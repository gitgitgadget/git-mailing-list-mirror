Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B141D54E2
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806805; cv=none; b=lnwe3HYLilZQYFN6K2Sbv8/ycvL2VNWqu8bFsiWPFFqShg94VB0+vN/Jdgu9RS4zqF++mpDcz1xddO5F+n8/ZuU0ZesOKZPg9jMqjlTJRfcdyHvdfggBI9axUgL1yREfkHGEhAl9olwtyL7GLzP51+MIWtdbSBPhNXWTggGUxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806805; c=relaxed/simple;
	bh=nTSFmqv+yk7Wxp1wG/KbU1mZ/MgY0CdxWcWFpUzaEd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=el+RF78GjB8m7Z5F1N8Rrt8sh3zQ7qP+nALz2wAGe50tnypVb3rWF34eBI5+cpzk95pbFZ8l/2BqUzMfpEkLK3sF2GX+wZCJHejmX3qmyx49wrfIEtBrRsRO4uM4RFkdhq15fStze7FWv7PZKDGW0xmM/cpLajMqXzRy5Iw2fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGm8Qlu/; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGm8Qlu/"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d46fbfab10so592935ab.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741806803; x=1742411603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrLOqVdMN1wk5um1GmHhLRfyvQCUb1D1p6tc+vmUC4c=;
        b=iGm8Qlu/nDbkkttI6oXw5PzgUi9K1Exw5V/idcc7Hkxe6hn0Rjk3hu8pT9eVYYROQ6
         XBFN0OSnxFRouq46l2LSyknwAriR8V2QPhxRrvAvt5nYwYuIDZt7u5avRnd9imRY1LlY
         +5vECgaOq1Bf8UyE6XkF/5JcgcCUaiM/B9awU2yfjexraJypo/MvQysdTpjBtmEvqMOF
         0CqgiqAqrQdSlGAulyiE11TKVKebcsBWiARG9Gq6+HM5ZsnMyTyR3xLzMSaSv8q3tvGF
         RQS4+NMRcesN3Mc9rQuN+iZEoMPFIdIgBMVFAm8pYO9wHVZYLU7CskwLLKCk/sqpDm86
         qt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806803; x=1742411603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrLOqVdMN1wk5um1GmHhLRfyvQCUb1D1p6tc+vmUC4c=;
        b=EzloQo6d/uu+KPv+ZtvAKeovJGAS8vr77VeHhn/DmE9RMKBmPMnXOu430q4dxn7Ew1
         MYyPZBXHwiSbWH3AhlHezn1NbkANN8cYONfdtVoc7JJsrOouHDHMZ4GFUMwtZibi42ol
         2TP6uF+Vbb/VA/WzyjIqckEkgLfzIEbXQ8QQ4AYaNqgU/BBeyTlQuvZb8Bp1ZDTSuGJF
         KyVZes3QiEHszujfozH4Rp+O3r+/vd+0/sCzrq5aty6SU8imjcmqgaFUPWfOdlMPcDjQ
         YhNhR9hkWZLMedoMwGVmtxPVAzcLgoO3LArdVrewi7dik3/hUuw2Ayjo3N2j72ti0jNJ
         oiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgl20u54ABt0eErkdEXb/C0zBhm9SSO3A15Q9L9j/16Y/3dJp3Rt7wHRQF1uwFt6Y/PIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ikxBAs4zVhcHaFcypHwNfC0irY53vv9Zp00K2qg1AgNov66i
	FH50km3coHFrHNUsA1isQOtH+25baOXsbXhNyV+L+Z5x6vxLXU7fQNJ4t1weoduDGJDKvwTul4/
	c9HWOAPg60z59d/00B85Bl1FaIq4=
X-Gm-Gg: ASbGncusybBURFWRZl/VyDmOqiP9KEzZyuRHSNFVUoaLAzNY5LOT9o5nry9N2Lyt7Gu
	qujszmvRNx9lV0/F2APQibvvO0DeU1lFcuJFZ7r/m2isxCp65Hg3qKv12qZ4AxjREt3/rB0rUDD
	gctl3Vb3W8tujXX8rXv/7KiK3JlZsMYxaLgRwVBmrVot+/9Tm9hViUE8eRBQk=
X-Google-Smtp-Source: AGHT+IF8UWEPpdON1jqscsRsC1HIgVrpvO3ChdfnmX+Exd4Bg0oNlEFcToS79dRIjO0YBB6uKbcNPQrbEjw45dlCTaw=
X-Received: by 2002:a05:6e02:1848:b0:3d3:f64a:38b9 with SMTP id
 e9e14a558f8ab-3d441a39ce6mr254512255ab.15.1741806802681; Wed, 12 Mar 2025
 12:13:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com> <cover.1741648467.git.me@ttaylorr.com>
 <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
 <xmqqikof2pqp.fsf@gitster.g> <Z9Gmo2P3Fnt3JeOs@nand.local>
 <xmqqjz8uxfyq.fsf@gitster.g> <Z9HaYEyYgBYTiia3@nand.local>
In-Reply-To: <Z9HaYEyYgBYTiia3@nand.local>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 12:13:10 -0700
X-Gm-Features: AQ5f1Jrn39QWAwhkHiPA1nhzS0TQoADmlhi7r1kWHxogILNrRzEq8yB-oDaKbeM
Message-ID: <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:02=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Wed, Mar 12, 2025 at 11:26:53AM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >> So would it be feasible to remember how 199MB cruft pack is lying in
> > >> the object store (i.e. earlier we packed as much as possible), and
> > >> add a logic that says "if there is nothing to expire out of this
> > >> one, do not attempt to repack---this is fine as-is"?
> > > .... So
> > > the majority of packs in this case should all be removed, and the sma=
ll
> > > amount of cruft data remaining can be repacked into a small number of
> > > packs relatively quickly.
> >
> > Given the above ...
> >
> > > Suppose you have a 100MB cruft limit, and there are two cruft packs i=
n
> > > the repository: one that is 99MB and another that is 1MB in size. Let=
's
> > > suppose further that if you combine these two packs, the resulting pa=
ck
> > > would be exactly 100MB in size.
> > >
> > > Today, repack will say, "I have two packs that sum together to be the
> > > value of --max-cruft-size", and mark them both to be removed (and
> > > replaced with the combined pack generated by pack-objects).
> >
> > ... yes, this logic to reach the above decision is exactly what I
> > said is broken.  Is there no way to fix that?
> >
> > > But if the
> > > combined pack is exactly 100MB, then pack-objects will break the pack
> > > into two just before the 100MB limit, and we'll end up with the same =
two
> > > packs we started with.
> >
> > If "the majority of packs should all be removed and remainder combined"
> > you stated earlier is true, then this case falls in a tiny minority
> > that we do not have to worry about, doesn't it?
>
> Yeah, it is a niche case. But the more I think about it the more I see
> it your way. I apologize for all of the back-and-forth here, this is
> quite a tricky problem to think through (at least for me), so I
> appreciate your patience.
>
> The original implementation in repack was designed to aggregate smaller
> cruft packs together first until the combined size exceeds the
> threshold. So the above would all be true if no new unreachable objects
> were ever added to the repository, but if another 1MB cruft pack
> appears, then we would:
>
>   - See the first 1MB pack, and decide we can repack it as it's under
>     the 100MB threshold.
>
>   - See the second 1MB pack, and repack it for the similar reasons (this
>     time because 1+1<100, not 1<100).
>
>   - See the 100MB pack, and refuse to repack it because the combined
>     size of 102MB would be over the threshold.
>
> So I think it's reasonable that if we keep the current behavior of
> repacking the smaller ones first that this case is niche enough for me
> to feel OK not worrying about it too much.
>
> And, yes, breaking --max-pack-size when given with --cruft is ugly.
>
> > > But in current Git we will keep repacking
> > > the two together, only to generate the same two packs we started with
> > > forever.
> >
> > Yes.  That is because the logic that decides these packs need to be
> > broken and recombined is flawed.  Maybe it does not have sufficient
> > information to decide that it is no use to attempt combining them,
> > in which case leaving some more info to help the later invocation of
> > repack to tell that it would be useless to attempt combining these
> > packs when you do the initial repack would help, which was what I
> > suggested.  You've thought about the issue much longer than I did,
> > and would be able to come up with better ideas.
>
> I think in the short term I came up with a worse idea than you would
> have ;-).
>
> Probably there is a way to improve this niche case as described above,
> but I think the solution space is probably complicated enough that given
> how narrow of a case it is that it's not worth introducing that much
> complexity.

Would it make sense to break the assumption that --max-cruft-size =3D=3D
--max-pack-size and perhaps rename the former?  I think the problem is
that the two imply different things (one is a minimum, the other a
maximum), and thus really should be different values.  E.g.
--combine-cruft-below-size that is set to e.g. half of
--max-pack-size, and then you can continue combining cruft packs
together until they do go above the cruft threshold, while avoiding
actually exceeding the pack size threshold?
