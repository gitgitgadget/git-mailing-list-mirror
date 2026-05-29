Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69923403E7
	for <git@vger.kernel.org>; Fri, 29 May 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077153; cv=none; b=sZwM8ph5NSx97q8hAdysK/MelfL0Xu8dthNrg5gkRBXaNGZoYM9U487bV7yTropL4iBVmsjEwJ/LU+NUqm8S81S/WT/CJB/VUm6Dap+wG8WdFFhYQ4EcHNZh8lAhyvDcCHlolPxiBQYsXlPdCXtZlgncqP1AfhZY4c60Xfv5HQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077153; c=relaxed/simple;
	bh=QeYvLQ2Hmrk7HYL4czQfDIzobizHB05eT1WVelUuqHQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZTJfRfWedsDFVmS6qPrwKyZ492dQJuybm84dDl0h2R35Yb2rn+uDdK7RGo6d2KE2nmZFX/rqefI76+W808YwR215uHfKKtUrqI/gnw3WqrvNwuVC7ephSIqM1zYUzFBW1kz6D7iOXm5al2zchCPZdswndOzCUXOqa7UYX8EJKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHGMNa1i; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHGMNa1i"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7dc6fbf3e86so27787707b3.3
        for <git@vger.kernel.org>; Fri, 29 May 2026 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780077151; x=1780681951; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeYvLQ2Hmrk7HYL4czQfDIzobizHB05eT1WVelUuqHQ=;
        b=gHGMNa1i/s7x2CvT9Q+RlxZ7SFQltdJgzQVVWlYoC4UdLNo9WbjzGeu6+r4SiVJWNK
         Zeod5fn7uV/xk8IIDg0e2JIQZbTV7P4F/Tfgt+XnExwbmlyStMH2g/mxaqZN2ZNqHt7u
         k+43Pxz84vi0qjokFqBoaGpYWBOKnSx58fj6ZbYNsUEgf7mcaSaRQb+t3N+ZMp24Twhe
         F2x8wh2e49ZIxsHQIKFrZNkvk93m9ulE8hBggaXM0bF269zh/Enaxsx73Qx1m+1d11cd
         BLUpRJHkuvx/8yo9bOb4LZRv8MA6vRhepxR0DGuUneztnsXtn4wZXY2pnVhaefdVwlGC
         S/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077151; x=1780681951;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeYvLQ2Hmrk7HYL4czQfDIzobizHB05eT1WVelUuqHQ=;
        b=dM9v6TfVP7bhTZaId3rTT5IoXBn/+676vP/CBzfHUo/Dl3mWl+9mvxxpUPkLoGuzTb
         Cu0wV0Vwq+IUHW2pIsa0ojP1KGQxlX9Ls9XkalS5NJ1lixftw5LAwMfDou90EyZw5s+K
         nvmVA+KCzqDs2QhHR/tvrfPLXcutzyHaduckgLfDvUbsv3elA5nHlOJv4p1HQUFP3f4M
         5jWwGf1g5z2uXwFQk1lkVyF3h3KefTXH3oFRzqUhSqTCrSVx2U43JGCLNA0YM0e9gRiL
         S56+JQi+m1mjuvqJHSK6GBRNfWN1A4H58n09/gRqq4516St7a7HijGhPJLg6vu/h74wf
         yhXA==
X-Forwarded-Encrypted: i=1; AFNElJ+q6Rmq1dYj28zMi0rKdNZ8M3d1paiB0ra4X/UU4d3kZ2XgrFNxq7aooYfWQyugS0BDZQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeCiAtQq89a90GNgS3Anhfxe449xNdomC2Fyh1+wZPTwsQ9AF
	gcVy7Icu/P0XsRMbjn6BttUbpv169mjyIzPlDBqI3PuIxwWuSz9Wu+01GMXI0nUW
X-Gm-Gg: Acq92OG5jss8Efyw4I/sx6/xN7gmku3axryn86FSCKY/oNHIjGepGNSRauApFK+Tsed
	XmgwN/c7F/E56uHqFFqaW8vODlQcVNUJL0rs7yzgaF82lZMhgXkjjy73X0cyY8YDqb6Vqkg7zDV
	fVxSqyjwY4DZi7PE0iCyzNyyUy6M9Vc+T01U4gtGpVWSV4l6KOdOVW2Q0F8c7gs7LCJPuWwuTcr
	eXoVL+BHapF7CYkDtiXZKZoyP3Zv6PM1CqNDjYem4mmbS/Qvexr5rZQNTRdKNXv0gvprq6NmcpE
	Ulk1gmpKg+CnfrlvLvJ8V4m3/jPMCG87Sq6dgSL3oQiXxPl2cgJFqUMSps3fAdCKnLa7jcXE78c
	Fw/AxrdMeRbzSF/wjwO7jmCvE8Ejpe3SVZzpTV/XeqrI82lrtdWzKLcgy7cnhpfF9OBIsqD8UlV
	GI6NKnzD/KzNxd/8x/oI24fFxsN/UCt8mGMP9Y5vsLosjg8sEXfFAXTUzUG1y0gwKu1PIgvK7wY
	jhZBkbwvx0Kxo89OtJFUPnYcWc18Br/rLL3YuuzbsW0Eme8iUTeNj0O
X-Received: by 2002:a05:690c:9686:b0:7b2:6b19:df2b with SMTP id 00721157ae682-7e05cb3fcc9mr3941177b3.17.1780077150495;
        Fri, 29 May 2026 10:52:30 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:ec65:a111:cab6:a60d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7de6757fe1esm8561257b3.5.2026.05.29.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:52:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git hook question
Date: Fri, 29 May 2026 13:52:19 -0400
Message-Id: <710DE79D-35C3-441B-9D7B-CE90798FA0C2@gmail.com>
References: <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
Cc: Jeff King <peff@peff.net>, Git maillinglist <git@vger.kernel.org>
In-Reply-To: <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
X-Mailer: iPhone Mail (23D8133)


> Le 29 mai 2026 =C3=A0 12:17, Wesley Schwengle <wesleys@opperschaap.net> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn 5/29/26 01:21, Jeff King wrote:
>>> On Fri, May 29, 2026 at 01:01:34AM -0400, Wesley Schwengle wrote:
>>> I understand the why, normally pre-push gets `<local-ref> SP
>>> <local-object-name> SP <remote-ref> SP <remote-object-name> LF'. This ha=
s a
>>> similar feel, albeit a different syntax. The difference feels like a min=
or
>>> bug, but not one I'm worried about at this moment: you would expect it t=
o
>>> get the same arguments/parameters as the regular pre-push hook. But I
>>> digress.
>> I think the "git hook" command is mostly intended for scripting, and the
>> caller is expected to understand the context and provide the appropriate
>> arguments. The hook command itself doesn't know about what a "pre-push"
>> hook should look like.
>> So not a bug, but definitely a gotcha that could perhaps be better
>> explained in the documentation.
>=20
> I think the "normal" pre-push makes more sense than the one I'm seeing rig=
ht now, but perhaps that's me. But I think that the docs would perhaps need a=
n update to why this `remote url' are the arguments. Especially if you read `=
githooks(5)' it seems a little strange.

The hooks manual says that the pre-push hook is invoked with 2 parameters (n=
ame and location of the destination).=20=
