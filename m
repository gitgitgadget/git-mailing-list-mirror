Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20801AC884
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482859; cv=none; b=lMx5RUfFcBXtU3ajTVghUbf3JdprAdxYimCeZZdZPPoo/etXTRhuQyUrAfswJ/MQQY7W+qynmU8T03PZ16XOU9XG9H88Z0jRYKQt8jS5gCluLSrkobiuEGaCLE/i6u0zbGNMDD+ETnvD19rQoTDwzPKmEEYOhsQxQoNryllRm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482859; c=relaxed/simple;
	bh=J7yEWl0z80CoT7eg8QSLL9/DW1COSQIr6nPsN2WqczY=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=N2LniXPN573CDdJm3Li7DFWYH2OiqwWt8DSWpJUSb5kp2RsZ2CWE7/Uil93Q2YiFT/aUByUW3RSGsCRpRVx92MRQcOwRviBnfAj1Y4pgWgNfgko5DGhzN0zNPIVUMKAtWU1pErGGWhoy8E5MOmpkS/ZdAlZuDi62+05gsGYBkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOC86x21; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOC86x21"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9ba43a9a0so34325397b3.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730482857; x=1731087657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UIiHPSooIrjkG7TqwgIeK37gzcgB2MpjPeBnR4fVGTg=;
        b=dOC86x21zEw5Zmd2XsSLCP9+jQGnGSX3k9bSBCDIu1ixaeS7Jbv6qbEgK7ONsgyMB8
         Zj5wayJcnoMxeOcjgxnpYyd/pbfKCYxwGIyomGHOSHQ+aA+yYD/+kH8UHFEDW8viY9sX
         jrMosJSVTfDKVto/IXfZVtbF+fbE/k9iS6RhTdb8T66uUD3K3sYfVzp82yuBv5UldALA
         wt9m4OzVVLdpgYXcl8eHXXue9qpHFHtE1zQJKCTQ+6so8cUXYLamKI3dxa7cyCphpyCW
         efoxkTXjKwKu9HugMp307NMNFmXIjnLe6GC5NP5sHq+uvP/L/QfiwwMhjKCe5emGYJAv
         3QtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482857; x=1731087657;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIiHPSooIrjkG7TqwgIeK37gzcgB2MpjPeBnR4fVGTg=;
        b=HSs7VtK9L2FM8crVj2CAeEd6S98IjQ6QPhmCZvKlz0WMLcL+t7/Xc7LINNSyVprDK+
         uV9YvezX+WhKlCwpi890ejF7o+nfKHYdieaSujKBXKZFEqH91aPI05pOeo86trxhkMSW
         RdiuBtSdaeFN/bWrEMIUMSsf1DpvUqKPbMzbahSBlQroZ030OUdCmxyd4qlVyIi6LfKa
         zKqgcke1Wu42KXV8od6tYyjae5UKM3p0/0dKrjTnOQXdqXCCSdP6LqU6ZInDQBpN9x11
         g77qH9BSvYm67JKgmI3gSRBqH4aVoud5EwizI5AhAPgCc4PFyn6OwzjeCbRMu2S5hqRU
         SFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsvM9uQfmsrtR/RNiNIcg+myxkLzGPmmlxQtXcFgOTAxZFPwFLZB+5pGyG0kd+/iM6eAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXbRB27a7NrTeunCDb8ez+jH3KV/lOSBpPTU+kO8kkHgolCKh
	HbBudET41A6yTdc6NWODcpDNLcJP5MO05YalSvkjr1Sf328caY1jcocqLLaZR/pn9bp+U6xh9fU
	AOHOq27fsYWy4XzHwNO8z6UHSjEKBjQ==
X-Google-Smtp-Source: AGHT+IHF04Mlg2PGAz+cbSPQUlOkvYT9PeUjgDl05otl3bo+WASKLFEN87w/VxTrkoWMKvRWyp8jPA75hYP/WhyZOTqI
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:460b:b0:6ea:7a32:8c14 with
 SMTP id 00721157ae682-6ea7a328fe2mr21877b3.7.1730482856932; Fri, 01 Nov 2024
 10:40:56 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:40:54 -0700
In-Reply-To: <xmqqcyjf4m3h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101174054.684519-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	me@ttaylorr.com, hanxin.hx@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>  	commit = lookup_commit_in_graph(the_repository, oid);
> >> -	if (commit)
> >> +	if (commit) {
> >> +		if (mark_tags_complete_and_check_obj_db) {
> >> +			if (!has_object(the_repository, oid, 0))
> >> +				die_in_commit_graph_only(oid);
> >> +		}
> >>  		return commit;
> >> +	}
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

Just checking...by "the posted patch is better without either
of these two", do you mean that we should not use has_object()
here? I included it here in as narrow a scope as possible (when
"mark_tags_complete_and_check_obj_db" is true) precisely because not
checking will go into infinite recursion, as you said. (And indeed I did
not expand the scope because I agree that the normal codepaths should
assume a healthy working repository.)
