Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BFDECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiJ0RkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiJ0RkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:40:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DEB481C6
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:40:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l6so2293639pjj.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BT9NfUqDnd2fyQFDxyarpYxgFNxqiMzk0LqwhMTOSiE=;
        b=ALmbsqkOeFVK8jmlhxFw3Zc8gg0BPj46SiEoaxSC/q3UOWlAhfu6ZzZ5/CCB9AWPv8
         PNWxMWSsTcyaKBeCHip5cevGp9Knlph1VN5G04BshKJ/1fpBWu0qxEe7oe8fY33x991V
         SLYry/uNCbgB17XCLbv2upfcrAlz+lppjZYo68kwNBZ7gu5a7Ivd/V9VOjEVI11it3OE
         6CDMyJjTUuJkfCR9Vy7Apn2dGG5GC9aF4P+HheIFbaAQqrUGjxYJguz42HCvEY8k7owE
         HD8nIsEmKAxy/MKVhD1+Ion/qq6ZJ5vshuN9pIzpJBT5gsyQTA1GZp1VtzZCE3frDRNc
         xoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BT9NfUqDnd2fyQFDxyarpYxgFNxqiMzk0LqwhMTOSiE=;
        b=1rVfZKvyYZuFEakZQOy980zsjEFU6/wqauSENAd8sQVbKBtZhn08GQCn5JPJk3YyGU
         DKS35YveXxq2lpts4n2tPlkjaLH/Z0QgEvjC5lRvnOegceaVO6oeDAQ8ha8H8rqig1bX
         QHHKxRZTPsWyPcaEhGPheN/VKHpHwGAj5LbFVlcf4FKfb6ebk2emP8EpHOLeqI6bo9Gv
         +yGb0oSyqClLqD9H5ehP9aBFlgf5oFJQWfFjl+ZRuoaXzB4miNQC6Rg4PjgQVlngpHZx
         HRxqwVCFwOryT/jxDb4EwzH5nOzSTEHH8E+CgRxj64gWMW3EH5+ydA9GvERx03bMdC/+
         LF9g==
X-Gm-Message-State: ACrzQf1pO71H6eav/wVFWEI2ToiZ3anYNi3WHIq2FszhdPEDnuA0iYfR
        UwlKvyLVLHfMB6ZPRj4/qkI=
X-Google-Smtp-Source: AMsMyM6yWiKSydePfFOJ8T6EfTzZjABEQL0A0F+BE+ed3SFUvPLEfVc2/oi+E6NsL/5HlMCa09skVA==
X-Received: by 2002:a17:90b:1b0b:b0:20d:7c31:e75d with SMTP id nu11-20020a17090b1b0b00b0020d7c31e75dmr11030002pjb.101.1666892414328;
        Thu, 27 Oct 2022 10:40:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a394b00b0020d45a155d9sm2897694pjf.35.2022.10.27.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 10:40:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Mention that password could be a personal access token.
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
Date:   Thu, 27 Oct 2022 10:40:13 -0700
In-Reply-To: <pull.1396.git.1666845947898.gitgitgadget@gmail.com> (M. Hickford
        via GitGitGadget's message of "Thu, 27 Oct 2022 04:45:47 +0000")
Message-ID: <xmqqk04lmagy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  `password`::
>  
> -	The credential's password, if we are asking it to be stored.
> +	The credential's password, if we are asking it to be stored. If the
> +	host is a software forge, this could also be a personal access
> +	token or OAuth access token.

Is this limited to software forge hosts?

Also, I wonder if the specific "it can be access token and not
password" is something worth adding.  If there were a service styled
after the good-old "anonymous ftp", it would expect the constant
string 'anonymous' as the "username", and would expect to see your
identity (e.g. 'mirth.hickford@gmail.com') as the "password".  The
point is that it does not matter what it is called on the end-user's
side, be it a password or access token or whatever.  It is what the
other end that provides the service wants to see after you claimed
who you are by providing "username", usually (but not necessarily)
in order to prove your claim.

So, I dunno.


