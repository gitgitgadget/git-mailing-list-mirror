Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2DB1F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 02:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdB1C1x (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 21:27:53 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:45523 "EHLO
        homiemail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751690AbdB1C1x (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Feb 2017 21:27:53 -0500
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id A53FC5BE06B
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 18:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        bit-booster.com; bh=Oshx3zdDVUUduOaNl+TQWsgsDz4=; b=f6Ueset17Ey9
        BewNGZlwEkh+83ao7hTAEzG5KLKvNR2h6JEBjC+r1LNiQFTjfM3LYgJDIchDOLbs
        486hoUWev4LXhrp6n/btLreegbMHJYJCH4j1/Wut/hQHaskLybcqfPI4bIf5Sp1c
        OofmkNAWoQgHse5ybr2rDGX+h4Ggy2Q=
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 899AD5BE064
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 18:27:50 -0800 (PST)
Received: by mail-it0-f50.google.com with SMTP id 203so988733ith.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 18:27:50 -0800 (PST)
X-Gm-Message-State: AMke39mXKRso6rLiYRrIbaf8QZxqG7+Vnfq42OxEvQ64q5WERIOt6rMbXplsdwiUpJ0TvgkVz2ekwn4Dvja0lw==
X-Received: by 10.36.216.4 with SMTP id b4mr420814itg.100.1488248869992; Mon,
 27 Feb 2017 18:27:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.199 with HTTP; Mon, 27 Feb 2017 18:27:49 -0800 (PST)
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Mon, 27 Feb 2017 18:27:49 -0800
X-Gmail-Original-Message-ID: <CAAj3zPzwWr4u1qSMp5CwVMzExW2eg9LQ7t7RX-5m6fRRGh9pcA@mail.gmail.com>
Message-ID: <CAAj3zPzwWr4u1qSMp5CwVMzExW2eg9LQ7t7RX-5m6fRRGh9pcA@mail.gmail.com>
Subject: [RFC] - url-safe base64 commit-id's
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any appetite for base64'd commit-id's, using the url-safe
variant (e.g. RFC 4648 [1] with padding removed)?

And so this:
712bad335dfa9c410a83f9873614a19726acb3a8

Becomes this:
cSutM136nEEKg_mHNhShlyass6g


Under the hood things cannot change (e.g., ".git/objects/71/") because
file systems are not always case sensitive.

But for "git log" and "git show" output it would be nice. And helps
with ambiguous commit id's too if you only want to specify a 7
character commit-id, since that encodes 42 bits instead of 28 bits.
I've run into problems with maximum command length on windows (32767
chars) because I was specifying so many commit-ids on the command-line
that I blew past that limit. This would help there, too.

Might be particularly helpful with the transition to a new hash.
e.g., a 43 character Base64 id instead of a 64 character hex id.


- Sylvie

[1] - https://tools.ietf.org/html/rfc4648#page-7
