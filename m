Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7A246760
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454460; cv=none; b=BvPjFR8uOU+cczDMU6dszfNim0UZSFvvAHEP6wlmQp5+aMYfyLKJHAuTYK9aIPusgtdYCkpJjawY3yCbgXRSW55FcpQGJ/maB8s7IXb53XQPO0nj8EyaHIY7uWfFDOgapwbEfbnI3mNAM5TONvjTKpibMBfNAkAONCjX0nf5caw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454460; c=relaxed/simple;
	bh=0GTn75DdssOtFx/iD6D8qtBxXdcQzpcEjUZ+/e+o3CI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAGAZQyl3ehP8bWfMIB5szfykNHgLJQU/chlFAW5f9c7mfGFpRVxyW+KWQdHnUQGN20BQecKfuKwTqJPW+wufMUoOQAgJus7G0mRlIUMhRvbmC4EmHKaP0PoHOgeKDupfYF02HZzbc/Idz+L0QnEVVm51K6wnYlseeY6aUMO7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ECAbnjC5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RyWWairs; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ECAbnjC5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyWWairs"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 18A66EC09DF;
	Fri, 25 Jul 2025 10:40:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 25 Jul 2025 10:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753454458; x=1753540858; bh=0GTn75Ddss
	OtFx/iD6D8qtBxXdcQzpcEjUZ+/e+o3CI=; b=ECAbnjC5Ep/8+havu3iINErJeD
	pVSBjO+rErp7du68LcdFhBMjpdiBBpzyr/6JOXOFrtcyceJlAZPQ/0qhaWQ0LVl8
	XpA6DzkmapzX74EjGq4C3H7iu0v5h6JW7/nNps4Q6oFOy4k/5DLVyshZabsVDNVy
	nHLeQWW9MHGoaSCt+YzCugrLPhQR19pzOjCRTVftfTAJWL9p/DToWU0Pn+HRK4qS
	Y3x3qeJ79pKiAPe1TPCrBYgv+LeyHvLQOB86Q0ijZfIW2e2i040E4JqbKxgvDCyo
	fUFvj2kCEEAQBOKmXU3Xcg579TG5ESgZT7/uhf4v4WI1rmkaGQYBpZCMOqdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753454458; x=1753540858; bh=0GTn75DdssOtFx/iD6D8qtBxXdcQzpcEjUZ
	+/e+o3CI=; b=RyWWairsEsVnShu6OMk4tpAivNKTTpuioeDOLagLQeuguyr+7k8
	KsCXMwcx6qSPcHJEn3J61LLhMHRJFJAGwQqAqKxEQ4Vt85B6bKNSh/RwNp6ffu2t
	SeAJLtU+/RaPovlidZ2yTANgESd/YBQ9P9qw4MkpW76+a/5CbBc5J9/LkZLua6PX
	sFO4e9oMYqJS7B0NKAQaX0ilJDB/a+2hc17FNTqBxcbIsyyc+WNo+5uxk5yXpzKF
	ttM66Z6bnTbczyr1s6razNr/QY8R2sDwsM3rMyOdly/4dQR2TCrnnnFAeywS3tnQ
	PEvveS8iMvUgmOJPFDbGV8kGtp8YK3lIOwQ==
X-ME-Sender: <xms:eZeDaFqQVYuewcGZmm2E9TgIFm5d45l0kIPL16p2Azd10tyidtBHFA>
    <xme:eZeDaIYhjbhT9dnYy4eGgG5b7A8Otoi1ifbaHwyMoPjRjX9sC4uL1JnQ72-YjWrAW
    xW-ous0GNU_f2MB8Q>
X-ME-Received: <xmr:eZeDaOXI7QpgqoctOkjBzTii7HAWDUVuLEVELEwGwMptQF-xxxAlXTU6ppynScpx76AncVvf0eh8OlCEOgWx3ewxOOPvlmtvoJIQx3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghmrdhsthgvfhhfvghnleegsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eZeDaB--4CC_96luuCHZJtaeRqmmc36hP7SLBZEcnWY-6qQjFwhT4Q>
    <xmx:eZeDaH_R4g8Iq5haT2HMrPeG5f3BblMPWV_wI9w9gfZ6NKr7hyzi3A>
    <xmx:eZeDaBQpI7o7QhYKQ6Hx3DgQ_CDbjmIoDhyLBDRCsbw6AO6b1unQEA>
    <xmx:eZeDaLfj_5x8Wsj_CXJNIzDwsv8DR85_HZ4Z0bRkzcfryW_a0_LsWA>
    <xmx:epeDaD1HSyfTq_kdSBmBRLiymRCvej9Rm8F9iwAIuRg4nZrCU3hf23yf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 10:40:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Cameron Steffen <cam.steffen94@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: Show skipped commit message after rebase conflict?
In-Reply-To: <CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
	(Cameron Steffen's message of "Fri, 25 Jul 2025 09:14:36 -0500")
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
	<xmqqwm7xxn4a.fsf@gitster.g>
	<184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
	<CAAVFnN=q5nCD3K1jppVcq7qB9P5WX0M070jqR_rey2hzBt0ERA@mail.gmail.com>
Date: Fri, 25 Jul 2025 07:40:56 -0700
Message-ID: <xmqq5xfg5o5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cameron Steffen <cam.steffen94@gmail.com> writes:

> There is already a message that prints in the case where a commit is
> automatically skipped if the changes are already applied.
>
>> warning: skipped previously applied commit <hash>
>
> Potentially we could use the very same message.

Yes, that sounds like going in the right direction.

But only if we can positively tell the reason why there is no change
relative to the parent commit _is_ because the commit we are
currently picking has already been applied, that is.

I am not sure how you determine that, especially after giving
control back the end user upon conflict.

Thanks.
