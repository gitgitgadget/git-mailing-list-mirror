Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TRACKER_ID,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1DC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD05022CA2
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 18:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407424AbhARSIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407440AbhARSIX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 13:08:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4AEC061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:07:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so9030500pls.11
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 10:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:subject:from:to:date
         :message-id;
        bh=2HlzfSTo4gfkVhanTamm4MDGoTFZGwwaPtN2czCZSvs=;
        b=sROdPq1KRciJJjiZhU6dqOVTtvcw2q2BAXLyb7deIjhizWwHD7SMcVGFEwYLSfGDlD
         uua5BLMaW3gp+LmjYdoktFgQ3H+bDo4U/S9K6VPT1T59kn8S2V5xmOPR7I+f5v/mrbsg
         Y0fRolz2A2R4FuX7odXkkNlC76jcmmCcJgV+WyaAN1wX1FalG/2DIAM/OtH9CfYv0wkY
         4t6nH7s4wYb6j8RhASQvvXiCjPcF7WVjkTTrIjWnkhSF7ThMrRpbU+7E0nA4S5ZzQF0A
         Iuq61nse7IcAMw9tfwEZf+zkCwnhQV/5tQj6kyuudPp5LrKn871gKXyTUq/70auVCYr7
         vJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:date:message-id;
        bh=2HlzfSTo4gfkVhanTamm4MDGoTFZGwwaPtN2czCZSvs=;
        b=oJLvCiQUK4xmFirqutVDU+8s9WzNJ5rDodXi7A6gD3gzIcVhCD8DdkQWbUd2Vz5aUJ
         cc5gpxDXPawVWkhfOhfjxKbMCMAq14JO/iqpGQ1wa7LcU9KATYX5MyErHHWDq+HZGdbY
         K1UlAc+efed5YO1sCx3Oy0q145tXsoQe86/fEr45bl+Nln+/157EjFaem32fg2pbLc3y
         DxsacMZAQHxXKVUgzSrBAaW7a2lwex3F2Fzznmg/su01ks50SeVDb3WVLHQhR+OM9n/Q
         y0ecpbMQGQ3nv9gMNnovDJoBQSm9P3o0Qcsv2/MBfcgCygfhsu9h4EGT7lqcmDYkbN3g
         QXOw==
X-Gm-Message-State: AOAM532kvwipqCdI4Wcfuy42bogdjxG/Y8nNWAvOgaSvPfB1DoYoBjMp
        0hqUy2KLP1U/Cmv3VMlzso3wVcrRGSziYg==
X-Google-Smtp-Source: ABdhPJwzrWz3ufPY5l2kAZuqX8hcaRhL050EJqmuypSg808TdXi8+cpqshE8E7FOMtlBlSyHVjAEow==
X-Received: by 2002:a17:902:9049:b029:da:efd6:4c12 with SMTP id w9-20020a1709029049b02900daefd64c12mr555580plz.12.1610993256052;
        Mon, 18 Jan 2021 10:07:36 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id p9sm16475661pfq.109.2021.01.18.10.07.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:07:35 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: DEVEL: Help with feature implementation
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     <git@vger.kernel.org>
Date:   Mon, 18 Jan 2021 18:06:52 +0000
Message-Id: <C8MHFL3YJDSF.1GLOUSV7BYS1X@localhost>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everybody!

I want to implement a feature in git, and I'm looking for some help.

I wanted to add a history-simplification option to rev-list so that it
doesn't simplify away any irrelevant commits if they have multiple
relevant _children_, i.e. when they are the point where two relevant
histories diverge.

Basically the effect I want for --show-forkpoints (named like --show-pulls)=
:
http://ix.io/2Ms6

But it seems there is no existing apparatus in the revision walker for
deciding simplification on basis of *children*, am I correct? Admittedly
my understanding of it is still a WIP, but I don't see anything that
could help.

I was hoping that simply the flag CHILD_SHOWN could be checked, but it
seems that's only set on boundary commits :(

This option would be pretty useful when used with some diffs, to see how
much two forks have diverged. Currently if you use history simplification,
the diffs for both divergent histories will be created against the last
relevant commit instead of the last common ancestor, which creates pretty
useless diffs with a lot of intersection between them.

Are there any viable alternative means to do this that I can explore?

Thanks!

FriendlyNeighborhoodShane
