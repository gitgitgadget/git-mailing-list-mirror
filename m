Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C41862A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906390; cv=none; b=AObTIbgo/g+NW/Oy14PkTnevCEuUyBPO79vbCIQq1qn9qgYz9Gmj44HTMp5S+uzZ3DkD07CYflDN98PbCUUpURTPirUDMa1bM9rpctdXOgsEatJ6aIgbVMsDdzgpcM2DnAKmFG9J9ZxESD5UaTN7ZPIuoqjdYUoF22iV8EdRseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906390; c=relaxed/simple;
	bh=cjW9wITlyoZQaFD9dXvn3MN48Hrhoyn3TOm819CHTLo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqv2HQ3iTj8noPZxA3KFk//Z8oxAXeQ09gFor+A4lu8zieds1HKh/IraqNdMab83DlWAoN31kiBe+YVlMISbqZWKPis5y7Iq9EY7zv3Bp9s7WzdohXg3Uek9KpFwx7C4nmdX8Q+GEctVtidBqkjphpH4zv+67b9ihJzn1P/ix9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dd1RXemv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dd1RXemv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D490D1DC52;
	Fri,  2 Feb 2024 15:39:48 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=cjW9wITlyoZQaFD9dXvn3MN48
	Hrhoyn3TOm819CHTLo=; b=Dd1RXemvbun8Ogr6b5PEZXI6ntVaqw88eQ6ADn/HF
	39qN9XYBjBnRRr6+jRNu5U4mc3E6AKCVbQ3dzk67wl9kg7sEY3WgM5eBPlNl2Dt1
	jw5USfIujqW9Aj/AxcGk1kw3jxZwBCwdz3sPRJ8Pj8sYqeNq19nW0dh/cMcaKSsH
	vc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CCE0E1DC51;
	Fri,  2 Feb 2024 15:39:48 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A8B41DC50;
	Fri,  2 Feb 2024 15:39:45 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] GitHub Actions: update to github-script@v7
Date: Fri,  2 Feb 2024 12:39:35 -0800
Message-ID: <20240202203935.1240458-3-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-522-g2a540e432f
In-Reply-To: <20240202203935.1240458-1-gitster@pobox.com>
References: <20240202203935.1240458-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 32F7D57E-C20B-11EE-B3F7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We seem to be getting "Node.js 16 actions are deprecated." warnings
for jobs that use github-script@v6.  Update to github-script@v7,
which is said to use Node.js 20.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 90973f9693..bb857bdaf0 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,7 +63,7 @@ jobs:
           echo "skip_concurrent=3D$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v6
+        uses: actions/github-script@v7
         if: steps.check-ref.outputs.enabled =3D=3D 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
--=20
2.43.0-522-g2a540e432f

