Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A8235063
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422555; cv=none; b=JxEsgeg4zpZE9w1oGD3b6RSLZWYWJXGB5I5MXPAf2FZ6vwK2/iIs8i92anLV1evedjQtH0O4O/AkaD5owr7wsXMn4dFG+rEayk/ee7fa7I99wlfQORW1lypsFaqIxFxyLi0Jbqzotz+S+Ug1Lr/76xZpPhzR3zmMQ9jaV5D9KwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422555; c=relaxed/simple;
	bh=Tf32sVaxIDzVdZUY7mPXcJQzgd6hYTeC2kNs2UMktCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kn8MJ6MG17+MHDX+yneuemHpUTeV4vdZnRfqsJORmP8O28yRWzLSTT6Ru/iPQcrG6jB79z/Jwve8XEcANuC16YRxlsJWXkrscZAfFEASLNkKEfQs3Do9yfY8ZEGMcvCqaQl9n50faXU13M5uPp+5L8NTR88M0Cvc613kk/hNGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjTj7CBY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjTj7CBY"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-458aee6e86aso29613265e9.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422551; x=1755027351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/e7m55WfemLgvnNLENovLKwJMzjaSgkaTMwaJoQ/zk=;
        b=HjTj7CBY+0SKLQAwI0tSwGhCuatjeihYMqU/wE89VkJbawN6LzwPmgklVkVgZbWaKb
         XhvlqWtw1ZTothfe5NKc9QQwa2P0YLr5UthcwaYi/Su6m/idTdZ0lnKrqHPuP/DH7pb9
         L45/rrbhbOpdJun6J6d8j1ZLuw3KWCSHEhZdpKKZzFzMXktuCC7khx9BeTwgxp9Fxcq/
         U54Ld/d/V8IJw9nKzk4Lf7WszWCvEU33d6YRrF/QLpFFEXkynoaeruG9cLrTNB1YrMV6
         el0ph9Ri2+Fi8q1T7SLXjHcdCHRZiLQQQucrTOHhLkOnMCMISe7NeLABK7buVUiNSzxe
         e7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422551; x=1755027351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/e7m55WfemLgvnNLENovLKwJMzjaSgkaTMwaJoQ/zk=;
        b=XA/V0NW845d841AWj56bAMeZ3MrrBynf0zNCvHVcZUUaE/CNJGOKWrwnsndeghYcs7
         Tf5/u3X1hy4Y3brVBJ35qJCo3MMDCPYS8xCuO2We1gDpYRP3RqVa5cO48jXVKTq8/SZX
         1b0FlnUiZ3Gw6wqg4iHSliyNgObWhxOFMfnWOJxMuoqsY61CG/GbFr88i/r77nSm6mKP
         R/a5CtBRJd9UB76WCUp0PmOG/3oUyaGye35vXnFwoF1Lagw9pgCa9xRsX+As+uoJBOOt
         3dIartOhOR8i8+5pCT5kw/v/ADyEMBOsXJnc311jg2Of3JofwzpAYV4FnrwSqK5hiDc/
         ljag==
X-Gm-Message-State: AOJu0YxdpsBRS38rofpKKbuaOy/IutP/YgeB3pGGyDEI3F5y/6sBRUKi
	a075qyfXLTGrTqVFQUdmofE/+2NPCZQUe5ZQ8hgDfkyHlstkNs5cm0jM9dILlA==
X-Gm-Gg: ASbGnctW6OyexylPVkRUR4/UHdzGWoofIjeI6ULLUL9AclqyuLHXh0iUC1Msh0/rAMv
	UrL/rooGK2yuV2P7X0mr55HfWjQ2zfsncnw/wKMzrai0ZOiZ4ZTGbUDuKg4i4RneifeH5ojdBJS
	kIs83IeXq/y4Ul0vJlDfmskl6fJeyS0yMwUjenknKldiJ8ucrkYWkP+spDGC6W6OCUtbkZj6ety
	2ElvJbFxcO4AHr1ho5kcJaoDkgJEmWtmGFL8DsnYP/ItuEmlKXyVpihO40whFPZnFpfaN2/ykr5
	BU/FjIIIsbFqCwxXzEBjScliR3p2pfAEFbf3Zfdhsie0ALWMhL/VXFkwbOM69T71qhEiTkcj8mj
	S96D2ColnunsHOWnj0GlsLbc=
X-Google-Smtp-Source: AGHT+IFW967UTN4pcchIw2N/u4ohj+L56+Dh0TEsOq0LSpdK5KfDBDAJaIlhbDltQa1CnQP/CNNJRg==
X-Received: by 2002:a05:600c:1c9c:b0:456:475b:7af6 with SMTP id 5b1f17b1804b1-459e70800b8mr1099075e9.7.1754422551318;
        Tue, 05 Aug 2025 12:35:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm87563015e9.27.2025.08.05.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:50 -0700 (PDT)
Message-Id: <29b5e00c556a3d39fb9ca57bf3903f43280def5d.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:44 +0000
Subject: [PATCH v2 4/6] t6423: fix missed staging of file in testcases
 12i,12j,12k
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Commit 806f83287f8d (t6423: test directory renames causing
rename-to-self, 2021-06-30) introduced testcase 12i-12k but omitted
staging one of the files and copy-pasted that mistake to the other
tests.  This means the merge runs with an unstaged change, even though
that isn't related to what is being tested and makes the test look more
complicated than it is.

The cover letter for the series associated with the above commit (see
Message-ID: pull.1039.git.git.1624727121.gitgitgadget@gmail.com) noted
that these testcases triggered two bugs in merge-recursive but only one
in merge-ort; in merge-recursive these testcases also triggered a
silent deletion of the file in question when it shouldn't be deleted.
What I didn't realize at the time was that the deletion bug in merge-ort
was merely being sidestepped by the "relevant renames" optimization but
can actually be triggered.  A subsequent commit will deal with that
additional bug, but it was complicated by the mistaken forgotten
staging, so this commit first fixes that issue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 2def1522bd59..e1251b4e12ce 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4747,6 +4747,7 @@ test_setup_12i () {
 		git switch B &&
 		git mv source/bar source/subdir/bar &&
 		echo more baz >>source/baz &&
+		git add source/baz &&
 		git commit -m B
 	)
 }
@@ -4771,7 +4772,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU source/bar
-		 M source/baz
+		M  source/baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4806,6 +4807,7 @@ test_setup_12j () {
 		git switch B &&
 		git mv bar subdir/bar &&
 		echo more baz >>baz &&
+		git add baz &&
 		git commit -m B
 	)
 }
@@ -4830,7 +4832,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU bar
-		 M baz
+		M  baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4865,6 +4867,7 @@ test_setup_12k () {
 		git switch B &&
 		git mv dirA/bar dirB/bar &&
 		echo more baz >>dirA/baz &&
+		git add dirA/baz &&
 		git commit -m B
 	)
 }
@@ -4889,7 +4892,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU dirA/bar
-		 M dirA/baz
+		M  dirA/baz
 		EOF
 		test_cmp expect actual
 	)
-- 
gitgitgadget

