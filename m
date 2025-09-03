Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367D2D4811
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943339; cv=none; b=NqpPIuBGu3RJn6YkM1l7NUY4zVr5DYtp1d/rJx2qN0ouu3TR+Y+cW2YXt4heq7gM4WHVNN/CStxnV5x3PR/4QcQPYZpWmiHLuIGzeKy2jZxmuZPVJcA7sHpsuW7eNguXohlQHm2KuHJNSDtSMw7+acUp0XywMwUPHbnyPhGzYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943339; c=relaxed/simple;
	bh=WV7hzUlSZi1Gej09MtNMTsl1yqMfyQXLTssbPCC0cqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvM+yUS3Y4i9Gx6QgcLvxbrXJ6zp591UmwkmNFAwMvdiv+dilIWs6gHj1q4JNBue6tH3YJJV3Hqa3H9TDBL1+zuvTI5UlmqRQRY+l6J7smLcyVtaT/namuHAQ+aq7/XJ3/X1Up00VfAMle9BFvHQ2UsMhmYbaemJwGNmI/z19jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njQOuRvK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njQOuRvK"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b047f28a83dso30347166b.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756943336; x=1757548136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2idWtes/xzn5hEHDp89VViggLRuuiPtAdTqNLEtEZxg=;
        b=njQOuRvKd9k1Hem9YtExqlAIHvwWpLp0i43naytEUPlWnsBpO6JNibOQmRBNvN5I1k
         5kcbxoHQE6rTIM0vsJrGL0FCFibkv+var7VaMdppZ57rSp0TgvUYnzyioMYaUpJXHOt3
         KzJ55oTVRNBhbgC5LxYN+h0Vw7kd87fbThoy6sDYyC5CNGyBnI5HAbKC/ZUg8bzQ780r
         5IT6AD58zVBn/b6JXsKYswSJVN2d0ctPTZRPnVFVFSfQy7Z80tjNQE6oj8X6QdxtdFJ0
         wVE09hpIQCNMZ4CxuoCMZFDZV85JcF9V1pCNWfvqnABXL38zsX45yiposlU62RdYmQFL
         1+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943336; x=1757548136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2idWtes/xzn5hEHDp89VViggLRuuiPtAdTqNLEtEZxg=;
        b=dsTtdbT8zvoFyRtW9tc0cbQXJ/jukKoi11kNXDcB7KM0m47Lj/QFDEiIDeL36j9EtE
         CDUC7XfFzCudQstCl0X4K+dS6xBvwE3JcWlKEv1NxW0hQIbujedaeY0XSAKKk4izcU+c
         pFzkF+owDsfQGeTq0wcoTJ9LhIL5USUPLzjiy+vRDwt+1cA/7vtIPDVDR5q8mw/7dTm9
         pmX40HOf2qVSOs0TJI6atBFk2DzuzLOpWmkBz6/apu7tacGsfo+GUm+Vnq2mPu6nb5xr
         OWLjToIEjTotOpKGwsvqTbj2jDy/FdHgxCBerVAO52CLYtbDMNoktv1AjN8FMVzH/rap
         qQvw==
X-Forwarded-Encrypted: i=1; AJvYcCW1k3iMkxD8amnElk//SRDEKG3F5ue5vHh9rAS08nzyEWuYsRNOOcmH/yNGQhyBH9jl5WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81q8cGCijhV7YbxoQqru7uE3UTZl3eWWAU9iEar24fipU5nax
	sRaMR5CyfUPdlRjJQS2K4gZ5d59ZBGDSy0MmNSGiumLrUNCcRmlKzSYJWtpxuhRJymMOpNso43V
	2/aS3PIL6YdVOL9Ks17bcIW0KB0HOT0w=
X-Gm-Gg: ASbGncthOV+iRndI3V5BaJJk5aeXL0nX3WLWG7ZAQEG0yMOTJuzDMU6b87aemGBTx8F
	JdOx9nGgXWHGp0HUvdaQqCvohROlwG/lie7JhUcK5a+Lk/0yMIlEpLIk29PymcLPVQhSbpXQfSF
	/tgDk8sEzDK0Po3fQyKTL4K545otEDlrQnTnWsWkpYJ05mTVQsRJ09HsrCp4P5DnuC6L3c00BMy
	i3zBwJ6ADWzr8NHqc99FTinGsDTXNmHTzx2DT5D
X-Google-Smtp-Source: AGHT+IE4pJbzhLUcXFFWAqUmjR/KlTsqb/liC52IUPLv8KjOVt7vlZR6872V1F9+nsIGxjjhUWhl4djzXcmxeDfBHsA=
X-Received: by 2002:a17:907:9444:b0:b04:53cc:4400 with SMTP id
 a640c23a62f3a-b0453cc4661mr902102866b.27.1756943336298; Wed, 03 Sep 2025
 16:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
 <a6125a0128937392af283033e63d2b04776caf2c.1756148933.git.gitgitgadget@gmail.com>
 <CALnO6CCvD-uoan=-VW+OmfCk5cLgNm=zENAejL9vX2czahMGxg@mail.gmail.com> <xmqqiki5n8r0.fsf@gitster.g>
In-Reply-To: <xmqqiki5n8r0.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 3 Sep 2025 19:48:45 -0400
X-Gm-Features: Ac12FXycGhoTkMobf9yl80KkzOUeazv2D3AuPoXPNcJ7xx10-JwH-V164CTsTuM
Message-ID: <CALnO6CDEbXx_e2Wr_r2jR-ZbcxwsELF_tu2pWE3mgfm+5FYY=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] doc: git-checkout: clarify intro
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >> +1. **Switch branches**, with `git checkout <branch>`
> >> +2. **Restore a different version of a file**, for example with `git
> >> +   checkout <commit> <filename>` or `git checkout <filename>`
> >> +
> >> +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do=
.
> >> +Here's a description of all of the modes:
> >
> > This looks good=E2=80=94I initially scratched my head thinking there we=
re 3
> > modes, but unifying "update files to match index" and "update files to
> > match specified tree" is easier to digest in this presentation.
>
> Yup.  And on the other side, unifying "prepare to extend the history
> of a branch" and "prepare to create a new history starting at a
> commit" (aka detached HEAD) into one is equally good.
>
> But I am wondering what is the most common perception of the second
> mode.  I've always thought that the action was to "grab things out
> of the index or out of a tree-ish and overwrite the working tree
> files", and it takes me an extra effort to read, think, understand
> and finally realize that "update working tree files to match either
> the index or a tree-ish" is equivalent to it.

I'd say your first version matches my concept of that mode, but it's
heavy on the operation (do this, do that) vs the declaration (desired
end state). Of course the second version still has the verb "update,"
but we emphasize less "how" to update and more the results of said
update?

> Anyway, thanks for a review.

:)

--=20
D. Ben Knoble
