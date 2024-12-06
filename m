Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B713DDDF
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478748; cv=none; b=ovyeG1vewRPky8RWJfFBy2pj3XvKeSY4NNOYknk3mILUr+sVJDKp6xiUkISCULUjA+V2mXlMHBhVoPn5evnMw1qZCs3/RYZ41I+8JgCVhc76UtjXKYWtmywHcyNCVSkkZjSq5V0Wsbf3shciLy32c1O6/FCMDxawFqHeWunOjUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478748; c=relaxed/simple;
	bh=ee9AjSrlAkHq8Clbv/XU0/FfKNhJJrpspEGqRrcs5WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMszrD/u4uA2lbUXAhcDzeerN6i0N4SgVLZFuUADkA61ZQCFOrQkZhw7aoti1YOv4VO50+JuLsJ5BncrE4S0YqnU7Sj+qYnTWlhFfUfhifatU4kTx4L0RNhAhyTzNWbSOsBFhvwNfcd7DHgf5f3LsatKqp7kWr7SmJbPp90wZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CxhvYqmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AZZRzKlM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CxhvYqmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AZZRzKlM"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 958B51140168;
	Fri,  6 Dec 2024 04:52:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 04:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733478745;
	 x=1733565145; bh=bhatoQYmIc73+1nkGgMLXLl6PrrppfKt2u55G31FkrU=; b=
	CxhvYqmCBFyy9eYROjY1UZHjprtS3PFeGyI3g0nkvbFthwRxveW3yNM2f2xU0tYc
	6Dslf2xHaKm5k14FDv7yveEsrvEI3Wl/8mhBmLPllXI9Q2l+a+WHwL+raUFSk1X4
	pN5fj4C8YOJHSiEerjYgVaLZ7+KF1W47XcVqudaRb4oaVVDf6efA6ElSk2vgcSUk
	6G8nUyHbk0yzCB4c8oZjqru5mI9MkThyr5QFAYzPkMlZEtFeJ1BoyhZCeAiDuyJZ
	l0FilzY7qQez+i8hkXAxVUkkgX/I6r+rLgQ3PgbAW7jej4j7p1kH1rxZs6LKgKj5
	kmBFj0+t7tgY6ilcMVWtcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733478745; x=
	1733565145; bh=bhatoQYmIc73+1nkGgMLXLl6PrrppfKt2u55G31FkrU=; b=A
	ZZRzKlM9PQlfB9pm1BJvwLtvnF7VUkaS6Iy5+JJUJyR6/JvIdT+EhSe3cEpjcCVp
	IViCFKSUysZSG0m5UFtM6FHmm/AcxSF0qMPYgBTiJEMg+54jQkkfVIf2dehfcSlK
	xAgwXazyZBClhb/z0BznuljyycZ1mQIsAI4hzK6cG2tQzDvIEUQUU9+aDsYtO4Hg
	1KuTmK3eQto8nDjEpllfh5ZfE+ZBqscx9MkmKUlv0RgxOVRQDw+ZBo3j9iQaaxIq
	BBP+E/JuttrjAODm+cSZDE6x9tcPWZ1xaBIg2pLYAe2A2cJsdYqlCB8YwQhCdbFi
	pX7HzfFaVpGjA+Y6Ulyuw==
X-ME-Sender: <xms:WclSZwRx4XOBMR45ephGbkVtRjgjVsr-lqdutqq2gr6HBSo00qJd7g>
    <xme:WclSZ9zSLNKxi7JHKOndsU1f5sOFnXfM2ShDVtdZsS4W4jqgoqFJHOX8W5oOyzaFa
    kIBVNSEPp85eorIvQ>
X-ME-Received: <xmr:WclSZ93Ht-QS8zNOSbu8lZVj4nMtLEs6tnBERK13ttHlTND53ULVnGD022TZ_dj3AxsmDEzkwWHZD1Jp5mgv4YI3n60fv2ymaZAJIt8Pmn96zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    grrghrnhhisehvrghlohhhrghirdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WclSZ0ATcKoJ6dyHCL8rhyOpNQGnNY_AxuZZPD_4nv--5eshCpAFJg>
    <xmx:WclSZ5h2R766FNB_hL-dfLYT4u3dG7IENaeplWEH9OAclU-DbKLs2g>
    <xmx:WclSZwqrAN6KjAcSaZpt_rwPiQ1Ijhd8I9EOli8hrDRf9aNjE1IX8w>
    <xmx:WclSZ8hgyesKtute7c9phW-1s5S2PRzrIHVV9IIuL4JFL3DqrMnDGQ>
    <xmx:WclSZ-una9zvEqQwKVW7v1c1HpuWc2IMg_-BeWT3RjU62OqsRZ7SZuMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 04:52:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 57dba076 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 09:51:00 +0000 (UTC)
Date: Fri, 6 Dec 2024 10:52:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Aarni Koskela <aarni@valohai.com>, git@vger.kernel.org
Subject: Re: Regression in :/ commit selection between 2.43.0 and 2.47.1
Message-ID: <Z1LJSADiStlFicTL@pks.im>
References: <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>
 <20241205173342.GA2593033@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205173342.GA2593033@coredump.intra.peff.net>

On Thu, Dec 05, 2024 at 12:33:42PM -0500, Jeff King wrote:
> On Thu, Dec 05, 2024 at 02:22:13PM +0200, Aarni Koskela wrote:
> 
> > See below for a reproduction:
> > 
> > * Initialize a repository
> > * Create a commit with message "mystery commit 1"
> > * Tag the commit with `git tag -a a-tag -m a-tag`
> > * Create another commit with message "mystery commit 2" (which should
> > be found from HEAD with `:/mystery`)
> > * Show the commit with `git show :/mystery` – it shows the older commit!
> > * Delete the tag with `git tag -d a-tag`
> > * Show the commit with `git show :/mystery` – it now shows the newer commit.
> 
> This bisects to 57fb139b5e (object-name: fix leaking commit list items,
> 2024-08-01). Looks like an unintended side effect, maybe related to
> swapping "list" and "copy" in get_oid_oneline()?

Indeed, that's it. We have this hunk in that commit:

@@ -1411,14 +1415,14 @@ static int get_oid_oneline(struct repository *r,
        for (l = list; l; l = l->next) {
                l->item->object.flags |= ONELINE_SEEN;
-               commit_list_insert(l->item, &backup);
+               commit_list_insert(l->item, &copy);
        }

The problem with this code is that it's _prepending_ to the copy every
time, and thus we accidentally started to reverse the list. To fix this
we again have to _append_ to it:

diff --git a/object-name.c b/object-name.c
index 240a93e7cef..4c50559ee8c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1393,7 +1393,7 @@ static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
 			   const struct commit_list *list)
 {
-	struct commit_list *copy = NULL;
+	struct commit_list *copy = NULL, **copy_tail = &copy;
 	const struct commit_list *l;
 	int found = 0;
 	int negative = 0;
@@ -1415,7 +1415,7 @@ static int get_oid_oneline(struct repository *r,
 
 	for (l = list; l; l = l->next) {
 		l->item->object.flags |= ONELINE_SEEN;
-		commit_list_insert(l->item, &copy);
+		copy_tail = &commit_list_insert(l->item, copy_tail)->next;
 	}
 	while (copy) {
 		const char *p, *buf;

I've sent a patch via [1].

[1]: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>

Patrick
