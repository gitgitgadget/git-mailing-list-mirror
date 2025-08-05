Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651C2F2E
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754426848; cv=none; b=g+d5dra29wjZVQJVSeuTQG1HnsGLgart3SaAWe5Qk0AA69gORgdZGrEIDRVNraYKuuObFyZOkSKmeosN34P333uXxvsWLJhFSfDYvfgp10UtnAhJ3VESq/fe99IvYd1wVRf3domDb9AVfLDEiVxqvSrybaPsJcHTTnVY0ZAbcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754426848; c=relaxed/simple;
	bh=MFAVzWkenVSnyxBKdiO5LIa8LWWJFpjKC7ClxCQFB14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm89nQkzH7Iz7ELwKIAbnx0M+Zici6mdoqtctMsLaclg1iJSSlPhTkK4/enHYEsna8pTQ9JJb6kKpC8n/eQbQMtlzgDPCQ66Is79pnsrk70ayv1chHm3sjtde1G/EaTvdDuizmHzGP6DgnHB5BX1GBJOP1MyLyUGzjussEiptq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WX8KEQSC; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX8KEQSC"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so22739215ab.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754426846; x=1755031646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpFJirWmFkVP1FWS8nyyglbjyU1kfQdWlkZ88CoInZQ=;
        b=WX8KEQSCAYXwFQUYX2hxqXwIr0HzCYV3oTt6dsH1fbbIQcx3oGCZ40RJZU3n5MxbKR
         8tM/ZDAjrXtMzW6hCx1JkMX6FpHg05PpvX9qSh2R+3q4Kujn2tqID/0T2zBrkoyMAiEC
         kYwWfUsOn5kEQxK2vhmCKXPcxUDMycuGhS0Y/OmIN83YExg0s93nhwtcErvESnJD43Fq
         u1xjbLl2AOPC+WTSQMAXgeJ9p21Xk6+QPq65dPchlgz0vIzKHCTCOsTO4XdwtR2PiZVm
         /B37CzAHWodRqvWfSkIYprWJhFJRpMSNLx2QTzr4aFTKBIIW0wqgMu+CwD81in1cMJpj
         ABuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754426846; x=1755031646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpFJirWmFkVP1FWS8nyyglbjyU1kfQdWlkZ88CoInZQ=;
        b=UmNZdp93RKfptS7BZPeynF5rggj1h0s1H7Yj4JOrjmTgJ3c6tBZK22InlS8d5sQUw2
         ssaP6XKASGtUSSCMmRea4yX5vWqryURnKOoTWneMh67h0jAUd6j2AS5xn34dvX+tGyjv
         Lhdh8t0dWtT3vGAsdQ8uV2jSIq8DMWrPYuKm9ftT46T7j2gbETNSu1UCyOCb4Pg7aXsj
         XK4WuvSY+yNECopzRPhvrQbPTnx7cFsS9e6FsMlX05n7pPN2rP+TwyPu/Kaf3ejrvqXO
         228FNN3oqUVt3v584DHbQXGB8cYV4Ad1ISUTp5ymStkOzcizt6Mi9YmJTQ8zi+y4EAOY
         DR1g==
X-Forwarded-Encrypted: i=1; AJvYcCU3eCL2oCCQoZvmnDM2Q8uJFlTUbd7IXpYyDe9in/Wb/q9ZtX6x/QyRO86b4aZLlwtq3kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ3Vq0e8pVxmCMfamaF1Vm0Ko9w2VOMa6d21d8p1fdK3TdF6m
	laubgnz79GHOmZ7h78/sag6Hm6AqD+ExK/fxdN+mf9Ktzt3/ZUda0dqoX/b41j7ngxDALLCpUeE
	pyojA9oxvkIfg9Teb2kCXQXKADOyVFNU=
X-Gm-Gg: ASbGncu3H015d6IOprK9uU/5wd4W2oO0ItCDS7CnOcZphbjt8Pzi82q9ZZqx+75b9wl
	5u6GLzb19KgE90lUQdu6NveQmLTMwP44vMtc5xhAL2/D4BHyrCf/US84Wb3iyABOSuFz86eQISK
	VyN4419UP7w+qL9W1nRk4e2rBSKbZg+sGxRj54GNu0QKVTaG8GjXHYFkBn3jKtT6ErRqpNFHvjJ
	x/mjmOz2LMzzdvL+0cYdJmh+YB1TTRcdg/Q+brJ
X-Google-Smtp-Source: AGHT+IEzsvZf75Z6rBR6WPCHqM6HZZ48GfbfewYh/bvzC8ExFCh+ryiNuyRKnt1L482BN+cfJ/iwRThmK9kUk5nDWR4=
X-Received: by 2002:a92:c26b:0:b0:3e3:b6ab:f869 with SMTP id
 e9e14a558f8ab-3e51b8f671dmr105585ab.13.1754426846575; Tue, 05 Aug 2025
 13:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com> <7238c8caf2b3c8c2516a8939c7590566cdaabd03.1754422546.git.gitgitgadget@gmail.com>
 <xmqq1pppzfnr.fsf@gitster.g>
In-Reply-To: <xmqq1pppzfnr.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 13:47:15 -0700
X-Gm-Features: Ac12FXxyjT-ldPLbB7Fx-T7YU8Ce8kHPRss1bRBt4LnN70lIpcAWdXsT9G42fQc
Message-ID: <CABPp-BEp9dH3Kidv=cHtzHnBSXyx-Vd3bkHBSC=O3MxjAMMTeQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] merge-ort: fix directory rename on top of source
 of other rename/delete
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 1:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     return mi->clean || (side_mask & (ci->filemask | ci->dirmask))
> > +       /* See testcases 12{n,p,q} for more details on this next condit=
ion */
> > +                      || ((ci->filemask & 0x01) &&
> > +                          strcmp(p->one->path, path));
>
> All the other references to testcase in this file tell the readers
> which file to look at, but except for this one.
>
>         /* See testcases 12[npq] of t6423 */
>
> or something, probably.

Good catch; will fix.
