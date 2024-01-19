Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44256456
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704411; cv=none; b=aetZ0Ffv8+9LwL3RMAdeyjQTtWUWU3f7Woj481i4PYQZ4axwpGa4iCo4LlA4DpvKyLpU8ph8Ob2Lts3XMM+nEpoafEqdGZT1FChuxHJVXwB5ZzcBl0RbOCijphn+jucT6G1WW0DQCOv9OTVGyug6M8brv08166rsSHd9g9U8PDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704411; c=relaxed/simple;
	bh=wYlyPy7pK+jt0hCIB0DBEyvvnUSST+utUme0ZIXD2J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=df12l+PGmWUC2OnNSUjMKqtVDwWdDijcYhBvjFbN6+Z3NnCHnP4+BJKjOlDGSdKp/zqKh189IwbKL9msvZ8zrTU1xym/5nTZhRe22R2uY/23EjkSk65GLjy8rJTUABQr2o71PRIwyb7tx43gABNSWrM+xNCCVtYmRI4eYLsUbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJkuAF+S; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJkuAF+S"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28da6285c1so244694766b.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705704408; x=1706309208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgcLk6KiNoccE9zSTkyk80ngl3VZpdWeXlxOQ8XYUIA=;
        b=SJkuAF+SFexBdEMmlksoSnwxg2JWcsux70whHh0ww79nWq3DtYjltghJg1t5NJHx83
         e+staOSySgVzVB08hyBOI9qrDJWqi+lRM7S4WYPKtFit0cDSgkRgESQmBEnLS2vBOnO4
         K4XyDXZpLeOzb84teeAIbTPEcGqshDk041Lsg93zR/qJPqyHRAAA0Z2melzfbXyLPN+s
         QcHADS5S0oa/7rAk74r+CSQDZywMLz4bCFLo1mMP1+Nz41wjnAh0LD1CJ3PUAcqwh8Kb
         SfAguPQKEVxZoN/2UNh/hy19nMa8KzdEdkCkxcnuqGA+vBSJNIZxEHxVAbHyRihj3VKV
         jsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705704408; x=1706309208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgcLk6KiNoccE9zSTkyk80ngl3VZpdWeXlxOQ8XYUIA=;
        b=aDsFv5HkURfT3KKPzgLue6hIuV0Ptn8xVf6PJBIyS2sPpMNDrLWkYzUcm5SAUtD9oY
         KP55tkXdEo6nKCNAQ2HdqU8FndSWzZv30r/Zojsgnm14I7fsSjn0JWPfBF44SmyWt3A7
         toqXNZI5UGJnFWq7mSbTPNha+yf32ZGZvN29bn8602US5F0By5y4mEgpT/sbL7ABrnq1
         Ln6BIferdUxGgy3C1xFX2LccxzPEp1W5754JqRxTUYqI6nBSKv0DQHla0v6WjDVXERQk
         46JhqbheVoJ8HlyA1rbiQoQhZYPzwHPHh9QSgHfaixx0we3aX4C4Ib4s+1ITVPkGdUed
         PTMw==
X-Gm-Message-State: AOJu0Ywjo3dRaP4797r6aMb9E3wk+yP7D63TbPibwKaA7q3CeL0WoNHe
	rV7IC4A/iBtWmjlg6dLZDLuaRNKMXjQp9k2k+thyxteJ6jqso55vA+E24VY/pi+0pu6iZG8DA15
	McbkivPKZXbZ2Hdk2hH1FOuqh+XxTUOQR0tL1
X-Google-Smtp-Source: AGHT+IGEXZ0cGgONFduVt1k/wUj4E5PLSKUqXNLv6XGq6B2I6/ybjFa46Pswm6y1lCKDBBziyW//VGdbcL1rw2QsTXw=
X-Received: by 2002:a17:906:1da1:b0:a2b:f7d:5b5d with SMTP id
 u1-20020a1709061da100b00a2b0f7d5b5dmr1556082ejh.32.1705704408257; Fri, 19 Jan
 2024 14:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
 <20240119-flat-jellyfish-of-drizzle-b31abe@lemur> <xmqqmst1hsd6.fsf@gitster.g>
In-Reply-To: <xmqqmst1hsd6.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 19 Jan 2024 14:46:34 -0800
Message-ID: <CAO_smViQLmvPiLHn_Tjtp=Yfug+xDDdK5u7uh51FyJ4DFbP71w@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: update mailing list sub steps
To: Junio C Hamano <gitster@pobox.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	spectral via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: Docs: majordomo@vger.kernel.org has been decomissioned
>
> Update the instruction for subscribing to the Git mailing list
> we have on a few documentation pages.
>
> Noticed-by: Kyle Lippincott <spectral@google.com>
> Helped-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstContribution.txt | 5 +++--
>  README.md                             | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

This version looks good, thanks for catching README.md's reference as well.
