Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BA2F860
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252134; cv=none; b=gy5rYkw/svmdvJsD5kv02rGwllHVXmOBiQB7QM47UwSzaKvOroxR6ktBINS8wzA8lNgwlJX2rWJK4DIfb5DUXSYJy0TGFPToiJtxar6TA9NbRe4FGSU7Iafp+aCRWcW5+T/QUHbEVyLPnJZp7TMU9KiDAa6hP/y2Xar6CrmPLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252134; c=relaxed/simple;
	bh=JIYi2N0SJrVbrGnkkQpZWse+Dr2T9VFgcTtnzoXrY4c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZN1r+Mmi/bbrORm2lbvJ9SYc/5xlfwU78Gdhc7hKIxElS714WJ9YHXf4DBUqlItbkb1HlFQFseWzIGz981UpovoEV0B9rnMBEdkz6DsvzluCVf0mStbly42HJp4cQYHFVD8SF2KkThcYnRtFdQtkgh9ZBHso2g6/xa4JLcLLcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUpXKfky; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUpXKfky"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710f0415ac8so1366385a34.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726252132; x=1726856932; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFR1IWnO9w/CW+q+/cZQaqDN6RNgRrQ/qsaQNzqH5ek=;
        b=ZUpXKfky+PJb1rej/+wbuSFkeaffnz0lxj0VDVMpVSsNe64Y2MgY8yH8oLUa9JdtaD
         ZmPMB3VMmU2SWzxiE2G1YTqiFg5GM3aSZy/YI5MynqOPX+Yci6pUHFOMPi66MV5ilwXv
         UNhS0XU4+FSuNs2x4eH1Xe9CQZj2bkvY4v0qUd6rhR+CKBgBTkPF9kcuS2pYvNWqDp8V
         m79v/NvJMRyKK7akKuHE216gGe8P2e7JGw7LUiiWnTTQskW1OmkZrTh/mRi4uUmDS83s
         NNylD+HIhMukI5C9n8UPl35nzGEf8ah2WN1VRuLe/A43egXvmTs0klO4ktKtDOUKTpQz
         lyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252132; x=1726856932;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFR1IWnO9w/CW+q+/cZQaqDN6RNgRrQ/qsaQNzqH5ek=;
        b=HgPMWoJy5LZFttfFETjKv97E4fh7P1Qrp9TnqeDSRxY13gtGRKRiW6rFbiZ2yaq9f+
         C+mYZvhzDCuUgBG3lR1wzIk9MIvvAns0N4jiC0l+30N/LoDsY97CZO387fq568dfWrUu
         bNESpDCuwJNeh1AU2KYDtKDiTk/ZDU3g9LOOx07GnfyG2tm1hvVojTEpAX50Pzybaiqq
         h/zyGFeelHm+/oZjuF2BrolLF/yyEHIMEvpwrfIgeZvdP6/80KZAYU6SgUo6FG6rgNjj
         5L7q/ajfNfoIoP73227JyBO35+58Swuv93muWWGgndvEPSsSJD39lC8cJGS6ES9/pu0F
         lotQ==
X-Gm-Message-State: AOJu0YyYVN2HcdEp/tSekeb241pYHaKQiAsZ4DflJZPd/tfzURfsI302
	82+RZkvY4O6+zjKTCFhZBa6JQRQABQQwtkog0Vr0zGuekyjFREdFQ6LocQ==
X-Google-Smtp-Source: AGHT+IGUCcZJHxcyTiwRTBPeci27CcTC/Ggs6D1jjalskTcYR1IOuzRBYoLSK5Zamm/Jm7m+P0x0zA==
X-Received: by 2002:a05:6830:6994:b0:710:f8ef:6482 with SMTP id 46e09a7af769-7110946c0e8mr5112388a34.9.1726252131808;
        Fri, 13 Sep 2024 11:28:51 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:bf09:b97d:2d58:69b1:365e:5f42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710fee7f075sm1275991a34.11.2024.09.13.11.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 11:28:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Stephen Smith <ishchis2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: SyntaxWarning for   '\S'
Date: Fri, 13 Sep 2024 11:28:39 -0700
Message-Id: <C7F37713-E65A-4200-A810-C71CFAA55926@gmail.com>
References: <ZuSDQPssBOujNCrF@tapette.crustytoothpaste.net>
Cc: git@vger.kernel.org
In-Reply-To: <ZuSDQPssBOujNCrF@tapette.crustytoothpaste.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: iPhone Mail (21G93)

Given that you don=E2=80=99t see it and that Ubuntu release is due a month f=
rom now I will see if it is part of the update.  If the fix isn=E2=80=99t pa=
rt of the update I will report it.=20

Thanks. =20
SPS

> On Sep 13, 2024, at 11:24=E2=80=AFAM, brian m. carlson <sandals@crustytoot=
hpaste.net> wrote:
>=20
> =EF=BB=BFOn 2024-09-10 at 03:49:33, Stephen Smith wrote:
>> When compiling Git from source on my Ubuntu machine I've lately been gett=
ing
>> some warnings when the docs are built.
>>=20
>> An example of is:
>>=20
>> ASCIIDOC git-sh-i18n--envsubst.html
>> <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
>> <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
>>=20
>> This syntax warning shows up for nearly every man page or html file.
>>=20
>> Is there are current documented solution?   If there isn't a documented
>> solution, where do I start looking and I will craft a patch and submit it=
.
>=20
> I believe this is a warning from Python about the asciidoc program
> itself.  I don't see this on my Debian unstable system, so it may be
> that it's fixed upstream (you can check at
> https://gitlab.com/asciidoc3/asciidoc3/) and if so, you can open an
> issue with Ubuntu to get it fixed.
>=20
> If it bothers you, you could also use Asciidoctor, which is written in
> Ruby, and which won't have that warning.
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
> <signature.asc>
