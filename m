Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE713D29F
	for <git@vger.kernel.org>; Tue, 21 May 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302457; cv=none; b=L0NovYRgKl2wIofhLW2zSlz4v0OUiRvqmXmF2hgJtmX8u69yoPrsb1DyyDWUYAb9OJyPNiztqvghO+Gw1YYdEbz/eLZ4fEdK9FlTdsifoCzwfLOlNSNqR7kPTjF1e5HOfj5FxwgdqP2tFxAyOSiD7SC0+7Q5+XYpgYQ2shK/XWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302457; c=relaxed/simple;
	bh=BvGb2bIw4q0Ez/vOynlJlvCsLWMJajrgDUFdQ0FNDzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCQVIAWeoQmVuxQfapL0zTz9Mnysvb3KM+ukjIoVRDmcTAqpgIrWcMCFav6khr12Bvxt1fapRdsIg8nAisL9NVZZR+BHFPRsU2PE55UBbIoWRdihbGgps9fOyA7X+sTudj2hnU95wd4f5lFUBxf5kbX3nVt2wcwdlali4tlesS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry9nt37C; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry9nt37C"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2761611e8so2724003eaf.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302455; x=1716907255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlfhRyvhhqlnMYwzIP2nHhEXSMf+26DSIg2lh40K0jU=;
        b=Ry9nt37CNIsYAXrBEkoNKZ4CA11Mm9O0fFtSeBw06J8tS86sjgQN/PFxYS8TEzs7Qn
         gvwDZlz1supjhHG2E/sVkq5U/m6vVL8Nd8z2WahW2NN2o8YueCDqpyIdoRud89I/6P8u
         dTeeG6opfJ57Uthn86JBFKP6dh6UJTorvBh1ES31T40l5uUAwGN8TORqXmq9cOfuwdqS
         JOfLJhqWzZIu6eYoLNnq3m3wjzL4m7LDr0OAArrH28tvWDsMuD2osK2j/OSauocpKYP6
         gdEutqzeXENvm77DB+OGzbC6x3yD5aItQPPnJvwJinC4r2BudW41G4d0q2V0U9VXiMCn
         SOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302455; x=1716907255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlfhRyvhhqlnMYwzIP2nHhEXSMf+26DSIg2lh40K0jU=;
        b=St8p+X2rELlUSGI6I7tNLI11EMbDWyXqh7AtNGE/ueQX376RJAjWMk1wHerIZv6FVf
         JBwoa7+xwMHcK5vC4qYhIz4hse+h6kzFzGWsCrguzw863cjEp2V0DlPGVdnCMv7KjOFb
         5ykH7xp22X9ZrfEwZ+nW/Y+Jke6pyO+FlWtsyJ5Gig/NJg9I73+t1xS56Avj3tIGdK3e
         0AIs0C4zslmfbhtfS3pMLw6xKZ0CFykCCa2+YJX6gOYtUhsNtKL2BHPMzv0sJEdYgv2J
         LtAdfbZ71gum/+344nsfgjoCDI08+hlGS+WgkSDEyWxuSNNLdGJmiKU+NJtPzABbegy8
         E7HA==
X-Gm-Message-State: AOJu0YydQWWRqTFidViqYZW8w/nOwQy4xizhQgSQTj7doSmm7gHIE27u
	d4R1T9X2PagTV8nt9AQrEUywgI4sWumLDxA+EaKhzPbfbUtOhc6RbznxMV4dgl2dIggY3Itnyhd
	s8o3Zq/Y0yEQWDB+mV6Fv/xsYxGid19jd
X-Google-Smtp-Source: AGHT+IHj+HTTymqWs97dSAV3t/KtcqBICtu86fwIL4IGGA4yHiV6u9M1IboVX788ategHCfVd6ldVKg79pRJILpfSyQ=
X-Received: by 2002:a4a:98e9:0:b0:5aa:4b31:50c5 with SMTP id
 006d021491bc7-5b281856d44mr28116106eaf.2.1716302454814; Tue, 21 May 2024
 07:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH8yC8mPP_2jv8HDBdMxWv6TbiLXeDnD=KmNRMbno2bHQtfH1A@mail.gmail.com>
 <3e4a7071-60b0-4f7a-b347-d584d5eb076e@aixigo.com> <CAH8yC8mNns_XiQHp3=q_tYr03Q+kR1r=2WOYha1XMp+cYs9WDQ@mail.gmail.com>
 <d71c7dff-46a7-4ac8-a8c7-ab4985458071@aixigo.com>
In-Reply-To: <d71c7dff-46a7-4ac8-a8c7-ab4985458071@aixigo.com>
Reply-To: noloader@gmail.com
From: Jeffrey Walton <noloader@gmail.com>
Date: Tue, 21 May 2024 10:40:44 -0400
Message-ID: <CAH8yC8nqRSmxHp+9fdPNh29eLv4JZ2+NFnYtOejhf-F+n7jkCw@mail.gmail.com>
Subject: Re: How to disable safe directories?
To: Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:25=E2=80=AFAM Harald Dunkel <harald.dunkel@aixig=
o.com> wrote:
>
> On 2024-05-21 12:45:18, Jeffrey Walton wrote:
> >
> > Thanks Harri.
> >
> > Would that be something like safe_directories.enabled =3D false? If not=
,
> > can you point to a setting?
> >
>
> It is possible to disable this feature globally using something
> like
>
>         git config --system --add safe.directory /somepath/.git
>
> Some say even
>
>         git config --system --add safe.directory '*'
>
> works, but I haven't tried that.

Thanks Harri.

Yeah, that did not work for me, either.

I've been through directory permissions on the workstations and
servers, and the SELinux contexts on the server. I cannot find
anything wrong with them. Do you know how to have git tell us what the
actual problem is? `git -v pull` is not providing more information,
like what the actual problem is (it just barfs).

Thanks again.

Jeff
