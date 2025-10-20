Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635442E0408
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992223; cv=none; b=kGF/r8hU4KYLyu9bEOEhRDZ9ZOKZ+VWdLnaQ7+QQ3NZjEBpIBYlqVctvUTaBKrXv79CKZX/PayzF2GMmDmGXLGwiHzFglOcGcfExNjfpQM4Z5TIAEm9ttGVMl5q7PdLESR5SraVZEa2i/7D4ZfrmYs9eCMzi2N+sQE1fAkQTRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992223; c=relaxed/simple;
	bh=J0nLJ+i4wVLFuug47pZH/zamx/uTPqxOYqK6mBB5+mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlVTstsEzk/w7U2bMu5B0QWRCM+oLxOyIkCBNXrUxkHDGArH87CjQYpYxvBhXlcdDRzKZzxjS1Z0aKIpXgENVuLIibNFsknRXD4nBPsrSBBLn3AEEP3AdX7kH5v73OazF9BNh6XfkWuASeClyA/JeXHbUJKhjNSqIvQesjFYdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsUSpsPj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsUSpsPj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso601076a12.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760992219; x=1761597019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DGk6WTfEPvKaohJC3yP1AbuyozS1/dXxkwqXtpTjTg=;
        b=ZsUSpsPjOR87mrN4OGCKIRYG4OTWXYwj9fag+OZm0CXUPW+SDdglfzKAe4K55eHoOH
         PlJeYJQWY34qQ413AuZePjojyn3hEL2ANybNtF3AdFMKGc0tX+6Xk5z3gExAzQlf2s+g
         Z24GNkpDoHL4PsDQplMrQQNtr2flWoj8TEEwz8vkCOXrJNrGxkKHR8RRnrz5yq41oiON
         LTRS+o+/ebIK2ZaLRC/Jx+UOa1UQZKpkr/moJJSRH6Yl1AcdZ2zClmZvgXwV2rCwxCXf
         EuAUHufwCdJiKIqqEqOt0ytrCR3ZhK+7We/as2/AQjZd7tljTo38MJ4KJjfJX3QHJoP2
         QSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760992219; x=1761597019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DGk6WTfEPvKaohJC3yP1AbuyozS1/dXxkwqXtpTjTg=;
        b=YZDPrBAClc5Tq5NWzCNRXYllkSB8plfHa7DrplGXwiFXAcOmg394eGJIF/uZrGPf1p
         XLOKOp1DjIopFP/aL8sURkwyLsk5dpS5+YH9w1cOukkpWItURTQ//NZ6ekG76bB7tcBW
         RnhomMuHio+exRf7lvxXL8FwOPLXY1M/wEC20Nw7e86hZ++WH5rtf9L5EK8aSgZcQpjp
         C200XnEHB57qjm40MIWfmzyEw6WdreLuR8WfxpXd/e6dV4hGz1t0h4UzITl4gnHtI+Of
         ACCR/qQsRXTQhavwZ6OOjhWKW7ySjU+OE07Tzmk3dkgJEa78apndBhDlz77FZrS1A5nE
         O7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDlxseb9F8E0p79GmxJaE47MODmxOcIRf4AlXYfbjrg5zXWhcIWVoeY9NkC+WcYZ/XvvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/zPoV/YgYIBXe6LT2DydhUeDw2oH7pOoM+w2djBOv8c17osc
	BemlIkOCWnG2j6vY6kMjG2UbYUsqUS4/ghjqk0oxr+CAJSzFZwda5iDvdJfNIdV57/T4AxgMNez
	moab/1xpdl7EO3Peq8dq9owBMBKjCk1Koh53w
X-Gm-Gg: ASbGncs2WqUYrO2+MjYi297Zo0hEeokggAQSbYItHMp808OBtx8yUvdeTZbXz9u1jyR
	C3xuK0O+up4atGkW1R0wmNZXCudl/Z677hX+7MRyxfdDbZHRwN7FGF+TuXuIi7VUyATbQZJUXSr
	ZZNvGAX5YWL85EIj7P6HQRGDE18pTOEGTVVhK0bB+fR6WOy2Pe7G+FdAC2xplp6wdfIBVCd2gWn
	+3S04j8PVG6F0wCZ4sV+HQ/ZcqLj2FaZYyZtM7iZksrDfgMsVlzoAFgioxGycAedboAePaPnj2v
	9kLDi7GVdkHcbBibE7uCIq1cuo2I0w==
X-Google-Smtp-Source: AGHT+IFT5UeC1OEnCqeQFLMD8oXqOXklffgwkFP7v2hLFAgvubDsdFEk1TGKkCVbHqfrvrxVwSH5ilJ8udmzi2EmUvE=
X-Received: by 2002:a05:6402:2113:b0:63b:f91e:60a2 with SMTP id
 4fb4d7f45d1cf-63c1f6c1fc8mr13743522a12.25.1760992218653; Mon, 20 Oct 2025
 13:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
 <xmqqecr1xiqc.fsf@gitster.g> <4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com>
 <xmqqjz0pz6l4.fsf@gitster.g>
In-Reply-To: <xmqqjz0pz6l4.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 20 Oct 2025 16:30:07 -0400
X-Gm-Features: AS18NWB_2niIbTPC8wKTh_2wv4_FaEg3_on8t9D8xeu3rKWf0rpx_6WVvbyT5LY
Message-ID: <CALnO6CDyCvSSRBTAzS354M5QKhqcOHOHokT1KwEqY7+58A-yfQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: git-reset: clarify intro
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 4:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Julia Evans" <julia@jvns.ca> writes:
> > I agree that "git reset has two very distinct modes' is important.
> > Here's an idea for how to communicate that.
> > It doesn't fully capture all of the nuances of `git reset`'s command
> > line syntax, but maybe that's not the job of the intro sentence anyway.
> >
> > I don't love the use of "things" in "two things" but it would be weird =
to
> > say "modes" because we already use "mode" to mean something else,
> > and I haven't thought of something better yet.
> >
> > `git reset` does two things:
>
> I do not mind "things", as long as it is not mislead readers into
> thinking that it may do two things at the same time.  "modes" avoids
> that problem, as "you use it one way, and it does one thing, and you
> use it another way, and it does a very different thing" is the
> natural implication of that word.
>
> "The command can be used in two ways"?  "can be used for two
> different purposes?"  I dunno.

Some options:

    `git reset` does one of two different things

    `git reset` can be used to accomplish either of the following:

--=20
D. Ben Knoble
