Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB23DEB6
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002281; cv=none; b=cqNCFhYd1UwWORzhFE00cUTwYCW+xIvIQYwLwGOxgyUFnEAWc1BaSQRGczGRBkmDy+QpMSrjmdig84A09C4JDNxdNvJ6ckn0blzhODg0C3G468mqwEvgoQaueM2c8sYndB+fL4iZvWML7nVAHqthlGLHA+8oM2I+XVYzktS2UR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002281; c=relaxed/simple;
	bh=LR7eZo1s8gzqBjWcIMfTqBJkrCTd+sN/jnM9tTqsh6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eKv25hHHXup1sow7tBZpiNZHMMdmRAkv9EwLTVQITnTmYEna9i449GRnqnqp8nmoJtQOHlQbLGKCZj0bq38EJLeLkjv/3sb37PQvpgJMMz71UpgVYN8Z+h8akXO/ZvqOoFKww/+JugweUEHsYd/Ckk3zv6Xb9PRktz57TpoeLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jedrhfUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aXALzbwj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jedrhfUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aXALzbwj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 16C891380993;
	Wed, 19 Feb 2025 16:57:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 16:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740002278; x=1740088678; bh=Pb2xJTJUSC
	rmBpwAg8ecQzc/fCg8U83zKEeK4Ac02MQ=; b=jedrhfUDHWYzQgmS9a3XhQ55w1
	pI2GsdsJFwWM07k8euOydqh61zGhG0Q2w5VhcwnDUKTbregugh9B7cGhiM0nK8ph
	TL4Kx+U7HLVPtIHCT5LoTKIAjz/xtJtlNvLLYHzQMiaKg+1vpo2k1OD6vQDfWl9q
	dz4iDbxqpy3Og26PfGdjQawdnkvsKt2WfmzUkiyQSvHMct8GAmtQFukugqg8kP0k
	hLaINqntFo8DblN/DfqW5/4XvSkNVxJWjqFSGgHTa5JFqHcxUFRf6behpQqt8cyi
	dX7alrY8mu6+uizyJnxgrbOSmeI0sC6acgi3a3eHnKVf546KWTEpPfHvWhog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740002278; x=1740088678; bh=Pb2xJTJUSCrmBpwAg8ecQzc/fCg8U83zKEe
	K4Ac02MQ=; b=aXALzbwjDK6pWXN4ZM9WY6+FpWx+78pF4eNGTelHgzzuXo/cHWc
	1jG84eGydrYsp4goa3KxXwHNUbIgko1GWJkJvTmgfXw5KoWOFwdoS3hI6pbjxTU/
	lTIKN7sHMPkJdqKV/QpGIf0a1eTqKMxMfDg1i7ArET66JkhfAYBEvgPiAhZhDvBh
	fbsolLf/DfqMpYS1OnqwDAM4l8qXzjfMbhb5XV0GX9gSvYExcC+dIRq9/TaahQDs
	Tkuv4BT4XPYaQ0tKXYgtitJVAfG+l/BtecCg9hDxwnR/PeTQTpagifUHuUGe5LpD
	OjsiwvZpSWwbXnN1zTo61a9vRXhk07tRRCg==
X-ME-Sender: <xms:5VO2Z3IpEcGm6Q_jR0kIu-kWNAELrCWpsrkUDuo7S2thkyy8K1mXtA>
    <xme:5VO2Z7Itmfh2NfC4fVmYbIb45NC70HcWRCBWCokm4lNvvviEC3D7n2kbwqf3OA_qh
    SEWnIYjHgf63OiyEA>
X-ME-Received: <xmr:5VO2Z_u4vuuC_sbB0Zhw2zaFcmFV-TIS7pFWPVt8WNE0632XRFmcwGvBIXYhlkVRqDi3hfV0RftrD_Y-OEbtZZOdLmItP1iXjn4GFA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhefgjeevgfegtddukeffieefledvieef
    vedvfeekledvvdejvefhjeefvdejhfenucffohhmrghinhepphhruhhnvggpuggrthgrrd
    hnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5VO2ZwaxrTBO2jromAFXR0Dd36EIuPrSbLo4q8s9MKpeL8iUOaBdwA>
    <xmx:5VO2Z-aHy2j6TSH7gp73U7sYWyWcEAjyZfWGAc9ESDcyVhUoAjX_Sg>
    <xmx:5VO2Z0AdsLd4zVMjEqF_5hDNUp3exS5MxdGQdPylF_-rPy2ZrkJWAQ>
    <xmx:5VO2Z8aF4VldA7-swzQHg_jNsWbQrDvorw-20891vZSnRVCLj-7vxQ>
    <xmx:5lO2ZzPPw1pkWLkiWlglMrJhLvEItJ-AUksbLyYlbPNxS9uHESf_1c9a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 16:57:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  peff@peff.net,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
In-Reply-To: <wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
	(Justin Tobler's message of "Wed, 19 Feb 2025 14:51:57 -0600")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20250212041825.2455031-1-jltobler@gmail.com>
	<20250212041825.2455031-3-jltobler@gmail.com>
	<d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>
	<wv5ziveuff7iellcmjcki372m5vp6nmltyls43e4wzslcqymog@gwczuaucpkke>
Date: Wed, 19 Feb 2025 13:57:55 -0800
Message-ID: <xmqq7c5lfvh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>> I think only accepting NUL terminated input is fine, but if we want to
>> accept other formats we should  have a plan for how to do that in a
>> backwards compatible way as we cannot use `-z` to distinguish between input
>> formats.
>
> If in the future we want to support the normal format, we could introduce
> an `--input-format=normal` option or something along those lines. 

Please don't.  Have an explicit '-z' option from the beginning, and
if the initial version is incapable of reading from text input, then
it is perfectly fine to have

	if (!nul_termination)
		die(_("working without -z not supported (yet)");

Otherwise people have to remember that unlike everybody else that
uses "-z" to signal NUL termination, this one alone wants to use a
"--input-format" option that nobody else uses.

>> > +	/* Don't allow pathspecs at all. */
>> > +	if (revs.prune_data.nr)
>> > +		usage_with_options(usage, options);

Hmph, this is very unfortuate.

The "--raw" format was originally designed as an interchange format
between the frontend and backend.  

The frontend programs take two sets of contents stored in various
places (like tree vs index, tree vs another tree) and express
comparison of corresponding paths in (<from mode+contents> <to
mode+contents> <path>) tuples" (a rough equivalent to what we
internally have on the diff_queued_diff queue in core).

The "--raw" format was designed to "dump" what is in the
diff_queued_diff list.

And then it would be passed to the single backend, that takes
"--raw" format, pass them through the diffcore transform machinery
(like matching removal and addition to detect renames), and produce
various forms of output (like patch, diffstat, etc.).

To me, what you are writing is the output phase of that pipeline,
i.e. the backend.  We do want to (evantually) be able to filter with
pathspec, and all other things the current diff machinery does after
the existing "all-in-one" "git diff" and "git diff-{files,index,tree}"
commands do from their call to diffcore_std() and diffcore_flush().

The revisions option parsing machinery does accept options that
would *not* make sense to expect for them to make any difference to
the result of running "diff".  Rejecting them is a nice thing to
have, e.g. "git diff --no-merges HEAD^ HEAD" does not error out, but
some people may want it to barf (I don't care---I am not sick enough
to give apparently nonsense options to random commands), but it is
perfectly fine to start your implementation with "nonsense options
may be ignored".

But in a "git diff-* -z | git diff-pairs -z" pipeline, I do not see
a particular reason why you would want to forbid the downstream
command to further limit the paths it processes with its own
pathspec, e.g.

    git diff-tree -z --raw A B -- t/ | git diff-pairs -z t/helper/

sounds like a perfectly sensible request to grant.

My recommendation is to avoid deciding to reject things your initial
implementation happens not to support (yet) too early.  In the end,
we want this backend half just as powerful as, if not more than, the
real "git diff" machinery that has both front- and backend in the
same binary.

Thanks.
