Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD75ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 05:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiH2F5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 01:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiH2F4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 01:56:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB64BD10
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 22:56:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q3so3730832pjg.3
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc;
        bh=c0tVDzA46oCPn4PAAUVh6CZiImQXd8F5HDBRvwZdIR4=;
        b=lj3ENhTMA9Ipb49pIQTVolB+MFPy4wYtHsIu9uVDJ+4nRMiRdbLnSnSkvN9lxDTiM7
         TDgur6so5aM24y42R0nl3LwS8FSkP+9RephAMNtGJsBxH/oBx5sBHq+nz8bNcSOAMvTV
         RLnVxRS4iX3xwrWtpi0OG40i3n8sqYIBUBdjW4IDhE3bKn1lz1MqqngbLWqHFVWz+Spj
         neP1aWF5lwjkdkTyvmfkH90pQ6olkHpbJdQMkf85TgYUkCCSjMgudqk66xcgSXBzoeMe
         +IHOqvTXyzso07q5RP2BPe7wGe6f7BL+/V6cVdSYVceTeXfVIv4Lg08eAQsPaaL7h3LH
         8CWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=c0tVDzA46oCPn4PAAUVh6CZiImQXd8F5HDBRvwZdIR4=;
        b=MTgNfI2DPFOsetE+J7WdblMVQnMn3qEnW2VX1wn4ditk2vwbbsYHudHM11Vua0WYHA
         0JU7o+zTE/zv4mN0PesD4dPjLeaPAsURRL9+sHKBcp4z84eUE/bXQr05O0Iz57VhCsS4
         2T+PQ8PvRFtFMgvQSqE4fLJKt/+lAyuQXKdmR4uTyLD0Pf7+z7z1tQ8nlrWag5HEBxix
         hLZmS+Gla5OldTpvVxVJtrjqSqap5WtPl+GB0vzXHU4PwkU84JSVr4+1/i6xY5/mfg/P
         9jO0mmj3gJlqZHdWMuT8DXWFXm4QSiNCqqzEUbCLrw4rKs+EK23mPQOEz6zRzoYfhvi8
         2pMg==
X-Gm-Message-State: ACgBeo3dFcsyndqxqfQiVobGQD0mVnmGuI84gBKpIPXtXtw9Jceaeslb
        zkelllJJDYHYRcgUhjXD11g=
X-Google-Smtp-Source: AA6agR52MlJbtTKeAs5ddbostisUFWNAjH9guOJlRgZs+bq2QhPw3UDt2UTVEQFQL+0i3nONEpij8Q==
X-Received: by 2002:a17:90b:2545:b0:1fd:92d6:62da with SMTP id nw5-20020a17090b254500b001fd92d662damr9687069pjb.239.1661752584229;
        Sun, 28 Aug 2022 22:56:24 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b0016d2db82962sm6491037plh.16.2022.08.28.22.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 22:56:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
        <xmqqwnax438x.fsf@gitster.g>
        <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
        <xmqqfshl3pbp.fsf@gitster.g>
        <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
        <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
        <xmqqczcnymtd.fsf@gitster.g>
        <YwoVAYTk0EKsAiut@coredump.intra.peff.net>
Date:   Sun, 28 Aug 2022 22:56:23 -0700
Message-ID: <xmqqy1v7r3so.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If it were a matter of choosing one static analysis over another (unused
> parameters versus coccinelle), we might have something tricky to decide.
> But Ævar's non-parenthesized suggestion is a practical workaround.

OK.  Let's go that route, then.

Thanks.

