Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D64C7C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938013; cv=none; b=lDefYMQt8SwhL7hcWaZC1S/pAcbeGxCWytEgoqvumiPhNc36Spf6SS9A5It68bIw7l2WcJ6RO4X+MkfSShuyvoAuOaH1VpGyIoUu/o6+PwGZ1yN+ibym94Dr/fBWsbxzPpyk1xY8b40YmbF0h3sE9hZlpgnM0ZVCdA+N7FoVkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938013; c=relaxed/simple;
	bh=6hqENWNH3j3q5xT+r/QnhNxCKYV5q5PxPcHON+SfK1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s9rm/UdgP0qpF+IxDS9cEwW1XDeyZahATQmmhDQCjZjvuDn0Wq6+GPd1RAJypPeHK18Q7T8ACMqm58o/GUk8/AOzEbln0t09KQAh600lNcJFFgAkNViqKNIQ5LgcFnGKyWYIwgUHMMfFsolOyOgMkrGgEpfzSetrWef9ZwGynqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXlceToV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXlceToV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4305413aec9so45073035e9.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938010; x=1729542810; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hqENWNH3j3q5xT+r/QnhNxCKYV5q5PxPcHON+SfK1M=;
        b=nXlceToVFvAh/t5YDcGQlAx2N207PfKSxx1OmCvwDU0ZlCs4VyHAeAxZN7KSfXwA2M
         w2VAmLTpp5ZPMP8xU10i4L3v2Fzgm8xvGXSWF/x0Mj/oioGaPq5McvzQeY8ZrGUZCuFG
         OmK9NV5xGbMTYDnhNRI4cVcXlRq7FDnBpfy3Z3ZSm7h89lJtVJSdlSkHdZfpP2V6SmQY
         x8snfb2R32/+8ZU2vOTCFRCSEf2ichd7HFOrYP+OMsdO7LFE5gv8R5csqIF4mXP7+8Na
         7vEb4YGhdLqgQylpHV0mPhk2lm96hNB5fLWKMZEPdTcBeVs9YoXSroxIA8GLV3wMDQxT
         odpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938010; x=1729542810;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hqENWNH3j3q5xT+r/QnhNxCKYV5q5PxPcHON+SfK1M=;
        b=JaSbDfAIrIUvjvNmdiSEXyMCaRbRDPHYA17iBrPr094/tRfCWRv3q/SgNoN4fsFum9
         Ne4MwFAdwD09SyHYD+hy9vvLHKo3LzAUBViiuNJNtnawndUTYaSndUs77PaMq7ZDcQcQ
         Ew0iQt+Wd5ypHlcvFcG5QZom1LZnQlpx+qmxMhYLdAkqpML+oRQzoClhgX6TSsN0xY6p
         ydFVMsQGxaMUGRqZiCzUDIQbob5rRGv/zYSeOnFhmoHyD+ulBENghoQtvpZAcmXely8W
         kwp8l4TrAHd+VxEJt8isQItHYw6jyutjoMCg1eAN0P49uzKIACmNlptahl3ZnYvZMyVM
         BO7w==
X-Gm-Message-State: AOJu0YxmSVMqQNqMhDcg6Qw0lT9Vrl1ZkI3k6OuLf3QKks3Ie8ODLz5v
	Brv0Rsp4EWVT5e+PKYh4R0GpBwLjUhrCM9izkyEfLItNUQKXuJp3w0X8pPl9
X-Google-Smtp-Source: AGHT+IG/awr5PVhOWINeNS9goLZxCslRcadKYvfL4PGP+bFU2U/iBqtMrU82EUC3U6/IinKueHPmsw==
X-Received: by 2002:a05:600c:350f:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-4311dee8073mr124089675e9.17.1728938010137;
        Mon, 14 Oct 2024 13:33:30 -0700 (PDT)
Received: from smtpclient.apple ([2a00:23c7:890d:5f01:51fa:eff7:33e4:8633])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5188dsm162522705e9.24.2024.10.14.13.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:33:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Should object repacking only update server-info for packs instead
 of doing it for refs?
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
Date: Mon, 14 Oct 2024 21:33:17 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Martin Fick <mfick@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On 14 Oct 2024, at 21:07, Martin Fick <mfick@nvidia.com> wrote:
>=20
> I have been experimenting with trying to run git geometric repacking =
after every push on our servers

I had the same sentiment when I studied how geometric repacking works.
When we tried to do geometric repacking every 5 minutes on a busy repo, =
we ended up with a single pack file most of the time, which isn=E2=80=99t =
really what you would expect with a geometric progression.

Running it after *every* push would make more sense, as Martin is =
experimenting.
Please keep us posted on the results :-)

> and have noticed that even a NOOP geometric repack takes approximately =
30s on one of my large repositories. Further investigation determined =
that it was the update-server-info call that was taking that 30s, so =
running repacking with the -n instead only takes 6ms in this case! I dug =
a bit deeper and found that it was the update_info_refs() call that =
takes all the time. This seemed a bit off to me. Yes, it makes sense =
that would be slow, I have almost 2Mrefs, but I had to ask myself, why =
is this being done from git repack?

I believe it should be done to update objects/info/packs

> It seems counterintuitive that an operation designed to repack objects =
would be performing maintenance of any sort on refs?

True, it should not touch info/refs IMHO, as you=E2=80=99re really not =
changing any refs.

Luca.=
