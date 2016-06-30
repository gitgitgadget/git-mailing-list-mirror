Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663E81F744
	for <e@80x24.org>; Thu, 30 Jun 2016 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcF3Ktv (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:49:51 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:35533 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbcF3Ktr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:49:47 -0400
Received: from hashpling.plus.com ([212.159.69.125]:46418)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bIYyn-0007aJ-OU; Thu, 30 Jun 2016 11:13:53 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/3] Grepping with intent to add
Date:	Thu, 30 Jun 2016 11:13:45 +0100
Message-Id: <20160630101348.15665-1-charles@hashpling.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So I've got back around to this topic again.

I've applied fixes to the tests as suggested by Eric and Junio.

I came up with a test case that demonstrates a difference between the
additional fix that Duy suggested and the alternative that Junio
suggested.

I've kept Duy's fix because I think it makes more sense, although it's
a sufficiently obscure case that I don't feel strongly that it's
definitely the best behavior.

The fix ensures that if you have a file which is both "intend to add"
and "assume unchanged" that it is not listed if you "grep -L" for for
something. In effect, we are applying the "contents indeterminate" state
of the index to the working tree file.

Charles Bailey (3):
  t7810-grep.sh: fix duplicated test name
  t7810-grep.sh: fix a whitespace inconsistency
  grep: fix grepping for "intent to add" files

 builtin/grep.c  |  4 ++--
 t/t7810-grep.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.8.2.311.gee88674

