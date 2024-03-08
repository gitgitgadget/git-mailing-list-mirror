Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7755C11
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893916; cv=none; b=T6S3lU8enAJTARM6T3v/B83qf/UNPZyE0SnhdbBhBlzfKkJTMGtUPm7QnzllCmtzTVmi1h4xk40MzmT6TS/B3m/EKCYefwyE6ArztJ7lP57WT9RHFSNzaob4MHly3cSrJMwmyNe/d05w6isOxKHHsb0Cj59NdaX+mYDz61icq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893916; c=relaxed/simple;
	bh=6pp/c768zlXKZOtU42drH1rxbnVodKqARfp3/tFRMlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sk7OGzztS5qmItPkF3cWNBBvz7FVo0CVip5Joa5hOIa2k/CXasSpor8DxdoclzP1QoqItOqWukyls3GOn32tDuAG6KVxxkVcFA/ZBdYpp0LnzoxF2cHwHZPC9EEFgcNtTLWsyVOQhFoS5WqTZCjBekfZ37EmP6d8C9lBBz7poTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5SUiNlU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5SUiNlU"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2436565a12.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 02:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709893913; x=1710498713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snHgCHYOlXvWnFX3YIQB3O5JJXLZWVsGsxx1fqp5Mz0=;
        b=E5SUiNlUucIOHCNUzi0U0tys0aEeom8Fpw2Nf9sQLOkDTfyWHIAkrxhoV0Pt22miIF
         nAAyf2B54S6NNitWSdtemSZKQv2nA+/wsU+3T94JXEYnY3uXeDD5UOUQZI/5BSRzsicw
         G8L12RuQvUQiyY1I37/UJ3XmQrBCsSWwQ3Fh0m1KcwDKDVByq2/yAMVwm0sEt+oSpPEL
         qe1+pZKmER9Ux7n6LJUB3xnR5wzGGhvskTqaoicM8fpIo9jwL9BhU0gZx9ejT75kIsA+
         llY6jeBYjVavNbza6O8rmU0FFB0vG5BJOGRAu+CFWl4BuYxwLFzhNUR6fT7tBWqz16jy
         4jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893913; x=1710498713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snHgCHYOlXvWnFX3YIQB3O5JJXLZWVsGsxx1fqp5Mz0=;
        b=dJ6ORS+P42+jhOqrTBb9uhddKtN/uule6UgUpw4cFSkxOsT93migCRaEnZQqPZdx0i
         ySTPpjys+FEnj8CGg7PFNsvuQIfvQTwDTqcZiMScd2drGuG3iitqMBy/bZz2gLgzAuWx
         74ng9GShtQBoUIeyCXnCaVIRa5W9S804NEc2gIiVuwOPq6CZDVWiMBNMqVIFOTsALn4R
         WCCmsf4/vBDGWJxOq8YbIxPSlRpXFskO8lNgLeM1PpdW2v9OpLl52ZY6tk+dRbRucCNv
         k1Rk7HzCyh2dYF/P2TaVq1baLfuijy7UaMJ/s9pApWLYUJVcp+vDeCT686G5rXzygBo3
         V2TA==
X-Gm-Message-State: AOJu0Yy357f1ZwQzfsP/akDweLhgi4mN4LxOJ9wTKx5vyiPTizM3jmPd
	vTfobzJqcuOLYHUGgRtWS9uaJLYckOGLnKxwxYSk8pVsMyjIrxQlRQBuFDDqELSKUD8LLONTTDj
	OETsDO46kxCCM5aXzUs1s+IMdkOwfeUq/nbM=
X-Google-Smtp-Source: AGHT+IHlo5/MxuVq/pOxtxc4gXQvh86OL2FNEJslDgyxevPTJ3WamDdcrP/IIacoI/ViKiz1Jzpough67KSMoFUBO/U=
X-Received: by 2002:a17:906:99d6:b0:a45:f54f:ccdc with SMTP id
 s22-20020a17090699d600b00a45f54fccdcmr543053ejn.18.1709893912961; Fri, 08 Mar
 2024 02:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqplw5ihm7.fsf@gitster.g>
In-Reply-To: <xmqqplw5ihm7.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 8 Mar 2024 11:31:41 +0100
Message-ID: <CAP8UFD1oWrE-C0XYi47PrBF36bJzHAv-jOq3r1UXw_BVnb97pA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2024, #02; Thu, 7)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry for sending this first privately to Junio by mistake.)

On Fri, Mar 8, 2024 at 3:27=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:

> * cc/rev-list-allow-missing-tips (2024-02-28) 5 commits
>   (merged to 'next' on 2024-03-01 at fd7b109d04)
>  + revision: fix --missing=3D[print|allow*] for annotated tags
>   (merged to 'next' on 2024-03-01 at ac0fc94378)
>  + rev-list: allow missing tips with --missing=3D[print|allow*]
>  + t6022: fix 'test' style and 'even though' typo
>  + oidset: refactor oidset_insert_from_set()
>  + revision: clarify a 'return NULL' in get_reference()
>
>  Originally merged to 'next' on 2024-02-28
>
>  "git rev-list --missing=3Dprint" has learned to optionally take
>  "--allow-missing-tips", which allows the objects at the starting
>  points to be missing.

The description might want to be updated as no new
"--allow-missing-tips" option is introduced anymore. Maybe something
like this instead:

"git rev-list --missing=3D[print|allow*]" has learned to not die when
some tips passed to it as command line arguments are missing. Instead
those tips are just reported among the missing objects and ignored for
traversal.

>  source: <20240214142513.4002639-1-christian.couder@gmail.com>
