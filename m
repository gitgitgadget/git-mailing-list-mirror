Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B885E23AE84
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034705; cv=none; b=rAky5O6mlQ1faYpHrg+VV0De7SdpZnLmGsivst+e8W2SlZwTMD+Tp5wnbv1YCZpwy4QM5PX6LB3HzDd6W//7vSpDiTTX+FjICFh4ToWLp2bnN/Z3IcIMEGe9UQfp7Mf5GG3UVNS+gfA+YsmZ2KVgaktxc+gmEB6V0AaGjcQPHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034705; c=relaxed/simple;
	bh=kh0P5MkQTDoLV1OAIMKaGboIpugtZOXFklCfAk+g5p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yfx9AELpOlyRFpWz6pm5j3kBnrQEvNl/J1iA8vWYZL+bhPQ58Zf38rQhcmkpSLuQquyfFhXHBJQ6RLgunEbEDJcNPk95TNjxNDP7ZybbFLEkpZ0+eHA57g36BL33nh7AcT992b3XBGbDek5gDZGO4pvfG5mV8oqamJhmIDjts5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X1/ibvYl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8ooEndn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1/ibvYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8ooEndn"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id E74661382BB0;
	Mon,  3 Mar 2025 15:45:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 15:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034702; x=
	1741121102; bh=RJFOuPBNEv0FugL+z2TH9PMjKkMihMJ7LTjOH8cve0Q=; b=X
	1/ibvYlpwYOuaQdFlU9yHJrdNoCLJ3U+f7v4wN/9NzqWA4v2JApSFJlp5KeST0/5
	bJNnmdcm2PjG2wqdKuNqR1M5gQuClRwG5RDy5OFmMwCi4XJSmACoAR+RLJ8xKAVz
	7J22NLJerDDPkgPojjaAtS16kDixBhmH7qzE54isXw/dgzPTq4LgVrQTg29IXhSI
	zri+ONMYaCaXahNiIzMf7VThUTVZ4dcLRwIAuQay4SrHYcA/BWvbrtZamo5UnZBd
	gqTMc5PcOeehAMbq6p6PcCTj3xiBPKVFNpkiQaR/+EE6WfqxRyqgUx2CB5yKPLUc
	l1YyNPqvX5NYF4LJ1rguA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034702; x=1741121102; bh=R
	JFOuPBNEv0FugL+z2TH9PMjKkMihMJ7LTjOH8cve0Q=; b=s8ooEndn9u4lF8mMD
	QERDVelFIjER/NhNbu/jHAJ4q31uAXowo8gqEHZNSZgsIzrqOhRmNjlOm8JGfjAa
	EIjODyj0I5uNsGsGlBEYsMu6b1jzt4Yge3O+9m0iGc27CWB268MmXi6MzE/hvRix
	5H4OUWdRzU5tKKCx5xJ5nPR9f3hkVotLb3JFVXfvk+F3Nke5HxB24w7DJsNGZIco
	wZepnb0p4zJD+ELQQem4nP08vFGsxY8RRDXBAYI8ttpvGpBaIxdsfj4rMhu947NZ
	QvuIG4ESV6Q3O60U2Jep373cCkFu090Iz/TKQNltYF5WRvBkVUOIiosfuc9Ostjj
	gRQKA==
X-ME-Sender: <xms:zhTGZ8BNJfqs0Dw7y0UufSTazPWxlPJkjwahPOKCGlrsjqEaUwo-Zg>
    <xme:zhTGZ-i2snrHKJIZ7s55m4-ac9r18vG92zZ2o19hgx00N-s4osdL2fblQ9xGgpA48
    5m1lrX6hjZGQOFs7Q>
X-ME-Received: <xmr:zhTGZ_morJOZ3134AxYGVxuPo0wWkw6hF5w8_gvDKl8V8bw_z9ETfPIij_CxbMedRuHeKjFlehnxLh1edCQgEi-GHFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zhTGZywUw_jSkSsTaj0AKizCErh3wydItboSjJ6toFEm1B52UOxIGw>
    <xmx:zhTGZxTjAixsRrhMe9KnIjOOIAUgOpfEGzgjg616t4WT0eON907qbQ>
    <xmx:zhTGZ9ZDlYRq3wNsZU5O7QWHXz0OOSewFtIGkGDu5A1PooAR7y3Hyg>
    <xmx:zhTGZ6S3ZR4xpbU0p_NsozVxArIHzyBGLGmHC-2JDzW5UcmUxLQCwQ>
    <xmx:zhTGZzcO9mkVgn1znolY3Gl1kHxjSf2fFuVG2BP3bv9pxg6O2AceTziJ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:02 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 13/34] apply.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:11 -0500
Message-ID: <20250303204443.360595-14-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index b124678b93..f274a37948 100644
--- a/apply.c
+++ b/apply.c
@@ -82,7 +82,7 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 	}
 	/*
 	 * Please update $__git_whitespacelist in git-completion.bash,
-	 * Documentation/git-apply.txt, and Documentation/git-am.txt
+	 * Documentation/git-apply.adoc, and Documentation/git-am.adoc
 	 * when you add new options.
 	 */
 	return error(_("unrecognized whitespace option '%s'"), option);
-- 
2.49.0.rc0

