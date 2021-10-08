Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A1C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 01:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760E961212
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 01:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhJHBQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhJHBQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 21:16:33 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3286C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 18:14:38 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id w14so7960471qkf.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g4SIZ004KvYEGk1I5ewoh5CR8heIvc9DwV8z7F05cAs=;
        b=kpfnzufGxjtd/3B6w4x3EtTQvwIfTGqrXa1bf0Zb6WkIDYBH6R9/UiTty8SDXUexbs
         ZCTKmyX10zl53kBfiKcfF1hOWdBu7cTQRgNBkR9vpK8odZmaUQ9UTKDoDlknc6TNl7D6
         Nw3gYmJN3xIZ6rre/6xfXcyEIsTBN0NetTiuKyyiF5kgyhpB3jwNDnluM4bA0jc3/++v
         O4ItEoj1eOwoqx9Pqo1YlE2R7O61B9NX/5DFB3XxBVd4WxOQ9rYcZTK0qxgY3CbhJst2
         P/T1eOriySNJcGoBWTn9KeP6NCXjLwoQxGgpjyD86T2zohIIaDfT3VuhljvM8+T280tg
         iY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4SIZ004KvYEGk1I5ewoh5CR8heIvc9DwV8z7F05cAs=;
        b=At1896wNZSenSuplwzaObV5NdWhLGnfIdrmd1JM7SYdkrXtIP7sBG0lAKehSQtz2DR
         XDQIczpMg8JpfXKooxTECY/dsMrHdbajc6iwsWBTG63WKgSb2ZsrpYrSEGd3rbrgrMkU
         LRy1oc7OX1mmuBq885Em5lldAC5k47+xyvIhvAwEYPNPsr5xEzDC5Tn2NR1zS2EXvmLg
         h+5P8NO5dhTaXQFf/WXoYbCUAYOqssRirDxRsM9zcFWgbCYT5b3/STahGI0iToFcJbQX
         L62eqm7Ubl9Nmo54cDC8+nM1fLKOdlRg7UIBj0RSDijRWYIOlUTRMTh8wUZ9jdH8jMmk
         bjHw==
X-Gm-Message-State: AOAM533kzhzD5cP3Gi+W6mdjXzSDEIaLlYjQQLpex3IOxhixfmNDpDiV
        ED5IfNZu/ux65FjTMxfaueamav/msPc=
X-Google-Smtp-Source: ABdhPJx/bcyBaEwIpShnf78P5W4NEVH4u39FEXeioNle1ZnjMWuC4NnPqhZNe7G8/9b2rW/Hw0+42Q==
X-Received: by 2002:a37:bf81:: with SMTP id p123mr528923qkf.439.1633655677697;
        Thu, 07 Oct 2021 18:14:37 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id d11sm1085885qtb.39.2021.10.07.18.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 18:14:37 -0700 (PDT)
Subject: Re: Git push subtree fail unknown revision or path possibly due to
 missing git-subtree-split commit
To:     Eddie Ridwan <eddie.ridwan@gmail.com>, git@vger.kernel.org
References: <CANcBuaZstymNMvbPX553kgr=FsrFFcDEivfiDPsPe3uyGLb78g@mail.gmail.com>
 <61ee8bec-1e6c-e3c7-2cef-7520f376c18c@gmail.com>
 <CANcBuabe3px0N=awsuBGxdHgU8ChGHJdG8PAPoMJGnG98ntjdA@mail.gmail.com>
 <CANcBuaZmRj3tZqprNwjJatJ87F0vUVDKDRm5+OnOk_z3wqvJYg@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <efdf8b7e-b568-cb13-eb07-346dc9ca4f49@gmail.com>
Date:   Thu, 7 Oct 2021 21:14:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANcBuaZmRj3tZqprNwjJatJ87F0vUVDKDRm5+OnOk_z3wqvJYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eddie

[we reply inline on this mailing list, see below :)]

Le 2021-10-07 à 02:00, Eddie Ridwan a écrit :
> Hi Philippe
> 
> Using the debug option (see attached file), I see that the git push
> subtree command is complaining that many commits are in the wrong
> order.
> 

Indeed, the attachment shows many messages like:

progress: 1/     131 (0) [0]
Processing commit: 1fbbdda4f0ef15794eeb4a343d3fb1bf17fbb853
   parents: c75f7cab156c91a1bf3b36658e1ac94dd1905bba
     incorrect order: c75f7cab156c91a1bf3b36658e1ac94dd1905bba


> Any idea how this could happen? And is there any way to recover from this?

I'm not a 'git subtree' user myself, so really don't know unfortunately.

> 
> Would it be best to just delete the subtree and start again?

You could do that. If you do want to debug further, I would suggest
searching the mailing list (see https://lore.kernel.org/git/_/text/help/)
for recent contributors to 'contrib/subtree' and CC-ing them. Maybe they
will be able to provide more insight here.

You also asked on Stack Overflow if you should try to delete the subtree
cache. I think this could be something to try (I would guess if it's called
a cache, it should be recreated). But again I'm not a 'git subtree' user.

> 
> Many thanks
> 
> Eddie Ridwan

Cheers,

Philippe.
