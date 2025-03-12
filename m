Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89331487ED
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746014; cv=none; b=kce39sr0BX2+yxNoHZvRtGM/V0uDUVPYwOaQsC3AbLs/MhrBba+zSF6H7SAnoBIlHorNdze08xf8RsS+zisVA15GE/uMgVDVeUwHR8ES+9MIypEGMqmOrPaFseykRWcCjgYIJfeZJxsiENMk9Iw5YR3mYcUzI4TnBFWRd27jcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746014; c=relaxed/simple;
	bh=+oli9qBIgP5kNN8LghBh3nRP2zIHV8Gmz2ZqIKpRZgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie3SZMkaVQMZ9ElYew4fiCVtmiGcfJSINiYaU/19YStq85Cch61hlun0kPQatFqyzFJljvzxThrKPKM0E0CcUG20jL4I+YF7uqSOWTNMzmxkaVyF27/4vmEe9gBlE9MXQ47Q3DPl7TA7o8CfdeFpoeKQRr3bmcbis15vApzOcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCQdhiTv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCQdhiTv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f7031ea11cso63989867b3.2
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741746012; x=1742350812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCmrSq7m43IuyriNj7j46USrDuDn1fMvYWxze1ZVH8=;
        b=JCQdhiTvyR6zw2r8ZoD+g7Zay5nbQlDa+/vuPm4nrwp/UuTRVE0eEVGhznLIiiWKbs
         aTo5cxk/TuZtd9XUiogv/AoRjks7mIo9NrELxh63L6QtDx5ZmQUYhs5KS+QKORHSg28U
         9dPItuVaQceQX8tBGmY0LLq/+0yXWkVFuyqcOFFYTXBF63HbYtuVts3mNrRhzhWeUWjz
         Ib0PgnQcq2XoUaeCSj8jJqI+bnW7uCSIsXg6P7QRNZ/WBdlqtwVv3W63PdwnwenLE9LE
         k5paA8uWY+pVic/UNC7p4Opfq1zw2v1ShSFT2/p2LGbztDzlYgATn0ORfwlOfVHjMrmn
         ufvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741746012; x=1742350812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCmrSq7m43IuyriNj7j46USrDuDn1fMvYWxze1ZVH8=;
        b=sn+AA4Gl+jjVfquyb85qvMVSXVzMzcAUqe5VB1pPDJl9NZTyMnWtZwxR57IpJGqtlq
         jhTUyCJvzLZI0dy+RgHQm1QV/2Vch+p5B0nC4i0HqkIM1/I7FiuHGI5+w53PGVdLExc6
         wceCUsqORwiaIDNzZoCAHquDKHH7S8wj5wpagPxZaC9JiJZQVM7UxRd/3+yjw1KL5nJ9
         i5438rTMRQcqpBDMovC5sYOTkCPxo6gw3Ss4RpAD2OxDS4jSz9phtOQPohhhGV5o9SfH
         dUZvA3yAMrtKTQz4EdNscOCgMi7eu/XDh+eiUTL8Ghzns8vaBrEwM3VPVmbOy+zqhRfR
         FhuA==
X-Gm-Message-State: AOJu0YzCkXMJMdZwIc6PVpPyBBCdWjXvih6O6eSWohQGs8Zlg+R7Od2P
	F2+Ck2TNk/GOdzNu8rcxqMJDdcfyeoV/5Xs3KmyDX2hchC8c/vkabJHVjjYQmGpxpZlAAm6q3Wf
	7IpVGYtG7Q115g4lgbX8TsdL2Hkg=
X-Gm-Gg: ASbGncsh8uVSWEFmRhELM+16Vu8hbUWsp8R7lehv11zyG7OAG7zcCQnq6C2X3avKkAW
	dDUWMMZoIkBB8KKzIOM9doS5Gb0/4QQRfcGswGkyjIKPn4FcMKgYoD+4kysn/8oDD+qCXZuieVf
	EXDCmEytlCW7iCZohCFXkUj9fiihs=
X-Google-Smtp-Source: AGHT+IGDZCWl8gSHtTNXiasYuObmUlI0ouBulU3T8AtRSx4DeZZVg6VMeg6/UzDDW3YAz/UoSIviNZ36CxAinK8o5uw=
X-Received: by 2002:a05:690c:6f84:b0:6fb:9786:5871 with SMTP id
 00721157ae682-6febf292ca7mr268162407b3.7.1741746011037; Tue, 11 Mar 2025
 19:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com> <20250221190451.12536-9-eric.peijian@gmail.com>
 <20250224234720.GC729825@coredump.intra.peff.net>
In-Reply-To: <20250224234720.GC729825@coredump.intra.peff.net>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 11 Mar 2025 22:19:55 -0400
X-Gm-Features: AQ5f1Jo-Z_6gAyYpjDKFJKPyQ30A9M1tmQU8uaOuXPFHCm6luTPaFQRPgAn3_MQ
Message-ID: <CAN2LT1CsjA7V_y-OqDNREkpERHEBcx627JhCrzg9GHfWS=b0NA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:47=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 21, 2025 at 02:04:49PM -0500, Eric Ju wrote:
>
> > +static int get_remote_info(struct batch_options *opt, int argc, const =
char **argv)
> > [...]
> > +     if (gtransport->smart_options) {
> > +             CALLOC_ARRAY(remote_object_info, object_info_oids.nr);
> > +             gtransport->smart_options->object_info =3D 1;
> > +             gtransport->smart_options->object_info_oids =3D &object_i=
nfo_oids;
> > +
> > +             /* 'objectsize' is the only option currently supported */
> > +             if (!strstr(opt->format, "%(objectsize)"))
> > +                     die(_("%s is currently not supported with remote-=
object-info"), opt->format);
>
> BTW, this strstr() isn't quite sufficient to prevent problems, as it
> would not find placeholders which _do_ exist but which aren't handled.
> One of the first things I tried was:
>
>   git cat-file --batch-command=3D'%(objecttype) %(objectsize)'
>
> and feeding it "remote-object-info /path/to/repo some-oid". And it
> segfaulted.
>
> -Peff

Thank you, Peff. Yes, you are right. It is a bug. I am adding a new
logic in v12:
1. Iterating on the `opt->format` to see if there are any unsupported
placeholders. If there is,  error with unspported placeholders.
2. Adding more test cases to cover different formats, e.g., just
`%(objectsize)`, just `%(objectname)`, mixed usage of supported and
unsupported placeholders.
