Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3157FBF6
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812571; cv=none; b=tulAhazhhiAeDo2XR3G6VgwXsFjTauFm72UUSir+LfQp+zk4synXoTte8OMkje2YGXcrNKUuhDMRYcOSNPGGxttr1jOOr0usk62X7KJyC2b6GFkSQk1ux9K8ZoSpxlGwT1o9UzqkKw97a1UausY4zmHq1ayeHMPZ/FilL9o8GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812571; c=relaxed/simple;
	bh=0P5WAA+fKWMVxJo7D8cwDhTRT8ZbbYEjaReIrCBtUbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO7dtCbE56t9qskOwY9+dmpMD4NqSZOHnhudFTSgBu6U9IcXAHz9lRB9szrBjWt38mg9/xnZogfRVBUqcsigiRQIbE9O5GLv/mxbZnzXVewovldDf4BdhJmjx96o6N9eDHN0YmrUkJTpwU1tOAAAp8Z1xJVqC9jKo8BUo6kJycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz9XLDZB; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz9XLDZB"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so1693795ab.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741812569; x=1742417369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMg1zJLmxNYe4iLuDaRfElPKVyfCFtVD6FDhYQk1JbI=;
        b=Oz9XLDZB7FZNolN1L69HDGixR8zJj5DeKzBXWLmLY31Cgju9bJp80PzqhVBf5pRdXN
         EdhoWUrcvn6G8FYnGUBzfOEViiCCdSkyltsDgvdTMl57Or5BksUIUKIx97hNfbUR9Deq
         bURS5u6UnC5MfA9rYYNauZYda00wSnfXF9JSSkafO2t4RpKZBHG4WqxxSB2IZf1QSGZj
         eVivFeI4nA3xMGLvZ9zuMAwvAuzANTd86OtDSa7rubsRcKO1TEz6upbiCzDnhkxlgEh4
         iPlegwsWDieGFYZqGm1EaFwNRv/uGhFp2GtHmHX0Cm791MiqcTsh3iBQSAYa4irFieoW
         Oi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812569; x=1742417369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMg1zJLmxNYe4iLuDaRfElPKVyfCFtVD6FDhYQk1JbI=;
        b=jpc0A8U5G8TcgWXvtxV5zjBmXlu145uHKsSRFi/Vqk6jYdJnBbxUUYDWcDj83FL9Ng
         MGFdmeT/uFNp6HUcV5W80/1Q8c3jSmKXvhGJIuniJF4br9iQxs4gJwyJJo03O25dcPtu
         pmyYB3gwm+NwA7YT/sR4oHhhO9ECVTHAviRuDMcGJ9GrbMchyA+MnEgMNWMQ3HtPMXaW
         Ml7Xmdk8lJtXavCfxnJKmeoLbdI38MSRTBnPmkeu3k85x5gxNgLaiHogb7hlqbRqD4OJ
         3gtk12jAMLZEWHfqggbGNMKL2tq8baSFPz8u2fFxh4Yf6/NGwnywBKtAi88cSIJCL9L9
         Tvjw==
X-Forwarded-Encrypted: i=1; AJvYcCV+9DQllzTocyPApb934WNGCKpB3VhwhqygmW0yWCtl2Z/NiuRuvgLJr3jCtvs54Tez7Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywqMrp9Y44TedI5JG/r+Nv4LqADJX47Vy/alQD4AcNXhR+6huo
	1tuOEZQO0GoprTxVQ/k25uahqYxUShlQesjcyuR+NvBqPp9aAAS3/XTah3UIdVqoFIM/fA4drtI
	SjHL7qNh/gGS7H/jNsCSTQ4Coxxw=
X-Gm-Gg: ASbGncsFJzgjaUi1Pho3AEVElPvfANb3pUev/4InXFCMs4mxsVfXxkfVy+gzC9f+zZm
	hcicC0hfUqw+ydyEMsDbo0WLUE7t9bIfJMbX+EhWbPXyVLkNo4YXqrhbiS3dOP/FYFHZa5jL7yF
	QHNvJcAO4S3T5VPFWyVnDSceuDLusD9PugtZYcsQU4b9i6Ciu0eEy+EAhVZgE=
X-Google-Smtp-Source: AGHT+IG89ltk/T54NyGGasrIBaawEDPirpg/cEHyv/C2YG3cjArnGfqsR7iD/ngI5z8r0caZjxMj3Ncx1/cLPadye+E=
X-Received: by 2002:a05:6e02:174a:b0:3d3:e296:1c1c with SMTP id
 e9e14a558f8ab-3d468921f95mr95151785ab.9.1741812568905; Wed, 12 Mar 2025
 13:49:28 -0700 (PDT)
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
 <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com> <xmqq5xkex9md.fsf@gitster.g>
In-Reply-To: <xmqq5xkex9md.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Mar 2025 13:49:17 -0700
X-Gm-Features: AQ5f1JpRRr7tqmZI2neftq1ojESkfaRDWBeG2lZq8p60KPa_7BmPoi_WfFXJOUg
Message-ID: <CABPp-BH35cn1nXSaF=U=dbSKUxTFL5uP+yUvhbXMi66tJMuhLQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 1:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Would it make sense to break the assumption that --max-cruft-size =3D=
=3D
> > --max-pack-size and perhaps rename the former?  I think the problem is
> > that the two imply different things (one is a minimum, the other a
> > maximum), and thus really should be different values.  E.g.
> > --combine-cruft-below-size that is set to e.g. half of
> > --max-pack-size, and then you can continue combining cruft packs
> > together until they do go above the cruft threshold, while avoiding
> > actually exceeding the pack size threshold?
>
> With below-size and max-size set to say 180 and 200 respectively, an
> attempt to combine the crufts may end up filling a cruft pack to 170
> but the smallest of the remaining cruft may weigh 40, which means
> including it would cause the max-size to be exceeded.  In such a
> scenario, there may not be a solution to satisfy given constraints,
> i.e. go above the below-size without stay below the max-size.
>
> So I am not sure if the approach would really solve much.
>
> Other than that a separate names, especially losing "max" from the
> threshold that really does not mean "max", would solve the confusion
> that comes from naming, that is.

--max-pack-size is a constraint.  --combine-cruft-below-size is not.
Think particularly of the case where the user doesn't even have any
cruft packs yet and has only accumulated a little bit of cruft.  That
option is merely a guide post to say that if it's smaller than that
size, then feel free to keep trying to add to it (so long as it
doesn't violate constraints such as --max-pack-size).
