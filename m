Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B24350D5A
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768907; cv=none; b=R6QelZwEcRjxkffSuBnZUDLaWLiDiK1ysdN91olYqP1pL0vvhX9lirLT/oBYRNZ7E5VAq4GMXaQr16KsdoVuMBUECpC+LSOvoDjxNE/eNHp9wPEgvb3qLZXEyR131qB9dd+2PXXjSF89raZveWV/bAki9Lxn5Ifq0DK7HxpCDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768907; c=relaxed/simple;
	bh=S28FZ5zmtg5qz3/RMjQP+89etBXhLyXWsQpqA/mlqO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W+MJVO8WK85+zrg0N35wpc/naKmMFsoWXhdq0Q8nCEa4/2zAxbD33MZJnC7fLy366yFFXgM76eSWz7XEB//MtyeI09t8QUta71Ry00PnuIxmNdMtwm3xTmQ3k6Hm9ty8aYoNux1QldyAWceXiqq+xtApDflRqyoj86liGNmMBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F3eO2feM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acrRViwg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3eO2feM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acrRViwg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C84C07A0166;
	Wed, 29 Oct 2025 16:15:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 29 Oct 2025 16:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761768903; x=1761855303; bh=5OvLe0dk8H
	2V9+Q0M9kgj2ZVwu+7WPLWQuy+YVPXDqU=; b=F3eO2feMKNZfX8lt/kMFXhG9Vp
	HVCQ4KI5HjvygXNEgSgFpT8FkCceiletn7QyiechuVw88litzg6cOQUFXbkV+Oje
	0JGz5VLCJR5qosH53UudYAx6Su9DkF34sSpYuX+B1fL9oRsmCYNQTOK8KVWKfcDK
	H/Tw7+MM0G4zp0TEcp5r9SwquPnje0WzAQbC0lDgSJdf1pXGDRgisTY+CY23yE1h
	j/TZ8EwIMiH3S7T5gtLB3TS+cByzM3r3FZ9rsyjwtH1lrZfThe8yc4FUyIkUIOoU
	gYK5dChmOb84VPbsuC8qHPaLDBMB4cdlcLlt33gtRfht5sTIxenMxNXIR4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761768903; x=1761855303; bh=5OvLe0dk8H2V9+Q0M9kgj2ZVwu+7WPLWQuy
	+YVPXDqU=; b=acrRViwgM08GBn8OVGmG1/lJjIIwhSRDOj/FaPAMhK08OXBkxzn
	Fuzoq93a7PCkG2ZpLTizs1UH+FTKmKZqIOXR+D8ETAe0BR5HNW9/0SnXl+dwT0xw
	TjKWFhxUVKOgMF3N7KA5Czu0YmoiBgug/um0/80WgEGXD5EzszTLnJl2LwB8BMrr
	okKRF2/NBe8CcNB1whKn1CGsRDq0mhv6eAW/HxWI+WZrDje1JvOktv6tXxByHuAg
	XjQXFQ4WnmQxfCZYA/h+kpn7eEj/OOiDkD0R7HZqyv+Pq2Sti0fJpKjsWLBRDkap
	sBqfGynzgpgko7ajiIXP9vRR6Y6ifoBr72A==
X-ME-Sender: <xms:x3UCaab1znqDWbqnAkcqOUAEymEXMqvXphKN3OJfL9a_uwtdOUmAcg>
    <xme:x3UCaUSiBr8C8Rr3xE07Me9-NpHROdn34bWx3NdyoUJfblhBC5a_x_s3afU842Fq5
    jsEw00YmsZB6Odc-XW7W331VRPRgbGpyYxGy1sjtxhOFYOT924b>
X-ME-Received: <xmr:x3UCadTBXn3DXWanvxJ0gVTHsIKwkQ9jSZoE5qx-pNR2mLNIav3bKgA7eWt9xi716OoOww3LdM2soPsaQDnQzwyTqTZgLrvn9Jw_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephffgtdegheeiuddvjeevteehiedvfefhveduhffhveeljeffledtvdegkedt
    hfehnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhgnhhurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x3UCaYQpjpB4Ti0J_NQjrH2fnWmKhVto1-8xKgVgtVQpI9Kwid8Usg>
    <xmx:x3UCaS4CmjgbWZPH54q509qVK1_Ew4ckX98ttOCtx1TxD1yDY_aa_w>
    <xmx:x3UCaU2b7GHlbgFP6piJy64ln6piJaxOMBz1oIxavIcRMY6xfn9THA>
    <xmx:x3UCadCVeowpKqYuGvQFi_Cah5iEPQ4cUPcD3tQAnIKCvSOfAhs-WA>
    <xmx:x3UCafhJx7YWGzrmiR31LO3pV2nm7vlcbLK4R6mvRvK0Peklmr37OhI0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 16:15:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <xmqqecql8oau.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	29 Oct 2025 13:07:21 -0700")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqqecql8oau.fsf@gitster.g>
Date: Wed, 29 Oct 2025 13:15:01 -0700
Message-ID: <xmqqa5198ny2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> We either need to downdate the syntax or do the following, but IIRC,
> 1.77 is a bit too new for the Debian oldstable?
>
>  Cargo.toml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/Cargo.toml w/Cargo.toml
> index 2f51bf5d5f..7772321dd7 100644
> --- c/Cargo.toml
> +++ w/Cargo.toml
> @@ -2,7 +2,7 @@
>  name = "gitcore"
>  version = "0.1.0"
>  edition = "2018"
> -rust-version = "1.49.0"
> +rust-version = "1.77.0"
>  
>  [lib]
>  crate-type = ["staticlib"]

For now, I'd add this on top of the topic and rebuild 'seen'.

--- >8 ---
Subject: [PATCH] SQUASH??? downgrade build.rs syntax

As the build with "make WITH_RUST=YesPlease" dies like so

    ...
    AR libgit.a
    CARGO target/release/libgitcore.a
error: the `cargo::` syntax for build script output instructions was added in \
    Rust 1.77.0, but the minimum supported Rust version of `gitcore v0.1.0 \
    (/home/gitster/w/git.build)` is 1.49.0.
Switch to the old `cargo:rustc-link-search=.` syntax (note the single colon).
See https://doc.rust-lang.org/cargo/reference/build-scripts.html#outputs-of-\
    the-build-script for more information about build script outputs.
gmake: *** [Makefile:2964: target/release/libgitcore.a] Error 101

work it around by downgrading the syntax as the error messages suggests.
---
 build.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/build.rs b/build.rs
index 136d58c35a..3228367b5d 100644
--- a/build.rs
+++ b/build.rs
@@ -11,11 +11,11 @@
 // with this program; if not, see <https://www.gnu.org/licenses/>.
 
 fn main() {
-    println!("cargo::rustc-link-search=.");
-    println!("cargo::rustc-link-search=reftable");
-    println!("cargo::rustc-link-search=xdiff");
-    println!("cargo::rustc-link-lib=git");
-    println!("cargo::rustc-link-lib=reftable");
-    println!("cargo::rustc-link-lib=z");
-    println!("cargo::rustc-link-lib=xdiff");
+    println!("cargo:rustc-link-search=.");
+    println!("cargo:rustc-link-search=reftable");
+    println!("cargo:rustc-link-search=xdiff");
+    println!("cargo:rustc-link-lib=git");
+    println!("cargo:rustc-link-lib=reftable");
+    println!("cargo:rustc-link-lib=z");
+    println!("cargo:rustc-link-lib=xdiff");
 }
-- 
2.51.2-698-g3eff15350e

