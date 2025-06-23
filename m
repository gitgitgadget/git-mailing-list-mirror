Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9E1F94A
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692674; cv=none; b=U37CyrTV6HDTq1UDaXNDj6mOot9WWn6HDvbwJjm8PM86vFlIq2KZzjd+g/ocvVKqVkaIrvrMGRXnC/baQv+zVSyNjBwOD1cymjN+D54RVeY+evWQULzaol923nN5orMl8RmZZn2NHC1QoeYJB0sLTeabhNAdM/4TMD1bMYL+w40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692674; c=relaxed/simple;
	bh=hDgKjw3jGLXnSw0OYOZFbrLTgvDqyCntedTf7yXWh0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/9Eepx0xQZAWvRfxA7rBY6yr4vokGSScdCQXlygTEYaPY7Oj5DJ4uVa5Ru/sRzdSPWX4/miWC6D7Xm5/FuXgf2YEyCzuzfhV1Lt3MRz63I0fYljVD81QAy1ftqiW2bEmHkyfH4EJj985qSh8ehwgmHvwG6bbdncQJSBM/Ni1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZrvzMT9M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aIX6fK3j; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZrvzMT9M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aIX6fK3j"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 59C6E13800D3;
	Mon, 23 Jun 2025 11:31:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 23 Jun 2025 11:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750692671; x=1750779071; bh=OaqeXwlIqG
	tuFXLOIgvN9xhAJ2yNOnmOVIQ1WElWF94=; b=ZrvzMT9MS7srcmS70hhygEdPAv
	v6WyrmQeAfTi4IjrfDp4aFmS1/y0C+tD+TWpU5T67V0YDfgXl9gUUtVpTWSd8kfb
	Ya/d4GjrTTUZAePnQNN8B2B3KUrqG81+yqohJ8QmqEWWDLEaZcIdArYyFaUw2f0g
	BRROKDSOB4qfKLjNHugdZQJZNqIp15M7wXKLms7piFIW+UEe9oMEsTVezLWrZwko
	21T689hhT77EhXbmMXJkkM0e393y9U6NilhrLugzbfrva6q+R+JlIAkFZ54efDAU
	pg/VbFY2Vf6MrqSA16Xi2RqSbdRjYjV5WtpKkW3Yf//EfLOFgrM1NbE5Gd5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750692671; x=1750779071; bh=OaqeXwlIqGtuFXLOIgvN9xhAJ2yNOnmOVIQ
	1WElWF94=; b=aIX6fK3jmVPxnyhvUn3830POvX4YkBttbtMsg79HoxSkBItysej
	UlMdUQWFJ+fdXmHAZAEodZyyxECITYT3S8Q1uOFzdmSCxKUkyPzgHY/WxI2SZuf2
	HE4ythub9qGIJGPfvbdi/PZajJ0Sap0Tf54ZgCLsFi1+Md5r3tig0j+t7GUQRw/E
	mKyMaS9rAJPvkYbvNeUVm/kGNIoEfH3irFE3TsFm11QoDK0hRytRrTiASMO6mysC
	JKa7v0yAzn0daNuIlJ+T+zNNNqwyAOykI8YuubkoWUER7Qa2p/OigLUIAYIf37al
	0lyZUPmD1Q25ar51CIWGr81jKxzT/KwNsJQ==
X-ME-Sender: <xms:P3NZaJ7CwZebKwTHH7HXFnBTJM9NJs9dUtrMaARfG3pF67yo4KOjTg>
    <xme:P3NZaG7t92fX7v5qkzbXI0Qmtwwl-in-RuHsYBWq5uYEafVESpnhcX_xqg2bpogAV
    aNh5ZNKcT6Tj_0maQ>
X-ME-Received: <xmr:P3NZaAdEqUC9A-WlGFDkagbHWT7BrhmeSdwARnCJBgXhsM0Br3J8Mg_OKeIJlEHXtIGdhdkqnJ95NVbb4zt5tFirp2cTktWGU80YxNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghfkgffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhieeflefgfeeuudejleegtdfhie
    eivdffteevfeeivdevhffghefhhedthfejvdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hhrghsshgrnhhkhhgrlhhlohhofhdvtdesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:P3NZaCKth6hMgLgFbPddmj9zDpeZeZ3vf3UBzuDNnGPiJhyFnFcFmg>
    <xmx:P3NZaNIH7fpLLKWyith6eS6JaVVbjDNLpt1oMNxhlQ4fYNo7wDEsig>
    <xmx:P3NZaLyccZ5-TjXJFGEaRUe4UgSbX_SXcDdBhQWGUNp9qMGtG0bB_g>
    <xmx:P3NZaJI1HoFL5cvdWLAxEqYBRi92UxsWs0Ls53lqdhxCfH7anGY7RQ>
    <xmx:P3NZaLBGrmUHwQq70EslYLyAzi0fVYt3AUuL184M3Nw70DIGgOs-mqe5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 11:31:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kryzet <hassankhalloof20@gmail.com>,  git@vger.kernel.org
Subject: Re: repository maintenance: git prints warning messages while
 cloning https://github.com/git/git.git
In-Reply-To: <20250623103550.GA649507@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 23 Jun 2025 06:35:50 -0400")
References: <CAB2ApcOds+SZszEHhMwG5YvxQcRE01jKgP1modo1WhcwWeGeYA@mail.gmail.com>
	<20250623103550.GA649507@coredump.intra.peff.net>
Importance: high
Date: Mon, 23 Jun 2025 08:31:09 -0700
Message-ID: <xmqqsejq79vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> You can safely ignore them, but if you want to quiet the noise you can
> put:
>
>   [fetch "fsck"]
>   badFileMode = ignore
>   missingTaggerEntry = ignore
>
> in your ~/.gitconfig file.

Very true for people who do not have much control in what objects
are added to the project, but for narrow audiences who hack on Git,
it is not advisable to use for in a repository where you are adding
new objects, using versions of Git you are experimenting with.  With
these configuration, problems in these two classes in your new
objects will also be ignored.

Listing names of these objects in a file and pointing it with the
fsck.skiplist configuration variable is more involved but exempts
the listed old-and-known-to-have-known-kind-of-funnies while
noticing if you add more bad objects.  If I am counting correctly,
we have only one bad tag, with 98 bad trees.

Curiously, "git ls-tree 10344b81045" (just picked a random tree
object from the list) does not show any bad modes, as the code
normalizes the mode bits while reading.  "git cat-file -t tree"
can of course show the badness on the same object.

$ git config --set fsck.skiplist .git/objects/info/fsck-skip
$ cat <<\EOF >.git/objects/info/fsck-skip
0323c14ecfac54b060a52ef54b9ea38377adede0
0776ebe16d603a16a3540ae78504abe6b0920ac0
07c2d8f92d55b9ab885c10bfa862e652dcc40ee5
0965df45db7cf28dba93b554bdf26b61e8b950f7
09c369f30a7ec350dc98496c5cb752280f6dfe51
0ba51186089993112337d5b34a9ee23fe7cf4fdb
0e70cb482c7d76069b93da00d3fac97526b9aeee
0ff673eb3c120d8d2f2c327e7a772f2e4f902809
10344b81045df0a2cea3e76d325df5156c0294ab
10b554bd1513e33b7054c02eba9cda69bc29e187
18e4bb98e1e685dfdd798048ada57c925ee87aee
192f84588c8e47a2d8ca3d0c6e50641b7a2491b8
1e474a8671630eca49f3a94145045903a22ffed1
2031abe6fdaa115800eb0c5cd66ebf265d17b3c3
2660be985a85b5a96b9de69050375ac5e436c957
26f176413928139d69d2249c78f24d7be4b0d9fd
298e5d544d67bcc11e95aa6b04f1069a9cd959e6
2b5bfdf7798569e0b59b16eb9602d5fa572d6038
2ce9f0ac1f9d9035ec6ca90ec4f3922a127c6c02
314297184c51fc558a83b8701a83f28a0e740d7a
31f24db6e3e3f70191d95bbe7a06a2b1bb711d99
364de08062838733978d41da581fcdbb73c4f1b9
3d00c15360e1aea2a51558e5f56b95d11e9d7010
3f703cd0cd32a4aa9892bda84c664c36e40f7921
406548bda4dfb72566db6e515e38604a7641ec15
41bcaba0309c151fb38f82135d9b011e2066d130
41fa9643de0044c75ac654ab2dd2319f1bf3b640
420f7beb8c3b0e8b7a5e6e8dad92e1246e1dcfb3
426bfebd8064b754e1f6ab7ad6ab81801310043d
4cec02b6467ecc33662b8b691c604d1a80ac4a1b
4f856748145b27bc669a98cd4d66574dfd01b083
5319e4d609cdd282069cc4dce33c1db559539b03
53cbeeb5b30e9a9e0759fad94a9e2d24aaeff53d
5588456a03dc45bc5cc026a7e61ecb86bdd10c38
56763d1f057cdc4bf4e60cbec69b51593f9e3bd0
59c9ea857e563de5e3bb27f0cb6133a6f22c8964
5b009b1f6683c4e167d4d13816a7303a4d74fe1a
5b140cab879595232bb13fe3007cdb14ed267db6
5c9ee24e27939640e18088e56f40373fa2620b0c
5cc4753bc199ac4d595e416e61b7dfa2dfd50379
5d374ca6970d503b3d1a93170d65a02ec5d6d4ff
5f3fcd81f68f4031cbcfcadd5c368104ca0969a0
5f7966de3b4b60260db3b510e6efeab94e55f37a
60f9d89665bd7623ef43c2b2dec7645bbb08c778
6722a6e40e1edeeec7cd4c527a16a51553074130
6795adc096e36c7a7f8e6a407297727e61d4d083
67d4a7bf52c33e679b6e398d1113a33b072d942c
69bfdfa541c368a47a86482dfe66e488b152fe3d
6bb02c5dc7e827fd0fb0d36ae92d14e25318bffa
6c8b42ad4851c05a0a093af5468bdcec6367b7e8
6ce87c726d7f7724a6441a1a94f2fc18314c5cd4
6dfeb7c11933067d0517ee8f862430e83ae33d29
747fe6bdc82aff5407221eff645656932c66ae63
75a725933087584bb4de417b38588f2b3dcc2943
7ab8bf31e1f8df4e485bbf198c2579fc6b2b5cb9
7cb7710ccdcb867bf190b70d4586593bbad49499
8156e162365f85a1712373132bd8bb3ba0209537
8294109a769dc1f2ae9c4c622c2cf3f82531d80a
82e9dc75087c715ef4a9da6fc89674aa74efee1c
832c112baac6645c09b4b30f79c263c679e54994
83941fd0e146733198bcc5fe8c06d50dc9e6c225
8bd5667ce5588ab02c103c9aa8d8f1c6e90da56f
8caa89079f408d056c20ae13a2a62cb2148ccd2c
905781d15f6cb171e9c4360465905c7c27f835ee
928b601edc5e57a3998233b5593de63f90d24671
958b0946a5082fbc6797209fb225f5d7a786b786
9796e3ff820daee2ce8b2439f237dff900769db5
989bf717d47f36c9ba4c17a5e3ce1495c34ebf43
9999cff451d3a833ca39981d6868fdb452449f13
a2438d35e51d7bec87ca5231c0e8f7fb9039ba56
a384894f34b2360404231ed72b3beb136876e16b
a4944100a4832f8fce1494e2e8cbea74e349f731
a851ce1b68aad8616fd4eed75dc02c3de77b4802
a869cb0789d8ad87f04d28dd9b703f3ff343a4a7
ac0272a74f3bf08bdc6c403dd624048521c89021
b474d669fad6d037c18c0d232aef579a65ae101b
b65f86cddbb4086dc6b9b0a14ec8a935c45c6c3d
b9be893a0014c33d0b825cd9588566825c129a4b
c084af1ee14b234a73d47e2bb3fbf3617837e16d
c48c95c3b53b9a16518955e1271ee3dfeb093f80
c9a4eba919aaf1bd98209dfaad43776fae171951
cc2df043a780ba35f1ad458d4710a4ea42fc9c17
cc4cf7c0e5833fdfc4999d33d5b652afa4858bb9
ccba05512dc3b5f46c5fd5caadb40ce79ffb944b
cf88c1fea1b31ac3c7a9606681672c64d4140b79
d32ad1f96650d7da0d9b7043eeece8235da67b82
d4a96ba891017d0d26c15e509b4e6515e40d75ee
d64c721c31719eda098badb4a45913c7e61c9ef1
d6602ec5194c87b0fc87103ca4d67251c76f233a
db8e952afe1ad62c4bc5989ef3d2292ef4aa4d4f
dd229923a70e17998038996d66d4562df16f6d28
e022421aad3c90ef550eaa69b388df25ceb1686b
e03fa31365b953db15f3dec6810aac4a58678e6f
e31297f6bcdec878e0054ae10066e2aaa0495fcd
eeb0c5958781ed3ed29c42b488a556676cd71ab7
f2745cc464cc08214719d9f6ac71fdda9d6417a9
f403f5914294bd2769c9ebab7607d90abee915ab
f519f8e9742f9e2f37cecdf3e93338d843471580
fd8bcb6bf8499aca79300df577d2c9b8cc898f1b
EOF
