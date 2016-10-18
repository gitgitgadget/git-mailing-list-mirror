Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E9A20988
	for <e@80x24.org>; Tue, 18 Oct 2016 13:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755910AbcJRNdt (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 09:33:49 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34743 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755225AbcJRNds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 09:33:48 -0400
Received: by mail-vk0-f41.google.com with SMTP id b186so217957646vkb.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 06:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+pLEmcJNRqVi+VDso3rEG/Rplfc4O2Er2ndYXTPchIs=;
        b=sDKjB+5vXhsJK/xjI6U5xS4TO7UEvSMknF7TpgVnigLCfYWRIjq2WeVLQDZ2ous0Zt
         PIUogCtLweKo7ftAFpfUD042QFvPveVOUcbGCfMi5NlaS3I3XsQ3Z78+16rOFjrDxHh6
         IsKOg40ZlK0BUccPMTJZQU1NP7wtCqKq/MVeokYh0srktzifyjtzyiY8AJ5oJCBqbJPs
         6mGT3b/+huwCFLh3XI93XUdhIN1jaT/woR0D9FIvB9C0s6EI0IMgvl6+REOePs1NopEl
         2dZMgPGJNwLN70qfdk/vW0ArUdHLGuL+ibdHaEHOfCPw9FDnrnBqTyrhdr+ocIbsOqVX
         sIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+pLEmcJNRqVi+VDso3rEG/Rplfc4O2Er2ndYXTPchIs=;
        b=HRp4arfQ3tt0wQZsBXHENjrJn5MSLSnAPcnDHgtZy6ctSQnSzGxSNoQm/UhSYlUhyV
         S8CJUgg7yZKDyT7Dz1GvLe2VD4bGnsZKtJ9n2FGoFibDL/uk2nURvEO1yieTwmcsHPrP
         q9ZwXgUF6TuWElobKkwvL6j23QWD4as0iVqzTDw90HZ6rULlVqJ/y1S/aLzQg/2kRAKR
         yhKE5MSkbiqouKLWRUUUMkB3SgS7kK/Au2+DHUaIG3kJgllKC36ClUp1FDIUpawRb0JE
         APzDtBAVQdha0zhJuojdhcXj9kUvwuyjMLa2d44xQbaYzSxm8BWrz7QD/ETMVNgO8ahK
         kc3A==
X-Gm-Message-State: AA6/9Rnbn6Hi2T7UthItlOf/tExGSKL7cLdqM4Wdi8mOLQJEKsXcPwAbLvEFVP8cE5dyILzk2q/42BtKTYNjNA==
X-Received: by 10.31.47.70 with SMTP id v67mr471726vkv.4.1476797622887; Tue,
 18 Oct 2016 06:33:42 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Tue, 18 Oct 2016 06:33:42 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 18 Oct 2016 08:33:42 -0500
X-Google-Sender-Auth: XmXy5KDGfF2FnvWCPtWEj_983RQ
Message-ID: <CAHd499C+SACpBrOEk-V4QMKoq2egmMfYSwUN1tZBBhFOTWomRw@mail.gmail.com>
Subject: Git log exclude/remotes/branches options not working as expected
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have 3 remotes registered in my clone:

origin, fork, drive

When I do:

$ git log --oneline --decorate --graph

I only want to see branches under:

refs/heads/*
refs/remotes/origin/*

I tried the following:

$ git log --oneline --decorate --graph --simplify-by-decoration
--remote=origin topic1..master

However, I still see refs present in the graph for 'drive' and 'fork'
remote tracking branches. I can't tell if these are shown simply
because other refs not excluded by my options happen to also be at
that SHA1, or if the log command is still generating the graph based
on other branches.

What I'm expecting is that I literally see NONE of those excluded refs
on the graph, even if other included refs also happen to be positioned
at those commits. It's the visualization of the refs I'm concerned
about: I have a lot of remote tracking branches in those remotes that
clutter the view; I'd rather not see them at all (in addition to the
graph not considering them when it is being built/generated). Am I
misunderstanding the purpose here? How can I achieve my goals?
Documentation hasn't really helped me out here.
