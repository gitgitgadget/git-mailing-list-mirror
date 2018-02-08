Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A5A1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 23:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBHXV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 18:21:28 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35586 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeBHXV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 18:21:28 -0500
Received: by mail-wr0-f193.google.com with SMTP id w50so6446448wrc.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 15:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fU7a6y+teXg0u6+HErqRxLpz/P0kLj+1PG43gNCd84s=;
        b=h4kdwREy111VbKeW9W7IGpwVIg7/2C2gjhM8mbnMRKE+pR4+RIFkGZWb3Wp021zkjH
         kdhhFiDSN+RFpV17ROVIML5i8hECxtp278X27b76pLNszl6YKXxgBKrjuNFvLJGqviws
         +7peBU0nT5KzYKY+iqBqs06Z28Rbhy2G8gpwyS6+BdoXxRjZ4UfinWfQRvSAR5FtoE24
         aFIxnnjBKNP3Ye+tfJAIv8GAAQaKCQS301+SNDBjriKkKN6hFzUlQzu50kYbFFnLl/xM
         TuWhvfiyVoYosTrR8gMkYBqOvTKF4ji/Gx43IBe/czycL728vftRrY0ErrbIN8fAFx3P
         a2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fU7a6y+teXg0u6+HErqRxLpz/P0kLj+1PG43gNCd84s=;
        b=gPTWzer7bGthvkstn56+Or61kC9CIQKWuawupEuP4il6TN8VIaBQ5NOtwDPR/yKe/p
         w44Y4nPUvaO40Lnatzkp/OYde7Z4/CnkfRdDBSCTWHWKJX23r/tPHUOQJEzDFNUMpP7M
         dkT+slQD2yNgnD/DbWnjPyd4F694FRAogaY0sEcxmAVShx2cpIdr3/6txeIvBAvo99nZ
         WfE10awyETbwD+0HhP8U2Ou2B5XCqbnHdRXl6Nqql0eMPgr/J3gHbqSGdHeHrntBSOg6
         ygdthusd8Bt9WvH1jZShy70V8vPJFrii4RLkwCum8MwFRe3p4Fvj8xkXFaUCFtslK6Va
         jgUQ==
X-Gm-Message-State: APf1xPCoSoyEyok8ycY8auGvDFJsLQdEKBT4zCkEmgrgSMvBvnc3j4es
        AzMykS+x4t97QKF99dcn+S8=
X-Google-Smtp-Source: AH8x225mf3UT1WOHzqSM8LtIDcTpjhqcB3lXhjspzMIHZk65pmTHnCb17vJEGdtDDAm+yASa3hO9qQ==
X-Received: by 10.223.209.71 with SMTP id b7mr614091wri.141.1518132086509;
        Thu, 08 Feb 2018 15:21:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y90sm1529147wrc.24.2018.02.08.15.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 15:21:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 03/14] commit-graph: create git-commit-graph builtin
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-4-git-send-email-dstolee@microsoft.com>
        <xmqqzi4jp3y5.fsf@gitster-ct.c.googlers.com>
        <9c473af6-fc67-5612-07dd-54b2a6e24ff0@gmail.com>
Date:   Thu, 08 Feb 2018 15:21:24 -0800
In-Reply-To: <9c473af6-fc67-5612-07dd-54b2a6e24ff0@gmail.com> (Derrick
        Stolee's message of "Thu, 8 Feb 2018 16:36:20 -0500")
Message-ID: <xmqq4lmr6paj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I wanted to have the smallest footprint as possible in the objects
> directory, and the .git/objects directory currently only holds
> folders.

When we cull stale files from pack directory, we rely on the related
files to share pack-<hash>.* pattern.  It is better not to contaminate
the directory with unrelated cruft.

As this is purely optional auxiliary information used for optimization,
perhaps .git/objects/info is a better place?  I dunno.

In any case, even if its default position ends up in .git/objects/pack/,
if this thing conceptually does not have any ties with packs
(i.e. it is not a corruption if the graph file also described
topologies including loose objects, and it is not a corruption if
the graph file did not cover objects in all packs), then the end
user visible option name shouldn't say "--pack-dir".  "--graph-dir"
that defaults to .git/objects/pack/ might be acceptable but it still
feels wrong.


