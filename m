Received: from mout3.freenet.de (mout3.freenet.de [195.4.92.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C011187
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="AkZsU7DQ"
Received: from [195.4.92.121] (helo=sub2.freenet.de)
	by mout3.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1rJBaX-006l0a-8t; Fri, 29 Dec 2023 13:03:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eqHRjOd3NyVVKxws5eE7B/Pi/bzjErAaZPXigCK2Qu8=; b=AkZsU7DQNmFIJctJ4OEcVFVhPU
	yxgVqd8Mt291Tb6UGz7G5P0+GHNiQeM1pqGonrlviaI8IFXwUqJn9Q/iGF6q5VcypMtevlcjXR8Xh
	+meRU5y2h7hkRcv2JWJX0FtrKMnva4n4qyQcHeih4xW1BptMbazvYo+r6zzI8R3QApA5N4qmnF86/
	NB+9owiGlgIKtHofbxDdOY5p7Icx6fK1rcdZbigyVvgUDF8hD+Tkwz7E5JcX2IGSmt7HhBRFr5xi/
	ACpNQEtlVny3wOSZd+pfBTcWZAIpLjVyex9/c7GeOQXFpxofBzWmul3affeUom81m80dVztx1/Qr7
	aN+2oG/A==;
Received: from p200300e2e7202b00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e720:2b00:dacb:8aff:fee0:ca63]:54966 helo=soren-pc.lan)
	by sub2.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1rJBaW-002SgR-Vo; Fri, 29 Dec 2023 13:03:41 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 0/1 v2] Replace SID with domain/username on Windows
Date: Fri, 29 Dec 2023 13:03:18 +0100
Message-Id: <20231229120319.3797-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 170385142059A4807E1B0FO
X-Originated-At: 2003:e2:e720:2b00:dacb:8aff:fee0:ca63!54966
X-Scan-TS: Fri, 29 Dec 2023 13:03:41 +0100

Improve error message on windows systems, if owner of reposotory and current user are not equal. 


Old Message:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/test/source/repos/git' is owned by:
	'S-1-5-21-571067702-4104414259-3379520149-500'
but the current user is:
	'S-1-5-21-571067702-4104414259-3379520149-1001'
To add an exception for this directory, call:

	git config --global --add safe.directory C:/Users/test/source/repos/git 
'''

New Massage:
'''
fatal: detected dubious ownership in repository at 'C:/Users/test/source/repos/git'
'C:/Users/soren/source/repos/git' is owned by:
        'DESKTOP-L78JVA6/Administrator'
but the current user is:
        'DESKTOP-L78JVA6/test'
To add an exception for this directory, call:

        git config --global --add safe.directory C:/Users/test/source/repos/git
'''


I hope that I have succeeded in addressing all the points raised.

Sören Krecker (1):
  Replace SID with domain/username

 compat/mingw.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


base-commit: e79552d19784ee7f4bbce278fe25f93fbda196fa
-- 
2.39.2

