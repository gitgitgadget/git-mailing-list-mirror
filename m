Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C658B7DA66
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967391; cv=none; b=EJhPC9MP/KvcZ8iL0h6BvfuvisdCPjd46zAZuRfrhhIQ7PuMqrrJRRgwmCLvAwFwsghlG/vXYUfSuzS/dwPUCqNsVNd7wDfqsQhTw6/0MUWsqQHdhGoGLOX1SeDgxSdr4Zz3LTdlo0b3+HPFtj8PyecFBM1Ti0+EqryubK6VGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967391; c=relaxed/simple;
	bh=FTkycQNqGrr7JMZfPTbnP6WDZav9W2+clMGrtHLhmS4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t2HSPTUAvMw6L7CRiXVUT19A8Tfee/+4ah4INI28gTAXCYjQEOwv4ZcyOQzkjB8SaCudDQCHH4MOeVDFfyYvQt8JgtYy8Y4UjH8TeL7K5H4cgsLGbvXVHMogfZG2yGR30SqyOm2g/YCAEOQk5wd8cgJEMImQ6RAL7K+3TMmgUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BNiHaEGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hq2Q/779; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BNiHaEGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hq2Q/779"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEC59140008A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:56:28 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 02 Oct 2026 14:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790967387;
	 x=1791053787; bh=AMuw54D85QHRDZWMelzgl6fiiM17vfMg3gISfpHit0c=; b=
	BNiHaEGeJpsaEc854nafaTpt/5UszaAEbBold1ZgnExFOCXy/5UqtBV4KHVt+GIh
	HsaVuJ/I4JlB9CMn17X4xkdrYsmNrPGz1NCQyZEYlAYjBgBapVAUzmsTgLBTmFMh
	B2jVWQK+WAX3CDbdd42qfrfzWxrIYJt6XJEZkkUZriOPxN0x5WP27X39es2bp1Zk
	C8qjJdWv1HdKn+yTLAvsSnqt/ZCrbXFYRhvc43JpAV1caV2j0WLY+sBjGtkl51sg
	6XnXlctCim2X1YDMtv09jeGIWTbB8yokOTBTJil3i5MmCHEtfQoLlUfcLWztPyQh
	+522fvymmdGgRYlyVrZD6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790967387; x=
	1791053787; bh=AMuw54D85QHRDZWMelzgl6fiiM17vfMg3gISfpHit0c=; b=h
	q2Q/779CThBR2OY2fkpb9tTCjKLD3NUBIjUaQsxEdplxF/LmWHqSZyerkKJlpMGJ
	8W02PeRo9EQ+lPFPQu+9c7dpPiyIXQFiW/be6yQ7JI/EvGZ0tzqUJqO540RVex0I
	FFD5WOjr58rrT9aOkTqtxjK6HAijBvNn+YCTzzUKYesMXcMCmbsFdTqLa9BYsm9v
	Nv3jXcDcbYJCJZjKOv0Q4f4Pin/ma2CbEVKozQFq6sgMjN1VqAnz8jE7ciwsaQGM
	MaR76GJ4/e+sczzfz/SrFqe4UdatfaMpTtHf332qZ0xSgzSZZ6tOMsaxcnzCguk/
	1AjzDc/pGv+0X6Hitt9Sw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790967387; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NcUWctB4daQKNJiDY6h66Uyg5UuLAkdqbMuh0+NXPyO+ke0
	SgIFXwhipvX+ULgFgpGYn+hv2aKJrBlYKOFlMptSkN3k/EY4Cs3Bw8HczmOzmXWO
	27cU6go82I2MfoU7slMeNbsvD1/tMTXSxZGcQeeJ2TOqAo2P2oWsEBztj5l6T6uW
	qF+pal3TXKJvhawUzT8jNgQmuNCeeuu4/G/1FcW6CAxg/XhN7rNoZLhI0tsPgLPx
	FVjzpS6uioGD3CYoN/j+c9y2N7CRdZjxL7bCQ91jEjKHddTWJ9VM9DFOxzKGuzWx
	aMvF/+yuPIjhfwXgDUyR2NnTi8Cz7WUMQ+mgFiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:reaGYaPYrWoT/f29wGBn28YT3mxLceecDuDu1BNqki4=:FTkycQNqGrr7JMZfPTbnP6WDZav9W2+clMGrtHLhmS4=;
X-ME-Sender: <xms:Wv6_agJRqcG-pqemUh87tPJYo9MwhxrWUcO4toq8ZScNQEVArqbLa2c>
    <xme:Wv6_aq8dRtlNez-rEjO4lqvlJkcDYPrF0q6hVEhIAJhSGn57kbHzRsOCxU7kBl8i-
    w7SS52Q-iDGJB4J5z0S2IzuYo9bxDLKVHPiXjNyqRTBRqxbN-s>
X-ME-Proxy-Cause: dmFkZTGYOCVB1iwNXhQ0+JO+270KPAetuMJpQRMAAjAS1ZvU/f8C1g1g7NAcv97PvGvD3l
    i1hlc6AWYmciVWdhz9pbPl6PsQIUu/d1IZZJI3o9CfHoLdiAR+hvFQgyZF0ehVJ17oca2q
    Xtdp5Lx4YkBUFixNEob4N4IC+EjuDPLoE6WNkacGX+hwq+BSFLWZkp5Sc2OsQEHr7aJ5L2
    GKzMv5VkdI+0t0W68F71jwKPKJ13Xv0uYWKPB9OQXDoW+jRcjOLfw3b3SyxscJqr+dMRh8
    8YYBrbOGasyUoz50dWjiXc+rhmejPILTQgw0k0jmKCaE8icSZ730SsoY58EyPivDS12DG8
    l4XlnqqirKGW74YlPdZirbMPt5LNj8YcwB2rNsjfNoRLSbLSnVU/dTWc8WoyEq8IMl+l4c
    2eZ8GckRyB4y3AW5UQk0GTDNmv5dfhOks/cbQhPfvcIixmf1iCPGCtZTpeDYfi3dAD58XC
    9lT7kryLd/7d0MC4aRsiI7xCdt6a5eBeGqLhmbPNETei7F66c25FHloi2RLdo0E2I6NmNa
    wSsrDPsWsVg/y7kRkek5uq/xWYOYdEHrfJ+ICLhHG33CJPeeBPPfsNrIRZWCsjQ+TH5UuQ
    PG5SfouOOXxmLAgJ14yHp3P9yZcKT0FOwbSOag5eG4zpQfXsTgLrvGGT/zSg
X-ME-Proxy: <xmx:Wv6_asmm3uolM94S0hVdpGWK6jHj2GeprBav3M4eUuXIT-ytOus_Og>
    <xmx:Wv6_ajkdvAJBFc05vuI3c7plXcMi5Fyj9ySH-1SUDgHCCUfKrwQaow>
    <xmx:Wv6_atsiR_UfE1g8KDbeP7wf4IFlZfk-KpL5O0C7-l9sSphDl2GowA>
    <xmx:Wv6_amkaEG_Mm5ETl6sy5aywiOW-7DgZu8Qq2nprzph2KqBcYzzB4A>
    <xmx:W_6_amBpe4GerSY973bOcS2Jrwgn9FoqfHXbioh2yoZvniK7J8KzsgD6>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E9AC822C009A; Fri,  2 Oct 2026 14:56:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aaez0ouLjM7B
Date: Fri, 02 Oct 2026 20:56:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <aea0780b-a390-4c40-80f4-6060da908dc0@app.fastmail.com>
In-Reply-To: <xmqqy0cgvwpi.fsf@gitster.g>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
 <V3_format-patch_learn_--range-diff-notes.d3b@m5gid.xyz>
 <xmqqy0cgvwpi.fsf@gitster.g>
Subject: Re: [PATCH v3 2/2] format-patch: learn --[no-]range-diff-notes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026, at 19:28, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> git-format-patch(1) passes on the notes behavior that it is using for
>> the patches to git-range-diff(1). In turn you get the same Git notes
>> displayed in the range diff as the ones you used to generate the
>> patches. And that makes sense in most cases.
>>
>> However, I often make notes between series versions that mostly prepe=
nd
>> ...
>> something like an alias set up with it. But why spend code closing
>> that door? There is no usability upside to erroring out.
>
> This is somewhat shared with the next step, but the commit message
> includes a lengthy narrative of the author's thought process ("An
> off/on switch is enough for this behavior...", "But now we are faced
> with a problem...", "Well, we can't. Therefore we need...").
>
> Can we strip out the conversational journey?  The log message should
> be a concise, permanent technical reference explaining the problem
> (range diff notes inherit patch notes, which may contain irrelevant
> iteration changelogs) and the solution (the new options and the
> .override flag).

Sure.

>
>> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-=
format-patch.adoc
>> index 191f64b77d1..5907f299a8d 100644
>> --- a/Documentation/git-format-patch.adoc
>> +++ b/Documentation/git-format-patch.adoc
>> @@ -378,6 +378,21 @@ case is to show comparison with an older iterati=
on of the same
>>  topic and the tool should find more correspondence between the two
>>  sets of patches.
>>
>> +`--range-diff-notes=3D<ref>`::
>> +`--no-range-diff-notes`::
>> +	Used with `--range-diff`, tweak what notes to display in the
>> +	range diff.
>> ++
>> +The default behavior is to display the same notes in the range diff =
as
>> +on the patches; see `--notes`. But you can use these options to use a
>> +different list of notes. For example, say you have given three notes
>> +refs to `--notes`. At this point those same three notes will be
>> +displayed in the range diff. But then you pass
>> +`--range-diff-notes=3D<ref>`. Now the range diff will only display
>> +_<ref>_. You can of course pass more refs to this option, just like
>> +`--notes`. And you can also turn off all range diff notes with
>> +`--no-range-diff-notes`.
>
> Very chatty and colloquial.  A technical reference manual should be
> concise and direct.  Here is my attempt to condense it down to make
> it more readable:
>
>   By default, '--range-diff' displays the same notes as the patches
>   (see '--notes').  Use '--range-diff-notes=3D<ref>' to specify a
>   different notes ref for the range diff. This option can be given
>   multiple times to show notes from multiple refs.  Use
>   '--no-range-diff-notes' to disable notes in the range diff.

Fine. The only thing I was concerned about was someone jumping to the
conclusion that the `--range-diff-notes=3D<ref>` would be additive to the
`--notes` options. But this says =E2=80=9Cdifferent notes ref=E2=80=9D w=
hich clearly
means that the intent is to discard the `--notes` for the range diff.

I think that version of yours is better.

>[snip]
>> +static int rdiff_notes_cb(const struct option *option,
>> +		       const char *arg,
>> +		       int unset)
>> +{
>> +	struct rdiff_notes *rdiff_notes =3D option->value;
>> +
>> +	rdiff_notes->override =3D 1;
>> +
>> +	/*
>> +	 * The rest is the same as
>> +	 * parse-options-cb.c:parse_opt_string_list
>> +	 */
>
> Hmph, I wonder if it is more future-proof to wrap the string-list
> callback like so ...
>
>         static int rdiff_notes_cb(const struct option *option,
>                                const char *arg,
>                                int unset)
>         {
>                 struct option opt =3D *option;
>                 struct rdiff_notes *rdiff_notes =3D opt.value;
>
>                 rdiff_notes->override =3D 1;
>                 opt.value =3D &rdiff_notes->notes;
>                 return parse_opt_string_list(&opt, arg, unset);
>         }
>
> ... than copying and letting the code drift apart.

Obviously better.
