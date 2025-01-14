Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD2224B15
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818605; cv=none; b=BBFUS0qCI1uY9VctlaM40TZrBEt9cJoNROf5gV57BwLv/aeDJVbj90srkfqCLSfOfjs/vI/D5vYgp5WiUDWoD+1GVIck2TjdtA++9Srt5m4aylMPUVtY+N9j5iMOnYfduQ77ZCIB2rN7N3C5uUFeU23ak7WGIosUvybrSRRLfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818605; c=relaxed/simple;
	bh=/BpOlW620AdrMtqu1s9NIJrLjyrXy6hLhaiRHyal+nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Knf8Ns1gTTc99np92lDFVJdSoEXR9AKIh9IQen5EfRb9Vj47EtrjASuh0PQ1pNFS1MP5u3vaoBmXwQFXmd67SPZ+pg+MMb4Gdd8SosV0golEKEKoqum08jaYlByWPxtXAiuYeZuXh5nq++/B+8hOIZlAXOJeR2Mq6bsmIJHkVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5pbaCPn; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5pbaCPn"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so8379161276.3
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736818603; x=1737423403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BpOlW620AdrMtqu1s9NIJrLjyrXy6hLhaiRHyal+nw=;
        b=D5pbaCPnlcoubdgbqzddvaNNkOu7r47VGRe9A6z62aNx2N9FocNuOqD5Jan0nktsAo
         qWtvWX4rbwuLdNQTj2ndENdO94V46BZDb6G5OJ2zNlNauqXJ8BtuP3jwhUjdTiDntAGK
         rX7KBik5R7kzZcgd+381nnpn6+zOxDSq4QH+4P7MwLlFazkbvNT7t5JoXhJH/4oVDl8G
         fhCy5ELAlMDUIikqw8vr4FT4Af/QjrAcoT7n8MXIZzAFFmieN/omYqzAz4axfKv6vJY6
         NsKf1rQ/K97XWVOWbRZTMDxvrDdvPUFMnTUfugEIKbvGGQpg3kxdnwICydhRa+MooTlW
         y44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818603; x=1737423403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BpOlW620AdrMtqu1s9NIJrLjyrXy6hLhaiRHyal+nw=;
        b=d2K4qTZAPKaIjw2BNeItOJyn0wGm9kj/Xde4d94Cn0VeYlgX9w2ssIan17zFsd7Muj
         0zsSCaqEHqwcb//nGeUB8QXD8fcmU3OrtsyUQUjCG9lWMszQHi8/zIxyhXXOYfu+PqHm
         Rl5ORh5zlhq5/bolygfjhEHDTdMImH/9OL/iC/92zi/vCPGxP2ljndZ1CnxGL6T2FAby
         xHLTotiGzRjjakwRk36FXj1C0eTxSwxOaICzti6N+uv3yyQj3+OveeuYBEzpwaP+5XIc
         1F9albEnzowzDiQW5bZ62HxBTLg1ibDpAybtNjZRZkN8DzPx93XyCFrV+in5t0vXIpUD
         vvDA==
X-Gm-Message-State: AOJu0Ywh1CSr6xcCJlNN+bJwpQwnU0/zg1ewbkkBykDbEtmpwkD56Bq6
	D0dsl9CcxMehyLK/yxl2r3QzHPD7vKbu6ZmdVbBdUaPJgRqEe0Xg6l1RJ9fy1vd0AfPHLfaOjD4
	yi01nEP0AdfGvVzwmqr9Wsiuiam0Ns4f+
X-Gm-Gg: ASbGncv8WGpkyr+24AV9MM5JIvMKRAKXZwOMmhDj/drWxeJQbjv0CeYcmZxxBQHPEsh
	AavIBwAy/GFnkdAVwYNeZGqTHucDgxa3eHYV/8A==
X-Google-Smtp-Source: AGHT+IGO+YM5bV7LHA3G9l29lDuU709uUEpCIj7C8iqdd5tpB3SuXal0mALmL65ESlnga5Zk6wKFeTNUsWiyoZ563qs=
X-Received: by 2002:a05:6902:2b11:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e5742268c19mr6464620276.18.1736818602909; Mon, 13 Jan 2025
 17:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-3-eric.peijian@gmail.com>
 <CAP8UFD2uVD4S8pWpg-oOdhNi_0m0ZTGOvaJX8MpZGFU9yAbV7w@mail.gmail.com>
In-Reply-To: <CAP8UFD2uVD4S8pWpg-oOdhNi_0m0ZTGOvaJX8MpZGFU9yAbV7w@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 13 Jan 2025 20:36:32 -0500
X-Gm-Features: AbW1kva_tuIulEhA8zyNo6qxE_qoYkNNZJu6KZcgOsofyeqJr_ESn6IunX_sXb4
Message-ID: <CAN2LT1B6xCvR2+Fkj3nvz28P1csAAw7Ukd1YMXw8tZZQO16UCQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/8] cat-file: add declaration of variable i inside its
 for loop
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you. Add that in the commit message.

On Fri, Jan 10, 2025 at 6:39=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> w=
rote:
> >
> > Some code used in this series declares variable i and only uses it
> > in a for loop, not in any other logic outside the loop.
> >
> > Change the declaration of i to be inside the for loop for readability.
>
> It might be nice to say that, while at it, we also change the type
> from "int" to "size_t" where the latter makes more sense.
