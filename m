Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397413D896
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666846; cv=none; b=WytEmWBnseic+tSYHucusjp2bS/HvTpVhNpNVXbz6H1uTXbwkqYeWhOKEMaa8E21Yi4qjTQg0DULskumkZZxN9abm08EDgLbrUB/l3hcoSNIfrNcEFwbNc+u+t1q+FCSVdr3koM+HQEZhd75u/KNI7qB723t8evnWaKZID2GlF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666846; c=relaxed/simple;
	bh=Gzi7NT4j0ON7tM7u275oB6iLbkyasH58D7VELWcteRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBonL7sP5M0UjjPTgex37DxhjHkKEZF/JKvZXKpxOCOdqbExY/kuQsGvzWPgoxHhmEG5SHkIBTCg1BnjpIN2mzqBE3hddgpjaJznH5/KYXtas5OkrMqnYnTdPHBwzn0pI+rznFDRyOehX45GgYbjWo3+Htey8QcIh+9k93ys5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hKu1Nnei; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hKu1Nnei"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20e6981ca77so49124195ad.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729666843; x=1730271643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzi7NT4j0ON7tM7u275oB6iLbkyasH58D7VELWcteRY=;
        b=hKu1Nnei47M83ZZKQTae3sAb8/AW6/y9iOI1kK9J9vWRoojCbRxizo54CUAroEJvuC
         klwmp8jbNd4JAkouD7mbThEHFjYhL9jbKdYdEzzfvI6n5lvAsBBks8uJzBwHaj46hcx2
         34yQ1Cj4x3qWrfSkho6R8VwoR0wblfr2utbDImO3H3zk/hfl3rGbfC+LeoydBJFiDA7U
         KdKW3nmfad1+rEjNBa/g7YAIiStx7dbhF6C3baF/xNfiLd87DjXU6/mmnwNHcU1RdzN1
         ycLcV3Z2649WVX3FiSswAwDB7eMp2FaQSMce9/5ws0pQzRGhQnKgaB2J59BNw5x+PW9p
         Vn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729666843; x=1730271643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzi7NT4j0ON7tM7u275oB6iLbkyasH58D7VELWcteRY=;
        b=Htdnnfy2okJwnItQW4yU+9GYv3c7VLvriRqlXyBx/ikim/Xl39PZ6nEORzORObuu3y
         fX8gzIGq5T7+snS4+8DmcHbN1kAmHbaDQjbS0gsSc5tTJcYi22EFopBXcSSnhfrSAxAJ
         uMuhLL2L+D7QsHX4uYfvaGmsga1p9YGMty6UnX/n1IcZN24kbDnC2a0S5D343Ea2D+tl
         Z+DETWOKlpw/D8TX5tCN+6LMvDXNuDCWkxT4bZU9AXcIUsdse6071RsxtV8xJY/W8Sbj
         ZbJ1Yi76bOzaLew0XlOIEYd3zuawRPoFiItSUJb7pV2rZN7KIxoaglTjlSaELf6d/LaJ
         /cNg==
X-Gm-Message-State: AOJu0Yyar5WyXu8wKszFAZC+OykmfHdesnmwJ/LRavVkGaixI4//D0a4
	TstAD879OzUJD+JAWv6IfLAsQzIB/ym88Cb6zpg5MvyfkosdRWEUBf/3ztT3767k21SavrIw+np
	UCAdiLN0M6lqWN38ZCvX8YD/Jdxixow4yz/2zOSNzcfM1qV8hEtc=
X-Google-Smtp-Source: AGHT+IHTSxvIpydi8IBondKWWZfZmoBKWdalJCgR1BBLIAGxNF4eTnhMaw1vF1zQivqK8Od0voOEaZIkgCUmoWVJr3I=
X-Received: by 2002:a17:902:dac9:b0:20c:83e7:ca54 with SMTP id
 d9443c01a7336-20fa9e5f0ccmr22473335ad.27.1729666843348; Wed, 23 Oct 2024
 00:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014032546.68427-1-hanyang.tony@bytedance.com> <cover.1729549127.git.jonathantanmy@google.com>
In-Reply-To: <cover.1729549127.git.jonathantanmy@google.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 23 Oct 2024 15:00:31 +0800
Message-ID: <CAG1j3zGiNMbri8rZNaF0w+yP+6OdMz0T8+8_Wgd1R_p1HzVasg@mail.gmail.com>
Subject: Re: [External] [WIP 0/3] Repack on fetch
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:29=E2=80=AFAM Jonathan Tan <jonathantanmy@google.=
com> wrote:
> As you can see from the patches, some polishing still needs to be
> done, but I'm sending them out now to check if other people have
> opinions about the solution. In particular, Han Young reported that an
> alternative solution (repack on GC) takes too long [1], so I would be
> interested to see if the time taken by this solution is good enough for
> Han Young's use case.

Thanks, I've tested the patches on our internal repos, the fetching time
increase isn't noticeable.
