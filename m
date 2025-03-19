Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FD1F4E37
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391578; cv=none; b=t9gU6QhubaIFvUG4elUYKodFX9MGTtsswMxVD5QGvXZ3gdgxzdSe4vXhHT343YkQ2nxhI7xBE4TKix9u9xUcglKII9lCBEyk78/wS/PmG7PS0PnrMRoMjfl6ASCZyde9D537iUXWD0GX0m7YlQttVLGI8s9FK0JUaEsdG9wAg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391578; c=relaxed/simple;
	bh=SIiHozKuLioHebajV3pjGliEJkwiH39TA9ZOMBXzqoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVxCFzqRO7Td2m6JS17N+r6rrddvKEHCmDdL/R9adsbOTdhPEZ7cp9r8f4UfjfuJNlt6zDYKuBuXuyu+gsJC67o0lepd7GAb3yci23GOq3CWTuGN9hQ8RY+7ADDDYmn5J8TitnB4wmAIAy2jPajpJm9kVSRaA0suigzK3sWH0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZzAUqyal; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TN+fgass; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZzAUqyal";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TN+fgass"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9237A2540217;
	Wed, 19 Mar 2025 09:39:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 19 Mar 2025 09:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742391575; x=1742477975; bh=3MnTnhcpIV
	RifjWdfi9pmUYQsry6bbtoSuAQFUXlf8A=; b=ZzAUqyalOzL55uPgKTrrWiHJxy
	SPU3dRw3YPlVlzz4/r9G+Z/btWwtp+90+1ijYx/nhvvnoaKfvYjeMa9SpJfHJFmh
	q0ICfU768IK+Bzi9qHIEPOeFKY7uoPkhMlw3+UPbeu5jNLNR4QKOvHrEBa0nI8F7
	0pD44lp8JJWC7PO6IHgc8bCn3pBf/OwmxPBarYWHzIlSdc3lnbh0GBUD819Om07A
	RgHWbQvpxRJXPoaW5Vc+5Y8gGhnTsEbcOp64JB0WmFzuM1dPlPp4Ad1RNJPKtMmD
	bYFkyEjZIosxNKpALxwDjTdZ8eYsEtf8vTvTV63H6Mnsl7/J+dztlWE9Iotg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742391575; x=1742477975; bh=3MnTnhcpIVRifjWdfi9pmUYQsry6bbtoSuA
	QFUXlf8A=; b=TN+fgasshZPBxPucyBS8KqYPMOs+AsHH1RA8jE6APgugLC9wCMs
	24ymf8bYDBr20JQKDzDGlkVSXsdXD6QllpTeWp2UHS8asT9nmd3Ze/XujUBisT9N
	7hvVKzp+gNjZKEdTPtUpGro6N+cEc/BTnTJvk4T4c42QRwen+dnppjBmyOi0Je7A
	pKTuh7gXUskcm1Ks+kd0P0e6/gOk/0DK5WjbnNOMfYZcaUv20CUPzKSsov76F8Oi
	Fq7v2jBLnkxerruV9IcPFfkFL6mztM/v1tABa+lZJbRHUoigso3g8xzSSCpv4UV6
	8h0tCXdz9J+Jrlvp1vPt6OVLVxuv8jz426Q==
X-ME-Sender: <xms:F8naZ1XtMsRuUf97FvBce2labwbtYROy31qbbYzKSQojxxBn_lBvPw>
    <xme:F8naZ1mHOxM8-zmpmRYIeBUCEjbuMu9SLv4M8pKHommUreeqKN-YQhZhycj9WiFvP
    fS0hRqa5OSojDjjAg>
X-ME-Received: <xmr:F8naZxbvXpfnzMJuogNloUesyDcymHyN6gIpUQgaBVzf9b1H6c-ViQ_sVr4w5lGuP2N5PZJ1b1_trSFqi7Zd_YOrP0PoxgBEwohOVV8x860glLIxIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:F8naZ4X8ZH8QUCS5xGe2YLJqw9oVgFbAx6PMqWyCmEdBuRjSHHKtuA>
    <xmx:F8naZ_nGvlUctWITrmfpOmVaKlKBczAaX4UV0gKci37RC95gSn8efQ>
    <xmx:F8naZ1cKccWK4nLJTMQlwaQ_v371juLeSZgsyV04SWs-Buk8og-AlA>
    <xmx:F8naZ5EiPQ36rthH9oN1qhnFCjQAtVEGZCcCsG4Hn-N0FN51rha0DA>
    <xmx:F8naZ9jDORZ1AtliOKXad2EvBtaZlqOvi7me7wz2PjycTmwIoKDERwsl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:39:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d9eeee02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:39:33 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:39:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: use test_environment conditionally.
Message-ID: <Z9rJFG7aOVg3gDTM@pks.im>
References: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>

On Fri, Mar 14, 2025 at 06:02:47PM +0000, Sam James wrote:
> test_environment is only defined with -Dtests, so use it conditionally
> and define a stub environment() instead, to avoid erroring out:
> 
> ```
> $ meson setup -Dtests=false -Dcontrib=subtree build
> [...]
> 
> contrib/subtree/meson.build:15:27: ERROR: Unknown variable "test_environment".
> ```
> 
> Do the same for 'netrc' in contrib/ as it uses the same pattern.
> ---
> Not sure if we can do better here somehow or not (with a disabler?)
> 
>  contrib/credential/netrc/meson.build | 8 ++++++--
>  contrib/subtree/meson.build          | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
> index a990dbb86d..6d815d01c4 100644
> --- a/contrib/credential/netrc/meson.build
> +++ b/contrib/credential/netrc/meson.build
> @@ -7,8 +7,12 @@ credential_netrc = custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>  
> -credential_netrc_testenv = test_environment
> -credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
> +if get_option('tests')
> +  credential_netrc_testenv = test_environment
> +  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
> +else
> +  credential_netrc_testenv = environment()
> +fi
>  
>  test('t-git-credential-netrc',
>    shell,
> diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> index 9c72b23625..d18f188216 100644
> --- a/contrib/subtree/meson.build
> +++ b/contrib/subtree/meson.build
> @@ -12,8 +12,12 @@ git_subtree = custom_target(
>    install_dir: get_option('libexecdir') / 'git-core',
>  )
>  
> -subtree_test_environment = test_environment
> -subtree_test_environment.prepend('PATH', meson.current_build_dir())
> +if get_option('tests')
> +  subtree_test_environment = test_environment
> +  subtree_test_environment.prepend('PATH', meson.current_build_dir())
> +else
> +  subtree_test_environment = environment()
> +endif
>  
>  test('t7900-subtree', shell,
>    args: [ 't7900-subtree.sh' ],

Thanks for the fix! I think it doesn't quite go far enough though, does
it? I would have expected us to completely disable tests in case we have
`!get_option("tests")`, e.g. like the below patch.

I see this patch has already been merged to `next` though, so we'd have
to send a follow-up fix that builds on top of it. Do you want to do it
or shall I send this patch?

Thanks!

Patrick

diff --git a/contrib/credential/netrc/meson.build b/contrib/credential/netrc/meson.build
index a990dbb86da..3d74547c8ae 100644
--- a/contrib/credential/netrc/meson.build
+++ b/contrib/credential/netrc/meson.build
@@ -7,14 +7,16 @@ credential_netrc = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-credential_netrc_testenv = test_environment
-credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
+if get_option('tests')
+  credential_netrc_testenv = test_environment
+  credential_netrc_testenv.set('CREDENTIAL_NETRC_PATH', credential_netrc.full_path())
 
-test('t-git-credential-netrc',
-  shell,
-  args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
-  workdir: meson.current_source_dir(),
-  env: credential_netrc_testenv,
-  depends: test_dependencies + bin_wrappers + [credential_netrc],
-  timeout: 0,
-)
+  test('t-git-credential-netrc',
+    shell,
+    args: [ meson.current_source_dir() / 't-git-credential-netrc.sh' ],
+    workdir: meson.current_source_dir(),
+    env: credential_netrc_testenv,
+    depends: test_dependencies + bin_wrappers + [credential_netrc],
+    timeout: 0,
+  )
+endif
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 9c72b236259..63714166a61 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -12,16 +12,18 @@ git_subtree = custom_target(
   install_dir: get_option('libexecdir') / 'git-core',
 )
 
-subtree_test_environment = test_environment
-subtree_test_environment.prepend('PATH', meson.current_build_dir())
+if get_option('tests')
+  subtree_test_environment = test_environment
+  subtree_test_environment.prepend('PATH', meson.current_build_dir())
 
-test('t7900-subtree', shell,
-  args: [ 't7900-subtree.sh' ],
-  env: subtree_test_environment,
-  workdir: meson.current_source_dir() / 't',
-  depends: test_dependencies + bin_wrappers + [ git_subtree ],
-  timeout: 0,
-)
+  test('t7900-subtree', shell,
+    args: [ 't7900-subtree.sh' ],
+    env: subtree_test_environment,
+    workdir: meson.current_source_dir() / 't',
+    depends: test_dependencies + bin_wrappers + [ git_subtree ],
+    timeout: 0,
+  )
+endif
 
 if get_option('docs').contains('man')
   subtree_xml = custom_target(

