Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB502188006
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942777; cv=none; b=Q3snBMZIVde2jIk/DOJ1hMoTSGu0WMart6crZ9T8QH3zy/JbQv5/e4jqL79Vjdqub7IrkjSw2zaokITUxGvTh8hkCJeZxAWwvnzHHT81SE3KmVV7/zAF1BzLZ3kMI1V2nN7s3viVEd7QPD/wIFa+VYuOiZBK6/1WB7PZjYXWNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942777; c=relaxed/simple;
	bh=DhyiDYy86pRCdXARJvGHMOrBDpFSoYfesa+9ji0C1vY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHvPwZADy1b3+OmQEwKWNFv7ryskRP94LEQBh1ozOL+8dzxMMrwi5s06onKJV6aaO59E3AMTbUxwWG1fjB+K5jSxgXPTgLJmf+LRPHNI0Jq9IGma2aE+G3OojTbvmKX7fgyeuj26w4F5n5fsqJHvQNlw8yqXsTbM1ZFSb7qSpF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z7F4OND3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IISXrlOm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7F4OND3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IISXrlOm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C8A2CEC0A02;
	Mon,  7 Jul 2025 22:46:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 22:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1751942773; x=
	1752029173; bh=vJO1snPavH4aRyzrQlCq+OM+DjaKiKZ2WesDYkUWPO8=; b=Z
	7F4OND35R3Tb1p1+McS9+Xb5b9PGnVQFfzc06ZwUiMKFauin1E8HQqOyEmdva3DE
	pYIqh1yxTbkqNmuCEoL7uSFi07L0Z2yaqlbYiH6GPI4ifN85r/qsiliVqxbCtd0n
	KtYzwPan3YWqazRSMWgweGBiwQIFe7I1onj57CLXDkChUY7je6yNQ0wBARwvoANV
	gAAy00oxsfjxP0nyRiOaj70B2jDAX2L54J4V6wzpr+oL1fMAtHee8M6pmfuVd9bA
	tJSaW1vZUQTaQBQV72Huch18gemiIVFXRbOMQBKHR4PMnnktaPaDWCBLPULNZ7Q0
	Dlag8DHqHlLsx9Y3GNuaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751942773; x=1752029173; bh=v
	JO1snPavH4aRyzrQlCq+OM+DjaKiKZ2WesDYkUWPO8=; b=IISXrlOmsjd58p34P
	KyATrJKuFVRT2d13M8YAkOFd96yT1AY9/u+8xaM/ygAmr+GrseRsUfC/jksgwayk
	yaNRrO5QVKi7lJ9HuM7qoVPkylYA0UKxtGbDPjgLMYqkYDHsmP/6cK0Vap2u98S3
	6usbM8H29BVnymjEOW6CirvFIQPQ7Co6FsGqpmHfjenWyr/vf6Ia2jXE9Q9aJfUK
	sYcAVDMLLMH5o5I4lRrgl8cJpbN/tPhkLJN3HD6s+1x5JCEYzhIppLXR0pcpXxY3
	7xtzvjcl8O8HyMa9XvifJjV6M1M65YsWR+rzSbbQfyTUZq/PSEicQe0SQBqvh7Gb
	LcOZw==
X-ME-Sender: <xms:dYZsaIwnUDALcpzRO5U1QjzGAoq_dbwkRL0FSCRat5TKCZQ0vcxUXw>
    <xme:dYZsaPimNqeT_0CrxISOjHeoaxVtIaZM7xL4kk5u6G7Tk7Ks8GqVLdvPXKXowJK8f
    kA-bD6zyJi9i5GdqHk>
X-ME-Received: <xmr:dYZsaDxrsjHsrZBal8jPHurgmxbNE1atAzYlhJBVHHjba4h0kbN0TMERX7yo-mP7BsgRwXkM_Ga3W7-DzKt24GdE5NTa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheptfhushhsvghllhcujfgrnhhnvghkvghnuceorhhhrghnnhgvkhgv
    nhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepuddukefhhfeuvdejkedvfe
    ektdfghfeludfftdetfeffhfefjeehkeetffduieefnecuffhomhgrihhnpegrnhihfihh
    vghrvgdrfhhoohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrhhgrnhhnvghkvghnsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhhhrghnnhgvkhgvnhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dYZsaCIMAcOprD56xLE-YAUa2jUNGB35Tt18n_FA2vO8moqR9Qd_KQ>
    <xmx:dYZsaKQ3Qq4JJ0QpVlsJisbXTDGGHXhaGx6Ry-BuNGVgVwbF5ZLTpQ>
    <xmx:dYZsaKoSMqEiwV_Nc4Vb8udtCiV_ofnnB8P8FoENUO3ljqsvYSJ3_Q>
    <xmx:dYZsaPpu_aKt9Dyo9MhhdG5FdYAjAChshloVcCBC0CZcfze7thW8EA>
    <xmx:dYZsaPFNEspxvuTQypLLNGXHmy53FHeW9kzIld1SxxoE7lme5yyU1fCz>
Feedback-ID: i0f414978:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 22:46:13 -0400 (EDT)
From: Russell Hanneken <rhanneken@pobox.com>
To: git@vger.kernel.org
Cc: Russell Hanneken <rhanneken@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] doc: correct doc for glob pathspec
Date: Mon,  7 Jul 2025 22:45:07 -0400
Message-Id: <20250708024507.62386-2-rhanneken@pobox.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708024507.62386-1-rhanneken@pobox.com>
References: <20250708024507.62386-1-rhanneken@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1751941709; l=1476; i=rhanneken@pobox.com; s=default; h=from:subject; bh=DhyiDYy86pRCdXARJvGHMOrBDpFSoYfesa+9ji0C1vY=; b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgTs8oZyN/nfBJ87o+Tlc5u/Nxtl7ny ZIuQPixFr42r4AAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA QLSQ5k8FCVXSSYfHK7I5EoJIZ8OZnMpLzKR/XGHr1Z+T+3lpvkOBwO0OJiZQD4i+up6t9W91Ccp 1lJwiPA9c6QA=
X-Developer-Key: i=rhanneken@pobox.com; a=openssh; fpr=SHA256:v/6QpakMfHNAgYOscb6FKcF1QCobNpfcaMKw+5XDMpM
Content-Transfer-Encoding: 8bit

gitglossary documents Git pathspecs. One type of pathspec is the "glob"
pathspec, prefixed with the magic word "glob".

Regarding glob pathspecs, gitglossary says, '"**/foo" matches file or
directory "foo" anywhere, the same as pattern "foo".' That last phrase
('the same as pattern "foo") is incorrect. "**/foo" and "foo" are not
equivalent. "**/foo" matches foo anywhere, but "foo" does not.

This change removes the incorrect phrase from the glob pathspec doc.

Signed-off-by: Russell Hanneken <rhanneken@pobox.com>
---
 Documentation/glossary-content.adoc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index 575c18f776..e423e4765b 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -418,9 +418,8 @@ full pathname may have special meaning:
 
  - A leading "`**`" followed by a slash means match in all
    directories. For example, "`**/foo`" matches file or directory
-   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
-   matches file or directory "`bar`" anywhere that is directly
-   under directory "`foo`".
+   "`foo`" anywhere. "`**/foo/bar`" matches file or directory "`bar`"
+   anywhere that is directly under directory "`foo`".
 
  - A trailing "`/**`" matches everything inside. For example,
    "`abc/**`" matches all files inside directory "abc", relative
-- 
2.34.1

