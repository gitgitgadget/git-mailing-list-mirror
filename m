Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EFC1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbdHIRUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:20:45 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32998 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbdHIRUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:20:41 -0400
Received: by mail-pg0-f53.google.com with SMTP id u5so30630588pgn.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvP24RlDZG3yfiGoVIgzJjEM0bwLVq5E+Wi+UStxOFs=;
        b=ckJqMV8nTkqPAiaxQVY0gnhO4R6oPj/I5tMmbMVRHAn35BTmwpSiDyQOtZVbJuAPyR
         XihTfPzUpJa9lLVNyfgS86KVPxf9TV21F1GlN0fdRXnXl6nZPSJ/Eub6FbEkBMdxO4g0
         0pRDf43v4eUHgY+gGdRFTzRGuByeR6wJigvmhKX7H3q4+67A57f2ClHfXvvhIciMeVlv
         axZ8/RqZe4HIcgAKdJWsezbDcOiAluGsdkaKEBSrh9KJQXBJ9F5/mtoM01ZZ3r7i+mOE
         u77wPG91f6FKe2nJR8TZV4mi0GiBBWzXknwlHTP7sDfVqzH90JvVBR9BoItoKa41oKTK
         9Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvP24RlDZG3yfiGoVIgzJjEM0bwLVq5E+Wi+UStxOFs=;
        b=QrOLYAsEM0jjqLwhSKMpoGdnoNyML9/eY91Jn8bVmSu5owq2dGEzU4ojkQvk9zO7ZY
         0m7roj57KyiDc1g7RgOs79PaKm0yoAcHhatgHJhzdvg6/rEonptoElIHkpURe2tmRjo+
         X+HqzQfHjhDvz2KQNmGCb0xCkJLushj9lrz4MeLmvKNm/0o97vld8oq8+4azIwLDCJFO
         DRlQc4oSuTZcLcwVsCYXO1l/JuuRBxXk9H3CYCQejHI+lqk57aLS5WI2+7ZnExhxahRU
         sihBpntniCZTE+X7Ta8T90AvMw2vwzF5gFrEiWmA3KFDS0mGt8mFo7sIJXUdGCz+5Egk
         hzWA==
X-Gm-Message-State: AHYfb5jFIu+JSRDtCofMSw1sixCFez8pKy2vXVmz7gBTJ7UMTzFIYPuU
        FXfuXCkfWScmjsyU
X-Received: by 10.84.217.140 with SMTP id p12mr9658498pli.323.1502299240686;
        Wed, 09 Aug 2017 10:20:40 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:2958:5ad1:cb09:f54c])
        by smtp.gmail.com with ESMTPSA id e123sm7752934pfa.96.2017.08.09.10.20.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Aug 2017 10:20:40 -0700 (PDT)
Date:   Wed, 9 Aug 2017 10:16:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
Message-ID: <20170809101646.4bc67606@twelve2.svl.corp.google.com>
In-Reply-To: <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
        <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
        <20170808135001.48f2440e@twelve2.svl.corp.google.com>
        <CAP8UFD20_Q7djbJfMmrGEnN3j2NasHyvuNAfZHMr_bNRjO0qpw@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Aug 2017 14:00:40 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> On Tue, Aug 8, 2017 at 10:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > On Tue, 8 Aug 2017 13:36:24 -0700
> > Stefan Beller <sbeller@google.com> wrote:
> >>
> >> There are also packed refs, so one could (like I did) think that
> >> pack.c is for generic packing of things, maybe packfile.c
> >> would be more clear?
> >
> > Good point. I'll use packfile.c and packfile.h in the next version.
> 
> It looks like you used "packfile.c" and "pack.h" in v2. Is there a
> reason why it's not using "packfile.h"?

Ah, I forgot to mention this in the cover letter. I thought that one
header was sufficient to cover all pack-related things, so if we wanted
to know which files used pack-related things, we would only need to
search for one string instead of two. Also, the division between
"pack.h" and the hypothetical "packfile.h" was not so clear to me.
