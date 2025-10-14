Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770272D248E
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432002; cv=none; b=f5CASV/mNBRf7ZEesvqjHtfGFR2vJFmdWI9U5Ic5y96Lm+qsHkPS8l/W2I9B6Am16RZ0gYivS6TLTXe+TZSO8t9S2HiNz+/xpzRbJybujlENxvqa3HcXF29O/u7kVIUsdZlM7qDBRzeTycQsJ6dEphooX32ZsisyxmOMUpdAvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432002; c=relaxed/simple;
	bh=VSuxbT2fEZ78uF3oa9o/Ki2Z3b0DAw5rjMvMoBGm8Lw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWRVB22rRv9557o64E3Tdf5IivduZbfOEN30w55r4CoNwENn1oXcANchwupj6RrT/l5vhjl+mp10WYFybBTZMwMXZaIPzykq5EqLnki5AWOH8d24u5wzkQOsyCiNi+Cceot10KFAO7plMStCsd/L7mshYw0c3ze5tqj2mYdyMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjMIImSn; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjMIImSn"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so1652854e0c.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760431999; x=1761036799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xE0cgShsuzdvR0SGcC1DNAmJkRyT7BMpsclA+R2rK9I=;
        b=QjMIImSnQhcdY9i4dHYSrFMhe/tjHM4UXTzubAoUJPWoRQyBJsgcfmaOGxgplkWOpq
         QoU17/9X0zkNKQyIYYSJLboYgM0IOY4Zx+pENg6HO2XYx/KnyAgni2O+OARGrRbGRWrI
         Mp0ODfm9ygZ3SP2Agh9bKt+2ZqMcgWx315x/EAtzA84FkqsQJ1KK7IQSMYlYHx+cMW24
         WZLfropMA9g3YdyBbnBTlFT4H7On+iAQPMeH1DBmlztQLPaSOg4RrlLvksOJksWgXpki
         IkSlMeuZv6k3XJUFJJ10m+AnehiD41Zg7X57jKZ4WhSODr5dHzffdm+9HpGkK3TuMQIz
         9DKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431999; x=1761036799;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xE0cgShsuzdvR0SGcC1DNAmJkRyT7BMpsclA+R2rK9I=;
        b=j7ZxczQ6Fn/E0cdaaeQz/C0EkqTXhweUnWmR+oBWa0m7Ob1y/0Z6qDzqCElIG+JFKA
         lY9edPVFKp/KYx5F+whqZCP+EsGL5MAKcfJMF12mokSmVR+L47vjoiXhwxQl8bn15xRG
         BK/o7cxcT6bAwx4gmVBja0vmVuhecM6ptAlyE9KZQu1U75abXJYo3EuXgcoiZqjEJyxB
         hLyYa7nwHsULxbsi1AKdMZUW3Tzvn8xMqbQu43xI3kspMfTTNG6Ct6sRqjnkq7klwbDE
         9ihV2sgqh8iYaVkORnjzJ6e//nmuH1oFxvQxowPWdM/iS+4/m6UDN/sX42dX0UWyA0Ue
         VgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKXLV+lHY4foc8rHUCIAVDm8meC5SiGz/b15XXkO04UWP5sekJebUxHmlx7XdIiylTNgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0nfkHYs+icNe1TyHP3V0cLq/5uhPyjDiaWplQ2zeAmLlMEis
	AkpPOwYT/wuMenLaYaC9vnTDS5pu0Re6HNWZgLVyjuv5+W6rrSdVRAbFyiIk1rxx4oDbzVsYbT4
	PaZFxoVz18KQ15ozb8kMiZmuwCTjRqv0=
X-Gm-Gg: ASbGnct8lOavwFEdqEbwWtqxVwtcv520e6vaMaECv4c718U8/bCuAQIPV5PQENcZRvP
	hjXbdG6FdO9av/4iz/n7RRkvQ9BAgqI0VyqBcIdzqjgLzP7rUNw4qgATJpTKl8qzmKmXcsFIs/m
	Pl6svx44mI2+qQHfe/TL5PMhL/bMWpKZJ4OxRknOQC5rwsd/xslSiYDwV3zCT2h1vn8pZqkDYRi
	+osvG2ehy64GZuOOkHN6rTLsByIqV2xTxVl2ekmOvJScDo+VW8wjlWThp4go5lf2NAkL18=
X-Google-Smtp-Source: AGHT+IE6xBr+O0RWuFGwW8QzZVjE1nc3yOZYupf7qncjFvPlytCaK0CBRXOu30fHCw+6rgiJlo6IsE3iBwCC5GZGqUE=
X-Received: by 2002:a05:6102:4a96:b0:5d6:5ac:3902 with SMTP id
 ada2fe7eead31-5d605ac3938mr4620293137.21.1760431999230; Tue, 14 Oct 2025
 01:53:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:53:18 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:53:18 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-3-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-3-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 04:53:18 -0400
X-Gm-Features: AS18NWCGFNUsAUlcY-uCeLLCy_UUigwfIfxV4I0Oepuvyyfd4wyLRtP-2YPjG30
Message-ID: <CAOLa=ZQQXEjTPLOwdsPKd2U1xzq1MwjGDeDdCAbv_eg4NK-TNA@mail.gmail.com>
Subject: Re: [PATCH v4 03/12] replay: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f75c2a06411a833e"

--000000000000f75c2a06411a833e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In `create_commit()` we're using `the_repository` even though we already
> have a repository passed to use as an argument. Fix this.
>

I was thinking about this as I read your previous patch. This makes
sense.

> Note that we still cannot get rid of `USE_THE_REPOSITORY_VARIABLE`. This
> is because we use `DEFAULT_ABBREV and `get_commit_output_encoding()`,
> both of which are stored as global variables that can be modified via
> the Git configuration.
>

That's a bummer. But one less step needed is a win.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/replay.c b/replay.c
> index e22ce39940..13d75d8054 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -62,7 +62,7 @@ static struct commit *create_commit(struct repository *repo,
>  	obj = parse_object(repo, &ret);
>
>  out:
> -	repo_unuse_commit_buffer(the_repository, based_on, message);
> +	repo_unuse_commit_buffer(repo, based_on, message);
>  	free_commit_extra_headers(extra);
>  	free_commit_list(parents);
>  	strbuf_release(&msg);
>
> --
> 2.51.0.700.g236ee7b076.dirty

--000000000000f75c2a06411a833e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a746274817f6e67f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdUQzd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memxGREFDZ2JoTk5KYUl4ZDk2RlNWS2daaG5CWlZOVApnS2twNDhSWnRU
b2ZQYXdyK0h6TTA2TWRoUEdzYmZCcUhPMG9ib3FtamFha081MEswb1BsclU3a2J5V25INW5JCmcr
VkhBR3RDVHlVYm5QMU8xNTBCY3NTdS9JcUVtb2Z4MG9WODRyK2lINzMrSnBKck9Ib1F4UGo0Rmw1
Q2hGTk8KVjRjdWRxOURqOFRQdmZjbis1MWdOQXd5QXlWc0NDdVBoWjBSTmdVMlRlOGRYaXdGNU50
ZUZUTWx1dnpQdFpSYQpiZk1DRDdPYjZ0ZEtXMTlKTXI5M0wvWTRXZ0pvWklVeG81T2Z6MVc0b2hP
UGJueURLUG51UjhoSFNveXpxVWRzCmJOaCs4TFdpcm1rOTJkVHNIM2JFNnlkeHFERUhyMU1uUVo4
cGZkbkxKNlRxMVdmNG1KNExBd3JEb0xaR2dJdVYKUDRPN0R3YXJqY2VVWWJqY1ZVRkNNYnprdUZW
Z0JvbGNWOFVvQ04xZ3hVYXh6SDBPUHh6cThrcDdnQ2thN0pUaApSck1pV0FGVTd1NENMVlJ6dmhH
YUNpa1hsYXJnbXFyZXgzTEh2NGZJbnhDUjlmaWxKUjBuM2pOT0lIamZRRjU5CjFxaXQ1emdXdjlO
cWNhYTN4WitpUTRvNEFicUhON3Faa1BkU3JmST0KPWZXM2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f75c2a06411a833e--
