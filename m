Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF011F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeIGBbk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:31:40 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35304 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeIGBbk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:31:40 -0400
Received: by mail-ed1-f52.google.com with SMTP id y20-v6so9991872edq.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 13:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhXqNB4fyL0jyw7YJJ/d8tRSXTyYdx2XWds6FQbDA8Y=;
        b=j/kQmN7DiQSJEL650TC8ZOO+BhMNPO44RHMlmFs6CUEgptoxrLzDpM9u7sdVt9gyt6
         qn8I407aijSG1NhunmxfSr2FemIWpYcMXkxYxtbkXCB9sJE6xeBBOsY9DxQrJg906peD
         GSmvL5b42n+aRirKwaLmP3v3NigabLl+yNdFoZitId5gjcz2LlfzH0xqHQdMePn3YK26
         R3HnR+uLazzqDz2kamQDH4GUt1BzHuj0imMauDQRsjKDOGCZtGnOiwki0uZqfs4TBF0H
         31xNw8yOPngToDC2cOygHjpn1vWkzlfeTR0B2Izfu5hekZUPusMmUMVOgejZv2GAWBgK
         yHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhXqNB4fyL0jyw7YJJ/d8tRSXTyYdx2XWds6FQbDA8Y=;
        b=iZtALjP+NqohD4iBeHHUaPPNFoQdfWK/uuYVbm0GovIzyTZORMQDPsqHmvKwq4EPnu
         aB6wvpWi4Wao+z1Rswi+GzAjXNhmJkGEnqURe/F1ep3ln+POmrHEwpZucMJPRyXFXqst
         hi3sVclFoQOTUsNWCH5o/1Y+j5S4wo35AjL1ouKe6ZIa+qJwiGPSmdRvqCwYGgXCZVeQ
         0e5IiVgX4fVAVJP5peii1CnoNNuDGRYRLcYbF8RfeJqmtcViwL8Vlten8nSTeLCAUy3q
         BM7vVFwwB18MEIxsnaI3O0i9R7zxOE4/dJ0ATmTv3wnj+3aCdGhylHx2aAlscvZ7Jivy
         eykg==
X-Gm-Message-State: APzg51Cnc98bWUBFGE9zKldDUx3KzWVDXBgc94Np6ug+lt4mdtccGebi
        okJoUNU8B0Jk7v5VMuGBz2srHELuK30ZKFrA9DWzoA==
X-Google-Smtp-Source: ANB0Vdap6I7+NjA7Hz/n1WfpShTQRGSAipCQ34XPGoheI3XNIPDJ1H+rTJJAaUJDiPNeOwFZO1JhzfDBt+/RiPrmHgE=
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr5667832edh.190.1536267266026;
 Thu, 06 Sep 2018 13:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180906191203.GA26184@sigill.intra.peff.net> <CAGZ79kbi=Ppkt4tYx+G_RDwp7e3+SU-LofZ-QzMsO2=zEPucsA@mail.gmail.com>
 <20180906204932.GA1482@sigill.intra.peff.net>
In-Reply-To: <20180906204932.GA1482@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Sep 2018 13:54:15 -0700
Message-ID: <CAGZ79kbFe8WMswWy+SorYUvEj2r5rUQdjx=zbVK5BfeU+Mgx9A@mail.gmail.com>
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, timschumi@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Does a hashmap guarantee an order?
>
> No, it definitely doesn't.
>
> I guess the reading-between-the-lines assumption that I didn't quite say
> is: I think most (if not all) of the users of sorted string lists don't
> actually care about a particular order. They just want efficient lookup.
>
> > I thought we had an example of an ordered list in the submodule code
> > but could not find it, maybe it is gone already or did not rely on the order
> > as I thought.
> >
> > It turns out we make never use of a custom compare function in
> > the stringlist, which helps gaining confidence this use case is nowhere
> > to be found in the code.
>
> Plenty of code uses the default strcmp. You can find users which assume
> sorting by their use of string_list_insert() versus _append(). Or ones
> that call string_list_sort(), of course.

Here comes my reading-between-the-lines assumption:

When using the default comparison function, you probably only care
about the efficient lookup as described above, but if you had a non-default
order, then we'd have strong evidence of the contrary as the author of such
code would have found reasons why that order is superior than default order
(and don't tell me a different order helps making lookups even more efficient,
this must be another reason).
