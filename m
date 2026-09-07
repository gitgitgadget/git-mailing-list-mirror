Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B6477299
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799015; cv=pass; b=j82bUbxzm3m6qcS6pr1iJYwY85DI1iXm7+6/JcukceZUofNO8gD7S2HLswlBgp9ZGcwauUvdEjam7D14LF/EM9TEQRESQGRQVDFcmB6jAm1Bk5DVYomXH7rgn50McC6eovDo0lEE6tQXWJVNrD+323lj4ztfdMdhoALP0Ugl30s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799015; c=relaxed/simple;
	bh=V/n2wS2VHQqwYia1PLaCHHbZ/XlcmQfkaJGOGYIg0CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2IRR4SQT+s9fJkxs4ZfMz9NYdP85+3u0Ur7LteihRX4PxDlN4yaxXab+3xjTeNE+344nqAnc+SvC49n7tmX3s9E2MsbY7zS3mBH6IG3ZpACz1WV0JMnEnUId+Vl6p+UMwt8OPlY0lMmXcl5G6Tubc+hu4ljd6Qj3f4yNYCPg4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=qgKMENrl; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="qgKMENrl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86162c086f8so39940627b3.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 09:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788799013; cv=none;
        d=google.com; s=arc-20260327;
        b=h6jWEIfjNmqd1czdrJdHaObEGb+iTN9H6XGVZBIjskpHsA8RQRL+YoasqownGDq8yQ
         QLblWHSchWIXTvhkAoByzZZdVK3CG2BiKzUhI1fhCrsav/dNX2iPHJG9vsLWPH1Kbt28
         Vrb0bZtu/HVxwlgnAmHW1DJuGQA1TzXSJJ388ss5+7jVPl5dD6t9FMKOHCjDq/etpUFy
         8iPB1V46ZJvYtWYopq/m+hGhw3ipjqcv9zkBCuWyETplfoptIfpB/HGYQANdQKOJA8Ey
         6AkGkztbN90If1W+WdLEoUouUd6tJ4EHpnXmPinWVhgAY8yxuwv5igFJ8OGcqjhFyPTr
         592g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ws10Y9J22JYNvdpCiv+DWl+VhkaVgQ5FV92BukoIKD4=;
        fh=iLJxgP8DAFLrDQjsB0Cddp9OF9hbFU6T6ON0ac1dnV4=;
        b=h5ddGttUJsQPzKoQPTsq0DHd1E7Ha0rpJFmWgtAInfjJee0fzSpcyIlNSHb7xev2n3
         LlcRDEIr31PX7R0SloYlAMJTvNM/nDiZYyc4QIGGXdZ+Txp3vkuEdf+rN/s2iKjVeWms
         TKpxtdvs3NNHkEO8xq1rGdNxZtX4yMNJyBnqZIjrui9Nez2AFtprPi52qcYNfqtzwC7B
         LzCBizlCJeGBV3v3Fpi9awa5TSP2/YAzryv7zy0r9EnBPVL/2VDNDE5qNc3OwccQ7siJ
         QBa0o0xKeH3qCAq7tll4xyj38yGCJSxLjWkROdD2XOViNbXLJHZOjWp57kGi9J+VxiNf
         9QIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788799013; x=1789403813; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ws10Y9J22JYNvdpCiv+DWl+VhkaVgQ5FV92BukoIKD4=;
        b=qgKMENrlRO3ioY2KKLX2g9nzfJeFXgFd8gi9gZpLXuV29EpmIfsKcVPt5pT6BuFOzR
         MTQ5VBZTgTIeHmZCsiyBg5H4j41wWTvYOwvmrpceLqmScP21BsC7tAfOUQEFPPBYyEjy
         fmIV2ILCKbgoM8Y1pg1+NmZm+cb/T6lO5vmzy4d0qJu7sVZFZ+R/jNFrfpbqkFEuQ8jy
         z47g2nErepkT1IgQHgCUqObjj0ETmA8EqcU+roLBB4Zj77rK0EyYAak9xRyvc/ujEyyV
         f5hV/ex1N4hvPYUUuS1xXy8HiWijwroRWcs9NWqxJt9auW/2JLV6C06RIOn1Q98Xi5Cy
         b4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799013; x=1789403813;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ws10Y9J22JYNvdpCiv+DWl+VhkaVgQ5FV92BukoIKD4=;
        b=jRigK/yyRFSSVlJ2nJygLZ6DvLiX9BncLidNQWJe3Ho+EJPBKNJpEEVM+fD8ONcQDO
         v0FlKdTuToypbfHXZ++8c3yXvyLXQqBfq4V6wXve/j9Dm+812HX5eaEFilzmBBg7CJR+
         7+rfZxpMHzGxoYOFKOZwximig5+GWq0ADNqd7HZKCHLzY+h9Sj/2q6INAjQX2qgWW/JJ
         xdFc+4tAuffJ/lBuwc5ceKcw9ORlEhyuHXi8/ydQPew+BpgtY0/vcjSWYtBgy4pg/qT8
         VnzcfmLlQSDdMvJZEDYnsataG0XwjmGAVkQXsH4a0uh+HJc9zNfSf6GBILC3l5bHecxc
         zUOg==
X-Gm-Message-State: AFuF++m2El4Ch3qIx5B4BRmdmVW638gXdX2cr0Fl8BxEbyFnas8EoZa0
	hwNat1/WYw+g2z0tlj63n2xDOHvGvKqV09lHChPLduSK5iEJILfTG5WnTLclPOqiUkYNZQXgc2d
	PLjbZA8kJ4BCoXFb+gCoo86AF9YGhJ98HlqBz1zrQ/Hhfv61/YVGKHWgNFoWk+6c=
X-Gm-Gg: AYBFou0Qcd88b3+gk5RdpTmpQjWT4LjacJJyXhL9cCw4upyzI5Lc2eSGhB+asDxpxqf
	BWyT3fMoZXU87ppBHGXYhfNrmeUmB1HNWVbgzHTKq66Z5REF3HWfXaljCo8+VEoWBF7LodLNkC2
	ISzQkSRL343CBuQ+NFGArt77Cy2yQkwDTvCrUmwPvY4z4HM08MpKu7oP9C4z7MsdSPkdDaN8uTp
	9hlylj2hISgIpsZkQj/hgbUulHPhpDtOl6t9oB/GxvPZiow1uARQDuZBsoWviniTewbbKW37K1Y
	kkudIbd5BJl6YpodxeFrG+iFwiw6EyL9xlD54qxtbLztg6knXCFOiAJJsx5EOql2uwXM+CDhb15
	7kNk=
X-Received: by 2002:a05:690c:e3c3:b0:862:5a77:285d with SMTP id
 00721157ae682-86e66c799b2mr103198837b3.0.1788799012680; Mon, 07 Sep 2026
 09:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
 <d09ef622-1398-4e38-8a04-8542e7347a98@gmail.com>
In-Reply-To: <d09ef622-1398-4e38-8a04-8542e7347a98@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Mon, 7 Sep 2026 18:36:40 +0200
X-Gm-Features: AcwNN1XYX68zEnzUICbM1H755uEy5nldzhjFW4a9T9yf5K-OgzgaBYVWWvdCa1E
Message-ID: <CAA0xjto++XQ6SZVfr5hWq2+CzeBsqSmTOLq_5UvL5s-0HDzaxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is done
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 07/09/2026 15:25, Phillip Wood wrote:
>      The merge backend which is also used by "git cherry-pick" and "git
>      revert" does not run it when it finishes.
>
> would be clearer to me

Yes, I'll use that.

> Like Patrick I cannot understand what this is saying, let alone whether
> it is saying anything useful.

I've spelled it out in my reply to Patrick and will rewrite the
message that way.

>      Run "git maintenace --auto" at the end of all sequencer operations,
>      ...
>
> would be clearer to me

That too.

> Anyway this change is at the end of pick_commits(), just before we
> finish so looks like the right place to call run_auto_maintenance()

Patrick would rather have one exit shared by both rebase backends. In
my reply to him I've proposed moving the call out of the sequencer
into builtin/rebase.c and builtin/revert.c, the way am.c leaves it to
rebase.c today. Say if you'd rather keep it here.

> It is a shame the single pick variants of "git cherry-pick" and "git
> revert" do not share the same code path as the multiple pick variants.
> continue_single_pick() runs "git commit" without calling
> run_git_commit() which is also unfortunate, but means that we could just
> rely and "git commit" to call run_auto_maintenance() for us.

That works until the next patch, which turns auto maintenance off in
every command the sequencer spawns, this "git commit" included. So
somebody has to run it afterwards. With the call in builtin/revert.c,
cherry-pick does that itself once the continue returns.

> Do we want to assert that we don't run auto maintenance up to this point?

Yes, I'll add that, and the next patch will extend this test instead
of adding its own.

> Using test_grep here would mean we get some useful test output if there
> are not matches in the file. Without that test_line_count just says the
> line count didn't match and prints an empty file.

Will do.

Thanks,
Thomas
