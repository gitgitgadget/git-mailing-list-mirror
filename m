Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27E31F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755401AbeFRT6Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:58:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34485 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeFRT6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:58:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so18118137wro.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LunQqe6AXL8bNngEy1J9fnshbOw6QDYguieiDhean10=;
        b=NyLo7Ty92X6hSriB+Q02bnfmh/T/Jhan/H7Gz21+3Wy2iJXRETkDLDL0Uj1K8WJx68
         DJGNAys/A1hxW1RsP8cYBzrXcHXmJ9SOma9C44vbxgL814QdywfHya9lEizvK707J5vd
         zG0XoNMM0TocZMce3PtFI05SIaOoAiu4cCP3z8dcvZz2wMDz23Ywaruow8fCMDbXptFe
         w/IzYgS0KOQGp+66XtwcsDc5Efsa6sMT1v+eLKnk8t35LUYiXiTK009/YPpRws/u5FHt
         9Y2jldRD+wcfAxnbSs0K8kuAxle38lWCpH3zoO2hiA0JvrLJFON46iTQIp3cC4DTzsCR
         gxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LunQqe6AXL8bNngEy1J9fnshbOw6QDYguieiDhean10=;
        b=ECOihEjUaC12QlAofPPUN1Q5pw0QOvwIbbS8Wy//Ct+8aJo60LjJT/GRUhse20N+b6
         Lu7n+jIZ17AZrT7sjtWltsYCL3Zxx9RFvqUNCFYejpsJR3BQCBvibF+u7TT84YMS39zi
         r9qACFamI9GCzp+iUWnwoIKDtMydqKLiFN93utdwZ858l3UhNbjsdEzoZB4MWFVD8gTi
         MFBR64EdS+O3uZvclluphUK2YA/leBwAWg1Z6rj04wscNbaC3D+wGDff8opu0UUQGfcA
         7SH3d3Q7LMTKYVh5WTJs0z2mzyVP35a0xUQ92m/7wnDHtB2L3bwu/hu5AV3PEhWd+3v2
         M5Hg==
X-Gm-Message-State: APt69E172aHD7x+jYL83+vdtrEFbfV0R4HPNTdcC/JeHqi96gZ0UbgX1
        MKg+wKIf7k8wfR2xJvDFq1M=
X-Google-Smtp-Source: ADUXVKKnpSqZdWpg0Xa6MNR6xOJBKe8w1NdJQ3NnuD4TdKzYCqDr4aU9AUvZF7cV5L7jWKqSXpfAtQ==
X-Received: by 2002:adf:b297:: with SMTP id g23-v6mr11145801wrd.218.1529351894438;
        Mon, 18 Jun 2018 12:58:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g129-v6sm8832228wmf.5.2018.06.18.12.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 12:58:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
References: <cover.1528233146.git.jonathantanmy@google.com>
        <cover.1528234587.git.jonathantanmy@google.com>
        <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
Date:   Mon, 18 Jun 2018 12:58:13 -0700
In-Reply-To: <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 5 Jun 2018 14:40:36 -0700")
Message-ID: <xmqq1sd3yii2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When performing tag following, in addition to using the server's
> "include-tag" capability to send tag objects (and emulating it if the
> server does not support that capability), "git fetch" relies upon the
> presence of refs/tags/* entries in the initial ref advertisement to
> locally create refs pointing to the aforementioned tag objects. When
> using protocol v2, refs/tags/* entries in the initial ref advertisement
> may be suppressed by a ref-prefix argument, leading to the tag object
> being downloaded, but the ref not being created.

I wonder if it is reasonable to define the protocol v2 semantics of
"include-tag" request a bit differently.

Unlike v0 protocol where the client iterates though the advertised
refs and see if objects at the tip of them, even if they weren't
what the client initially wanted to fetch, to find these unsolicited
followed tag objects, allow the server to say, "I've included some
objects you did not explicitly ask for, and here are the refs/tags/*
names you should place on them", somewhat similar to the way how the
ref-in-want thing would work (i.e. the client does not really ask
for just objects and decides what name to place on them---instead it
lets the server to make part of the decision).

Wouldn't that allow us not having to advertise the whole tags
namespace only to implement the tag following?
