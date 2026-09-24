Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF0442370
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241595; cv=none; b=pDSA8q3/7I9xi5wL7TqAXFJ/juyI9lezTvU5nlAqCWAjJ2Ai6srIhV/BOzMHLmg/62enRo/dwy61nXMYvzDHoAGvqKNN16hux3hNuvnUQT+r5G9CQEScFjTI42bxU43v6Jqt9NsFMVWmMgr/yVE8WKsRPPLpvdQ1D5qXMtbIM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241595; c=relaxed/simple;
	bh=CwRhShpAL7sOygI+y4ACUCzqvFJLmSzKeF2jaowSt1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU36C6DX6hH3JGSSpztiC44ilu0mOhIJ2ERdaSQtkcTmOc8eLTDhYaHBn3e1OFw7tKkWYNlTLJ/TvjEaeNXOZGks87kFWKjEClOgJCU4fUoEc1fowePpAn3oWGIWa6AiDBAM49RTIho4J1bSRA25OHPPy8D5UC9z66velCG2F1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tt3m7CKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dG30I9eM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tt3m7CKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dG30I9eM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6332C1400074
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 05:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241592;
	 x=1790327992; bh=aPuE9oeQKVQgsj9fnCu7YTCanTP/YuCo9XWzBFP61ek=; b=
	Tt3m7CKc1ZPd7PzBTUkVVIMXyI6nZ1jEANroTSTncsj4xiSNoUqQitKOjUmUta98
	tXL2IxDufsmoBZKibqN1Jh4B2Bcqq8KOLuX0nx9ySrGQ61qkvCzPIRhwhSfja3Ut
	czOCUMTbe7K9aNFDM2YxSa+/OFafcTWwp836l+ZxXKCnSzJjXORnZjbf1RT0ak+q
	pff/+CCtXxieDEdzxXbKDkhiFNclz0hdpCqSfKSTb3XyYkfpMWnNGWBGz44f5o8K
	e8JGc4v+/i0oE03mU2qHoPjukam2dtrkIUeN/fi8ddvG/mihjM8ZjyXZviSU+hAD
	2fgov9jIV6xbll77VJ81MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241592; x=
	1790327992; bh=aPuE9oeQKVQgsj9fnCu7YTCanTP/YuCo9XWzBFP61ek=; b=d
	G30I9eMYjWPXvm9vWJXvJN8ho9B3xC6ux4WNssFqAu6DG720aez5o1D+JsApzgGK
	rsCgOpydWS8tRvUIWvMpbrSBOq/XACbbt39HN6O8B2DRgm+lKP5RMEaFxMXWiwb2
	VcfvR/f1w91lRiVGniEs+Zefx16IdPHT5LoScdFrrZBAyaDe4f8Wa0Y5o4YKsfvg
	asjIoLAZrUl6BPW2oN1Bo4RcPXL0cIx9bcAuHGYBMMaXEuNrGWWMkSh6g1eQn1Ez
	DTaBE7S5tcna+7JXkfTWJwzYByLO4A/91P+gGnyhM5L2urbZ6Q0ArHAHIe854Pfi
	eVhXdnTJL0/7ErH803eIg==
X-ME-Sender: <xms:OOu0avvRfVV3t03uONNH0ANvZ2OhhSedrZiIR5PaNmf5XmdvB1n4wg>
    <xme:OOu0anb-PVVTHdg6DHWN2YCOiKaOSAh6zO0roXWFYqTojAL3PEjlb5ANzKhJqfF9r
    5zVLsqh3m3H-JKyVODaBg6LWcqPQyh58-NMKziScCZ_9utiN53EW-s>
X-ME-Received: <xmr:OOu0aobH7WLi4Z6eZ7aPnO5pU1MPaovzNxzgrKVJKbdcc6Rl7ZAR53VXfeR0NVISQjoMD-s>
X-ME-Proxy-Cause: dmFkZTGhs9DR4p+NgqsA/Yq2jv5eAnNnd240U1YBWxUaE6zw6rKb23at9GOF1dx4/ypLmT
    s0/jqJKKuM/bTUBgSE1DiCh1fGkH3ppO0Lv47iNmtkUeWlQqLOA7BYnugGCZG2VWgP5qCI
    abvNyGiRupoMqqtlKGAUI6Wab4L0Cw7pkDBYRSTf50MF+gbzFrhELDI/fTkCvXDYBSEmwE
    4xS6TxGaIx08DvfWzlAWGh2AeiaZiTYHUu0QewotLKjYbq2wfzw9xyDsK3db8JhtdVzs79
    o2HxFhGXuom5Q7qwlF4lrOBhR9OhNshqfULq/l/Rg/uK9K3ySw3s9x2iO5cXEFJFy7FeNf
    jdxKgKC4hQbaH3fA3L1QnmJUHlIxAXUTH7iPcMB43XO/l+H4/n1aKSccFIqOnljwbl4qhA
    gIun1f92iai+gRzRmT7+vKAR3fjoGBpejZJSPs5/XyoULHCVngUv0eIJGrSri2mcS6pQKj
    Gg+CpIgDDzee+L54GsfhU7OewoS8w0+UoW2LvO/Ad73zolVPPAYsDl2IVWMwp28dGFtEWj
    IZ/yJCdEKGXs8OCZlf3cC8qjpn86VvTspQNayeLKl1Xn9esWxAS55Jxhh2TQD4jSF7wwj/
    qjcKOsDdpXME9CE2QIpW1QRt1HADziqOyA01MOGoMdAnJonn5Osv2qTE5aaw
X-ME-Proxy: <xmx:OOu0ajXZfUzqZtwO-fNCLbhjd2b34JCBOU2w43Ua-FYMezQx2dQEWw>
    <xmx:OOu0av0OvHb_sL21QchHQa9Dsv3Hbp7Xb8gmOjowOEwJlLzrZCa9HQ>
    <xmx:OOu0aqaccHyiPzaYkvcMzi9XXWQyNoumY58DbF5Usrp3u7CjFEK-Uw>
    <xmx:OOu0airgtpSuKktCYCMS9sjhBqGgh_YjrlauBeMC2MSqrA1xjMXO9A>
    <xmx:OOu0auffnhWiOh5dYjsggS5sdqx5n3YMG3cb-RpD5T6oFTNsxLcW7p8t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c87ceb1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:25 +0200
Subject: [PATCH 7/7] setup: enforce that passed-in repo does not carry
 relevant state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-7-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In the preceding patches we have refactored `create_repository()` so
that the passed-in repository is not used anymore to propagate any kind
of state. This was done so that the parameter doesn't act like an in-out
parameter, but only as an out parameter that we initialize with the
state of the newly created repository.

We don't enforce though that the repository _cannot_ be used to
propagate state anymore, which makes it quite easy for state to sneak in
at a later point again.

Ideally, we'd do that by having the function create a newly allocated
repository instead of taking a repository as input. But unfortunately,
that does not work because we end up calling `repo_config_values()` when
we create the "files" ref database, and that function requires that the
passed-in repository is `the_repository`.

Instead, call `repo_clear()` at the beginning of the function, which
gives us a clean slate.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/setup.c b/setup.c
index 0d0a4abbe6..fa39219d6a 100644
--- a/setup.c
+++ b/setup.c
@@ -2858,6 +2858,9 @@ void create_repository(struct repository *repo,
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	struct strbuf err = STRBUF_INIT;
 
+	repo_clear(repo);
+	initialize_repository(repo);
+
 	if (real_git_dir) {
 		struct stat st;
 

-- 
2.56.0.rc2.329.gd58861e689.dirty

