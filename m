Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A82D322E
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787498615; cv=none; b=bhu2rPaOnpz2WnSOO8vObbiSSYwX9kLMckTeYZ1p9joKFqgQR0JgFhSYm3uoWMsK+vTEaxNUQE1Nc2adVZeNYILB4Vm5IThL6XT9yogIXTUUm8tz7Mf/zhUX8En6YWGFezqIyfnSg/bj/Sj1fZJ41m8sfLpFkzCAthhX7i0YRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787498615; c=relaxed/simple;
	bh=cHdhbS8NCyNeGk7W2F1hLASMerXq3lZvsq2SLGm/tis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgRmSwo8gecKrF/QUqpMmgKLJljEUq2C4W4DwJ2q5ktTRELVJ5G8GMKqxFp+ydwTIoUgnobK9gd+rN8WmzA8IwfBI3sFlP/IREdn/XbASeZR/aBdXjUXgKTXfK+R5DiGz4Zw/RR1qN9tw9NhAHJAsHUFkZUfNigEaRzKaM2+yd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfxaiTB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YmVEz0UT; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfxaiTB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YmVEz0UT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C73CEC001F;
	Sun, 23 Aug 2026 11:23:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 23 Aug 2026 11:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787498613; x=1787585013; bh=qAWf10ZvYS
	oyb17zdJYfzvMh2L43oOIej7wwKXMpjmc=; b=IfxaiTB6AdXpRCpApiZXudz3hW
	MW/K1DBm+zM15W2XaGzKQHdiEmDmLo35rnJx9lZMfhKdVdekyOVUSOzhAz0p+45K
	qSLy/qkDQmNDTNawogtpPfZMaaXTqYSpsoj9+xhT80IdNWjeaL2txNYrOd830Zdn
	pZysVw8xlwyfzjqksuO732IUfs1TnBn7qW+yxM0zqajfI4S0Q6xJVZsnu5M/P/3J
	b6i8nRRPMGN/q9L/okjeDi3XuV00IkDh9yGv2fq4VKcjClkTc1yyNI1VLMEcolZB
	xrCuB63dXyQlfViA25Wlbl1+5UBStxB1P3Ne3GB//hIrowTEzk3fyknR/4bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787498613; x=1787585013; bh=qAWf10ZvYSoyb17zdJYfzvMh2L43oOIej7w
	wKXMpjmc=; b=YmVEz0UThCyB8aREdeOh82qgd6Vw3AY/prtF3ptHROmhOZURML1
	jTObh+OTOOuBCcMQB0nazvZtOizD8KveoOU6AgPkI27yVPC98RKbCkr54g98CAS3
	PRMehlTpRns8fhVAR+jnHXLIqic0afB01YIbX8WXBbO4A57NRswyRKaUp4JFgB/4
	jH35fVFE8GZkX4xjtc8MKI0VzKHTM/L+Tyk91h+hjgQQtglEfma/TGhcmFnzSIts
	mrXvijFzqrv72l/9sIwyC6l/fUXDlALCNiRksJVaieBnCxx82a3DIk3UL74DRUWO
	NEgqHZ207WctIHNUk+stW7gvl+gIQeW2F+A==
X-ME-Sender: <xms:dBCLapzGuIoPwT0NQcTT2ioZJoCo8dvZj68e72bvrB5pBA-emCr7Iw>
    <xme:dBCLagKfGY7tMbv08NX1gdILjfpMMZPx2Dr8s9Y-2I5oNTVFeK27DHV9zsnIDOear
    X-OlDuU2sGfbeFPhfagu3CJpYl2OYV-hX6kqhozT0oU-Z0TQRjeYw>
X-ME-Received: <xmr:dBCLaroSr3opbLMP-Mld9TLKs25-2b8czqESZoU0nbaWT8OWY1uZOkNEtWQlaHzMwo_DlLOpmKVoX7TqbY_gOlFZz1f6G7c1kg>
X-ME-Proxy-Cause: dmFkZTEztKRHnDzW5wy6N2BXA7Wf8l6KZK6ECWPZtlxYmUKKxParWe0akkeHb27Pjw/1Wi
    eVG7J+b4abF1zRCysbrqK0xdyBvym+Q1hQMyAEX47V7kQnI6t3jOC7HLAHprXBVLii2nlC
    bwEU8QVL56Z2lD7CE2nJWQpAUtRwsEBVstTjIi/XKZ12s3tqKdplqs5GvlNwbVCEY+dHfm
    h8Y1e5IrQomGlOExxgRW2r/sIgwIUwBIZeJNm9HjmsWdthHRFbK3iYpAqLimQ5HvBD/uSM
    waU+W8o/ePIHxtDxMSlMtrvyoVfUGeoKrdlBgt9V6rAeiqSzctlYhx8ajiVo+Kh20i7KpT
    uJnxjqcIdy3O5X5wolRhhYBBVg0R3goKJXT23D5l5QE2Ro+ONglEpKqbrMbMfWqZ3EW3BM
    JNhnUG0HHPJCNdtHNxPY/vWM9KgPB5/RFq4kXpz5Iv3QB4l+YZONarin96dmS1ILTGTPVr
    q99HphyYNYkNLS/ohuglyM5d/DuVWNMRUgqkizCRGs7d2OxbVWgR1MG5i8Y3WannR3Paxr
    gnOrzB4u02hhfDDCPUZ6APVdlh54rtHcxadVfHz9ZI3DknIWZa6zJQtgoZxC+Mfi1GJXxm
    BMw7m2VRBK9g7cjW/kEKFrdk21hCCLQG4ZK+zL/CsX1P/vvv5d1UrorQEyFQ
X-ME-Proxy: <xmx:dBCLanI_d5y-lEIG2Ru5ib69Q15rmuxtYU1qL3cHqc4JjIF54xB6NA>
    <xmx:dBCLaoQs9E_FhS5bfokzXhN1mKLrdKJue7xA7Qow0qpcWd14YGqBtA>
    <xmx:dBCLauvlofBL5kD8Lsp37k70vUJhcNhFclhSJYkR7eRbo1SRL43ESA>
    <xmx:dBCLahZPXf5V7ZrIW2OhVecQhJSnLtp5jf4L8xSPN7rFWsk0C3d9_g>
    <xmx:dRCLavapGRgmR0f3V715vzEPlTolHmHhJj8JkUUjYg-2E-Xkisvr28Bg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 11:23:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Alexey Samsonov via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Alexey Samsonov <vonosmas@gmail.com>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <aooRdiVdjovWSFiG@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sat, 22 Aug 2026 21:15:35 +0000")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
	<xmqqzeyeujde.fsf@gitster.g>
	<aooRdiVdjovWSFiG@fruit.crustytoothpaste.net>
Date: Sun, 23 Aug 2026 08:23:31 -0700
Message-ID: <xmqqa4qcvp1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-08-22 at 17:59:09, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > I therefore haven't read this series to avoid being influenced by code
>> > we're not allowed to include.

More on this a bit later...

> So we do have more of a legal problem if we knowingly distribute code
> that infringes copyright or which we suspect may do so.

Projects like the Linux kernel ask you to disclose your use of AI
(and have other requirements on your use), but I haven't read
exactly why they want it.  I wish they instead said, "We do not want
to be blamed for knowingly infringing.  While we do not particularly
encourage you to use AI, if you use one, do not tell us" ;-).

> If somebody comes to our project and lies to us about the provenance of
> their work, that's very serious.  Saying, "I wrote this with AI," when
> we don't allow AI is being honest and ethical and disclosing relevant
> details to the project.  It may be that we can't accept their code for
> that reason, but they have participated in the project in good faith.
> We could certainly accept other patches from such a person written
> without AI.

But that contradicts what you yourself did, doesn't it?  An honest
developer who discloses their use of AI admits that their eyes are
already contaminated by AI output, because they did not avoid being
influenced as you did.  So are they unwelcome now?

Stepping back a bit, even before the AI era, a human developer may
have seen code elsewhere that they are not allowed to include in a
particular project.  Learning from what others did is the nature of
our work, and it is inevitable.  Is it reasonable for BSD-only
projects to declare that those who are familiar with constructs that
appear in Git code after working on it are unwelcome, because their
contributions may be contaminated by what they have seen in a GPLed
project?

I very much appreciate that you are treading very cautiously on the
safer side, but I hope that the actual balance lies on a somewhat
more practical side that trusts humans.

> That doesn't affect whether we end up having negative consequences from
> distributing that code, true.  But at some point, we have to trust that
> most people are honest or our community and society break down.

True. True.

Thanks.
