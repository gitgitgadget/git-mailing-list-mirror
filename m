Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17824416CF3
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599461; cv=none; b=LGItmN7FwcBn4gasPJvRHEH9pHISm4wkEIWQ08vs4GbBaK2iW0SwUVjMgo0rCKW0uuPFis8+imdMvSjAo5WUvjjhqQU3UdU2oJkaY9EwYCrNOAjH7bqFkj1bfs3KZuVtXVsoJ29JAuc0Z2UBgQv1jUieywsHMvNUk9Qd3ChnuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599461; c=relaxed/simple;
	bh=iEZ4su8vjql91K+2TfmaE4VZw8trk16dcFl6UfG7eaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZcpjQvxiG3bnNmWyOAeGH2Nz+MqOdUOeC/Zy1U/u4L8IsmprqadbGqHlhaOfkW0jvaSwVjRqMX5l9EbebDSuYo6Wmks2eNAkia4MWdxaxsHgqQjk4QEHEMJuvTQgshPyCEpcg7qCYQVKBtRm9g49llHLpYUNe8s2Z05iTEAa7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GawSrW9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dspz0o0p; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GawSrW9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dspz0o0p"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7038A7A0149;
	Tue, 16 Jun 2026 04:44:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 04:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1781599459; x=1781685859; bh=BbPzfQKUKE
	qm0ETOCByUugIIEb9o6Ko2Dm/zfqKq9Dw=; b=GawSrW9RtCtdkRmNMpiFsltn5z
	9H+nIbmBLoQ5TbLF8dH/2PTvMyB/b1/e+C3GP0ilSTKXEJg0VposodvvVks58O05
	GmnqQJKzJ0sWdK7U6brH6YdTr2kEtGRn7GphceiKOks+Qsb3PvrXeaeg4Y8wS2ug
	YkXK96RsX62S9AAwQdRH4pPRBXxedPL8HKwLhNlAHtDbF4EKBPa4rR3ypJA202A/
	rV+r2QIVKTXA3CIgea3ejhYKwYZSm2OH3dTqVgSpvNHDMnu7WKLj2JkYQoVbxNik
	3+D1oYvqJLWs0QCl3hdYp8r8jiT82E+UimICPXRTqidyvFtxldefzht4JBbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781599459; x=1781685859; bh=BbPzfQKUKEqm0ETOCByUugIIEb9o
	6Ko2Dm/zfqKq9Dw=; b=Dspz0o0p2h0cu2488SiLinFvMtaGQRncBAaQg1Y2ZiD5
	BhUWlDE7eB1lPhFTKjIN+EnC2Hp0SOLbhW/f2l6NuPr88s5GQ3ZD+z9pvk6BZJ80
	a57bUI71qbO6GWCcuIEiaBhABGqxrnY0itRHMBNIlU6DSdxZrPI6cfZIHcSmL25N
	zjtC88HRDJ9KIpdKWVos2e5xFpSmkB6bFWNXeFgtNLkX3+lIZuXFcRJmAghTGhhl
	+D8sdNrWglwNoEym+bYBqTtTdZkQ2I8QZ0tqSIABWXe+MznPZvQzFiySoA1Tk/RI
	K4bRCv+PUIMcUDiC8F6ommjSc20ZPKskUjHo9iBMnQ==
X-ME-Sender: <xms:4wwxalH_ydikXmuUvYLuAveyzh4ZfCkO-tkjyJ9Xrbv7fEhJ8jHSjg>
    <xme:4wwxagUbpD41Oke1WeYDHkvgBoWe-nEtlEa6OZZZMrKsHW14R-VF0bsuGlsEAF4j6
    mumGCAxUD346XaVK5dlOOcdBnkFbumiXwcoz-U88Qa535Flusjbsg>
X-ME-Received: <xmr:4wwxakz1Co9yPIm2woB8JBLnUpUD5MeCM0lwa07c0oepAQX7J0s-k4XnQQThMOjNSCzkPWYgIA_SinKovuJGx8Ou4dqf-Biy9u6Nm7E_yxZKXw>
X-ME-Proxy-Cause: dmFkZTFksDWBJfRY1MYUkZTgpPAXNFRcTvCTxTlYGo26olBEjoItaFlyktUrmSPaqw8KUL
    uFhKI9m3iObOMbrHbbLXyap1RUkw/Z9TxJ02yab1WpR6H+2q36ZyG5/BkyfBLU2M8FgmMu
    SFrDeo65mb8BdEN9tO177Fy4rrTT0S3IQyu2xT0skvIiIKrE7Y2kMEMgl4IpUUGFl38nCb
    XUCu1tFbLdUyG6bxBsIVFhcbd3nJ7K3Ke8KXc1fZVwRbCMH7D5Vl8RB7CMG6vqP349HRbF
    Mm3WHwz8A2SCk88/hbV6LzA9DHnKKkt8hDAOjlnIPpwY8LJJtlTHMJPWhxdgKveBeHEnnY
    JESQy5yUve0GzfRUdRjP8kutQ5yJjV9TkrwJO/R/i0kd5h69glmhM8tKkvoid83hRWm90D
    xFBKq5GmNj0x5LRFqmzdRpVGp3uKnBvm63D1EoKbznbOUn1Nrfbs8kX4thl2sC3RJCAQ9r
    1ew6vdAD6mM5BxbUDy20Qiae/emidoPSiAqsZfvYsrq4QiPFI7xYn1NPSJQOjUZ0Y/AUJB
    4sjmJQcHqWoazPi1S4NSkRwgsgtpGIAI2snhy/jlUmhk0FshdYIx5emqwzSJ0GH7lWd2Zg
    VQzznTK5zLjpin9hEReqP45T7oMgENvPXmefUCXaCCG/FZ6b+clR9tR+M/Pw
X-ME-Proxy: <xmx:4wwxamMC9_FFTQg0X2mBnLqbocSxCgPuEMi814HE4Y1rCbfy4cxdNw>
    <xmx:4wwxat5zW-lhXZ0lEcD_Ud5iswBRsIAdekuPOU0YcGl2ABIiCMdNKw>
    <xmx:4wwxavO0SXjSu-EQnnShKPos0YbH6j_ZEuiXxOigD8FZTEAHFb7mfA>
    <xmx:4wwxajkQjdX-nEh7RvnpG9Jw_SfWtP6ZYcn2735EXNLuFirha1RnMw>
    <xmx:4wwxagcKDvQGI-Q_qXOY1RvDxoRiJePn2OV4E3YhY4zBE5uplcDiZaVl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:44:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c004d9bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:44:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] builtin/refs: add ability to write references
Date: Tue, 16 Jun 2026 10:44:05 +0200
Message-Id: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUMMWoC/yXMTQqDQAxA4atI1gZUcAZ7leJiflKNxVEmthbEu
 zetyw8e7wChzCRwKw7I9GbhJSnqsoAwujQQclRDUzWmMrXB9SmY6SG4Z944DSgvH5Z5dikKWme
 tp9ZH13nQxaolf/77e39Z84nC9nvCeX4BE/VKBIAAAAA=
X-Change-ID: 20260616-pks-refs-writing-subcommands-7a77be5bda9b
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

Reference-related functionality in Git is currently spread across many
different commands: git-update-ref(1), git-for-each-ref(1),
git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
hard for users to discover what functionality we have available to work
with references.

We have thus started to consolidate this functionality into git-refs(1),
which is a toolbox of everything related to references. Until now, the
command doesn't handle functionality of git-update-ref(1).

This patch series backfills most of the functionality by introducing
three new commands:

  - `git refs delete` to delete references. This is the equivalent of
    `git update-ref -d`.

  - `git refs update` to update references. This is the equivalent of
    `git update-ref <refname> <oldvalue> <newvalue>`.

  - `git refs rename` to rename a reference, including its reflog. This
    does not have an equivalent in git-update-ref(1), but is inspired by
    and supersedes [1].

Thanks!

Patrick

[1]: <xmqqv7brz9ba.fsf@gitster.g>

---
Patrick Steinhardt (4):
      builtin/refs: drop `the_repository`
      builtin/refs: add "delete" subcommand
      builtin/refs: add "update" subcommand
      builtin/refs: add "rename" subcommand

 Documentation/git-refs.adoc |  34 +++++++++
 builtin/refs.c              | 153 +++++++++++++++++++++++++++++++++++--
 t/meson.build               |   3 +
 t/t1464-refs-delete.sh      | 133 ++++++++++++++++++++++++++++++++
 t/t1465-refs-update.sh      | 179 ++++++++++++++++++++++++++++++++++++++++++++
 t/t1466-refs-rename.sh      | 131 ++++++++++++++++++++++++++++++++
 6 files changed, 625 insertions(+), 8 deletions(-)


---
base-commit: 700432b2ba22603a0bcb71475c9c333d17c9b0d1
change-id: 20260616-pks-refs-writing-subcommands-7a77be5bda9b

