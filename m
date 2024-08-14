Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B213A418
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618321; cv=none; b=pn47La517JNO3zikgN0p4hcnwnx8XR4gTVmGf6cfBGSDDDrjllc4fGaoTvgGSH3p0657O1mJiZ8DFH2I7E4SJvGXMw4bPIZeQ+7uTqVyjJUvHyVTwoxCkm8Q3gv1kFnIZMg3iFklPoOYLKxDUdkiAqlBGi/+2iO1a6L6Cj4F68k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618321; c=relaxed/simple;
	bh=AzUj8spFAxsKjMaTFz5FGByM6NOtBXz8D0GKavJxcGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTwffO1RmYoyTtAmcvgg1YGFVB0XGYBN9/yS7/MVLjhLEzx7u0k++Mi4Sp5Hf3kiBC14lsNmzdkGHTf4XDIKVldbKe4AobC7gkSS3/gpn1JONHuAkFChYjlOaHobRbDzb+n7H68ymLzzEdXK1/cPFNUsqEgx2FhSYiSNJg/+bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oJd9lYRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jmvy1wLG; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oJd9lYRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jmvy1wLG"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 72D8E114EADE;
	Wed, 14 Aug 2024 02:51:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 02:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618318; x=1723704718; bh=ZCyjENfYzz
	oX+ZOFJv6cSiPv2bzvUen9/0czNnq2aA0=; b=oJd9lYRjWNF3rLflTdUvgmhZ8K
	wLY+m5eXZQpn5NSh4wsbRNJnmuO61QV7LnBdy9K5xo3R9iqOf9b3rDeOObP1LayJ
	4q918jOUbI4+B/BSks3RbwlQR45FYirzoroVrm78/1v0+O1MjbWKsC1DJnbaRd4s
	wlVV4o5jUBXX3ZmnWg9sE4++QcflibedY7pgpIShnay5aIVhs2yBpV6XHAjdh60p
	e1U+7/qenhAPM9afLWykplWndQWwv/P3XDHz0zlOLOwWMWb3+71uPwjbMIVC3LYO
	ZDksRm5IazYgHHp5GxMi8rbBLyqRCCVzj9/nRyyucHl28TPJlckHoRLzEHdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618318; x=1723704718; bh=ZCyjENfYzzoX+ZOFJv6cSiPv2bzv
	Uen9/0czNnq2aA0=; b=Jmvy1wLGI/9SOkwFpumUAZNnelypwm/2xd/iJGye6WIT
	Qd+fkvbrFqdpCTC50AtLF5Is0PnmOO1TwOWLecyxsBNhkyxMHz44jIsQbEG+aL21
	wWlxJzGW5bicjFeKo2KND1p/VbbYBpvt/mU2zMnDet7Qdy5lgHk5JvZKIpQWTcrw
	JsmHfQNutYyZXAk85IPJyHm7VyWG6g8OUyZ/NYHUnMdD/0BkVzoqhop7OCPcHF4z
	1A6RzSOKeOeOm+9jHYc6ATQQMUJ6QKVhgyaatYW3pPB3GJrWDtdPK9F2QCmYiXCY
	HXOyXUrkMD0nVjaeBycte4y4+YQ7nsAkHZnr/zEc2g==
X-ME-Sender: <xms:DlS8ZtA_Hqom4Wn90EU_N-_XaXzxz7yL9E-1OWBJb3M53a7Rnw8s0w>
    <xme:DlS8Zrgn7BcN58jucDUp6qcVruwqoU29FdYAxb_XMsw3RB4XvgGAxJ0uXLVmPqguP
    -FtCcDnbd8hkMauIg>
X-ME-Received: <xmr:DlS8ZomRPIBHAJq98zrIU9__qFyiaHWKwuJw81OdBRYVr149xN-lIW5M8yiiPJ-WqjiG-EcxRpwv3G-fBjYfZyXLBOV7WWYaNhoZ8R8z3opNgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DlS8Znx5ukHDqenI3abR1wzQzlObDhTjs-KpkG0hmPKKGevJjYsR0w>
    <xmx:DlS8ZiTmHkhm5ZK_KhTz7J12EzcDtCizI7sC77VaV5G7_qmtO03ifw>
    <xmx:DlS8ZqbxAlrWxEG-lBCMLJMtFGwXx3oe_UixQvAk-R3WVox3EJrjkg>
    <xmx:DlS8ZjSZASR1kjmxHF2qn2_spa2So4WdGXNzkkM45xLQyekGU49RlA>
    <xmx:DlS8ZhE52wO9QNdY-v7r1CikcfL19TS62NkJlWcGrs6wA_KpKe7PFnqC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:51:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff2d3cee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:38 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:51:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 02/22] git: fix leaking system paths
Message-ID: <f36d895948a2b26148062a3de2997fb6d23301d3.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

Git has some flags to make it output system paths as they have been
compiled into Git. This is done by calling `system_path()`, which
returns an allocated string. This string isn't ever free'd though,
creating a memory leak.

Plug those leaks. While they are surfaced by t0211, there are more
memory leaks looming exposed by that test suite and it thus does not yet
pass with the memory leak checker enabled.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index e35af9b0e5..9a618a2740 100644
--- a/git.c
+++ b/git.c
@@ -143,6 +143,13 @@ void setup_auto_pager(const char *cmd, int def)
 	commit_pager_choice();
 }
 
+static void print_system_path(const char *path)
+{
+	char *s_path = system_path(path);
+	puts(s_path);
+	free(s_path);
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
@@ -173,15 +180,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			puts(system_path(GIT_HTML_PATH));
+			print_system_path(GIT_HTML_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			puts(system_path(GIT_MAN_PATH));
+			print_system_path(GIT_MAN_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			puts(system_path(GIT_INFO_PATH));
+			print_system_path(GIT_INFO_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-- 
2.46.0.46.g406f326d27.dirty

