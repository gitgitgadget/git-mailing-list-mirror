Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543ABC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbhKVSWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhKVSWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:22:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B33C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:19:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id l25so64069650eda.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tsYo+Z3juacXmrKq8hYrkJNMHcbMeCa99GADq0NMmQ=;
        b=iN866NYcNc4J52pgR4AG/CqtSLwPhKSsXpHKS2nV6u9jB8r19jvyKXigxLRn3D7Q/B
         gJ0d8+7p+uZr0lAdCTgFbd/S48HcxuneGpHCafYw4WgpDl19dFXEokh1yqwfyvZr22RM
         edyI1cveCMvRoXmX+4oDGkLWZCVkGFgawXp2lcpW+5bGgzkiokN3vF7sqrsYxACvq5BW
         Kmlj3s0/Mn2esnU2HnXAzkGeAQBhGTuSOGdFS07Xlybe2ttwrvszMkMv2LXTtfCDM2qO
         ZTS/sFYT4dsTJkT6aIQF4WYyYTQwOij+HH4a4me3LsIwUq0hcZamf/S4sG1fjKlMoJ5K
         wahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tsYo+Z3juacXmrKq8hYrkJNMHcbMeCa99GADq0NMmQ=;
        b=1pf9vcqN6hO3BD+kWZtRzGIeVR2zlE8Io9Ffv7ejhi/eXyHJlCN0mV5ETZM7J9Ehxq
         KgPMS+pn2vDbUWFSjWMoe508WLCuj9MVaeygydrbM/oH6xaApb/2Yp88X+AhI6W/ABzs
         Ui/a9F9wtj80xfnsGp1OueEap651l5IrRX4RExSN07rccu04Ur8duMTbKDhcXIWqATvf
         1+w2CrgB1wxDIWlSSWB3ml1ji8qu5i8uuUPO2hfnGjn3EPqy7poBNOFotd4YSQ+egeDf
         YuIJfduf/EB/OMipjY4Co2qS9/N/y2QDgPCvSFrGP4ZXVpBwu9hzbyi+Zj9spJwrByRr
         Ytjg==
X-Gm-Message-State: AOAM531KTMVFGaEHFG/lkH4sv7iieRoh9K1cpy44AZ5MCz8A8nSLNUKu
        EyJ1JKgAE9yzBIj3XYt6p/TAEXPyZOluSLUB69E=
X-Google-Smtp-Source: ABdhPJyE6vmSIv26Q1nN1NKj5Vc6HfZo7VGITQNLFRiA/gRDIeKtcI0eUIBBolvPYPo4+4fn6flN6GBmxUWoI5zgPkY=
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr43649336ejc.330.1637605163286;
 Mon, 22 Nov 2021 10:19:23 -0800 (PST)
MIME-Version: 1.0
References: <D5EE9939-F639-4E69-BD81-10B05EC43A8E@jpl.nasa.gov>
 <211117.86fsrv6jq7.gmgdl@evledraar.gmail.com> <37ef900a-d9bf-1941-75eb-ea8556e2ba8c@iee.email>
In-Reply-To: <37ef900a-d9bf-1941-75eb-ea8556e2ba8c@iee.email>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Mon, 22 Nov 2021 10:19:11 -0800
Message-ID: <CANiSa6ieZrsjQD0+5dCMQCyCZzEVeLpQij8AOFS1R4RYGqbf7g@mail.gmail.com>
Subject: Re: Config spec for git
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Wallace, Brooke T (US 349D-Affiliate)" 
        <brooke.t.wallace@jpl.nasa.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 8:38 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> It feels like your config specs are like feature branches, but that what
> is missing (from Git, relative to the config spec) is a merge strategy
> that can define which particular files/folders are merged at the one
> time, rather than the current 'all files' being merged. This desire has
> come up a few times when large (corporate?)  projects need to merge
> large independent feature branches that will need different specialists
> to handle different groups of files (i.e. partial merges, e.g. [1]), but
> that hasn't been implemented (yet) as it would need someone to think it
> through and work on it.
> --
> Philip
> [1]
> https://lore.kernel.org/git/BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com/
>
> Collaborative conflict resolution feature request
>

FWIW, I've spent a lot of time thinking about this and implementing it
in https://github.com/martinvonz/jj. Being able to represent a
conflicted file state has a lot of benefits, of which collaborative
conflict resolution is among the smaller ones (allowing automatic
rebase every time a commit is rewritten is much more useful, IMO). I
need to document the design but you can find an old version of it
(from before I rewrote the README to target users) is at [1]. The
design can of course be copied to Git.

[1] https://github.com/martinvonz/jj/blob/2879d817dd1021f8dc2ea5e42000c1d5d50e4fc7/README.md#commits-can-contain-conflicts
