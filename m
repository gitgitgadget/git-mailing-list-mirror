Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ACE283FC3
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115293; cv=none; b=tStl93ebLpubcBFxzxsz763+AMFwlAqaHJMhXm2fiORrjmGA1Fmg6OVI5is7pJCtDrGBcJQjvwJaS2QSLXaFCrTJZfoxLgkPSG620kPLlAB+VHFs+5fBRUDSG0B9HvjrEHCmzs4OPM3IhXWGf4G/V7bXcDc9iDRmNGeV2tRhTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115293; c=relaxed/simple;
	bh=wYG2zJSA8Vmp9kNg2+cDdml+a0Q/uHpSFYB/6Rf2ecI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhOcdvEkyJkroYy/VxvIiSdXVliO4Yg7HDn2ta4EH2WNSnOy1nasGJkJS6pHHFqUc3I44LB1kZZYfmf91Rr3TrjHwQWaPtVVqEx7OqXSP5VftHbma8nemG7vtBeYEmV2sXPOOEuqY59opG788/83erH17waxtJMKKDfsuswIMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s9Wz3GZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFMslUia; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9Wz3GZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFMslUia"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D0477A0105;
	Mon, 21 Jul 2025 12:28:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 21 Jul 2025 12:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753115289; x=1753201689; bh=q48D4cdTdP
	9IGmHlCUQwiWm7KXjmvgglFxvYYBzWVqE=; b=s9Wz3GZ1uoPw5n/SiGad4w4Nr5
	6Nx3fw8dU/vvqIifDW2o1Zy7j8zOne2A6atb7TjO+mC0/Xv02Cow4gJt3307xv/O
	edKJ0LcF1CNgDO5y80xZewmBA2kjs7H0Pq/FzpusTZsfhURSWz7vWKR+THsmOa2J
	OBMvTpM6/NLtPB296IZ+W2MnyybKynpkcUhgpjtU5ueXXFKHb64QUajOmAZ7CoKA
	upIXYixSlyrbqEt5YlzgfevlOrAzKRt8HrjFdrUF2DKsYFLO+9S2h+iqJor81npx
	Ww/4M7herJgIkEHz1DkqI0BtGZ07hrdHClXfDtTlOPq9gk93BQs9M08x4hXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753115289; x=1753201689; bh=q48D4cdTdP9IGmHlCUQwiWm7KXjmvgglFxv
	YYBzWVqE=; b=hFMslUiaQUm7WjXDTDwdyiBhwt7D89L1rdxRJWh7AvFo3qak/TG
	Q9rX+PhuOZ6qP57FqME2I8REL1N3yo/Pa5YgimiKk/Gd6F5w59HbLpc5xzSZz1Q/
	m1RFl2ns1DjyUzRoRzFP4zr0cew2xxysNz8eSwOP+3YOQemAmEXkqx2olc+IXbdQ
	sAcTZkXDjkHtlrCl/nKa8AyYCtswW//yWXIAt/ZwxAUo4uWTHlcPfGEhbqjXvvaR
	pgI5soVtO/d/v5OttCrWqeToEQOwT0thXxCVMO/l0eMpTkmZQzjejfDCBOtToHPF
	fsx3Qvos2VsUQc+LFwGjI9/LlKxszXer9pQ==
X-ME-Sender: <xms:mWp-aOkrJKdgM8qmI9_G-PLyuBdNdt8vq-8lin25kEnQDm3hqHdfNQ>
    <xme:mWp-aJEQJGdoRdwLndyBaJ7Rtb5QNK98Sb_3GT69L2BC0kcxtpml6Tod_th0kOi6z
    hDaP2P3P0v314zfTw>
X-ME-Received: <xmr:mWp-aGHXsz3L2LrAMj2x7Ypnly6TZG2pgwavRGwqJeTAac02lznUS6r1Zj-IjjU35nqAIsw2LMoOhXRRPIszqgWXXc8FGQB0hKwZc14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptdfffedvledvudefjeegudelteegfe
    egudegheevuddtveeitedvjeeuudffjeeknecuffhomhgrihhnpehpuhgslhhitgdqihhn
    sghogidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mWp-aONV4e59WnCpSk2Ne7UOhSriVAg2zPI3wtORNH6bobZO9GNJvw>
    <xmx:mWp-aNEE8TpU8LArjE-Xh-qHbU6VGb6qs-SVCF56_HbFNkZFFdKGIQ>
    <xmx:mWp-aNPccb_y1yKaDWnWxtXXE1AKN3F7tGWqamvkrKJbcSHyomg-Qw>
    <xmx:mWp-aG9Yk79H1nXQXkrJBgGX-A047FrfmLl2wN1y-Bv98m4F_0p4mA>
    <xmx:mWp-aPKsRmnAJmvD0mpT7KY-O1iMJSRwqyC03THvz6baBS3h8y2MSx17>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 12:28:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] revision: drop early output option
In-Reply-To: <20250719070813.GA706382@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 19 Jul 2025 03:08:13 -0400")
References: <20250719070813.GA706382@coredump.intra.peff.net>
Date: Mon, 21 Jul 2025 09:28:06 -0700
Message-ID: <xmqqjz41zey1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We added the --early-output feature long ago in cdcefbc971 (Add
> "--early-output" log flag for interactive GUI use, 2007-11-03). The idea
> was that GUIs could use it to progressively render a history view,
> showing something quick-and-inaccurate at first and then enhancing it
> later.
>
> But we never documented it, and it appears never to have been used, even
> by the projects which initially expressed interest. There was an RFC
> patch for gitk to use it:
>
>   http://public-inbox.org/git/18221.2285.259487.655684@cargo.ozlabs.ibm.com/
>
> but it was never merged.

Ah, that one I remember.

> So let's drop the feature. It is extra code that is untested and
> undocumented, and makes working on the revision machinery more brittle.
>
> Given the history above, it seems unlikely that anybody is using it (or
> has used it), and we can drop it without the usual deprecation period.
>
> A gentler option might be to "soft" drop it: keep accepting the option,
> have it imply --topo-order as it does now, print "Final output: 1 done",
> and then do our regular traversal. That would keep any hypothetical
> caller working. But it doesn't seem worth the hassle to me.

True.

The safety of dropping of it (instead of fixing) relies on it not
being used at all, so using that same assumption that nobody even
attempts to use it by passing the option, would be a sensible thing
to do.

Will queue.  Thanks.
