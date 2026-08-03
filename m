Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDAF2A1CF
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718203; cv=none; b=XkTaNJDb9e6mT1QbIx6XzqwqcmDrhAnOlWp3IH1exbxsuDvGi8jLx/0UL81JSHGKGB0HLErmVSZdrGGzGDMYmw2d8qUte5bvMG36MdECkoKenPVKd0SvyE90f692BtlLyszwmPSDJDugxuIY22iVc+wGvj4BZBrgeBc05IEeQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718203; c=relaxed/simple;
	bh=85Pt7yK1bL29mzzEy3f9d7E69G8i78mLIDOrV0ruz/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlSlUg3JAjoDQuCyrf527xlMixd4TsXxkBIKOqoNQGSCyXAwHZq/qdIun6MlJfFE2Gfr6NT/t2pl1JKutPoTX5gW+gkLEp2+NbFCJu9N47nVREht4l5PKSc34CoxAPzL3MCk75h7lHsiW6t8ot+wFSSwPb1k9hGRgAXDLMF12M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail101.his.com (pgh-217.his.com [75.149.19.217])
	by smtp-1a.his.com (Postfix) with ESMTPS id B2B6A195;
	Sun,  2 Aug 2026 20:41:22 -0400 (EDT)
Received: from proxmail101.his.com (localhost.localdomain [127.0.0.1])
	by proxmail101.his.com (Proxmox) with ESMTP id 43FE4BC0E7C;
	Sun,  2 Aug 2026 20:41:22 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail101.his.com (Proxmox) with ESMTPS id A103ABC0E47;
	Sun,  2 Aug 2026 20:41:21 -0400 (EDT)
Received: from mail1.his.com (ec2-3-148-140-11.us-east-2.compute.amazonaws.com [3.148.140.11])
	by smtp-4a.his.com (Postfix) with ESMTPS id 3E32862;
	Sun,  2 Aug 2026 20:41:21 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail1.his.com (Postfix) with ESMTP id 1C62921306;
	Mon,  3 Aug 2026 00:41:21 +0000 (UTC)
Received: from mail1.his.com ([127.0.0.1])
 by localhost (mail1.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Bhi28kqQEBA6; Mon,  3 Aug 2026 00:41:20 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail1.his.com (Postfix) with ESMTP id 1FC3D2130D;
	Mon,  3 Aug 2026 00:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail1.his.com ([127.0.0.1])
 by localhost (mail1.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id LMBCKSJXAXBZ; Mon,  3 Aug 2026 00:41:20 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail1.his.com (Postfix) with ESMTPSA id AD82A21306;
	Mon,  3 Aug 2026 00:41:19 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>,
	redoste <redoste@redoste.xyz>,
	Fabian Stelzer <fs@gigacodes.de>,
	Xi Ruoyao <xry111@xry111.site>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] t7528: fix failure under csh
Date: Sun,  2 Aug 2026 20:41:03 -0400
Message-ID: <20260803004105.36913-2-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260803004105.36913-1-keni@his.com>
References: <20260803004105.36913-1-keni@his.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.122 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	RCVD_IN_ZEN_BLOCKED_OPENDNS  0.001 ADMINISTRATOR NOTICE: The query to zen.spamhaus.org was blocked due to usage of an open resolver. See https://www.spamhaus.org/returnc/pub/
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record
	URIBL_DBL_BLOCKED_OPENDNS  0.001 ADMINISTRATOR NOTICE: The query to dbl.spamhaus.org was blocked due to usage of an open resolver. See https://www.spamhaus.org/returnc/pub/ [t7528-signed-commit-ssh.sh]

Explicitly set sh mode for ssh-agent (ssh-agent -s) to prevent
failure when user's login shell is csh-like.  The failure is
caused by propagation of the $SHELL value from the user's original
shell despite the test and test harness explictly using sh, which
makes ssh-agent emit initialization code for the wrong shell:

> cd t
> echo $SHELL
/bin/tcsh
> ./t7528-signed-commit-ssh.sh --verbose --debug
[...]
expecting success of 7528.2 'sign commits using literal public keys with =
ssh-agent':
[...]
./t7528-signed-commit-ssh.sh: 1: eval: setenv: not found
./t7528-signed-commit-ssh.sh: 1: eval: setenv: not found
[...]

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 t/t7528-signed-commit-ssh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index b50306b9b3..7bf4a40de2 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -82,7 +82,7 @@ test_expect_success GPGSSH 'create signed commits' '
 test_expect_success GPGSSH 'sign commits using literal public keys with =
ssh-agent' '
 	test_when_finished "test_unconfig commit.gpgsign" &&
 	test_config gpg.format ssh &&
-	eval $(ssh-agent -T || ssh-agent) &&
+	eval $(ssh-agent -T -s || ssh-agent -s) &&
 	test_when_finished "kill ${SSH_AGENT_PID}" &&
 	test_when_finished "test_unconfig user.signingkey" &&
 	mkdir tmpdir &&
--=20
2.43.0


