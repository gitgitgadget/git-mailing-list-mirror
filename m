Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6F41167E
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185255; cv=pass; b=XE5M6fiVvF5T5DrL7T6dL4vesqkRSrXYjUpLPGQT5BHFLpDKgCmXDj1Qzl+A43FUnuP0iinz7BKt3iqt3zIpaVmh2cpyP6bxz6fN9PI+dUmHwhUU4wm0GTYbPSJM/UatiqDTexkaX7U4GkZs1r6IWBHoi4BF1a1Qvr8rygDq0Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185255; c=relaxed/simple;
	bh=Za1Kh9uMPbiAE46GZnNqw6WpVfjzwrafutFxTGDgyPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df/T950xzZya5ZZZ9LDgd+33P6ZrNyUidm3xstfGKqKpKM16CQADVWH7crRWvQBEDWDc88M8k3EV20Tn4qUxx4G0mnFFLsMWWKYH0QILDb5OILfDqhp1jxV2NZCjgLbQU6MFmxaTqae1Z70dfwPiZZfZhA/ML1g9jNsxjtpOHU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFobAAcY; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFobAAcY"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6bd42f1c01cso754278eaf.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185249; cv=none;
        d=google.com; s=arc-20260327;
        b=qYR7bfbPeQxPHsiYhNsDk36EfvSrZF0sOePd1LDwgFWzOCzQ5fy93tcff9p1SS0riZ
         0b8Pd+SkGsZ61agGwk+nCorTOkA73Mh9QFJ6DBJuNs5nSBulw4L5aYKMogF/nrwj1q7O
         DPXb3RUcbAmiv/nkp6anL0Cptej+L2zf/UvE1vPlXVPpf1YZzpmhn708eKAfGzwLSIrB
         HBaDkSw/27MYmWPHTZHJgtXeUYXMAeKx6cITgDXux7dVW5pKfnHQv5T9XD7VXA6xUCHc
         9yNxEBgBtSVYTvN89vJs2IBC/ALOb3JjzySFSfhrSokPOs3eELhiNlz7T6vev7Lq0h7X
         /mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPxzLDfdQ9YNL5A8n+WBNCcnnlhDsaFs/8sfwDeVov4=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=eDkgUeSYrWGa/FWiQzuDG+cY5kILPQqCA/1eLFxxsJnjoY49lmGK3rrbndCfisO+RY
         aU9G40HSgXpMDs9fZ1pZ9b3LeTyDpEfGuAWoTjSj/zLzEtQXnIAjn8SA9nrnfesNlEFG
         VvEJE9zjgNoU2ZS5+b/9W34bYCwvVwjQaIgZlpyFRZ+9ZlXVvDsHhJC0d/2i0Igd7Ts7
         P0AqP3eTVt6FnBycW+zN3my5uSA0cViyncbR+gfHCt5YJfynyuv1TW4qceeBZbJ9LQ1c
         MdkhQXr200+OhRGm5fooFV4Y9pPLhCKa8yRrWzjJnLzqGJCMa/EzrLU8OEF174E/6VUz
         lx1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185249; x=1790790049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPxzLDfdQ9YNL5A8n+WBNCcnnlhDsaFs/8sfwDeVov4=;
        b=NFobAAcYMvWYGCiCWnqIOJIK7VQp9L4DCCfANC+NNy8qpM3pSBguUQTF2tE4F9aWNK
         +P07Gh+mT6dvHtQY5+3bO1zKXHmJKMollsdg1isZL+bVoxvU9KOrooFWy77nWIY+MNvO
         J1OPJLjbm9DOslIyHaw7ABwoCSXfGiYySfhFtgMr9hqKS1oTWFVvOJc6+R6v+BTFjniw
         CItLalbAfkXXjuAWEqyKEPq2U6LG/xcvPNb6oCCFkM6QEuC45yTj2sNaaIqrPIxgHHUq
         84Ydzn6nEwk73wY0Nxn06sziMH1KlgT0tqvlz3Wz2L6BU0baESIlN5XDN1PEFjgD5Pn3
         QLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185249; x=1790790049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPxzLDfdQ9YNL5A8n+WBNCcnnlhDsaFs/8sfwDeVov4=;
        b=fAWpa0u4Vr6kwUuvm7jUXRso7k8jhQxOKYvkmocVtzRRnRejgH9q4xd77VDq8H03Ih
         ju0xpTPAHnv7zMFzPf2+nvwCF+gg7Sq3RL3V5DA8/djlQv5OpuhfKgarJ4Qk9Asm6TF8
         mfCVynRcrbofykh35w+Bnf8QLPOG8R6EKMTXjS+FfxOzVkDLq+rXIIFmkogxBl+GWEou
         8YZKetejstv6yB+Jz8DewGw0pDuiJGC497NyLF/8bw72HUbIlBHoIPbEpv9C4vdE4lHh
         lvzASjSh/68XU1Q2vJEz+9AJ01vV/Mhba36cxqtgSNTjBokzzRmu9WVeVFQSqmNKC35e
         /f/A==
X-Gm-Message-State: AFuF++l0K3B6R/2UOnomdvjoSwfOw5jIuvXrN4QFio/6sxiovi0fmYNd
	t51stak5jpcvyeaP/w2pa2wZ2ZJ22cospLmZDVTRRU0L5WAoVtZgC/316DajZVQr7VWRFXfNvNt
	xPhhrApNqyinHGwvmicwuk9PxVyXnClQ=
X-Gm-Gg: AYBFou1smwSbzv8q7KOqHbEx2JYbF0hW4PY0tPnnTK42WFh8H3WyJ9D8MKMZ040Llzu
	z23v1fr3BXJb0MV8DNar0DH12XG2mov4HakIw7GtG3E7SbVBbtFarJu1u3BZDbt0u4JryA6nIum
	kdV7ctYPzLQGBUpp3X4ma2G0e14rSNVzPoiIu9AzUPeL7Wr0S0yord1b+UQsdC/rNlY7Zz6MPEa
	2T0o2Y6xEwzefDhQVFQdDIzdyZdSluoxJ3yXDI5rvBhRzkw3lgL8aTRVFpn0tkpHJgLrvaT4A7G
	OLh8JN55DediV24LOHAHpd68TEdeP6R5e945Tu4N5C2Lnd9h/Hgn7wsk3Fp1nA1g1T+xtjl+Ueh
	Oca7OAXhfeiSxW+jAuGOSAoy39G/nXHn604pqm9XMxKVObr356tol6t7a+Fhg5LmGne1Wlw6/QA
	==
X-Received: by 2002:a05:6820:4df2:b0:6b7:83c5:fdea with SMTP id
 006d021491bc7-6d2d1c1ef5dmr2976338eaf.43.1790185249404; Wed, 23 Sep 2026
 10:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
 <20260911144519.1011780-3-jayatheerthkulkarni2005@gmail.com> <xmqqmrtn8mpx.fsf@gitster.g>
In-Reply-To: <xmqqmrtn8mpx.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 23 Sep 2026 23:10:38 +0530
X-Gm-Features: AclHuK86B76hyU2oSDxHGrBST5D74mL4cYYXudpGG3FRMAOtPdHMvK24Y9r2tHY
Message-ID: <CA+rGoLcRRZPu8SD-vZw+rEjVzKO02=nMn_x+4ANJX7eh9jgBcw@mail.gmail.com>
Subject: Re: [GSoC Patch v6 2/7] repo: add path.superproject-root with
 absolute and relative suffixes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
>
> Correcting get_superproject_working_tree(), which was introduced by
> bf0231c661 (rev-parse: add --show-superproject-working-tree,
> 2017-03-08), is a major part of this step.  The old commit added a
> single test for very basic use but this step makes not-so-basic use
> cases to also work correctly, right?
>
> It may be a good idea to split this step into two patches:
>
>  - a patch that corrects get_superproject_working_tree(), that adds
>    a new test or two to t1500-rev-parse.sh, next to where bf0231c661
>    (rev-parse: add --show-superproject-working-tree, 2017-03-08)
>    added its test.  The test would fail without the code fix to
>    demonstrate what we improved.
>
>  - another patch that uses improved get_superproject_working_tree()
>    to add path.superproject-root.* keys, together with the updates
>    to t1900-repo-info.sh to add tests for the new feature.

Fair enough. Will do, but I don't think t1500 is a good location tho
Cause the bug affects repo as well
I will find a good location.
