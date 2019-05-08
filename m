Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196771F45F
	for <e@80x24.org>; Wed,  8 May 2019 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfEHK4L (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 06:56:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60716 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfEHK4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 06:56:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F325A149C18;
        Wed,  8 May 2019 06:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=4DQQ5AwJocGb8AdbC9vZ4RuoH
        8A=; b=Gu4mCtbHXLtvJly7AiJ4/G6ciX2JGyuwAjSSU/LIzWQLbM2NA0MjXa0Ze
        5wg/Rh+kDs9ckQ8svtsr0IAMdOdIgtdMZyE1CVGeHVFU+toPtDxfjGghHADIH0Oz
        P1aigzxxuAVJMf/bpSAPRSnVif83z6m11YyuOa+obfH3OHEoY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=NowlsRo0/C3zxOS/zNZ
        4B141Xf+FEPRVArAqHyiqVDEdEzEi4EwSLfcCw36b+M4fwTGG7lsd44O/bO9XxLA
        zVOfQupx2N7ZKfoH1OsGONOwVMJJJCXt+SSZXIy35TSgO4z0XRHX+A1EnIXnpxhQ
        Br2oe7Q1auQbZc/hnVjeZztI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB600149C17;
        Wed,  8 May 2019 06:56:08 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 596A8149C16;
        Wed,  8 May 2019 06:56:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] send-email: set xfer encoding correctly
Date:   Wed,  8 May 2019 19:56:05 +0900
Message-Id: <20190508105607.178244-1-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-777-g83232e3864
In-Reply-To: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E259EDAE-717F-11E9-821A-E828E74BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier I sent a series of "oops that was wrong" which was rather
embarrassing.  This is what I have to replace Heinrich's patch that
was not quite right, while making it harder to make the same mistake
while defining fallback default values to configuration variables.

Junio C Hamano (2):
  send-email: update the mechanism to set default configuration values
  send-email: honor transferencoding config option again

 git-send-email.perl | 58 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

--=20
2.21.0-777-g83232e3864

