Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDE229B38
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729170; cv=none; b=lpA4q4YECpqGdaSsfNlris58oWdNpfSrnOpoL/KAAgBOrYZGV01+oNNpuoqAz31lOqBl0O9jV88IpAgCZemIu/dmR0hqMQo2S3UPB503tfjj+okNsa2wlA5VSrCeSNFa+ynHpfPjBnXHRiZiXChJsFsX6TvYlCb2WJjswAwj3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729170; c=relaxed/simple;
	bh=zQKS8GermoZDDHrP4mSaj0B2KsFMSHfPkLt6pUmvd84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwhB2rJhQecr4iaDg+OktgXHz78whQu0RePCOq6mt5S63eFaG6MhorugSWCfkBScdrneFlTBN6ln1yLRbMSKo0PXAMbjXlpi6Wn4c18DS+hj/P6dqOXWCC30unnX6zbRSiCw1jIt+aX8eTHHsBw89hl13rUtG4qpvM4qAvOD9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+2JE2BI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+2JE2BI"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78fc520433aso15355747b3.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729167; x=1768333967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYaTx4OR1H1ddGztluqtmoI+6ecyft2mP8p1fRDSKow=;
        b=A+2JE2BIR45qHE/ZSY2CfaVwFQZtf+cGIjny6zML1gw3qk4/GOxPgFc4lfGFTdf/6j
         ZhYzYVj7qvDsBeWA+2vMFe26JBr+EPepBw89jp75nF325xv+3BzjPF1hwadGyFRXgJTX
         swMYSJ6lKJjvWjT3u2Y+nBIezgz6E1Z/n4q/Y5fAfLnfPGvOtF2mLZQat3oGyX9Grjcc
         ePbsQWbG6muyQdlUN47xMJ0wpDACzYRHs4mp0IUjDaHuTgQ+HD/qdgjN6trdscNl4V7T
         BtsXSMTi7z68nNcRl0muZdRkawkef+TsWE+H0nFTpzne6th7Q3ot1RIWC4/pgyC2VhRr
         kBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729167; x=1768333967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYaTx4OR1H1ddGztluqtmoI+6ecyft2mP8p1fRDSKow=;
        b=LEpycjXUH2hnqEJPVudxkCb0LkX1b0HNQlHgpqCJzmREX3vVOpV6Z+x7uaipH9+aVO
         RhPMydg9BMnFiZjFLHueRNG4V26yZrdulxu594uhuMujlj9onBt2/Z1bzPEcxUKioL1N
         TOcPLDfdihfX0qJleDqg0Q7nmbsOAcoKSqCUZBHoTkCAHmCkt8caRWNYraa/dy41avOT
         IpvDGK3PKHTTbANQMieOuFLKDBgxxF0BsdQafGv0/WSGUnFMusCEmOhMZYOVtmw6eWpx
         gWk0D47hkW+NyhoHolDyu17uVj0oTp33S+TIW4WuCfGMKblLAdEKjKh3fE7kdfcKtlA8
         nbVw==
X-Forwarded-Encrypted: i=1; AJvYcCVhogNGPAhTH+VgmGjxo52pi3BNjpeTErgzP69qPic41C8PV3jGQC0jgZoSUVEEklp04yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyhxNp2sr38sk4bfNlC0d00YbiYgQ8/r3ZASCcBvKaTxa16Zy
	28O3xpuaiYxqGd3IH6l1jxQaC1Uoa5MWiBHNkAilmzH1bC+Rru61t5/qMbe4NbriW6h9vSmbJpu
	ccgu1QnrWu5pD50vAzy3ocNjKn1zHUQc=
X-Gm-Gg: AY/fxX7rWni5pbIDfgyHN39gCwlDCNPBLehtL65pUUVZJubtLdvUDj9/pmmeMAV0kr6
	NOwvtUElAaF+0vTJ9/8FaZz4qIVlkRod2Yv8+std+28XkAcGDE6LFgnvbj0XdcMG5Lv4F3G7tWn
	NzAC3hWan3EYwiVOynf8kNG2Rw3w+rNcFnjwQ7sxKsSTuCro0kGau5OlzWUqYE0pBcX6t+gHZtr
	tHSgHzqor6/vPjGhgO5gdv6VCrBAlOp+hZ92GHwIIUh5sKokwGG1YvD1CZ0/9VEMQ03eX5vI1y+
	VSLFUkA=
X-Google-Smtp-Source: AGHT+IGzqTnuN1NYl+APzKNRBw4c3tddEF9CKaZ/1IpnHXCwY+gNMRO8kiXvnW9MbqNtjJqYULehNfI/lA+UUKVSykM=
X-Received: by 2002:a05:690e:120e:b0:645:591a:cb6a with SMTP id
 956f58d0204a3-64716c753a0mr132338d50.70.1767729167512; Tue, 06 Jan 2026
 11:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com> <xmqqsecmnl3d.fsf@gitster.g>
In-Reply-To: <xmqqsecmnl3d.fsf@gitster.g>
From: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>
Date: Tue, 6 Jan 2026 14:52:36 -0500
X-Gm-Features: AQt7F2qstly95e1fGCxVNT0L-sAU917QsOGdwPEdfIWwINKbkBZkktaduhPe8fY
Message-ID: <CALH9GrYpWG2WPM76WDFnK-tFFTFtg3hZFLjg3z27gOYKeXpmxw@mail.gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
To: Junio C Hamano <gitster@pobox.com>
Cc: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matheus Tavares <matheus.tavb@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 9:54=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Matthieu Beauchamp-Boulay via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
>
> > From: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
> >
> > When reading exclude files, git assumes it is encoded in UTF-8 and will
> > fail to apply patterns if it isn't.
>
> Is it true?  I thought we assume that the exclude patters are
> written in such a way to match the encoding of the pathnames,
> whatever used on the platform that our calls to readdir(3) returns.
> Some platforms may have compat/ code to convert these paths and
> force use of UTF-8, but please do not write such platform local
> conventions as if it were universal characteristics of our system.

I believe you are correct, I wrongly assumed git would always
manipulate UTF-8 paths.
The revision will need to take the platform into consideration.

> "ignores" -> "exclude" on the title, as that is the canonical word
> we use in the codebase to refer to the ignore mechanism.

Thank you, I will update in the revision.
