Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38D61F404
	for <e@80x24.org>; Tue,  6 Mar 2018 01:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeCFBXf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 20:23:35 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36500 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCFBXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 20:23:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id 188so19079137wme.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 17:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=slavbTWtoY2U2TACwBUG98IhKYpgL2pGNW9bP79za0U=;
        b=YEEuSf7wTq/SV7YcKvHEiOL4q2QYaxG1DUZFJ1jIfMoqJfPOlbIh3fjaZT6eNVmubX
         0Rd69Q3tT4/k2A/iA6KBoxrVAuzuyQwx27fu+dNZH48z12KSGf1K2Wi3e9IjvRoY7FF3
         uSGKOBccnUUUag5Up7a6wuYoJ0fhN8nI0tYFcaGdfu9t0ztHnc9YVjJbpBDPAmYWqTDu
         epJONcc/Y50ekMsD2tGvx7XxTjcCjAfncNEGEBYNvK5RE47ZhIQcYm1TzqRI5LdNp1mo
         d0lTFUIHDtk94tC4rXwHpCXrhdgdzSiBTW/56ur3uMn1Alhwmg3kTXFKfswgPZ2U2OaU
         +xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=slavbTWtoY2U2TACwBUG98IhKYpgL2pGNW9bP79za0U=;
        b=ttghMLkhEJMkE7gAJxf/ynHKhuE7JVOuGxZCr6mW0mDHF6mZ6CyHodeJ6bjHiIUKVh
         zoXSMs4tz1qgfPH1jkfpmNp0IC/gbK45cGyCkibXOi6Disl9nEq4Z6t7O9ASdDc+nFS1
         RlqUBtIZqIvg38TrAUNRz3v+v2EB3sQ3baXoGTvTXYz41XDBaqG4jNojU9Y/3lJ6bf7V
         mBXelmOKkZbloPwphEr/BjPe4PhMXEswnGFnPaUXs4BKfSzdqlSmjdnTcqEd1Nht7w68
         a7BYQgX2KMhdmQMJDh83lM+yYvWiY7Nruekc3vsz723JVKMoBPQhVVyLtvifjn8T/aBz
         kLzA==
X-Gm-Message-State: AElRT7EY/d33S//iKvhUTqbmPTYVxJRCSHITMoIdjZteKmm81Rz2eJAs
        6UFwAKDlLYH4MPSotNTyw4Q=
X-Google-Smtp-Source: AG47ELtjY36gAN/Q5SYEcAjVzvr8q41NqEuIVLa6Te6nt+QSFYH+1a5sFOG172m1kUS5KZRivyq8xg==
X-Received: by 10.28.8.201 with SMTP id 192mr9668719wmi.47.1520299413501;
        Mon, 05 Mar 2018 17:23:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w31sm15311492wrc.49.2018.03.05.17.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 17:23:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-7-lars.schneider@autodesk.com>
        <xmqqfu5e8a53.fsf@gitster-ct.c.googlers.com>
        <55633B6F-EB6E-42D6-8E58-79158A99774A@gmail.com>
Date:   Mon, 05 Mar 2018 17:23:32 -0800
In-Reply-To: <55633B6F-EB6E-42D6-8E58-79158A99774A@gmail.com> (Lars
        Schneider's message of "Tue, 6 Mar 2018 00:45:02 +0100")
Message-ID: <xmqqvaea6lpn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 05 Mar 2018, at 22:50, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> lars.schneider@autodesk.com writes:
>> 
>>> +static int validate_encoding(const char *path, const char *enc,
>>> +		      const char *data, size_t len, int die_on_error)
>>> +{
>>> +	if (!memcmp("UTF-", enc, 4)) {
>> 
>> Does the caller already know that enc is sufficiently long that
>> using memcmp is safe?
>
> No :-(
>
> Would you be willing to squash that in?
>
>     if (strlen(enc) > 4 && !memcmp("UTF-", enc, 4)) {
>
> I deliberately used "> 4" as plain "UTF-" is not even valid.

I'd rather not.  The code does not have to even look at 6th and
later bytes in the enc[] even if it wanted to reject "UTF-" followed
by nothing, but use of strlen() forces it to look at everything.

Stepping back, shouldn't

	if (starts_with(enc, "UTF-") 

be sufficient?  If you really care about the case where "UTF-" alone
comes here, you could write

	if (starts_with(enc, "UTF-") && enc[4])

but I do not think "&& enc[4]" is even needed.  The functions called
from this block would not consider "UTF-" alone as something valid
anyway, so with that "&& enf[4]" we would be piling more code only
for invalid/rare case.
