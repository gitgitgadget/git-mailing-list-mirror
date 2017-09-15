Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8509C20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdIOVyQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:54:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35043 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIOVyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:54:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id i23so1779519pfi.2
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWNF1vu0uEGPnedkHxeBVYGxsTm4htytguu54LyPgP0=;
        b=nXM+lIH+qdb1knS+MobaBSJkxCAmDmGi1NN6VZlriNELi+vGl4JTFCQW25pqnAYIJS
         anuEOVgbOu6wbfBK07XOW/tVssJeQJTdAQ7tnbm9Yrqxn9KY2Ryp6rXNsZTqYS+3PnbU
         CmBmaQPLv5E3NpthZE7gG4HV7g672EdQahe0apUwyCiRYBlRsIQTSjBHcsB3cPXV0lg7
         EraUGAEmrzYhAbvn73au55chhDGWqtJJkAUK9YT1HMlK/I3pu/hl4V0+m9zuOwKya7PP
         1I/BGyM3AhklrAS0q+ugT4o8YJ7Go4BdGJVlDXHMGejIMV4+G2WihNSlNEIkXT6eisD4
         pouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWNF1vu0uEGPnedkHxeBVYGxsTm4htytguu54LyPgP0=;
        b=RBg1Fm1yx4d4T2JCJHJrQFh7sy+220Rl41tnIGqfQsLTGNqnz9Q3uEtX4KDW4zHwGf
         KoPODHgWpkOpNBWHCveMEJDKdS1JPcxV7VqB0nm2DobDEw35FdN0YhFsHNFRoH6c6l+c
         jkoAZTxOGOxpNPlSYJ6zKKc47O5nzQIV+tRF4pyUrdIdwWlAL46W7f2fCQmxcRBKnyPd
         H8SHjx0aWreq62mHyMrKkqQidV5m74REc1RnsgVHfPUozDvriaVTNrSl5i/Fix1K7BAR
         u6K3OfixCg05x7vldTIbu66Y9M3fXa1rYSukIi6i8opMcVSr/gNUNbBJC5DugKQUUrFa
         0PGA==
X-Gm-Message-State: AHPjjUgjaw82b1Gp0TljMhl99yZObUyd5t5Y5WrdNrSLVd0XSPXiRcnt
        BuxDa0CLVc3VxAif4tA=
X-Google-Smtp-Source: ADKCNb5G64wdyotMjTIgp/8y5Wu1D2umUQK8et1KhFFDqXsc9g3FfmGw82fT7ydXixXDH9ZUl31m2w==
X-Received: by 10.99.43.4 with SMTP id r4mr25093159pgr.380.1505512455292;
        Fri, 15 Sep 2017 14:54:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:40d3:83c7:2f82:80ea])
        by smtp.gmail.com with ESMTPSA id q28sm4063646pfj.77.2017.09.15.14.54.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 14:54:14 -0700 (PDT)
Date:   Fri, 15 Sep 2017 14:54:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jason Merrill <jason@redhat.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>, aldyh@redhat.com
Subject: Re: [PATCH v2] git-svn: Fix svn.pushmergeinfo handling of svn+ssh
 usernames.
Message-ID: <20170915215413.GW27425@aiede.mtv.corp.google.com>
References: <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
 <20170915214653.14720-1-jason@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915214653.14720-1-jason@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Merrill wrote:

> Previously, svn dcommit of a merge with svn.pushmergeinfo set would
> get error messages like "merge parent <X> for <Y> is on branch
> svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
> svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>
> So, let's call remove_username (as we do for svn info) before comparing
> rooturl to branchurl.
>
> Signed-off-by: Jason Merrill <jason@redhat.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  git-svn.perl | 1 +
>  1 file changed, 1 insertion(+)

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

though it does need a test --- I have no confidence that this fix will
be preserved without one.  Anyway, that can happen in a separate
patch.

Thanks for your work,
Jonathan
