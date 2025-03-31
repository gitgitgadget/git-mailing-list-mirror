Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE4213E60
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743444897; cv=none; b=UF+sTqvf/QVaooIPg5rdoNN/yuuWgaqmsxGHLnxjb60GxcP+NhFDmnOAHYdADs2LnONbvlXcyPIYS8QJMe4VRUMXnbRkYac0Dh8foWfRDRjqgCmfVRSFmWVogFrHCm3YzV0IHtRobL3ptgv8nmEZrat9k0OKu+/DBSfWarm+Fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743444897; c=relaxed/simple;
	bh=hHuBd023t7plc+4DTOuoz/Kj70pebtWPlGboBqbZwKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRfFmKxY576rI+jKA4rccekgJsDH3MM/dVcyFl7p3bpV3q/EozmuvS+w7bCIemDyUtVriQjHBkTBzMVizL1NHnzNEvUAUCNQ/uwgiLhbfnPkeBW8k8kENKcgae2PBJZC/vB3wydX1exseI1XmngzCaac0Yd+UodhkFoZPq/JySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6taErG6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6taErG6"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85ea482e3adso52727339f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743444895; x=1744049695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3owHpYPHckykTnmtv29CAyz+luvL8Gy9sQ76VfQsRI=;
        b=g6taErG6nzvdHt9Y+lwBhnoyxHJLi22WhfFj3tfrUZdInojgnTye+DKxDFTVvh+Kel
         KAGgMDhdkwhS6E2c8AJSfmHG6aRGHsiGBlx86iIV9KlJXKVD+yPGXyeRAtZElvARUzes
         qCkPAMgPSaSINX2++vfIqKkjvKLUkiypNbh6dKtGpYI5O5byIbmHfWSYJFffgkDAW74Q
         4Qp/uNmH4F2LogQEc6bcWRlnIIfMWw/Ijk4bxwx8DgMCJIpYVrx6MgXHTlY1Ucd0Ey5Z
         KuNRFcJm54SJ4I4FGuJIOjbYXdfda+lJ/p4jUkEcWfyA45+9k20AQqVWJwN/N1rzBYti
         VUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743444895; x=1744049695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3owHpYPHckykTnmtv29CAyz+luvL8Gy9sQ76VfQsRI=;
        b=SAt1JG8MDJjOMTQdwMXvrMXwnLgYgHMFV6rwlqwAJaTCfDXTVPChfUSX1ztNLZjLZi
         BMcdYLlVRZcWl51XC1n///bkI5j5Ihfgk0JDWBAdA5hf+YD0JUHB3mQzmsZOQOsnVFyr
         zVrcfq3LrrRHXWUlxpDRQRbE13ds91Sx4y9TofSew/iaSI877hUlPePYE9j/hIvb/iFH
         KnN+ri7fDXKJuHXjGCjx4Qsa+gaWVBwmxi26HRPhtTpFyj5Ml1brM6Wjdr9bD0PPTYs+
         /JnO9PqFZB5lrUaRb+aZX5Ahb4Sw+0mwrVPsTlAacZNCT/8pybEo2DfHV4+6yriWBg2A
         KY3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvYdxFG4RZieRM1uhp4ggkRXmn6YdeJvgwqXaEPPB98+gIs+p5PBU9I94Fz7xqnC5ohUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpZHXzTSeHzqE2Pc2NgPoKBoPb4kW5wRUW6q9r+3dlB85mdAy
	slqkNr7DKDcHtVYu1W91bDnayJi+DycF7DHHT6Cs69lKJy8u1/xvqxVgBELrs30DJs4vfqSTvPE
	7h+KP4IHQ2Ky6u9uDPfS55H0qTaY=
X-Gm-Gg: ASbGncvMjFkT4nZYi9qDVALfvodNZD5jMgmZfzLb3Mt/QmaKmxZt3f6VYX7U0hGglKv
	qkiJP8o0zV8gs9eWa8ePNPtdEKLSonjDpYhG0iWMd+Zy0pTu+pkT/ojyhlClobxcC8w+Be/o88L
	xvsZqbkHdTvVGmPCAlU1jeu1UH1V8=
X-Google-Smtp-Source: AGHT+IEm9fhhWRZcwO0oZjvfp2VYcGSPKAR3CxeQ7PUfAG8vmnP6PPv88U19xxEN1BPZDqD/f1WedZDk/fIRV7BQ+40=
X-Received: by 2002:a05:6602:a00f:b0:85e:22b3:812b with SMTP id
 ca18e2360f4ac-85e91e74850mr1057477439f.8.1743444895272; Mon, 31 Mar 2025
 11:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
 <0b6bcd225dc1444f4debe5fb8c499c6cad0a4ab2.1743436280.git.gitgitgadget@gmail.com>
 <CAPig+cSJ-3CXLV3dEhN+B8k7COQNW1Zm2ynuZtmmspzXsjp_PA@mail.gmail.com>
In-Reply-To: <CAPig+cSJ-3CXLV3dEhN+B8k7COQNW1Zm2ynuZtmmspzXsjp_PA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 31 Mar 2025 11:14:43 -0700
X-Gm-Features: AQ5f1Jpiak8zgGEhaqYksqPL2RT3TfbDalhhHAFjMaJ2Oz-qyr-ObpRvDBAsMhU
Message-ID: <CABPp-BEm-RH0N0bxtfp0yvaqbuiqFPBEQEuzWYov2Qv7+8X7qA@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests: remove GIT_TEST_MERGE_ALGORITHM and test_expect_merge_algorithm
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 10:34=E2=80=AFAM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Mon, Mar 31, 2025 at 11:55=E2=80=AFAM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Both of these existed to allow use to reuse all the merge-related tests
>
> s/use/us/

Indeed, thanks!

> > in the testsuite while easily flipping between the 'recursive' and the
> > 'ort' backends.  Now that we have removed merge-recursive and remapped
> > 'recursive' to mean 'ort', we don't need this scaffolding anymore.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
