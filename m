Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34271F942E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537362; cv=none; b=kFDgM6uT9e2Xkmj6QfvagrkMBmNGVMpCrnccIgoKgVDExZwKmgpNHxIB55aHjhFqARoau+C1RRzL0pRbcUZwaZE2PTSkoQbC1A39d1JB8nKaWWUsB68e0S8eOYWb6vVBPw/Q2ZXGmCZ4BAdvSPRabT1P3EZNd3WSBRyyVUOwgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537362; c=relaxed/simple;
	bh=avoVmZtZrCYBSLlMgMUelqMQsmaT2cmhOPxeO6xJJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwanKtuV1D2HBtEyw5TRgwMq/ftTJE3WYUV8SjwCvCDnEjhLIPFCA84/Sg1hUtnMaflcRwStAunhxcZJlbbcXDo3LKGWELXBb6tmy+jAVXU/s4AaWEZC6J/kRu35+MxGARHKM1UEOU9hwjaNO29bAWYV62lgVsNSJJfaNbShVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AnP2Kn6E; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AnP2Kn6E"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e2918664a3fso4069631276.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729537360; x=1730142160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49B32nYMEJuIx8sKEgHeG3vDhExI3nl21socEBZbUbE=;
        b=AnP2Kn6EEcS5TmuMP6fUDDJkl4iqDo9BQlqTwjjFecxik5TNx5YVtr9oDYf4oa/OFc
         yROG6kn3UZcyj6ZvBInNc9Up/heW8Xx13o3I7ms6YOr/yHPoVLwvieJuNkUhsQopApJE
         76bFvwKGDkHJjj66XKwGQ1SN/hRIsJNxEoFKcioRnIzNfgMklXAmdIxuNK25ExxAYzrN
         pK35QTpiTYiqFxXlNUopoV1oJWaqs4Rl4vfTkKVLgliNNgPuX2f0rWYJxeJWjhmThg5C
         CMH5UXueiZjQgbTwWbUFeh3BWuWx7G94VRp8rNkqJ0eJhVSckrffbkD54Dwa1SB9jUB2
         I0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537360; x=1730142160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49B32nYMEJuIx8sKEgHeG3vDhExI3nl21socEBZbUbE=;
        b=lMYWSzN8pT4rZK2gTBp6sWs1Kivu9fqsM/AlTLHIVpQkYmjsvtKrfpZFJB8h1oDpcQ
         ec9tA2xKrdc1M5J8SSohJrKDGw3W8k8T903YmfK6f21DErOtTOY9swk7zNNHN6XTXvXx
         xSlv9hhyAUJ8MsAi5FJIC1T2tquiNEHcKbhcyH93I4385UjLiNIwYIUDP98dTsUg6IFH
         K8QUlzyTbHiuMnlyzNwJO9ZvDpC7qeUIgkRoqAytrH8nozlW0axgnvfxnUQ4lADyRDSr
         7/6ZeDQZr8DW6uWi8HJc/J691Fxd8Vr++zMdINNE/DzeQXgdC5cBSLOByjy8y8tVtzmk
         2YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU38sttPxRoxESf3JlCLCUaK6gHarn0SD10CmLAj1kJZ+T+f1YJgaFwVv8DR4rmzv2JxIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1D9daSsDHTwpDYZLEVmozAQ2rury1jjmClJZoxUK7qrJxqNLt
	pLCPiA2rLnYyD8u0FtmdwHupoGkbIS0HnTx8Xb/J192EOYQU36ahZK47a5IYhLI=
X-Google-Smtp-Source: AGHT+IFq58zVc/hogNzSuoIpFcxlBtJoFP6bhZQrlZ0Euc8Dr4j+L5YqLvWU4+pm09nCPXcH+3c2qQ==
X-Received: by 2002:a05:6902:98a:b0:e29:123f:49f with SMTP id 3f1490d57ef6-e2e242b9ce5mr707329276.0.1729537359729;
        Mon, 21 Oct 2024 12:02:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdc9b1f05sm761155276.26.2024.10.21.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:02:39 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:02:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Message-ID: <ZxalTgct8WhEmO0w@nand.local>
References: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
 <ZxZETN7WjbNiSRyF@pks.im>
 <d66936b8-d12b-4035-b563-328ae9fc4824@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d66936b8-d12b-4035-b563-328ae9fc4824@app.fastmail.com>

On Mon, Oct 21, 2024 at 06:48:20PM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 14:08, Patrick Steinhardt wrote:
> >> […]
> >> Notes (series):
> >>     From the commit message:
> >>
> >>       “ The test itself is fine and does not hide a bug:
> >>         `--no-create-reflog` is not supposed to override
> >>
> >>     A source for that: roundabout through git-branch(1):
> >>
> >>       “ The negated form --no-create-reflog only overrides an earlier
> >>         --create-reflog, but currently does not negate the setting of
> >>         core.logAllRefUpdates.
> >
> > Hm. The "currently" reads as if this was a known shortcoming rather than
> > by design.
>
> I read it as “we might change our minds here—watch out”.  ;)
>
> It feels very emphasized.  Like the documentation was expecting
> your surprise.
>
> >>     I *suppose* that the same applies to update-ref since (I suppose) they
> >>     use the same underlying machinery.
> >>
> >>     See also git-tag(1) which says the same thing.
> >>
> >>     update-ref should document the same thing, then.  I have that marked as
> >>     a todo item.  The changes there are a bit too involved to implicate in
> >>     this submission.
> >
> > So I'm quite torn here. It's documented, even though the documentation
> > doesn't exactly feel like this was designed, but rather like it was a
> > side effect. The test also contradicts the documentation, even though it
> > only worked by chance. And as mentioned above, everywhere else we
> > typically have a design where the command line option overrides the
> > config.
> >
> > Overall I'm rather leaning into the direction of making this work
> > properly. But that would of course be a backwards-incompatible change.
>
> Good point.  It does feel inconsistent.  I agree that the conventional
> pattern (to my knowledge) is to have options override config when the
> options are given.

I agree with you both that it feels inconsistent, but I feel somewhat
uncomfortable changing the behavior here in a backwards incompatible
way.

Even if the original documentation leaves the door open to changing the
behavior, I think that probably a non-zero number of users has either
(a) never read that documentation, or (b) come to rely on it, or (c)
both ;-).

I think if anything we might consider updating the documentation to more
clearly capture the status-quo, but I'd be very hesitant to see a patch
changing the behavior here.

Thanks,
Taylor
