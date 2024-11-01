Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1304087C
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451586; cv=none; b=GlJ76fSZBSgdCc0OXRUqG5XMseNP1NCVDL4963F230DYbkc3L1KZmXiBsoLOsdDyAezuKTy9fQldvMgKpu+P2E/gQbxkuAg5wZUQtDF4gzZ+rqnGhIHwprEVyUHYI/8B+35qP+8EntSUzeWBGofEdBAez2JZiW42g7DQNxd9mCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451586; c=relaxed/simple;
	bh=Os0VcVHvj186jBhnOJEDzs007B1v4AUSAweWVzm3z/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQUB0wn2juPBU2AsnT8UH1lLb3i1zZSk21WBnMxY32/mb1ivwd0fB5HJkLzn3TPuCUJBl169ZoMfWs6O7SwaluTW5PuhC4UEoc0CQFCro/NJn3Y5rdGiXfYbMPAr4EhjlGIj/qGKcK/ZsIX7lGLhIEa/zUBVgMTxBtGUnZf468A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LfVEpHsw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LfVEpHsw"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso261530566b.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730451582; x=1731056382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn+fizL9xyYMQVyenT7yBdxkHeNDlcXCIvLEcm1iBVQ=;
        b=LfVEpHswponV+wFCqKzTUosTvD4yNhSoiCsnlpImqj6LXJQV030U6QFWTom4jBgpvK
         vEZHw3Tu6K11tDdvFDejut4kqrnuVSuG+lZhmAxPh/TqyfJpzr5OoeDwpDl9Z/blnpSb
         jnkGews7CdJj1/nVFtX6sBQwCa1TEdwpCXOUPSAuNX+xUEsOCb7zKCWGQcjdOHRmxlb7
         NxQgcFWjpD8xPQAqCCthWgfFjpVkdB1+fi5h3sAo8BvAPbMyuGq08RTKyVhxGOUYUoz1
         S7vu7n2b3aXiqLYxaVQ9Piww40+FD1JdWVPUVpyn7lPF3FAB8TRrifSoySeQ2i1jruR9
         6tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730451582; x=1731056382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn+fizL9xyYMQVyenT7yBdxkHeNDlcXCIvLEcm1iBVQ=;
        b=NpUFtQ/iLs0A0Hbe3sNwOkCVeMws8WwkK3Zu92kkskPMi0L3mahp4BA0AOswaEPYbt
         V9BYVMSO+rn7HOCyNrtHzIDs4i1lRUDMrQBGrfO1E0StgF/7+8Rnib6+Jehr15Hx5ET7
         hK8u+nYQ1pfFaTMu2mjW5vXAqqr9vFF8fKuvTLlPlDYYBx8QiBh0+FzMhIfwVrUvHVE3
         5mkLjC0KelCB9mHarj974RtFNPvTPZZNYGUFXG0hpq4wQIRXFGZTopRVuIwaDNIExSTy
         fjdtaXnomNKgAKkpDPcftqpSUvbni4evEdGDK3gAWC2eX1PIJdWaZ7pwzpmEY4NeeTpc
         dhLw==
X-Forwarded-Encrypted: i=1; AJvYcCX9wpiAur3F2IRB1x201QWniAuzokkobFaCPu0VjQ9RhpTE7RMOn1fKqyi9MiwrP3KLG0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQprpLTI1X0UdakuuA6TuCzjyviXUb4R/WxftK56DZzyyq4Bd3
	3eLzTybxcccBxNjc/a/Orwo3209A4o8IWclai5QWsKIdu6pZ5TjKM5hvFL8x0uxudaQXq+/M1kT
	mw6D51UMcts3Mc1547MZZ9ZZ8slNhp6WG/DkX8gplKHuhXTTBcRs=
X-Google-Smtp-Source: AGHT+IF10o6wcsk6BDPQ1HxY0C0sBihuEPutmbS7IvfrnMjtxdSnC4ToT4jKCSZDSnu/64B8Fdu83GqePDh1CYkexKs=
X-Received: by 2002:a17:907:72cd:b0:a9a:9ab:6233 with SMTP id
 a640c23a62f3a-a9de5f814demr1853255466b.34.1730451582097; Fri, 01 Nov 2024
 01:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com>
 <cover.1730409376.git.jonathantanmy@google.com> <631b9a86778f15b7086e5f17fe850ffa151dd341.1730409376.git.jonathantanmy@google.com>
 <xmqqikt74rs5.fsf@gitster.g> <xmqqcyjf4m3h.fsf@gitster.g>
In-Reply-To: <xmqqcyjf4m3h.fsf@gitster.g>
From: Han Xin <hanxin.hx@bytedance.com>
Date: Fri, 1 Nov 2024 16:59:30 +0800
Message-ID: <CAKgqsWWo2r37nsxeYErXjEgrSepBgFpdde9bXuYDTfu4MC3+Ag@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph
 but not obj db
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>      commit =3D lookup_commit_in_graph(the_repository, oid);
> >> -    if (commit)
> >> +    if (commit) {
> >> +            if (mark_tags_complete_and_check_obj_db) {
> >> +                    if (!has_object(the_repository, oid, 0))
> >> +                            die_in_commit_graph_only(oid);
> >> +            }
> >>              return commit;
> >> +    }
> >
> > Hmph, even when we are not doing the mark-tags-complete thing,
> > wouldn't it be a fatal error if the commit graph claims a commit
> > exists but we are missing it?
> >
> > It also makes me wonder if it would be sufficient to prevent us from
> > saying "have X" if we just pretend as if lookup_commit_in_graph()
> > returned NULL in this case.
>
> Again, sorry for the noise.
>
> I think the posted patch is better without either of these two,
> simply because the "commit graph lies" case is a repository
> corruption, and "git fsck" should catch such a corruption (and if
> not, we should make sure it does).
>
> The normal codepaths should assume a healthy working repository.
>
> As has_object() is not without cost, an extra check is warranted
> only because not checking will go into infinite recursion.  If it
> does not make us fail in such an unpleasant way if we return such a
> commit when we are not doing the mark-tags-complete thing (but makes
> us fail in some other controlled way), not paying cost for an extra
> check is the right thing.
>
> Thanks.

Although the scenario I faked in t/t5330-no-lazy-fetch-with-commit-graph.sh
usually does not occur, if we are unfortunate enough to encounter this issu=
e,
I hope it can automatically fix the problem as much as possible without
relying on me to take an extra action.

Thanks.
