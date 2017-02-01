Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603B21F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbdBAWLV (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:11:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34230 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdBAWLU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:11:20 -0500
Received: by mail-pg0-f65.google.com with SMTP id 3so17582498pgj.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 14:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jLCuqQymKSeDJVWeEcusMIYReZn7Gs3DdYLIskhb9R0=;
        b=lMqb7ZFsemEt8vrJKFb7fBU/8UDgCAB6RXZxQbnRFuGKcKTt8Tscfctdj/o3kb9JyL
         H8HZzduI3mIwZ4XjsIKcgD1EXo6VUlR29mNPdoiY35QetdDc16DyVcByy52Y4tMJmDe0
         8XYnNBJQ/YymS6Yi8kVrbaaXLAOM31EjLz6C7mhcYqHhkDIW51EDnOSw3Vm17Jkc6ZMT
         EbLZrRHk6LYp+7+vp+wlGfCfIfADIkdk1ekZQQ6LAQhNUlcaQq3tb/H2aD9dZ8yx6wuR
         e7VuCA3NM8V2uujnSDV6JyGvNrnLiIjiQ/bokaZrVcGba2lrQ+2AmnOrZGJF0I6wqbkK
         XsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jLCuqQymKSeDJVWeEcusMIYReZn7Gs3DdYLIskhb9R0=;
        b=BL88aILf/EKamYsVwQycf48qDqSqvkTOn3xw/hIMwFNaSXanfvbdZO2JD4UC6bMwO3
         d6j6knmPqb376gAuPTBXw65hpc50TUnlez+m1ZoLT1IMpzgJXtn+UOIQrHaKcbpfppXE
         vnqcx8g5N6nU4ybQDUmQ2HrrnYaYHTWsxcY0Frik4+Hr9/3ng+ZOsePj+ZFkFnOWFdZ9
         cts3oOujWft1SlfWjX1FEtUcmNh55MludcMY76GljnKNxLhmb1d/elo6sakCkWtWK94i
         NEkivRxRSVeBnrqs+La9UNiNwpWXz2+qbv4dc9BiPXDxawmfKwURYgM4BWvi/GTxJA1c
         xdZA==
X-Gm-Message-State: AIkVDXK1sUG0vP4uXiKwhJQsrTqaunen+H5ITHT7ewTsz5Z34qgyaxQqNx4u5waCJT41xg==
X-Received: by 10.99.45.133 with SMTP id t127mr6596510pgt.224.1485987079787;
        Wed, 01 Feb 2017 14:11:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id n79sm52181218pfj.31.2017.02.01.14.11.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 14:11:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Gumbel\, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git commit results in many lstat()s
References: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
Date:   Wed, 01 Feb 2017 14:11:18 -0800
In-Reply-To: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
        (Matthew K. Gumbel's message of "Wed, 1 Feb 2017 21:45:25 +0000")
Message-ID: <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Gumbel, Matthew K" <matthew.k.gumbel@intel.com> writes:

> I do not understand why git commit must call lstat() on every file
> in the repository, even when I specify the name of the file I want
> to commit on the command line.

Assuming the "COPYING" and "README.md" files are already tracked:

    $ >COPYING
    $ >README.md
    $ git commit COPYING

would open an editor, in which you would see list of files under
"Changes to be committed", "Changes not staged for commit", etc.
Among the second class you would see README.md listed.

To figure out what paths are "changed", without having to open all
files and compare their contents with what is recorded in the commit
you are building on top of, we do lstat(2) to see if the timestamp
(and other information in the inode) of the files are the same since
you checked them out of HEAD.

    $ git commit --no-status COPYING

would reduce the number of lstat(2) somewhat, because the codepath
is told that it does not have to make the list to be shown in the
editor.  So would

    $ git commit -m "empty COPYING" COPYING

These two only halve the number of lstat(2), by taking advantage of
the fact that the list of "modified files" does not have to be
built.  There probably are other things that can be optimized.

