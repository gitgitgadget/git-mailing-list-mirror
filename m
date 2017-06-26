Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04588207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdFZRbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:31:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33143 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdFZRbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:31:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so950168pgb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BQW1Zkrlg0sfXOnbelf0wmt7i7i55dxupwhBKnVNJm4=;
        b=JAXk4VmKLAq+zvribOWHxAEdkQsZ1vKGJrjmWZ0bouvSEA2CPi3BtufEfnjTNLuCUm
         WG78SnaABgsqoHkJxdXQCnkQ2As60A8CmFu2MbnfzEVc+2dRwca5ssOsJAWhMFnSyIf8
         TmB/kW/0OMbFc6QmnElbwV+cjlR/SQrPpPhn5MYUz5nNwWIMTz7y66Ykx0mvie/vtzvk
         Jomz/7LdiXpsgdU2M7/Morrva9vMhbKM220a+uFmrqVgAFLJUWxqC/gL2ljelDaVa9pV
         u2L/CgMvwOSRtgjxZwFOxMxBq2Rj9YiSIqKasO0ufGiFQZsavvS8B39N6Kh0TNNYynUP
         YU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BQW1Zkrlg0sfXOnbelf0wmt7i7i55dxupwhBKnVNJm4=;
        b=umh7RqSjEJhrsXemrgjAOn7aX6Ed4JIrf2bp7HsQthmJ3qn0I1IzzGQo5xgMdy8+Dv
         ZO+tMvyxCIo5wSveDaU1ZXIUwwHEIO8igvAP0t+KNFNSWUAiTG7hS09cmEH8e+WIHTrB
         rDaNYEsT26o2g/5LIlepYj+efRye/GBenZGk/HROWCxiKqlbxAur87Ei0233oJ2ku6Hk
         5JHe87uYoevYnGM2726Y9FQdFiY2LUc+2cglAQFmNF4EuNY1M9zgm18DU+QGo9RSvL9u
         L8VfZ4zoMxRNq80+445kXfHdDEr8sY2YjdTnhRbeOW7j6bX4+aVgCyM52W2kcvgH4XWU
         lH0A==
X-Gm-Message-State: AKS2vOyWI6kDUR1KZF6LbwO0LjcgGe+N2rpr/AqQrW294O8ke1kCYqYW
        dQuwtSS5KW6Y7Q==
X-Received: by 10.84.160.226 with SMTP id v31mr1265793plg.91.1498498305170;
        Mon, 26 Jun 2017 10:31:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id r28sm1514507pfd.4.2017.06.26.10.31.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 10:31:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>,
        peartben@gmail.com
Subject: Re: [PATCH v6 1/6] t0021: keep filter log files on comparison
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-2-larsxschneider@gmail.com>
        <xmqqtw337m4b.fsf@gitster.mtv.corp.google.com>
        <79C07E47-251D-4869-8EEA-11A9E336ABF3@gmail.com>
Date:   Mon, 26 Jun 2017 10:31:43 -0700
In-Reply-To: <79C07E47-251D-4869-8EEA-11A9E336ABF3@gmail.com> (Lars
        Schneider's message of "Mon, 26 Jun 2017 11:02:06 +0200")
Message-ID: <xmqqvani64g0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> It would become a problem _if_ we want future users of this helper
>> to reuse the same expect (or actual) multiple times and start from
>> an unmodified one.  There may be some other reason why you do not
>> want the comparison to smudge these files.  Please state what that
>> reason is before saying "fix this".
>
> Understood. How about this?
>
>     The filter log files are modified on comparison. That might be 
>     unexpected by the caller. It would be even undesirable if the caller 
>     wants to reuse the original log files.
>
>     Address these issues by using temp files for modifications. This is 
>     useful for the subsequent patch 'convert: add "status=delayed" to 
>     filter process protocol'.

The updated one is much more understandable.  Thanks.

> If this is OK, then do you want me to resend the series or can you fix it
> in place?

In general, I am OK running "rebase -i" to polish the log message
unless there are other changes to the patches planned.

