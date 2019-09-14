Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF34F1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfINMYs (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 08:24:48 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:32937 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfINMYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 08:24:47 -0400
Received: by mail-lj1-f173.google.com with SMTP id a22so29571919ljd.0
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TsnFoVPDl4uUlX8pRK+nlOVoo4qUBF6KW5w/9Etyo8M=;
        b=lLdnVTIAvhDGAWjAZcqi1v6SBPh2Kdsg0qttoaCdfx8b+P6xEkzChbh2pKobFCHCZy
         8gzVnb5M8BZjAilgowBvSh+3s0F9XNj4itKbyzqb0RvUpeAh3bJ7cM4SEd08enWfhw2w
         NtzVYDAdcA+AqHa8fgrfyB3REePC0gDskDoL9rGM1H0CKdyixSkOOpeLUOfgG8wxi6Us
         4wswhizPQifrzgQkNUaI4v72Wqwql2f5548ODe2C1X28IfaQuvhmG2NEZ1BwMxf12ppU
         qEcuDh9A4RaVglF24zEGe1Jby6YkkYDSoS09PiFMNdHJqjW2apa+8OjzwiZQF9wKD8kV
         61Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TsnFoVPDl4uUlX8pRK+nlOVoo4qUBF6KW5w/9Etyo8M=;
        b=SGtAvL7/D2dWaD5A7mi0TmaerbUFkWFDdsDyO/O1J11CLUQLVwSk+OAlB+vHxPNNnP
         3ipJszEf5UqAI+RB/OBwrTtEQMI+3tywH1KgWQ5+Y36wXLArF1bSoD6d5gLU5/VsCr/Y
         EvGDPx4/nSaoielCAsvjWWuC5mgFvenYHz0enu62OKEOZxIq+1PK8AfpscI+fNqevNQN
         H7Yeh5Fp41b7nyggFaQ0MmmUmJS6derrIcTtwAxI9V2b6qI+pUFNxZ3IOKz+/qZ8hZ7X
         MwUth9qj3mOyExwZPhzeuXtJNICeNi4/UIKr5aSugAwi24RIHcfyAzryaReEzGtKeogG
         v/1A==
X-Gm-Message-State: APjAAAV6eAQHYpAOtNbducGjlMkoTDE9jAbIjw6jhYh2fziuclw5EmhU
        /RcNW5CI6XEtX+wMPJ0zdUDWX1Rf42h64CNdn118LA4mb+M=
X-Google-Smtp-Source: APXvYqxR5+63ERQgPH6b9Im1aWtXI5Wx9S3/qaFL+mewSEoQ2dUnGZZKV3sDxNKGvCESgKICy1xbYvLDeA79POT8UZY=
X-Received: by 2002:a2e:81d1:: with SMTP id s17mr27565775ljg.94.1568463884811;
 Sat, 14 Sep 2019 05:24:44 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sat, 14 Sep 2019 14:24:34 +0200
Message-ID: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
Subject: git-gui: automatically move focus to staged file before typing commit message?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,


I personally prefer to have the changes I am about to commit visible
in the diff view, while I write my commit message. So usually I do
this:
1. Stage the file(s) I've been working on.
2. Select a file I just staged, so I can see the changes in the diff widget.
3. Jump to the "Commit Message" widget to type up my commit message.
Basically, I would like to be able to skip step 2. When the user
stages the last file in the "Unstaged Changes" widget, no file is
selected and the diff view becomes blank. When this is the case, I
would prefer that git-gui automatically selects one of the staged
files and shows it in the diff widget before I type up my commit
message. Naturally, this automatic selection should **only** happen
when the user chooses focus the "Commit Message" widget.

I propose:
(When the user focuses the "Commit Message" widget, if no file is
currently selected (i.e. diff widget shows no text))
automatically select the first file listed in the "Staged Changes"
widget so the changes of that file show up in the diff widget.

Thoughts?


Best regards,
Birger S Pedersen
