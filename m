Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A022B645
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801448; cv=none; b=keZl5ePsZ19NHtPPnchlQ15xu/HFzdqEQdl/uiEmND0S9WgFy8ojBGuF5uUgCUdh+qeN0l2w8/WbyHykrX1AvQXEWA3ip/eFWWGCmqsMbqTsWzeodN3n1Nu5qj4NYz7Ntj6/6xSfZbO6EhWQ/lWZFsHXjvNDdK2VZRyYmYzSSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801448; c=relaxed/simple;
	bh=9kjiPOdVqBPnJQo1b7zeEHB/RCGpJ/5WgVcuq71dGkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9F8Z28QMQyWDTfRnD+/cl1ZcAskfs9a9vJR7OnDvbnl+hr4mRl432/pcU8tQyr998d67H9L88PL9jDnJGRVDmyzkNvM1BLHst1QhiSIHATf83kLGOXlKukUi9IxbB4wlHxQ/CFmqwn2IZUParBo9redUE6iaM0ozDgoXtGMnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kumkm/0S; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kumkm/0S"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2e444e355fso1715184276.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729801445; x=1730406245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ch2qvc72lpDDQ5Fc371yNCxOoKyxsyVJxhiwX5zJQcM=;
        b=kumkm/0S8cAHpJVOgoJhOreP9UkypQYkv2U1H6G+zJsxOoeRu4E5RHqzlYl0+esI7X
         qg/9dN/8epNV62b6HH1loU5svyz8wArnU4GdoNqXXM7J3cvyY0ATDoYrRyda0Nmjqe3Q
         Z9EftCTNmSPDT/4ILRQ6HCMglzrSqlmu264gEKIBkZz94Qi4FAwppTUy8/b/bXI3rsqe
         ZZL6uYYzZD0g8vjAvecv7OPJObxU+BLqslBtLXSABQnUvGcy9rwikXYrBOzvmQ7ZEK7G
         hGs08/8KyJMnX/hlDHncGkWUTiKTa35EG6wKr7IKYqi9d/ofhlWMuwDXtTXGSB+BHDlO
         8mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801445; x=1730406245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ch2qvc72lpDDQ5Fc371yNCxOoKyxsyVJxhiwX5zJQcM=;
        b=m6F8CsEFw/exL/ztiT4gXuoPBjIu41yrS5pq4fuRDLl3DS2rn4i4akkyEgvpi8bsbV
         vopvvqwj5LbCk7WOnGnVlnujXl/bryWTcTGvt9QwDUl6KBWbAf9tJuLIyJWrTjFqq+lD
         OHfJ/eGprBaQECHv47OnJZVlMhDPOmTNai6a7loRqhCx37mWwCiBEehp1ZAnvdIoXVah
         VCYDYHh0VaD7xAxiHrCMDwwFFzGwbQ4S0sqC1AgGuqHIjeixPMO8qpqdvBSxB65rhjEr
         UftF7M4105sQBAzMR2W0QvG1u9n8lWSfEzOomsqDlrWPaWEGrbcLAVfaMex0OXyXnNmt
         fC4Q==
X-Gm-Message-State: AOJu0YxVdmOuO/Z9Iip78/zaBFSLMAykJ+pwRPP3PQzgfVgk1fyJs234
	0km9R+BwdZUiQDH/mF+qXr4EH7Ga/I4eD5euYkPGgrVdhGwWmix1hTGjWctVOBzdCfDYepahmwv
	O/WEXlQwyX+MxIISO8AF1nXGtMb4=
X-Google-Smtp-Source: AGHT+IEWpG5pCoAdVkTgLKacviXGRpR1XvMpSXHCWmojOT7nQZlltGidyYh7Bi+orpOmd4safWOnfmzVTshw9kZ5PDc=
X-Received: by 2002:a05:6902:1785:b0:e29:3359:e127 with SMTP id
 3f1490d57ef6-e2eb38fe011mr2648068276.4.1729801445415; Thu, 24 Oct 2024
 13:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240926013856.35527-1-eric.peijian@gmail.com> <20240926013856.35527-5-eric.peijian@gmail.com>
 <CAP8UFD0-EPZkdWd8xbg-Yt+aSGfJQE1cFz62Oxwjm-8N1sQ2PQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0-EPZkdWd8xbg-Yt+aSGfJQE1cFz62Oxwjm-8N1sQ2PQ@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Thu, 24 Oct 2024 16:23:54 -0400
Message-ID: <CAN2LT1D2h-D38F6ELv5Opb1-TdQiFXz88aqA8oxOOfmXw-dTeg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] transport: add client support for object-info
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:48=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 3:39=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> =
wrote:
>
> > +       if (transport->smart_options
> > +               && transport->smart_options->object_info
> > +               && transport->smart_options->object_info_oids->nr > 0) =
{
> > +               struct ref *ref_itr =3D object_info_refs =3D alloc_ref(=
"");
> > +
> > +               if (!fetch_object_info(transport, data->options.object_=
info_data))
> > +                       goto cleanup;
> > +
> > +               args.object_info_data =3D data->options.object_info_dat=
a;
> > +               args.quiet =3D 1;
> > +               args.no_progress =3D 1;
> > +               for (size_t i =3D 0; i < transport->smart_options->obje=
ct_info_oids->nr; i++) {
> > +                       ref_itr->old_oid =3D transport->smart_options->=
object_info_oids->oid[i];
> > +                       ref_itr->exact_oid =3D 1;
> > +                       if (i =3D=3D transport->smart_options->object_i=
nfo_oids->nr - 1)
> > +                               /* last element, no need to allocate to=
 next */
> > +                               ref_itr -> next =3D NULL;
>
> Space characters should be removed around "->".

Thank you. It is fixed in v4.



>
> > +                       else
> > +                               ref_itr->next =3D alloc_ref("");
>
> Here for example there are no spaces around "->".
