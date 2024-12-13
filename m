Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4314175AB
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090282; cv=none; b=o80iiw6rUvniyq967C0nCCDtbWNCDg6ZETdy4zSBhl9zTklWLWTVjRj+vadeDf7XBG1edw7ZaZXF+EdgZRCTddaGwpSco3fbGe0Qu6KTEMY6sJdXn0K50k0W5awHSchT5j2PernNq+CI4ZY0zk6A3CqaIpGjHhEM3P/VmyH+GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090282; c=relaxed/simple;
	bh=LpJadftlHdQvriULaINlCMIuKkXgjlZhxuCUE/VigI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixkDwmSgHQhAsNUFkn9Y7tBItjAaPPk9mLshIerxELJ4tmTxZhxt2Nb4MTv0UelBHZxrlGjU4PCcLslElf86vXKv44kLNgT0a0FVcsSq4CQLJKM4tQtBwZUMDUWxnD2x7JREyd0C9Bx6QdkijOGSyJfi/+Iw3a5m3ydGF7QmSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY2kVYGT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY2kVYGT"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so2764167a12.3
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734090279; x=1734695079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB+1kxFcVPHpVMKXk8x+cP+0Z6eAeezSFfrZ7H9ByfU=;
        b=eY2kVYGTMeBhLG7xC3Wd7ADlH5ha56w7JJyDdgZ7O/7C0ECZD87OISKIT7QHNThMNj
         OLqGeLhs6rQaHH60JXET4nWB4Z2cTVhrdwTyx4MTjtDqoovCzhXzdzg9HNLuGXw6pzTv
         4WlC3qyzp7V7KzYr4Jgq8I7DwNmv4xXX++6z1hpcVbRluNUswAOUjacMbI3R4bHwSFOk
         jLUVADQ+acheopDZh/oRegN9Y/YTinmskJyE6zX+w2bw5fxLZtwylQRnHgFUp29FozxW
         g3DD0hFt8ozEyiJskKIMZRummFffYvywPi2VzdzDKrtFCMOB9GWpfnpuuLcO2Dzzz6KA
         t9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090279; x=1734695079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB+1kxFcVPHpVMKXk8x+cP+0Z6eAeezSFfrZ7H9ByfU=;
        b=RQ5h9BorTpAL1kQiqfmq9WHq9YexP0iBjiLn1ntp/XYdcj/3nz9/W2w11f/dUus3pC
         qkt/MTFVq1hli3c819Ys9Fa63m/c4s62nQi9mjNGGPu8n/Ie3Yy/5ug8M2Ep0LcHDlMN
         Oge9PiL9s1zRhYLlTPFKpyJ8r2oN1bbEyBxCXzFfcAYXJ9Fl+T91XfeeAzIascmpdceM
         sU9aZLdS35cU1xm44CxonBd0RzedQSNyS7+hFWQjwNst4r/jdPGe+s7NsyF/d8EC6G5Y
         /515BHUT1MtBJI0Afg2Y4uUdU7UBs4RGWAxpmv/4CdpsseERUkif6jRH2ringsL3dRrY
         11Eg==
X-Gm-Message-State: AOJu0YwACvORWMWYdAVqSAotlWHFA+yGnikNwfcQhSmoctwRxFDZmzyB
	P32fz2s4RXZVYKaLX/I6gtAx8sKaiW3yPVCfKlef6VLDMXpEoS9kGxKzsl9i567vYpln5XEaHGs
	2/eGh12lBSXqEG802rWgMJEKa8xfOLUlJ
X-Gm-Gg: ASbGncuo4YLDFOCWn+LT1EPblBV9I6wwUhdSpBvFZ0vKna35gLDZr87Q/Fuu8ksyXc8
	bkaWi9ekOmnP9R1y+9pFKYE4gZcVTHgmZkfXaNdl8
X-Google-Smtp-Source: AGHT+IGpBWYmDYMqwkrCbCP9ywCFaKZmpGXAcbanhFFYCmCpRnQml+4kTZB4r1FeOUWsHFFH4lt/VnY+TgmROvrZ35w=
X-Received: by 2002:a05:6402:388e:b0:5d3:f141:ccf6 with SMTP id
 4fb4d7f45d1cf-5d63c3c1dc4mr1654046a12.32.1734090278967; Fri, 13 Dec 2024
 03:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com>
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 13 Dec 2024 12:44:27 +0100
Message-ID: <CAP8UFD1MOChEhJhW1i4E3D62k_to5_r3P05LCbFRXMrEunvAfw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] refs: introduce the `ref_transaction_update_reflog`
 function
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:36=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:

> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
> +                                 const char *refname,
> +                                 const struct object_id *new_oid,
> +                                 const struct object_id *old_oid,
> +                                 const char *committer_info, unsigned in=
t flags,
> +                                 const char *msg, unsigned int index,
> +                                 struct strbuf *err)
> +{
> +       struct ref_update *update;
> +
> +       assert(err);
> +
> +       if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
> +               return -1;
> +
> +       flags |=3D REF_LOG_ONLY | REF_NO_DEREF;

If we could switch the above lines like this:

      flags |=3D REF_LOG_ONLY | REF_NO_DEREF;

      if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
               return -1;

maybe we wouldn't need transaction_refname_valid() to take an
'unsigned int reflog' argument and we could instead use 'flags &
REF_LOG_ONLY' inside that function?

> +       update =3D ref_transaction_add_update(transaction, refname, flags=
,
> +                                           new_oid, old_oid, NULL, NULL,
> +                                           committer_info, msg);
> +       /*
> +        * While we do set the old_oid value, we unset the flag to skip
> +        * old_oid verification which only makes sense for refs.
> +        */
> +       update->flags &=3D ~REF_HAVE_OLD;
> +       update->index =3D index;
> +
>         return 0;
>  }
