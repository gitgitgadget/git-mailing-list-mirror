Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E399202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 00:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdJ3Aiq (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 20:38:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50545 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751684AbdJ3Aip (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 20:38:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33286B9DCA;
        Sun, 29 Oct 2017 20:38:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0W58vUOs7CWARXkHqHOo9GVuH78=; b=NHLx32
        nTcCQYw4xLEPBJQRpYBIBUeKtzNhkCtx2ksr23j+MCydE0VfjlZ5ZII56oHSTrKO
        OfrUX8YFbnBiqgbDFwsv4uVr/mW47tZUJVmILdg373NeyG78IJdVWmMaPorHngvI
        3Wb2kttdcfFGsSGXkPRk++ks1ymwYVCe47zYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HwZlWS18FYYj6AmetVFcLr1KTSSu5/O9
        XGS/arxkIe6mC1NqRAJoXkyo5FNqTH19HRWyhjC6HGXg1Y6ZZX83dc/fHMvqS+g1
        eDmzpvjzRtDyZQRK83AEQjBrJXZxK8HXJ9qnGvqyf2XVLdmM/FzH/m0k80PUd/+y
        x2uBvaX1w2A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27D6CB9DC9;
        Sun, 29 Oct 2017 20:38:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A19FB9DC8;
        Sun, 29 Oct 2017 20:38:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
Date:   Mon, 30 Oct 2017 09:38:43 +0900
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 19 Oct 2017 14:30:24 +0200")
Message-ID: <xmqqvaix8o6k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF4C644E-BD0A-11E7-A172-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've queued this from Dscho; please take it into consideration when
you reroll.

Thanks.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 29 Oct 2017 16:17:06 +0100
Subject: [PATCH] fixup! Git/Packet.pm: extract parts of t0021/rot13-filter.pl
 for reuse

The patch introducing Git/Packet.pm forgot the NO_PERL_MAKEMAKER part.
Breaking the test suite on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 perl/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Makefile b/perl/Makefile
index 15d96fcc7a..4a74a493e6 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -37,6 +37,7 @@ modules += Git/SVN/Editor
 modules += Git/SVN/GlobSpec
 modules += Git/SVN/Log
 modules += Git/SVN/Migration
+modules += Git/SVN/Packet
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
-- 
2.15.0-rc2-267-g7d3ed0014a

