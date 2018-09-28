Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389721F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeI2APY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:15:24 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:34019 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeI2APX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:15:23 -0400
Received: by mail-it1-f201.google.com with SMTP id p20-v6so2064953itg.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mPn4ldL5RzAnGWLHesULErN4Z8IVOY0lTy8BSxAhLRg=;
        b=HFt2b6q2rYH3IsW3/Fzi+uRF5TOMkoSf1YiZWV8RBR7B8wri+cZtKCpnMyD+wBd3Oh
         TwktFcJeUEhMAhjbkb+cmqYMQraPhYowJTTUv7Bstw0QfT+MNOszlnoioIGwyo7R6yps
         FKRma90pFtLBSVs5YN+ATQJMI+owT9f7Ge/ujxQrYqbiBogD2K4RoOzZfepwfZOowJxe
         uCVmDjJFAHjBXwdU9G5qxhiKw09B95Y2A9ziTrsieMZH0zJtAKXqTvHrKeVaMvDWnc8l
         Ra8pLEzhqEljCgkOtS9En4ahr9lob6EZ07s6bG3ycGP1vvVFhw7X6qxGWeUSnrnSCHJg
         gH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mPn4ldL5RzAnGWLHesULErN4Z8IVOY0lTy8BSxAhLRg=;
        b=bmMLFgN+mfYbSxKp1tVgk6/KV4kLmbOxZTrDFdUkSkpS0sBmRZxZQ7FBTlyisN3jWA
         S7/yrLS4KRAw6aGXkzgD6ROZ2XXrkhRkOFduBqCcM5da0Y3uiTXZMIwVVhIEZY5yI2YD
         po389ynrRnwVQtVvYGrPeEu6sLBnnan3TO1whbcr3u5RKCuUGHgAG2SEbnqIbAj0BL9U
         y1ZPXM7g+KV1bTXcVIScmnnOgsG4DbpngB+FFc9sOsDh5qrZ8iwNPbw6r0yjR4Iw97Ye
         ajA0MWjqY9Zdw+4L7fycLUc3EuVw1lZaqjS56iN91BG6+49SUhZULncCaijjjcs1i/kO
         r7mg==
X-Gm-Message-State: ABuFfog4RB2vDvy7FPgleCHRRQEv1UPXZLFnShhHa5n5jrxzeS9yeST8
        mtoSBb0PoV9KuT36fiqtSqDwAXP9h3IMFjICSjWO
X-Google-Smtp-Source: ACcGV62I9wEa52jQj1MYeluEswZwKLsWOewCcDpxgWRPE9IKXlmQeoGFKJBqDNBIjeTnRFOnweu/0Hpx/1s8oVb9Iuak
X-Received: by 2002:a24:9f84:: with SMTP id c126-v6mr2386867ite.29.1538157031069;
 Fri, 28 Sep 2018 10:50:31 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:50:27 -0700
In-Reply-To: <CAGZ79kZOecyJzXoD0ghZFKFWuWf-V0Sb0bYbBangTcbLGr_xVw@mail.gmail.com>
Message-Id: <20180928175027.181442-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAGZ79kZOecyJzXoD0ghZFKFWuWf-V0Sb0bYbBangTcbLGr_xVw@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [RFC PATCH v2 4/4] fetch: do not list refs if fetching only hashes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +               /*
> > +                * We can avoid listing refs if all of them are exact
> > +                * OIDs
> > +                */
> > +               must_list_refs = 0;
> > +               for (i = 0; i < rs->nr; i++) {
> > +                       if (!rs->items[i].exact_sha1) {
> > +                               must_list_refs = 1;
> > +                               break;
> > +                       }
> > +               }
> 
> This seems to be a repeat pattern, Is it worth it to encapsulate it
> as a function in transport or refs?
> 
>   int must_list_refs(struct ref **to_fetch)
>   {
>     // body as the loop above
>   }

The repetition is unfortunate - I tried to think of a better way to do
it but couldn't. We can't do what you suggest because this one loops
over refspecs but the other one loops over refs.
