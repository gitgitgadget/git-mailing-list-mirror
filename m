Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7DB1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 00:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbdL1Auo (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 19:50:44 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40628 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdL1Aun (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 19:50:43 -0500
Received: by mail-wr0-f176.google.com with SMTP id p17so14276401wre.7
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkS0iruP9dz3Kt+z+s8bTB07GC/aRgrwuCMe28wFtvk=;
        b=ITj/m2/0aPsja6kIihzW6GJq50AY/FNYPZSLeVJd7ClB+kqjcNXsndz7UCkO5a26Us
         IJDehK5YQP6lx5dRR12E6IRf0I8olxxWej0na/wil4UjIVCKtq2UCtDm6gobN6KSTNNR
         upkxCGMS1bRmkE7kpmBAyaTjxz4sM2Xg2a5mCHqpObxLN+/FhgUrBuugAMnZl5p+wYVq
         0HJuARpRBm9+MzmO532Zzu0ISLXP9pNvimEq6JMKNj21CTFm1ByvEgSw91NODzKuACsU
         OpSiodHYcEEpYomx131xQ+s3HGVRrW0hJNCGNLi12i+r3Rbo8ktCVQ6m00VG6nlX8GmN
         BOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkS0iruP9dz3Kt+z+s8bTB07GC/aRgrwuCMe28wFtvk=;
        b=cUyFIiE4nsSEcLeyG9+XqVgFc4YBkqDOuhqSXI3KT71/l628V/X2WWB8wYwEiMCmT3
         ZM4COuOUfKwUrknYI7BvI2zYBCKX80zY4uB/kkvyGp+oUqlFkbg/9rPSDJfW9kRhm1YB
         IQBiDGctgP0d4HYFaUk7NSkTWsTjJ2IqdBtqa8kF1gtvhZqZRGJZnoYa3muPS635aHH2
         5XHEuZbaHzNRd2tn3gUdBPW67m1OWSQ8ddzZhqcZ4bxLXQNcPCIvqU6ODxXrAZnv4pcz
         3IXmJqeYi0Z6xmjjm9GGHcvR7ar4hqL9kWFebfNk9fAX5ydvO6IxbIpsmziFC42HAUmy
         Qqxw==
X-Gm-Message-State: AKGB3mKocNbID7LslUYbDUgoRHrM5f7BHukMm2nIsjMzggQxsdAfnW1G
        ygaqKAT8jwclD2ZlEllq9XxtQMOP
X-Google-Smtp-Source: ACJfBoudl5uRXdy4eY5LdNpdSNAC1yGSgCF+FVOzvEzmzU7ghShfPuANMufTl2kkhcnQGZV1udlO0Q==
X-Received: by 10.223.139.199 with SMTP id w7mr31219459wra.282.1514422242162;
        Wed, 27 Dec 2017 16:50:42 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id u33sm47789316wrf.42.2017.12.27.16.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2017 16:50:41 -0800 (PST)
Subject: Re: [PATCH v2 6/7] wt-status.c: handle worktree renames
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alex Vandiver <alexmv@dropbox.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-7-pclouds@gmail.com>
 <d0f2055c-e0c4-32af-6371-53d0e9a5fbc5@gmail.com>
 <CACsJy8Dn_XKA8=iLRZpj2EKYOSZqHT0jw9o_HzPH_vncGGeCCQ@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <fb29d5bf-daae-fa8b-b787-e536cd5f98c8@gmail.com>
Date:   Thu, 28 Dec 2017 01:50:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Dn_XKA8=iLRZpj2EKYOSZqHT0jw9o_HzPH_vncGGeCCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/12/2017 02:06, Duy Nguyen wrote:
> 
> >   ... <path><sep><origPath>
> >
> >   <path>     The pathname. In a renamed/copied entry, this
> >              is the path in the index and in the working tree.
> 
> Gaah.. as you may see in the other mail when I quoted this
> (incorrectly). I must have modified this file at some point and
> thought it was true (my version did not have "and in the worktree").

Ah, this explains a lot... :) I got really confused with your v2, it 
felt as the series took a strange turn, and in a kind of a subtle way :P

> The "and" is still problematic if you take this very seriously
> (because in this case index name and worktree name are different) but
> I think it's ok to ignore that "and" and switch it to "or".

Yes, I agree, and the change does feel like a good thing. But, I also 
now hope this doesn`t break any expectations, because... (read below)

> >   <origPath> The pathname in the commit at HEAD. This is only
> >              present in a renamed/copied entry, and tells
> >              where the renamed/copied contents came from.
> >
> > If I`m reading this correctly, it should be vice-versa - value from
> > HEAD, being "original-file", should come last, where value from
> > working tree ("new-file") should be first.

... it totally slipped me that documentation is/was pretty strict 
about <origPath> being HEAD path (exclusively), where I was still 
expecting it to show renamed working tree "from" value as <origPath> 
in case of working tree (double) rename, too - where that exact 
(already renamed in index) path wasn`t to be found inside HEAD at 
all, so the working tree rename couldn`t really be shown as "source" 
and "target" rename pair, strictly following the "porcelain v2" 
specification... :/

I see now that your initial reply[1] was talking about this, but I 
didn`t focus on it much as you replied to it yourself shortly 
afterwards, and later v2 of the series came up.

Might be this is where you changed your offline documentation 
version, too, as that is what the sample patch was about :)

> Yeah I think the "where the renamed/copied contents came from" clears
> up my confusion in this format. Back to v1 it is!

I see you addressed this by loosening the restriction here a bit, too,
making <origPath> be "pathname in the commit at HEAD _or in the index_",
in your "[PATCH v3 6/6] wt-status.c: handle worktree renames"[2].

I repeat that this looks like the correct approach, making fully 
described working tree rename detection possible in porcelain in the 
first place, but also aligning output of "status" --porcelain 
variants with its default (--long) form.

Hopefully, on top of everything positive, it also doesn`t break 
anything (too much?)... :P Latest revision should now provide all the 
necessary ingredients to resolve what happened, for the (small?) 
price of tweaking previous expectations a bit.

Regards, Buga

[1] https://public-inbox.org/git/CACsJy8A=jZ9LAuM50GVjNT5gtdiYYMyMuPBSrJFO4LmKVQsETQ@mail.gmail.com/T/#mf2f5ae672ec6f4e1abecbd5fe65283e9d8fbed57
[2] https://public-inbox.org/git/20171227101839.26427-7-pclouds@gmail.com/T/#u
