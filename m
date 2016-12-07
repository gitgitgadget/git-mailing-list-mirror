Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CBF1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbcLGW3y (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:29:54 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35443 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932362AbcLGW3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:29:53 -0500
Received: by mail-pg0-f49.google.com with SMTP id p66so166495228pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GfEfgGwf7hRD7TnCQCIT0+mF3AOvGdhCysIFolxG0B4=;
        b=Y+NAt4ac0seAmpKyyFPEgyJ0d02AysHgkqAfB9m/JTruDNsLcjMURr+6uobbmG5TFL
         XEs+z4ExtI2esy+pw1kIr3Oi4GJWykhCSmW42ZL29Q9pKGRcqTvSLpjfLFwiYYbg4lVz
         wJE3xTlx9twDBmtea24iM40C8t6jC1t0Ki7tcBQcs6k1oadUc1IS9CSCiZbYlozKmgSs
         VEVcgIhmAGY1Y5sYJF5w4Yh1f2GvuVs2tT4OgBc34ADet/JNmkswDL/ozniGX4PqbtPU
         aqNOd0GSRH2Lhp0XqVRtYMDoANwuMLHGG9Edv1pgltSk9MAzSF2Z9JUqaeW5iiL8jZne
         St2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfEfgGwf7hRD7TnCQCIT0+mF3AOvGdhCysIFolxG0B4=;
        b=UTusvjqZTgLAPhVrII4lWY8y/zn97359OYthWPBhnxBDBfWp4Wrgc8IOjzHeY/YUf2
         ceDSKH+lXd9oEchCwtONvTKm5VfqIZvGtc16kuz00BdK2fK/itpUsTI1TYpmlZu1X7g0
         4c3oYxB4eNQIcPsHN+slY9dmAKh/bWGVDSPkv577gdnSHLazoNN4pOLxfW3kFjZdP5Xf
         k2jkKuo55JvCrFNNOsuAKh1IIX3FWU99otgDw9y7LncEBHz5MhnX8v5axRR3ICw2KbZ/
         nPGoPoF7NuMmHlXx41/7Usaaeap4Xa+ZObNmQQtJ8WtnHzGYfLEHNMFwZKdItlBOX8A2
         bT/w==
X-Gm-Message-State: AKaTC03wnfCnGPgpw9lptC20saqs5VvT0gmBvQNunHWmbXp5W+FNVPCUSymphyUt8W+u+1nw
X-Received: by 10.99.246.83 with SMTP id u19mr124851136pgj.165.1481149769340;
        Wed, 07 Dec 2016 14:29:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id q145sm44883864pfq.22.2016.12.07.14.29.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:29:28 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:29:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161207222927.GB116201@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <7d968fd8-a92d-efd3-ce67-7de6049b6d56@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d968fd8-a92d-efd3-ce67-7de6049b6d56@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Johannes Sixt wrote:
> Am 07.12.2016 um 01:10 schrieb Brandon Williams:
> >This function should accept both absolute and relative paths, which
> >means it should probably accept "C:\My Files".  I wasn't thinking about
> >windows 100% of the time while writing this so I'm hoping that a windows
> >expert will point things like this out to me :).
> 
> ;)
> 
> With this patch, the test suite fails at the very first git init call:
> 
> D:\Src\mingw-git\t>sh t0000-basic.sh -v -i -x
> fatal: Invalid path '/:': No such file or directory
> error: cannot run git init -- have you built things yet?
> FATAL: Unexpected exit with code 1
> 
> I haven't dug further, yet.
> 
> -- Hannes
> 

Thanks for providing me with the error.  Instead of assuming root is "/"
I'll need to extract what root is from an absolute path.  Aside from
what root looks like, do most other path constructs behave similarly in
unix and windows? (like ".." and "." as examples)

Since I don't really have a windows machine to test things it might be
slightly difficult to get everything correct quickly but hopefully we can
get this working :)

-- 
Brandon Williams
