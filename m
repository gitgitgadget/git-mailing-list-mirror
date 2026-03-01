Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36893B2AA
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403538; cv=pass; b=CfmT3wSi0BqqP7lnQLVVZUO7jENtAhk1oVbQryInd3Ydv2akQV6TEmmpDb4YTorXRpxxpdCOnwSe0nO1bOdc/iVUMEDMJ5W/IXDQhZII7U+WNETsBbCuVQmBJZQYQDt55gYatbMMatowGbxb6upXpHaCaTe7W1VmYn4HWby8EJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403538; c=relaxed/simple;
	bh=dFBEH0tYfGMplHFFGIkczgLq3ljukJDgoKdvcpjXeqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiQkJnurRXJHTH94PhYqpAsPkLAZ7Brwjp5lPr4sB87d8GcmvL5+Fo2AK1pQJe4l8TBN2IyqqNhon2dl/3W/hcI8/HZSJVn03Or0IW20rx0jNILF+FYHfneUSmP2y5SCuK8Iylgz6OUYvR+KA+c8pUVnz8qKRZ7fxB3Ioj0rJMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBQWt2FB; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBQWt2FB"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1279eced0b9so438034c88.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 14:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772403537; cv=none;
        d=google.com; s=arc-20240605;
        b=boAkITRYxquxkKwJtF8QLviLNyuyqfQ9oi38tA4prMyzAIKqVb6YR6uUykvDN2uehY
         +EO663CNyEqZZUxg7jt+2RbObnQiXEJmHksJeV5wgAvAFhJDyfV7Qfo89bJlsG/by5kT
         K58ABfUG8VnL5FHcdEt80pyg58LV2tH1LibjdRgHof5WsbqHRRHKdE8RvdW94ycQYroz
         v5jMElZ6kihvw68B8HQrgWsfaLN3cVR1t0HOJaE08EcNrzYkB86cl7gGVI2ticJ/WaWf
         5LcNBdV/dqO9guhVdCufYV+rJdYEiMEE3KtSO8KD9FnSs0vCTUDzWpeF98GAX52m4j1g
         IQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFBEH0tYfGMplHFFGIkczgLq3ljukJDgoKdvcpjXeqs=;
        fh=ClMxk5PzTyMoAB72h0jvlSiB7u51Kqx2SaK91cVnEHk=;
        b=GTzAl7SAgylvEved7AnkrKGWYB7byPfhrTAbDoYDpYJPhnoK78ipYxmTkJx7F2MW7K
         hz1vrXA6JDov+DEUqFlJDCBaw+I47NfSRz/XSIKaCH5DndcCgEFGUniued24UfUp+Dmf
         QLyhmkJzogvrbpvW4VMqE6bxfVlcriXdPX+2fDSXuwl2TJq6a1USKdIgftKCXWhk5tUo
         cT7ibk8bUsau/7FmaA7UZBSbawP8vea0XxJyUR80Fs7FU+Aa0ywhYplWzLgGP3PY5vP/
         0kwhWkgRNJjx8aVHdOBPIhhkHeIfEunId06UZK/zvzpwuI+oZpCHvJv3M2+4966dv9p1
         u+Jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403537; x=1773008337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFBEH0tYfGMplHFFGIkczgLq3ljukJDgoKdvcpjXeqs=;
        b=CBQWt2FB5MHWZ/PlZuCBSThSBcaUIpBQp3qLLYFThsne82pErFpR1bDd/FFTB7FHV1
         Zc32NDMo0qCLLq6KGG9BHUnMRUBzFRdGTlTkaxi6d6ZFEMtSCP86EyQg4SoRdejZd6rx
         3lr6+8VU7CFp1IElfjB2WF1ktm74xNdG1SJfd0SsjDVPTZeVjqelIKSwksTI97SneFq8
         qssknnkaZZrbZBRIenaaUv+sbq/3EKVPVHxjsOPIFC3AGt6pg8qwatO7QPNsANYDHD1C
         5DXuTxMvBWjRDJheAiUTKIiMIyyDo/v3bW1EMko604Pbxst0fSnHC077EDIcQWmzAOos
         gyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403537; x=1773008337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFBEH0tYfGMplHFFGIkczgLq3ljukJDgoKdvcpjXeqs=;
        b=qLUhNhXLjz2jOC+GDCqRehWOsUOm7s8udryPQ0UiL1SNflQ0LMbd8dGR5mlj6QDFna
         qj7YjIra5Nr8kzG76hxD+0jAEJXKkpFace48ZKSgZ7Hc8DduvJdHVOlHb2VxiCBMdgVi
         Xxe76f4a0A4rdZMCl6D+b/hY7jbVXiJ/HBh+aq6XtoVnEEpNWvLRX1qTQMuJaRJbp9L2
         D8NKZqLgbkC+cR84hQ8TWAFUf1lo9KSAOW9tAEBho55xgvBxP+4p/myAwc8n+B3bP6h9
         Q4wVyFft2aokQue8okrvJv61PEaIWUIg/pVrl5lgPcViz+1/WnlDaqqZHWWtyrq6qpYw
         4BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxGSDTcrA2HCYCgZxoClZFc9UgtWKafOYRaE+TJrz9QMl/6v/ri+12PDt7zD3GSf42JFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7uYUS/uufAV1iTsS8mmhyyhlqUM1SKwzhzn7J4YztxmY8IA8
	HR6hBA5eWudBtz9NoLiMmXK8Jx5r+ljkQSrddkwkqz3Fr3FGFy5Ab3qtZ30nbm16VqlmH5fFKjO
	OqdTW3S02lXlc6s15XpQh1cz0B0Dmly8=
X-Gm-Gg: ATEYQzxhOM3MbKFpI5GdMNLuZhuE8hDmA96cYzRK0pAyyJNmL+qMgVvR2lw2uGRJ4pc
	BtbnT/N0GPPivS9jT36ehdL13sdwW2ZYjS+H6sunuyIGASy3W7qNcITAs/eFkwpFAZHJ7mB/I3T
	7WKhx1wCqS1yKmhTsxdFCQ3avZ4pvBdi9weRdcxxMDGx5Xwh5vdCjj6hzyHGEjrsCDTtVXJmvR6
	6iYDheRSBDVKtBhBo4WOPOXtTxXIN09jPqxOF4Sli50Yxqsq/xQs7era6EMPmOVZUo13TZPObTJ
	MmDsCSHGHYH8Cuo/rsGINSheQaiz9WHFDZVo6hHlsbjBNScX936K02iIWFaWVQzcfCvhY8h4dSH
	6xq8=
X-Received: by 2002:a05:7022:ba4:b0:119:e56b:91ea with SMTP id
 a92af1059eb24-1278fbff7a6mr4277152c88.27.1772403536829; Sun, 01 Mar 2026
 14:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c67066fb-f857-4738-a3a2-53108c57456a@gmail.com>
In-Reply-To: <c67066fb-f857-4738-a3a2-53108c57456a@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 1 Mar 2026 23:18:45 +0100
X-Gm-Features: AaiRm52dX-DPf79CCDlLpeO5TddfAxvuHCHC76OCn7869xlYMEfX26A-sb2Ft0A
Message-ID: <CAP8UFD2Q7gctwzGOe+rbgdXZSbDbV0dmM-cx4qt_d8nKi88=HA@mail.gmail.com>
Subject: Re: Editing GSoC Project Ideas
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Sun, Mar 1, 2026 at 3:26=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> I'd be very grateful if someone with write access could please update
> the description of "Refactoring in order to reduce Git=E2=80=99s global s=
tate"
> [1] to stop recommending moving settings from `environment.c` into
> `struct repository_settings`. That struct was originally added to hold
> config settings that were already lazily parsed. We've had a number of
> submissions that move eagerly parsed config settings into that struct
> where an invalid config setting causes git to start dying in unexpected
> places when the lazy parsing fails.

Yes, we should definitely update the description. Thanks for telling
us about this.

> The current wording of the suggested microproject does not mention any
> of the subtleties involved which sets students up to fail. A better
> suggestion would be for them to look at what Bello Caleb Olamide has
> been doing in their Outreach project [2].

Yeah, I agree. We should suggest that.

> I haven't been following Stolee's work [3] on "git conifg list --type"
> closely but I think it introduces some functions to parse config
> settings gently. Those functions might enable us to parse some config
> settings lazy where the functions using the lazily parsed settings are
> already set up to return a error. Doing that would require careful
> analysis and should not be a blanket recommendation.

I haven't followed Stolee's work either, but I will take a look.
Thanks for the pointer.

In the meantime, if you have concrete suggestions for change you can
submit one or more PRs to the https://github.com/git/git.github.io/
repo.

Thanks again anyway!
