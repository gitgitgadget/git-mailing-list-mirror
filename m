Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4496E20984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759154AbcIMXmu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:42:50 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37099 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbcIMXmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:42:49 -0400
Received: by mail-it0-f52.google.com with SMTP id 186so204878itf.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 16:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BepzSfJ8NODrIBlgdiML2TYO3EgX1mVHEVEFBrO2pSU=;
        b=IV+IkcdC51hvReosDP9cU+8MfyWWouKoIM3KNd42hmtuVQ2JTZ+W3rHcnieVuTYkoD
         ga0J45phNz0wGP/QPxbSIbFjzgmE78MDbXiV8S8RJaswmTLWA/KX0wjvLCS0E2oW+84f
         gsLgjqhMtFwG1Oi8zQ3pzFHALrAW5zg4UPwtzi6sewP4VZpPw1Fg45zeHVCYUhLsObVE
         ECLndPtP2dSkqafST0sQTWdJN1zUFT9NMUa2CibDFlUDAQe1PUlQbCV4P4z2KKMz01aV
         xNDLVstxvzo7LFUJIAOoqMGCqHdtGtGQOoF1JG4JeePTG9/EevB4LTwAYd2QyjOdfcMT
         i5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BepzSfJ8NODrIBlgdiML2TYO3EgX1mVHEVEFBrO2pSU=;
        b=DbkLOp6n3o70ULD7welbjOmK67x+1Z/UrKwGOGIFWpIvA+Ixp3kwlkG2+0QUtW1p1I
         Qam9PdVskBCohBFmDC4SINrLcDgvDdm0eGUdolBlfqvARBTKLKJBjhSpU1Vyhhxdu1kd
         Zv0yb27X+SaV75suRU4wcKwwbN227Ok+UPBFYdDVMtJbHTQhzmysOVDl7Dk3reP2jgIe
         5bRoWduIl7d+takJTvO8xrnuto7ibV0s8wOugQjfgtEgwHLVaTrf4Eob1CCNgsKvDZ5y
         /Bn6JkpyFNMZSWqSNqo7HCUtuSFk74XdED+1EDUFQkITNdr1Xd9AT5fCds6UoDnWEpVL
         kLSg==
X-Gm-Message-State: AE9vXwOv5zYCoCkt8U5I1ALGixOf2wyXZN8xkMmavMV6El69JfBXp/2u8wlehlg6CUcZxGyNgoWnyCQsCF1fTc2C
X-Received: by 10.107.170.168 with SMTP id g40mr130251ioj.173.1473810168297;
 Tue, 13 Sep 2016 16:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 16:42:47 -0700 (PDT)
In-Reply-To: <xmqq60pztlz2.fsf@gitster.mtv.corp.google.com>
References: <20160913044613.1037-1-sbeller@google.com> <20160913044613.1037-17-sbeller@google.com>
 <xmqqlgyvtn6l.fsf@gitster.mtv.corp.google.com> <CAGZ79kb4Rm=AT-hFutXW5jhZRL0ThDFr789=AbxKC-o+jQ341g@mail.gmail.com>
 <xmqq60pztlz2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 16:42:47 -0700
Message-ID: <CAGZ79kaFofpU0TMd1ZcJa9UrzdFytg9UjqqtPf8WPXe0zjWihA@mail.gmail.com>
Subject: Re: [RFC/PATCH 16/17] diff: buffer output in emit_line_0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So would we rather want to keep the ecbdata around for each file pair and
>> just reference that? I thought we deliberately want to avoid ecbdata, so maybe
>> we rather want to have another struct that keeps path related information
>> around (pointer to the blob and white space information).
>
> I would expect that there would be two structs, one per path
> "struct buffered_patch" that has the per-path thing, and another per
> line "struct buffered_patch_line" that describes what each line is,
> and has a pointer to the former.
>

Heh, I was trying to come up with a clever thing to save that pointer,
as we would need to have that pointer once per line, so in large patches
that would save a bit of space, but probably I should not try to be too
smart about it.

So I'd split up the struct line_emission into the two proposed
buffered_patch_line as well as buffered_patch.

However the naming is a bit off than I would expect. Historically you
had one patch per file, so it was natural to name a change of multiple
files a "patchset" (c.f. a commit in Gerrit is called "patchset"/revision)

Today as Git is quite successful, one "patch" is easily understood
as the equivalent of one patch, i.e. what format-patch produced.

So I'd prefer to go with buffer_filepair and buffer_line maybe?
