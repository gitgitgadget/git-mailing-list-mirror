Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00322318
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886947; cv=none; b=Te4NH/EKDd+XUH7oUk1CxP+0xlF7z3mRcRuGe9MfdixL4cwbe4skbm+BEJ22TKc/dL01JlTl0qa1G8vu0E3Ojtkd1fiClktHAQj1ZIuBuE4MhYC9IDsHwF27c3GkHwItZQcYeeitlHZO/qDsRih4QLsazkrOvOoI45xZhyQW/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886947; c=relaxed/simple;
	bh=ki68I4r5EpDmNgJ4JypKYcuhRlfBY6f+ybvT/ZEmPag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3rQtchPN6h5Z9Hf8dlvHNa1yPjipp6CutVAfLeeeXIRoYoR1SWr4DJXcVr4q/5poogEHXpRC+Ds6IwvsmSNJFLnA1tJHCmWyLrx3bTkcAyKpfLF5KO9Hr7GHLwzNKotm7LjhEMx7cczLffeR9zHG4Aiwttefu6zcTQ7TkUT5Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=m5NGc4iw; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="m5NGc4iw"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso3675872276.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728886944; x=1729491744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki68I4r5EpDmNgJ4JypKYcuhRlfBY6f+ybvT/ZEmPag=;
        b=m5NGc4iwNlmDXBuUA8h5DWSnH0DZlbr6DdQ2VRirHqPRI1Ccm+ajiGjzcy6iHCqqNY
         MO6k4JkmQH+LE+JCshZO7vHmG7JTk09r9PZr/QPmv+7JZSMBrCeFk+8jEgMRywVYHYGs
         z72lrGnfgshd580lib+QxeerbPhNQkiI8ljCAyyeR/s3AqobXPLqvsQDZsoExQfqsxwr
         n146245/P29c5D+Zn+d82AgPAAcGWQaFN8oUbbDJ+Nv8IYLT0yWzqcZqyUe+CDcTGrUC
         T5jA3/SPvMazSECgRyxOWxXefxtWH8dfxYO/sWgfobqZQIjwk76Mat0TYsXP9BX/JhQY
         1bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886944; x=1729491744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki68I4r5EpDmNgJ4JypKYcuhRlfBY6f+ybvT/ZEmPag=;
        b=Nd2evFgXenbjQfty9CoE+5VNlvvH0PBWkpV0cafj4O2HecZ7+Oty6qfmhARGM3kZa1
         p7ZOmr4pWp0Pn8BSw0u8zPN8lPfKGV8teCYTO+QJyFOyIFS7syKrR61hUIBWtCVpIUpZ
         qmxYiyLmmq85Scj/TiMvV2Mo6hWK6qpcxctzeicqLlPx0HXaFBZPjvP5CXy1xxjQ/t9a
         e0M3zxqHWsuwbMU4qtLQ5HFiDU4Z/0n8M7+BtnmJuqb6Oqgco//cCSmrP6qdvKJOKSK1
         o+XOY3Nb9dBIRcCwOE9B5ENJCsSnVb54HMoqtCEXtVqozrMqh+ZeifL+8l3T/aoHmmtx
         YkCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvQvHLRtuIFfAt04WfAhASWzknA5A6tPuKBPWXm6JhMHzrnpdV59KSxByikmN0I4uxpME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbl3tLooUen3OJ+vlijapgzkV0nQ2uHE5P6jAD8kr89Aiy0+cS
	IBGKXWga4eXzJp/xb5re/gtAzPXS0G8h3A+2CnXrIn2BbwsG4KrQKhkwYyzkw02vML9PJ5y5rTh
	DBSwtXEEBzyCXvQ5ewqw67eKmtC0cjdFPdKfz20BsadYfiKM4gaTI9UwZ/EUDNrJCzoNoZ7aeau
	tyJakyQLgA5EJq8uvWgHqxUwxlFUiZu1KqyVAv8N9kw25Oh0vrFBvM1eql4Wxx7bJUCPUiMjgeb
	5CB9i+KZyCuo75nk1XruvGqG34TM7nncAxfYl6U0HxeR18OEbOLiQbkT8jhxnebsJFHGrl0rISk
	VxoGGZodvDs=
X-Google-Smtp-Source: AGHT+IEBO9w0Onr42pZXXVQ1nY4Us1mkuXa5cZckql0YoiZJdiuobXjdgBcgLLhE83AzSML7+M2qIOUj2bM2TpaM2A8=
X-Received: by 2002:a05:690c:f93:b0:6e2:4c7b:e379 with SMTP id
 00721157ae682-6e3479c7bf6mr75758207b3.19.1728886944183; Sun, 13 Oct 2024
 23:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com>
 <CAOTNsDw58poRNMpKiCOTouH84ah7+jvMfM0OPj-Y02Bo2O4kXg@mail.gmail.com> <9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.de>
In-Reply-To: <9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.de>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 14 Oct 2024 15:22:13 +0900
Message-ID: <CAOTNsDz7Q=KrRgeV2EN6Y4WmSNdn7kF-4Xury8dbxEcbcoxBbQ@mail.gmail.com>
Subject: Re: Bug Report
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: =?UTF-8?B?5ZC05YWD5a6I?= <wu.yuanshou@foxmail.com>, 
	git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:02=E2=80=AFPM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> This bug has been reported at
> https://github.com/git-for-windows/git/issues/5199 and has been addressed
> in the latest snapshot at
> https://wingit.blob.core.windows.net/files/index.html

Thank you. I tried the latest snapshot and it worked perfectly.

Koji Nakamaru
