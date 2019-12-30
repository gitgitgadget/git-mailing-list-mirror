Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED1C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72F3206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrx3Mrzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfL3Uba (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:31:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35669 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3Uba (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 15:31:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so33676614wro.2
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aurQ+0Rjo39EvS3Lr9KML0BgMNpfiT6uPc2n4KtUoBQ=;
        b=Xrx3Mrzgpbl7CHpz5tZMa3OokBbc9jaioBVUFbe0OOSbumvPmntYSMAYa57sYnkMSs
         CEqgULAfrQbPbmV3scgecZTem8wINSeKmBt+HfgxAmfGiBYWg7KhTeb/JzTfZUG1p6Ju
         AQdoRe3LmetQ/ka0l0futDCwGq17VSF+AvAkHi00OuDv0lVbmEPRNDO1XOzON578ygHI
         Caz/FU+reylfCnxNOd1A4cZDhJtA9uPbE57vc/bf8si/R9XSWhtdgF084TYIzQzUB7UE
         Fn1kD1IrSQRL2IpLGLesrLqTYecj1obk5iDFT1e/36pNZRRWQ3cgYIjCzN2mkqULimnk
         XH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aurQ+0Rjo39EvS3Lr9KML0BgMNpfiT6uPc2n4KtUoBQ=;
        b=nNIH42uGFQO7GsO30C73v3CwTo6eOiUH5IRY4IwsJW47hxvnYUP/OAannER8t9bhIJ
         a1AQeFGfCML1duS2i1dQecXGwEOfhHPaWjrKDWCrEg+B+Hlh2V3jtxC40D6YH7nvEUn2
         wA3gm7fM4TuXaBBAXYQ5xzYt7yhGtqMQ/x/Bgrb97ecLKUnojGiH+Z0KASYD8s8b0Not
         8PHsgR1upHafYwwAeu7CAeZgBmXko1amlgB3yw07bShzO89aLrefaaC0mc2UTTtsM5Js
         8IQE5HD7LonrSk3uPNUKmBWOBrXS3uzEpZnOa9qddW6/vTparSkKB8pd5UgVCvUbWBco
         dCAA==
X-Gm-Message-State: APjAAAXXjhGR/yo6gYb7lEPlXN1P4Ah+DUDnpSiofxtX95LNV/IWlM8e
        CoyaPlZlnd9DGJgLy8+U351cuz4e
X-Google-Smtp-Source: APXvYqwoIlnfiOQYMY5i3zvp+IcKPzv3IFvnBkNNnd2SsjdM86LWpG8a3yACv/YFA4qpCwrO2e0wWg==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr69542025wrr.286.1577737888168;
        Mon, 30 Dec 2019 12:31:28 -0800 (PST)
Received: from [192.168.0.108] ([188.173.146.22])
        by smtp.gmail.com with ESMTPSA id k16sm48871594wru.0.2019.12.30.12.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 12:31:27 -0800 (PST)
Subject: Re: Re: [PATCH v3 1/1] git-gui: allow opening currently selected file
 in default app
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <pull.499.v2.git.1577647930.gitgitgadget@gmail.com>
 <pull.499.v3.git.1577721419.gitgitgadget@gmail.com>
 <1b2363be726c6d70746aec9fae62edaf857cd665.1577721419.git.gitgitgadget@gmail.com>
 <20191230194129.kjmp6r5xuwmq4wum@yadavpratyush.com>
From:   =?UTF-8?Q?Zoli_Szab=c3=b3?= <zoli.szabo@gmail.com>
Message-ID: <2fac0090-8db7-885a-9b1b-0017db7ce91b@gmail.com>
Date:   Mon, 30 Dec 2019 22:31:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230194129.kjmp6r5xuwmq4wum@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2019.12.30 21:41, Pratyush Yadav wrote:
> Hi Zoli,
> 
> On 30/12/19 03:56PM, Zoli Szabó via GitGitGadget wrote:
>> From: =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>
>>
>> Many times there's the need to quickly open a source file (the one you're
>> looking at in Git GUI) in the predefined text editor / IDE. Of course,
>> the file can be searched for in your preferred file manager or directly
>> in the text editor, but having the option to directly open the current
>> file from Git GUI would be just faster. This change enables just that by:
>>   - clicking the diff header path (which is now highlighted as a hyperlink)
>>   - or diff header path context menu -> Open;
> 
> Semi-colon left in by mistake?
> 

Yes, that should have been a simple period (.), signaling the end of the 
sentence.


>> +	eval exec $explorer [list [file nativename $full_file_path]] &
> 
> IIUC, this line can be simplified to:
> 
>    exec $explorer [file nativename $full_file_path] &
> 
> It works fine for me including on files with spaces in their names, but
> a test on Windows would be appreciated just to rule out any hidden
> surprises.

You're right. It can be simplified like you have proposed. Tested it and 
works correctly also on Windows. (Since I have copied that line from the 
existing `do_explore` proc, the same simplification can be done there 
too. (I did not realize this myself, since I am just learning some TCL 
in order to have this feature in Git GUI...))

> 
> No need to send a re-roll just for these two small things. I have
> updated the commit locally before pushing the new version out [0]. The
> rest of the patch looks good. Will merge. Thanks.
>  
> [0] https://github.com/prati0100/git-gui/tree/zs/open-current-file
> 

Thank you very much for your support!

All the best,
Zoli
