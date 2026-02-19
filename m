Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E5338596
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508451; cv=pass; b=ksaYq5XA+nV6aYq283+HEFbKf3IbPV6lP/4HKc5yKnRXgsWVd/dFBfMRenFqq11IhZKCJmjqQq5P/V3YbZeeDzeuaxt2EDeOPylnRygaD/m4CzKRqIdLPQwPdSiWRU9Fm3HtAZcw8UIRzGcpeW3C7VIvqlrdekqzzdcqybCj9tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508451; c=relaxed/simple;
	bh=FSKstJwoFAoSyIo8l3r5QtM+NLWJDKNme3SchpBBV5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3rdmaJB+5TyZeEcyDMgDUrjF7++q9o0MY9AxPktiTLye/Emq7s77ZIeQaTdF5W6yYY2I3U+EFOO1dPUOMFgr+HqhKIhAcAXzlt6Jr/t7QzrMqIO3UpahXJVWJiyyf7j9NPRDcpT/3RPSkJLR7Ww3dK1vB7XftIW2AihQ4WqWQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ataPvozx; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ataPvozx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3530715386cso665991a91.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771508450; cv=none;
        d=google.com; s=arc-20240605;
        b=HGPWdtuNoXqKQVRH8XKwhgjkOF7mQQMevumtwzvA2sdNVAAHHYI5/bipWrZ8OEeUvf
         uhjD1az/i4RZb51MQAPqHDtsvHr8ZoVl8Cvk93vxfDJiidZ5xM6hCatoNscd/1oKiVv9
         630MgpAIgBm0JwFPaVOhaHejt24H2alotQCfzDitJp43e218LI5wtMtJsb4Pskh8kLLW
         ZcvluvfM8d6G2RPeOTCF6vNaVqqULBFnyVh3BnWpYeBiclIp+ZUQEwBXVBfE7bX4KVWr
         ON+AMxDKCtCLxtmTEMQrhRabqahfj2XToxAC9FjtOI1IJrJRopiJw29fV6opuDEQOED4
         V63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FSKstJwoFAoSyIo8l3r5QtM+NLWJDKNme3SchpBBV5g=;
        fh=nJm7XZV75Ii0x85FzWr8klunF9UYB+86n+Ya67oxfAg=;
        b=kao3q+sS53E2aXD7O3VhHxZk9rSCDeZtskmUwRbky2oS8xqusV7xQtSnqLykwhSP+C
         xXmcyeJT4MQySMzcUgKHIuH0MvsM1JjTGeXitvuKITP0WbU30icYal6SGkz4C343l11+
         rhecZTewJvBx2MjcasEUykFSy3jmUNFJmDqWjDQ5v8QRJNJv87KvzpD5Lmp5T1mCJyOz
         XLejCfVuc0QZ6WNYFaZ+VcdDJCRmmqNCDSS9nx9vCS9pzJL1sUSXqSsJrrdE+4PhjFkn
         NYfyt06oRw6pPux0raOjwZgj4B6zBrDLiEz11SO5nxttirBNskIs8+stnxPBAECOlRhr
         B5qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771508450; x=1772113250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSKstJwoFAoSyIo8l3r5QtM+NLWJDKNme3SchpBBV5g=;
        b=ataPvozx950Ts1rysDIocJSIdkKGH/WoHonfuQRJuWS9BX+p90SKJUJDke0L22bDwS
         /vuOjhtnQkpamq0ur5mhbBG7R9zUBEIRsnrRKH5ST6SFfc2KlPpH8pkg/6jXh1E6+qut
         qt2FOAmLmtxHN/HK7CsbsBLQifeQPl7atUEL8ci61+x0hV765yVcjuiFMT0fE6PY9Ml7
         NMg/ppC88UUsJ7pouTFFkWB24mxwtyzUe6ba5xTtyWhlXT1F5WEvUOvH8hQnmMCzzwUZ
         3+/ehdVLPOHYyWQmqAnai5IpXSyHdKFXFcakhMk747DVB96qdK5kE7vBnBZNSd9fqo1I
         Yhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508450; x=1772113250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSKstJwoFAoSyIo8l3r5QtM+NLWJDKNme3SchpBBV5g=;
        b=UoO92f5fp/3yoSwW+jR/xhxR4Rd09P+vJKZX59YDIY7rr0xv0FJ5B5ul3jfTtlYpau
         RMKEJBznwff0XkcCSTx9pLlnEWzgNKsxaywkGB4BK8+4mt9WUznAi0OJmzAlAVyl3RqY
         5yKo55NLY9HFi+q6IOCy522tTQWcZUfzz4HXTc7/uhGoDvxTpEQdh8dre/OIKd7Ucci4
         pH/agudXEVVEV9Dw4elrCxqes4K7aTZMWJpbqGJS5GRs2aYHAmTgs9pCgRvwsViVcAgu
         j53fK0UDICEtDROHE6CiBRxJlzCOlnGboxmvubKmZFbasM8ElJoY0e6BL7rKNe5yZt0f
         dh7Q==
X-Gm-Message-State: AOJu0YzLsHAEVPyFKPgx9RnOaonRskb1C5FdEiObQSvpnPVvE6eanCy1
	adobe7KpgrzaLMthbxTE/zqIU9PsTZoiJdK8oCMJEXZuJnPqbhHVemaeD15ysEMr1bX9o5tAWT0
	uS/ijYC+jJsoHLFBS11rOLL6EG8U/dSs=
X-Gm-Gg: AZuq6aLiGPDvUS71ufcGaS0u03qkYmL9xX2F9Ht4rJ6pVBDhbz0Z5eKROGLKDzHP+oU
	Rc5vRVm0TUwTXX34iW0J4TnvmWXYOvEUVVdJrQZOYWUyp6i/6ypcQv4EHrV9lj4c6zgD82jiEvf
	erralHjrBn8OBexooiorCrl9O9/u87wAMKRxHWk0hGkAedNkK0hhQlY2jZLXkbEmcjxdMRAokN6
	M72GXupLT6LcbBYtw6Sg5q9CunuJew3+YgePL8FCH0S27ZsVuh8pI2CfBAuc5eCc2Nibumqd0e8
	vG78NitdVcL4BcOY4UNK5z1A5sUqJtUdKMWJQoWbFymKyW1x9dpUtM1P45cUx2CzspmNnS71ukv
	rMm5N
X-Received: by 2002:a17:90b:1647:b0:356:3ba2:122c with SMTP id
 98e67ed59e1d1-3584492cc1bmr14553868a91.9.1771508449589; Thu, 19 Feb 2026
 05:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
 <fe5bb243-6205-41d1-9dad-7a1e2e42fbec@gmail.com>
In-Reply-To: <fe5bb243-6205-41d1-9dad-7a1e2e42fbec@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Thu, 19 Feb 2026 08:40:38 -0500
X-Gm-Features: AaiRm50u8S5LVsM3495twhb47Yx91GLZkHZZRw9H0GAlzG0uNHlbx5-iZYjbRvI
Message-ID: <CALnO6CD7xGzVSKRWFJw-igz49PrYfyGyd6_pDP1QN8dTETMJVQ@mail.gmail.com>
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation changes
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Evan Martin <evan.martin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 5:19=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> I tested the meson changes by setting up source and build directories
> with daft names to test the quoting.
>
> $ git worktree add --detach '/dev/shm/s#r#c dir'
> $ cd '/dev/shm/s#r#c dir'
> $ meson setup '/dev/shm/b#u&i ld'
>
> If I build git and then remove Documentation/config/add.adoc
> config-list.h is regenerated, it is not regenerated if I do not change
> any of the config documentation files so it looks to be working
> correctly. I've not tested the Makefile changes.
>
> Thanks for working on it
>
> Phillip

Great, thanks!
