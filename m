Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF1208D0
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424826; cv=none; b=lRG1oMeStak/kSxWDlRI1SFItWWbuy6pZ+6QaujU6oA3BNW6MHE1ZQhvEOHHvmDAp6bRtbaegiIUFsHyTy/zuue/mNKJBTdix1tpBJsVCR+/ZxiCxvfzalRBVD0JqcxlSt2I+U1iWb0b1mjJjwDNCwY2aWe2X5aHr9QgQ3cH3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424826; c=relaxed/simple;
	bh=8szR0hA/D6RpRDmQPtLJlsCxAo8/0UeLUozshM1XqD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoB5YLnf9Jh38YWpM3PJNhcf7sdQVl4Ja2Z1REQfi6LyGzBQWOpz4SZeFKaSX2ChPwxUZarw3N5lshtv8bSCF74h7rq/SOItLyuvK0BgXxqbPz1WYRmy+sSl5mC4nOzbzniOKZ4Uy2+C2EHBs9TZz5dIdTCT+/1fVkLEfrrKt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z7sFALje; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+PjHvdC; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z7sFALje";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+PjHvdC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A0FC81D000D0;
	Mon, 17 Nov 2025 19:13:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 17 Nov 2025 19:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763424822; x=1763511222; bh=Z5knoMUkfe
	tGGOJrRPbz5a1NYmdJ1F+S8ngtZaY8qLc=; b=Z7sFALjeGoyvp3la/yd2rX6ciI
	T1Yr8C/paphVEU7FHz1yQoRtxDP8WCAPpRRR0hO/lh5/w+5LGbKPuVXQg7d9Ju81
	zbSoAN2oR5rOMgDbkbiZMf8jclXdR1BzC311d8ehwRINui+cLwCWbiK3GORorTbV
	Q1bimVUEK/X84LL8hhYaCi0qbqgM18s5ZyxfVglsLLBK9nUB7VfJ5WKqeengUGtd
	hOCV8+0LMiQ0uxbvE7zGEOl83GJixLVDojluhTp6ssJ24pzexnSgTk1VM371mClK
	1YqKYVzG7zUNIW5LUn5cagLDC7owmMRINy8sXjrdApH0olzwog5utsjGeu0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763424822; x=1763511222; bh=Z5knoMUkfetGGOJrRPbz5a1NYmdJ1F+S8ng
	tZaY8qLc=; b=R+PjHvdCYAVJWnDWU0s7u2mX4sN287FFV8Y9LvxAecB+JI5AL6A
	sIDlB9R3Nyc3IgtFkyMEyO1C2ok2Gil5pqzgffUm48VuziyIKRYHX3iQYk+Ip0AK
	/0Qe04SG8BkB/nskWuAMh2WUj7K50cEcrLKItmfLCcMs/2bWWi5DE0r6Q9u3BVKe
	Br8rrbyq99I3xPoGruaHPYW00bw/CA7nK0jLjdmCc+WQwm9czNRCrcrpZff4zY2V
	yxWSWSO6ItUbwwpT8aDtcr/XtCUeo3hkOO2QBlRuK0CYYjBEflkPI5+/WZzWMWGo
	1oY5mhiilmraVnGZNRhqMis+NiFxWzRgngA==
X-ME-Sender: <xms:NrobaWfE6Au4xgJ1r9gKLFc6kjXJuCgOSPpdCNOBUFggasUFbtmdYQ>
    <xme:NrobaXEQsa52HeT9pQTO_pmu4diWS6ZXxkd_QqCcBYI0qZuBQ5zXbrgrYPcK4KzOP
    hIPxggmiqZo1djgiW442wuyCqo4lGGcrs-N9ea3f8KobOdrJPnluA>
X-ME-Received: <xmr:Nrobaf0YaD9JNkuiHFoCMxzpP75pCzPZBbVYAS_GwoxV7jV6S0DhS8Ld91_a70LUmDokFcCCu_25_oY3WK6IdKMFuzN_Ul3ICV2i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelkeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Nrobafkbo3oK8aej4sgu_xtEEWSLPGv9ncFBUVY4P3nwkD9-ZrwMag>
    <xmx:Nrobaf9bNq_Z6ktXpV94xXIzdqXtVFxZwF5KGfTLDAhWRAm6gWKyNA>
    <xmx:NrobaUqf3GVf4z2qiYwhvbU5n0ZtzwgURnKuPJdL88dLYs9oYr5JLw>
    <xmx:NrobaYmWffBEdE6LMZ-bsE9P-6kr2hHoG0IhSWA_-MqI_unEyjfC0w>
    <xmx:NrobaQUTqW52dvbR3njHNQFbLtDovGRrVx1dfSLNjzTWx_m90vBUdr-r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 19:13:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 17 Nov 2025 22:09:50 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqq7bvsjzlx.fsf@gitster.g> <xmqqpl9h9mgo.fsf@gitster.g>
	<aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
Date: Mon, 17 Nov 2025 16:13:40 -0800
Message-ID: <xmqq4iqsgpu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-11-17 at 06:56:07, Junio C Hamano wrote:
>> In addition to "cargo clippy" I reported earlier (and attempted to
>> fix) in a separate message, we have been seeing constant failure of
>> "win+Meson build" job at GitHub Actions CI.
>> 
>>   https://github.com/git/git/actions/runs/19414557042/job/55540901761#step:6:848
>> 
>> I attempted to build tonight's 'seen' without this topic and it
>> seemed to stop.
>> 
>>   https://github.com/git/git/actions/runs/19418361570/job/55551045554
>> 
>> This topic may need a bit of help from those who are clueful with
>> Rust and Windows.
>
> I think that has been failing with Rust since well before my code came
> in.  It has failed for me for a long time (well over a month), so I have
> just ignored it.
>
> I'm going to send v2 shortly, but we can squash in changes and do a v3
> if there is something actually broken in this series.

Thanks.

    $ git log --oneline --first-parent -4 seen
    3f252ac9fe Merge branch 'ar/run-command-hook' into seen
    672cb7c62e ### CI
    3af201233b Merge branch 'bc/sha1-256-interop-02' into seen
    950efaac03 Merge branch 'cc/fast-import-strip-if-invalid' into seen

It seems that 672cb7c62e (which is an empty commit on top of the
merge of v2 of this series) fails win+Meson

  https://github.com/git/git/actions/runs/19447841443/job/55646336507#step:6:689

but 950efaac03 (which is the merge before v2 of this series is
merged to 'seen') is happy with it.

  https://github.com/git/git/actions/runs/19448271167/job/55647611566

These two runs roughly corresponds to the with=bad/without=good pair
in the message you are reponding to, but with the v1 of this series.
