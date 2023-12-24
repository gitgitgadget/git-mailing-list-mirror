Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AE15D5
	for <git@vger.kernel.org>; Sun, 24 Dec 2023 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="j7T32c3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703410221; x=1704015021; i=l.s.r@web.de;
	bh=lVjKuoys85CC7bYNnsr5fzI8cAkdoTptbiKolHAe9Lc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=j7T32c3ccfKRm4kB45ZPLJV1kUnGucu+FUTnNh82qgauVxaPGDgO1oc8kPBh7Ow4
	 udkP0x6g65pUZufeRo+j3yiqQS4Uz+vflJSC1QKIKLsEizSujmlMt05YhlD7plIpg
	 eXEB8j+h4lt03eCQRj71wzv+b8K4Zja/jpFNsPuYYdXx9nk6RI+a1E0xinx5N2bA6
	 /6H5yhN9tlemDGqxKbTGztE3abwwl97jMeYEikRITgS7tojvq4xmqms4be5UVCiRE
	 7r4PQ3HoHS3klxBaMVxmcfI5dzrvexBoXz2XZ0T35ZTvcbZ0bhNyr1TXqudEzOVKN
	 kabP7pa/wW7TPJV+5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzkSZ-1r3dgS2b5N-00vXSV; Sun, 24
 Dec 2023 10:30:21 +0100
Message-ID: <62dc66ef-d669-4486-be61-8d50bf469627@web.de>
Date: Sun, 24 Dec 2023 10:30:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] t1006: add tests for %(objectsize:disk)
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
References: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
 <20231221213034.GB1446091@coredump.intra.peff.net>
 <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>
 <20231223100905.GB2016274@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231223100905.GB2016274@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RH+69BvAQYVZEDVszz/grY7BfMOA65GhpO2OYK2vX/ZXH3Dw+3h
 fWVqZyFJX3Lbdz16iUP5JlCMArfyHcku2oJfR9hd9OO5eZijlsLxqDbIdIlikdarGndkYV1
 uV5RWMoSORsP8PoAbS/oi19FCTw4nqz+/zF9Ev52SKQLPXwXZ3FdEeGqHTiuvH3pwBc7xt2
 GAVW/qcNXsUPfWN3eJrIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c5sWHK83Nqo=;1Tgk3U2yQVAhrjaXzSPuryrfYsG
 /cLKD4ZlEhCdAykUuV8zqnR7bBv/+0/2DI2eWX9gro9FeqZKqvB0viDmi20eyZ/hEr5tlHg4c
 IcwUHrdNesnvJHv07UkFVXjtxOYTl8BOArpsVL/scOhyShYR8DbJ/ygwBqc6j3EFd5cu1uH7z
 wDOpnKnPjf/F+pNtbGn8YV+/YxQ6IAmzUHTx4DV0ABUz8THxB/sWe11PPjuaxb33nk+XnqOLG
 CvRSOZLmb1oyiQI1Jd67j+fAeuBV81xokSGaPO6LicF8XnHPxQ2hf6XfthWWL0IVAOqJTaHrC
 3wwLHN3Wm5e5lyVOKS9oxgZ/mLWmeEKTxMEznFqpWieWv4V7KtNJh6HTZCMmGlyegdmQhvM8k
 J7DWSDAVsutlKyYOsBGEfM4bwbjG+Ra9gbcA8hMEWdgC6HjJuBsKgyp0COeRYsjfwvPYGR5CC
 tFW3tYe9USgjgk9aVmKcg7kFOZglFUWht3HcUbUu9weo4uynGfCOnleyPsoUjLo/4TQymeYL8
 QNpF/TBVSlCX6/1Q7vdbgWqRLaEwf/amTxciKc0BHY3jYcD4S5yq4t5OCk+gYUXVNiiRjL3+u
 Gy8P1MP/fhBbE8PdJ6KRs1fuQJ8QLh5/DYtDO+/VQKJLBlNTCPRA856Qha+MqA4/VjS/U/KQI
 WPWS7Ol+R1nBLEwne+ld5Exm0bhKOtlqCs2PUOwofs0sQh40VJ3/zeZI+oZ23zq9PrhfXdYlH
 0MVBpSIr8SH38z4/KgXmhFosiFMK9hP0KaaF/XDUGj3TWChA7qH+i4IaWX6fYaUq0PT+nPARh
 vnDxVr5huYi64ihl97XtLQ3F8ngsQ/v1cKqdACvjj7eu+/1hNeggveGqhs3uJ5UFu2ZgAyks8
 3Lhi2lQXEdElzCG0vvwcEGG8AORTlHxHHHo/tYzjg2tX/pytoxGbIszN806WNku9JSLxmbfYp
 pNyToA==

Am 23.12.23 um 11:09 schrieb Jeff King:
>
> ---
>  t/t1006-cat-file.sh | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 271c5e4fd3..e0c6482797 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -1100,6 +1100,42 @@ test_expect_success 'cat-file --batch=3D"batman" =
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
> +			sort -nr <idx.raw >idx.sorted &&
> +			packsz=3D$(test_file_size "${idx%.idx}.pack") &&
> +			end=3D$((packsz - rawsz)) &&
> +			while read start oid rest
> +			do
> +				size=3D$((end - start)) &&
> +				end=3D$start &&
> +				echo "$oid $size" ||
> +				return 1
> +			done <idx.sorted ||
> +			return 1
> +		done
> +	} >expect.raw &&
> +	sort <expect.raw >expect &&
> +	git cat-file --batch-all-objects \
> +		--batch-check=3D"%(objectname) %(objectsize:disk)" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'set up replacement object' '
>  	orig=3D$(git rev-parse HEAD) &&
>  	git cat-file commit $orig >orig &&

Looks good to me.

Ren=C3=A9
