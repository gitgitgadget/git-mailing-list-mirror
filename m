Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F03002BD
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458904; cv=none; b=lpPkb1KfrHbVRCFMfkfGjVa7fSvD1eGq/bA41TvohBAEG+gzruy6MPCRHXnQEgYD/3Gc2NTMuRjQ2A/+rFcEyj14A80ZPAEG0YjtaB4Dg/eOKokPw4PSrG2Reyimih2Pi+fJLe1MPwB2IZOis879iVH46ojlX3CPCFj86BY6qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458904; c=relaxed/simple;
	bh=xb/yNzZCWGD4HJSwP1pFXK8Hauisy8AiCD29AUvl/kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkd5xfarzDkY8N5SLTzAhyuFqiKwbID8F1NDEQotdw+jRWoHlNfWz4hASJEPTHgGKLY8IkGpV4LBVeoNcYuHTaPLNJcCGky8YuUXspLE9p8hEe8ZCR4wcn0e/ztHh5+WMNIUogEWMCWoaBcNcJ829803Mh9ol7BPVNyob1dCbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb+h7COh; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb+h7COh"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e30a19da78so2991589241.2
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760458902; x=1761063702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb/yNzZCWGD4HJSwP1pFXK8Hauisy8AiCD29AUvl/kE=;
        b=bb+h7COh3KN3zUVBHg8gNxv7fFqEPyz2iepsQSmiY4L+71Lp8ZyXfPVdxCVtQITzKq
         hlfJgVUaxrgKd1Y5ydJjc4Sfqmwv+sX0AOCVi35Ie7tXqs/8fya8RL9ZkLzzhjJItTFt
         aBSDksf5TVtj4tm6CtJqVsmcBAbsJRXNMyeRMmW+RFvb5bF9sserpdcZUYxQMIcupQUB
         eB9KWXXZBdA5GPlrFuxNPLuw+5ox4SeVWVGEApqEtu1kf6PVtwd7QCVy7Crt+l6u5eLG
         1r/KY3jedZu3Nh4TJ1sqvdHiByqVKJ/JyjZ60/mBeadTm4Rn7Q0rO7KyXGM4HHEIpJyD
         GRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458902; x=1761063702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb/yNzZCWGD4HJSwP1pFXK8Hauisy8AiCD29AUvl/kE=;
        b=ET+52cYnaLOKOJsXj8f5FD8qaMeuQQaCJTSDwY8WFKTVu4ecW2VtaKcG5Q3wYks92F
         YrdBhMudSDYigsa5qmXIMFqdDucvaoHbSEX/2Fut6xsHhvHtmwQ0iGALiDBCuO6/YERl
         P6mqwQuDG97g1qPjbY7mDMrTH7Hf3w5I27O7Sz4WGFps3QvtLLVPZ12s/rKuWJKkVNi8
         eipbmMsQKp7q9ERB2YfMnRLHpqupfq+KdgF8mjCka5HrVXsrUdpDTf/guttDDnU66uPg
         sM8yVIJSLIy7HfG0GuzrdJwAJXhxxlU65O1l6IcULJnsPYai2eX7bJGt6veMd6KFqueu
         LLHg==
X-Gm-Message-State: AOJu0Yw6kTqLpTZ2uMA3Y1xi9YXfJuDyWmTQNEaoZ6Gncp3SOGo4kRya
	9ZAPlPWhofDhaRCl1dqCYX+m5qJ505XP+KXogOtsBmQgL1q3vfX2pl/UdpcxOCrWskayuCdhQQo
	cCrzINC/cbX0dmIry/264NW2AVIgpfPZgdvHLseF1kw==
X-Gm-Gg: ASbGnct8Erm/dxjF9tAReHcsYiKh4z8carhoNR0gcvZygpaLn6/1OzlCWlHxSyNQQ5k
	RviYhAUM+6CAcmHdnPsL5YlowUTyGn5plhc83VdFSn4FOnO5vq4B9CBIKz9NPMiH1MhAL3HkdWj
	oSXsDwU0sqIW+r1CeVPhfG1zzzvNCMGVuVi5whLAxtu4tF/zheGT5Us7EENuJVf02vxO6sh3ao+
	0hAgn3CU9jsaTNsNdQjQDDJOlENje29HzwhoKTFA/8+z2keqm7JBMY5cA==
X-Google-Smtp-Source: AGHT+IE2NZ12Y4ZpPb5zBvwuVPq17WJohCs5R9i+8/TK1QNz+xM/GtQQDSGyP9VjbnX3gdd+xAFTAn26T3XaHc2SnX4=
X-Received: by 2002:a05:6102:3a0b:b0:5d5:f6ae:38f1 with SMTP id
 ada2fe7eead31-5d5f6ae3f4bmr7070453137.40.1760458902084; Tue, 14 Oct 2025
 09:21:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALrKrsRS3ezovHJsPQqeUb=3=uQ65pkxczP35UFnNd4WtXnv8A@mail.gmail.com>
In-Reply-To: <CALrKrsRS3ezovHJsPQqeUb=3=uQ65pkxczP35UFnNd4WtXnv8A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 14 Oct 2025 21:51:30 +0530
X-Gm-Features: AS18NWDccjbERnI-YVaEyeNPnNUv4T87QahdAnFVoHmw7jnO-QefmGcaxzDSi4Y
Message-ID: <CAPSxiM8FsjRb=NqtjWagROSC3Gn9iSx=cfnuo0YO2T+jPNeBUw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=28Outreachy=29_Introduction_and_plan_to_start_work_?=
	=?UTF-8?Q?on_=E2=80=9CReduce_Git=E2=80=99s_global_state=E2=80=9D_project?=
To: Queen Jessa <queenjessa34@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:37=E2=80=AFPM Queen Jessa <queenjessa34@gmail.co=
m> wrote:
>
> Hello Everyone,
>
> My name is Queen Ediri Jessa, and I=E2=80=99m an Outreachy applicant inte=
rested in the
> project =E2=80=9CRefactor in order to reduce Git=E2=80=99s global state.=
=E2=80=9D
Hello Queen,
>
> I=E2=80=99ve gone through the =E2=80=9CMyFirstContribution=E2=80=9D guide=
 and explored the codebase.
Good.
> As a starting point, I plan to work on a small refactor that replaces a d=
irect
> use of the `the_repository` global variable with a function parameter
> (`struct repository *repo`) in one of the related source files.
>
> This will help me get familiar with Git=E2=80=99s development workflow an=
d contribute
> incrementally toward reducing global state. Please let me know if anyone =
is
> already working on a similar change, or if there=E2=80=99s a specific fil=
e you=E2=80=99d
> recommend I start from.
There are lots of files with Global variables, so your work would most
likely not affect
others. As a starting point, you might want to look into any file in
builtin/. You can also
look at previous patches around the same issue for reference. One is this [=
1].

You can also go through [2] to see previous microprojects done by past
 GSoC/Outreachy
interns which might be easier to approach than the above.

>
> Thank you for maintaining such a welcoming community.
> I=E2=80=99m looking forward to learning and contributing.
>
[1]: https://public-inbox.org/git/20250318115912.2978992-7-usmanakinyemi202=
@gmail.com/
[2]: https://git.github.io/SoC-2025-Microprojects/
> Best regards,
> Queen Ediri Jessa
Thanks for your interest in contributing to Git!
>
