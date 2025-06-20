Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC644C80
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750378855; cv=none; b=Rr/KEUtUBpD4Fcm2XrNi0+JomZ0x8TqhAz49VVPdeOzI3MgFb3fEGrZ1GXiJ3GDlgjJh8TJukFuea/ACkw7xOUjpXlaRIKd0SLt8X0fFk1SWrZBxTD9FEkQ4hBG6NDmxeGc7ENOcVVgZkvSVuH9X0HHDHvd+X3SIfBgec8jGLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750378855; c=relaxed/simple;
	bh=BoZjgQ8yG4TqXlS9LnLvAUFNVGAEK80XIgWQOkhUUKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hB9hOrsKmORrwvrlUdmEQjAwUFHaWMRL9O7ovNbLmWKwpQBDKlo0XcK4T7sJBtn9EzHTjyjPT2lzN6txMe4HB/XWUedQhDwQWkzWBCvMlnEBObWG619LaEXta+ktu6vbyppOutxDzEnvpf43zJ6b3OcdgX7g+jovdk3YsEcli8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SfI3HR2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCyyPakH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SfI3HR2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCyyPakH"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FB4E11401CE;
	Thu, 19 Jun 2025 20:20:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 19 Jun 2025 20:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750378850; x=1750465250; bh=M61fq16hzN
	RQQHMU9iKRG10+njGRpKev7lnWy40pYgo=; b=SfI3HR2NrOSHM1q890P/EJtvWe
	Jy5Fnk3qXcZ6z4jGptqw0VtHDQOQm1m8Yf7WQArySpS0MVkUVkUzJoI3lchRnhmx
	/X4fL1RBGsaf4+id2QCumfTilTPkBAQS8Poe5o7qp3jIouc5MDjDdIcr3aKR7X32
	8TyPUG9mhtA+3I3FRFCQCsscrXnu/w7EyS8ra0EsU4S3feo30070B+clJDdczkko
	RhTU4q2pWR1ZHfofKwsLK01Wf/8c5xmy2Wv99X586OmKr8+9R6+Do/+lyDTDEU9+
	zx2MWnciClDIdpi4QL2GllQTQhyxhce51QNwqqj+yzig+OS5W7VkNJDQnJHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750378850; x=1750465250; bh=M61fq16hzNRQQHMU9iKRG10+njGRpKev7ln
	Wy40pYgo=; b=HCyyPakHONYcVpyZ2x9vuaLAZXG2dUmqJerdKQRxvoz65ElX268
	zu1TgPFwDAFTjBwV5GIzsvQPbYTKIXdOEgtBTxc5bLTuxLXTYozFU+hBHZ6XhRAx
	ko319+Fa1Dd0L1dgHGfX306ZCAYRDDpqZ/r/VpStM6jK74ULuoSIQ3Gosa7bXrMU
	UXs7NWMvwV7PQxiqgQBshvDb9n3dBTiaK45VJTu6l10lAlMnb1723frGaRcD2tY6
	alLlPIYkdmiPbJKAlM3GTjANgsd6WCYxHltHtpL8pLjBfQvimKDQWRq73B8Ogr1U
	/CGYrvbemwJFQR9z+F/J6R9YADoA5+UItXQ==
X-ME-Sender: <xms:YqlUaEiJvjvIVTwD-rveCAz55JSA59D4RPt1Hs7xzxzaFXfdn3D5lg>
    <xme:YqlUaNA_zeV4b60l81M7nWfU10EqvuwV32XIrafEiCVBgCdYN2nDQ78wiw19_ud47
    ObgVPYmlVbiZ6O-3A>
X-ME-Received: <xmr:YqlUaMFj2WpcJWw7SLqe66LYo0t-W-ojEBkwOoy4JXalmmiHAgU6-jvOM0L-MvBra1ULsaTr0xetjEr5ZJEuuaPSovRZ6npsjwBt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeileehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YqlUaFRL_mYb8-KNKb76HpcBxjauadLOFl595xvKM1e3JewWi6oqCw>
    <xmx:YqlUaBxPp9fG_dy_JwXP4Dl9WpEnllPIPgLuFFJspAyKmdzjaYOPag>
    <xmx:YqlUaD5zBtq9vljOiir_BLs65klD7MfmtIanIlWMUjsXE9nSzxh3dQ>
    <xmx:YqlUaOxWDhT91Zd1h8ssHB5CkICho945YJWFd8Y3i0ZUjfO527EVQA>
    <xmx:YqlUaGW31ZZh2bhN1LsdHhjYtukKNWU2ubZB4bRB4PtcqC76hgVL5cku>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 20:20:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
In-Reply-To: <CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
	(Christian Couder's message of "Thu, 19 Jun 2025 22:30:01 +0200")
References: <xmqqmsa3adpw.fsf@gitster.g>
	<CAP8UFD0YEgh4Oy8MDpT0DfZJgo++NHf3mF6VsYxAG1CjhrKGLQ@mail.gmail.com>
Date: Thu, 19 Jun 2025 17:20:48 -0700
Message-ID: <xmqqfrfv8dr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> I have this suspicion that nobody complained these sub-par
>> suggestions the tool makes based on what we have in .clang-format
>> because not many folks run "make style", and "make style" is not
>> very easy to use after you record your changes into a commit.  IOW,
>> there is nothing packaged to help "I have four commits on top of the
>> upstream, I want to run style checks before running format-patch",
>> i.e.
>>
>>     git clang-format --diff HEAD~4
>
> Maybe a format-patch option (perhaps called '--format-check') could be
> added to run such a command before format-patch actually outputs the
> patches?

A post-commit hook that does *not* prevent your changes that do not
pass the "style-check" from getting committed, but does give you a
feedback that let you consider before moving forward?  It could be
pre-commit hook that stops you, but then the people may bend their
code to please the "style-check" and commit a sub-par code, which is
not what we want.

Or just write that command invocation into "MyFirstContribution" etc.?

>> > git clang-format --style file --diff --extensions c,h diff --git
>> > a/builtin/fast-export.c b/builtin/fast-export.c index
>> > 332c036ee4..d89e5ba6d5 100644 --- a/builtin/fast-export.c +++
>> > b/builtin/fast-export.c @@ -658,17 +658,16 @@ static void
>> > print_signature(const char *signature, const char *object_hash) if
>> > (!signature) return;
>> >
>> > -     printf("gpgsig %s %s\ndata %u\n%s",
>> > -            object_hash,
>> > -            get_signature_format(signature),
>> > -            (unsigned)strlen(signature),
>> > +     printf("gpgsig %s %s\ndata %u\n%s", object_hash,
>> > +            get_signature_format(signature), (unsigned)strlen(signature),
>> >              signature);
>> >  }
>>
>> I do not mind the original but the updated one is not worse.  IOW, I
>> would reject if a human sent this patch to fix the original that is
>> already in-tree with "once the code is written in an acceptable way,
>> it is not worth the patch noise to replace it with the updated one
>> that is not significantly better".
>>
>> I'll call this kind "once the code is written" in the rest of the
>> message.
>
> Yeah, I think those should be considered false positives. They are not
> worth failing the "check-style" CI job or even having a human look at
> them.

We disagree here.  I notice that at least GitHub CI suite does not
use clang-format task for "new 'seen' was pushed, so let's check"
set of jobs.  The style checks are done for pull requests, and I
think that is a more appropriate place.

And I do not consider it false positive IF they are pointed out on
the changes that are *not* in tree yet.  On the other hand, if the
preimage and the postimage of the style checker's suggestions were
iterations of the same series, neither of which has hit 'next', then
I would consider a change like the above not "false positive".  It
is still an improvement; it is not improvement enough to warrant a
churn by piling new commits on top, once the preimage hits the
public tree.

What I called "once the code is written" is something I would refuse
to accept as a "style fix" patch, but they are still improvements
and it would be great if contributors followed these style checker's
suggestion _before_ sending the patch to the list.

>> >  static void warn_on_extra_sig(const char **pos, struct commit *commit, int is_sha1)
>> >  {
>> >       const char *header = is_sha1 ? "gpgsig" : "gpgsig-sha256";
>> > -     const char *extra_sig = find_commit_multiline_header(*pos + 1, header, pos);
>> > +     const char *extra_sig =
>> > +             find_commit_multiline_header(*pos + 1, header, pos);
>>
>> OK.
>
> I don't think those are OK. If the existing code already has longer
> lines, like perhaps here the `static void warn_on_extra_sig(...)` line
> above, then it's not worth suggesting wrapping lines like this. It
> could result in a code with both long lines and wrapped short ones
> which could be puzzling and harder to read than if the code had only
> long lines.

Existing mistakes are not excuses for piling new ones on top.  

I do not think the code with suggested change here is making the
code so uneven to make it hard to read.  Quite the contrary, the
body being easier to read is a good thing.  There is one
contributing factor that clang-format may not be able to understand
(or perhaps there is a way to do so that we are not taking advantage
of).  There also is a reason to special case a line that has return
type + function name + parameter list and allow it to go over the
usual limit, which is grep-ability.

> Ideally our tools should be able to:
>
>   - provide full patch (including the commit message) which correctly
> wraps all the long lines in a file, so that such a patch can easily be
> created and added as a preparatory patch to a patch series,

Ah, I wasn't talking about the proposed log message part.
Especially in genAIs era, I would not want to go there, just not yet
;-)
