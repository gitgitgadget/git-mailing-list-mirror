Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06145BE3
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409845; cv=none; b=T+dHKppoU6mYA2ha1wNRBaItgfpsuUSzjSQGeE2+P24UyE3Fyn0dKrH8OjihpBOy3dniJegmYIAnRUjSMU++6ATIKAXS/NQ45TKPzORokmCOI7cZHFpmJtnTAoNH9wlhTRilveuTJDEW2EV9bC8lM4n2l6LEFt3B4vVW0Gc/I08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409845; c=relaxed/simple;
	bh=JVMcjMzf0corJwHxPim3y6m3jkX0ZzYYNWb3OgwVKSc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XtuMxSMiZZE4CeOe+Nk8fRLrKkqz6V56tuNhwRq59ZxnPO8byj01lHLMwKpRcxHBDEPmhgvvPHSl2+P+io5CIKDPz55ucIwEubR8aOzpJzV4iipJb3PrGgfUAtY6pspkt86/QheYZZKpWwuBJltXP9+grEOHslIwuznWiNwa7i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tV+WMy/2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tV+WMy/2"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so21531917b3.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730409839; x=1731014639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FXMCdrAW6yGSM1OugbhcdGxiizwYZz3xfIzlBzh4V4Q=;
        b=tV+WMy/2KYcoGmrSAZYeVZvhiLB7WNFBC+EZ2o37GJu/OlWiGt+kno7enaBYJU+syG
         3x7IAtxPGBoiHfKencV/bI/tuZhJJFEO+TkHKKPxJOikdvS3tIPSN2Jkn3eQt8AFtXmR
         TJm0rILvL7fwB9sfe4AQQkqMui8Tt/2ww9FHXDpdsp839cIoBmLedvePDR9zuzI3HgMZ
         Sd1inHZVg+APtM67N0hQSgssq4IEVWJ7ddOxHFLbVZguzveIO3nuGkz8iW/aK4n40FJ/
         Ssk6GbLVEKuwzW89To7DmPrNnaKLILJE0kLeaKDHN3cNj4WGDEsgD0VAz+DNOmaci5Ac
         EOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409839; x=1731014639;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXMCdrAW6yGSM1OugbhcdGxiizwYZz3xfIzlBzh4V4Q=;
        b=SU1hwqb/UHB6r9o9p5e6ozauRFzIShYiMfxxcoadwZ52Kwf9x5N5lM9/j+r+Kv1vyC
         gcdE5VCMHIn0o2mw5cZZ/7K0bWqriPL3KNQ4RY6pfDArtisz5bunChMtIa0IT9v0+7Tk
         HBFFNUZeASr4QZCegGg8q9AB0A+zTqjVGkIFaZZwy2lsLxokCc9Em4BRAVwUbhALOoY0
         2G6jw6NoF4Liuz9uryO3iir3Ob5KLt1ssKwPKfEJJtaxQIAZVxJ7Co4uJ/Yi+s59mEXI
         bkr0pEOHarZveuvyfKdmRJO4u6ZC8ydzsQ7D4nmSEnbB3c59fuGSZu1hAY+B6A+k8pkL
         Dfgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzcF4WA9VaRDhtd/N0fHCAGwqOSSpTcTAgI23VfBQNvNcgAU1McK1bfS59DBcWuUvNBYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZiP04xo9oRcDjfizoQu6qCe2nUq1RByYNj9nDfqOTGVMAiQ9
	ZY3QPzpwzZTloY6FU13iCo9FHEBz1c2jLybrENOQD1da6L/zpmnsbMGQjx4JBXDft4sgogS4b2P
	mbSedn1HdGbQVUQzVLq7N68CkNdC9Fg==
X-Google-Smtp-Source: AGHT+IHGEqRIHCAqTcN1AISUqO6LpyaMtVe5eIDAeJioYnWBarEEjxIKjEojRyz/wFTelhGAL6LQUssJ7qQzcPvDcJUV
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1f26:d3e7:169a:dbab])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:4b8f:b0:6e3:c4cb:689b with
 SMTP id 00721157ae682-6ea643de98dmr234827b3.4.1730409838735; Thu, 31 Oct 2024
 14:23:58 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:23:56 -0700
In-Reply-To: <bzhg2a7mv2xrbahk6o5kpijx4dxmpkm4wrrjhatetowjdowout@hesucnp6cikf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031212356.545501-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> >  /*
> >   * Returns 1 if every object pointed to by the given remote refs is available
> >   * locally and reachable from a local ref, and 0 otherwise.
> > @@ -830,6 +842,10 @@ static int everything_local(struct fetch_pack_args *args,
> >  				      ref->name);
> >  			continue;
> >  		}
> > +		if (o->flags & COMPLETE_FROM_COMMIT_GRAPH) {
> > +			if (!has_object(the_repository, remote, 0))
> > +				warn_in_commit_graph_only(remote);
> > +		}
> 
> And now that we're checking what's local, we issue our warning if we
> have an object missing from the DB but mentioned in the commit graph.
> Seems fine, although I wonder if it makes more sense to fail earlier. It
> looks like the only place we do the
> `mark_additional_complete_information` checks is in `mark_complete()`,
> so should we just check this condition there? No strong feelings either
> way, just curious.

When we were merely warning, it was useful to mark everything then
check later, so that a warning message would be printed once per
object, instead of potentially multiple times. (In the infinite case
that we discovered at $DAYJOB, it doesn't really matter since the
message is going to be printed an infinite number of times anyway,
but in the "plain" case in which the user is missing a commit and does
not have automatic commit graph writing enabled, the fetch will indeed
terminate.)

But since we're making this a fatal error, yes, it makes sense to fail
earlier. I've made the change.
