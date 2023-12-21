Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC22206F
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Hdf3QSDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703161194; x=1703765994; i=l.s.r@web.de;
	bh=AGBlGZ1sf7HoI10T3mjvuKe0KOoiPf+ycPc7L5hTHao=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Hdf3QSDVL266gg/ZybOoX2PqBlz6oO7gDO6KgrKNVOW6qt149y3yTX6K2XJ+ovUX
	 FRjwwscemF3clxzUQEIT770PpDe+T08iUZUN9SwZ+nsQXcg7niuXGuWl4LM4WvaSt
	 gBOIIHPaTAYJbl9gfarIVKRFo/QR2Ve8xscTwTKgcqPrOcM0MlV+EN2rGM+XoijKC
	 /N3WF1QzMU0gSYFOVG1pYbYTMQnesGkqYDNfuvJny1IOC5fEZEbqXKSxlFSllRU7p
	 XPTcK8PVmxHa7qL/+tqAsmxhe0GeHzeLEdt/Vnv/NHwaQBxGlcjNmkMf0ZvQHS7MN
	 bDDhg1R12q6VA7Gu7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1rGqG810fS-0015G0; Thu, 21
 Dec 2023 13:19:54 +0100
Message-ID: <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
Date: Thu, 21 Dec 2023 13:19:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1006: add tests for %(objectsize:disk)
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231221094722.GA570888@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WLflaCtr9VOCPNurFYMR8hbB/hGVi46ehSxGFGZryNAlvoJnQ8P
 HgjPljimzGSNUsUDsCc5ryndoDG0ba1c9uavq3zK29Uil4Zh460Jt9fwrg3VsqTnqeNyyMt
 YhFnD/e6s+Ge/wmznwj8S0eGz2kuacSNmBlNfkuj5su8e6Q6dWjdGyKpffq3JgwqXIB4ixA
 EpQXPfuKwD+JSBZGwZI0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rHuiNOEnT90=;iNlZhmbmhcXHWohvWtX4ysp3uid
 0b3n5PG/Uc987+VfZsYjIRKhmCxjHf/SGXOsoIGSagNZ7lNa7rw/jxAqAWJO+aeAJmU88RquS
 Lh6/1HgDuWnHLA9Lstivc8yI9mz5utwO8HpmPwjPhy4Z9O/oVvS19ARfFf9MVDLD3ZvUotsQu
 T46X7c94IZSylF+VGPuxNulFZcDIL5pHW5clhOC+0XtjhebcS5gAPFUWw1ckL7OttG9cbOAKR
 9UHFBHXJFlOksJyzajsyJ/LCjDVMh4Iw4YatQydDluuhuELV24fl1drYXXNQT+M81a56Ngpbw
 hqk+UNZ7/GGwgkxnb5WGeSKR5MHhQZPqIGYRILPra2zUdB5ZLUMhKcJMMMr61V2Y3ZEIE8g3d
 niNNgNU0vwDV8tjEPfWD6dhAmgFd9VLoPCG0qHY5HJ5KN98W0KhtPYClqleHJB+0J8Ql9XmZl
 +iM5AxfTQNyifapMNdtFb5juvILxLeiUP/qkN62hzv/2Hbujwwn72q/6lPSNOLDiOoCS4++Qg
 1xQoXehoI0C9QuuA9b7aChY/460E3aLkO6FJ5L2K73M4a4//NNQnijf28h4aSBG5fROpLrPHh
 oZR4/KfoTJZKsuMqekTywrTCBbYqOtsX0k3EgQu4aZdYnaqxfALkeHw4dVvQqWfm9vIdVmXsO
 gQ1hjjWZ2cEywyF+LishtMchp8J70uIIMreYr1Ko07S4Tj6V+HKtZFRTmNcG1/cmwZuinmiN2
 N05DE+MWDRkBAykpLLB5aZVFsHaE+uM/ndvhAXZv6TiWtJ5MVNAuIR6upKUhAYd4xiTJcOENh
 0KojjAwQZpJ4JFvaO5CwOw0ZA6KBJME4gOwwGxjTaZtsBXYGDZxkIi/ViN3X300Krpn2cHz75
 R44Zxc8jqFHkkuHgNN46qvEgF83loedQ45Jf9LNtUOdSWAJTuB2oIlGXhnq7jnYFgbHX02Qnz
 irC5mA==

Am 21.12.23 um 10:47 schrieb Jeff King:
> On Tue, Dec 19, 2023 at 05:42:39PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> This adds a packed-object function, but I doubt anybody actually calls
>>> it. If we're going to do that, it's probably worth adding some tests f=
or
>>> "cat-file --batch-check" or similar.
>>
>> Yes, and I was assuming that someone else would be eager to add such
>> tests. *ahem*
>
> :P OK, here it is. This can be its own topic, or go on top of the
> rs/t6300-compressed-size-fix branch.

Great, thank you!

> -- >8 --
> Subject: [PATCH] t1006: add tests for %(objectsize:disk)
>
> Back when we added this placeholder in a4ac106178 (cat-file: add
> %(objectsize:disk) format atom, 2013-07-10), there were no tests,
> claiming "[...]the exact numbers returned are volatile and subject to
> zlib and packing decisions".
>
> But we can use a little shell hackery to get the expected numbers
> ourselves. To a certain degree this is just re-implementing what Git is
> doing under the hood, but it is still worth doing. It makes sure we
> exercise the %(objectsize:disk) code at all, and having the two
> implementations agree gives us more confidence.
>
> Note that our shell code assumes that no object appears twice (either in
> two packs, or as both loose and packed), as then the results really are
> undefined. That's OK for our purposes, and the test will notice if that
> assumption is violated (the shell version would produce duplicate lines
> that Git's output does not have).
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I stole a bit of your awk. You can tell because I'd have written it in
> perl. ;)

I think we can do it even in shell, especially if...

>
>  t/t1006-cat-file.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 271c5e4fd3..21915be308 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1100,6 +1100,40 @@ test_expect_success 'cat-file --batch=3D"batman" =
with --batch-all-objects will wor
>  	cmp expect actual
>  '
>
> +test_expect_success 'cat-file %(objectsize:disk) with --batch-all-objec=
ts' '
> +	# our state has both loose and packed objects,
> +	# so find both for our expected output
> +	{
> +		find .git/objects/?? -type f |
> +		awk -F/ "{ print \$0, \$3\$4 }" |
> +		while read path oid
> +		do
> +			size=3D$(test_file_size "$path") &&
> +			echo "$oid $size" ||
> +			return 1
> +		done &&
> +		rawsz=3D$(test_oid rawsz) &&
> +		find .git/objects/pack -name "*.idx" |
> +		while read idx
> +		do
> +			git show-index <"$idx" >idx.raw &&
> +			sort -n <idx.raw >idx.sorted &&
> +			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
> +			end=3D$((packsz - rawsz)) &&
> +			awk -v end=3D"$end" "
> +			  NR > 1 { print oid, \$1 - start }
> +			  { start =3D \$1; oid =3D \$2 }
> +			  END { print oid, end - start }
> +			" idx.sorted ||

... we stop slicing the data against the grain.  Let's reverse the order
(sort -r), then we don't need to carry the oid forward:

			sort -nr <idx.raw >idx.sorted &&
			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
			end=3D$((packsz - rawsz)) &&
			awk -v end=3D"$end" "
			  { print \$2, end - \$1; end =3D \$1 }
			" idx.sorted ||

And at that point it should be easy to use a shell loop instead of awk:

			while read start oid rest
			do
				size=3D$((end - start)) &&
				end=3D$start &&
				echo "$oid $size" ||
				return 1
			done <idx.sorted

> +			return 1
> +		done
> +	} >expect.raw &&
> +	sort <expect.raw >expect &&

The reversal above becomes irrelevant with that line, so the result in
expect stays the same.

Should we deduplicate here, like cat-file does (i.e. use "sort -u")?
Having the same object in multiple places for whatever reason would not
be a cause for reporting an error in this test, I would think.

> +	git cat-file --batch-all-objects \
> +		--batch-check=3D"%(objectname) %(objectsize:disk)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'set up replacement object' '
>  	orig=3D$(git rev-parse HEAD) &&
>  	git cat-file commit $orig >orig &&

One more thing: We can do the work of the first awk invocation in the
already existing loop as well:

> +test_expect_success 'cat-file %(objectsize:disk) with --batch-all-objec=
ts' '
> +	# our state has both loose and packed objects,
> +	# so find both for our expected output
> +	{
> +		find .git/objects/?? -type f |
> +		awk -F/ "{ print \$0, \$3\$4 }" |
> +		while read path oid
> +		do
> +			size=3D$(test_file_size "$path") &&
> +			echo "$oid $size" ||
> +			return 1
> +		done &&

... but the substitutions are a bit awkward:

		find .git/objects/?? -type f |
		while read path
		do
			basename=3D${path##*/} &&
			dirname=3D${path%/$basename} &&
			oid=3D"${dirname#.git/objects/}${basename}" &&
			size=3D$(test_file_size "$path") &&
			echo "$oid $size" ||
			return 1
		done &&

The avoided awk invocation might be worth the trouble, though.

Ren=C3=A9
