Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BC36F918
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036071; cv=none; b=jsqPQBVXETGYURJzrjF0mOwWgANDp3xO49e+b9bZTBPjVloLo1MLGEpSZGgJPBZOcjqt6OAq64FNxeFFLrWkE5fncgcVloMyNQpfGWPhNGnAmAlcrNn3Jj9P7ttOY4r1otX6oXWcHsjjmu8Nzgw+4wosh/TprJng99cHdK6I35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036071; c=relaxed/simple;
	bh=sdChq5vUYv5LOvg9P54OfQa4Wu7/iunPOabKWlJmLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWhXdwKEIeekOiuKcNQG+iZJOuHW2eJvz8VBkYAv+sqkBHTL4efxEINwkqr5V0HEbC+t/Ac6AM4Wya2Kc8U25ZVBwVacXTBoqIus32TgRrnwsj60hiPp915hxYKtxIfahabNWlAWWjpGUwaMGjlY2W0LyHQ70AjNV4i5VgwloTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWIU78PM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWIU78PM"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-486560db92cso4511696b6e.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036068; x=1781640868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJyVBFNeLa4Fiw7Dd8100oVV+vSar/4E8wRt+LlRChA=;
        b=BWIU78PMoc34fmfZO2NkLOtYsuHo/ZYtgqCpsQqTR+gEHCmfgvW83ZxNFNLi/jNBcg
         qnMyJdkdTrtCofLQWIqvj2DoQx+ZLSgEj05JR1WpMC9FWslGii57hjyHXGY/Ay2AXlxf
         kKX5spqUdqdhBGw2/K0In/PmYP3SvyMiSrR7kB7r6ZwMeN029ObvHXnHk7HoBw7xFNJ0
         fbFhnc7nLQkDOqBqijCh09j8W83YbkfyzBpFVzquaShQm+HSF8TXMh2EFQMLYDh/rA0+
         nKFf6vg3uxjExzQd53D3sM93WU9p0+CYzepbzBci1vVPFGz0DPbcZc0/FDnXDMgYshzx
         OvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036068; x=1781640868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJyVBFNeLa4Fiw7Dd8100oVV+vSar/4E8wRt+LlRChA=;
        b=KXpyQG/8H1rdY6NzzVUwv+GAJrxOLEhnguUr12xZEls6L6E4ibLzd6NT6FcnBFxxfb
         g0yiBG7rBJ7U41D/rAC4uOUV7px03MTbnRWsxTRvrpkzMtDQutkVDI7vtv70jRY/ZAN4
         tPZVp6FGl0/KuBadcZ700HzbLqC4zw9IzoZaarZbE8YkOTeUMSHBXs2102onKn9OF5/K
         udst3yhhQkAt43705macOtQDZUlzw8bdAYPz54EPz+5KIbmnPNUIEa8iYV7djUXZLVKn
         wsBSoKtugPJWUBWOBEwLkawZXMxzYU8r/tfsBqPAh/PaJjseoFxSyhuTv0k6nk1WFJoq
         QuNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Y1QXDHhF6tayI0fAjyRdeLA1mxoF5GjHaWRGWQV9MwGu9smlKdBis6jhwrnYEhTVGiBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/VtxjwZ+DQlaKhhXP1V5qoDWqqPL2Fy0AX5NqBiRcfbdH1S3
	AOdon3OOlMmU+9zv0S2OR8jrYv0Ua8gheUlTSOA6rY5PTPU2LkQS86XA
X-Gm-Gg: Acq92OEJmt/L/tZtDAGpd2z4rmJyNCHnSolyrLX1VCSAY5RLy9gqqwcOlZj5+RMryvf
	0Qc9YB8pKYh7+D/D4poEMYmGxgruDIe2vIUxPuDpQvjX+HHQpPHZkIo+NHvjKcHkGLDFy/UAnID
	EAvxeKC2nMUoOYybtij2njdxq8oIqjd45+HV7f79SFxNKNAGDx/CpvP3rkdE1vUr4foH6sobesn
	zIfJiB6sXBhBOxUTK59Wd6fyHPIdHFQSgiNObsSzMy561DQVWjlyE85Wz0VZVZodXUpVrALma1S
	nr1WnV57M4/j2HsZzVP5QW/klQiV7qXl04sh1WYRlVGkVYtMKoW6jaWyWi5uRxKuc17CRsQEbmK
	zepQdnbAF5GGVLvTrXbB1EY2bUSY9XUpP+MlL3A1BOQpKx6mufYMp3WRsIYWI8E3jkro3Ahoh2o
	KLOkRZGXtvre8vjdXRBb7LYztEWki//g1ZM8Vujw==
X-Received: by 2002:a05:6808:f03:b0:479:d6cf:ca8f with SMTP id 5614622812f47-4868e0e138fmr14221119b6e.39.1781036068015;
        Tue, 09 Jun 2026 13:14:28 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm16873812b6e.4.2026.06.09.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:14:27 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:14:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, cat@malon.dev, ps@pks.im, 
	kaartic.sivaraam@gmail.com, ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
Message-ID: <aihwS9aQ1b_8q_5u@denethor>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
 <20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
 <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
 <xmqq4ijbsn2m.fsf@gitster.g>
 <aihH8ye-r4QuXlRD@denethor>
 <xmqq5x3r1ph0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x3r1ph0.fsf@gitster.g>

On 26/06/09 12:30PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > I can see a situation where a user performs:
> >
> >   git history reword abcd1234
> >
> > with the intention to modify a commit message, but then for some reason
> > changes their mind and doesn't want history to change. Maybe the wrong
> > commit was referenced, or they decide the current message is actually
> > fine. From my understanding, there isn't a great way to abort rewording
> > a commit during editing and thus the user would have to reset history
> > afterwards if they care enough to go back to the previous point.
> >
> > So I do see some value in a mechanism to abort rewriting a commit
> > message.
> 
> I think we are saying the same thing in different ways.  I want to
> see that command "succeed" either case (normally we create a new
> commit object because we record an updated committer timestamp, but
> if there is no need to create a new commit object only to record an
> updated committer timestamp, we may choose not to and leave the
> history intact) and I do not want it to *abort*.
> 
> The mechanism to do so may be exactly the same, i.e., accept an
> updated log message, then try to "hash-object" (without -w) the
> commit object with everything, except for the updated commit log
> message, taken from the original commit, plus the updated log
> message.  And if the resulting hash is the same as the original, do
> not do anything further and return happily.  Aborting sounds more
> like complaining loudly "baa, you asked me to reword but you gave me
> the same message? is anything wrong with you?" with non-zero exit
> status, which I think the user does not deserve in such a case.

Yes, I completely agree. If the user doesn't update the commit message,
for whatever reason, that should still be considered a success since it
follows the user's intent. I don't think it makes sense to exit with a
non-zero code in such cases. I would also question if we should print
any message/note to the user at all for the same reasons.

-Justin
