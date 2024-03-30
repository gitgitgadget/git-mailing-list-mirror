Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFBF3A29F
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815132; cv=none; b=KirZOQs6OiTi2xi/cMZmYc/DzvyhHLT7c0qAsQQY753z8lPMtb7tlNiO6+NuSmNBmvI2YIUO9qJWRuFpdUfvCputTPEsR+fx2GInMb1O96ZkF1tItYg8rrFwKwLIqVWTrNzlA3rPaPAIvHb5NNSvnif5IovADBTGUiSON8Q/YQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815132; c=relaxed/simple;
	bh=cRM0Ms5wJ7zxaC7Kyb6a87+J6i+YtdYVzdSmGmGgNig=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=r965sixvu94mP73wXXFvWc3fFeICq9DGLLzO0aeJnOEMGXmypnAMJH3M0MwreHOG/iT7M13VFQnxAf34IUcMsebqejZpoTxAG0VJkmG751xjwpVHOnnwSMQo/Grhn8V2WmNFkLOSmwmf6OSClzjaO/HQL60ZdWEP5gBzaUm1+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAX06SHd; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAX06SHd"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a4f608432bso1738853eaf.2
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711815130; x=1712419930; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZMs12IjZwLcP3oLkclbq0hVAkMMiTFazkEbV5IcOcw=;
        b=QAX06SHdDTbeI/YGPpvIE+pQqaKQ73UOAYtJ4scjUEZKr7tThXOfO94/INPc96tKG9
         ypxyn172BGeNYBtyRORrvIC7PzHo6rPzuyKLsSF4dmcPXHCCOoCboUvHn/In6RXl7YuY
         DPPPtt8FCnF7ZI6VOcWoWPAFC5JgOOgHFRZz6FCZgK9CB7KjuVctiZyyUnPR2+KVMjdt
         Lw8C9tEOtaJS7vKtwywLDuz6V+ibsjuH0XAkvk9Svlovo1ptubthpbsXko9EEtVOm72q
         FQw9av2k5rnM/XFDvvNJa40poegzLWeNDJ0Sbh1duuz+v8LM9w8LdZZ9B4qurA2TWBWU
         Tr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815130; x=1712419930;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZMs12IjZwLcP3oLkclbq0hVAkMMiTFazkEbV5IcOcw=;
        b=nVnXqLsML3B9re5phNH7e7i83+8rzlRJ9AYECauOG68PoXWnKKvOWw1lHFbb0wpdIc
         Nbl36QZE/baLKVm8ofGnuqMcFJ7DmPhbRUYTeBBoXWLULofqhjgUeJX01iDXqlw0wLQu
         jCfMbMPkF/abqUUuwW72ZzifU3JOUX8pDEavY3aOLaOMPlDGGCa69X35oFbTGijW3doz
         OfSKZdOZl4FKQpWawF3Aw9gwWXqV199Bwj3mc7KLDcEEVmykvyxvYKkitFGzqgB2Y3Mi
         q0B5TxekNSpRNHjR+w7clBdf2kSkJgiIgL6gfhtZLwg6pcCWp7E6sAaWUR8Qv/KfyI6t
         Ecgw==
X-Gm-Message-State: AOJu0YxOtZP4AxrBTi9LtZUPdjYw3wunmOW2cgiZ3L2AiWS7owR94JsT
	3beEa5Nh7oTv3Fy6/yVxXdVOZB9URXjsMiT9UVX05CrFelZKt2Vr
X-Google-Smtp-Source: AGHT+IGUOSy/gXtO7ppuQ2yxd29aIMFUPspMLnmDL0fl2S6dbsX/5dA7aP8iuab3UDwpb8Gg5XLcfw==
X-Received: by 2002:a05:6820:2017:b0:5a1:b571:4871 with SMTP id by23-20020a056820201700b005a1b5714871mr1994504oob.5.1711815130377;
        Sat, 30 Mar 2024 09:12:10 -0700 (PDT)
Received: from smtpclient.apple ([2601:5c1:8380:760:45ad:937d:79bf:858d])
        by smtp.gmail.com with ESMTPSA id fe8-20020a05622a4d4800b004314e13afa2sm2729657qtb.29.2024.03.30.09.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2024 09:12:10 -0700 (PDT)
From: Benjamin <ben.knoble@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [RFC PATCH 0/3] Parallel submodule status
Message-Id: <D0DB711F-8D07-42EE-BB5C-69662EFE8B13@gmail.com>
Date: Sat, 30 Mar 2024 12:12:08 -0400
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 jeffhost@microsoft.com,
 me@ttaylorr.com,
 nasamuffin@google.com
To: atneya@google.com
X-Mailer: Apple Mail (2.3696.120.41.1.4)

> This set tries to speed up git status (and other commands which =
examine the tree state) for repositories with many submodules.

I built these patches on top of master from d6fd04375f (The twelfth =
batch, 2024-03-28), and that went smoothly. However, I used hyperfine to =
benchmark the changes in a repo of mine with many submodules (which I =
have used as a case study for the performance before [1]), and I don=E2=80=
=99t notice any change:

=CE=BB hyperfine 'git status' ~c/git/git-status 'git status =
--ignore-submodules=3Dall' '~/code/git/git-status =
--ignore-submodules=3Dall'
Benchmark 1: git status
  Time (mean =C2=B1 =CF=83):     977.8 ms =C2=B1   3.4 ms    [User: =
415.4 ms, System: 460.2 ms]
  Range (min =E2=80=A6 max):   971.5 ms =E2=80=A6 983.4 ms    10 runs

Benchmark 2: /Users/Knoble/code/git/git-status
  Time (mean =C2=B1 =CF=83):     987.0 ms =C2=B1   6.0 ms    [User: =
419.5 ms, System: 461.5 ms]
  Range (min =E2=80=A6 max):   980.5 ms =E2=80=A6 1000.1 ms    10 runs

Benchmark 3: git status --ignore-submodules=3Dall
  Time (mean =C2=B1 =CF=83):      29.2 ms =C2=B1   0.5 ms    [User: 8.5 =
ms, System: 19.1 ms]
  Range (min =E2=80=A6 max):    27.8 ms =E2=80=A6  30.4 ms    90 runs

Benchmark 4: ~/code/git/git-status --ignore-submodules=3Dall
  Time (mean =C2=B1 =CF=83):      32.3 ms =C2=B1   0.6 ms    [User: 10.5 =
ms, System: 19.1 ms]
  Range (min =E2=80=A6 max):    31.0 ms =E2=80=A6  35.0 ms    81 runs

Summary
  git status --ignore-submodules=3Dall ran
    1.11 =C2=B1 0.03 times faster than ~/code/git/git-status =
--ignore-submodules=3Dall
   33.47 =C2=B1 0.63 times faster than git status
   33.78 =C2=B1 0.66 times faster than /Users/Knoble/code/git/git-status


Is there something I needed to enable to see the speedup (am I =C2=AB =
holding it wrong =C2=BB)? Or is this series not actually implementing =
the parallelization yet=E2=80=94perhaps it is a series of preparatory =
commits?

I look forward to an implementation of this feature; searching the =
mailing list reveals some candidates which don=E2=80=99t appear to have =
ever made it to master [2].

[1]: =
https://lore.kernel.org/git/CALnO6CCoXOZTsfag6yN_Ffn+H7KE-KTzm+P-GqLKnDMg8=
j_Qmg@mail.gmail.com/
[2]: =
https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/

