Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCF1B87E8
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095597; cv=none; b=kzpvSTc+/uZhi4qW78OOw27QeDgM6w2R2fjwkh9I4GcJiTVm4+CZYEWl792rTROKHClDlN1ehGKlKCZJ0/q4VBKEcsGmVn748WvmCYQ7BQ0nSzuWMKbU5tf1bd2B2iYG2eAHcqLyosin/y0O3BoTStK1QXOKnFzuAhLPYCA7Nug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095597; c=relaxed/simple;
	bh=VaCrpItujINQV75wQ1VHa3Oucua7HxNhfMsP392wp1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbDTet41V4qmoWCNRg8dkIft822tb8pdo23zZ8qKbFBxsZ57C5DkXA5arvsISIzLBKs2xZgVMcbOdDD+T1vv10JoN8FOY+awP7SJWSFQozoONF3e1auRROqh7sA3rkqGJvyGwVgmf6wIHLE0DPHX++XBoS3d6iMK5v2C3s8oj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TuUiXz21; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtuJQkF9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TuUiXz21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtuJQkF9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CEFE7A00A7;
	Wed, 13 Aug 2025 10:33:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 10:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755095593; x=1755181993; bh=B7/L2MuZMI
	am+ukEy3eFsIFkyAG1mF2jQRrNtamb29k=; b=TuUiXz21yPQl9j2MtpaXKjODbg
	0ebSI4iCzFZdeOaOgBgOAK2uvaKhxZs/kSYI/4BHH9VJ50Hrz/OsOJVM14RNF9Ul
	EYuBUOpks50x4RhdmDVmstvjdPudnEfYLosixrS6B4j0x6QITYDkst/8yBp/9tbn
	zVJeY73NP6ERNLIr8bK5fLZ8vzzwNxayr1E9SyicLnm2IicsYnMaunqizfY3e8JU
	v/OS+qsfsGKa6TraqkyZM4aTzpDsgy51kBG4oWAS40TIb1xlBcIc/VhEzubdFvTF
	PeAcK69Lu2NePI9dlowGWob3X46FhDvEIEnNTp2ZffOloITGIQ2Odq8UJNrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755095593; x=1755181993; bh=B7/L2MuZMIam+ukEy3eFsIFkyAG1mF2jQRr
	Ntamb29k=; b=YtuJQkF9JhocRxMtuL975WALv7hn8zZnR7QGxW0AXbVKTuR/7LZ
	RsffqUfUbh7np7+LMjXFmObEW/I9zXgyFYxDgCWi0mtzDXnVMGod1EJQcS/y5Ktz
	f+ZZjOMmFJmo6UWbvYrbgE6SUOoPAboiLiJ0OvUablRyo7u4x4dAWV0hOySxQWW8
	8uskZYYOnddGeW2PFpAEwW7eAneWoGK0Eg4MSUUIvDhz1VksoLGDiYfFERP9cRMD
	F6RcCVBjGFhM0qjiCvKBDWQw3mW3s5mneav/fRG1Yi6m1TP9c8G4vmP15RmaiYEJ
	D6YXcEME/rEzPZzqqMLxz4CtLE3NzS+Vo/g==
X-ME-Sender: <xms:KaKcaC2iOIUdjOK0ffV5oplRTX-lYlF4piBAotIzdhA2eq0TOEtHiw>
    <xme:KaKcaPqIN5A_zjmWSYmTQsZUazFF2iaV2LCDM6EsJiZgLTw07jWJuAHI5r5P_sG-J
    FZ6m2bx-yxzimNkIg>
X-ME-Received: <xmr:KaKcaHf8TTjvJYHPMEzMmEOCK5kl-U_qy1ObkEFEWPbsiW-h9a8EiO4ip03AHhX_UlQcukeN_uWyurgDXzJ2ZhK-9N88bJtr1rx15Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeffiedugeetvdehffevffeuteelhefhieevffeuiedvvdekkeffffdvieeh
    ffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtihhmuhhr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KaKcaGqe_KYiRPsJ0c3Q9yCF0qJHTy46jKzPBraVGbrV7mZ5FRBaKw>
    <xmx:KaKcaAH9MFQcAy3D0R3Pq3OcF03jJee7EO3ez89KkX8-ZDKe-8HpVw>
    <xmx:KaKcaOuyAX8HM-K76KXjphFPhdy2k_iixu24m6uORZTU7nHMcz8mxA>
    <xmx:KaKcaKU2SXBMhM2DPquJkHNMjAI0H9Pe45p6u9xcHPyiulhpCmf-KA>
    <xmx:KaKcaG_-C5OlwolQCxxaYTOK1xxLjQfeykC6Cl82MhFKZhFvKEKUpy0B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 10:33:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Timur Tabi <timur@kernel.org>,  git <git@vger.kernel.org>
Subject: Re: [BUG] suppress-cc does not support multiple keywords
In-Reply-To: <CAPig+cTvCLU3u5y23HSrbxovs8cjcJdOUj0e1G9Rg4F1AP0jAg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 13 Aug 2025 02:34:45 -0400")
References: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
	<CAPig+cTvCLU3u5y23HSrbxovs8cjcJdOUj0e1G9Rg4F1AP0jAg@mail.gmail.com>
Date: Wed, 13 Aug 2025 07:33:11 -0700
Message-ID: <xmqqfrdvp9zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... If there is any "bug", it's that the documentation does state
> that you can specify --suppress-cc multiple times (even though you
> obviously can).
>
> [*]: https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---suppress-cccategory

"does state"?  or "does not state" or "does state that you cannot"?

I guess you meant the second one; some other options like --to
explicitly say "multiple times", but many others, this one among
them, does not.

The existing text

        --suppress-cc=<category>::
                Specify an additional category of recipients to suppress the
                auto-cc of:

does make it clear that <category> given to a single instance of
this option is a single category ("AN additional category").


Perhaps a minimum fix would be something like this?



 Documentation/git-send-email.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/Documentation/git-send-email.adoc w/Documentation/git-send-email.adoc
index 5335502d68..b959e39257 100644
--- c/Documentation/git-send-email.adoc
+++ w/Documentation/git-send-email.adoc
@@ -403,7 +403,9 @@ Automating
 - `all` will suppress all auto cc values.
 --
 +
-Default is the value of `sendemail.suppressCc` configuration value; if
+Can be given more than once to suppress multiple categories.
+Default is the value of `sendemail.suppressCc` configuration
+variable (which can be given multiple times, one category at a time); if
 that is unspecified, default to `self` if `--suppress-from` is
 specified, as well as `body` if `--no-signed-off-cc` is specified.
 
