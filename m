Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB162C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86DC20842
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vqXfvuvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgBKTg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61542 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgBKTg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A79A4CE1D;
        Tue, 11 Feb 2020 14:36:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=UPSELPLSo3GgeSxNh4MDfvn/G
        84=; b=vqXfvuvB/rzMDpr01tB16tVil6PGwEAwhr8SW9le+T0CgiJyP5CqPtCVi
        gy7fomZGyBSW1QKFq9/x9jTWKHovjjxEYSctVnoMFn6kdxa19unMtRxRbDHYXGmK
        a3B6Txsxj2L5xJq/4p++ug1P2KLa0FRJRHzM/kJbJbd+RXkSaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=CTefmqpvwX9e1m28jLn
        BeVE6L2zhoG9/Up+WC7neFfu+TogBvXcA+gTVa5gzl25C7wo4JyZHCx2Gj7Hph9B
        Rbj/2meg8eSoHyAz97P65P84vra4ZxXg2b0318MSiuLl8Wewr9wQI4bKKIfxPokR
        0xSly4Z98hU/hOD6D8pxvMmM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62E604CE1C;
        Tue, 11 Feb 2020 14:36:27 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C78D04CE1A;
        Tue, 11 Feb 2020 14:36:26 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] es/bright-colors (hopefully final) reroll
Date:   Tue, 11 Feb 2020 11:36:22 -0800
Message-Id: <20200211193625.231492-1-gitster@pobox.com>
X-Mailer: git-send-email 2.25.0-453-g769eb9f0f1
In-Reply-To: <20200121165623.151880-1-shawarmakarma@gmail.com>
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: CB3F502A-4D05-11EA-8CFD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I've got tired of waiting for an update for the finishing touches
to this topic that has otherwise been polished adequately, I've
applied all the changes suggested during the review and also updated
the explanation in the first step.

Eyal Soha (3):
  color.c: refactor color_output arguments
  color.c: support bright aixterm colors
  color.c: alias RGB colors 8-15 to aixterm colors

 Documentation/config.txt |  4 ++-
 color.c                  | 75 +++++++++++++++++++++++++++++-----------
 t/t4026-color.sh         | 12 +++++++
 3 files changed, 69 insertions(+), 22 deletions(-)

--=20
2.25.0-453-g769eb9f0f1

