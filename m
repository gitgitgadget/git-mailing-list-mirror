Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558595304C9
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183626; cv=none; b=Su9acthGKCc9SqEo6EgaUc2vaiSuYk+Cs5xiC5zzsSgTzF+X4d5BbA3RMx8pQbEJd+gb+RcO7EyYLthwusJ1dQ1aay61Fhn+Vba9ZqyTLlISqQ4py5VQ9I9hbgc9SuaCYL0GE3yxJGty6Etvzmku16IKstrVy2w9innm+OMVOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183626; c=relaxed/simple;
	bh=0KUs/g3EaVSYDMJFTHKzY+w//LRZ/UP7NDqhhs3Ml4Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QDbq1iQxGhSqZZaJvFbqbzRFxxvH8PN6vEGaHBdrstp92b2/jyVPiNNe6QVWiIZLEOVMn5hJDdP+5JiS2n6oOBIwYeSFfkVqdF/lqnedcxYN/kaxrW3cxLe1uu2KB2/xVxN7FF/h6/e8mrUw2NlZCDEfVVHshqn2J+QdCJ6/RDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX+1gzvS; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX+1gzvS"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0d298caso830676a34.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183624; x=1790788424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cpc/aNOF/sdDa39bjQLTWbxBV6x+XTtxgKc3dYNdV1U=;
        b=iX+1gzvS0olV7tLjyUG7Jk27R+NAh29hJFDA1NHKj09QfbiMFWAPZJS/SsdNqXjsYj
         SxowpYMvDmo0rxY3V93im0yo46sz7bRb47xJINn126OiENDc4MgRN7T34xqq1wyhJpkO
         kRdS1E9rYYST94Y3RKG8p5ZCDNQfhu2WzNFEws1bYq2o+F1BmtoM7Obr6OM6/mFBrAe4
         5sflE6GsqUs1aqPMnIn+KaE7YaTIVDqJiP8oI8ZtLch6bHQwEIu1SFrx50ZEA/XOvyTu
         sdR5LgUDQw3BFACVz5vNTAMmRdmaXXc733/gKdIZ31bZeTGSp8cfrg8Xrsv6xkVUYmBO
         Egmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183624; x=1790788424;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cpc/aNOF/sdDa39bjQLTWbxBV6x+XTtxgKc3dYNdV1U=;
        b=DLW7lnEi8+Gq9QoMBrccIySU0KCn394EUVmnv4EPnOiYu+kUY2FWxtO+IPB9dHY6jL
         WwjLYQsv/aPp/Wpx6suPolk2gM+jkZxraknZ8ENOVgVDtbjuCjYV4w6XEe6Xr0DkvF/1
         IqB9vNOmZmWs3FPXAfnfZBPOh/6A7Ah+4FtySOukwrbNk8VetI9RBSrwhSJeGoqj4/8N
         g+i/quHAA0exGxi9ahaLPEjt/Vm4uVCojmhdZWcRn869IY21PqY/ODZ3zqWcgugJvoPm
         6x3Qtypj6sgWc0ygcuEEh9ent3Qlq4p9nH1DikE00qJqxpQwxmn/MqQdg/vpOhVF/TPB
         YJhw==
X-Gm-Message-State: AFuF++l6uWv2QS1pPEXeZH8VH5J1XdsUya/z+0yclw17IVo4FgyN8scK
	xt+dIDQtClPr0D3Gc3qHsmx3KPDIn2qUUC7Y2CAVeJR+sRZx6tL0DxO5ZfTXaunS
X-Gm-Gg: AYBFou3G4zU5/vLLUmRQIfYJTMBbpPKX9EJuC3tUVltz1tUnLg79q9qBaOKXx3qPr2j
	Vdc9j6PDPy+spaut5wmZ0EsCY8KW62/AEM8cRk3rMojIm+nFtASRHjFVc813xuAuK4n8ZpU4NTd
	eIF4RKqqD/B5Se9lRlb1yk8GlTB2Lf4+CqP5njdoo0SElAAHnrFXfPcMKwpyih1VLFrkPkoA0jp
	sVdGbs2NXDeCvJMsjxoD5cA343JxCrCBYjiGazbijKXxp4Dr8ohclDSXhrWOJhMhldgDffG5CKw
	0RPL/Z0OUHkgPH8k/dJjKvpieVOK8iwG4JUF9dhgwgi6bLYzHjTWtwh8xM7tuTvcKHiv/Nmt+ln
	9g/ZIcNi29i1vLyj8snjE4L4/s0nxnnExRSVw0OFAcazIhe1Hx2pkj7FcrNdov5o4SUQQxXlo3c
	XGv2IsVuMJUR2ZnkIl4EOHNiYcc0ZP5jL69E8ne0pyqCmVGyrBIpDa4/2rUoY0pHqvp9bY7K3vL
	jf6m74yHw7xOeVG4++c50+4PGFsaig3ctigof8QxVhIKsBhkMR6JGS/i33gDpmg4qUe3DUA10FA
	zf9xtc5rSn0Ji6POP/SFmglQyLOLEz3NT0GX5WcLFnHgmz65KJyZ86sEiYn40IyiZyCO8Uct9N1
	1aP+rA+hfqt5etjgiLIN9eO0+kMVI7M+vRsOL30Rd0UwWwC3mYvCfSavmuIo=
X-Received: by 2002:a05:6820:1798:b0:6c1:dc9f:ab2e with SMTP id 006d021491bc7-6d2d0e17bfamr2975219eaf.27.1790183624172;
        Wed, 23 Sep 2026 10:13:44 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce763f94sm2972392eaf.8.2026.09.23.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:13:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] ci: reduce pressure from large test fixtures
Date: Wed, 23 Sep 2026 13:13:27 -0400
Message-Id: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwrCQBCE4auEXtsQJ/ExXkVcJJ0abZFEuicih
 NzdUZdfQf0LOUzhdKoWMrzUdRoLtpuK5NaNV7AOxRTqsK9jaFiUH52VPcMzG3yaTeDctFEGibt
 0SEcq76ch6ftXPl/+9rm/Q/I3R+v6AXIrhSV7AAAA
X-Change-ID: 20260923-ci-large-test-resources-349cdc95f7f8
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

Linux pull-request jobs with the long tests enabled hit two resource
problems: diff was killed after git log produced its huge output, and
large clone and repack tests hit ENOSPC.

The first patch compares the huge output with cmp and removes the large
files after success. The second sizes Make and prove parallelism to the
Linux runner's available CPUs, following the existing GitLab policy.
Both changes keep the large test cases enabled.

Prepared with Codex, including review by a separate Codex agent.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      t4205: compare huge output without diff
      ci: match Linux jobs to available CPUs

 ci/lib.sh                     | 4 ++++
 t/t4205-log-pretty-formats.sh | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)


---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ci-large-test-resources-349cdc95f7f8

