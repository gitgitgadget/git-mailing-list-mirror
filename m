Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373831AACC
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568932; cv=none; b=jttWnb1VZvg/Ux7Wt6GANYFreXVrSrwV+SHRw2mK0xoQVDotgUpOnRbDekdyCdBRs3z2XFYwEpCo4wH1TUXgCe3mp8E7/aABysexht4x521lOGYyQCPs1PumqJWYyg9UKtVs4IMubtCmMgc+6wFGjqEDpTiedy9di3Kn0g8/CLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568932; c=relaxed/simple;
	bh=R0OAg3zVXUMQylVoSggAg75jNN9gCjxX2yaHOpv0yus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx5s1LykO7eQ3AZG4A30QIRaghH9+XpAWaGkAgUCNWKMjXl7POb7VKo4vShB0QViY/J82tOLBGjVArng17L8iaUEopjz/haCKxpfpMtZMOUse4qtXjCgE20ah5KgacmubRcIBSHdZDOFrPGAto5PA2nN8WGUJEDt3fFEKMCMJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFY+1C52; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFY+1C52"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5785173dfb6so1442432a12.2
        for <git@vger.kernel.org>; Fri, 24 May 2024 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716568928; x=1717173728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHf+lfZBKOCb8U8d7/RtYTXM2+KZTgWrywZUaJXG0mI=;
        b=cFY+1C528QAjJHvSwPwcIAmolEfrLQvpqeatQykXEksIyhijLzJx3fNohEquxDLPHE
         0bT6X6cwxAn8Fi8XkH3V8pguxdu9fTRWv4g6s1bbTgFMil9n2bYX/sx/k8fZIPaDKVGo
         PZoDOdXmwHUeJPPUc+1Ol2aci/7iKLLvJuM+hzrj0YDsf1kMBh6YQvkPb+V8g0KJ6pEX
         JX1EOD31SmQvcCSeXFeIoWAXMfsIiKMniRQ8+RmmauzsfdpZsYqcF1/GHNpNMuq8SS15
         9XXw9d3TY098G4BsFxIRGJoO6dvZT0V6OoeAR69j3eY5FfeKjgXO7yFymGKZvFrsuihr
         DKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568928; x=1717173728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHf+lfZBKOCb8U8d7/RtYTXM2+KZTgWrywZUaJXG0mI=;
        b=bVlffgTWgE1AKXJCVJxwZXZ3/itrhhWoOHFVP31h98ZZNuEdxsIvWIu5AzAaK69DoK
         oc4eSbGPG0KP1owoN8HOjuZOPyjVCiB2s+D8+mg0JeNsFE2PhhtSMSKk63yS9l+0e+h7
         iPghHRhWzx89FisEcfk6HNdDySG0u6jxh9RnSlZVkO5DhRY0TwIBVxNhWrJeosE1ZLkg
         GLenNtoTD7EklmR2o8LlbW/wbHKF+WyR9UtSlbins/jDSs6LsD4c0hVIc+WYafil9PuQ
         Ufoe4zCaEOPr8KD9jZu0hxnjRm6daemKhNT/Sjzzp60qyqm2cjIfdmwShIdXm5sEv//e
         At6g==
X-Gm-Message-State: AOJu0YzesLzTuGMxeM7z1OxwLnddb/I7YvT2dOJook/BwyJ3qJ68B7mL
	JTgLQp7yO+Jhfrr6IUm2+VHg7AU6fEc66NcP3vq5hR/TnW2/qhHaZhDPv7HAbWDNsSatZEqoUXF
	ZojH+UyHYSU8jkyDGlvqlt8ihufMmVA==
X-Google-Smtp-Source: AGHT+IFLOYsmp+ygeUVnwBhC4HfjyXuiPG6VYjlQhLE4kaf6pVCC3pWume2GW9eE3AQICUNvTLTClEAXHWuTXqBP3y0=
X-Received: by 2002:a50:9f69:0:b0:578:614d:e0a2 with SMTP id
 4fb4d7f45d1cf-578614dfa74mr970858a12.25.1716568928378; Fri, 24 May 2024
 09:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <20240515132543.851987-1-christian.couder@gmail.com> <20240515132543.851987-4-christian.couder@gmail.com>
 <xmqqv83fvw7p.fsf@gitster.g>
In-Reply-To: <xmqqv83fvw7p.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 May 2024 18:41:56 +0200
Message-ID: <CAP8UFD1JZ7eJzrTk1YPrfy1XLAnnLvukABOJE69-JbqVWtL1AQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] upload-pack: allow configuring a missing-action
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 7:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > From: Christian Couder <chriscool@tuxfamily.org>
> >
> > In case some objects are missing from a server, it might still be
> > useful to be able to fetch or clone from it if the client already has
> > the missing objects or can get them in some way.
>
> Be more assertive.  We do not want to add a new feature randomly
> only because it _might_ be useful to somebody in a strange and
> narrow use case that _might_ exist.

Ok, I have changed "it might still be useful" to "it is sometimes
useful" in the v3 I just sent.

> > For example, in case both the server and the client are using a
> > separate promisor remote that contain some objects, it can be better
> > if the server doesn't try to send such objects back to the client, but
> > instead let the client get those objects separately from the promisor
> > remote. (The client needs to have the separate promisor remote
> > configured, for that to work.)
>
> Is it "it can be better", or is it "it is always better"?  Pick an
> example that you can say the latter to make your example more
> convincing.
>
> Repository S borrows from its "promisor" X, and repository C which
> initially cloned from S borrows from its "promisor" S.  Even if C
> wants an object in order to fill in the gap in its object graph, S
> may not have it (and S itself may have no need for that object), and
> in such a case, bypassing S and let C go directly to X would make
> sense.

Ok, I use your example above in v3.

> I am puzzled by this new option.
>
> It feels utterly irresponsible to give an option to set up a server
> that essentially declares: I'll serve objects you ask me as best
> efforts basis, the pack stream I'll give you may not have all
> objects you asked for and missing some objects, and when I do so, I
> am not telling you which objects I omitted.

I don't think it's irresponsible. The client anyways checks that it
got something usable in the same way as it does when it performs a
partial fetch or clone. The fetch or clone fails if that's not the
case. For example if the checkout part of a clone needs some objects
but cannot get them, the whole clone fails.

> How do you ensure that a response with an incomplete pack data would
> not corrupt the repository when the sending side configures
> upload-pack with this option?  How does the receiving end know which
> objects it needs to ask from elsewhere?

Git already has support for multiple promisor remotes. When a repo is
configured with 2 promisor remotes, let's call them A and B, then A
cannot guarantee that B has all the objects that are missing in A. And
it's the same for B, it cannot guarantee A has all the objects missing
in B. Also when fetching or cloning from A for example, then no list
of missing objects is transfered.

> Or is the data integrity of the receiving repository is the
> responsibility of the receiving user that talks with such a server?

Yes, it's the same as when a repo is configured with multiple promisor remo=
tes.

When using bundle-uri, it's also the responsibility of the receiving
user to check that the bundle it gets from a separate endpoint is
correct.

Also when only large blobs are on remotes except for the main remote,
then, after cloning or fetching from the main remote, the client knows
the hashes of the objects it should get from the other remotes. So
there is still data integrity.

> If that is the case, I am not sure if I want to touch such a feature
> even with 10ft pole.

To give you some context, at GitLab we have a very large part of the
disk space on our servers taken by large blobs which often don't
compress well (see
https://gitlab.com/gitlab-org/gitaly/-/issues/5699#note_1794464340).
It makes a lot of sense for us at GitLab to try to move those large
blobs to some cheaper separate storage.

With repack --filter=3D... we can put large blobs on a separate path,
but it has some drawbacks:
  - they are still part of a packfile, which means that storing and
accessing the objects is expensive in terms of CPU and memory (large
binary files are often already compressed and might not delta well
with other objects),
  - mounting object storage on a machine might not be easy or might
not perform as well as using an object storage API.

So using a separate remote along with a remote helper for large blobs
makes sense. And when a client is cloning, it makes sense for a
regular Git server, to let the client fetch the large blobs directly
from a remote that has them.

> Is there anything the sender can do but does not do to help the
> receiver locate where to fetch these missing objects to fill the
> "unfilled promises"?
>
> For example, the sending side _could_ say that "Sorry, I do not have
> all objects that you asked me to---but you could try these other
> repositories".

In the cover letter of this v2 and the v3, I suggested the following:

---
For example in case of a client
cloning, something like the following is currently needed:

  GIT_NO_LAZY_FETCH=3D0 git clone
      -c remote.my_promisor.promisor=3Dtrue \
      -c remote.my_promisor.fetch=3D"+refs/heads/*:refs/remotes/my_promisor=
/*" \
      -c remote.my_promisor.url=3D<MY_PROMISOR_URL> \
      --filter=3D"blob:limit=3D5k" server

But it would be nice if there was a capability for the client to say
that it would like the server to give it information about the
promisor that it could use, so that the user doesn't have to pass all
the "remote.my_promisor.XXX" config options on the command like. (It
would then be a bit similar to the bundle-uri feature where all the
bundle related information comes from the server.)
---

So yes we are thinking about adding such a way to "help the receiver
locate where to fetch these missing objects" soon. We needed to start
somewhere and we decided to start with this series, because this patch
series is quite small and let us already experiment with offloading
blobs to object storage (see
https://gitlab.com/gitlab-org/gitaly/-/issues/5987).

Also the client will anyway very likely store the information about
where it can get the missing objects as a promisor remote
configuration in its config. So after the clone, the resulting repo
will very likely be very similar as what it would be with the clone
command above.
