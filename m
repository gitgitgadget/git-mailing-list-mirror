Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CD1339A3
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208760; cv=none; b=JVRqWqlUgcw6jssUH9iqT+RPcTBcmqS9HJdkt3fv0Kfm2JYMYh/4Ix681IttKJgWUPHzln5iSp/PrHhQH30DMTrthaM9d/OHVGhpIickM6t0qdGDckZDQrSKf5nOAGAR7Hsh37ulPdt9Tqz6RpkhOFhZo0dvjVPAAkndD+q6aGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208760; c=relaxed/simple;
	bh=FQl/WEz7Az8oeDf/MS25WyfWu/OPZyB9LbgwEy/9H6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4lM079ne8ucx695Y2q47+AUavUuYm2srRYKiRbYajb9rZUNGFQe6425A0QYXiR/F5kG1hzIHmjlsUrtaDZjc3PePS/5ajRLCj1DE4ngMFc8Bc1pb4twChFWHtf3uarL4YEFNpLGLgeKGLQQ1qrxKa0DgZE2LSipqUlY5DTjQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaV1jfcH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaV1jfcH"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-510218ab26fso841022e87.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 10:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208755; x=1706813555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3QDy0iQtZFqBqpD/+j4BsSbkv7mx4EUn2/vrPwJKzE=;
        b=WaV1jfcHdNrfpMg71sbzCS6xh2KkiDPFsXIoGBFLQOJaywEnjAM7ZW5C3KCQQDrapE
         tzmv0RhVedaNu9QDiXc+DLjnwVaff8s2AgJWsA7p78Oefm4sWq8Bl8F02AvrCquggVS9
         tIfAHdg1eavlV0HiWji7r+0CoCAG/jf6uLDfwuZmWo2lIhnOYR3kPX1xwsH7Sul2E+Q7
         mw2QUX0ZThdIkh1576CJ+zgOsX+zROpZcfJft2jf0JZs2WDlBw5J66HofSFxMsof8QcL
         muh4PDVuQau0ZhIbikz8v0zPfEFSZRthhhkPZLcyPd+RmwayiQO4hyKZts9866ZbAQlb
         I9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208755; x=1706813555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3QDy0iQtZFqBqpD/+j4BsSbkv7mx4EUn2/vrPwJKzE=;
        b=QfB4ScUSxnuj+Tz/UpW5cAivhatu7ny5/hQt/m5g5eyF8pofKbatKXSan0MBmkXp5C
         oXW5LxiwrKoYZXR6ZyX05ZBTGEPZPIuHwdwO4wu0ltARXC6lHGUjlHfurvqhUPjYfgkp
         goox1kc9I212TRXzjyVEbx7pAlG0e6XBWqPtlcmk9NOx8K0uC2PFRlGmTNKH++qjvGAq
         vD0seO8MWLbmtXwo9FqHuWGrgZPpuVApOw5zVYWhsCD2m3vjFbOsKGH23lVZm9YeZT+4
         KanLymjEQQwGsRox8TPitDdyTYIlR51pbNBzsVa9yPh+Hhq/aC/P68tBOJuPut/cS/IP
         hWag==
X-Gm-Message-State: AOJu0Yx1d9OeKUc4ck6GHJlVh3fko6DWnzehG1DjkI1FTmk+nT4HF4+i
	lO9N+y+mcabzdc+JABt2jMGM1lxRe2r6hkiYOdIZSOAMVHJvZDitZu1cKTLS4kKsSDQxx5etw/R
	18xXMNrjNIH1St5KfHnrR4MgxosviPEQvAEU=
X-Google-Smtp-Source: AGHT+IH0+HDqSBkPuEoYqc9WGxxGM+UxXrmcXQ7tozi2snPNAy1MZ9uk+a5eXneU1IpE1LyIsUYkbTrxa+vRS+os210=
X-Received: by 2002:a19:ad02:0:b0:510:189c:2d74 with SMTP id
 t2-20020a19ad02000000b00510189c2d74mr238724lfc.66.1706208754555; Thu, 25 Jan
 2024 10:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
 <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
 <CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
 <CAP8UFD0M_KeUTHthQ6n_a1KbEvuA1gAsE2jKkAqd-4twjbpNWw@mail.gmail.com> <xmqq5xzhxta3.fsf@gitster.g>
In-Reply-To: <xmqq5xzhxta3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 25 Jan 2024 19:52:22 +0100
Message-ID: <CAP8UFD2Oo8v8Qn0JPYURZA_s7ynZmk6v30b9zR==MxWBTXk9Ng@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Junio C Hamano <gitster@pobox.com>
Cc: Zach FettersMoore <zach.fetters@apollographql.com>, 
	Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It seems that this topic has fallen into the cracks or something,
> > while the associated pch looks good to me.
>
> Yeah, it wasn't clear to me that your message you are responding to
> was your Reviewed-by:.  If I recall my impression correctly from the
> time I skimmed its proposed log message the last time, it focused on
> describing a single failure case the author encountered in the real
> world and said that the patch changed the behaviour to correct that
> single case, and was not very clear if it was meant as a general
> fix.  Is the patch text, including its proposed patch description,
> satisfactory to you?  In other words, is the above your Reviewed-by:?

Yes, it's satisfactory for me, and I am Ok to give my Reviewed-by:, thanks!
