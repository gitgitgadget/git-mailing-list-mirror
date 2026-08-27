Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9C1A5B8A
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813394; cv=none; b=Wz4Ty8Sauc0BXT59UC4v7Weh9RifabbQ/LAPd54OUwavAWjLWDUnLk3GPaNgJCxGttvabR9hm1Kwxsi4/HrJXn9h430wVN/VQwVe43jmfpGDfsA7lxOWFW6gjZIc3OFkZIOxnCTN9nv4405E6Ps/E9FJfgwqSI/aXtf01xeE0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813394; c=relaxed/simple;
	bh=uNvhmsfUy3GCyJD4COknvg2HgNzWtmQ8tKl1sgdrmr4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s/WuXL/InUoQne7qvaSYlAXsdUpix69a0Z/n0RHs+f25FM77FceDbj09fJ0g9WwXvaIlj5SMrHNjMIMZPT+MQDyQuuaslEU9QJdHaa3gcShfxx8/DtlY4vKQc44rr45fKBAgmYRmMHfhkGLOA1SIjVurGZeZy85CQZteHJjsLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LJdQK6Yp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSyMIEvT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LJdQK6Yp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSyMIEvT"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 56BEA1D000FE;
	Thu, 27 Aug 2026 02:49:51 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 27 Aug 2026 02:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787813390;
	 x=1787899790; bh=d+og2hZyMa4Hy9gMkMdlDIn7MLniKGpB0nd7csYKfYE=; b=
	LJdQK6YpjQqymzAiBof4FKxBjoE4o14MLz29rD9hhCx99Iq5bRiVBpC2r2CvEtpV
	ECFhHTVynmjol0BKTkwYGOndds5eUMBhrCeHFs+3p056RuROYUfQi7UgHkTt2kwn
	Qt5EeVrFa4RQMGEAXRzYukBcTC1AR7tVqa7JcWT4aiIG/MIrXUlf0zpx2yWp+k5C
	4z0xMo2q+t9xLfGQxgoxdvIuemFJbcIX8nz7Ca7GhZ7azjh5hgO+pZkw8QPWq1xN
	1LsseSk4OzfDgWuhMLzhyDbZC7dwl6XQL1jnCqVpVjyjXteRVfNB9+PxnYmi2Rnh
	KKIvmYCHfQ1IqWV3oDwgJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787813390; x=1787899790; bh=d
	+og2hZyMa4Hy9gMkMdlDIn7MLniKGpB0nd7csYKfYE=; b=hSyMIEvTVdtKhAXK1
	1NPoO4wj0fmVza5J/2qLnZbDIs4hGAOixIsKuhwUUI4Rqcd3KDH0hsBjM7FCb3/+
	BkXF34NZqxjOJcAWlDz05szkP90XGuArkwSCqtckAsdHyeIkGU1UPh0AOVNpgHzE
	oIjqs5RQeS0mVAn5opiQC+bu9YNiBisqxwGE5UlyKv2fFaWJVcnY7GYhkKn8ecwy
	imh0mdZTWB1SZSsU+6Df2ieOKfxCo0qKMcTnPInVa0B/dVG68Sn8w8E/fvEl/efH
	uL+k3CgQ46QRsVryhdzewyf9fpvDBbHfasdw6mU/WzKBAm1Em/LRo0ckSnUy12P4
	xQU+A==
X-ME-Sender: <xms:C96PavsJ6uxOgk72TCXg-3hHvWZkvfAhFGR6mSiCJ_6OzSfVv8yJnIA>
    <xme:C96ParSVkN3ZSA-Hmer4PavHYdSOALfGBf865O87UGM5p-r-iQ2-2YdX4TDY-YlMH
    xIXLLvSBp5EiUdYdOI2PpnNcL8fJtkOLNdRSfBUSSO4xAQ2AGAOVg8>
X-ME-Proxy-Cause: dmFkZTGHQmxow6+UYD/LKZn6hsVu6fdHHLGGXNS4tzALcA8aMV1yW/8735rrFDjA6Et53P
    C3666EFTrGzxBWlXimldUOE0fr0oP02MpmZiq7YXUa5rFJGipWoe5gA7gPc5P+DdZQbh/x
    KSa4Qf0FCtny0Uy1xjzcm5DL8f80SBV3pXGTZs+t/cQ4EtdzJBRKS/vp3otwPMNv0NWeUX
    7mJX0tNGXPP2fGsWqKEMRSdDvvVC/XHitFRiCKSaxSRLIz8b8k8G9AZuN/KPRTb5pJ1O0y
    NRmOry29gN+IFYqJwM8r3iLoA42YYSSg8PnwgmujT/6iqBKTJL9apABG8GXZc03cK6AFsu
    n6wb/RYK0Rs+DgSsV5JnTNjSMRTr+vLzOC1W1MnORH5MyBWWKEMRD5uu6y1XVyVteTGs1C
    ZdB3Jz3Oriaw4X9E+zFQeJvYaU0jGwYrMghqzdxyhKkk6DNfS8IZIh3MlhF+QsdFNkKApu
    een+BCsQgGndzDgXBCoHhyDBoZ8nYAWREH7LgJasad9gcJIrzSiJ0q4w7Q8M92VShI5+Lw
    sLp3jbfEdvI9/hmJTIUBiDaMjtm8aRg/sK/d4Gn8FHEsIXNLvrF5MXYBbnM7Bp0rlRdmeJ
    n/1SlKUcfwsftaPOQlaVXjF65CJ+T8Ukn3Ps5nMQSLy1nfU3HI4PA7OU0hmA
X-ME-Proxy: <xmx:Dd6PanUHeJm0LeGSVpqn67TFJ2s_622kB0LtNE5n-HyyHTpVL480Bg>
    <xmx:Dd6PatZYyl0K4TVqapuM9PT7pjPQx5ueq2N8vp2wQnEzVhc0EZ0wcA>
    <xmx:Dd6Pat1MgeGEz0XlBm974JeWvzCUdWqsJpaOHVmW1vObJKsfwuyquw>
    <xmx:Dd6PaviVbv9St8XzIO-D8iSDHuJ1Ix8-ZjIGbtS0eI3LFX8C6VZXAg>
    <xmx:Dt6PahqhSdPTvAy7InqO0m7x1MFKMAh-uOD5NGIwFZIe5C9dPc_sRpO8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D58C822C007A; Thu, 27 Aug 2026 02:49:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A77UefpisLgF
Date: Thu, 27 Aug 2026 08:49:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Michael Montalbo" <mmontalbo@gmail.com>, "Elijah Newren" <newren@gmail.com>
Message-Id: <cd741511-b457-4464-aab0-56d8554bf763@app.fastmail.com>
In-Reply-To: <xmqqjypchixe.fsf@gitster.g>
References: <xmqqo6epj6is.fsf@gitster.g> <xmqqjypchixe.fsf@gitster.g>
Subject: Re: [PATCH v2] you_still_use_that(): reword the instructions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026, at 19:48, Junio C Hamano wrote:
> The message is overly long and may mislead readers into thinking
> there is recourse other than adopting the new workflow.  Clarify
> that the message is there merely to help them find a replacement
> workflow, and is not offering to reconsider a decision that has
> already taken effect.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

From the responses on the thread there was one action point that was
agreed on and that is changed in this version. See the range diff at
the end of this message.[1]

Spotting the changes is harder than it needs to be when there are no
inter-version comments, range diff, or interdiff (any of them).

>  usage.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git c/usage.c w/usage.c
> index 3f0118ab2a..365c0bcb90 100644
> --- c/usage.c
> +++ w/usage.c
> @@ -386,21 +386,19 @@ NORETURN void you_still_use_that(const char
> *command_name, const char *hint)
>  				 STRBUF_ENCODE_SLASH);
>
>  	fprintf(stderr,
> -		_("'%s' is nominated for removal.\n"), command_name);
> +		_("'%s' will be removed soon.\n"), command_name);

I was thinking that maybe the final bullet point could say something
like

     ... and don=E2=80=99t send a message voting for it to come back bec=
ause the
     decision has already been made

But it *could* be mentioned here instead. =E2=80=9CThe decision is final=
 ...=E2=80=9D

I bring this up because some replies have come in where they demonstrate
that they know what to do about it. But instead of doing it they vote
for the decision to be undone.[2]

    Kernel audio driver maintainer, here. The first thing I want to know
    about a branch is "whatchanged" - it tells me exactly what I want to
    know with no distractions. So I was horrified when I saw the removal
    nomination message.  Please reconsider - while git log can do it, I
    don't use git log... at all. I'd just have to add another alias that
    would be another thing to constantly collide with while using docker
    build chains with different (but usually older) versions of git.

(Although this was before you could alias deprecated commands but still.)

Honestly, it seems that some people would rather vote/lobby for the
continued maintenance of git-whatchanged(1) [3] rather than execute
one config change. That is just my general impression.

And I also bring this up because the commit message says:

     and [the message] is not offering to reconsider a decision that has
     already taken effect.

=F0=9F=94=97 2: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A22=
7FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/

=E2=80=A0 3: This message is for the deprecated command git-pack-redunda=
nt(1)
     too but there hasn=E2=80=99t been any messages about wanting to get=
 it back
     in the last year or so.

>
>  	if (hint)
>  		fputs(hint, stderr);
>
>  	fprintf(stderr,
> -		_("If you still use this command, here's what you can do:\n"
> +		_("If you need a replacement:\n"
>  		  "\n"
> -		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
> -		  "- check if anyone has discussed this on the mailing\n"
> -		  "  list and if they came up with something that can\n"
> -		  "  help you: https://lore.kernel.org/git/?q=3D%s\n"
> -		  "- send an email to <git@vger.kernel.org> to let us\n"
> -		  "  know that you still use this command and were unable\n"
> -		  "  to determine a suitable replacement\n"
> +		  "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
> +		  "- Check what others on the mailing suggest as a replacement:\n"
> +		  "  https://lore.kernel.org/git/?q=3D%s\n\n"
> +		  "- Send an email to <git@vger.kernel.org> asking for help, only i=
f\n"
> +		  "  suggestions by others do not work for you.\n"
>  		  "\n"),
>  		percent_encoded.buf);
>  	strbuf_release(&percent_encoded);

The rest looks good.

What I like the most about this patch/change is that it is more
assertive and less wordy, e.g. just =E2=80=9CIf you need a replacement=E2=
=80=9D
not a long ceremonial sentence =E2=80=9CIf you still use this command, .=
..=E2=80=9D.

[1]:

1:  fd53eb2ca3a ! 1:  dca3205b1f6 you_still_use_that(): reword the instr=
uctions
    @@ Commit message

         The message is overly long and may mislead readers into thinking
         there is recourse other than adopting the new workflow.  Clarify
    -    that it merely helps them find a replacement, rather than offer=
ing
    -    to reconsider a decision that has already taken effect.
    +    that the message is there merely to help them find a replacement
    +    workflow, and is not offering to reconsider a decision that has
    +    already taken effect.

         Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## usage.c ##
     @@ usage.c: NORETURN void you_still_use_that(const char *command_na=
me, const char *hint)
    + 				 STRBUF_ENCODE_SLASH);
    +
    + 	fprintf(stderr,
    +-		_("'%s' is nominated for removal.\n"), command_name);
    ++		_("'%s' will be removed soon.\n"), command_name);
    +
    + 	if (hint)
      		fputs(hint, stderr);

      	fprintf(stderr,
