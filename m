Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA293CF680
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408926; cv=none; b=O39kptPmvZAVKY8oA8ehWOyP3AWOUNDyzeG9Z+crz+3bzq7bR4XDGEn+6AjKhyPUjGxa5AN0All3n+HugZst87JwgeiOR+wlG7OT/slrlgLyYNRqh6kqO6ya7/1w4AxWfeGbAks3wM/M8AwOOTnD340S6/51M6wmtvy0g/tOfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408926; c=relaxed/simple;
	bh=6YAIEaoEMrTe1a8VmN/zfsBH3RWdLatsVYJKadhEABc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPGhv70A+Z3tjVVhP+Euynjg76WyP36OkQPFqMrSXtIpJzkx9oFB6+YWEVA9H+xA1Hr5IW3ntjZ5fbIo9Rv7l1bUHjaTBcp5uulqPd43gEWl2ohttnrbPAPOC3l1jHLEl1EFdBR310kndk5/JAq7IcQTl/R5dkXTdx86FGixh00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZ+C2pnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deAfK5Kr; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZ+C2pnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deAfK5Kr"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 26B631D00157;
	Tue,  7 Jul 2026 03:21:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jul 2026 03:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408919;
	 x=1783495319; bh=cF8zrcrMGWX4JDGvDfFMYReJbmVzjekdbvcYglpvId8=; b=
	bZ+C2pntzLxArrLNqSaJY17eWnQSCA9Fstc1mez2g+ezEqdAM6z5DlcF1+RhvG2r
	jm5fp5tVjOp9Iw0SdqwwPy08IcnP+qL9Gys5jEtWvGX7J5djyPEvYJer5ZC9oTT5
	Bd2Rr8usoGw8NDv+qB5WIn4/H3lw/yI8bmybP/onwgR67efHWtSZLipJCIaT9IEJ
	iu4oCHySZyZXs8vt5WDJIaZ7ZqDDyFJX08vD2NO1rKTVELfljlmLwoIZKsxZBWnh
	vHw7RmyYAOgjoX+SPUgfKboqRAg53rt2y/J/bjdiJSuNNLBrQiiyJ/Q/AaQALen3
	SjJXcD7CYTE8GuIejJKzNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408919; x=
	1783495319; bh=cF8zrcrMGWX4JDGvDfFMYReJbmVzjekdbvcYglpvId8=; b=d
	eAfK5KrIGti9ClKFb72mxnfDQUBYPAlORks+8w0L9lVMKZ6EKS7gTHfjPLBEqEAs
	nkQrESDx/GSMJuTTRaQuVKgfRAUAMXadUbgS8aHcP+bLHuTAZFCJGrUVCC56OuHg
	HqqV9AhEf9flebppv3plGqKPx4Ubr6xsZqMKKs9GXX3sYr087BEQtr3ejn4ljUxT
	7ORoPs9G9NpnjkGpVxGlI6+E6bLqWE0EIBPqozwVq/dcSkW3YdI/ILsgey3O7PF4
	ni7NBtR9QhXs14sAN7HRAXYkIk4Ww/d8I/wmKniRu5zXMCwjqciItkN/6nUyTQu4
	LYHVBkSfEXys6jNdSeSag==
X-ME-Sender: <xms:FqlMaqsf7V1RBUc57HvQvvbuB_TM1c_fhYm0rK2B7deu2NsMbqWJGg>
    <xme:FqlMam4V4DUiqATM2eWGN7T3f1tbyih9nEuEqNB-DEJ_54KZWWPJWmAaKfj9cbGys
    BaDTyvT5QDBD3EMicJB8QeUsuQWSj8O5_tylcBIltmqNfa3vL9syQ>
X-ME-Received: <xmr:FqlMajL8j538SpoSwwY1xwATKGIfui40QAo_v_uhoJK2sU_8Rwb3yAkRD-ImJAakmmUEH_SwlPqI0NOO02BzYtItOuHhm5LWbUliMvSwzQ>
X-ME-Proxy-Cause: dmFkZTF9s1z+R9IDFklBRl7h9GjFLDJ03cHkKgKpbIKlsEzraDKIRmHnCjNpIBHFaoa6yB
    8VUMsHz4gLB39bLxUA9y0k9QvCt+TAdxb4jLt3bqM6YVhX8COg1a0oMDaNsxRozyNzKMSh
    WF3bX6QCD2fDFJT7zh5jFCEYktMMg8SyP2bX8T8UEwiRMeS8hDARJim3Uy/lQ2TUVjBXpW
    dHuqY6+bjO4ZMCmiI7lwz4eTCJqG+g7dSGfb69Js90GWGqbIYAiupNiOKizKmPo+RWSIX5
    9dnMRohxlan4Qb+w0ZbrgqtSZzBv9fT1Sv5yBO2K2J1V+p+ZDgj72gUUbncVQN0AW6mQFv
    YBdJgXodsBrfugkcsFnLANKyH+8PZxFM2+Jew0gPAmUA69uprbHyxm9OcjlDUnaxBCSK1W
    F09JF6OX6QoD31Z9gv6bQrfsXBZytAiyOmznA2k9cEc6lNcWCjfNBWzgdZFlFkjAJEVxXe
    4NwyYJAq6zxe09pqhOQm7WsehpujNFW8xOQEXJpwrbxRGHviByxerwD9cy2c/A8vTQrh0o
    ITlo8G/MrohPYNsOY4C7bn7E+AsL90MOS6wYoMyG0TeX9O1qoAa/TCbBccvPdKDkKRP82/
    8uaeXWhpXUsld0WByZ+pVdHx0ObrnD4jNzm2elK21wjKY8MmONKn2eW/hkJw
X-ME-Proxy: <xmx:FqlMau7QxTX0cZwFvWC7Pux3WjkYexDzXx0YqAgcTpNS8dKNkYgmlg>
    <xmx:FqlMauxEuQjCEq6rXCuZYxruSh88aj9U9QyZXJcKU344X4Ha6eNmpg>
    <xmx:FqlMaqbh72YXpRl9jhZPeLgK5tIML4YkCQ9JgK_X6OcQMnT3X4ok6w>
    <xmx:FqlMaoRBub8PzljdGMJvTZfgfxrgeOY6Mxk2SoW2-KCEBlGa5RUp5w>
    <xmx:F6lMai6Vx4JoiWxWaenexYjHXLA8PHhR9qi95aIrcyoBn5bGmCnhPUie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 134b8fb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:30 +0200
Subject: [PATCH v2 11/13] setup: drop redundant configuration of
 `startup_info->have_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-11-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In `init_db()` we set `startup_info->have_repository` twice: once before
reading and applying the repository format and once after. This is
redundant though, as configuring the repository format does not rely on
this variable at all.

Remove the first such site. While at it, fix up formatting a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index d4de8c2900..088e7b85f7 100644
--- a/setup.c
+++ b/setup.c
@@ -2847,12 +2847,10 @@ int init_db(struct repository *repo,
 		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 		separate_git_dir(git_dir, original_git_dir);
-	}
-	else {
+	} else {
 		apply_and_export_relative_gitdir(repo, git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 	}
-	startup_info->have_repository = 1;
 
 	/*
 	 * Check to see if the repository version is right.

-- 
2.55.0.141.g00534a21ce.dirty

