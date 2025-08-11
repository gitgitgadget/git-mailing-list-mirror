Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC22E2832
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946359; cv=none; b=eeSQWUEuh2O0wYTK5uqIBB4Cg7DUnHI72AfQbfbfyH+qvgNgFWJPqjMlSD+zIdlGA4MxhU1BXfEPNZQSr03cM1RTCDE2EWqxkLrDVhUR5srcUSfiTe4N6yrqAgj0nSEHwcBHxORGwHdq7mX2e/JKYVlcPjM0XcShpJjnnlklzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946359; c=relaxed/simple;
	bh=Ji6Cw6EJWi3oq9RLy7HU4zX8rbLkrZQoNCL2qH4G4mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnIfyoJe86/b/pX+zYaFLqMmbQYrEdTzUFLEsAp9+mVdj5lyGNRv4fJo9ljBKEvyDGRN/gKxD1528aMlOBmRABp0xtc17M/DCOm8Oiyu/r+myhpacnWBLZ832oxuporkljFyFay1rJ4HziMO8Xiq9+rlHPSMv6/JgwKxkT1L6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHQxHy6S; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHQxHy6S"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acb5ec407b1so671347466b.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946356; x=1755551156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji6Cw6EJWi3oq9RLy7HU4zX8rbLkrZQoNCL2qH4G4mI=;
        b=cHQxHy6SSjB3HKzI1QVbO0ugyxnquS/ApapG56esRAi1qf9X2uo4mKGPlsbDgdcV4g
         6r6F9vafnwP+VvRHe2tzaWxVVvbvZMWliczeMo2Ac9XYfvROhK4dzFaw9ObYJWZWkCBM
         4P+fD6FQErk4/JfgYBylQVW7jTCqD3XVuF8b97AJaSus/+SSlRWYWaRwi8RfW4P3mVyX
         vpsu/+BrKZ1Ljtobq865CweCZ5aWb7NKN9yOLsEW+qPyJYJY9bW94GwtGf9cr6Onb+Mr
         OR5+N2AyuUD+qr+zMAVfukmCii6sU5x7DsDdADLbLW43dw5k03Qxn+Z7z2wiV1JUakKE
         GDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946356; x=1755551156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji6Cw6EJWi3oq9RLy7HU4zX8rbLkrZQoNCL2qH4G4mI=;
        b=BiSmCNkk/h6Vo4/b9ZffQWBbSI9idbsYo1mcUg65XLFwbkaXlvOVXgu8bb+10DqosK
         4xoNoIV6a2/Vr4IKM7ZiWWS5V3hjqciyfm33CwChElHcd5S74av93gLx51SoEre3S7xx
         EahtXG5T80ASSOqweuC6eR2f7/P7s64IJy9mbSIq0kapEmpT8X3l2CFPoyIo0JwZLe0o
         DthWVS7qXMBapkh/f0UXJjuVrUamEds5AfeI6GuVr8kDkId4FBQGzKCs4lhDXtQ0emDE
         xSYUqju29QDfYSgog+FiN68NEy7L7QMT/gXoowFr8by19+/S9aaS25s2Bg5LAGFU5u/I
         qoUg==
X-Forwarded-Encrypted: i=1; AJvYcCUqiwI4Owd58BSAHUd9oclWF9pgVekOIcPS4Cii7KYF20CohE8qk1KM5U3D+tLQiKXYimg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRTAjYXQNc2Pv0lBQoeM94080GtO+UO2qSBQ0v/wBD4xOYGje
	U+0OQeRnQE5S6cvhlEynOI2+q6D5IcwRpCt876FJdWz3Lyxhu8URoKl8nzZ7CZrwXXy7VjDHIPN
	AYZEDJfhCdYSe62nH4H0+A0v+Idmk/B4qSQ==
X-Gm-Gg: ASbGncvKFtpWKKPpdFrW3zJi6fTEUDf6ZpubGof1+hB8AKUhN0Nfwlom0LmqEvBSbXQ
	H2ZvV5+vf393BJo82oH5YYGoG1sZKWWoHzDuNkNPJaVww71VeUm8r0pk+w9PkV+0H8QJHEGVnGj
	Nte3IdKVShXO1Uhrxu4LSpWe8sQIy+d0C/Dvw9CCYRm0fihyw5+q5Zkf0YG9uS0280185qBBAnK
	oER9NOMxZEQhDm3fgd9zCUv4F9D34zk0+RS9z6MkLR8xHcMTsE=
X-Google-Smtp-Source: AGHT+IE7nL3LRe+Cazn8G4CAzTFwx7FQ/Jue0WZpcDPhaY7qmjJ4tAMyl2E42Vod0aVsuf2xWgfaiKxTjM3cVieel+I=
X-Received: by 2002:a17:906:fe0e:b0:af9:b456:f9c8 with SMTP id
 a640c23a62f3a-afa1dc8127emr98608766b.0.1754946356108; Mon, 11 Aug 2025
 14:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <pull.1950.v2.git.1754913323810.gitgitgadget@gmail.com> <4e2e2bea-c8e5-4343-9e70-a2bd139eb242@gmail.com>
In-Reply-To: <4e2e2bea-c8e5-4343-9e70-a2bd139eb242@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 11 Aug 2025 17:05:43 -0400
X-Gm-Features: Ac12FXxbSANHpVb48JdeSgunh0syEM1LuD78YPGGjpjAl1c0r5Cg9pgI8SJTnd8
Message-ID: <CALnO6CChgchH-KPyNwwy9zf41c_2miqza4rWS3NxzpZFcJmEsg@mail.gmail.com>
Subject: Re: [PATCH v2] git-jump: make `diff` work with filenames containing spaces
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Greg Hurrell <greg.hurrell@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Greg
>
> On 11/08/2025 12:55, Greg Hurrell via GitGitGadget wrote:
> > From: Greg Hurrell <greg.hurrell@datadoghq.com>
> > [...]
> > 1. For file "foo", Git will emit "foo".
> > 2. For file "foo bar", Git will emit "foo bar\t".
> > 3. For file "foo\t", Git will emit "\"foo\t\"".
> > 4. For file "foo bar\t", Git will emit "\"foo bar\t\"".
> >
> > Before this commit, `git-jump` correctly handled only case "1".
> >
> > After this commit, `git-jump` correctly handles cases "1" and "2". In
> > reality, these are the only cases people are going to run into with any
> > regularity, and the other two are rare edge cases, which probably aren'=
t
> > worth the effort to support unless somebody actually complains about
> > them.
>
> Thanks for updating the commit message, I agree it's probably not worth
> worrying about cases 3 & 4 unless someone complains
>
> Thanks
>
> Phillip

Agreed, and fine by me (since we have a strict improvement).
