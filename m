Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092122F11
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729523; cv=none; b=od/T7hXDdowS9oaFr1lquEm3G5skBqR3JE3u3ZZ1QNLNEdKrzTwddFYiHFRVWL6g9fRF8hMAkKxxi3LGQ8kpL8DVIOwIethUJPHi904brB3dObDQ8Q4uqcON8TpReiBWqJqY8Qr58rnjNOpVysuqb5mbFEf7RQgpDZ2iNFYUPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729523; c=relaxed/simple;
	bh=zoOgNy3Yc9GEXftLC7+d8BjxZiGRrFxsdiVS75Gi3Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc/krXnIHzj8Mus+MUviCNO+yVcKMt4WsJxMB37ocEftXSkjpnDk552IYMzvc366CUCtb/Xp+H444uBt9BaHu5/AaNKN8Kp+u9tQggVmtAjA0BdKF5aXIIhrPkd0f+2XGzGsvKpOy33wy+tZEyidcks+YCsk6dcK2YBkWZSEbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJKcHDk; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJKcHDk"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a74cfa7671so769458137.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729521; x=1730334321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na2YjBY9rFzU84Kux0fzRzp0rblhJ0Lfs0/mH2BbKFw=;
        b=XQJKcHDkkCFKTa+efmxLH02hsENfpMlJpq+m7KlLYJCKuvom3AHUZ/g3HlYuKdNYV2
         bMV+pXCUDv+cQuBghFQhZQ2bnjaxa+FObdbyv90XOfB/jxFzN9L4fIE2c7W1BM0HYKFV
         W+LyoTypGchWvNPttgpY6sL94NOlTwFSkWIhl18Eo5HV1O0akWCHG1JeiFYce/ghpd1J
         zossyrSq45wcvo1VBpMgnLiEHVMr/fmqaAtwKsRM9FB8uCu+lVpuncc1B9gCWJcPL/ZQ
         jOX1eSlH6TfkLbOIoZ2YqRKVbd/L9kwV+3DoyhYw7C0NcuujIAW0kp+HnpukbuEPdqU2
         FhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729521; x=1730334321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na2YjBY9rFzU84Kux0fzRzp0rblhJ0Lfs0/mH2BbKFw=;
        b=OYoceC1orleNPCeBMH2oz2z71K/X86p5wtpD7GAaz8tdfNa9DSbIbPLZ+1E2cM0rLD
         7pBwPQ0qJpC+wRB8xGBlw/LQI2XhOUa+IwHE1Xo445ugb/l8hsytJfN7D7I/xElGNCC+
         YJhMShb7rOy4kbJzIfNjEspskqAiCXjYy93zkGU0nhRwlh2w37y7FeUW49ets9uaMso1
         rQ8WJv8DsaVhCxmyS+ewgBlq/JK36u0YG/KPDQNbgUcSZ2XBmgDup0GJrROUu4OSbuNl
         dtQz2zjo7n3SrkDFubG7u1F0DQvBGiHLn81BAYLOarZmlaXIv3ZJU2RvfEvjCwxuVaC8
         eUqA==
X-Forwarded-Encrypted: i=1; AJvYcCVtjLsQVok8ZCK/7DjR6JkJrpTWh4aYQLvpyO7EbTK4OcDaZE+T3qOBWLsggMYCATyIcGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Zzv5gClMKFdWXfqGcTFNz9MXoYkde072IVBOh8MpOBail6X7
	HUv9G9p8IBBK8CbTxmK4wxAXs5URaqF5zJLJERh7UNHcep0LMEzsOX+/enM6G9q0V5pn5VEeqAO
	+ps9ErNVwf3IJtBE2oyXnQVdd58Q=
X-Google-Smtp-Source: AGHT+IFdCmz0nIU5j6hAvnmEoL1Kmc912Zcf9MX0cLp+hv3Nnu/tJUUH6t1haf8IaObeZ4krRupYbfeDxyHdU9jJa78=
X-Received: by 2002:a05:6102:1608:b0:4a4:97d1:ae99 with SMTP id
 ada2fe7eead31-4a870e49620mr131152137.12.1729729520998; Wed, 23 Oct 2024
 17:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com> <Zxi5TeHM9qD3lrbx@pks.im>
 <ZxldiQVBxAWbXoT4@nand.local>
In-Reply-To: <ZxldiQVBxAWbXoT4@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 24 Oct 2024 00:25:10 +0000
Message-ID: <CAPSxiM8KbpzQuOgTG1V9rsQJ33wZy-+mGn2pGq0kS7JNMv-Wog@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:33=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Oct 23, 2024 at 10:52:36AM +0200, Patrick Steinhardt wrote:
> > On Wed, Oct 23, 2024 at 07:40:17AM +0000, Usman Akinyemi via GitGitGadg=
et wrote:
> > > Changes from Version 4:
> > >
> > >  * Fix incorrect indentation and remove unnecessary braces to avoid
> > >    confusion.
> >
> > Thanks, this version looks good to me!
>
> Thanks for reviewing. This one is looking pretty close, and I've moved
> it to 'jch' in my tree, but I think there are still a few lingering
> comments that I'd like to see addressed in a subsequent round before we
> start merging this one down.
>
Thanks to all the mentors, I really appreciate your time. I have sent
another round.
Usman.
> Thanks,
> Taylor
