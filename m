Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55393269CEC
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883028; cv=none; b=ItWae3qmO+WkxLGeyRES6b2rAArn/qRelydab+CAkReFOQVr/fIXWy5XtMHUER7JLrynLyha5Us2DkdcInplK5y6sEGR7fvDnrXQOp/WxTMar5Et7+WoUdOfcSkj1BViJ2Cb2onPPwytUDzns2EKvmy2li/E/UZDB4VknkoXjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883028; c=relaxed/simple;
	bh=Izd/9b6O7RHT9lmo8kwbavzC7N+zTOGwBJbON8qQz6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5a+fS1+0doneXoDSGVU6gq0ZmqqeBsNLqDFd1PIB/mPEHW/6PLH9oGKvqlwrY9mO20IL4U0WMVEruwo/feU2YrotiGNi3bN2dcgJlXebPTVCnnyeKjYSxCfHekMTou4Rlq5woXszSrvMSmwqq+h1aqtK2tYs89n3vptRDyS8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThO+Stsn; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThO+Stsn"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d46693a5e9so8918455ab.3
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741883026; x=1742487826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vn5RZ3Wld7a8ojP2eochv9qfP2WyKT6/KbL9qollrY=;
        b=ThO+StsnJYc0ItI1zuW9tA5rgkcFM52Pgb/iSnrmCLTfOL+YtrI60ImE4ZXoUJWUvS
         VIN2zG9bpUfMQcq5ON7OeTVlR5YR9j1NY7ExoPIXvBVWQuyB+kc4WeUa1qfC4iAt5ckn
         EVuSE6hIaA3UkUXt6/SA8cA/ScizaMqjjreL5UiqJMf3MQ23i3rj0kP+VOYnYDj4NtHL
         YDAhWaVP5uq4XDZoIK24AcH2nH5P4NKGJP0v3cAYaR8/4NqwPhO525v8ZakaoNZhGaIR
         VCJd8vIzyDt0Cmm49SEZ9Yl0LUiykSeYl6QqjqKYiMswBPr4s5KSS1VJl3yWI3m0kDzZ
         PXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883026; x=1742487826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vn5RZ3Wld7a8ojP2eochv9qfP2WyKT6/KbL9qollrY=;
        b=IBjrgCZOA7pAESqabhxZBcGnMgWhvjIKWLYlA/fl0bLrrV0WtdfAMFAjtC9xTVeqqY
         KzDCPCWl7CrwSpQW3j9k1W1v0WEohtV9G0RtSDguEUrsWjeTS90fDBp3fuzSpv7kRBDT
         +dziMZw30QBbWx+YUdG53YkuRE6CS79lBWOUOvcRjN/zLnFMiwXxgPm4pinIyWMgMq8Q
         zZMPonG3ldTBLZFdK9jzivgAjncpvKsbXSU+PRIV4zmfjH0hK+4kz66nLrzXNwOPao8z
         ajIMCmfFoR//hSm745+MqRzL+0OBttq6Ut+pvUVJloSbYKemQjSJjyCcmt3iA4rlZ8HI
         q6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVvJMW2jioDlJrGn9PdtkDd8h9qGuxWh5q1saQbRtBHqTaq2Xi7vu9rSVaVciOqlr1U0nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtmZ3GtJ8qs5WzD+/WvSgIDsUlq478ib/g9RTIR14TvNHPpEHR
	8tZEpCRel9LX9uq/bk4vmrGCcTnuNFmffJNHBIAIkBxzm20cINuOLy27s7PFHpw93RSSQ2t1FCh
	vdHQQ/Y9DsjcXafz6Pn6H7xPkl0RulQ==
X-Gm-Gg: ASbGnctd4DOi6DOwdQyG3p8otNzFy0n91yb/JP5Mqk/BH0rHvSQRRBkvAD4SE/RR+bR
	vfQxF6mFvexOtHGoBsIa1gp7JEj2kKJ4d1cDqNELU2MgUc8Vo8o/mg7zZqIlPxxx9UBLIL/iJ46
	YQmt+CBmOp4/8ZKJjbmporJn6Gz32+6RKhumR3msHwKreaGeZAEY3hn//6/Oc=
X-Google-Smtp-Source: AGHT+IF5TMX5JSeuNOOH3Gcc/l3s7RBOWwQa6LJ5FJuIMnw2+J6L1ai3NPXEOHu8UCb5xl2UJQ4s2WvM/Ican/D5Inw=
X-Received: by 2002:a05:6e02:3683:b0:3d2:b66b:94cd with SMTP id
 e9e14a558f8ab-3d46890bde3mr144088715ab.3.1741883026242; Thu, 13 Mar 2025
 09:23:46 -0700 (PDT)
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
 <CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
 <xmqq5xkex9md.fsf@gitster.g> <CABPp-BH35cn1nXSaF=U=dbSKUxTFL5uP+yUvhbXMi66tJMuhLQ@mail.gmail.com>
 <xmqqmsdpruqg.fsf@gitster.g>
In-Reply-To: <xmqqmsdpruqg.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Mar 2025 09:23:35 -0700
X-Gm-Features: AQ5f1JqnHZcMttQTWteigN8oYPLmG0AZoi8dGGAUfswHZuVkz4CcOVTadrKM9r0
Message-ID: <CABPp-BFSXVkZb76va0CO_w3G+MtNuvC3jv6-9vo-oR3LHW4YNQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:16=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> With below-size and max-size set to say 180 and 200 respectively, an
> >> attempt to combine the crufts may end up filling a cruft pack to 170
> >> but the smallest of the remaining cruft may weigh 40, which means
> >> including it would cause the max-size to be exceeded.  In such a
> >> scenario, there may not be a solution to satisfy given constraints,
> >> i.e. go above the below-size without stay below the max-size.
> >>
> >> So I am not sure if the approach would really solve much.
> >>
> >> Other than that a separate names, especially losing "max" from the
> >> threshold that really does not mean "max", would solve the confusion
> >> that comes from naming, that is.
> >
> > --max-pack-size is a constraint.  --combine-cruft-below-size is not.
> > Think particularly of the case where the user doesn't even have any
> > cruft packs yet and has only accumulated a little bit of cruft.  That
> > option is merely a guide post to say that if it's smaller than that
> > size, then feel free to keep trying to add to it (so long as it
> > doesn't violate constraints such as --max-pack-size).
>
> That is correct and it is why I said the suggestion solves the name
> confusion.  But think about the sample situation, before and after
> such a repack with two thresholds.  You had below- and max-size set
> to 180 and 200 respectively, and a cruft pack of size 170, and you
> failed to grow that cruft pack beyond 180 because the next available
> cruft weighed 40.  Then you'll repeat the exercise again, find 170
> that is smaller than the below- threshold, try to cram more and
> would fail.  Isn't that what Taylor's series wanted to prevent from
> happening, and isn't the two-threshod approach supposed to be a way
> to improve on it?

I don't think "always combine" is necessary for improvement.  Perhaps,
in your example, this round of repacking can't combine things.  But
the next time we want to repack cruft objects and there is anything
new that (individually or collectively) weighs between 10 and 30, we
can add it and get something over the lower threshold and then ignore
the resulting cruft pack it in the future.

In contrast, the single threshold either has to violate the maximum
constraint, or always reconsider everything.  The two threshold system
allows progress to be made (so long as it doesn't just look at the
first biggest object and fail every time), but particularly if you set
the thresholds too close to each other or you just have really large
cruft, then you _sometimes_ might not make progress.

Personally, I think I'd set the --combine-cruft-below-size to half of
--max-pack-size, because that guarantees that any two existing cruft
packs being considered for combining can be, and the resulting
combined cruft pack if big enough can then be ignored in the future.
In other words, this scheme would allow you to always make progress.

Am I missing something?
