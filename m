Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB3311C2D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086520; cv=none; b=IU0FSRF2pycxzY+2eDG+Y3TqoPx2tsNXTF4Yrf1P4VGxPJTQ2lWa5iCAv6uG5Bstd8aqf2STltZPHAUQ1WDOovlWg10IXlPiWAKt7LPRPO/KQnJCKWY/BqJoyiEAHJ1OaCy5c1K0OpdzLHi+An+NoKFfvzHSEj9cpyAykf39Tj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086520; c=relaxed/simple;
	bh=A2gjj16BvBmaNBtr1haCczN4X1pppZbC16CouvgFnwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxSmQ51geu4lSj3jHU6UN4RhuETam1rn93cVEIk+Kw8jECjkf8gRYAxC+Mdo0O+zAM8OyQItVsYQEiF/nqr4AEo4kJo6gcFlyuvb6jOsMwMquJViQc9lf2XDSqrn6N8/VogU5nXpOrXsvJ6XVnMEQgm2zaXT2+NNnIoFVOzqS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFrcugPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSi8CBt+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFrcugPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSi8CBt+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 77D2DEC01A5;
	Fri,  7 Aug 2026 03:08:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786086518; x=1786172918; bh=DsyaTORfe0
	rkAK/MTt2C0DQDFWm6Dn8XIojGRU7QTkE=; b=GFrcugPSAEQbhz4N81U19x8rwA
	ke0TejPZzRn34ezEyQq0UuzFcLufKwY746OuM6hwHE8cBizfdp5ybiUuN41Tjeci
	H8Tnf/CORhzLmX2wmK8oB1r2RDKplDAonCJ6ORCTuO2Aflt9TnKNq/3/XM9zFr3w
	dZE8+8IklW1F+ToJIo69cfHU2dXxMRNzHaKlVKyRb8sJB36+Vctf3dYe4GiZDAPz
	WXX9vY6U/41XQC6fdXoqiuHuSS5pMAzgXzz5RW9jJ1q7bRAjonzM2zzLyuubAdSe
	1q9oBE3yoFTNkww6IZCrq9L/PufEFVpy+jPeETu3rE+a4VsBuYFEm1q1nAaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786086518; x=1786172918; bh=DsyaTORfe0rkAK/MTt2C0DQDFWm6Dn8XIoj
	GRU7QTkE=; b=RSi8CBt+RUXgwPNuqV+UxjghrFBhtrStbLkTUxmJzkakiREQLXQ
	a9BWZcrtGCy+2TFC7K2f6WCE07D4ET2N8wAR0hDoIKT2UBapTL7iMoUpSm92tsvX
	s+mVo6Iv09rz7wMlK/tcnYQJPU4dTH5ruLCWci8qEQlvnOx9G5eIMHSjsDJPFTgQ
	Ga3/7iFdOGxn8RJF2tXqYkiVeYNbWOALVuZxrqQR0x5eqU1kQ8osvN5FNCEWEmsk
	UYxE8B/2Und2jrjwdmT9DZgm8JMtETLl5hOwDloGrM3zMrRdGgly+cBhlu/JTGB6
	neecB76cL3jkznoHSUc4bgMa+5CAPORJ9Pg==
X-ME-Sender: <xms:doR1aiGmk6egBve27jmPubmMhDe4wNlid3Kh2vVOrTNAvIuMtzRo7g>
    <xme:doR1aqUiuii7bdDKGfNPBdBSQ4DPGU2QLF2zzG0UN9_tUUzBxa3QWlEu1aPRlJ3eB
    wUHsEDWHHWbw6e27JzVTHqYm1jYnYZgcpIU_ibJzKckhf529AeZ0Xw>
X-ME-Received: <xmr:doR1ahIMZwZB4W4Rt64Ca3zxNjLJAzBbNXURDAMclT5DkxbCuoxe1XSdXMKpQaLQkos2urcBuxCpHlR7OD2Mzfw5Z72fjCCDpcceTDSMx0czYg>
X-ME-Proxy-Cause: dmFkZTGBUUUC7R9FXsSuB4uooEJ84V3kqZkBljxCP/bUtkoJuf0/j1kpnK4EO5vYxAaGK9
    asnY+Z8TkMq5axAPKzpATdtrpe5S3RxmzYt+ooxTuynNfq9Op0/dCijrm7DB7dtLsJoyVG
    hhp7qYc9Nz2Aea6gkjLE5bmBUN/KuVIgVL9a2ar8Oy5WwotOQVjeWp58FJ5OEwARo6omwk
    dvPA8O9ivgwAq7VfPznE1DlkaB0PeyQPwNsQFPLZ+as3X/38md7g/tDflfeXVKvMeFDeDh
    6NkFcYxAvypIHvc+As+P8q10V/Xl/SZIM07JA7JDwnpX6dBVOyFW0Snx7MdXj6+3XhFsmc
    XSGzKrkvDZgYwGkxusFKH1cOHb28zoE3lNF1ItY3PHXIz02QxcMbHb/SOxuzBy/K6Qul8m
    yE5Jj4n2KQj2UfgTOQLFsR37m3puYP0umYFtn+9LCb9J/JzxEBoxAAA0m1tSIisVJQzeW4
    gbrtJtGKtr/oBq4U22a6InkYyUBiZcpTkuvD7evXwBhj54IyXWeqUYKHBYctmvlvsJTA54
    edegUetebPMX/rOo/nns7eeTxH5qUgGbKiU6lZeaY0cbX/EeYksmqOO+JNu8GjcvW2v3mL
    UuSBEcYAgV24RVuip//fcshxysf8wLwKSaHkrxkzH5GyxdecBlw7raWK99tw
X-ME-Proxy: <xmx:doR1aq9dcOQfqXq_l7ro0wKOfurPCp--epnPRW0Kk1v1_BiAoE5NZg>
    <xmx:doR1akJTmAQRCdPBupLgqQ7m1P1ctAuLCAMnfyxje7OHzO0_y5HBPw>
    <xmx:doR1avkMFxtn1dYLXAlwwhHWK9UKkAB9j2z8NmzkPOMO3_6AD57eKw>
    <xmx:doR1aoNP76n6i943QLHZDlJxC-TQ4tmxF9whclY4AKjbQVf3YaqR3g>
    <xmx:doR1ao7Ue_HFoW1qMBs_5mFFNZxP_BCPyxj5lUibG-znfpc7rbQMj5zi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 03:08:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 45bc560e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 07:08:36 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:08:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/4] completion: add 'git history' subcommands
Message-ID: <anWEcfhdzvNQfskU@pks.im>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
 <anV7cHblfmGvbl-e@pks.im>
 <e894cf4e-7df2-489a-a596-96f1d4d95dc0@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e894cf4e-7df2-489a-a596-96f1d4d95dc0@kernel.org>

On Fri, Aug 07, 2026 at 08:44:41AM +0200, Vincent Mailhol wrote:
> On 07/08/2026 at 08:30, Patrick Steinhardt wrote:
> > On Thu, Aug 06, 2026 at 10:27:36PM +0200, Vincent Mailhol wrote:
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> >> index e875787710..7372e2919b 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -2137,6 +2137,54 @@ _git_help ()
> >>  	fi
> >>  }
> >>  
> >> +__git_history_has_revision ()
> >> +{
> >> +	local i
> >> +
> >> +	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
> >> +		case "${words[i]}" in
> >> +		--empty|--update-refs)
> >> +			((i++))
> >> +			;;
> > 
> > This will unfortunately be quite a pain to maintain going forward, as we
> > now have to be aware of updating this site every single time we add a
> > new option that accepts a parameter.
> 
> Do you foreseen such new parameters?

Yes, I'm very sure we'll gain more parameters for those commands. Commit
signing, sign-offs, handling of notes are all things that are currently
being discussed, and they likely will require new options.

> > I don't really have a good idea for how to fix that reliably though, I
> > have to admit. Maybe we should just mostly ignore this edge case and
> > always complete references, unless we have seen a `--`? That can be
> > checked rather easily via `__git_hash_doubledash`.
> 
> My toughs are that if such a special case ever surface, we can just
> dispatch it earlier before we check for the
> __git_history_has_revision, like this:
> 
> ---8<---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d313780d8b..786fcb5e16 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2193,6 +2193,15 @@ _git_history ()
>  		esac
>  	fi
>  
> +	# Subcommands which takes something else than a revision
> +	case "$subcommand" in
> +	foo)
> +		# 'git history foo' take a file first
> +		__git_complete_index_file "--cached"
> +		return
> +		;;
> +	esac
> +
>  	if ! __git_history_has_revision; then
>  		__git_complete_refs
>  		return
> ---8<---
> 
> This seems reasonable to me. Once we know what this mysterious new
> command would be, maybe we can find a smarter and more tailored
> solution, but at the moment, I would not call this a blocker.

I'm not really concerned about new subcommands for now, true. But
hardcoding the parameters as we do above feels error prone to me and
will very likely diverge as the command evolves.

Patrick
