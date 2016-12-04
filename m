Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1194C1FBB0
	for <e@80x24.org>; Sun,  4 Dec 2016 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbcLDQgs (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Dec 2016 11:36:48 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36067 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbcLDQgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2016 11:36:48 -0500
Received: by mail-oi0-f48.google.com with SMTP id v84so315805090oie.3
        for <git@vger.kernel.org>; Sun, 04 Dec 2016 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=UnD38trob07KPQntZDONDl1anrTpWLg8w2NdeG/Pubo=;
        b=lXYRMQMdmwMxmseFGtlCupOnvnkMLwEifLFxAiUAOAYbe50SsyjL0MAMZZXCOpwoEC
         OACNW9fqmiMYA8DyVPy97qVutskq6ASdocx5rDnAU1XlIZvo3TAowxdTCDLEgCzkftsE
         xP5rS9vavU6+eNt9A3e/4/sszuuuBQ8s55fXPzho7cSn+FBUJ3fFAhfpQt34i7zkDw+R
         oQNH5tHGdCPlISXxHnecUsw07oIjKTFfa1DEevTjE0uUmc2K3E88QlLwDRogTTRt6HW3
         t3GViZVkLoGGXYUboCn3GWOsnLrGx3y4b07Jd/3AtIRRGi4Ol2PuHvgxDP+VP8G/9y7+
         Ztag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UnD38trob07KPQntZDONDl1anrTpWLg8w2NdeG/Pubo=;
        b=C4gcumg/yb374omAiCH6wTHV0XTUsFPzc7FElwx3JbTSoN3Yy6CNEu4PXTqY8Z5pti
         JaiAUnjdPBokHGZooTI1FV33rnrR25BAlpTCquTqTYtDMdH7v7JNQnqYuFVzvu51/2Jk
         SMiCmRtPQ1EBaY5tRVYfGQpGVTypk2L8aHAtF3Wfzn3yTvJ2RcWMziRfnWUQV+0odBVM
         2NsrVBXuNAVhjT3ZzbzcsY9hNAXHZOnGhm6RmUIBu1JCzjjQQFfjAN7mKJhK07pnvwSC
         GZet3BQcmC7AKnRrUYZqisyoDqFa5N2U8xynI/eoPzIa8NbCdkDnpYOQf024qi9erltv
         G5MA==
X-Gm-Message-State: AKaTC015IQXlJnrarYx8Smx4y+M/p9RuSKEdLMk7uCginhkoRgyj5UIRiBx9zp+fLnO5GtTQztsFJBBCP6AbRg==
X-Received: by 10.202.51.8 with SMTP id z8mr26404159oiz.79.1480869407033; Sun,
 04 Dec 2016 08:36:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.52.135 with HTTP; Sun, 4 Dec 2016 08:36:46 -0800 (PST)
From:   Timon <timon37@gmail.com>
Date:   Sun, 4 Dec 2016 17:36:46 +0100
Message-ID: <CANtxn9J9O+PADxpWa0JCcgwwk_tC5DuJGUruULN2fGP3knZ-Sw@mail.gmail.com>
Subject: [BUG] git gui can't commit multiple files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a regression in git 2.11.0 (version 2.10.2 is fine).

In git-gui I select multiple files in the Unstaged Changes (using
shift+click) and press ctrl+t to stage them. Then only one files gets
staged instead of all of the selected files.
The same happens when unstaging files.

Git-cola also exhibits the same behavior. Although there I could stage
multiple files if I used a popup menu instead of the keyboard shortcut
(I'm guessing it goes through a different code path?).

Note that I tested by reverting back to 2.10.2 and verified that
everything works, so I'm quite certain that this is a regression in
git.
