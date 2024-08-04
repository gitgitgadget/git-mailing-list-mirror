Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAF4D131
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789529; cv=none; b=PWNQ6jbGHG78mboQW1TbLwo84hEUT3iQUJIygX3XkR/RbGCMA/KaGS2KxfR4iy0KFwdrHHT4k2VPtJJYqM9etDWAmgEDQWzhgZnQOIj05cNvtTG8/IWnRmSUeCrsf2DNPSwh7xzH0bC/+TAdXhF7ErQIDH8TGae3lC9uTiqNWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789529; c=relaxed/simple;
	bh=1bmKEMhcRY4Cf04um4BWorwa+bvAZMWPQkdyUyp4qbs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhE4Hv377+HgMCncOg8yIa/GatqgSTLWsgMr6IYhGj2bqWWSMSio0ghLNR9iN2tASFgcnEbU2ut8X4S+QYcOlj2+ZNnr55a90khH9NENQnBFn3oQHgA6rDrsk/mBKmLvXM5rD/B18Is08rBjvn/Rfj1i5SY3ZP0Fd+63Q55WK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 474Gchph3994830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 4 Aug 2024 16:38:44 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local> <032201dae461$c7bcc9d0$57365d70$@nexbridge.com> <ZqwvQUAqVozGHG/t@nand.local> <040801dae528$70966d10$51c34730$@nexbridge.com> <Zq+mF2fyL5hux+3k@nand.local> <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com> <Zq+qHRwHC3sD14eN@nand.local>
In-Reply-To: <Zq+qHRwHC3sD14eN@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Sun, 4 Aug 2024 12:38:38 -0400
Organization: Nexbridge Inc.
Message-ID: <04f101dae68c$c57574b0$50605e10$@nexbridge.com>
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
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBAbmv8+0Ce5iwkALnbZ/bAmhVbPMC8lvinAHmkHLnsPkHh4A=

On Sunday, August 4, 2024 12:20 PM, Taylor Blau wrote:
>On Sun, Aug 04, 2024 at 12:15:41PM -0400, rsbecker@nexbridge.com wrote:
>> After git repack -d --cruft --max-cruft-size=3D1M &&...
>>
>> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index <
>.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
>> fatal: unable to read index
>> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index <
>.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.pack
>> fatal: corrupt index file
>> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index <
>.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.pack
>> fatal: corrupt index file
>> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index <
>.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.pack
>> fatal: corrupt index file
>>
>> Apparently, something is wrong. This is an ia64 Big Endian. Not sure =
that matters.
>
>show-index expects the contents of the *.idx file on stdin, not the =
*.pack.

This is what I get for being 1/2 asleep on Sunday.

./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index < =
.git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
138 ce6131022c3a48a15f4b7a68afb6ecf3b3bcb0cd (03c2fd95)
12 d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e (64dd3dba)
183 df967b96a579e45a18b8251732d16804b2e56a55 (879729b5)
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index =
<.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.idx
12 ad16bed54cc61cf036075879deeff95ae977514b (239ee6ff)
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index =
<.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.idx
12 4f336f3df31054eabc05ac05f98bc024c8e05423 (24bc6ce2)
./trash directory.t7704-repack-cruft/max-cruft-size-prune: git =
show-index =
<.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.idx
12 bd44d8aa2d22eb47ff70cef4b0bb45d1549ee49c (c2c93868)


