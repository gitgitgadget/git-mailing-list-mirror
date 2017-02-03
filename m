Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CAAE1F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbdBCS7r (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:59:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36440 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBCS7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:59:47 -0500
Received: by mail-pf0-f195.google.com with SMTP id 19so2089358pfo.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zRYUPPnPTYruQ2M8h9NxKpD8YUV3ATOcbWCJshNGNhQ=;
        b=ovgHWfUDdrH4hyoCUGKIXt7cqkyv+uaFRUj9gu8soKWegPcQ9pnb1DApc7TfsKesFZ
         fR2tKOmhSLuMIqQfWKWVfX9gPF7k6wh7zlLFBTd4baq5TkPSp/0oHn4x3lXm2tWPUthd
         i2FOdMzPr+0hywZwmFzSvrtlZ/GxKTKIdnnBV28kfdZzmYCf9QgAMlFsOKBvK9UKBg+z
         vCQYH39S1lxrL+hFKEU6cOxrtSdB9wlLe8VucA9KDRwb9CG7/R6DvPwAtmJ0RhsfsYGE
         c0MC7bfG8L2kOItCv3C8yLy6USChrmu0N4MaKaox0PsOTwC1//m5BSx8kODmY89VKO5B
         ZIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zRYUPPnPTYruQ2M8h9NxKpD8YUV3ATOcbWCJshNGNhQ=;
        b=uM5BB4HMwwvJsKGL9YN/P21RUUxaDgjJgUCIFkP/dYyZfNB8wcNk+pBWk+C6R7IwSm
         UbiZJZWpneFVowOkSNtAownZRbbzq/zBvAplYIGmKeuFAcYGBANQSvkgjuJbcwgFhlRG
         QlHrUyK+Ej6jwzb3H3+hxcuRxd+OTqvhF0gMH/kauRVnRa/OoiQc7RLC15aHaBI2jdVk
         njYCPxlbktiorMXUxHpTcVy/S3hvYMeeq5G2+QPfDIAIq9j0lyUjW0c3X8IyKJnBvj0a
         II8EUhkAt/tOf43+/papZOB+0qRtisg0MdSbO8wnOFppW23J2aTZGNr+yGBKDTouLXHp
         d74w==
X-Gm-Message-State: AIkVDXKKEPecoYIwwdvyD+5yxV/PhmpGUlIPKWDwV35UXGjVlNzoTYsJ0tTzexM6lRnW7A==
X-Received: by 10.98.97.68 with SMTP id v65mr19713479pfb.124.1486148386432;
        Fri, 03 Feb 2017 10:59:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id r21sm68881805pfd.95.2017.02.03.10.59.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 10:59:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] reset: add an example of how to split a commit into two
References: <20170203003038.22278-1-jacob.e.keller@intel.com>
        <CACsJy8B=OEdUbc3_Svci_whtk=-Bz-4BP4y-Xr_u3CU81dxvCA@mail.gmail.com>
Date:   Fri, 03 Feb 2017 10:59:45 -0800
In-Reply-To: <CACsJy8B=OEdUbc3_Svci_whtk=-Bz-4BP4y-Xr_u3CU81dxvCA@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 3 Feb 2017 16:05:48 +0700")
Message-ID: <xmqqlgtnf6ce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> +$ git reset -p HEAD^                        <1>
>
> For good practice, perhaps put "git diff --cached HEAD^" before "git commit".
>
> I tend to avoid "reset -p" and "checkout -p" though because sometimes
> it does not work. Not sure if it's just me, I think it may have
> something to do with splitting hunks. So I usually go with "reset
> HEAD^" then "add -p" and "commit -c HEAD@{1}" instead.

Perhaps I am superstitious, but I do that, too.  

Doing this that way, the users do not need to learn "reset -p" or
"checkout -p" and only need to know "add -p", and not having to
learn two extra things is a big plus.  On the other hand, it
requires the users to learn the reflog, but that knowledge extends
to the use outside of the -c option of "commit" command, so overall
I think it is a win.


>> +$ git commit --amend                        <2>
>> +$ git commit ...                            <3>
>> +------------
>> ++
>> +<1> This lets you interactively undo changes between HEAD^ and HEAD, so you can
>> +    select which parts to remove from the initial commit. The changes are
>> +    placed into the index, leaving the working tree untouched.
>> +<2> Now, you ammend the initial commit with the modifications that you just
>
> s/ammend/amend/
>
>> +    made in the index.
>> +<3> Finally, you can add and then commit the final original unmodified files
>> +    back as the second commit, enabling you to logically separate a commit
>> +    into a sequence of two commits instead.
