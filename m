Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474A12C544
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431466; cv=none; b=tOE+xcrccYIsgpFZM9VCcMueSm/mNJJ6HwHZ++qi6H7kOafj3T1hq+w+zpxp19jOaievIpBz/bHQPFp2j4Mco3o0QF2D1HZNjDPfnbKxOmsTG6Z3YlyAmrPf9oXFBGciyyMWlb+932dNRm0L+5EpYXNl7T9BwGZzoH05V8580Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431466; c=relaxed/simple;
	bh=gCxT8IZ3aOxU4HK1SVkfyWRjYwsCanixaIOOqpmaLPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I49kIcYAjzjmK5+rGYA3inPo4j7hvXGWo8QRj/8fgfk8VY6NNj31o6fKxf2J5aKEcpHURcWQW7MjJhEGZOU7efN5dzkGW2kMQ3v/pKd8AbNjgevdH3G9Rc8XoxFlTEYQ9s74h7i49IQ0Q8OOTvg5/1UZDPlYJRw5JQVOWk+xpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzahjepS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzahjepS"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-361d175c97fso12511751fa.3
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431462; x=1760036262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCxT8IZ3aOxU4HK1SVkfyWRjYwsCanixaIOOqpmaLPA=;
        b=RzahjepSTAq4Ue3sLtAdRHS9yeuEYZesBRDwkun0ieVaJAjGDEZsG8lN8vKXEebmkf
         oZMYhkq/9emOKcxc7cehScLLj2RMvA1eqFBNM6DBFk0zaLO9i1otCRK2lmEOHG2mf2s8
         tGzRFvxtM0FA+zH4RPq9gWR8g4G1OPt+behmjpSnou7CrVfJ9SGsTR5fg9oSMJ9U3W1t
         E1ojnv6YpEh7T91ArJWCncC/A/e3Zzto5KyqpZqCPqO6IX/5fY/MTT3cdZNJoKC6zthX
         Js9MMoFbPpbFwmLrDZCg56hhCEnLBQEk5/XZrkIJdazZE16ah/uDkHL4jfSc1Nv1CJel
         /tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431462; x=1760036262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCxT8IZ3aOxU4HK1SVkfyWRjYwsCanixaIOOqpmaLPA=;
        b=EWg1AhANyl/CHP1mIz3UFxMZUBzum5jd9HLw2q7N2+Z8OkfXwy5bu5CtFRhf/X6ddE
         2It3uID6QemkTA7sgDJqpqqCF9524Qw179KbNVN6I1nCWeKGFDmpoLCxrHqjaY4tt9X9
         0GFHQkq5vx/8j/GDOiBL0SOGL9vrjpRlMZjRIMeJPkfWYW/qxhYsG3yQIME8ReK+tQ1Z
         MTAiYogZd8Qs0M6DGGHgmEFTW+RFNU4Efe9fbDufJSGFf/bAP1XJN7Fwy/qtS149JyJu
         QoukNOU8dio9DeCVjM8y3fcLjx88gAXT3pwD1adY1Em6urwqQSAfrOQ8ripjyAJoVSEQ
         mB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPQ5BQbu5J0hNovGoxmmTlPoxhCmw/DdPc2GmLJZGgql7R/HAgP40r9imlaWoIX2QKdRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkOvwl7h5zXpyPduDzaUZQNzxxVQVmIUgfAVXk++TVe/RDdJt
	F4ZsxVfTxDU9tdL8mROAWfvBuw4GfYZ1WA4wm7Ixaq9+5GpQFrSQM7q2ImW0F9OXNMuAhulviUh
	4outMffQkvnMgxu1vx5iolWcULQVr8KlgHmLKKDA=
X-Gm-Gg: ASbGncsQiZl2Oz2D5aDoNOiHlIwj/w6qFbtXHc+7qNxJc+gtmQtySJkmrOwgoX3aUkk
	TYdra20BgFu7qfShktbbu2StXpyjznX3M7NW+TrRbk0lKB5l1ybojImYjr+H/6I+D2mmOi05Tyy
	yiihCedv10PxQ3E5rCquHqA+2K0WyTeL9xNCIsbzoWtRqsYJo3x0TrqygGnTjcn0qWEsUe5HG0I
	NH52yHjAmHLF4DRqHAimlYLMeQlvKNl
X-Google-Smtp-Source: AGHT+IHBMmWwoAcGKEqe+TirpZCg2CfhsyY8ySxp1PDGrXEm4k5UBV11rb+d+Nmww7cpzAAjsDMDO5IOVtmTEBGiwqQ=
X-Received: by 2002:a2e:bc8e:0:b0:372:8ca0:15af with SMTP id
 38308e7fff4ca-374c3827b10mr730671fa.35.1759431462244; Thu, 02 Oct 2025
 11:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <8549f634153b1ab394a2e6630d8cc1209261a31a.1759341748.git.gitgitgadget@gmail.com>
 <aN4SU3lLFi2EROsF@pks.im>
In-Reply-To: <aN4SU3lLFi2EROsF@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 12:57:31 -0600
X-Gm-Features: AS18NWApyjQMc0XO6Rie3MWlRBZWwgsVeKRJ1ybbOQpOGnkljvH8Pj-UnNVlq60
Message-ID: <CAH=ZcbBDawtnC0GB46uh+00BbsZE3ibn-hXJq7CU26ScJ8A-1w@mail.gmail.com>
Subject: Re: [PATCH 3/3] make: delete REFTABLE_LIB, add reftable to LIB_OBJS
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:49=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Other than that these patches look sensible to me, thanks. Even without
> Rust they simplify our build infra a bit, so I think that landing them
> independently of Rust is a good thing.

I agree. I've been trying to find and fix things that don't depend on
Rust, but will need to be changed to make the adoption of Rust
smoother.

Thanks for your feedback.
