Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB3C001B2
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 10:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbiLNKo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 05:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiLNKo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 05:44:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2971A23BC0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:44:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt4so6507853pjb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 02:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z/kem8wUOK23d+rUk3PzbQZYOVJQDTrlGZaXpQuuuwA=;
        b=WtFcz2w/I8TfdBJehW8wmwFj9BAdF7CAkaxZ39baoUKD9l/UCuqcMIlr9K8QqeqmtG
         g/Dgv7SNHERur3/ztuEc+LmTl8dWBqCXPPIaDuPBqAqF5VIimGwvtzcjp/f/lzo4d6ZQ
         yMPbMgB3BZ4t58MpkPt5FxBTtNoIEP54s79gtAe1qN9nMIiMF225R0N5Z4nSxhDuCh/d
         XZ/EeSCAX2GzGb/0wRmmqZAmd+SgiBWRbZL6uG+H/Ycedeg6VO/A73zSIdGYkt1Ghfnl
         mLrDfkxEfhw1gVCC/fRBZuEnCk5JZbiaTTqEzGJZC9owS32BvnRIFuxja2Tcdfa7nUrJ
         gP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/kem8wUOK23d+rUk3PzbQZYOVJQDTrlGZaXpQuuuwA=;
        b=3ePa7AyAC4zkhy9KmMTopmh6BEb7DDDa2ZWPxwFinLSAS/AkR7yNAnckvU6Z2Y9+Li
         h6R9sC+Q6mbW1oIEv9mr3MTUkWDJa0IWxBqnaPNljbxZsV7x9CeOuabkgt/AJyHX8SXx
         XI0eCUOq5nM3rWbuRiahPjZMKjG2eRK1gNJY1PUsx//xLtsolS8145lTbr+7gm4kxE3n
         VmyOHi0jOh1Ib4WLcdKYkZtlDTZSdV0v7i9QtnCZHXNhdYVFZBYg7c6MZ0rXK7UvhDhw
         qRxoOd8iD+lSqPwEgFbgi9bkRiZVxgpMOJDGbP/A7fwNtYpYnkOpBt2r1U2g9tNcQC9l
         xbJg==
X-Gm-Message-State: ANoB5plKwb0DGVH2UU78/anXjSenYQMl9Lrjc5B7d/pfy8BMAFsQ3wPY
        ubJkYU2+7HyeFJgvFU0B6jPKWn9krNz48A==
X-Google-Smtp-Source: AA0mqf4++KzHzmAivPHhel3Yv2lNwAiNLwsfRv5ly25khRRu6ee//XnAvfCBZ0vr3lEd4YVT07b3Ww==
X-Received: by 2002:a17:902:ab0b:b0:189:5f5c:da1e with SMTP id ik11-20020a170902ab0b00b001895f5cda1emr24139689plb.27.1671014664253;
        Wed, 14 Dec 2022 02:44:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0017f592a7eccsm1507009plc.298.2022.12.14.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 02:44:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
References: <xmqqiliewbje.fsf@gitster.g>
Date:   Wed, 14 Dec 2022 19:44:23 +0900
In-Reply-To: <xmqqiliewbje.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        14 Dec 2022 18:59:49 +0900")
Message-ID: <xmqq7cyuw9h4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In the past, I tried to re-examine all the topics in 'next' myself
> to pick and choose the ones to be kept before rewinding and
> rebuilding 'next' after each release, which took me a while.  This
> time, to share the burden to expedite the process, I'll reset 'next'
> to 'master' without any topics merged, and rely on input from list
> participants.
>
> The topics that used to be in 'next' are all marked as "Will merge
> back to 'next'", but people can tell me to give them a chance to
> reboot their topics, instead of piling "oops, that was wrong" fixes
> on top, while I wait for such an input for the coming days.

What is involved in "re-examine to pick and choose the ones to be
kept" was to go to the original thread (which should not be too
hard, as Taylor has maintained the "source:" line in the report well
during my absense) see general consensus and the reason behind the
consensus back then still applies today.  So another way people can
help the process is to say something like "After re-reading the
https://lore.kernel.org/git/$THIS thread, and particularly reading
$THAT message from $TRUSTWORTHY_REVIEWER, what the $TOPIC wants to
do and how it does it are both sensible."

No self promotion, though ;-)
