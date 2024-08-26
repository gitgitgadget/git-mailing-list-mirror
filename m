Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF613A250
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656918; cv=none; b=CmP0OQ8Irp0TQXDbOxPGS2tQatjQ/lFZ/e3qsbNYK2i5nlBlRKCSiRWyb4rwNS+uAlV04+vKP5wVFY1lYs3c0lhf234KhARQp2bFqxX2kh7OBp5BpjZ0VXshQXJSwUkp6xyiS3jvRR/dyuxB2oyien0dmZmi5pgoD4TIed9oybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656918; c=relaxed/simple;
	bh=SsAr+T+axBQeBUlg+/3oCyFA7+muobGM5hp3r64TdMQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnsw1Lsis86Qr6aOI1GFz/0bUvdzGkky2lktwblwC6hRu2dYJAtpTvm3NhlWG/pThr1zMcGSo/zHCN801PPNISbb0mI5vFMvoW+Ainl/EdJCGtEzFDwR1CUsZ0QQlMoI8mOjsh+rS2ovZ3DIy6uhMTvGpeCevMBfTvln5itmWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RO25Cl7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU2wS6xR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RO25Cl7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU2wS6xR"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EC04A139093C
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 26 Aug 2024 03:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656915; x=1724743315; bh=9t1Qdz+WyA
	4BWLYpKkikvCtMZ1yjGMYOihe8Ai7u/xQ=; b=RO25Cl7k1eQ1RvWJJZUsLImf9a
	rhOLys9ErT3agUOFRRDnTK8HAjuYXMKCcqAUjaoyfCGZIoVTUU8B4GRzWvhxLN2+
	HYYCD7zRMr3tppmpbm8rd2Ex8gb+9adwQYzN/r7HMQ789AHmaTZ+sD+R35fo1uT8
	zGN0D8AvN0hc5TmafbiCFdJbfESFoiuJVNW9lODrdPgzUx231SGaCTNTurLAaJnl
	vHIeArTrhibut+8806FGeN6lO9YAf2BPCgpQztKBCyPfmC87bUrh5mu03nYdx6//
	zal7TkZX0KFhYf4ST/YVZvf/IrAbjYMkzk4F5H1grxit02iQPE4eDsgnFx1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656915; x=1724743315; bh=9t1Qdz+WyA4BWLYpKkikvCtMZ1yj
	GMYOihe8Ai7u/xQ=; b=FU2wS6xRSV6L+7KsuIzUcLTvjGDUshRXQWPipP4ubc2V
	qK3qgMA17sKc57n1FPxA6jUbO96epwzGwrZhV1mUfUMgDsdixZKswxP1p4d8NjjI
	eaQml9kQI7bx1+13/9SJlVfSODoVkEY5s4WJ6NVlNnU1h3mHUvjgF6oic8RSMZu5
	ugR/57VSdRYjcVhELWhgdxGym9WKJ+Zbrp1wre71eCRs7rpWm3hfOOgdpzJz9bJB
	NhT/2e3vfCiV+oJ590zh4x2W0el2QVkqnNxHGvyJUL9J2ZguC8MadlvtYMTd99nK
	g4QsWjJ4HDO9pAuO0yhBNCupqz+f2xOccvcc2qmWTQ==
X-ME-Sender: <xms:Ey3MZgektS645FsqI2DKA82nP1mwTIitYyw4sr43vZC3Y1oWYhRiPg>
    <xme:Ey3MZiM9H6Uae6cj4dsvDHG0qhHYmYsX2qVzTOq0vf5Xq2jqaltvGwQJu1W6AOUS1
    nhDu2Z0CQOTKdpq1Q>
X-ME-Received: <xmr:Ey3MZhjS3gxZxTuVcVEHUwG1WQJMWIXgXAwC89LinkONLvOHJRXrgZ3Fsz0QqpWtO-Da9O_XlZzrTN9NPSvJLy9T8YTI27NdaGWj__xAQ_vj_wE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ey3MZl9wpG6iM4F5vghr1A76y5smQKuxNjYXi3eoXNhYBmnIGzi9Yg>
    <xmx:Ey3MZsv20A5fD6xqmd3kS3oJQd6L1Pcm54CgeMYz4KDrefexhoRQoA>
    <xmx:Ey3MZsESvhrirF3Jjzchw_7opKmjiSJKi0qwCChHIqSpysdSc1BhKg>
    <xmx:Ey3MZrPzUEJoMfCz7zaCzbNrQLY5loCsSBiJvL40wG2NbcWCt3rt4Q>
    <xmx:Ey3MZpWID7-u5tEhZnqC9WIqTZD_KHyFGmqwMfkdcurC8Cv8SYwhL2ZA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df8e5285 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:53 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/22] builtin/submodule--helper: fix leaking refs on
 push-check
Message-ID: <e3d1ac1712fff01d74d4c6ffdc1c04fddb19404f.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

In the push-check subcommand of the submodule helper we acquire a list
of local refs, but never free that list. Fix this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c    | 2 ++
 t/t5531-deep-submodule-push.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85fb23dee84..642a0edabf0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2958,7 +2958,9 @@ static int push_check(int argc, const char **argv, const char *prefix UNUSED)
 				    rs->src);
 			}
 		}
+
 		refspec_clear(&refspec);
+		free_refs(local_refs);
 	}
 	free(head);
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index f3fff557447..135823630a3 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -8,6 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.46.0.164.g477ce5ccd6.dirty

