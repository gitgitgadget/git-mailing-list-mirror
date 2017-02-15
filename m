Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADC02013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbdBOWw6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:52:58 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37469 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752922AbdBOWw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:52:56 -0500
Received: by mail-it0-f51.google.com with SMTP id x75so5589375itb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sB/MOceFvD3xfdVIPdWO0O5TjdFjxaFF7QCqvzByKcs=;
        b=AN0xCvta/jsM6gFu5O4YoOdEwBa3SL4XvMTRCe9fNLAFRW6pm8SpXT5pjbzroF0MkF
         Q51gGJrvg/vJHtu+vL9Q4WAjuP0TmpEyRPyt8VTuCzYNnZInDcGTyjwwZJ/Nz5YndU+V
         gU0DZorZC/CNa/NFOeVsyRelE+Inpd5agmGhhXZZ5LdA4eICrAWoJk7f0vs6bwYmW2Rz
         r3GbDnLiCFLjv9ZKbXiLobZcpWcPhiFkwejg4WGipwcvuPGsj5AlOPCWAjaweFcHoUvw
         4snl2LO4p7Vl1q/imbZT3R1gPdDvtG3ejmNMuA6Dli51+FuLoOvm4INGGFPvXFlSThwW
         u4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sB/MOceFvD3xfdVIPdWO0O5TjdFjxaFF7QCqvzByKcs=;
        b=tGS2MuHITNp0zIvcdQ1EUf0o4KZuRC+4Cr6UcKnaSbaMZc20uqlZ5IxhLuFO+bDdTF
         +HONmpn6/ZXfwdwO19Rgr67yc6LqgkE6W0BVyF0pgIL/FjbTaNaXP7BVtn/ruawb1DTd
         Go3hCh/z0Zn7JzBW1kKvmq2pfKJE1kf/Ah3B7lqCQWO4F9HU0hUbtX3d4qld+lOcCLEN
         sQx6ufUPGvclzo4oGcwV8N+Z6lA7nbnA8LFFp0bozu/c8YVUTRIQK3wpwUkLQjQr2pOg
         mrcSXCZIAWn7iyAUue5UK+5wCqU94ygnfZiVsP0C7+5rSk48t2Cesmu6G/879eqGfNz9
         Q+cQ==
X-Gm-Message-State: AMke39nhXQwUDu015bEKcYxqsPrR6kCEmexyWkHFOWD4DsA5IVFXuG7WSP52AnFYdcSLEFLLKChEL0QbXeBUsnUn
X-Received: by 10.107.16.14 with SMTP id y14mr32806122ioi.164.1487199170617;
 Wed, 15 Feb 2017 14:52:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 14:52:50 -0800 (PST)
In-Reply-To: <xmqqh93v48mv.fsf@gitster.mtv.corp.google.com>
References: <20170215003423.20245-1-sbeller@google.com> <20170215003423.20245-5-sbeller@google.com>
 <xmqqh93v48mv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 14:52:50 -0800
Message-ID: <CAGZ79kaX1URNvzp8QuFEFnJDzSW9nE971+nvhPLOQQx4aSyBkA@mail.gmail.com>
Subject: Re: [PATCH 04/14] connect_work_tree_and_git_dir: safely create
 leading directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 10:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In a later patch we'll use connect_work_tree_and_git_dir when the
>> directory for the gitlink file doesn't exist yet. Safely create
>> the directory first.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Among the existing two callers, the "absorb" logic in submodule.c
> has safe-create-leading-directory (SCLD) immediately before the call
> to this function, which can now be lost with this change.  The other
> one in cmd_mv() has the target directory as the result of moving the
> original directory, and I do not think there is any corresponding
> call that can be lost from there after this change, but it is not an
> error to call SCLD on a path that already exists, so all is OK.
>
> Is it sensible to let the code continue with just an fprintf() (not
> even warning() or error()) when SCLD fails?

I'll move the code from the absorbing here (i.e. lose the
SCLD lines there) and make it a die(_(..)) instead of fprintf here.

Thanks,
Stefan
