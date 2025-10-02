Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E230DD0C
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403098; cv=none; b=oM+xNDjT8IakW7rS5gpEFNixPX2O6yUuqSXUHOcPol1KEFc/VFonJk4H9ORNdMuIWxd8Jn7ozlwoZ+w5cLs4oTDNJuLgrjLxpzWyNGswrp2dNGgEKjTO/yFEcm21UvlgOfsx0wfB0cnwanY5tS2sbFIfatZB7UPd46/0gnCFS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403098; c=relaxed/simple;
	bh=5N4gTQ4XfEcNXXeBpDySWgBKxINrd+SrQqsYGGr7KN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rk3t9i1hOeLI4RHnnRNpbS0GPibGuzHiY1KewzxTMC/winnwCUBHkcOkr/n+5+3izCnGgJqpKr/X0igSwf9s0TH/aqqOMpiV0336lLB2Wug3JbmOX36Kpm0oAJEE/hlWIPiZudKG3JHj6FVGP2rMX5SQUQ9VxMNhFa50HinD130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PhPMgbKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpVeyduB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PhPMgbKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpVeyduB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 804657A014E;
	Thu,  2 Oct 2025 07:04:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Oct 2025 07:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403095;
	 x=1759489495; bh=FiPQSgO+bnS7MV3BNxbMXizODW+BvOyokAu2163T/pw=; b=
	PhPMgbKV6CRBtjJ5nKy/4L+n6bLWQX40k6vTEp7hq9BagQH7EEA+2aczY6L7oHwE
	1Hug81qzbpBpbeAy6lOuru+llnHlN2B/gDDHx/fJEwR5zzO2v+e3vz7TR62UzJYk
	FYFmRTlpiP3pYF6oBsmEHssA/AG1h78vRzgwL9Fn5shi2iDluoVts4DjlxMBQdFQ
	BzzRWdJSOxw0g7PCTPRJSfJSEEPQR/sre4Eh6BN2NiJBwR2DUDNrVVwlRuOUc7iZ
	dcdUIRm2jgWqR5iNvBVZGTWC5r+tpTHQouPZq5gm7NBn480v73YzYc5xWoOvtkoW
	7Jr2J+eRZW4XWoG5joNl7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403095; x=
	1759489495; bh=FiPQSgO+bnS7MV3BNxbMXizODW+BvOyokAu2163T/pw=; b=f
	pVeyduBfWUhiZqfHbARgfq9Bu704xETYOOV7cIuUDfSN4GoTKjpLByjDs/nkEcb8
	EdOMpJzSfPY7mPxgFfOEzmjsHhuIPfNWPtlOOXk5OBHl5Yl01J5rT38vzN4/iGzz
	VHXAkYkTLeUsqoMiC6BnkXciiAXoiCAChSyc5yGh/z30Hwe9j56BdUV+1ZtegO8U
	G0hHEaItzG/rbL9p4uAJq/3UDKqj6fyPFyEdKApom9OrbIxishX8CkHMzBh1xrz6
	Uqbe+aeywzL+gP52rCLJV6uh/2+axVrT8P5w66VBtOHAGwVbfq5IR4fWKpCHwvI0
	4/kygDe+OR0WZpccgpbOg==
X-ME-Sender: <xms:V1zeaOCNVchWjrhzTBF_Tk3N6R5d_xn30zzHjVB8QwmsPE6DzE4RCw>
    <xme:V1zeaOhH-Aw79wfUffGIm0pckoJfUjx0VOJtJpLQC8Y_jFDqyAVdL8eg4zCmpyrnO
    spk6E12vllofJXP96wO0pGcdncloH6k9bTe1zm3w3RNLCpYMpR2vA>
X-ME-Received: <xmr:V1zeaPMDekTmseRJLMrc4vQMWbJE9vtFpj1bqCiaozELOBN-Inud9u42dWeliPZOl34HcuQXaJ3DVTO0namJb795BZtmHID9Tj3gvc9jEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfffggfffuddtfeefieefhfekueejhedvhfekleeugffgjefhgfdvteefudetjefhnecu
    ffhomhgrihhnpehphihthhhonhdrohhrghdphhgrgiigrdhsvgenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:V1zeaH5JXk1nlQTXUiSqgHCuJ0y7I0T1NKyGOk1cv41pep6HDv1T_Q>
    <xmx:V1zeaF38GpXSQCNUC03PmBFebdXoYTgPZ-_10r9MAZPjFZB36okpCg>
    <xmx:V1zeaAbtjKTOZHdFoPo9y96h1NidJ3jPwEx6ymiwHj29VAAdWMBWlg>
    <xmx:V1zeaFACET5eqcDXIjhBpLfyKQQC2gogr6CYlqSaGFCF2I1pJz8XHQ>
    <xmx:V1zeaBYM52DSLLSmb-1n4FnPRIEhrIrJq_3Ju-wNTfFNWrdTl-nS4K4s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:04:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 282e56a2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:04:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 13:04:38 +0200
Subject: [PATCH 3/5] gitlab-ci: drop workaround for Python certificate
 store on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-3-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

On Windows, we have been running into some issues in the past where the
certificate store for Python is broken on the GitLab CI runners using
Windows. The consequence was that we weren't able to establish any SSL
connections via Python, but we need that feature so that we can download
the Meson wraps. The workaround we employed was to import certificates
from the cURL project into the certificate store via OpenSSL.

This is obviously an ugly workaround. But even more importantly, this
workaround fails every time Chocolatey updates its OpenSSL packages. The
problem here is that the old OpenSSL package installer will be removed
immediately once the newer version was published, But the Chocolatey
community repository may not yet have propagated the new version of this
package to all of its caches. The result is that for a couple hours (or
sometimes even one or two days) we always fail to install OpenSSL until
the new version was propagated.

Luckily though, it turns out that the workaround doesn't seem to be
required anymore. Drop it to work around the intermittent failures and
to clean up some now-unneeded legacy cruft.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ed4dc9db94..b388154078 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -157,17 +157,9 @@ test:mingw64:
     - saas-windows-medium-amd64
   before_script:
     - *windows_before_script
-    - choco install -y git meson ninja openssl
+    - choco install -y git meson ninja
     - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
     - refreshenv
-    # The certificate store for Python on Windows is broken and fails to fetch
-    # certificates, see https://bugs.python.org/issue36011. This seems to
-    # mostly be an issue with how the GitLab image is set up as it is a
-    # non-issue on GitHub Actions. Work around the issue by importing
-    # cetrificates manually.
-    - Invoke-WebRequest https://curl.haxx.se/ca/cacert.pem -OutFile cacert.pem
-    - openssl pkcs12 -export -nokeys -in cacert.pem -out certs.pfx -passout "pass:"
-    - Import-PfxCertificate -CertStoreLocation Cert:\LocalMachine\Root -FilePath certs.pfx
 
 build:msvc-meson:
   extends: .msvc-meson

-- 
2.51.0.700.g236ee7b076.dirty

