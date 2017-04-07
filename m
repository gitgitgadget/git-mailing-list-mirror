Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EA9720966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbdDGLv4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:51:56 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33990 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbdDGLvz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:51:55 -0400
Received: by mail-oi0-f51.google.com with SMTP id g204so9515420oib.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6uR7WiSBKaKmLSB8LsHSHOmjPHBd3xwMlLsXfH8dKHM=;
        b=VLKgcMBIrGjEJq/7d2S4idJDOYjvtmIFVBX7lLx1K8tTsoa4vLjUsmVpX/6HCU7E3N
         SwO4vdmkZgIuFHLZbvVyehmayvF7V+MsdhlkwdIhoEjY5OZS0g22zMPA9FFJSYm8hgjL
         hI5DE6r3BUOhy0HQgz9h4TWJYotLOzKIJtu2Egmjr2TKEV6u5QmWrVX9l2kgqcjYXtNJ
         SHqIjXAWMZY2BVa9rNae4KgxWICb0DKxZNpxlqFxluCf10KxbkBCLJrgqjJ/MBhCmF2E
         1ozz6BTfHv5KpH0OF2Ch4oL1ZAJIAlp5gELlXvfGQ00D6oN4ieTs8GLKuDUppsdfMllD
         QwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6uR7WiSBKaKmLSB8LsHSHOmjPHBd3xwMlLsXfH8dKHM=;
        b=eyoSgBpWPG2rjGDqfG8Odi75KEjMemrxvJ70duSXwrNmpNLOsus9p5PZY47vcMHNrH
         QZVCR0tE8G62lAL2ezPn1kONa6BtIKhv2BWhdWtvGvd5GGha+1FqGIxjPZb1mNVbieR5
         dxHKbrATFLZ/Z++5brnTNXoJjZP2aK8syae1Z0N5DcC/5D0pM9uX8LICOm7Tm5knzNK0
         ee/310N3UMv7kHFbf4ppgLyeYwnpBsY6QHt+aQzSyB2SlqpRkv+wMlnylJZ/730eDRue
         49uwl4fPdXLtvLSuGHkUhr/Sg/BsmkovXfTUM/iMM0JiNSeJ5hbXSztLIDprrsLJAuxL
         Aq8w==
X-Gm-Message-State: AFeK/H3nQ/atW4W9i4Tu7ZOqPRqdnm+hFD6aX5vNWHr0p73hXZ6jClSqPR9CDLA7PgBIZMu5mfIfSOoBBQ0S7w==
X-Received: by 10.157.6.78 with SMTP id 72mr6485213otn.37.1491565915088; Fri,
 07 Apr 2017 04:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 04:51:24 -0700 (PDT)
In-Reply-To: <1d131a33fd155f14908ee1d41e98be8a1309c6b9.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <1d131a33fd155f14908ee1d41e98be8a1309c6b9.1490966385.git.mhagger@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 18:51:24 +0700
Message-ID: <CACsJy8DAFUQnjkLnaXD0aM_97_E_7F_=fMeJb2Azigt2Pv0gTw@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] files_pack_refs(): use reference iteration
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Use reference iteration rather than do_for_each_entry_in_dir() in the
> definition of files_pack_refs().

A "why" is missing here. My guess is readability/maintainability
because it's easier to follow the code with iterator design, than the
callback one? No maintaining data in struct pack_refs_cb_data is also
very nice.
-- 
Duy
