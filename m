Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8C1C693
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874073; cv=none; b=iOLCKLTM4NoG2C134sreG388BzNzMuvrOjpUWaniqL14ijT+xQotLN/dRsqdnLjl3mw64AG7jkQ5WirJfAtPxNIjnGAmqi+n7dfJ89pjmOKaRBlyXNaI0nNqCpGSXAYDS+wPtkBGM6ED9iwJScbTapI51RlGAbTVh8bRaOb/0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874073; c=relaxed/simple;
	bh=OLBIH4rwGxjS+PHkvE7LzsEYrO71XTFcEJl6jck9jr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3pDx9ETIaNF2bsXWoXKiKYeHFxuYqBXNIWQ1fOC9QHWDqutvTdQ8PxHoO78zrD2dzak5DtT4LqiWE7+MvPUCoBaBOwEwdhfPvDCEVmiM9U8pn6Dq6tVbLM9M6yGF10wEuNbdn71We3m+35DYzbiq8C34ERXEqrjE7dvQQmSDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RLEW4ar; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RLEW4ar"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2077b48cb09so60885ad.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726874072; x=1727478872; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfkwQEeHFigSbM/VHizkVSMdHStFdoUtzc2f6PlFl6I=;
        b=0RLEW4ar6awKGlKek6X4IlfmInflE8qZDgGHvA4z2OOsLyVrtRSQuVUjwD+fCP2V0r
         mQF3aN17ZMXazOeQd8QLQYRCLsHxAvtTbFpkcvFNh6SlauQ4ciupjTJx97Fl85pOBL+R
         9uOOdPnN/CTcAjW0tcPUC5BVaG2JL22y5eWYR80PDC+IgDGTRd0snx2SPfMlw4/AbExj
         dBIjnCGs4nM/bnQAquATbr6JFlnkuBQDW860EQXmnA2KSxDTMsuANG3QJgjxBXD292mP
         u2fPAAF2nTrYesrnlN4w2DjSwIzHKlt9AAHNexP5cx19rQ7G+nB/2KFrMaKtsPboJbTB
         wfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726874072; x=1727478872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfkwQEeHFigSbM/VHizkVSMdHStFdoUtzc2f6PlFl6I=;
        b=YHobaWo8hRo2pdDHUsaW6wJuWMhEqy66DCYtYXh6XtXruaNHBxCpy4dzUG7XFlPhRR
         QfdJtfDEnKnGi/tZsNvaPXRFpU7FOUSa8SJCp02EbiKHQw5tFLnLt/gJnYKRgpzDCVYg
         6jxxJUQosWLFnh8sIhhbNsug09VlTKv1OIyXDVOO+9kJncZ9twgIPzIqDrKVPWLxdAdt
         HO560d4NHQ7rZBEYT2YeqRlN29DmGXJR6wp8AF79uFrNiskkij7UPLlpT11SGdnNM1e2
         n7fkzJUQQK3BMnJcDXJWNY9KkZ0MQXCPAeyx1jqSG2MWJpAqd2LN6+u/6n1I0auTliL9
         hAlA==
X-Forwarded-Encrypted: i=1; AJvYcCWwKvRM/YUkoZoS1V7iBfzX+CPsLG5VZl1Q/0YVJx5QaVwRBDZPw8VU80wNT3RyufAYzhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH71Z/v3ktZbn0EC6fTsIuVWsJ/xFgO08j+K5Wv23N3ixj6aKe
	nD/KVUlWRKPHQfRwW/afC0ZTnlZK3Vz/EWyFMcekL2G3Faa2mQ6qfgUaR6RtYw==
X-Google-Smtp-Source: AGHT+IFHJhivDEQ/1PTNoMsP/5yJrp3dyDQ4cCe8bTtsw0PWzEtz7qNdCZts1SR8AN1n9Nj2RRACQw==
X-Received: by 2002:a17:902:cec5:b0:206:b7b2:4876 with SMTP id d9443c01a7336-208e27d56b0mr947815ad.20.1726874071533;
        Fri, 20 Sep 2024 16:14:31 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3508:c939:5134:41ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da99esm100357135ad.45.2024.09.20.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 16:14:30 -0700 (PDT)
Date: Fri, 20 Sep 2024 16:14:26 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/3] doc: introducing synopsis para
Message-ID: <4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
 <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
 <xmqqo74rxvw0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo74rxvw0.fsf@gitster.g>

On 2024.09.13 11:15, Junio C Hamano wrote:
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > In the continuation of the simplification of manpage editing, the synopsis
> > processing that was developed for synopsis paragraph style is also applied
> > to all inline backquoted texts.
> >
> > Refining the magic regexp took more time than expected, but this one should
> > really enhance writers'experience. I had to fight a bit more with
> > asciidoctor, due to discrepancies between version 2.0 on my laptop and the
> > 1.5.6 used by Github actions.
> >
> > The git-init and git-clone manpages are converted to this new system.
> 
> The fact that such a "magic" processing will hide the gory details
> from those whose primary interest is to describe the commands and
> their options cuts both ways.  While I can understand that purists
> would find it ugly, as `backticks` is now much more than a mark-up
> that means "this text is typeset in monospace", it is a very welcome
> thing for developers around here, who just want to write their
> document in a way even whose source is readable without having to
> worry about suh gory details.  Maybe this gets popular enough after
> other projects notice what you did to AsciiDoctor, love it, adopt
> it, and eventually it feeds back to improve AsciiDoctor proper ;-).
> 
> So, unless there are objections and people want to discuss it further,
> I'll mark the topic for 'next' soonish.
> 
> Thanks.
> 

This still breaks on MacOS, as `sed` doesn't understand the '-E' option
there.
