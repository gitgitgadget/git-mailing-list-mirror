Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218032D5B2
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042406; cv=none; b=S8CSe94bNvV+6nUf8IGSPsQOAw8fivoY4cMsol5jQrlCtlHG6f41vy0P1Ok3cw6DK/75dowALSb6LU4VGa5Z0hNKf35tt2H5az3h6NzRCrpDHul8eOnRkdfj67gnz1KvAvR16R7SefIBueIUE3OrpQ8bhzaTT/ur/l+POLYvTkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042406; c=relaxed/simple;
	bh=n55NqjB34FT2l0Nsl2gVDBuC0xnv0KSv4ScTfcTSVcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhcuZqjKfrJhPnsUHdxYhFkAsOtzRIkd54x40RpHyyAToO+LpBSXu6ADcQIJL5QnqR3KusDacjt2J6ktCDpnf1B/ecvao8fo8jurqpkmhoKD6bMC8tM640nMXcIQXl4tU1zHVdfx6zKoteIHtAydVrRnWGc3ety/e/5BFNqdVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny0uCwlN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny0uCwlN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f1987d547so3727660a12.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758042403; x=1758647203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n55NqjB34FT2l0Nsl2gVDBuC0xnv0KSv4ScTfcTSVcY=;
        b=Ny0uCwlNMzddANSzSLuWztJ5rCEKzfvN2nbz9ho8IcuoOhLUbs7/nNZoBgG/ZOtZFp
         AizmWOZ/wkzfZ26h9IfDJdBPesHQzr1YQumjxbeeK1Bepeg9fQzkD9DbMwj8MKeh9WjZ
         1HkScgWIiYo6eYs5ExcfB1pCuol5Q6gWncIurjXIHUnR/hfIgA0uuJ1VgCDsKzwUciPm
         P0v+KgH+Pb531NNZTP3f0zmpB/PIVQAMUdUHkJa2g4sxT5j94nOO5qv5evHaBruAhPiD
         gdNlC/bUxhftzmOFA+DRv2HDc4Ps66RqD2WtvWOYB68ueaHmdYseqLAmL8fpMvVfwpqg
         J/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042403; x=1758647203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n55NqjB34FT2l0Nsl2gVDBuC0xnv0KSv4ScTfcTSVcY=;
        b=kQQ/uvhhOjXq5GidptR177mMfaZHrF0xAint5AxhpECxfRjls+lBRitFjOyRAgYqb/
         WKgFZPfWqs88YEdbmFHOVYEKJYfk2wEFlaAIj4ayq0o6Ly1NwSExDdlU/fagZiUUWBSj
         uoXkoOLuKxyzul+gy75kzMja89c2TFvzLMbh2E1+Ue3N/2cOL9hW4WTmFwGNITrnXlRR
         5thOK2p5oZsdtf6Rr9Tc1pKxr9mZ3kGzJyqgwICfbgwb0dTOUalqmSrg9/FgdCKtUu8F
         bFC6zmRzrtU6D9+K27GTAiogTb60zDNsfilqO2Y3jB54n6qD77T5gfiG5ZuoOC0AmnAX
         rBUw==
X-Gm-Message-State: AOJu0YxPIBakIfcX8sMcL4sKLe/OoeHizjwB1XmqvbyKep7OEoK5z93E
	L/LCGcksdcKBdYcjE5jdDvTHdZLc4h7wTotWeQGo07PsMIs9OixOqArs7YGMWOXE6gL7xNtJfhg
	7xfFV/JHdVdaDPkyX6afviatQLnAoP/Et6E0I
X-Gm-Gg: ASbGnctl3b4BlpbIJzh4yFCsK2CQ2HPz7Sf96bNFtaAke8LYO/OyH/1uOkPEH5blmgV
	AroCMPr/MItWNklY78YEZaq0DUflXSLGoX/ql+nhCe48ocrByb9Lj8vWFJi2xRW1yr14QZxjiOj
	yX4TU4+NGTyZGxpz9vwpW7pjksxgbwEKcqJvY/3j1JeAhsdudcZ6lLbkB+/qyS6Bb6Ch0lgIVcx
	kU1lX+gq+Myr1+0wcn1m+BsvYbbVHeImwh2gg2dVQ==
X-Google-Smtp-Source: AGHT+IHV71vQBMsGzOUAAfcAALpUrxQr83ccD8vxpKzesgUGjbJC0t4h4SFpS8nAQp1yMABHusSNfSb46nFyX0sIU18=
X-Received: by 2002:a17:907:2d14:b0:afe:7fc2:e383 with SMTP id
 a640c23a62f3a-b07c353ea03mr1612092766b.1.1758042402967; Tue, 16 Sep 2025
 10:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
 <cover.1757982870.git.ben.knoble+github@gmail.com> <4736597d-1144-43ce-8c09-e78e4563765b@gmail.com>
In-Reply-To: <4736597d-1144-43ce-8c09-e78e4563765b@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 16 Sep 2025 13:06:29 -0400
X-Gm-Features: AS18NWD0ZLEf_CfXcTFnch4p3LwNoP5W7jgoZwn33bk67svK9zIwq_8Hw43M3pQ
Message-ID: <CALnO6CCpcy2E4Q4u3+fVTtb3iNOCPUx2fdL+Lgd-+vWhptK2EQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Teach git-stash to use --index from config
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:25=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 16/09/2025 01:37, D. Ben Knoble wrote:
> >
> > PS I've left some new t3903 tests as copy-pasta for now to get feedback
> > on the rest of the series; there are bits of that file that could use a=
n
> > update to the modern style (e.g., not using "test 1 =3D $(cat file)").
> > Since some new tests are substantially similar to old tests that use
> > this style, such cleanup is /probably/ warranted but will delay eyeball=
s
> > on the core of this series.
>
> In situations like this even if we don't convert the old tests, I think
> it is worth using a modern style for the new ones. Some people argue
> that the style within a file should be consistent but in practice that
> means if someone decides to clean them up in the future they have even
> more work to do and in the meantime we have a harder time debugging test
> failures.

Agreed=E2=80=94with Junio's "mostly good" downthread, I'll work on a v3 whi=
ch
_at least_ does the right thing for new tests. No promises on the old
ones=E2=80=A6

>
> The cleanups in patches 1 and 2 look very welcome. I've left a comment
> about the tests on patch 4.

Thanks, will look.
