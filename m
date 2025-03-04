Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB26202996
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110596; cv=none; b=tq1EM6WlGpBZFo+yYlUTUi9Ocuwih3c9QjM+rYJ6cWb3iYbcaAo6AqlzMr48CwnWjNxUHS2HgAUpslBnSmQZ20ODJj9Er4BOwj16uheBJz6Fx286RMxfMOyrjBgOXw5k3sf8ygugjakdFDMb771xZ289YeJkFxvDPe2FhaCKzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110596; c=relaxed/simple;
	bh=SCpdKL0GylMnatdPGiEWPucigMSRgq4d/HVgK0gaOVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfEj5Be1hKAChoknd5LFmwBETWBAuSSRc/HBn4Mv8V0UrEaYOThwV5PvVYV/9dYljAfX2FrLZ8VqkO7jXz694LRFTq89VQV8F2a1BBfJM0cpOwaZ4QAeXIXoQhjh53nsn4SOm605owEOvPdHg+wLX4fUHeNXenEoGAOWALL2hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzGRO2bs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzGRO2bs"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54973b49353so1560745e87.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 09:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741110593; x=1741715393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVVAM7L0+MvCUrrVWu2tY61N2EYBBHX8FMK/RIbDp28=;
        b=TzGRO2bswCpDYUtUnaRYx66oHN9wm1l9UURJJYUm087hyi3d7vK4CzSQhs4fwNBVq+
         ZGf6fNN3qBQX50SUlTJHLOghzRotnpOHHVrZAUHAxz+ufzKHJafmh4ccrjsz2twyzowq
         75cOmY4DK96dCDdfYoVBTQST/hButCKTV6eRjUGI7uBXkZEMedREDcAG5ZET64m5eRnh
         ESsBE3ed1wiwKBJu4+xrVoPIXsvRuIKjgaTOVw0L66h9U4XSVKQ4K+JKgqag6XMGwJYr
         HDyrN3Ixa/Q/VBXVsMYEbW6zodozSsdJLRPX4J5Kg8iEA18OEFF/Ifz2v/Qc8SYCTL7X
         CVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110593; x=1741715393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVVAM7L0+MvCUrrVWu2tY61N2EYBBHX8FMK/RIbDp28=;
        b=BPqQW8k+OYrhZl84u/fQ0W8XXU7QNc7kWFHAVvyKvaGPEUoq1AVvDZwR6INKVDxlRc
         6e2+9g9rP6VojSfb4vf8cEbO7o3KqLOazzpv11anIvwn9QAXVllvJRBoQ56/VOKLwjkc
         gFIXZMca9nHaBViYno/VbTjCVRn+F8THgxcB7PVvVZm0UbYikNgWalEJJNMt2ZRXzAjh
         YCRSKXZlqxU54hYn/N2aeTxhvPL8xfrDIOrvDcTi2x0xm5wui0JF8/Zbf9pJyM81ZNe8
         AWuJXq1sBj96UIMh+YtsOY8THyTjUPNZro6ASUGyFqaogNuV7a0Qf/3sK5bgzchKvaS5
         eyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmqYRtRkDc3CErak36aLFC2eW1OjTy7nuiNIH3UEY8Q2jC+Np1nBboGVIHs0/kR8EdaHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWyqVCCGo6vA5xDKzZ0XUQc25GyTvtXHeade4ZSuoVUNuM2Klx
	NcNgSzyFQzY40R6XQLPVx+gVA9agqsMKTm65ZcHgVksA/RfHox/ne6cPUj4rEzj5lco/9nV8fdh
	8gBG8QmLhkB6VjAEINUjztDRqg84=
X-Gm-Gg: ASbGncsuTXuOdu7p5Iq2bTEYgwa10wrZyMe3WIwTYzP3htyjQk3L///1XpTKIR4jcKe
	+pC4owCAsmduTOSNo3h06zRef3s0E0pMqYTflClFq9X+b3Ga8D/eMYzwlqWMmU3mGy6j75UeMs5
	6SgFdRetkV9qT4n1kvdvcMers4xxFwxJzuMva74pn0DGqRN1vIoZjPH6x/0g==
X-Google-Smtp-Source: AGHT+IHqsdLy2/vq4doh1iclwQDHh981fsaGrrzlKFkhAEJkIs8w1V2eWTExlp0bHWGoyeUm+322Vx8vxQfhx+QGU1c=
X-Received: by 2002:a05:6512:3b83:b0:545:9e:bed4 with SMTP id
 2adb3069b0e04-5497d383223mr10517e87.52.1741110592872; Tue, 04 Mar 2025
 09:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
 <xmqqldtlt304.fsf@gitster.g> <CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
 <xmqqwmd4r9jx.fsf@gitster.g> <CABGrwBBaHzM9tE6vWkuMSZuUbHVWwCZVTgkvMb04C=NYyGCLAw@mail.gmail.com>
 <xmqqsensr8r9.fsf@gitster.g>
In-Reply-To: <xmqqsensr8r9.fsf@gitster.g>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 23:19:41 +0530
X-Gm-Features: AQ5f1JoM7hjcXBe0E2uJByIRUzcj-BmXivUtcAmBDcyxQXF-mgK4ZMTbRuIdU9g
Message-ID: <CABGrwBBbtiWtMnwJV3Pefo8VDH2LYWsH2QKG-TG_AEdZq5585A@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 11:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
> > Yes, due to the use of the "-f" flag, it's not necessary to explicitly
> > check the lack of file using `test -e`.
> > But if we drop the "-f" flag, we will have to check the lack of file
> > using `test -e` or
> > `test_path_is_file()`.
>
> Isn't it the other way around?
>
>     $ rm -f nosuch ; echo $?
>     0
>     $ rm nosuch ; echo $?
>     rm: cannot remove 'nosuch': No such file or directory
>     1
>

Yes, you are right.
With the "-f" flag, `rm` returns exit code 0 irrespective of whether
the file is present or not.
Thus, the `test -e` check is _required_ if we drop the "-f" flag to
return the correct exit code.

I apologize for the mistake.

Thanks,
Mahendra
