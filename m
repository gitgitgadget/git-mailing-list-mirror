Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A3304BB3
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787030810; cv=none; b=MokAgwYUkaU5dF9Vs92fbGQi2PKa6FZZ6NDeoqRqK9p8d9DGCBPjKqUHcqggu0frypwNiZyFpGB6o/DQUf/kRf7fQIoOshTolp1X4MkbwYa+Qok/QuGIN9x+qWyTm5s+0zQ0b91XtI6hkX3PbnfYBvmilCFu07kYapibkPbRNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787030810; c=relaxed/simple;
	bh=CNpKtchaAEi9zOQkbBj7CHRoEp8jEm6o3GKwPqYcCrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNdAJBpCWCnFediCbQRJ+XnYdMrbCK3lRqdxKpb1mGEVwLnX+3ZWY4F9S8xdB3wPKNGsb9HP5k9xq3ECkJg+I26A4GAhaOWN1qevkKmBJQYXpRLuv1z55z673z31U7Z6biMQSTdna7gs7fKvavjgSJ3PLxKFkidiFtJA3jFRB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i5/9wZn/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKz642j0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i5/9wZn/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKz642j0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8328CEC0282;
	Tue, 18 Aug 2026 01:26:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 01:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787030806; x=1787117206; bh=sZnz/TdBsq
	xrykAosOCw3DUILeIUEHFqKGjX840d3p0=; b=i5/9wZn/ST5xKrHoo+JkKfmztv
	pZsQG0wQ3FSltKi7uxXD6snWnER8IgY9VS/whmj9PF68vYF3Prq02MhCKlb49Irq
	ZsTYnpZevMyTCIY/6I6OhRasva6q4VctElrKruq7tNtkYUHHHorVucUteUn6HZNV
	qdOqaOEAlY9lmyDZ6NOXTUDXZk6CbSDbc/O9SbTyDBqFgVcSowiGMxxBmN1Y5Y7t
	qsWCLeJlhmqv2Lgqx9267O4lF9x3ZdWlkxY2ti7ZoUaLf9midEsfHluDL6ueLtGz
	FBPKOeqwLkRp6a+Oxva9SWP2MEs2g4YW0MqUI2zuBc8aLDKcKxotsJODyMVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787030806; x=1787117206; bh=sZnz/TdBsqxrykAosOCw3DUILeIUEHFqKGj
	X840d3p0=; b=IKz642j02iTMOrFUHxTvb7NcIluGxZ2dGNGFzyy3E0iXYIHeYs0
	YQF8Hn9WfJgJX4TD48IzEdm9nuqjbezcZHji/A7eukZKwPtnPYiudnAVOAUv8gX/
	60a2nm2hFrSfKSNZSH7uwNCqMd+DxjlCwVKavcchGZ36FpkhVMg+xGvf1b486gVQ
	iDFCjuqJUwuTd0jiuaEGquv7xdWuWE4f3fEH61/NL0cjDTPNfSSXkbwUPVs1SQIU
	Q7B/FRugctwgafmiAz1VbvWlMRH9hk4NrEU8N6kGRtoknBYMNVmsKQa0X+/C9Vb6
	Zqca23j3/3ZtwG4aaAiUFowAreE1Gu6gCcg==
X-ME-Sender: <xms:Fu2DalMrPUM3lIPiK1MOMt0A8zql5M4MxIrcEKRD-wfBYaNKtx9UrQ>
    <xme:Fu2Dat-jD1lOr-IO37eZQpVWRbbJXFKT99pfVKM2470AQKkjHhetgUgYZApfy43cN
    160tS9LMujFtRKdgEp5D5eTitz1kFQombVyBCZPD8c7UsO3N9jwrQ>
X-ME-Received: <xmr:Fu2Dah4WwKBq6r0sXw32i5_RuB1rxZUrirQluTadsTOmFvYqqg7hLXDuhzgXGLusDWWBQm9qbcgOGJwrXpqYEV76DlNZ_Ur6zYy_q9N8>
X-ME-Proxy-Cause: dmFkZTF+AqwsIxstEPOQNtHfhs5S2i4Tec8sn2gTZKJVrezP2MQByB8CyysGMO33gsIO4p
    Zh0FtM2H8srUtKsB+00oCw5kLkaMSU33o/HNszn4+ZDi9IbfydnhHEZnzU/1gXhyFSKRC8
    NGPZZvjkmtORQJHK+8untwwQTVQ/SEsdDEpRIsM/L3Mpu02OtiIensyJfSwmCX7oI49sCg
    cmRNQUybmYQ6C1cz26iopmdKG1y4Gp6XmYPDaZNNCItfJi2094qPlm39kwuzZjuTXIy6t2
    EaqbnMRxjYPmd48ylCHwyn7a4Qcm4Y0CywslKSMPwUpg8K0qjWYGFJ2+egxtmikeX2lvQ2
    HusmrBj0B802x+apncKj8aWvgNT1J+JDzsAW94i/UhwCA8j7Y+LhgNN3M9tiT/OfUG2nj3
    XfmQC7YBBCfFyWFgs5kOVv8b3kb2VjaAjzD9HEpG/7BrsgUoDk1vRPLHIaP/z934HtnM7d
    o7mdGSTXCq3qiBnV+F4lLikGuDVuLBVwd69GDgMhJ2h9IQo3woIxHYvZoCTVj/BMoxCb4a
    QnTWI+NCzM9GkqY1quy2RtF0H2d4rYl1SakjCs80V1NncqKzmvNWSaOULmCn/CTFnzx3xo
    jIfiiJrR4SPbyiVTM3mLiqLCsFBCRk68K9C9B7fS+JHQbLtBlSgG7+V9dH7g
X-ME-Proxy: <xmx:Fu2Das2nKpUrF4qUGQktbG4Gd0_dc0xb0qAdzafBbYqH3tlCtdEdBw>
    <xmx:Fu2DagAerjY6yTZ1-5qsMAUtlqEJ6Ow00LA0MhMi8Ktu4-SxaFE52g>
    <xmx:Fu2Dam2xrvzzz43ZTSrd8b8ko5kNEVGWhqMY6BQ0a0r7LlL13Des2A>
    <xmx:Fu2Daiss2nv_Ute9i1RoJr1wxNkaI_OaK8gLhZbrKYpPGu18bPHsrQ>
    <xmx:Fu2DaglfYen4X4kkvyWH7Z3aBDhoWVTZnPAHivj8a9_YVbrhu9L9odll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 01:26:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b039c8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Aug 2026 05:26:42 +0000 (UTC)
Date: Tue, 18 Aug 2026 07:26:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] bundle: get (mostly) rid of `the_repository`
Message-ID: <aoPtDyISRa0mVXRa@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
 <xmqqik5866di.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik5866di.fsf@gitster.g>

On Mon, Aug 17, 2026 at 09:47:53AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Refactor "bundle.c" so that we don't depend on `the_repository` anymore.
> > This conversion is trivial for most of the part, as we already have a
> > repository available in all calling conexts.
> >
> > The only exception is that we use `get_log_output_encoding()`, which
> > implicitly depends on `the_repository`. Add an `extern` declaration for
> > this function so that we can drop `USE_THE_REPOSITORY_VARIABLE` and not
> > accidentally introduce more uses of `the_repository`.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  bundle.c | 32 +++++++++++++++++++++-----------
> >  1 file changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/bundle.c b/bundle.c
> > index b64716f252..a9330bf0d3 100644
> > --- a/bundle.c
> > +++ b/bundle.c
> > @@ -1,4 +1,3 @@
> > -#define USE_THE_REPOSITORY_VARIABLE
> >  #define DISABLE_SIGN_COMPARE_WARNINGS
> >  
> >  #include "git-compat-util.h"
> > @@ -21,6 +20,13 @@
> >  #include "connected.h"
> >  #include "write-or-die.h"
> >  
> > +/*
> > + * NEEDSWORK: this function implicitly depends on `the_repository` and is not
> > + * available because we dropped USE_THE_REPOSITORY_VARIABLE. We can remove the
> > + * declaration once it's accessible via `repo_config_values`.
> > + */
> > +extern const char *get_log_output_encoding(void);
> > +
> 
> Doesn't this defeat the whole "drop #define USE_THE_REPOSITORY_VARIABLE
> as a mark that we are done with this file and no longer need to
> worry about it going forward because we won't be able to compile if
> somebody adds a new use?" premise?

Yes and no. By removing the define early it allows us to not reintroduce
new references to `the_repository` by accident, but carve out a single
exception for one of the functions that still depends on it. The
alternative would be to not do that, and if so there is no guarantee
whatsoever that we won't introduce more references to `the_repository`
in this file.

So I'm still leaning towards keeping this as-is, but I don't feel very
strongly about this. Let me know in case that argument doesn't sway you
and I'll adapt.

Thanks!

Patrick
