Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467D2907
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915651; cv=none; b=kv3qWSQQ5HLgDfdsglfbftGcc7SCpMY5OQd/LvuZBvRhq2kFiXQoFQu84UarPcezhutmxr1d7DAOyJafMgoomjjk/MDJiC59D4Os/Bl7GmXvHq53YWQa0GAMxBeH+8JnCsrMzQy/oVXYyIQHJY+vtSIKotqex2iTt1yehRB0gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915651; c=relaxed/simple;
	bh=Whv+xT6TQpKP6nC2mK5KEiFedw/CtRPUSuy0mBUa28o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7yl5BemrnSI6PM4jN0be8Yf+velmisJu/BDWMec1U9V0hJuVpyN/cLEN9u2520R2fbHtb3WuHyRjfzwAco3muDiDWOXb/DJ3lY7sluTjO9MdYxdweh51n0z2a4jrw0t56LnJm7kIH3poi8tesNfVdD8mIBF2IGtSHEMhkmN1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gF5vRkrd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9em/CNU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gF5vRkrd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9em/CNU"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 06427114015B;
	Mon, 18 Nov 2024 02:40:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 02:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731915647; x=1732002047; bh=+2zgnLeAtq
	OEagUC24uHVuGwZj3tnVn9B4XEFhrGHFE=; b=gF5vRkrd/QOWlCjtl9adnt9pTh
	M+aztE/sMTGtQ6s43CaCAfO43iBXstMENpZsiUVWwKUjyPz2YwNGCX0SSXXgbSSb
	46FLQYXnz+3cUy73q4+4mLDehfJPRTFfzpqIKM8KmITm6dqeVPrzFCqkpBhF7oMI
	qISKe4yjey7uB1vfbHoLyBUQG1nJysBBck9Jjj4smqcRV9GhQz+KnPeNBqU7VQa2
	PYWwJPP3w/FvqsnvNFDUS1Pq4jpYJjcitUXJSE7JHrBTcdMBvDiSEwS48FNcBKhw
	zfoXgOVC35L1HLpfVH5/IezNbUbs6FwOpEqCvKVMpvXwVU1WCgbdLoTsiEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731915647; x=1732002047; bh=+2zgnLeAtqOEagUC24uHVuGwZj3tnVn9B4X
	EFhrGHFE=; b=V9em/CNUnsj+YQ3nMZcJPh1QRKuGEqXMEhFSFuw6mmfcnk8f+N/
	7o7wSItfJUH6jNxnDwCmX67SvSkmN4ahyW4vkKT0CoRvwHkpLk/TXv23yTPEl/R7
	Z/KVVYUpNNWXTTq/bs9BpRxYFQQlals3GzgfagQVB7PkHjSViJ860f7wDoDgQPNF
	29ZCABh4hd351bdHdy8Uj0LhCBCvdzYViMCEaCcP0NiRFmjmJWHJUtDEHZBWkICY
	0vLftgNrKACFcbioNqXR0wPasl0b7daqJjNvrDqzVKwnSJpWXj4IpFmV+IRHoKmz
	onemj6iULsmcweLZom8W/4s7spZ89JjrOHA==
X-ME-Sender: <xms:f-86Z9k1nOH1MfmyxycCaRwUJop7552iE3zgGk342t-gKOufXpmokw>
    <xme:f-86Z43_5YGFQhIHxV6gaVzNT77ekEIs6hkgTBIoY1-GcULbsgKbYVpWONcPmWsS3
    pJcDhA5ORK0XuRvUQ>
X-ME-Received: <xmr:f-86ZzrV4sUoA0Zgruhfiuu39ZrhtkFoyecf-6rjyNdjNODu583a_fkg1g4RBvDnLyC2FNpLLRo9cewOsM7ZXFbYrEZP84ZguamhgEUmfTkzZ-cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhesghgvnhhtohhordho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:f-86Z9lRgi_xhaUdtF261ESMcZ-S7TlVcYACQRN7FYOgAD9PnV00_g>
    <xmx:f-86Z72TVS40OpU2tvG9AdvwimdN6fQWhSOuNmoEvqk0WDtuGStZ7Q>
    <xmx:f-86Z8tRTjZ6Dibbqb4eT3TvSMFpwHRC9rzugxMbmCBQTFl9Dhl4GQ>
    <xmx:f-86Z_XGlmCjdwBfK2sk5nns_oeUHLlfYFcTz8FvW7EQreQOBrb_zg>
    <xmx:f-86Z2RfXFqSPYfig3SYJOVmSEEHQ-oROrsh545mUkBnEbhxHQdJJiqT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 02:40:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 336e3e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 07:39:57 +0000 (UTC)
Date: Mon, 18 Nov 2024 08:40:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Sam James <sam@gentoo.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/5] object-file: move empty_tree struct into
 find_cached_object()
Message-ID: <ZzrvciXuOfw_V6ox@pks.im>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
 <20241117090842.GC3409496@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117090842.GC3409496@coredump.intra.peff.net>

On Sun, Nov 17, 2024 at 04:08:42AM -0500, Jeff King wrote:
> diff --git a/object-file.c b/object-file.c
> index b7c4fdcabd..5fadd470c1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -325,14 +325,13 @@ static struct cached_object {
>  } *cached_objects;
>  static int cached_object_nr, cached_object_alloc;
>  
> -static struct cached_object empty_tree = {
> -	/* no oid needed; we'll look it up manually based on the_hash_algo */
> -	.type = OBJ_TREE,
> -	.buf = "",
> -};
> -
>  static struct cached_object *find_cached_object(const struct object_id *oid)
>  {
> +	static struct cached_object empty_tree = {
> +		/* no oid needed; we'll look it up manually based on the_hash_algo */
> +		.type = OBJ_TREE,
> +		.buf = "",
> +	};
>  	int i;
>  	struct cached_object *co = cached_objects;

I was wondering whether we want to also mark this as `const` so that no
caller ever gets the idea of modifying the struct. Something like the
below patch (which applies on "master", so it of course would have to
adapt to your changes).

Patrick

diff --git a/object-file.c b/object-file.c
index b1a3463852..f15a3f6a5f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -321,7 +321,7 @@ static struct cached_object {
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
 
-static struct cached_object empty_tree = {
+static const struct cached_object empty_tree = {
 	.oid = {
 		.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
 	},
@@ -329,7 +329,7 @@ static struct cached_object empty_tree = {
 	.buf = "",
 };
 
-static struct cached_object *find_cached_object(const struct object_id *oid)
+static const struct cached_object *find_cached_object(const struct object_id *oid)
 {
 	int i;
 	struct cached_object *co = cached_objects;
@@ -1627,7 +1627,7 @@ static int do_oid_object_info_extended(struct repository *r,
 				       struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
-	struct cached_object *co;
+	const struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const struct object_id *real = oid;
