Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FE2F6925
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284030; cv=none; b=A1e/D/GO4DHAeQDn3FZpdrn0+qRqxuTqJuSoysQCF+NZxd8c2nHKh+07llzUTxnQW+Jwpt0lWNKMaCIFcrhRK56g8imk6yAuoleCSotlOY2X1lwBfN32a4/lN4jDMXZtvc33mn6AR95ZLQeMuJwMLjRz+0eTeWhvgHq+uB5DIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284030; c=relaxed/simple;
	bh=CqOcBzu06rcvC7PsTvImC+ld1+CI5fWMh7INDMCflbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqcKIgchesRJROdb4719rXQxUYKGy7WpPkYQE4QhTIcaJBa6kkiElZqG1oMbzEd5uHqpQaZ4A5TPUGqq9S+hHoe7GRHFlvxIwFIUDu3FuETC+39cGWTRlNoaTlv8rGfR50jej7yQjtnsZFCRq6fgTqob+8ciQAeubrI8VK/960M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnEp0FBT; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnEp0FBT"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-659848c994bso3819966eaf.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768284028; x=1768888828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCd1KwCzNaGmZG9bR48fmQTx0G02IAsMVx+4ljMGh7U=;
        b=mnEp0FBTsn75qSc1CE4/NVs+RozmUB9UJAp84YfaO0vdNk7f0mQI6Z7p0bXg0MNXsi
         Jf+3CIFP3gXPEhKbQqaH4qkTTupoYT+V5GP34r61QS8ph0hKmjkAP3KuJiPbyV892GIi
         34G9dysL4SDaTuGqLqYwBmJ9uS6arF+jtYBatQu50xqSbDZ2ZAyz0/LBCIu7MPGMndki
         MV7iqvXnkRzJ2xrTJjxPRw4YSsK3CzSNxv6bwefo48LuOxnJd4tkdtZbCbNHgehIcMSm
         d4GdUGZrmlQ99c2YzRJ1HzfftxSQU1nVV+d3JshoL0OitdxP7WQ1EVBGfO+nbqpkWdFO
         EHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768284028; x=1768888828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCd1KwCzNaGmZG9bR48fmQTx0G02IAsMVx+4ljMGh7U=;
        b=p8hQOGGiWYExDhF24VFi4/ozN5Tgi+/86i+C5mk6Z7QE7/j9Trf6ke0dE7LcUZL1Ya
         qz16kAbdYU+SvJ6xVZT39fTvkund2tfmfaUMH/vemSqa4v/hIxKrR7yaRozh/qWGQ3PM
         p5kj0kfyZ5IiabCkU/RUSf6DxNV5rOUXchQcGpPt8sOwKOTun/DmYh3rLQDZ1Ka5RzW0
         CjJb5epz+HsHN3pLd9UOmrEm/94NGyXezTqUve+LigiZejl4h1zY1wg+KIQHsUAFzIkU
         /ZhtO3ajpp7S7wBIBIUEOCit8dPbzec2HWiqCBf8onJ/YDZCT2AmIE5WXSOMqjxEaCqI
         JcjQ==
X-Gm-Message-State: AOJu0YxdYOUComgLjFj/avubBTuKXRXy0VvY5DVKHxfZSy4Avq/b8Sg1
	InW/MrYaQcWSSjNHKSmGDN+jBgrgpqPEcBoer6v5FUA3O0Jimt28nOuVd0wW8AMbv3ANncQIG2o
	U9vN+sN16AJgFWX+5PMXZBRTbaYCd9q8=
X-Gm-Gg: AY/fxX6aKJ3k/8+24EjD8tTgXiFrhxw0W0wO8S2GPh+vjBsiAgL9RDcaUOUuX1Nmk2f
	rj9FdQLV316LUGK29GzCHl2j2cBhb9cv0PAE7wlH8W7yuc6RBk4VLF7eNkTv47zYizCqqd+YN6o
	gJp6boaUI2+PfnnMfvwSmDaGAlx20oKM0Jy5znRKW8QL4BEf6jPTSfrUhdVgACfDGC59DiAl5VM
	jcgWLWO/GLVelq5gbLEzH1YZKfK6tpG3aaRfKsw4v9DOMcgnYzbDmVLogxqM/JM2uL9zJuu8BF8
	e1o3kUJIt6nS4tVtKR868J3PqCOV
X-Google-Smtp-Source: AGHT+IHD0nupOAzNS+QUSOt99R/yELQum39JQti2XXlS8V6vArn1jnHajO1YjlKORpfkG0hGbGBgkfhHq/Z6zBuY8g8=
X-Received: by 2002:a4a:be9a:0:b0:65f:5869:f7e7 with SMTP id
 006d021491bc7-65f5869fddemr7209650eaf.63.1768284027945; Mon, 12 Jan 2026
 22:00:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
 <20260109-b4-pks-history-builtin-v9-2-8766101814c6@pks.im>
 <CABPp-BEo5jGBgJBkCdu_GHstsbEm4mCpKO3NWvNfcjDVC+SbLQ@mail.gmail.com> <aWTw4ezgeloLB0R2@pks.im>
In-Reply-To: <aWTw4ezgeloLB0R2@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 Jan 2026 22:00:16 -0800
X-Gm-Features: AZwV_QjjcWsSDiKP8JztT3jo2bUmeNhXmAWhZimSsR__pOa575gOND_G8D-iYeY
Message-ID: <CABPp-BGM4AxoedD3uUnS+12n5c0egd8pw-=cRsO64oDs+G9RkA@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] builtin/replay: move core logic into "libgit.a"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 5:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Jan 09, 2026 at 05:16:41PM -0800, Elijah Newren wrote:
[...]

> > > +int replay_revisions(struct repository *repo, struct rev_info *revs,
> > > +                    struct replay_revisions_options *opts,
> > > +                    struct replay_result *out);
> > > +
> >
> > stray extra line?
>
> We typically have an empty line between the last declaration and the
> `#endif` in our headers.

Yeah, I was just confused; sorry.

> > > +#endif
> >
> > It feels duplicative to have replay_result include a merge_conflict
> > field and to have replay_revisions() return an int which signifies
> > whether there's a conflict.  Can we remove one of the two?  (Perhaps
> > the merge_conflict field was only a workaround to the weird ret
> > setting from the previous patch?)
>
> The idea here is that we have a generic error code that tells the caller
> that _something_ happened, whereas `struct replay_result` gives the
> caller a bit more context around what exactly has happened. This allows
> callers to handle merge conflicts differently from any other error and
> makes the different failure modes a lot more explicit.
>
> Some context: at GitLab we actually have the use case to surface more
> information around what commits have conflicted, so there will be a

Interesting, but doesn't answering that question presume first-class
conflict handling?  How do you determine which commits conflict
without that?  Or, is the first commit we process that hits a conflict
sufficient information and you don't really need the commits that
conflict, just one of them?  Or, do you presume that all unprocessed
commits after the first one that conflicted would have also conflicted
(even if it touched files that are conflict-free so far, so that
commit would not have contributed to the conflicts)?  If this is done
without first-class conflict handling, there may also be an assumption
here about linear single-branch history, or else some kind of attempt
to continue processing whichever commits don't have an ancestor that
has conflicted, so that we can enumerate "commits [which] have
conflicted".

> follow-up patch series that extends `struct replay_result` to return
> more information about the actual conflict. I'm already planning ahead a
> bit in this patch series.

Wait, above you said you wanted to know the "commits [which] have
conflicted", here you seem to be suggesting you want to know about
"the actual conflict" which might mean you only care about the first
commit that conflicted but you want details about what conflicted
within it.  Or is it perhaps the set of files that would have had
conflicts across replaying the whole sequence of patches (in which
case a bunch of the previous questions are still valid)?
