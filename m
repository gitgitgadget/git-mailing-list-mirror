Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FE17BD6
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624734; cv=none; b=MDnHFux4qLpICRJFG9zh2vcM8tjv5WITH7JJP7cT9oO63JIzXS53+WUB9YPsInQIB8vguCGxKhBfcARmU/udpTUeCX8nkaDgE+XH4a0XduHdGtNoCDFlPfaBsw5I8rxKJVzF4uDzJmqvfUEsVmjdUeiXceSHjqN4QT/1nO41ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624734; c=relaxed/simple;
	bh=CoJ2mCqCsDhqTX77JbU82WTpZp5AGg4GnXaS8kaoX3M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKW9qIkQuf6zDAP8lXHNOFBbcW7UYAes7CjjwBcKB8c7bZeSmg3xVgXIb0am9VFCf/sSR3oAyUxaUeh1H4S13jZLS/UlvBzxGm6AvCaz8AjmjYgWhYCEvGC6Q5baUtSJ46ZueeuquV2nDLHtuIqdunS4hGnvtJ8TD9vrMMoMgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rQsftpTN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3f7tNGD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rQsftpTN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3f7tNGD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F0DFE1140129
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 01:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624730; x=1728711130; bh=LfN4uR3CFj
	1a3laAMQ6GnUG1jKazvozZPwi4Ios1feQ=; b=rQsftpTNy+ZUGQ/0xUH6WlZfJE
	82iXKIAU+q9e3x00wWCuCSuvdiRbA/cYerOS+YYQvNukTjmRspC5m3aC4+ddmST9
	GyTR8y8RUkNfiWu3+UikM5ZdDO8KlUjTgruG8jW4ZglSsxW+xgRm0peXps7Vc4rg
	AXTH53QdVX8eG5UP7vF4zRtamrGQKG+nNvA67JGSBjtJ4pm3IqXByoC2TbmB+Foa
	OBL5FWdPs+iiM2BkKWT3GKvIehWKnBmWQu/GJDKElhBZG+AMDlvDg6M3NLIuG0fn
	C6TWqvJJEFdjGdTPNCSt/+O8DEcXbzBo6oaoPP+x8eXGS8frY3HJ3Vx21QXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624730; x=1728711130; bh=LfN4uR3CFj1a3laAMQ6GnUG1jKaz
	vozZPwi4Ios1feQ=; b=l3f7tNGDA+hWGeIwM/KrEGoMFd8O16oJJX2/COB5nvoa
	YFc9PtK8ciOO2lp+ijaQiU/WuzL7xvGOUPPsCI7Kk2qvHRSbHh+rIqJuTV8qe+Mb
	qS3Ga0UoUKscDbYXSRopluLAa34I7u6N/naUdg3afVWjD1TPDr3k5KDE+/j/0DeX
	67k/susvRFJrd2/WTJ8Gaaesown6jl0oxrMa7jicYYsN87sJJBVXsa4Fk9TM+2H/
	ZprMzTNp0f5TF3v0O/T0dArMr2U13MyHm2KvsoC7t69wb09M8EWLLRx6Y1CzbfsN
	5CYBuShv7k9msVRYpl7LySYn4pjWzbVbNhIdN0198w==
X-ME-Sender: <xms:WrgIZyJ8IdRyPtBLj5r1wM7Q95HPOPYCq1TKxtWsImXqNy8hudJtJQ>
    <xme:WrgIZ6KCFpuJcshWMYP456qay3UaXAbTqZD5H6T42y4BWuEDCvxHiNgS-QmPTH5jp
    UzVY6HzDjEoYSh2-g>
X-ME-Received: <xmr:WrgIZyuDqyKXOGLFuJfak-sQODwQEl-pPqJ7n8qBLGTvUsoHTHf2H6Onb47Psxu8Pfyudyx1o810EPMqxgEvIjtGteusro74vdjpGWE6AV_82j8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WrgIZ3bnZlXmYWw-rccg0hf-WUmEbFkXstXaoIq-V9bG4rfAj-kmmA>
    <xmx:WrgIZ5ZV0MELrDN_Kkz5zowlIaz592XuJeVWc3AQlc2j9rNMiatidA>
    <xmx:WrgIZzDRxy2iRTWY-mOn6GSILrultEyn28arqCEwJ312iUu8N3CtmA>
    <xmx:WrgIZ_bC4u5NRYOYeActCnf8w7p2EyeSUOjvVRKD0pxl-tkDMU12cg>
    <xmx:WrgIZ4wra8VTXHam_SpfskS9fu91-PW7wKLwS794IwV5wbntNBxhWFvA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e47e6ce6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:04 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/21] builtin/ls-remote: plug leaking server options
Message-ID: <89b66411354437a1e3a97751f185889dffb84126.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The server options populated via `OPT_STRING_LIST()` is never cleared,
causing a memory leak. Plug it.

This leak is exposed by t5702, but plugging it alone does not make the
whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index f723b3bf3bb..f333821b994 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -166,6 +166,7 @@ int cmd_ls_remote(int argc,
 		status = 0; /* we found something */
 	}
 
+	string_list_clear(&server_options, 0);
 	ref_sorting_release(sorting);
 	ref_array_clear(&ref_array);
 	if (transport_disconnect(transport))
-- 
2.47.0.dirty

