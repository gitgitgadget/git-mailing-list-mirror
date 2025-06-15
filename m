Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0463596D
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749992125; cv=none; b=V5maw8H+lETMAmJ4bQFSiV5kNZyj7mgvaqNBt2bE5WExvxqJ0oYwaORYUqMYtSUMXWV5C6u/lp0G7xYHBXgR+2P8tbMLVIRnlH4w6xOVG8hVYhjI6SWvfOlYH6BbS3CeRatNf+nL4Gmi6aMUMduPNTBJa2QHO+Gp4UKp774U2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749992125; c=relaxed/simple;
	bh=WagscHeFzwi40GJQfT1MxjEgGK4uTzsCDBS5FtjS0XQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lr4YyYxp3ACmiRuoELEosfWVwU1sKW0NxNUQc0OZJ74uWSKz9gxY5PrSIcbYrd1OMJ2UH4uephexIDC6Zf9IW97UfEOcp7HhLqJ+SKgRT2xmfY933MoM0Io8qblWf3lVtLrXslcbPK2OF3MLY+c491Ra65h0hUre6v17fxRw0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOO897+q; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOO897+q"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3168179b3a.0
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749992124; x=1750596924; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDtXg8pLoRh97mRah7SWA3UQYAGQkBKSGlv6DBIjfNg=;
        b=iOO897+qD4Ao9aFPeH2B34XxLNFf40C8UDrtMCMR6er3ttrcIrEQGtUVqVxpwkbWN3
         DTxqkkEmK3HuBKLItLCm77Hxw48I7dYxNzvRgURsx4CMjmsTk8YcVmAY9awKI5V3a6/w
         8Z0WPvmto+dS0Kb4w2PazRAlhq0Gttu5E+0lamsS1PI5YNc86BLrdFVM8HYewSlqDa3v
         ULAw8eZjIDW96eVJYHjZror35DFK4WpV2pnfqywtMXZCQtektf92+TmbxU8tFO1dIeXa
         4hqgoAlpRE0SY4rJzJriDQJB26Ew551RTv37TC5dCWt9s3dZ/3RA3U0JOTbqHcOGnprX
         HSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749992124; x=1750596924;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDtXg8pLoRh97mRah7SWA3UQYAGQkBKSGlv6DBIjfNg=;
        b=jUrTW/c1tD7i4Qzt0rSeDGTeTCV5azjOjWkSblsHjWAVOgdu7kOqEKaOv9Dw5GgwBO
         uWn/nF4twsnIVwY4IRbb+/WJ061MiTxcn4oFz7ihwQ2YIhmXZcnhRJQ/dkxcg4UCW/3N
         2OeaEoZ6PRE6txt6npvSc+DFDwr8IfahB8dgi+TJ+lkwauOFNodQMSC5TqkSWVwKj+4j
         2U9OIqMasQOAi3jNuLDpqSwi0zyzQqfs3PtWilXWqGB+qKfQsnq+iw8mV5MwoTB4ZfsE
         jEE9DSkMH1H7MbQali/kjaUM6742+GM3VC6a/vPXaPA0fDDKBof0bue2UNK7t2AG030J
         5xdA==
X-Forwarded-Encrypted: i=1; AJvYcCVqDDhz3o2OADr+APWy/LS7ppLaYHSKBw5biItwBPi836LF4Nfu2Lsj0r17ipKCpq3vh5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yJ5oEuSKdr7xdvYv/7cDEbNZpRasR1n3cmTQOha4BWYEK1lj
	6bmnZKDYMCEX5XmHEwG9UgyHzyS1jckgPqpRZQNEPQkZnPpZTNG/sXmJ
X-Gm-Gg: ASbGncu0Uv7Lt6BJ3Qkrlrq04vUJtJdTfTvOe6Yaor9qVzsZjBcLCY15f7My71OehU9
	cfnjxOdRHZfCq1LdKTvwCgcp1scbMjWfDocGIirgG2P9xdvsfQWpS6THKFqZp0Tc4XlOB16MryP
	Pb4WqdftzMCmSfFEBTW9JEtl91IlqBbFzCzWFOnLoJT/3XagMx+iRPKzkJkHBZ0lpkBqukgu8qW
	T0roVoJSSO1GoIzxjkkpRJkidRcIYB59Wyc7hMJel+EEk80P2qx9LzMITrzrYZMPoMvcqs+EQo5
	dnD8KTiXOvkOQBoqolCPdbw0Ly0ZdF7CdTjukLIkzEpd7TSA2rrjU/tMbdi4BTOAqKdfA5U9InA
	p3PViUZPQIGumdKctqnWYLBRV1MhxBJPZ
X-Google-Smtp-Source: AGHT+IFI8FOEcLj1VJrZheXVarR/W+3ZF7b6LF1gfdZkASPEMdUTAyG596AvwmoNxNPpf2g0vyVZ7w==
X-Received: by 2002:a05:6a21:8cc6:b0:216:1476:f71 with SMTP id adf61e73a8af0-21fbd5dde81mr8379411637.39.1749992123537;
        Sun, 15 Jun 2025 05:55:23 -0700 (PDT)
Received: from smtpclient.apple (awork062155.netvigator.com. [203.198.28.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890082859sm4987312b3a.104.2025.06.15.05.55.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jun 2025 05:55:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
Date: Sun, 15 Jun 2025 20:55:08 +0800
Cc: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Josh Soref <gitgitgadget@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Alex <alexguo1023@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C3C7F5F-9442-4C63-9280-D46A683C9F4D@gmail.com>
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
 <44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
 <SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
 <xmqq7c1f8nr2.fsf@gitster.g>
 <SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
To: Jinyao Guo <guo846@purdue.edu>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jinyao Guo <guo846@purdue.edu> writes=EF=BC=9A
>=20
> Sure. I'll choose one account and use it consistently.
>=20
> Here is the edited patch:
>=20
> =46rom 04b286cb2e736c3a53287b6ddf406e704f19fb2e Mon Sep 17 00:00:00 =
2001
> From: jinyaoguo <guo846@purdue.edu>
> Date: Thu, 12 Jun 2025 18:48:24 -0400
> Subject: [PATCH] Fix memory leak in function handle_content_type
>=20
> The function handle_content_type allocates memory for boundary
> using xmalloc(sizeof(struct strbuf)). If (++mi->content_top >=3D
> &mi->content[MAX_BOUNDARIES]) is true, the function returns
> without freeing boundary.
>=20
> Signed-off-by: jinyaoguo <guo846@purdue.edu>
> ---
> mailinfo.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/mailinfo.c b/mailinfo.c
> index ee4597da6b..e0ea358311 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -266,6 +266,9 @@ static void handle_content_type(struct mailinfo =
*mi, struct strbuf *line)
> error("Too many boundaries to handle");
> mi->input_error =3D -1;
> mi->content_top =3D &mi->content[MAX_BOUNDARIES] - 1;
> + strbuf_release(boundary);
> + free(boundary);
> + boundary =3D NULL;
> return;
> }
> *(mi->content_top) =3D boundary;
> --=20
> 2.34.1=20

May be using goto here would be better. Like:

---
diff --git a/mailinfo.c b/mailinfo.c
index ee4597da6b..83358b7517 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -266,13 +266,14 @@ static void handle_content_type(struct mailinfo =
*mi, struct strbuf *line)
                        error("Too many boundaries to handle");
                        mi->input_error =3D -1;
                        mi->content_top =3D &mi->content[MAX_BOUNDARIES] =
- 1;
-                       return;
+                       goto out;
                }
                *(mi->content_top) =3D boundary;
                boundary =3D NULL;
        }
        slurp_attr(line->buf, "charset=3D", &mi->charset);
=20
+out:
        if (boundary) {
                strbuf_release(boundary);
                free(boundary);
=E2=80=94

Lidong

