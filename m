Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E11420951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdCQRJn (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:09:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750999AbdCQRJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:09:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AF9178B6D;
        Fri, 17 Mar 2017 13:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=zKkK
        RLye9L5mP5W6g6ejwPqfeqo=; b=KcakebLMXoUEMgLMALenVZBcrfAnAjT1rjuW
        wF5q1kJIN9WFhasrzgE0zi4NQAnYQ2fQ5edLLQKFo9OEOEkYpNRTvxdxZJNI+dtU
        2ehEruTmVENpnBCkJtbXIeuWVQ4m/qu8eZxgmPH5iIUA0Km7RoaOSF/KV4A710DI
        UzBQs2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        rJIscOip0/manihnqJ3UGKvqTOvO6jpvMU0T3HAynJBQrz7N+Gcq5eFUjsvJ7gd5
        OnUUGrHc94OFYstaRjKObjLqr0EUXjkIvMTjPprbPWN9Zs10sYlbCr8q/vohPgtR
        hKSaK5tO99/GeAj2sQ+r4XVTB2Zg4X7O0COBcrr1k0c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1189F78B6C;
        Fri, 17 Mar 2017 13:09:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64DDB78B69;
        Fri, 17 Mar 2017 13:09:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH 0/3] Git integration update for DC-SHA1
Date:   Fri, 17 Mar 2017 10:09:35 -0700
Message-Id: <20170317170938.20593-1-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-317-g32c43f595f
In-Reply-To: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
References: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
X-Pobox-Relay-ID: 8157615C-0B34-11E7-9A3E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are three patches to replace the last two patches from your
series.

 - The Makefile knob is named DC_SHA1, not USE_SHA1DC; this is to
   keep it consistent with existing BLK_SHA1 and PPC_SHA1.

 - The CPP macro is called SHA1_DC, not SHA1_SHA1DC; again this is
   for consistency with SHA1_BLK and SHA1_PPC.

 - Switch the default from OpenSSL's implementation to DC_SHA1.
   Those who want OpenSSL's one can ask with OPENSSL_SHA1.

Jeff King (2):
  Makefile: add DC_SHA1 knob
  t0013: add a basic sha1 collision detection test

Junio C Hamano (1):
  Makefile: make DC_SHA1 the default

 Makefile                |  19 +++++++++++++++++--
 hash.h                  |   2 ++
 sha1dc/sha1.c           |  20 ++++++++++++++++++++
 sha1dc/sha1.h           |  15 +++++++++++++++
 t/t0013-sha1dc.sh       |  19 +++++++++++++++++++
 t/t0013/shattered-1.pdf | Bin 0 -> 422435 bytes
 6 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100755 t/t0013-sha1dc.sh
 create mode 100644 t/t0013/shattered-1.pdf

-- 
2.12.0-317-g32c43f595f

