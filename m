Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7076511188
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801019; cv=none; b=pMuRNC2xBCSHuIMILAqFvcgKmUT0w7Y+n0j7tHeae5e2i6YoUKv1ulhqfirSM6+viSTgE8wzKjzBh/lTwaKl3RjiaYbqk3yeX+d6QDnhKEdX704CVVLPJZMROn8UyvPz5uOMHACX69gJvC0L5tIO/H+fcOHzhfo2pMKli0e8uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801019; c=relaxed/simple;
	bh=XVgDI3bWFTDHLe0XmVXVyX+EWSnE16MK6S0/R435br4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=np8Ze775viAx/WOfKDtC6v8zZX1ILrM+5THRIVacjhevnx8VqkSwQzMDUw4IdNuttd+6Y4Gud4kwoEwzpctHClt8AzN4tmsooKohL7hcrqrHxsLuQonFwbH9WLIAafwvaPGIBozZ8SU6Yluy3+RdxAqdvdA4st/SRVWmdV9bscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=mitSfSah; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="mitSfSah"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39675172593so2916441a91.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1788801017; x=1789405817; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=13bMhJLambWjcuL/y2R6YKteovu2tQcEIrgQ1OTf/7Q=;
        b=mitSfSahlCnybXA5FotzvU9P87nSMfe5rmGgUDf3A8AwryQdWpD/eA2Uqmydh7Duko
         ahrPqHnVolnRq8w2G8RjAecqS/0xCldKIyKWH7LWYy9ZUsejTw4Ii6zEyE7HsEhj66yh
         N6k7a9M2A/yJ7b8SPe/QMKDInFUcZ041rISJVapAtVstwG7kCuk2gD4N/3S86pvjiZq9
         D7+lOPoDA9n0eJuAeiPBS3blZuNJVtRklPyf2iVI8TzyZyKjA82QO5RXvGDYtum9tl8C
         vzmZTLC+hL14zvdw/XKaGPWiTP47K9JIq1pVIRcYvl/V1ol4AfW3eEG5nZkR1O9xgzmA
         zQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788801017; x=1789405817;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13bMhJLambWjcuL/y2R6YKteovu2tQcEIrgQ1OTf/7Q=;
        b=eK+M9rCq6e1BN2avU7guMOT2iyLTDr3oGAg9IoQ13zKmUypKkIZKeSc6TKG7VRFDps
         X1tDq53F6fHIN3MqTWrgdckGP0SfozXXkWIwsl1QMSWTFeNcN+dIDUTXAGTluyRQ0WzL
         hSbrqJx88D56ogbwEWfuKZsKtganJ3/0go8cbh4r+YKPnDuc93+mtx0FAtzLr2h49ckJ
         mtHa86/WHIbsYDL6KSKgG+iqpbjuJ6JzNsH0tDeXqKry5zcvSIfolEJWFzFJ6I+Nmzgz
         msdP5j9osd70Ko6U42+uHT6WulkpSct6pRmBibQvc+u3qw3tmnb7avdpnuF5ma6W6g1o
         O/bw==
X-Gm-Message-State: AFuF++nhXeXLdHW82bCqlNgnhE46rasxDued5z0Ys/xjbTGttzREW7XW
	7tKI9QRljoHQa/DtOt1RYRcIqFSPRYsgMzq9RwgVb4X/M7RLB6cAgCpRtjlRArwymjamhWGBsZF
	XTZPC
X-Gm-Gg: AYBFou3rPci7llzY2o9x+rz0iTpplQrNlYrqTMMyq4crYDdkCSoWNCkAMqMTro/tkDK
	BAOQroUG1LljIGUlEN/XVjLtAowLOMivRPm+2hoeHIya/BwZAXFsI9XfhFjZnjofT52SQihmYf4
	Z1jsoyyMA7mLEq7OcJBOSoL7zaDk5yfsDl6+Fp3vDxP05RJsAAnjknnAlFy7hQnYbqI+KE+Ymxv
	ZO+Q1HmQD4MwLxXs/7OubK8LyVvkj3SbPQ6wuTynNTxp+VVBOCXBj7UeQYaLrfKtiha2KobJLKI
	5PtD93ycuePQLAlx+j67Xv6hBTzI6AWla3GIcq7n63IrwUJwWqCH/iSzWFCBHPHYQKHM4RcAcUI
	bZGW+sfNrhrGaB+qSz9czabKPWPuTk0FK+GyGryS/iNJRiu7P/ootuAB6pWXJS9gUxFUFHpq8hB
	xzV5vErR0UBFYtjHDMtTwEJOUeGHiunNH33Ou5r35chOViyw9i0wIJNbKBWnrn0BrS1FVMueAiF
	pqElbHIDU/jdoImmxU=
X-Received: by 2002:a17:90b:50cc:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39b26202ebamr37513369a91.14.1788801017094;
        Mon, 07 Sep 2026 10:10:17 -0700 (PDT)
Received: from brighamcampbell.com ([2601:680:c200:5c88::1fa4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm28873524eec.13.2026.09.07.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 10:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 11:10:15 -0600
Message-Id: <DL991DWRB590.NECVWISEVRKG@brighamcampbell.com>
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>, "Taylor
 Blau" <me@ttaylorr.com>
Subject: Re: [PATCH] doc: Make asciidoc bullet items separate
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com> <ap55z8P8i2hqddAL@pks.im>
In-Reply-To: <ap55z8P8i2hqddAL@pks.im>

On Mon Sep 7, 2026 at 2:46 AM MDT, Patrick Steinhardt wrote:
> Not, probably not worth a reroll: it would have been nice to point out
> that this is in git-config(1). E.g. something like this:
>
>     doc: fix conjoined maintenance strategies in git-config(1)
>
>     Fix conjoined bullet items for the maintennace

maintennace -> maintenance

>                                                    strategies in
>     git-config(1).

I'll mention git-config(1) in v2 if maintainers request a new revision
(though I agree that a patch this simple probably doesn't need a
reroll). Otherwise, I invite the committer to make editorial changes to
the commit message as they see fit.

>> diff --git a/Documentation/config/maintenance.adoc b/Documentation/confi=
g/maintenance.adoc
>> index da8be9f812..c778ab09ac 100644
>> --- a/Documentation/config/maintenance.adoc
>> +++ b/Documentation/config/maintenance.adoc
>> @@ -41,6 +41,7 @@ The possible strategies are:
>>  This repacking strategy is a full replacement for the `gc` strategy and=
 is
>>  recommended for large repositories. This is the default strategy for ma=
nual
>>  maintenance.
>> ++
>>  * `incremental`: This setting optimizes for performing small maintenanc=
e
>>    activities that do not delete any data. This does not schedule the `g=
c`
>>    task, but runs the `prefetch` and `commit-graph` tasks hourly, the
>
> Ah, indeed. I can confirm that this is misrendered when looking at
> git-config(1), and with your patch it indeed renders correctly. Thanks
> for this simple and obvious fix!

Thanks for the review! It's a minor change, but this is my first patch
to the git project, so I appreciate your time and expertise.

Cheers!
--=20
Brigham Campbell
https://brighamcampbell.com

