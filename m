Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634C1AC884
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482605; cv=none; b=nMiUafrfKT0RjmfGtvrRuVurRBXRzwsxqQlTaz1H9Yl0cXONZdmJ+pQTpIJH6CbYWWq9AIAE3dWjlKQLGmXu/VPeGD2l3ZobhoR2xCsr2ES0J1gwCiqh1qfBk3PSXtyOz+F8BIAX+SBAo0no4IA/vK2e/5dbV8yAxFFZ7hdoiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482605; c=relaxed/simple;
	bh=26e+c8VUXEvgzVSvj/kVLVcXlz93ftHZlkpC40NhW0E=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=MzUkFxASKAhVDzK1JFXowcUWHWbBWFt4/MiEwDD0shU1SE/XOLX5C3LxgAPtoJp+VPOYkyRQsBxSsHMv9sMw6JVrY1uJTwjrlT/iF1SE0tysI10icYmSqs6rdDRuK8H23j1jFPFswSPcs/FpydDD6d/fvBNqIP7fwKKTrwXlYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtV0k+iy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtV0k+iy"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e5bdb9244eso38177387b3.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730482603; x=1731087403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3GIoLY0uzo2hb19LHKgLeTjFMFLCRIag1QQilgXnlhI=;
        b=JtV0k+iyxJj8raLSNHZO7q48Th3IAwfs2JO0p69hmPhnEu8cV2kWYgjS1bBTxyadz8
         UTkBzWJKG7huosWwNiJd3827xhmXjJb8KJUfrDk9vrRumpqULMOsKf3Mu3V8QBHpo1ho
         D9GxiJqoBl7dMb+QL4AQ40ZoOEUfiptkgMLk1ntfpTcYDO8nIQrC2Lv7nQBSU+YJhozP
         3Axz38j/o29g3jxF+PrO5Ybs6fLdaByG6da0uuJzYuuiMlTBzv+jfCl97O8uYUHBkeM3
         wXa2Ipkm4VF6k0hXiSDi4oXjXap3OLjmfcM3AYnLFMp7cAoZDABegxxCKTQFLJ6GlItt
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482603; x=1731087403;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GIoLY0uzo2hb19LHKgLeTjFMFLCRIag1QQilgXnlhI=;
        b=RAxbOaQdcG/OijDFeFxGYByGm6cH8aTvQG8N3UpafQ0wZNNvM8QdaGi/K0qhMwBSMu
         U7/VmcaovMYKXdJbRMWIZaJ4WyAaj90BBuZ4rVl38I1pcWZt/qGEL9sF5iwUmNx5hX6z
         FsuWnH0MPyXf8aS7/ePJ8+BrF+IURQd/xzD9CdZ4HqTLw63zdirOeksngKGfaRb43U6g
         j6D9X4cL4fMZSgcMHFFscK1VYK3NqEyHYNhLut17kk26rEg/ofTPWzHVyqPHWkXgdCMv
         UKIIMAQW/2FqHopM7ZfYZ9FPbuOTKs/rjCCDek52JIK4Ip6OpDDUCcwvhosCltNa8ewe
         kIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNFVEhFDwHDlyjB0EkosIWPOv69ZuJEZFOku25rs9eTCCFkMsm6sYuezhiD6thFEs28k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzam/6Gmzg6ODIwmGdkMZAWCIwPo7LPHdDeREdi0AE4GArjDB8J
	48NwN2kcDXpMHM/k4Y4KFbF/81L6VHh3pa10rKwTNVgvbyV3Rk77PgiVVw7j0woge1RcGvSz3xn
	kL0jAsfLsQ+8lZyf+w960VIbX5UB1kA==
X-Google-Smtp-Source: AGHT+IFx7wlLzmSs89puVdMDhmO2DFmhJAbUMzFL/lMorD6xw6t+5V75OoqRIXkjTaeMc+7gNdIwcmz6sEmSor2NWEsH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:25c7:b0:6e2:6f2:efc with
 SMTP id 00721157ae682-6e9d8ad570amr9292867b3.5.1730482602901; Fri, 01 Nov
 2024 10:36:42 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:36:40 -0700
In-Reply-To: <xmqqikt74rs5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101173640.683565-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	me@ttaylorr.com, hanxin.hx@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >  static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> > -					       int mark_tags_complete)
> > +					       int mark_tags_complete_and_check_obj_db)
> >  {
> >  	enum object_type type;
> >  	struct object_info info = { .typep = &type };
> >  	struct commit *commit;
> >  
> >  	commit = lookup_commit_in_graph(the_repository, oid);
> > -	if (commit)
> > +	if (commit) {
> > +		if (mark_tags_complete_and_check_obj_db) {
> > +			if (!has_object(the_repository, oid, 0))
> > +				die_in_commit_graph_only(oid);
> > +		}
> >  		return commit;
> > +	}
> 
> Hmph, even when we are not doing the mark-tags-complete thing,
> wouldn't it be a fatal error if the commit graph claims a commit
> exists but we are missing it?

If we can detect this cheaply, yes it would be ideal if every time
we read a commit from the commit graph, we also check that the commit
exists in the object DB. I don't think we can do it cheaply, though.

> It also makes me wonder if it would be sufficient to prevent us from
> saying "have X" if we just pretend as if lookup_commit_in_graph()
> returned NULL in this case.

"have X" is controlled by the packfile negotiation part, so we would
have to change that. (This part controls whether we send "want X" for a
specific OID or not.)

> In any case, infinitely recursing to lazily fetch a single commit is
> definitely worth fixing.  Thanks for digging to the bottom of the
> problem and fixing it.

Thanks.
