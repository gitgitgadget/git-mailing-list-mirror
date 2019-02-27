Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4EF20248
	for <e@80x24.org>; Wed, 27 Feb 2019 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfB0Mg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 07:36:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38092 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbfB0Mg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 07:36:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so5425835wmh.3
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=05GhkPQHS1JjpFlTrUOEUbNGv0BbxCnwlORSZMRVCWc=;
        b=fm14Kn96BTi6LjhFazzrb9SmSnTBoMotpruZdA1iuGxvIWrIA6IK0TOZj7bKhwKHZG
         Ya33POqpyCDNG6+SpB62MIH5Q5hpoCf//6/YYmwBvppUFBoFatddwQYVayQfe5J7NXlI
         jAI3r3eE9kCJy4ioXyjRUFdBufObZUkIhpEnGEsTE+r0TCLNuNV2QLk6WueqdTe9y5Wm
         xbemhkmIN5qhSfX23DwXAo59K52aVrtSWe6f7SRMAd2d8eye27sgO/qT5w5vUS0wkV40
         6q6piqUeyTQ2mFQ6mlRBSHyoDaVIbWsJcm6/oI9nc/NwbD1B4mztK8a4t/hTuSMx1M/K
         /0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=05GhkPQHS1JjpFlTrUOEUbNGv0BbxCnwlORSZMRVCWc=;
        b=NKcVm9AE9minyyaAB9e/SU69HENps1rSplJJ5QVPkmyTqwHH9M8ul9sf8iPTRzV6CP
         TCgv9NOHHicKT/rVIAitJY5GLVlJH0x6+L5A0sjk1OtYoNCtQgyBYN0jOSkDqJNgWTS8
         gmuoyVo/V00Dr1rtO+GxtSSyV8oczpczjq+uc1Qei1kTMDpL8zAWMtezkcKSNrJNuT1O
         F2ykl6rtI0MsNDVj845rJHT/QWMv+Kn0hyAgzitJIeeAeNalRKb7DfTfNwKJpceTUcAW
         1jspzhiZdcpDEWLldJGhgpLMpvtdr3al3IOWo4mNjbMi45oQjw2EhlMVSKM+X4PKo/dP
         jYsw==
X-Gm-Message-State: AHQUAuYnrxmpAsS6lSLsY5t5pOWMZtDzjA94MoV9KIT/swerYVy4yenB
        Tu6qHyb9/0v3Lv3/MDxZIp0Ys3Tu
X-Google-Smtp-Source: AHgI3IaAwx84Nk2bjM5xgSKvD2oz9o8frpKrhbQGmC8ihZvPSJW3OCohuPVaft+V466STCu6AkymlA==
X-Received: by 2002:a05:600c:21d9:: with SMTP id x25mr2253811wmj.136.1551271013777;
        Wed, 27 Feb 2019 04:36:53 -0800 (PST)
Received: from szeder.dev (x4db6969d.dyn.telefonica.de. [77.182.150.157])
        by smtp.gmail.com with ESMTPSA id u13sm3654583wmf.3.2019.02.27.04.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 04:36:52 -0800 (PST)
Date:   Wed, 27 Feb 2019 13:36:50 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
Message-ID: <20190227123650.GG19739@szeder.dev>
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com>
 <20190227113711.GF19739@szeder.dev>
 <CACsJy8AcrRBtEUFtFVDUbDZDodDDMAHxnwsf55zH+TzKCoyVMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8AcrRBtEUFtFVDUbDZDodDDMAHxnwsf55zH+TzKCoyVMw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 06:49:53PM +0700, Duy Nguyen wrote:
> On Wed, Feb 27, 2019 at 6:37 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Wed, Feb 27, 2019 at 06:07:42PM +0700, Duy Nguyen wrote:
> > > > It was discovered that the --no-gpg-sign option was documented
> > > > but not implemented in 55ca3f99, and the existing implementation
> > >
> > > Most people refer to a commit with this format
> > >
> > > 55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-13)
> >
> > No, most often we use
> >
> >   55ca3f99ae (commit-tree: add and document --no-gpg-sign, 2013-12-13)
> >
> > i.e. with a comma instead of a dash between subject and short date;
> > and without quotes around the subject.
> >
> > Truly sorry for nitpicking :)
> 
> Naah it's about time I update my ~/.gitconfig to be "conformant" :D I
> think we both failed to mention where to find the command for Brandon
> though: search commit-reference in SubmittingPatches.

Well, yes...  but I didn't mention that on purpose: SubmittingPatches
advocates for quotes around the subject, which is still the less often
used format of the two, and there is no good reason for those quotes
(that 'deadbeef (' before and ', 2019-12-34)' after the subject
provide plenty of separation and indicate quite clearly what's going
on).

However, looking at the length of the suggested command in
SubmittingPatches made me remember that I've been using a couple of
patches implementing 'git log --format=reference' for a couple of
years now...  I wonder whether it would be worth having something like
that in git.git, and thus making it conveniently available for other
projects as well.

