Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2797A202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 17:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdGFRDy (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 13:03:54 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34804 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdGFRDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 13:03:52 -0400
Received: by mail-pg0-f54.google.com with SMTP id t186so3914315pgb.1
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MXDok89871I6fvaOHj4nT+jQ/lFE7dn10cmfQ4DBmy8=;
        b=qIYRyB/BSeRnb2zY4B8HTkVaNAw5mEal+F1LN5R7HErikuU2+Cp+lVLw+DzCCOC90O
         /aOSB3QgI02Qabm4PWWZgl/uyhKuhy+sh1ucz70LsSVUNgDl9+QjHggDLOvrC41KSp/w
         CcSnfZeHDvuV1eSighJpY45iUbPd+A8FHVQEQe7ET+yoHG5SNE/FO0mGzf5Ig5Uw+/G0
         hhVq3aSjB9+oD312QM+LuwKiNw4PkSdQ8rYWL5i6O/wVufekkhEWH7pQUfu+fn/xo9vB
         EB1+DD5Ck6y6P4rL2WsDEa0zgv+Hr8WO6jcT1teTgRQdY/Y8yuDyejI83vL/84UxYQLz
         R4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MXDok89871I6fvaOHj4nT+jQ/lFE7dn10cmfQ4DBmy8=;
        b=AhzsRJXFbKpqOJsl4KH2m3Imu2ikN/RdVs8zywZgEZ1Bn22FWRCyqS+L0TH1M5xY3z
         iMow0DRNdh6s+vPg8yHoctIhaG+2bAxdlrL5uwIU0D5oO8OYTaswLVrMi4CbPamW3Ap5
         Xz3RujhUTKqq4f3cbiFpVZsi4Kxcf/3SVrnKQomvPjkkzCAftA4A6zm2UHBxujJjUgM6
         Dac51QY2OemZTVADiN584POAEw/q5I2awxSBJHLyopSdkk082ryQfd6AhpL5+RqR4A5B
         46Xmlt36mQwAIMTuOVhhDK5paZS1OSihD1GyeySTmMgJEIY2b9HvNBiMQ8naqbGZbvXn
         nxMg==
X-Gm-Message-State: AIVw110Yc2e8bFTJ3VAUXplF4TrTEwIOq1bcmP4JYzeYJlOdah8xvuPY
        tul5oZkpYu7btnmYtSc=
X-Received: by 10.84.210.106 with SMTP id z97mr29794405plh.6.1499360631957;
        Thu, 06 Jul 2017 10:03:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id a4sm1303646pfc.22.2017.07.06.10.03.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 10:03:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: name-rev: anchor pattern without --exclude?
References: <87k23ltsl6.fsf@kyleam.com>
Date:   Thu, 06 Jul 2017 10:03:49 -0700
In-Reply-To: <87k23ltsl6.fsf@kyleam.com> (Kyle Meyer's message of "Thu, 06 Jul
        2017 12:53:25 -0400")
Message-ID: <xmqqfue9fqfe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> [*] A bit more information on why I'm trying to do this: In Magit, we
>     have a work-in-progress feature that takes "snapshots" of changes
>     before they are committed.  These snapshots are stored as
>     "refs/wip/{wtree,index}/<full refname>".
>
>     We want to use name-rev to map a commit to a name in "refs/heads/",
>     ignoring these snapshot refs.

What is the <full refname> in the above supposed to represent?  When
a user sees two refs "refs/wip/{wtree,index}/<full refname>", does
it mean: "These two represent a snapshot for changes while the user
was working on this branch"?

Isn't name-rev a wrong tool to find that information?  What is the
answer desired by your application when two or more branches point
at the same commit you are interested in?  Pick one at random?  An
error saying it cannot decide where to place the snapshot?

I am wondering if you are looking for "symbolic-ref HEAD".

