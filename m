Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657614A4EE
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723641; cv=none; b=EzY3hWi1Chf1IgCzl2o4f93oq4/gPoQZncuffKPt6PTIARbeg7kEbZMcc9dZksTswrm/HjTF+Q33XE+4MHXxozjeUos98J9uGTo9Hki/P694URxied+3T2TZrfqCRv1PZ3l4sGzYWm09hwl7q4VkYTsXQFEIrxARZaCGpMGzRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723641; c=relaxed/simple;
	bh=Xm3oek0yH4ctzC7cU9YEKOzpItBEGRnF7FOSLEWtAxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X10AqIHfFN6LV+Hrd8SIWSpCwKKvrkMNZgqs0Bx+STZCGm7JVCE6Ufpm1wGq67FSDztml3lETJrrwholO2Edehmx5SMqVg8Vhpj9IROAge+2qGKapxAPAHfKFCyxu4n6ijuFZ7NXhRX4s1Tu8jlY3ye9ZJeTC0dW9l9htLkp4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pMBDa7AN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/cjsgG3; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pMBDa7AN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/cjsgG3"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 919B21C000A3;
	Fri, 29 Mar 2024 10:47:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 29 Mar 2024 10:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711723636; x=1711810036; bh=1Wvt61ilIB
	Qwf/eAqQHs7ouN3cJVphs1JNzDC1pLODg=; b=pMBDa7ANIwoZg4U74/kMS7FTMW
	KNJsuoXgAo2yl6B413vHq19Ir7b2JVh24WVMI/Tf6l0YfQHuLlWniJnWxZzwOYBj
	N+0ziKS/O6wvOYOKqK9TqgaUinw8ICklpZ3WIX4Z5hD5SCS5hAMV+0LMRCOFwtf0
	uaEwpf/cGcilSpJmttc6mTrXF/7QtDf+qiER8Yp8MToRkU0tDtgE5o6ldnl0RSvm
	v2s1skA0/5azx4scd4tuNFUIjNafWecQKZvA3CFDTj/3u7BSOzkNRMVaA442d8Dz
	/srAwuQXoWSXCMknvWgm8wy03rLJnNhmdjXglmrip6XOd2kuWLodcm2MCoog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711723636; x=1711810036; bh=1Wvt61ilIBQwf/eAqQHs7ouN3cJV
	phs1JNzDC1pLODg=; b=s/cjsgG3TYbDyp7QUXAXaoOTn5z+qsW0bSIBTVhKMuMI
	vFdAIY3wXOLH70hD5rW+tLnhj/kFlxi2z/XM4cZEfOcEAvauXYgPQ+ibN9r49T4x
	/0vYFeIIdglp1lcAtJyfADgIfhLaBZVPxQlFOVE/JBDg82Q9pZ458XaY1xpScmOw
	a3P1+OfM0StS1HW0V2SRVx1kuZuZsOds43ZFDwipeh8HsXURKO8OVCiZGYwFICpL
	rbGeoklGHKZRtqfFMNlS2P5hr1Co5Dfiy2nFgdpNr9vBu7YbmByr7+IzgGWpMpQg
	4bdFZma571tTgVCS84sSIYRKfNj6LbPxGMbw/uRCZw==
X-ME-Sender: <xms:dNQGZrI4RwhcFe-zqYKdJOAQygzgQA7YOlTXTtyDYLr9oEJzxHSYFg>
    <xme:dNQGZvIrUWsaIBLm4hzjXqzcEEnszWbRF8tvPq4nUC5IUIutlrPOv4uUUQ_8c_rTF
    9rflYdeDay_PLJf4w>
X-ME-Received: <xmr:dNQGZjt6g_WD45usdz6xx6pXXL7HcC5io25-RN3kpeFHB2c8fM0nq2aLK_6HlwkrrytHLu8MSmhz7T922Sjix9OOWku8DFpppM68d0JoU9lT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdefkeeujeejtdduvedvudegvdekvdetleetkedvhfehfeduteelgfejteelveev
    necuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhgohhogh
    hlvghsohhurhgtvgdrtghomhdpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:dNQGZkZ5E8YMdSZaUpZnNXdvr9stfoh4VTfe0-j2bBvGgNezMbrx1Q>
    <xmx:dNQGZiZLC5KhTpzJORB0fbFw065a9kMY48dHNtdmd4_oshNdIpdwFA>
    <xmx:dNQGZoC_QRCQmo2mhi1GQRrvKPyQjO6kzxcsPkH5rFFxcy1-VMhmfg>
    <xmx:dNQGZgYbqfo3VOTAPYPDn0wy0-02XtDXEBvFIGaYzrQwnWLq5AqmSQ>
    <xmx:dNQGZoNnwRdcJHpJ6WhpU8KGTUe0jFl8SyFsrUMUTbOpje8ohMtnyKoV6Sg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 10:47:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8787127 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Mar 2024 14:47:07 +0000 (UTC)
Date: Fri, 29 Mar 2024 15:47:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Olliver Schinagl <oliver@schinagl.nl>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/2] cook: switch unmaintained GitLab mirror to new URL
Message-ID: <d9515be6f21a8a95de3319e1046e05606cd91d55.1711723543.git.ps@pks.im>
References: <Zf2B5oksaJRDH5WT@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lks1U4lOimeiKmrl"
Content-Disposition: inline
In-Reply-To: <Zf2B5oksaJRDH5WT@tanuki>


--lks1U4lOimeiKmrl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the official mirrors for the Git project is hosted at
https://gitlab.com/git-vcs/git. This mirror is only maintained by a
single person (=C6var Arnfj=F6r=F0 Bjarmason) whom we haven't been able to
contact for multiple months by now. Thus the mirror is essentially
unmaintained right now.

Given the recent introduction of support for GitLab CI into Git in
0e3b67e2aa (ci: add support for GitLab CI, 2023-11-09) there is interest
though to set up CI systems for the GitLab mirror. A new mirror was thus
created on GitLab at https://gitlab.com/git-scm/git that has been signed
up with the GitLab Open Source program, which gives that project free CI
minutes. Furthermore, this mirror has multiple owners (Christian Couder
and myself and we are happy to add more stakeholders) so that we do not
run into the same issue in the future.

Switch over the GitLab mirror URL to the new mirror.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

The new repository has now been registered with the GitLab Open Source
program. It has been configured to mirror [1] and CI pipelines run after
every mirror update.

Patrick

[1] https://git.kernel.org/pub/scm/git/git

 MaintNotes        | 2 +-
 cook              | 2 +-
 whats-cooking.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MaintNotes b/MaintNotes
index 919a9dc3fb..774ce56c20 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -135,7 +135,7 @@ My public git.git repositories are (mirrored) at:
   https://kernel.googlesource.com/pub/scm/git/git
   https://repo.or.cz/alt-git.git/
   https://github.com/git/git/
-  https://gitlab.com/git-vcs/git/
+  https://gitlab.com/git-scm/git/
=20
 This one shows not just the main integration branches, but also
 individual topics broken out:
diff --git a/cook b/cook
index e1d9e6aba9..5fb2062574 100755
--- a/cook
+++ b/cook
@@ -398,7 +398,7 @@ With maint, master, next, seen, todo:
 	git://repo.or.cz/alt-git.git/
 	https://kernel.googlesource.com/pub/scm/git/git/
 	https://github.com/git/git/
-	https://gitlab.com/git-vcs/git/
+	https://gitlab.com/git-scm/git/
=20
 With all the integration branches and topics broken out:
=20
diff --git a/whats-cooking.txt b/whats-cooking.txt
index bd471c4e78..24e9fc51df 100644
--- a/whats-cooking.txt
+++ b/whats-cooking.txt
@@ -27,7 +27,7 @@ With maint, master, next, seen, todo:
 	git://repo.or.cz/alt-git.git/
 	https://kernel.googlesource.com/pub/scm/git/git/
 	https://github.com/git/git/
-	https://gitlab.com/git-vcs/git/
+	https://gitlab.com/git-scm/git/
=20
 With all the integration branches and topics broken out:
=20
--=20
2.44.0


--lks1U4lOimeiKmrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYG1GgACgkQVbJhu7ck
PpTY4RAAkwBpI3qNsej2jueIahkkXAPYGDnrv+vPd+yleQlX960hsBQYddAh9y5l
Rn+KsqqDe5HunAoQOM6vGzUm726sRKbJTjv5z4p7p8IbhZYaaGqXuhhItnYqrT2K
kKwaOux1PlT798zrsibEbagw0bQy5fXaEzAAy359FTfUU9p35PrNxu1ca6OVIZEc
6U8Zu4dfwJJBw2/T6oQsBaJ/8+G9u1bJGluhm+3e1U4pyuiE3xA1QxcjnWmZAF0A
0BtuFYu8VXZ2bqYbM7rz9v+Ghjgz77fnEMRa3YeoZCsYmQM3cuvYTnEzmI9yEUri
JJA7KI0I3JoMdL5Lh2Dl+wkBU+MrAMpVgFTnPc4AzB+gn74qQOkZ0jbL86ChUuuv
vNFaNHZkOl16mWn6RSY6u8Wrz7nKlyIV7M6Tsi7Rsb5uDp6RzY5wLcpm7HuBsJxz
T1bb3w3eF88l987iryJp9JTKgJ+/0xhMz/QOpNsFNWd/x8Dz+xo3a1t8d0OwtIEa
U/69TcLl7VIO68giqDCxMRxOHu/lsUoVfWth40BSUZdJeZ8T1eu6qaZzr8iIBs87
sZsGBZZEC/gwmUt+RLQj6hZvuTO2q22dmJd4vn5oMjwzrOEwcf37m+wMOfbPtI6Q
RgrtsmYJISZ4KVqqYaonWKa0FK4HRyp+YKccgQPQC+Bz2oySJE4=
=Uy4Q
-----END PGP SIGNATURE-----

--lks1U4lOimeiKmrl--
