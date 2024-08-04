Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3B63CB
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722798950; cv=none; b=kY4Zm4nvdCQl0Vf6GJF7dJx7B885hRwReLZL9MhfMhyfaPbv3vUO08Lv+ScXH2G+ptcXnn8lUN4VWzu/jPlAZEsBwY95J6Z4c4RaAeKw0+PQ9Ge6ujJBVeWXYfMlKmm2R4Yb8YorJqXliHxn0xR7UKaUWhYhvnbwjwsQmNPdiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722798950; c=relaxed/simple;
	bh=wBVWBDzz7AB3ZEVZgjgj7WwJQAwbEFep4Hrjd2SV79w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHuICB/+EZNYYC3DoB8KSNsM4GIJ2wqztymy1pAm/syJr1BVGcNK6badUkonq043WqdQqL4+ufYyOUxp/HsFwGXHuPOT3vfxBy9QLuwb1U44mNVI5eZsA4x8m7046XokAeYcr5+OQNOMvMMjBbPxTPYYqg/Kw0MrrRmxzSwkTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 474JFjs04012088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Aug 2024 19:15:45 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local> <032201dae461$c7bcc9d0$57365d70$@nexbridge.com> <ZqwvQUAqVozGHG/t@nand.local> <040801dae528$70966d10$51c34730$@nexbridge.com> <Zq+mF2fyL5hux+3k@nand.local> <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com> <Zq+qHRwHC3sD14eN@nand.local> <04f101dae68c$c57574b0$50605e10$@nexbridge.com> <Zq/ElpJpbcUqB+4e@nand.local>
In-Reply-To: <Zq/ElpJpbcUqB+4e@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Sun, 4 Aug 2024 15:15:39 -0400
Organization: Nexbridge Inc.
Message-ID: <04f901dae6a2$b4e0c210$1ea24630$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBAbmv8+0Ce5iwkALnbZ/bAmhVbPMC8lvinAHmkHLnAtYWESgCIvtXa7DRao3g

On Sunday, August 4, 2024 2:13 PM, Taylor Blau wrote:
>On Sun, Aug 04, 2024 at 12:38:38PM -0400, rsbecker@nexbridge.com wrote:
>> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git
>> show-index <
>> .git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
>> 138 ce6131022c3a48a15f4b7a68afb6ecf3b3bcb0cd (03c2fd95)
>> 12 d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e (64dd3dba)
>> 183 df967b96a579e45a18b8251732d16804b2e56a55 (879729b5) ./trash
>> directory.t7704-repack-cruft/max-cruft-size-prune: git show-index
>> <.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.idx
>> 12 ad16bed54cc61cf036075879deeff95ae977514b (239ee6ff) ./trash
>> directory.t7704-repack-cruft/max-cruft-size-prune: git show-index
>> <.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.idx
>> 12 4f336f3df31054eabc05ac05f98bc024c8e05423 (24bc6ce2) ./trash
>> directory.t7704-repack-cruft/max-cruft-size-prune: git show-index
>> <.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.idx
>> 12 bd44d8aa2d22eb47ff70cef4b0bb45d1549ee49c (c2c93868)
>
>OK, so it looks like the first repack is doing what we expect:
>presumably the first pack containing three objects holds the result of =
"test_commit
>base" (and contains the blob, tree, and commit objects for commit =
"base"). Then
>I'm assuming that the remaining three packs hold $foo, $bar, and $baz =
in some
>unspecified order.
>
>So I think that everything up through the first repack is doing the =
right thing.
>
>(As an aside, it took me a while to remember what was going on with =
this test. Since
>it was confusing to me as its author, I figured it may be helpful to =
spell out some of
>the details. We're just making sure that pruning a cruft object works =
with multiple
>cruft packs, and we're adjusting the mtimes of the *.mtimes files =
themselves to
>ensure that they are rewritten during the pruning repack. Those =
adjustments have
>no bearing on what actually gets pruned, unlike when we update the =
mtime of the
>loose copy of $foo, which does affect pruning).
>
>Anyway... in your setup it looks like all three objects are gone, and =
we expected only
>$foo to be pruned. So I suspect what's going on is that this test takes =
longer than 10
>seconds to run on your machine, in which case it would fail as all =
objects would
>have passed the 10-second grace period.
>
>If you apply:
>
>--- 8< ---
>diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh index
>71e1ef3a10..959e6e2648 100755
>--- a/t/t7704-repack-cruft.sh
>+++ b/t/t7704-repack-cruft.sh
>@@ -330,7 +330,7 @@ test_expect_success '--max-cruft-size with pruning' =
'
> 		# repack (and prune) with a --max-cruft-size to ensure
> 		# that we appropriately split the resulting set of packs
> 		git repack -d --cruft --max-cruft-size=3D1M \
>-			--cruft-expiration=3D10.seconds.ago &&
>+			--cruft-expiration=3D1000.seconds.ago &&
> 		ls $packdir/pack-*.mtimes | sort >cruft.after &&
>
> 		for cruft in $(cat cruft.after)
>--- >8 ---
>
>, does it still fail?
>
>(There's really no reason to have --cruft-expiration as short as 10 =
seconds here,
>since we backdate the cruft mtimes by 10,000 seconds.)

This worked. Even taking it down to 100 seconds also works. I suspect =
that the reason this previously passed was that we have an unrelated =
heavy use looping process on the box right now so things are taking =
longer. Running verbose also takes longer.

