Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9832B1F744
	for <e@80x24.org>; Fri, 17 Jun 2016 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbcFQHqQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 03:46:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35341 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754006AbcFQHqP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 03:46:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 4529B20A77;
	Fri, 17 Jun 2016 03:46:14 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 17 Jun 2016 03:46:14 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
	 bh=BF9BkuqkruKf5aV9B5I+3dd0Ns4=; b=dLPNgpy8Alh/5xJOK+R4pN4PK2H+
	Ic/wHQHPj+XAFZW/QNfgj4YJ+++IEIGy3+0z+1C7sTcjapR2ryFsNLyXiciDHxT7
	TdIT6hAz23iWLxW7Qyat6yXSfo0OWhlT2Uac2f8K2SJ/xzakHIl4XXeSUX8HpMWH
	ZuGigysNb2GbhWE=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BF9BkuqkruKf5aV9B5I+3dd0Ns
	4=; b=aj03oQcGeiC2lp4kgeLbxexMSMN2rgA44ssRvkzmcP7cI41mb8BN0TKP0b
	FvhE4iiedQzOCdXKkbFLGgBsiutbkxAN38bLraECR4E4+k+/1NpA9lf577ysM1DO
	RSKrL2BU4b3hn7iNDLUrpLb5D6Zm8+bSDS2Kp7UoHzNNGEnuQ=
X-Sasl-enc: dWlQle407h6+zSTdPSWlr+H4nMOd2mrWToPpfvsXo0tT 1466149573
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id B71D9CC021;
	Fri, 17 Jun 2016 03:46:13 -0400 (EDT)
From:	Michael J Gruber <git@drmicha.warpmail.net>
To:	git@vger.kernel.org
Subject: [PATCH 0/5] Documentation/technical: describe signature formats
Date:	Fri, 17 Jun 2016 09:46:07 +0200
Message-Id: <cover.1466148698.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.9.0.382.g87fd384
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

As promised a while ago, here is a little series that describes the signature
formats that we use in Git. The series sets up the the basic structure first
and then describes each format in one patch.

The series grew out of my own efforts to get an overview and structure my
understanding before I can set about refactoring what we have. Things
that became apparent immediately:

- We don't support verifying push certificates, although they fit in with
  git verify-tag. Patch has been submitted, and this series documents the
  result already (git verify-tag --blob).

- We don' support verifying signed merge tags other than by using log/show,
  which is not quite fit for scripting.

- We have signature parsing code all over the place, including places that
  should probably abstract more, such as tag.c and log-tree.c.

- We may want to give more support for deciding about the trustworthiness
  of signatures, the same way we export information to receive hooks
  in the presence of push certificates. (Give information, don't decide.)

Michael J Gruber (5):
  Documentation/technical: describe signature formats
  Documentation/technical: signed tag format
  Documentation/technical: signed commit format
  Documentation/technical: signed merge tag format
  Documentation/technical: push certificate format

 Documentation/Makefile                       |   1 +
 Documentation/technical/signature-format.txt | 242 +++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)
 create mode 100644 Documentation/technical/signature-format.txt

-- 
2.9.0.382.g87fd384

