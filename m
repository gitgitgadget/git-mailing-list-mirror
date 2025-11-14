Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3842FD7B9
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154705; cv=none; b=ky751IXCj/a8/sPhoXyieU1ebvmaDD24g4irOy/0yZ1QxkZ22uEU0OVr7cSH3ZIpOnk2q3znTkDZDjqfPyzvgCl11TGxdMC6XuQ2ifvPyFUazvOiFVIb99rZmorYwUqDg3Zp76xVXj+hFghFbI0Bm/Tgdryn2pWO7NX+CYzY6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154705; c=relaxed/simple;
	bh=tVM52vMc2kg1l4sHHBdW8HYxig1itc6sx1pRrV72Qa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tb3+WeR9hjRmPurrDqQXpgyF7fzrtA4dXmvPNgANlBgeF7+zqabJXmo821DFFImsLD8dWrsW6CxYrS2Nw/3uMcVKYciGbQgkR8T9kUkdWJMb4nQAbHhHjSwMYX5Xx/gEyusWfW3zjpJRg0ET9fLUR3UHSiB+OHsnv7Ak5ayM9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fnFAFxLE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZMhrONd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fnFAFxLE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZMhrONd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 40930EC011A;
	Fri, 14 Nov 2025 16:11:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 14 Nov 2025 16:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763154702; x=1763241102; bh=Zqbcd7xT/y
	WnMv7UNFeAApSRh05bVXdweFm6gA1yEvc=; b=fnFAFxLE0cRrQC3L8R8qOXLdkp
	sx3zm4jWS6X9a5FQvogzo4PFYMvFxfI1ShJXMUMb1xifLb2fppjfkSnVRLVVQKvh
	8XRYTwQxoiJ/1LlACtfJjL3XkMcjgNNsv0j3MGmdQCCRSnwqLFkgzloEhTkhBUhE
	25jGBqQ6CUh1Uko9EpUhRBj8IPALkVHI7UMqMvvKfNaWrOkeUoxYL2qvoWj0wgwJ
	Foj+pO/mzgz1XMYTjQK2vUGxTMR+CELOdkIZAcMr4W+FBHmpZLn4iE5H8V1NdcRz
	92rWW/t8as1nKQB2+VwHwPEII3wJNoZQKv6C6imoR7f2agzvuUBgye/s2t8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763154702; x=1763241102; bh=Zqbcd7xT/yWnMv7UNFeAApSRh05bVXdweFm
	6gA1yEvc=; b=sZMhrONdICLI8jCPeOxEYFnBcjhyWYqxJJyD22wLaJm6EyMo1KG
	qmWFZlRrENAYkQBEjhWWEjlqHoU9819fxsikw/pOJz8Sz2wvQP9lC2d4ZvrVYumU
	xkv/HWa475bJcB/Te4ljbWNv1dKTwUWYYRCQuI0rhSvmcjNOEhGEViUsbAnStVY8
	UQcM3YNge/sKkkFP459SYjmNOLi/dbwH0bXDyNbTUbKUYYsyW0FavnhEREm2R43T
	wZMWfRbaOajyeF9AgaNv62nsHT81KpXqDIU/sD6rH1XVIc0NjRaAwPMCDomems4k
	Y74WD9ygCD703dYZaV3plOmmejwDZP1TDUg==
X-ME-Sender: <xms:DZsXabJTz28OEFf27yZMnOy3jcw95Twj57AFUYiOO4jKkkHaP5na9w>
    <xme:DZsXaWB1vX-XbtcGebvni0s-D3gq1msGdv2Qui4vyiQ-f6eJigUopm_xBr54FLrgj
    sSDDuq7EXaaGsjT55v_R8wj8VkWb8UXd0etvzTiqzfJJqZvkbx6>
X-ME-Received: <xmr:DZsXacDMsbIqBO8MyvardDwltTGdHx8EYRQ-S1n9OqlCpJ1a1jr2QKfDevRvIWiQTkx3ircp18cnvita10bAjGDwdlxP9AYZM7vy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DZsXaQDYSZrroqP6GrXkCiiUL1Nz_k7iGXrJwb61az26JaTI-xaEsA>
    <xmx:DZsXafq0ll6qwmNRmpGfmGPPDEEZi9YnUGdOcLKf_v-nZduhn2Iobg>
    <xmx:DZsXaSkEOFPlg2sCBfIcCHK9O6RQ2nT3-oqUSkVCYvILdMQCvIXfLg>
    <xmx:DZsXaXzjm3yCGQOBsDkoLWY9hKrubInGgiSN518mANhTiu5Mi1YUpw>
    <xmx:DpsXaZS_97Lxd6lOaVYjGs-7Tb8YDCykKMJin9OtozGMNVod32dgIeIb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 16:11:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <xmqq7bvsjzlx.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Nov 2025 09:25:14 -0800")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqq7bvsjzlx.fsf@gitster.g>
Date: Fri, 14 Nov 2025 13:11:40 -0800
Message-ID: <xmqqms4ogvzn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> The new Rust files have adopted an approach that is slightly different
>> from some of our other files and placed a license notice at the top.
>> This is required because of DCO part (a): "I have the right to submit it
>> under the open source license indicated in the file".  It also avoids
>> ambiguity if the file is copied into a separate location (such as an LLM
>> training corpus).
>
> You may be aware of them already, but just in case, I was looking at
> CI breakages and noticed that "cargo clippy" warnings added in
> 4b44c464 (ci: check for common Rust mistakes via Clippy, 2025-10-15)
>
>    https://github.com/git/git/actions/runs/19346329259/job/55347554528#step:5:73
>
> mostly seem to come from steps 12 and 13 of this series.
>
> Thanks.

This is what I queued on top for today's integration run in an
attempt to work it around.  I am happy about the changes to
assert_eq!(*, [true|false]), even though I may not be happy that
clippy is unhappy about this particular construct.  I also am not so
unhappy with the "do not needlessly borrow" changes near the end.

The first hunk in src/loose.rs thing is a monkey-see-monkey-do patch
that may or may not make any sense, which I strongly want to be
replaced with a proper update by somebody who knows what they are
doing.

 src/hash.rs  |  2 +-
 src/loose.rs | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/hash.rs b/src/hash.rs
index 8798a50aef..cc696688af 100644
--- a/src/hash.rs
+++ b/src/hash.rs
@@ -310,7 +310,7 @@ mod tests {
             ];
             for (data, oid) in tests {
                 let mut h = algo.hasher();
-                assert_eq!(h.is_safe(), true);
+                assert!(h.is_safe());
                 // Test that this works incrementally.
                 h.update(&data[0..2]);
                 h.update(&data[2..]);
diff --git a/src/loose.rs b/src/loose.rs
index a4e7d2fa48..8d4264c626 100644
--- a/src/loose.rs
+++ b/src/loose.rs
@@ -700,7 +700,8 @@ mod tests {
         }
     }
 
-    fn test_entries() -> &'static [(&'static str, &'static [u8], &'static [u8], MapType, bool)] {
+    type TwoHashesTestVectorEntry = (&'static str, &'static [u8], &'static [u8], MapType, bool);
+    fn test_entries() -> &'static [TwoHashesTestVectorEntry] {
         // These are all example blobs containing the content in the first argument.
         &[
             ("abc", b"\xf2\xba\x8f\x84\xab\x5c\x1b\xce\x84\xa7\xb4\x41\xcb\x19\x59\xcf\xc7\x09\x3b\x7f", b"\xc1\xcf\x6e\x46\x50\x77\x93\x0e\x88\xdc\x51\x36\x64\x1d\x40\x2f\x72\xa2\x29\xdd\xd9\x96\xf6\x27\xd6\x0e\x96\x39\xea\xba\x35\xa6", MapType::LooseObject, false),
@@ -741,7 +742,7 @@ mod tests {
             let mut wrtr = TrailingWriter::new();
             map.finish_batch(&mut wrtr).unwrap();
 
-            assert_eq!(map.has_batch(), false);
+            assert!(!map.has_batch());
 
             let data = wrtr.finalize();
             MmapedLooseObjectMap::new(&data, HashAlgorithm::SHA256).unwrap();
@@ -754,7 +755,7 @@ mod tests {
         let mut wrtr = TrailingWriter::new();
         map.finish_batch(&mut wrtr).unwrap();
 
-        assert_eq!(map.has_batch(), false);
+        assert!(!map.has_batch());
 
         let data = wrtr.finalize();
         let entries = test_entries();
@@ -886,16 +887,16 @@ mod tests {
             let s256 = f(HashAlgorithm::SHA256);
             let s1 = f(HashAlgorithm::SHA1);
 
-            let res = map.map_object(&s256, HashAlgorithm::SHA1).unwrap();
+            let res = map.map_object(s256, HashAlgorithm::SHA1).unwrap();
             assert_eq!(res.oid, *s1);
             assert_eq!(res.kind, MapType::Reserved);
-            let res = map.map_oid(&s256, HashAlgorithm::SHA1).unwrap();
+            let res = map.map_oid(s256, HashAlgorithm::SHA1).unwrap();
             assert_eq!(*res, *s1);
 
-            let res = map.map_object(&s1, HashAlgorithm::SHA256).unwrap();
+            let res = map.map_object(s1, HashAlgorithm::SHA256).unwrap();
             assert_eq!(res.oid, *s256);
             assert_eq!(res.kind, MapType::Reserved);
-            let res = map.map_oid(&s1, HashAlgorithm::SHA256).unwrap();
+            let res = map.map_oid(s1, HashAlgorithm::SHA256).unwrap();
             assert_eq!(*res, *s256);
         }
     }
-- 
2.52.0-rc2-455-g230fcf2819

