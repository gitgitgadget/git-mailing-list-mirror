Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5739C2036C
	for <e@80x24.org>; Thu,  5 Oct 2017 03:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbdJEDED (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 23:04:03 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:43060 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdJEDED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 23:04:03 -0400
Received: by mail-lf0-f44.google.com with SMTP id o125so10846248lfe.0
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=K+bEBBHByX8Daq775qhgsNWv7/E7VpbeBVGAWmMDxEE=;
        b=nvgGB6Cy+/P9ZIN8rjineiQMnk4+NhKscgFEwym3TgpEtEPSOL8PUTFJFmHWBTUZDu
         FUMqvEk86F0EB4oweaTvZvqkoLk5F+puC3jxMvhU2jhneWs6310yoVC2fYP8N/lTsNoc
         PiIracbq6XkVNO7V7dOEFknuYGxQ0m5VskQDUdm5wdt4RnHJAzY4CLKP9V0RKGwe2Ic1
         fZMPskWEJie96DSrHZq6FYjI5sdLJMnW/1Z8fn/tbD6MKvox1qWXnPHXQXkVmNH20y6u
         UFUoaj8iRq49SAoyfiW2DBMgSdU0Qke68BsJn5m2lDa6I2xZv6lEqxMPe0Cgoy6l3g5q
         3Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K+bEBBHByX8Daq775qhgsNWv7/E7VpbeBVGAWmMDxEE=;
        b=hJSdovjvjRJYV2AU2sDBKg83yZ8Lpi14UcIPrbdVs3TlnYWZm3sRb36S5Dn/E8WC36
         X0P9WLiad1SoSPDuce1s9OpakSgu1vSi5jNLrcbar11CsO/ebcNSHoYgAoTgP3ol3FKU
         +OiA1Istl1KaTaRaIqi5hOuMpTHOh1KPy50vCT7BhrZIbGUReUHG2tGAzzTNi6NWHsNQ
         M37DwZkbGTl38KTJs3JL8089Ic5h31TBymnRlHYRqdAjR4SBkJekIGiyPLbBUDWMKD0P
         4ZhRNF34qtRezeguRsuzb64lS028x3KQBRIRICwqS/GKn0DIEK/9R5cfieOTdPDjhAT6
         CstA==
X-Gm-Message-State: AHPjjUgWrzpxsb3jfQCRK3i3dzesXqernSf/zm9J8wzvaHE8VGCBiufE
        xptwGed3yTdBU10Zo9e6szXV8qa2Nbg8rHYfyyqAZg==
X-Google-Smtp-Source: AOwi7QAsNMJ5ml7wv7ANuuxGsVcZoWzEOOSfLDnEzbBz5sLe6B8vTSQs0ylDDks3PyL23XxoKkXAezIAIkmpl/5vSD8=
X-Received: by 10.46.84.16 with SMTP id i16mr10370417ljb.60.1507172641540;
 Wed, 04 Oct 2017 20:04:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.92.12 with HTTP; Wed, 4 Oct 2017 20:04:00 -0700 (PDT)
From:   Joshua Lamusga <joshlamusga@gmail.com>
Date:   Wed, 4 Oct 2017 20:04:00 -0700
Message-ID: <CA+bN42rdGATo-T-ibWRMvXsKJwgX6Lp_xSM+MEQdc3tOejshog@mail.gmail.com>
Subject: Deleting a branch after merging it results in "there may be
 uncommitted changes"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I'm trying to understand Git and the mess I've made. Some time
ago, I did crazy things like adding to master even though I was
working in develop, leaving it a commit ahead and X commits behind. I
did crazier things, like trying to amend a previous post's message.

Anyway, I follow a very simple merging model for this one-person
project. Recently, I made a new local branch off of develop called
feature-printing. After checking out feature-printing, making my
changes, and committing changes, I merged it with develop. I then
immediately tried to delete feature-printing, which resulted in a
prompt asking if I was sure since it might contain uncommitted
changes. Though I've seen this problem many times on the internet, I
haven't seen it in the context of literally just merging. There are 0
steps between merging and deleting the old branch.

All of this is done in Visual Studio's GUI for Git. Any ideas?
