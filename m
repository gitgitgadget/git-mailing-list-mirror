Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EB3A1C7
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321494; cv=none; b=lxS7wdb0Wzc3fVDqqRP/2yR9zQVY8hjA9pJ+CAosXPlai9MI4MSR214SgyCuJwGT9UFz3bA6aMulyhOISNiyR/b1afYmIsQZBrxdljRWl/oMpG5tof27PVpsnZkNgSIxxBk1tv32cD0X7aSfqOaQEQlTCsI7Gg0vgAIfuI8MpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321494; c=relaxed/simple;
	bh=pnZVVYOMSKFBgEf98yJWquF66l09qx4dUZ6jLDRx00I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YYcAQzvDNmx+koXkMP264dqiVngMV+xqJLO9+K9+ntTe0st8gDOpUZuKN756VflzrI9CEQPeCsvzNqJJBiOnRZJE4zo4k7vnZNNaDQsVT+xwxFfWFzPtUlqodq9SHYzoDDGvKKLFbkuDhR1o7OrKwcobAIX7nsCZ3jb0zl1s890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOVVJPQg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOVVJPQg"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d24a727f78so28389021fa.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 11:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709321491; x=1709926291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmacGR1TnQw3/1+YUX7IYVUqRqf3TKN2N2LZ4g/zn7E=;
        b=mOVVJPQgR/kVgUSHbvEjgHT1MeXecA/9MGas4jfJjxW6IeSe+Kn+UcwxVCHtbYSwGX
         6sbQdzfHM/1bGEKekKu0c2kNO852dMQeOR6lj6XFRUsMTO6VSjCOHSI5240ubIyola99
         TgqIpw/tsUwd2Gt9j6fK1HEXMFoqGDI+qmahyo7ump58f7s3yEkDGpXDI0wiOh3nUkgr
         4Gg1s87CmiYyFBvER0zIDppxTrOMfx2SmB0O8fBy3lt0ep+AR6f3pbyhHIPuxzDfNSRD
         bd5vG/5CNoYP/jHucjzMUixaFId20jAtML3YhpRD0H43LBOI1Ue4tM5Ond5HgyMmbJCm
         wbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321491; x=1709926291;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmacGR1TnQw3/1+YUX7IYVUqRqf3TKN2N2LZ4g/zn7E=;
        b=IyrGFT95uOLtYyTzVrtMSevfmmSdRB577v2o8dUmZMuHCW4Ewzj2F/iBcGBLWGYHOA
         wrCVL80F81PAQB30f0mATZ7+VzwOeEjkpWTlNs5/DP4S5b2rxLHpm4mxBYTNaPxuDzWt
         GT0FRapy4H3ugrcbCHV4biHzqQx5ig2AsLMil7mb/dP1zZpxnPur1jHPXF0Zb1HNtHl6
         PzOla56Fr6HQibc9J44qAu+Yt2XKfRsZTgZLoOrfXMWvAQFNT0ASHa0ZmtdzW82o/YmY
         oBXQwnK1xEicUUC2JAki2AmUo1m7i6JC090QQJoFrX4sUjlip8dapVrM3IgzlSdislrt
         D2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXC0wA8N6VCWXvdm6rDjdYh3YkXX1QN5/RDJmz/cXNZbQv+/OPfXcCmGO5WnTXfcpe8kA1nm44f7rRfPqmPYn0jhGTn
X-Gm-Message-State: AOJu0YzmsZ8Tp+qm/OkooiLF1MwcaPcIGKylaBK0Bx7bAZCEtjQPNdpw
	c9dh06WxAVMTJdN2K4xfCapnj1sY3dDbYeCGd+vGvM5O8lJy3kj0h9SBOqA6
X-Google-Smtp-Source: AGHT+IEOkQvhFe9P67yFX0P+qI+5Qu2XcXQ3CcawkghlKkMyjKFGbvyWy9047jiXqnafRax2haloGw==
X-Received: by 2002:a05:6512:a8e:b0:513:353b:5091 with SMTP id m14-20020a0565120a8e00b00513353b5091mr1471513lfu.40.1709321490020;
        Fri, 01 Mar 2024 11:31:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s27-20020ac2465b000000b005131e2bf3dasm706811lfo.215.2024.03.01.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:31:29 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g> <875xy76qe1.fsf@osv.gnss.ru>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<xmqqmsrh6d2f.fsf@gitster.g>
Date: Fri, 01 Mar 2024 22:31:28 +0300
In-Reply-To: <xmqqmsrh6d2f.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	01 Mar 2024 10:07:20 -0800")
Message-ID: <878r31n3zj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Jean-Noël Avila <avila.jn@gmail.com> writes:
>
>>> +	/* Dry run won't remove anything, so requiring force makes no sense */
>>> +	if(dry_run)
>>> +		require_force = 0;
>
> Style.  "if (dry_run)".

Ooops!

>
> Getting rid of "config_set", which was an extra variable that kept
> track of where "force" came from, does make the logic cleaner, I
> guess.  What we want to happen is that one of -i/-n/-f is required
> when clean.requireForce is *not* unset (i.e. 0 <= require_force).
>
>>> +	if (!force && !interactive) {
>
> The require-force takes effect only when neither force or
> interactive is given, so the new code structure puts the above
> obvious conditional around "do we complain due to requireForce?"
> logic.  Sensible.
>
>>> +		if (require_force > 0)
>>> +			die(_("clean.requireForce set to true and neither -f, nor -i given; "
>>> +				  "refusing to clean"));
>
> If it is explicitly set, we get this message.  And ...
>
>>> +		else if (require_force < 0)
>>> +			die(_("clean.requireForce defaults to true and neither -f, nor -i given; "
>>>  				  "refusing to clean"));
>
> ... if it is set due to default (in other words, if it is not unset), we
> get this message.
>
> As you said, I do not think it matters too much either way to the
> end-users where the truth setting of clean.requireForce came from,
> either due to the default or the user explicitly configuring.  So
> unifying to a single message may be helpful to both readers and
> translators.
>
> 	clean.requireForce is true; unless interactive, -f is required
>
> might be a bit shorter and more to the point.

Dunno, I tried to keep changes to the bare sensible minimum, especially
to avoid possible controversy. I'd leave this for somebody else to
decide upon and patch, if they feel like it.

>> The last two cases can be coalesced into a single case (the last one),
>> because the difference in the messages does not bring more information
>> to the user.
>
> Yeah.

"The last two cases" sounds like there are more of them, and there is
none, so to me it sounded like patch misread. Maybe I'm wrong.

Thanks for the review!

-- Sergey Organov
