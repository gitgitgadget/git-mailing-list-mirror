Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74242262FCB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359502; cv=none; b=HFx9AcUGGvu2X9jMhlWQb3mebNpE2cyrK0Vgbgd9QbpLhjzCmDGV+sP0NqQaptLSpOaIIPQVQ54w3P3rJ0ZkmHtKVxGdLBQ0C1Vj6FDpERwerE/rUJkcvf2kGKpi4irbUmX66TIsKCmKohJogPp4YGzQh/NLEgPUAEqSAxirJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359502; c=relaxed/simple;
	bh=f+P3wNfHGLK/3coTa3BZRL88yPsAwMnbiF1azuUd9qQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YIS/VHE1iYfrLQ1twWiEZAKMI7iojCjhn50tMd8ICW09s/5Oz48u7yfiToEeF13orM6aehwYltsbl/gPWqGDs0FbdHn+T1R173MLHjJ0UuxWRA8bo/+TnHBudbK60JrLssW9We5Ch7P5Hr/naVRpwE71XD7fKzS7KcZxJH3jeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stxnext.pl; spf=pass smtp.mailfrom=stxnext.pl; dkim=pass (1024-bit key) header.d=stxnext.pl header.i=@stxnext.pl header.b=cj3DeWZe; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stxnext.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stxnext.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stxnext.pl header.i=@stxnext.pl header.b="cj3DeWZe"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso5266175e87.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stxnext.pl; s=google; t=1760359497; x=1760964297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XtCQjfSgBupietqj1Ww8lMpP2Mbc8yoTDaYZvAFRJek=;
        b=cj3DeWZet2aeQ23i1wdFsEst9gR+tJtewfxVmb/TTa4UIbUuyK8NlxojX+WGyg8fRf
         2tV+2qp1oude3mASXVuOZ/5eJXS3wglKhB0pR3eMidZaO51S4FlJ9xzcWDQBWJBT8Yi7
         BFjXS+O+MG5LZum/Pfn0xBnaGJPWzCgOUxhFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359497; x=1760964297;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtCQjfSgBupietqj1Ww8lMpP2Mbc8yoTDaYZvAFRJek=;
        b=vvmEww70KT+lodqK5NNXGzQEMkZh0K9ZFCjpYxlzjlkHvdBrvSdSpgit4IzAhDX1ZB
         I8AjdDF+H+MsV0SXidSySMdqzN5NxNtTdSZqE2SKyv/ipP4D5BKWbSkelTliLEU52tRY
         tXIGfF0My9WYgiQw/eWd/Eg8/NbSgP2bvQCpV/b+55ko2LUyZXgsiVJD/LlhPT7WFfVP
         ew395718y7H40LkGGeunh0GUR1weV6OAJUvEKo7Hq8l3fabaKUZLJQKFKLv+QVpeu08P
         GQbQghWli/CSHJDurlsZiclgihnmd4HsyQdbyCNXjxkJxjM9E1l0DnIpnUxDLpFGIy0c
         tztQ==
X-Gm-Message-State: AOJu0YyfBEUHEtw4vHyO3Cy+pL4ZdVuiIWV8D9+4nSSR34MJXVMTHSml
	JNxlzqrXDsPJLU0jH1l3HjtkMK1YZ4WJn6FxbjAjajDlXTTVikzrJRi4xhQXHbAodzgMrvSEnsU
	q2DTRWL8lTKEgR7hTImjl/+PyTnEJ7yTNSWDB12Bj877fkLTshfVYSnw=
X-Gm-Gg: ASbGncsSt+MaqMp33cuRcpYFoYpeZyBS3Tb8KUsB1Kn0I6rWuNEXH1Q5ySYC1zPMQss
	h0Ymncig0oPTmJeWFAWV917/zlebQoaEikhplxeVZQFKGMzP/owTokwNmBkscxv2TSoy/nGR2Hy
	oGiXhXskisVx/qZNkVGxWZapSS+2NtnnPMENsOKfl191cubgaeezw6EP9FJhqwsGsvDNjMI4PCM
	WVh3Gx/cDL5KO9W+poBuCcSEuK3KhbK/C+m
X-Google-Smtp-Source: AGHT+IGHcmm192HJuLIsXpx4tNa8kwOTmG1IEQgektmENq4N2P40Hn8Ol6T1Ke6DhImyDdtB7ywaW7KxTWnyvTqYbpQ=
X-Received: by 2002:a05:6512:4028:b0:57d:b8a1:832b with SMTP id
 2adb3069b0e04-5906d89edbdmr5948954e87.24.1760359497256; Mon, 13 Oct 2025
 05:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Grzegorz Koperwas <grzegorz.koperwas@stxnext.pl>
Date: Mon, 13 Oct 2025 14:44:45 +0200
X-Gm-Features: AS18NWCSTiCG6YQpPI3OM38T9UcDyweq8bwRD0w-YCQEtlgqx_1wcr82dfePWA0
Message-ID: <CABuAATb5bKG+CwPME4jPwJfizw0FE1w3kJre4b2a21UGv_8f+g@mail.gmail.com>
Subject: git whatchanged
To: git@vger.kernel.org
Cc: admin@grzegorzkoperwas.site
Content-Type: text/plain; charset="UTF-8"

Hello!

I recently got this output from git:

> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-this

I am letting you know, that I still use this command :)

Have a great day

Grzegorz Koperwas
