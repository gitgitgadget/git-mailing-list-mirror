Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00D2E2DF3
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479064; cv=pass; b=uAmFGSCOjIV/3+NVkqbhsEYof8weKHRCx1rHTx5HtWaJl6dShpCFVsayCNyTb/8m5WXCiOXDlPt6c6CCBSVA6rjqnjh4tzCpehoYPRWwpZwQvEhlZtJ8rwp5rhV1J/PbBcMXoQUHx4yefNGroeny38ClQBMyzXQhCIWBdTFvNDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479064; c=relaxed/simple;
	bh=sJwHVjtyk8WmOHuTuuGf0/95D+YgXoYiAzyV91JwYIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmvgcCR/jvzmy69v5vrVV7LK30JbYtHIRQD9K9wUBJ7+0Ghx9358zqVfKxL9mRaGkp9ZgmjBi3byorJcxCl1SQdgiT0usAwKelLt1jXWemUhAFPTtTKWD93/NZIxFwK9D+j0PvNvoFxL/0U7qeUYdRbBlwhuUq0MBJsCZE61N8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Sc0cICll; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Sc0cICll"
ARC-Seal: i=1; a=rsa-sha256; t=1772479048; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=niLQ0eVqtV7gL8kjnRGlZgDg86GloYq/BYEFFJQeUoSsX7KiVAljh9vAMFSLN4hryv6q15fEMkeB81FCRrP02abvhQodHEjPCgzFZkbt6F6I0dXvjF6ksj67wifodmuB/L6VQlflEkDI048e/LNFbxqoNdg6PKO/zYXBOCrAklQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772479048; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=huA+s5NGgJAj9wKk/8Js+BVanl+GXcwYkoHXBnKu7iM=; 
	b=gTA6FeJ/3MZjNDKOEWqdfUN5pAxO0HGTTh5tthUP5hi2sPV8sAj3OlY2EreCeAKsQJ/7EU8Q8szklkU7/OYCUprcutfIttHEVrsQU45eUxElaO7LvSZzbMicV8f0bf56xBwQBzyXjEg9HcBjwqMb8PWml3K6SVR/WdzpoYlxplg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772479048;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=huA+s5NGgJAj9wKk/8Js+BVanl+GXcwYkoHXBnKu7iM=;
	b=Sc0cICllgtJuYT3pnOWFur5DXbTixNmn5zkpFi+WWPAITECA4C4/kmzCqiO9606s
	w5E7aP9blTiLM+clxqASYwQuFrxiuM2eLWKZZ0n4s4CtSjD4Xk5KkFcZFjtB7kja374
	4DE1D+Qxb+oOaeNxTnVJUi6VOVzzYOuAEEc/NRq0=
Received: by mx.zohomail.com with SMTPS id 1772479047500888.8177306149424;
	Mon, 2 Mar 2026 11:17:27 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Jeff King <peff@peff.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/1] Fix update hook perf regression in next
Date: Mon,  2 Mar 2026 21:17:03 +0200
Message-ID: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This fixes a performance regression I introduced in next by
removing the "exit early" check for hooks which output over
a sideband, during the conversion to the new hook API.

That was unintentional and these hooks should continue to exit
early if no hook is found, to avoid unnecessarily spinning
un/down async threads which no-op and just add overhead.

Reported by Patrick at [1] and independently root caused and
confirmed by Peff who fixed it in a very similar manner [2].

Pushed to GitHub [3] and succesfully ran the CI [4].

1: https://lore.kernel.org/git/aaWeSu-d1FMz_sW8@pks.im/T/#m4a1e62b3149825ef03f9b5b48f478933abc521cd
2: https://lore.kernel.org/git/aaWeSu-d1FMz_sW8@pks.im/T/#me0d2655bb53f5ca8fc8f31e5726ecf4d2971fa11
3: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/update-regression-fix
4: https://github.com/10ne1/git/actions/runs/22590151068

Adrian Ratiu (1):
  builtin/receive-pack: avoid spinning no-op sideband_async threads

 builtin/receive-pack.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.52.0.732.gb351b5166d.dirty
