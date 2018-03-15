Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C601F404
	for <e@80x24.org>; Thu, 15 Mar 2018 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCOUjr (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 16:39:47 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54704 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeCOUjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 16:39:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id h76so12912139wme.4
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XJtKi3CU+rh7WKk/WlB5N4toOXkwxiZFrbClowmTHmI=;
        b=P6s/mzzY2ASfyhIikvVxli9wAgZIORZ1wfyuSoYOffpUTVrzzPR+6dNtTM1Oleu/mt
         q2jk/kVsKaQSV3eUm/nuWYMSNveHRGy8+ZOwDIqRiox/Xo/aJmkFryn6wQ3Xb1M5e0cQ
         NPd2EgrSIqcaB8WdvqdlOxHVzSdMHR+sjqa0jaN6/TUXyPr4qWDKoxYqxT+3joDmEgHf
         ef4Qr+xdGPtGtu62ti5nGttrx+U4HD2hMkLiXfLHsKDFCnfIVwElfCIx5GrPhGjMV5/T
         74osSSIPkpgmOF1CHfwL/57WkAEZJVV6dXGJBtdNFJ/qGaKBPsjyrzH8K4+GKkoWNDgK
         KYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XJtKi3CU+rh7WKk/WlB5N4toOXkwxiZFrbClowmTHmI=;
        b=cyQIzteY40EPyPvnFXeHy4JHdO4S24RR3UEARv5qoIb9vEO1MqY57cfINzswkXflB1
         g11LV/EIR1O+Mxz3GoXAKkxNsB66zuCiYK8dDitIHU2urIHZm5fORDEhyCtN4pMijSAW
         rMBZ5OFBQzcA3LavFqFw/znpKm5lDt2yk1RkyPi8zqvEB6prCCq1eThfdskiRTPe3+SD
         l57C/V53WznzkGGDHgM1rMQMOMKGaaMWNCAIwrnR1Iv/MzOqJUbRWFibQa3yypgVaBaV
         8kRBPMoK4Emd5MDvK74IkR54RT5sMtRsc4Cuga1uXYWmdr3crclRwGxjNYTpewvDW+y/
         9r4g==
X-Gm-Message-State: AElRT7H7ZMBGbxXVdeArK1R5G/e002d2AOeZItG1WiQL1DBEBB/6TMm0
        XW4PTJCVoFX1twnQ5kJtFrMWcprw
X-Google-Smtp-Source: AG47ELvtJw1ztgy3TYiqcw5o3g6MEUa/uUNPZ0/shju4Zvm3OUd8qv9pIfIf3QIltAvP4vAXepM4LQ==
X-Received: by 10.28.61.65 with SMTP id k62mr6266764wma.140.1521146384924;
        Thu, 15 Mar 2018 13:39:44 -0700 (PDT)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id m191sm5000779wma.21.2018.03.15.13.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 13:39:43 -0700 (PDT)
Subject: Re: [bug] git stash push {dir-pathspec} wipes untracked files
To:     Junio C Hamano <gitster@pobox.com>,
        Jake Stine <jake.stine@gmail.com>
Cc:     git@vger.kernel.org
References: <CABWk7R9xNDHJbbsMZbOyhcYXq-bD6Krvbw_mKDBJFALALS3AHA@mail.gmail.com>
 <xmqq1sgl703v.fsf@gitster-ct.c.googlers.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <780a67cd-7e94-f155-d04d-72799e2997fa@gmail.com>
Date:   Thu, 15 Mar 2018 21:39:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sgl703v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/2018 17:52, Junio C Hamano wrote:
> 
> > Hi, I ran into what I believe is a bug today.  I’m using primarily Git
> > for Windows 2.16.2 and also reproduced the behavior on Git for Windows
> > 2.15.1 and Git 2.14.1 on Ubuntu:
> >
> > Given any repository with at least one subdirectory:
> >
> > 1.       Create some untracked files in the subdir
> > 2.       Modify a tracked file in the subdir
> > 3.       Execute `git stash push subdir`
> > 4.       The untracked files will be removed, without warning.
> >
> > `git stash push` behaves as-expcted and does not touch untracked
> > files.  It’s only when a directory tree is specified as [pathspec]
> > that the problem occurs.
> 
> I wonder if this is the same as the topic on this thread.
> 
>   https://public-inbox.org/git/CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com/
> 
> What is curious is that the fix bba067d2 ("stash: don't delete
> untracked files that match pathspec", 2018-01-06) appeared first in
> 2.16.2, on which Windows 2.16.2 is supposed to be built upon.
> 
> > Here's the precise reproduction case executed on a linux box:
> 
> This does not reproduce for me with v2.16.2-17-g38e79b1fda (the tip
> of 'maint'); I do not have an  install of vanilla v2.16.2 handy, but
> I suspect v2.16.2 would work just fine, too.
> 
> > jake@jake-VirtualBox:~/woot$ git --version
> > git version 2.14.1
> > ...
> > The expected result is that when I do `ls subdir` the file
> > "untracked.txt" still exists.  Alternatively, git stash should warn me
> > before destroying my untracked files, and require I specify --force or
> > similar to invoke destructive behavior.

I can't seem to reproduce this on 2.16.2.windows.1, either:

+ git --version
git version 2.16.2.windows.1
+ git init woot
Initialized empty Git repository in /woot/.git/
+ cd woot
+ mkdir subdir
+ echo test
+ echo test
+ git add meh.txt subdir/meh2.txt
+ git commit '--message=stash bug testing'
[master (root-commit) afec47d] stash bug testing
 2 files changed, 2 insertions(+)
 create mode 100644 meh.txt
 create mode 100644 subdir/meh2.txt
+ git commit '--message=stash bug testing'
On branch master
nothing to commit, working tree clean
+ echo test
+ echo append
+ git stash push subdir
Saved working directory and index state WIP on master: afec47d stash bug testing
+ ls subdir
meh2.txt  untracked.txt

Regards, Buga
