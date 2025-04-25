Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824810957
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560071; cv=none; b=o4Jn6w7PSAMf3xMtblM1Y9dZhH1+Sfy+x45auo10uBLqP7+fUsEayGg90odYsch6S9WEDiRILKDgmWrr37jAGQklPPipTZQXX5W396J7Dx6RqlPAoLa8U3DDlcVlIDlEsJQW07SkZkDu6E1Jq1nuVLRlLMAl48crgSjGsMJBbq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560071; c=relaxed/simple;
	bh=KnOAF3CWDvmhby3sRhq+qxV2wj+qkZWu2t5yBZSOupg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=hsPXu1EUS64WZhGYsuTAblSjza+EcfMEWUGSTFfih1P7FPYAzQ9ZGCU6SktjUgxQjYzwJ3sjEWdFJFJ5RXQqh63M9UKGQJjCfz0LxRJ2ZcjudDOdxBCkUue6GWssOvLOVNiC2C0a6Z+CGxehMlUjR392jsyfwFovNYV7YVinZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1FC5aypt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwF+T1CS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1FC5aypt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwF+T1CS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 048B4138022F;
	Fri, 25 Apr 2025 01:47:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Apr 2025 01:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745560069;
	 x=1745646469; bh=dTVTW6OwRpcNbgIBfSP8kaYExQwb02ZATT8g5rAeuao=; b=
	1FC5aypt053mBJqivxggt9c2VwABcCkOZKGkJ/8cf/DSTQPPfKSnkD/UewzY16u7
	lBJBREsRY/Y+8Jhc6JI3trohdZuUkGgNbw6lVRwuxiKlqrjHnzgaiM6C2OgGk5H2
	7CzQGKHyNapVPN37gBhAlgBAk2M7hpnf51/Wrr07MS9RuZUZBwBAK3+sriXjneK0
	jo/0mvBoXQCFxe2qd1vxL/ibcz5WYFiSRwK6JybTVMEWmyIwJAnXg9haFlS/ipFV
	MyUlek5v9u096yBid9Znl+uEpi2bOAZp85qiF4zpwzvg/ba82YUuEjre+ndYW6Sy
	9zhSXUhjxGMb6NlVM3BsfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745560069; x=
	1745646469; bh=dTVTW6OwRpcNbgIBfSP8kaYExQwb02ZATT8g5rAeuao=; b=C
	wF+T1CSwoWK3F3UmNHcRVrtLM+sHF++gNA/efCKmmwtp1UJjzDOeUEWPLPbbdPKM
	73HVIrH0IeZ1AZFC7/IiQhXvS0tw0kNG8HcbWf40tJxoCYRi/Dn/K8EUaYIM9qwP
	9JdwhJmwRBOAnUUDVVPsXljO/40p6C63UbOr0uqg9FiVf7IrDzfQnbHz7EhO25xN
	g8fj5VuVOtX2ibtykoP5Gm5D2rGzMmo3G6qMaEYrCs6lYfaXpnwPW4th9tP+IHhk
	uvtp2phm0VCtztOenkayD1fQRrZvPAN51iv/9EUIHa0s2rfFy537D8YBmTd7BppA
	engB2rKlSl7cfikYwKmoQ==
X-ME-Sender: <xms:BCILaGS7G-u4KRcqWRK6qlHiNxZNsbe1MY9UzOsKmGjtPjo2Z97iAg>
    <xme:BCILaLy9UMVEtoS4CGAFVgS4AYRPPkpbqXLgYjlkJ-kuJADNqnEB0_SJRKAlBOW7U
    wDKBsRNSPIy8LQviQ>
X-ME-Received: <xmr:BCILaD0JiHYUn3SZgyMQDfiP3lOR5M0I0dT6OYF_6k0mZo01tSBJXs_XS7P67-not0Rgyt0woDbZ0Za6NaOCaz37YHeXy5fITwa8AkCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvth
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BCILaCApWF9f0M5TCapA8qLPTd7HyqDdYuV5vU9H_5wLcMbzhAFC_A>
    <xmx:BCILaPgGQLMfO3TdC0Xo3ZXkc0oJ708Nu-7xeSbRWkcM0I7n69ey8w>
    <xmx:BCILaOpjDNaILBaRk7IkegbvfLFVi5Yey40TR2edHb-Rhq6FWPVITQ>
    <xmx:BCILaChYYL-lmTWTjxq0yEF49n0kbDJBhstBv5jLrK8gUa76qSQcJQ>
    <xmx:BCILaDxjpPULmowCt_C7lawjCTCmQ7vT-4fEOp-75qZ6rviDwyVrLjSE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:47:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8b1b927 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:47:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] meson: prefer '/bin/sh' over PATH lookup
Date: Fri, 25 Apr 2025 07:47:43 +0200
Message-Id: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8hC2gC/4WNQQ6CMBBFr0Jm7Zi2KU1w5T0MC4RRJgIlHdNgS
 O/uyAVcvp//399BKDEJXKodEmUWjouCO1XQj93yJORBGZxxtfHO4/oSnEnigmsU3lBGmib0TWh
 ssFrqa9DtmujB2+G9tcojyzumz3GT7S/9Z8wWDfqaTCDy99ANV+2deYa2lPIFBcbj3LcAAAA=
X-Change-ID: 20250424-pks-meson-posix-shell-4969161025c5
In-Reply-To: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

at GitLab, we recently got a couple of bug reports about Git not being
able to find its shell anymore. The root cause is that with Meson we
have started to look up the shell via PATH, which may exist on the build
host, but not on the target host. We have worked around this issue with
a cross file:

    $ cat >cross.ini <<-EOF
    [binaries]
    sh = '/bin/sh'
    EOF
    $ meson setup build --cross-file=./cross.ini

But this made me remember the report from Peter [1] that Debian also
faced this issue. So I decided to address the issue in Meson directly by
preferring `/bin/sh` over a PATH-based lookup.

Changes in v2:
  - Simplify how we generate the summary.
  - Add a comment to explain ordering of the program path.
  - Link to v1: https://lore.kernel.org/r/20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im

Thanks!

Patrick

[1]: <20250209133027.64a865aa@gmx.net>

---
Patrick Steinhardt (2):
      meson: report detected runtime executable paths
      meson: prefer POSIX-specified shell path

 meson.build | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Range-diff versus v1:

1:  cdb4db30677 ! 1:  b606f3ffe2e meson: report detected runtime executable paths
    @@ meson.build: summary({
      }, section: 'Backends')
     +
     +summary({
    -+  'perl': target_perl.found() ? target_perl.full_path() : 'none',
    -+  'python': target_python.found() ? target_python.full_path() : 'none',
    -+  'shell': target_shell.full_path(),
    ++  'perl': target_perl,
    ++  'python': target_python,
    ++  'shell': target_shell,
     +}, section: 'Runtime executable paths')
2:  d439c859fbb ! 2:  3804c32b879 meson: prefer POSIX-specified shell path
    @@ meson.build: sed = find_program('sed', dirs: program_path, native: true)
      tar = find_program('tar', dirs: program_path, native: true)
      
     -target_shell = find_program('sh', dirs: program_path, native: false)
    ++# Detect the target shell that is used by Git at runtime. Note that we prefer
    ++# '/bin/sh' over a PATH-based lookup given that '/bin/sh' is the location
    ++# specified by POSIX. This lookup can be overridden via `program_path`.
     +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
      
      # Sanity-check that programs required for the build exist.

---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-meson-posix-shell-4969161025c5

