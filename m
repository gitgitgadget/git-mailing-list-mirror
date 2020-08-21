Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6FC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F8220791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj34kO/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHUVSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgHUVSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:18:10 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF52C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:18:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a1so1526681vsp.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8eiVOsBWuH7GqdTrBbN1LEmwgyysNy8rvyR1ix9xgvc=;
        b=Hj34kO/tmkNlP5ImpNh5a19+UTJYtjDnh7BrB3yj7Ki4FS/Z+nVZhBckKknWODcq6a
         m5015LpQchhZGw7ZmO16SWujSlSQSBO9n7M4CWUz0QPfdWuvJZZKSykBvoGL4UjBY0kv
         FhWq8rgzo6GrogN5djEFti9BgXGc/PzcxexDkH8R90QbbvHmRNW4n9mosXsCQ2NokfmR
         V4xizF49y3NQFBqIZSkIUOkJXaWduVynWcgzGrJ7hV4RFDO1LgATOn0hu7PdQPLZHIX0
         QOkx3h1rgZZ5atRr84c03T84w2LDW2PVPfGKEItuNxhiJ1sE1UZ3G0MgjwAxhkuG8v6/
         CpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8eiVOsBWuH7GqdTrBbN1LEmwgyysNy8rvyR1ix9xgvc=;
        b=QHsft8q59Nmb9v7r7ULiyl0VgG6UHreMWqP5juMb+gc8kOam4WKw6fw167afdUCHJo
         bd60u0fuZhBzn0cWifd0WUsaakNPHo4vI8RVx0KlWV4g+ESGgJGLtIt7a3fnS+rJdKDM
         Vk/fe88q9B3BSd/OwDFHn9oBgVy3hclRyiMEvOKcu3F2OtE4js8RDbuuDjNsrjFOJQtK
         KDS8xaC1vhhw1twfJYIPXyxIdiDVpD6rZ3yUvSOThjhAeHj17XHrJFECsEqahOo5wyd7
         mTZI8tKqRcs/q9IBFGNTEWEQh20pqeL60JFx5HaTUb6H58e3diyeymiGdocAyhbVTHYr
         MTLA==
X-Gm-Message-State: AOAM530leYYov/A9t93E+SDYxTPRqXxkZpjWNmybVG6WxR+T9g8e15uN
        ANnaWoHXhjn7oWlrBZS9t/QMz7nas26yIGUfmEc=
X-Google-Smtp-Source: ABdhPJxKNueiz8mwnyePS7Vkjy9RKaYBj2tNwlihopIK4bTcofes8GTOpNWso6zgcEKnHfjzfbXsqm6+ugDQw+CHgT0=
X-Received: by 2002:a67:7d8b:: with SMTP id y133mr3379691vsc.87.1598044689488;
 Fri, 21 Aug 2020 14:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200815002509.2467645-1-jacob.e.keller@intel.com> <xmqqk0xx455u.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0xx455u.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Aug 2020 14:17:58 -0700
Message-ID: <CA+P7+xpew4-ZxcOjuTqq7B3ziYOpNzUWSaTMQLRnxZQPsb1PSA@mail.gmail.com>
Subject: Re: [RFC 1/3] refspec: fix documentation referring to refspec_item
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 9:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > In commit d27eb356bf25 ("remote: move doc to remote.h and refspec.h")
> > the documentation for the refspec structure was moved into refspec.h
> >
> > This documentation refers to elements of the refspec_item, not the
> > struct refspec. Move the documentation slightly in order to align it
> > with the structure it is actually referring to.
>
> Makes sense to me.
>

Hi Junio,

I'm thinking I should send the first two patches a separate
preparatory series while I follow up with a v2 of the RFC of negative
refspecs

Does that seem reasonable?

Thanks,
Jake
