Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7DC2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12191207E0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h40AZxmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfL2RZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:25:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34679 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfL2RZd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 12:25:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so10210625wme.1
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X12MilUFkps88Rp0rVQ8d7nqCvJI+bOx6Ax6fhsUL7s=;
        b=h40AZxmGtjHjysNAgEfQdo/kqkhHXH0kZ/ijWURHgYTDwDsbeF99nF/u5ueMgNxIaI
         i5gDzAt38XZVJgJP6b0KYj+yzWpJSMBfbsXoMG2O4MzWvsvuUZ98YbMNo0mjecTRi5rA
         N4Tb71HhhevCqbAU3NsbKF4HAOVyW1RUI9NfDbmxTPzmaj9PlVCHuaQqZEG+1hKgjAmC
         RxCC8edg9i+goQ3p6l180foFLiZcZ0fSNiMIVh9IMkpkYj3L/1SEAm+l8LhtbCx34fwG
         1SSmY3sKKK4agtJ0TVN3v5IJx/V6MB8lpHxcvXd9WsF6ndjZceARSWyjzZuWg05t7jJt
         ABsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X12MilUFkps88Rp0rVQ8d7nqCvJI+bOx6Ax6fhsUL7s=;
        b=FEKayClwEdkBplyVRqHWOU1wd3UW+Q/s+lBZBTJFTTZIFpNYCm661W30NHkhgp5Ke/
         qYnK1gVIAV9YTgKzSPT2KHhjgYiVsgeDYskcfKAByxIneOUfjho0nfstIUdi22IFWkX9
         Cni6uBzQf7ceCtsmdwZ1F+Q8s9yThsEF+vNy+J5C45iZ+EUz5LYR3CS6XjvwwvNoYy21
         9rwmD1m8y1m5vjIAnAzt1/TN366RuGUjPemzpR6pQQjoPhZ4xLMz8JlQ3tPHVAxVaivV
         kwaBctOMkg8xR2oeXqtv/C2Cr5xypkx9ehfndKrD5oN3HufZHSHwFX5IvyNclEwpOjZB
         TiZg==
X-Gm-Message-State: APjAAAUmXmUzU9+4HSoz5+l6ATteEo1HLXNL1WPgCgg4YCy47sbdxKgt
        YUOQyfSNVr9KNbT4JsQNO/M7pF63
X-Google-Smtp-Source: APXvYqx0Uc6FbvylKGvJhMwemW6kYuOgT9804TUzHpXEXfMhQkvlLrjPWumW3dLIKj4lg+ZnD0Q8gA==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr28540849wme.73.1577640330664;
        Sun, 29 Dec 2019 09:25:30 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-10-13.w86-222.abo.wanadoo.fr. [86.222.153.13])
        by smtp.gmail.com with ESMTPSA id b10sm43971115wrt.90.2019.12.29.09.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 09:25:29 -0800 (PST)
Subject: Re: ERANGE strikes again on my Windows build; RFH
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
 <20191229142909.7bmjbrroboitvnzq@tb-raspi4>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <a32e075b-9e6c-2b6a-8619-0330501eee97@gmail.com>
Date:   Sun, 29 Dec 2019 18:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191229142909.7bmjbrroboitvnzq@tb-raspi4>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 29/12/2019 à 15:29, Torsten Bögershausen a écrit :
> On Sat, Dec 28, 2019 at 04:41:42PM +0100, Johannes Sixt wrote:
>> In sha1-file.c:read_object_file_extended() we have the following pattern:
>>
>> 	errno = 0;
>> 	data = read_object(r, repl, type, size);
>> 	if (data)
>> 		return data;
>>
>> 	if (errno && errno != ENOENT)
>> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>>
>> That is, it is expected that read_object() does not change the value of
>> errno in the non-error case. I find it intriguing that we expect a quite
>> large call graph that is behind read_object() to behave this way.
>>
>> What if a subordinate callee starts doing
>>
>> 	if (some_syscall(...) < 0) {
>> 		if (errno == EEXIST) {
>> 			/* never mind, that's OK */
>> 			...
>> 		}
>> 	}
>>
>> Would it be required to reset errno to its previous value in this
>> failure-is-not-an-error case?
>>
>> The problem in my Windows build is that one of these subordinate
>> syscalls is vsnprintf() (as part of a strbuf_add variant, I presume),
>> and it fails with ERANGE when the buffer is too short. Do I have to
>> modify the vsnprintf emulation to restore errno?
> 
> If you ask me: I think so, yes.
> At least the documentation about vsnprintf does not mention that errno is touched at all.
> That is the man pages for Linux and Mac OS, or see here:
> https://linux.die.net/man/3/vsnprintf
> 
> It would make sense to analyze the complete callstack, I think.
> Is your problem reproducable ?
> 
> Changing the function strbuf_vaddf() strbuf.c seems to be straight forward to me.
> 

According to the standard, vsnprintf() _can_ change errno[1] (and the
BSDs do so[2][3][4].)  But apparently, not to ERANGE.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/vfprintf.html
[2]
https://www.freebsd.org/cgi/man.cgi?query=vsnprintf&manpath=FreeBSD+12.1-RELEASE
[3] https://www.freebsd.org/cgi/man.cgi?query=vsnprintf&manpath=NetBSD+8.1
[4] https://man.openbsd.org/vsnprintf

Cheers,
Alban

