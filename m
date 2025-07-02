Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E51134CB
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420563; cv=none; b=oRJ0ODFWptFSmaYzeHWRUDocyI2nN8loWx7db0OVJTiz4mKEv1D86C4qm9BBH1tKvMMVt6qzON8N9jjfNyZkYp2XrG6xEfKyCWWZkJWugUm1ppxAmUdEsEWVJ+89LQDfk/R5KgEIfLFKAwCrq/6A2V5Bt3puoD67QuUqD+gzSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420563; c=relaxed/simple;
	bh=BkZi5wFZTxDyR76WohahlRDbpm/RmFCHo1dorqy7DPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MMqYfvhhUf/VF6cLAdPpAmfkp5yM1PHK6mYb+Wa9TCDsO8w+t5x/W84Q7qUhLfQGnnWCHg/tJQEZPjPuxU3CkJ4szAE4Z5eIYh3OWemjP6JRyKZiB2dJLGQRzpqsDM5iI/YCZdqh8yQ0kvcfQZpGtqSS6r57t3jREqS8r7VMo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P48BNz6I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P48BNz6I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2352400344aso59460695ad.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751420562; x=1752025362; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iPEByDjIGX/NAYhWIvIVNT7/P2mZmPrIYI0FQ4z1rg=;
        b=P48BNz6I4O23eit/QBYt6Ei+toBSyRi9BPERCVjsBX7xzyeORH3UFQpUI9SI14pbyu
         Zn+FcHRcdVjbfn9ge718uFHgmRNdKZsOPa39cMvnoofxa93GwBVd03StgyhdmQbZIE/t
         VKdFScc6JuArZRe2r96SGkOMM4FnH08uvdtkN5QVljgfNqZUaW5dzlqrZ45zOXxsh/TN
         XkS6mghhu6kgLh8FrfPPEhbBKhZv5RQSHBHS55rHqqcRiCWtcMvf0K7PVxL6jRgq9omx
         hABDoAndf2wma1cubwAXcZrBvV0Z//dSoGXmqs2eNu7Zpl2BCqEHss4WtXxGEVj02aRZ
         hHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420562; x=1752025362;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+iPEByDjIGX/NAYhWIvIVNT7/P2mZmPrIYI0FQ4z1rg=;
        b=KzamMcPmSxN/ZxVvFDtr7YHxXXd+n6Hp/n754Ajidjx21GNLH5jkXNL/GkLY0pqwD5
         +QAUXHL+rezNIVJlweVDbnhuHKwVpJPXiyCBvfkiLqs3WqH0PTOCMXOXHsTrZYxxzw2S
         EkAaebVyjx5npwt+BB97AbjWMlpIrjxX0hGinv/KsYlNlfjC8shburfKp9i7jUSzfeay
         cyRh/jyw0+eMGRr5XhE5fQfNVp74KfRoQuTuVCdl01tDAZXwFNRpoYuKaHY51nn/e2I2
         kxG/I717zPGs6Kr+soJ/5nqTH4Xqm7Ov7tC657uykRP/LAzZuQSVoTNnnVMJVW+5uFzB
         yaWw==
X-Forwarded-Encrypted: i=1; AJvYcCUrIOtEhrn7y3ch1qniZsWibo+AFwxT3KZwLP6ykfrQoVcQdRwvffEZ74fPqgeq93Vf87o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwttpuF+BDVdVO36acKB9IVHVpkqK1YHfmDxpSx+wZzg+tVO9l
	bSCtIoQLzyTqpcwckWQcZcfIroeJmMKTf4h3yjjovdcr2pxs50KNYIg6uaIvaA==
X-Gm-Gg: ASbGncu89wdHWBIq++UdSbJO7cuSeJawXalhY+SmbJSID7Y4wgQr9Z4WnhOioEAZpRg
	8ckbccDqL7PTTK5YXTnQW40fhs2TpGUgF6qKd3caIjylwwtAPK51X+Bh1jA3Pf3L73v6IhCbph+
	brUNmQeEVEDBTxS2nmK1JGq8TiLueUKjUJckcD5y5hUllleZSYAleBm5/gLAZjFxvSO4gmxewjJ
	caxOmrRiLMFptsSCygxvuLXZp/qxJ6vmdQMencoXGKCtFFZ188zBAO5G0I5O0FCAEOHXNinB7DA
	Q1i0HEPv8Zzpj6tMYQraGR6lldBvj328lWRZhtkskhuvnsh2zxBjkvx0fc700/hyH1MsMuk/NAd
	1/T0uFIxPafjajWmDB5LqwtxdxBo=
X-Google-Smtp-Source: AGHT+IEwt/YqB0Ri5C4Me9lt2++53VtzHdGtyHHOcaa3Wbgk/bfj3TiK4LWI7WtPWEZgk4C7nF9Qpg==
X-Received: by 2002:a17:902:fc4f:b0:235:e309:7dec with SMTP id d9443c01a7336-23c6e4ffac7mr11761595ad.26.1751420561692;
        Tue, 01 Jul 2025 18:42:41 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c5a8csm118226315ad.223.2025.07.01.18.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:42:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 0/2] fetch --prune performance problem
In-Reply-To: <20250702005837.2813893-2-phil.hord@gmail.com> (Phil Hord's
	message of "Tue, 1 Jul 2025 17:58:36 -0700")
References: <20250702005837.2813893-2-phil.hord@gmail.com>
Date: Tue, 01 Jul 2025 18:42:40 -0700
Message-ID: <xmqqms9nfjvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Hord <phil.hord@gmail.com> writes:

> This version (V3) has three changes from V2:
>  - Removes a header declaration I forgot to move previously
>  - Cleans up the refs_warn_dangling_symrefs API to be more sane
>  - Drops the ref shortening that seems ill-advised in retrospect
>
> Phil Hord (2):
>   refs: remove old refs_warn_dangling_symref
>   clean up interface for refs_warn_dangling_symrefs

Hmph.  On top of which commit did you base these two patches?
The second one does not apply on top of applying 1/2 on top of
either v2.48.1 (where I queued the last round), v2.50.0 (the obvious
choice for a new development), or 'master'.

$ git am -s <patch-2-of-2.txt
error: patch failed: builtin/fetch.c:1384
error: builtin/fetch.c: patch does not apply
error: patch failed: builtin/remote.c:1521
error: builtin/remote.c: patch does not apply
error: patch failed: refs.c:458
error: refs.c: patch does not apply

Thanks.
