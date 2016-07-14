Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE8D20196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbcGNUt6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:49:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752498AbcGNUt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:49:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 181B92AE34;
	Thu, 14 Jul 2016 16:44:00 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=u+e4
	qeRAUb8PfPQ1o9p5jdQy/NQ=; b=VCtifszKh2pXv6EhFQE1fbwNg9FEgTp63U3C
	VDgDmhRI6cq7dJkk5MKMO8IeZI0LUxAG4tKQxUqfnVqWAThawLg/HkOJ60aFLuGT
	v2hDoIl0K4/mrK0a47mw7PqAPes3dCm+4wz4fqPjo6Pb7JAdV3DBWXtGgYTR5BxC
	VM8z/jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	PidB8Xkh8PcYWeETAVRp+rsoorTMKTAI90N2MxqNH2ezjp1QvgJqQxUWm9T+MET9
	n1lZc+QSrsrqW4kRoNHztn/4T7MGTc1C3uySPaCLLwzj4F69FAlKwVZpWhxIo+Ik
	R30wuB6xOSPHHztBUaRuq5m/RGpVT8yCvXUY1/n0Cg4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF842AE33;
	Thu, 14 Jul 2016 16:44:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 863A02AE32;
	Thu, 14 Jul 2016 16:43:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 0/2] ulong may only be 32-bit wide
Date:	Thu, 14 Jul 2016 13:43:55 -0700
Message-Id: <20160714204357.2628-1-gitster@pobox.com>
X-Mailer: git-send-email 2.9.1-545-g8c0a069
In-Reply-To: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: B0F5B442-4A03-11E6-BDD9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So here is the final reroll from me for now that targets 'maint'
(eventually).

Jeff King (1):
  t0006: skip "far in the future" test when unsigned long is not long
    enough

Junio C Hamano (1):
  archive-tar: huge offset and future timestamps would not work on
    32-bit

 archive-tar.c       |  5 +++++
 help.c              |  6 ++++++
 t/t0006-date.sh     |  6 +++---
 t/t5000-tar-tree.sh | 10 +++++-----
 t/test-lib.sh       |  9 +++++++++
 5 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.9.1-545-g8c0a069

