Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C043F1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeJMHf4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:35:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44833 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeJMHf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:35:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so12892816edb.11
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YN2unw0DaZoaYwoWvPoP1sQaMMA7tiVIXy9gzVbSLiY=;
        b=MU5sGQFUWjfLaSxEmdswDT9KzHanOUq4Q6iydp6ltwUYms5eUzcLusQ4319hUI/abK
         +9k1MGu2Lk2Yzo6m7ySg9DMu+gM8BfvCEJ/EFSRITg6fJgimDxNUOGVGvCOpDCewi1ny
         A5Hoi6q+mdApOuhIoDceEPcv1MKfv2S0BT65vaD7V0eR02+AEu4schzIc2yb4yaSw1NR
         e1/vtkIhep2w+bhMaRKEb7tAdypVLB8LFut8WrBKCcrmR0PXjnXab+laRR8zjSvvHVKL
         HOxsDrmt5Q4ve7E9e9WFAYcMMFe/ceTFXZm9nWx4IS4ucfSyA4QRqYhdtrmqWqmgCbzd
         bcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YN2unw0DaZoaYwoWvPoP1sQaMMA7tiVIXy9gzVbSLiY=;
        b=kKHJw4W7MkhmrosW7jhjesaoBaFdR+pcOqJN0IsOsBlgyGzK1KUy78DxZot3bBplTV
         B0s+0w1aIDL0CviNkfm41axywqAepl6MZMsGsrsEjBd/PyI+MPCg7KNAAaxt7dKNyH/n
         gFtV+Qh1DM7sIJ162M8pjp7L4XNG0NsWYp1PZ8z0m1udRn/koLLhQ54AzO6UjQMTgpRJ
         uQJc9/njxdNDV/vyDR8BWuEhQRVLPvumgNTYqlXghZzR//QgikfvGcxFkMM0u7flBILu
         nXWc4/M9VbXCaLCMYFWRnpnmgzu6SPq45FCyStauGm6dfMsZDhcfn5PENwjadB5LY0DW
         ecfg==
X-Gm-Message-State: ABuFfoiNgMOYjpFcvIO6f6By6b3wRdY2nRkJdESMlcnYjoj40Xi7oMO/
        DRwDMb6Km/ZiPlochaFHd4ZQNmfGiN2dn4FZQeFfcA==
X-Google-Smtp-Source: ACcGV63LDqyr9VABefuvZpAP3TaY0OnXiqYWJYy4xt91FAHZSonyTgW6nSInjpDkQQpLIqPrXggpUJcQ4auPcvnjZ/A=
X-Received: by 2002:a17:906:1f13:: with SMTP id w19-v6mr9175543ejj.65.1539388866328;
 Fri, 12 Oct 2018 17:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-6-sbeller@google.com> <20181011221114.186377-1-jonathantanmy@google.com>
In-Reply-To: <20181011221114.186377-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 17:00:55 -0700
Message-ID: <CAGZ79kbr-K3OARrn=3dGTmeMUUVVHPw3fp9zX=vy3pJrv8g2Tg@mail.gmail.com>
Subject: Re: [PATCH 05/19] object: parse_object to honor its repository argument
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:11 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > In 8e4b0b6047 (object.c: allow parse_object to handle
> > arbitrary repositories, 2018-06-28), we forgot to pass the
> > repository down to the read_object_file.
>
> [snip]
>
> > @@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
> >               return lookup_object(r, oid->hash);
> >       }
> >
> > -     buffer = read_object_file(oid, &type, &size);
> > +     buffer = repo_read_object_file(r, oid, &type, &size);
>
> There is still the matter of the 2 invocations of has_object_file()
> earlier in this function. The first one probably can be replaced with
> oid_object_info_extended() (see the definition of
> has_sha1_file_with_flags() to see how to do it), and the second one
> looks redundant to me and can be removed. Apart from that, I don't see
> any other invocations that need to be converted, so parse_object() will
> indeed fully honor its repository argument.

I will convert the has_{sha1, object}_file[_with_flags] functions
before this patch in a resend and just pass along the repository.

I'll defer the change of logic to another patch to be followed up later.
