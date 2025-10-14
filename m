Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E201DFCB
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444939; cv=pass; b=DPbI4etZSE48T+Lp+UPit7Vrtm4g8FSp+XhpeCpiUJz28BnS44yvOOuvfcu4Gm9PO50/jnTbcC3hi7GLkr6OH6rcbk92G/nV5f0NI0fYRBMppv4A6qi7q4k1X1dIMEcQDdXojPwnbj8r+cM7ZqRW51GY7ryHMlTOCjWqaF6Dl+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444939; c=relaxed/simple;
	bh=ghROFLHUdKgL/+1UR5RJTQbzobtsdD+Nkw3hNW2xJHI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkfybQx5kdxd+opslt4h99JpnmYJRudEvGd9ZJiwXYoLheHz49PAD2jtp392Tav4LO/RPJgnUgj1H1EKN3uYJ49NwDC+oLOJbVkwyW0X3RVEsy/MMmJheKOGLvBl8FERG425c8FJciNnZswzfk5Xp2r2ahV6R8VXEBnW4KJfMgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=RIbvVt9M; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="RIbvVt9M"
ARC-Seal: i=1; a=rsa-sha256; t=1760444781; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U1Cgfm0iYasRMjfuz6F+7GQWpjuoW4ZYjSuEeDCjkWCGLX+RkyFgMeodKChKo2/Du54eQetR48S13A8eDdhftVYNhOT7xAGUBWBaEjCPkq7HxhOB2pSDiiGyfIf8IElHcCqhXLj5S6+IvRu73+QJr3SUuExkDcjQqPOqbJ+3vms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444781; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=LWqZqGyjkznhaMN5nMZs4GfNjXk7lwmtCUL4fo0f8go=; 
	b=AV3QxqVfbdB5AZuz18RxERWULpwku/wDmuk8wrnbz+5M4hBqIL0ODV5eZUG0a+nWsp8VW4raenoQqfa6ezv6GdMC03BGVYt2IdCdODVxfboDSDkjgn+haszjbrfiB3pdhDMUW67TWbrGR4pO0lnog8/d/uAv/0nmf/igksISixE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444781;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=LWqZqGyjkznhaMN5nMZs4GfNjXk7lwmtCUL4fo0f8go=;
	b=RIbvVt9MAAeT8IEeC+Aox+7PzhRaIfoJPs0VVQAfYBO/OHrG8ejEZFq6P+P+JX5f
	mrlWY1r4Rmu9jYuBRnAOj6YomS8t8Ps369k6OYDIu8P7pVg5IVpFdSnNjMGbVYOEDhN
	i7D8ujO4SF4bwhy4NBWyJ9ENdAT15WPCdt1/8fNE=
Received: by mx.zohomail.com with SMTPS id 1760444774716110.36251281875741;
	Tue, 14 Oct 2025 05:26:14 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 25/29] tests: t3440: test --trailer without values
Date: Tue, 14 Oct 2025 20:24:38 +0800
Message-ID: <20251014122452.1851103-26-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Added a regression test to ensure git
rebase --trailer accepts trailers without
values while preserving the separator’s
trailing space in the recorded message.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 36f11f579e..df121efd0e 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -50,6 +50,16 @@ test_expect_success 'reject trailer with missing key before separator' '
 	test_grep "missing key before separator" err
 '
 
+test_expect_success 'allow trailer with missing value after separator' '
+	git rebase -m --trailer "Acked-by:" HEAD~1 third &&
+	cat >expect <<-\EOF &&
+	third
+
+	Acked-by: 
+	EOF
+	test_commit_message HEAD expect
+'
+
 test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
 	git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add \
 		rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 third &&
-- 
2.51.0

