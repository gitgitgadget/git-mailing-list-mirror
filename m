Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E91C5F23
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090753; cv=none; b=OxKGyNudM1XN0+qSPBo0cjo2xPX6xM6M+9VA5VYNbDcgrsvZB0McWyOF3oOqr4N1L8V3W7jbG670sCAY0vnTUlmkRCb1cADulnyIwJ2j0aS8Ssc3F9ZGL4wj0+XGO/hayk5ETLJf9SbuhZv7n0Qah8BRw8qDQyYiiNeFpQz2Ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090753; c=relaxed/simple;
	bh=J+2MCyfDStUrm1cakYI05nm1I8pvCrgU3F3dvIjhAoc=;
	h=Content-Type:MIME-Version:From:To:Subject:Date:Message-id; b=PsqjJHZ9tr9AtBdtcJHLokKyImHBhH0WUBpIWdpQz3TkOVbEh/FMJVT5ukbJez0AOd5vNJUdURciaxlPvDICwFpunNgFOrmanYIDLpziThuuBgdI41wN46CqG/sY+woTxs8Tb5Ysosydtc8YNezHUCYP3IUxDwGvY9oKGBRhVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TyjfCnv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZmUWDCi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TyjfCnv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZmUWDCi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFF3314001B2
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:32:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 02:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to; s=fm1; t=1758090749; x=1758177149; bh=R/
	06rCkH0TEBBOfw68UyssbgZ5XwUTb+ltert6szr8Y=; b=TyjfCnv7oNaZHrCwwq
	2RMaZ79CamA+ve+EmTGkwpEwKkxmIo3QRKxF58pKW9LojzzcgBFUTL5zxGJkf2Na
	onrTp/AxScuYJkK1OSEu7VKuAqVIhSI+FEjmvDThlH4aJWdCJo9ggav9vX69zm1R
	vYNm43evjqLIuhkriYtML24klHb4DElV/Fdoiw1vcCADcWGCRREuyJ4rGJQf48Qu
	SkQQ4ISCRGuqyDb3SJWbQiNDvgecf9zUQ/22G4gm434TNHx1FrJBzOfcO2IphJK+
	zLaNOx1Uxhvu/0L7WiNwur29T4q6gnsctKieVQ6LgEqi0duv0ixOwpm7MQSZgn/c
	pXgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758090749; x=1758177149; bh=R/06rCkH0TEBBOfw68UyssbgZ5Xw
	UTb+ltert6szr8Y=; b=OZmUWDCiyoizPxsD+YvsNR6liAY+47uDxZCP2QX46VIc
	B8nlbFvoQ+SkIbJw7YVH2lV28xMbn39ISIbmU8shHB/+32JxBN8b1ttBR7ch084F
	NN/8ee0NOmzWPDDx4tmnBH7xTa5m57dLYO/5H+D91qjGcMEX3itzfe32lGlNHmK0
	fnsmv8hdpuJ/OSYS77cb0KuwTEV3r5NxVNaEc66pYsVHRXHhTXwXPFDERk29XsYr
	079bj1Hwixo5tYAyXDGKY7AwgU1yvvaUjDgq71p2paYKF3WAdq4pV40aSKtbfnIh
	EMisJyeJfuNmXgSPo1n3ysagXAiCloi9EY5HoW9BQw==
X-ME-Sender: <xms:_VXKaEhGd659GurzWgwZT2GGwpaOl2OKjz88mziRysQMrPJ3rClxmA>
    <xme:_VXKaPAHcCjunHrZHjsHnWDkwtpf8lU8XOs36CRXVtpyAx2hOV0tybzb2xopRNpVt
    SMcNgT4StfTbA>
X-ME-Received: <xmr:_VXKaFeCirgA4v7mxZYdkPPtRPbaMLATDcAHpp4e7K2a_hJJFnlFSj0AR_-HT1rao_CcfgW9HuNkzNCavnNRGXMbM0v5kkMgSazDuiqvFEB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurheptgfgggfhvffufffkrhesthejredttddtje
    enucfhrhhomheppfgvihhluehrohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvght
    qeenucggtffrrghtthgvrhhnpedtgfdvveekgeejueefffdtueekgeehvdelfeeggeevve
    eiudegvefgkeeuteehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhope
    dupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:_VXKaHeebD_erYcv5ku2G8R6vt1P_ver8gs1adwuHT70K8X8nQt3rQ>
    <xmx:_VXKaJhP_aDq-9Y00iH4j2jWtnQeK1SDV1b4eV7yzIm-XTJiP_i3DA>
    <xmx:_VXKaDR9fGDD1x1dJKNXA9b0A9xheZjBFEdjoVN3JehFuOpWchbwmw>
    <xmx:_VXKaKymAUobWY4uycjVgZKVI0IOPFI93dDxBdMIH2tOt77xi0bxDw>
    <xmx:_VXKaCZP6DOqKF5lB84-4N1HeHQz1m4U7vF6m9xWfAXCu-75GfU4eY10>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 Sep 2025 02:32:29 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: git@vger.kernel.org
Subject: [PATCH] send-email: don't duplicate Reply-to: in intro message
Date: Wed, 17 Sep 2025 16:32:26 +1000
Message-id: <175809074627.1696783.67425889158412786@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

If I run

  git send-email --compose --reply-to 'ME <my@address.net>' .....

and edit the intro message, then it will get two copies of the Reply-To
field.  gmail.com rejects such messages.

This happens because send-email reads the edited message examining the
headers.  For recognised headers the content is extract to use in
constructing the final message and for possible inclusion in the patch
emails.  Unrecognised headers are gathered (in @xh) to be passed though
uninterpreted.

Unfortunately "Reply-To" is not recognised in this process so it is
added to @xh as an uninterpreted header, but also generated from the
$reply_to variable in gen_header(), resulting in two copies

So:

Add parsing to the loop in pre_process_file() to recognise a Reply-to
header and to store the result in $reply_to.  This means that the
intro message will not get a second header and also means that
any changes made to the Reply-To header during editing will be
incorporated in the $reply_to variable and so included in all the
generated email messages.

Signed-off-by: NeilBrown <neil@brown.name>
---
 git-send-email.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 437f8ac46a85..e2248c223119 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1931,6 +1931,9 @@ sub pre_process_file {
 					$in_reply_to = $1;
 				}
 			}
+			elsif (/^Reply-To: (.*)/i) {
+				$reply_to = $1;
+			}
 			elsif (/^References: (.*)/i) {
 				if (!$initial_in_reply_to || $thread) {
 					$references = $1;
-- 
2.50.0.107.gf914562f5916.dirty

