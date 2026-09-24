Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356EC37F337
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258977; cv=none; b=h33RRjtC+p2tjyqsQ/a7Ai8Po9E5U/RRQgwV7FjBb/czrYv1Ejn1u3OFrANL3MXyVJzkiaOFldvJkKWjdPP5p5m/s1DXyfEyuLem07QEDI0E2nM3IGjIaHQBqGhLeyqOxBBbepJcjyp97PlbUuj5rcSpsyJvrHLgYg6GxZe0XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258977; c=relaxed/simple;
	bh=x/K/rsfOsFffsItvN++rI72AizHeA/bUhgqeE3k3rK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8qsiu8ABC6lwxiNPn0cj98bbFnD2MEKJJubz1frPDUBywX6G5lJURyo5xWOp1fUQpjIDbVL92jYuuaPH5YCEbgg5A35w50LZuufggzL2ChQRMnC2kaqpK4kbG6eypZ6NoDtCps8ks2ttrsfdHHWxlEQDNC+HZy4TtRv9NUqt9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=II+pcdwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yJtBMbhM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="II+pcdwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yJtBMbhM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8294A7A0088;
	Thu, 24 Sep 2026 10:09:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 10:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790258975;
	 x=1790345375; bh=GIjx/LPYdG0qXkWSoM87uVzOn054FG9G6j8Oflm0FbE=; b=
	II+pcdwObi6XDiuSgY7F78xhPVb3430nY01J/SNJ+m+MsAtg6m+95G8/Mj1uk6lN
	IoDY+oClL7ZgwWhgKMvDy1rVxcICmz+oA8/gTbJ3xOdSrJ7gP3bu3EcEEwyaAWpS
	jFnyIVmqD6x+cCk5Z/JaLVQUnbvRjsTUxgeXSfX8ao+MUoRAlc8+zkgp84Wvg6YS
	p3pCRFjq4Chp7mPxvL2kQzZ6xsaFyJh2eE6MRxYO0ikqkzc4Or7jMryrO4qrpeGc
	UIFBxSt4zenieS00Tf1kR59XtsASgOdkLZVQKtoa0LqpAaBzNSsjkrN8Dey5yKGK
	9+uJRsslCYBUmj6gPPdg7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790258975; x=
	1790345375; bh=GIjx/LPYdG0qXkWSoM87uVzOn054FG9G6j8Oflm0FbE=; b=y
	JtBMbhMghFXAMAyU/c2y+akO6E1Y5lcKbKeKbWCNQJVZyH2IQHRW261EDvtmcFE1
	Qaw7jGb+yMMKvRnl/4SIMlFIkS/qvAsfKpekB2+EXa98ACGorl+PGeRecvu6KXVP
	sYUms2AlMtvW/hgpx8U3TEm9/IUWQvpZJNbh6QCtsMHb4iG4XrT3OiGa6raoEKrF
	Js2HXNbLQLiHH26+wLmkjQyAuLOrTlV33MmQZe9hcp4V6gJG4J7aeqdJsXUnCR9v
	cMtG2A7mFrCW7lOS2QKb1b1VmjhTGHsO5V9fNR+/19hbNEHzkSHmZPSnGg//xW3x
	5jnhZTT6q0uo8/cUyHctQ==
X-ME-Sender: <xms:Hy-1akay8cJ8DAuyvYwVawB-08KGAoVUxZXG8sH4ON-JYhHwQNOJpw>
    <xme:Hy-1alZrLwwcv4jhCmkyaI6TMqvm6M0j291ui7ZrXpO6d0debzyNF3hj0Uo_vlteT
    kITI9m_GtP59rzwyrsm5PI9PQFGtCjyEN23DFOLRaVtGO2bs1QR9cY>
X-ME-Received: <xmr:Hy-1asntMIYwgS6dNGLYxfUJiY5-IVx_zDM5OXa1sii844tPxb6BUQuY981SgcwJkRTFqY0>
X-ME-Proxy-Cause: dmFkZTFwHBJJ90ceNJcXLyaV9qiY1alliFtuY/Ua8z1EGa0orDG/KAZJQsbT2WGm3v2CSL
    TfATgpswwlBqoIyRFI+0PfcNlfsFyVMPS30uGuYVoJ+yqbGuScB2d9JxnFx3yC4JbDiDDU
    a5WRCAGK9lwuhxKjM+oTUAPPw1/FTkIzM0NZtvzhEnr49HxGd1TTXuEHkflfY11o5w6p33
    WRTir/CciAme4vwFkUX8tVXN1i7Jx+78VN/4YIYUkOEPYYe3iSPS0XGbzvQKj8vEQC5izq
    SAV6vEw08etAZtpDO0kToQ+ddbgE4FNP3vM+U1RcBax+yiTbHeQvxecOtLIt+zOJghT0VY
    SuqZsFLnasaR9qYkW+gF/PRH3c9VLhTHwOFdFUeEmEzePAIU8ybQmv2dT30FfYwgRME5MA
    INYvnR1n0EXoheMAueUOfguo0W8PpQlllwYraxEklStEe6TwSHQjPqeeh6YugnH6pc5zkZ
    ApkN14spJbnRVGUiaMq+zn2gNaqmxend7Y97pYEFIo48J/VhmeoVA9EdAsfA213+XVmsin
    wFjFOVJ+5X38pdvDLl5Mm/1Ja6eV2LuLtvjkNsO89SRQETlDGJ7oApNAbFmAVdF9CHYUIK
    njh/CI5HoQI6xlSiuAF1Wz9G+sx8YhhKZl6A7yJGAjNq8DrRS+oOje/SFOeQ
X-ME-Proxy: <xmx:Hy-1apwdnsO2zusQ0lRhZPsM8EGkWvtHZxiC8ZaVIXvTlOgvFZlHgQ>
    <xmx:Hy-1aiNBg9Y2r9SEi3grETUNy_rljdM8f_Ps35RJJejd2c9eRut1Cw>
    <xmx:Hy-1alQZREbHL5x5QRUlBIGZe9NvjrTtUr5u7xfl4rc19C3saXm6Hw>
    <xmx:Hy-1aobzxCYV-ttvWHjfzg_pz1T6jOipbCtdQGky2W2R7m47IjB7Ig>
    <xmx:Hy-1au_Wt2VjYOYH2-18LmyBWO-zx6ADpebuHQy7nYc49uOKFsq4Wg3o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 10:09:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06805d97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 14:09:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 16:09:16 +0200
Subject: [PATCH 7/7] gitlab-ci: fix hanging MSVC jobs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-meson-improvements-v1-7-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Starting with GitLab Runner 19.x, the runner executes `git credential
reject` in its cleanup stage. This has bad interactions with our build
environment because we install our own version of PortableGit, and the
runner picks up that version of Git. The consequence is that we invoke
PortableGit's default credential manager, which is Git Credential
Manager for Windows. GCM then tries to use Windows Credential Manager,
but it cannot and thus the job hangs in its cleanup phase forever.

Fix this hang by unsetting the credential helper after installing
PortableGit. This means that `git credential reject` becomes a no-op,
and thus the cleanup succeeds again.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.ps1 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index e3b367fa54..2ceb5dd99a 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -53,3 +53,11 @@ Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet',
 $rustMsi = Get-Installer "rust.msi" `
     "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
 Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
+
+# Disable Git Credential Manager, which is auto-configured by PortableGit.
+# GitLab's runner picks up this Git in its cleanup stage and runs `git
+# credential reject`, which hangs in GCM and makes the job time out.
+& "C:\Program Files\Git\bin\git.exe" config unset --all --system credential.helper
+if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 5) {
+    throw "Failed to unset credential.helper with exit code $LASTEXITCODE"
+}

-- 
2.56.0.rc2.329.gd58861e689.dirty

