Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D494A1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 15:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdFMPZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 11:25:34 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36404 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbdFMPZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 11:25:33 -0400
Received: by mail-io0-f196.google.com with SMTP id i93so13317450iod.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VR2rGRdrxWyaBzNK9u2mkAAkG/ecPII0UECkxxbLxRE=;
        b=uzYn/uzSCXoj7OBq7Hryb9oMESexbdfYJ5y07mnar8iGhzXo5a23GHww7NIWR3CSdX
         V2tIcbwBhBV2EvsviRRVy5pETdWmQbGoG+KV5i0OFJGCXtxiPePMrcCHxBr5EPPxT5i6
         WwTYOfn2g1NVhOCPcVKRgYclWbeUKx0tEE44yCgDSnSZolk3aP9qTzcMDxhFT3p1cF27
         IxHnxo5L4T5PIUZsKHo8LAIHUzzhVrahP+NHb5W/KGCadVGPplFes4QyQT8A8os/F6c4
         J3IM0Lda8tZF4+8D2u+Lt1KKrw8+iA6zYW3KMudRU3Jt1k4ZlVHFCzhsQ6mt1pw0jjgA
         FPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VR2rGRdrxWyaBzNK9u2mkAAkG/ecPII0UECkxxbLxRE=;
        b=NXBLffcRkK3SYDVRasR/Xnoox6uotQo6q13ExRBsJaw3JQZZh4sG+KW8qNTiRkYqmD
         2j/OIImZEFzNpIJ6Rcgbuvi/TqP9GbDkExtwtRMVzaD+QNS23sPbDKWoU6VT5QpfobL9
         sGEvB3IEvrj3tIwCs/liTAmmjeWfJANia+ID91o6Y7AplJ8o9EHWP90uB5LgLisgqWHX
         liK7IqGm53iqQtcl6DXcIroTHyrDDQ8RI57h2Rj2GRZPQWqhQv4gg1rc3P9AWQCur1Zr
         JDSNEXoIZY3DbHxzTu/qdPdc+2++v66zt1/zDmZTcfglBWUQRLEsSqtuiFI6OzLj2b++
         BtBg==
X-Gm-Message-State: AKS2vOx6ivD4z6VK+snKOVxGOJZPLjX2+CT/O+VMWyvnx8ydVwXHEEZW
        ya8lxV02faSaynmniRo=
X-Received: by 10.107.136.211 with SMTP id s80mr504401ioi.18.1497367533052;
        Tue, 13 Jun 2017 08:25:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id b24sm6156166iod.33.2017.06.13.08.25.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 08:25:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
Date:   Tue, 13 Jun 2017 08:25:29 -0700
In-Reply-To: <20170613023151.9688-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Jun 2017 19:31:51 -0700")
Message-ID: <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When using git-blame lots of lines contain redundant information, for
> example in hunks that consist of multiple lines, the metadata (commit name,
> author, timezone) are repeated. A reader may not be interested in those,
> so darken them. The darkening is not just based on hunk, but actually
> takes the previous lines content for that field to compare to.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Not about "blame", but I was trying the --color-moved stuff on
Brandon's "create config.h" patch and found its behaviour somewhat
different from what I recall we discussed.  I thought that the
adjacentbounds mode was invented to dim (i.e. not attract undue
attention) to most of the moved lines, but highlight only the
boundary of moved blocks, so I expected most of the new and old
lines in that patch would be shown in the "context" color, except
for the boundary between two blocks of removed lines that have gone
to different location (and similarly two blocks of new lines that
have come from different location) would be painted in oldmoved and
newmoved colors and their alternatives.  Instead I see all old and
new lines that are moved painted in these colors, without any
dimming.

Is my expectation off?
