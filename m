Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FB01F78E0
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830224; cv=none; b=uvUNGEkKPOy1kNSvYCHtpiPStKXol6KJN7fAJ6TZp0zVeIqw7YS0Iaf/Hpo+TEzezmkPrU086IFa/AAJJh50AGgjdxSim4v1HXW2ivL+M1ho5wOBZrfolyv2aIoivFeEpIpI3CRhXZ36tCyBgRTwOvacM8z7BgxRP/nqg6ADsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830224; c=relaxed/simple;
	bh=arCEWQbd7FI7BpaK7WyvLfooBKplcqOzXQyQ93VDVhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TK7rrLazPiY8CZ/6jlIempywKOU2LLML327vID3O6MSW1wj431QilQtlH3f3XyNd/UW5S+oVS20zWagBJ/BUzjzt7i0Jh5Fzlpd1AmDMQqsVHltSGCaHAY6Xe9pJ+IOF+kd9Igkl6K8FpBODWaozUcbY7vbwkDP6T0T0c9SQqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yw4XRBMB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1CvoPIP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yw4XRBMB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1CvoPIP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 789941380384;
	Fri, 13 Jun 2025 11:57:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 13 Jun 2025 11:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749830221;
	 x=1749916621; bh=SwLFZbFPDU00v25vv26cLIMXIIz3jdYpbcyyNYmY7H4=; b=
	Yw4XRBMBlPtNW1eZlVIBdRTn4NjhVTJenWn29Ji0+42iFyRf1J7RBjmKaJECRTsE
	quTANKxsCukZ8dc36yIBoblba1aBG07fNlBXjmo19X8VdkYeW6k0OPVvU1rZDmvb
	Ow9L4mwoawqJ9yRDX4Nn2t52dLQ+c5PG1qCP+ifSQyCJCrTsRVPRj+Uh5WJ1yiuq
	3tJUFNBYmH7qk5HmmqRJK+O+gnorEPXoYnFUHj4N7uWSAE56vB8pOpiuapnqEOxv
	NHsv46+OZglnMuKdgtHe45cHxbQWWtT5d1K/NymlJs9oKFsIfcPDbITHjzQOgvDo
	FeW7FHhx82mVgLX47f5eVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749830221; x=
	1749916621; bh=SwLFZbFPDU00v25vv26cLIMXIIz3jdYpbcyyNYmY7H4=; b=U
	1CvoPIPkDszho3jzfMDqLWtluAUhVFPhGkSzkEWCoI5NOmOYLhgZ7JZ1lKmL5WN9
	5RLciai2nzpryS9eYgNKSMvx1DQKJvynXrFS0EWdRWj7hrK2blenlH837ykGD6Y0
	55+JwUTkdKc0PPXmXeM0vEx41/OZ7FIGnopUEWrYoYQAgUFTmAkGZynsOr/2QNQ1
	ZhP+FHEWvGDWMTT3Uayq5eHB8P75INOAJPS1chaG0gbcgbhbNJttqH25dEVRnEI9
	VU/Yq+OUlE0xoA81uz0MD84Zh68TmOObBZ4Mt9Qes6Fde6uB8+nN/h3TCeHZ7VQ+
	Izo1NW3CiV1g4hBJDsvdA==
X-ME-Sender: <xms:TUpMaNDDwIQam-PIFiHAiqDRf1dB7PWE63xU-B-ueIPffPRimM9tBw>
    <xme:TUpMaLhbtuHMbcIN4vMhg5DMEonjteeo25ju9eJlXbRW1iX_ozQa_UHDJwEkrPUnT
    -lLgMAAXcF5vR3UKg>
X-ME-Received: <xmr:TUpMaIm1DAaYGP8uRYSZL1m12XHhzcVHHWnym7ty9s1pgeuUpz9276RTOHjcap_6DP8vHe65Oc-udA6QY1H23pN2pDR-pCNT4eu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhht
    hhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihgrkhhlihhushhhihhnsehgihht
    lhgrsgdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TUpMaHzNsWt5U8HzI87zAmL1btemSj-ugS0aamnqhOzGpMC8IuDjTA>
    <xmx:TUpMaCSq5cvUfE7X1Ffy-ogIKciNzXcQEpnC3UnOywA9LkUvQyEbSw>
    <xmx:TUpMaKZlvLmwv4DRpdfENv40nenQ29GH34UqGCz4NWMzwyZNiVjulg>
    <xmx:TUpMaDT9L3QBtCkZ2UMjBJfal3Tj4MEGW-UvKSKTgkIZLh17aPv8pg>
    <xmx:TUpMaP3im-X3ffR815UByx5C75v3kS9hi7ejpROv4e4kZW7I4bMamDL5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 11:57:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git
 <git@vger.kernel.org>,  viakliushin@gitlab.com,  John Cai
 <johncai86@gmail.com>
Subject: Re: [PATCH v2] cat-file: fix mailmap application for different
 author and committer
In-Reply-To: <CAP8UFD37rFvhO_XLhSjZNoOQ_ePwrrALYBcqKHfhMKcpqhkP8Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 Jun 2025 14:59:52 +0200")
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
	<20250613115750.41205-1-siddharthasthana31@gmail.com>
	<CAP8UFD37rFvhO_XLhSjZNoOQ_ePwrrALYBcqKHfhMKcpqhkP8Q@mail.gmail.com>
Date: Fri, 13 Jun 2025 08:56:59 -0700
Message-ID: <xmqqh60jab3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 13, 2025 at 1:58 PM <siddharthasthana31@gmail.com> wrote:
>
> [...]
>
>> This bug was introduced in e9c1b0e3 (revision: improve
>> commit_rewrite_person(), 2022-07-19) when the much simpler version of
>> commit_rewrite_person() that worked on one "person header" at a time
>> was rewritten to use the current apply_mailmap_to_header() function.
>> The original implementation processed author and committer separately,
>> but the rewrite introduced this loop-based approach that failed to
>> properly handle the transition between identity lines.
>
> Thanks for adding this context and improving the `sed` invocation in
> the tests! Happy to stand behind this change too :-)

Thanks, all.  Queued.  Let's mark it for 'next', hoping that the fix
will be in the first batch in the post 2.50 cycle.

