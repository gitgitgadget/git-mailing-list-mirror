Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C91C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeI1EDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:03:35 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39458 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI1EDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:03:35 -0400
Received: by mail-yb1-f193.google.com with SMTP id c4-v6so1782288ybl.6
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cI6Jkm0aZaf9fKgowcLpBsbolI8Uvl697NrkYPKL6A=;
        b=PXiO26vFN8051YJ2sSa7LKdj6oDPXz8x2/rn05yQEWqbEuxX02Nk5DxxOlXmBAwtI4
         WDWiPSmjp84amv15q0/pAeZQ1u9D0prLjQB7vcBMdpuLYjS7NCmdEqfs2pSoXyTzbAhh
         LGCdpfuwWW9gefPYFHecKcu6KnDjnwnbHnrZ7A8HY7CSnWAhgaJUBs9zjT3dulPDeCpW
         RcfoovBDFCYR9F+zybdP6BinIdwq2fdGxBM1VQ9Aw5BxhtVKU/xteRQpqzL3x1rvf0Hn
         pvSHVw9frYGh6OVV7+konlXp6XhB1kxtYRJZ9asbb99VcX0MbBk9sCWESmKgQUfIhOVl
         XW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cI6Jkm0aZaf9fKgowcLpBsbolI8Uvl697NrkYPKL6A=;
        b=LHu2IMfeWEO0RFGxnx0Zld0sOcJi0f4Nrkp5KpKlEa1Kyca3XbOsof/MGW6LoDlTkg
         x1EnvzmSfu0+Wmei8Gmj/oV6RCIJsq9v9JdbE3L7z4cwET1YvY4jixD7oTpTF29kajA9
         WDkY87R42h3OWfr5xXt04Rd7SfgZwjWGiwRNI4BUMlNSO1BtugEqdv7VGEwFITdxT9N4
         02X9+sb5WG42TmC0D3W2UNH5S2lmOA5cH9KSnLdOWMamdxeO/Fg7NR/AoEGzh6hXxKSk
         C5xFGo+x+bfuWwQEmaFOG2ykQfX2+jFP+CdDAbdzprSB3SLEjHcFrl0gJferJqSoVvpI
         81DQ==
X-Gm-Message-State: ABuFfojb+VNz8qKYRS62cUd54RCzS52v8+9TFrcpeA2AAgUHjhHnwESO
        HzDZU1RTa0uWsDHdlcRjWky/z5iZd1kmWeul77nrWyiCVxI=
X-Google-Smtp-Source: ACcGV63KpW/hEVfNeaI6Mdqyonb9ZVHF8rHLy6BllqHiMXL3eqIa/tmB/9w9IOpEn7elpIfZPZhiNQC+areSerZLqC4=
X-Received: by 2002:a25:e481:: with SMTP id b123-v6mr6802346ybh.416.1538084595348;
 Thu, 27 Sep 2018 14:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180925225355.74237-1-jonathantanmy@google.com>
 <cover.1538075680.git.jonathantanmy@google.com> <1ae00ea1fdd1118b92ac90d67f27a988750b60f2.1538075680.git.jonathantanmy@google.com>
In-Reply-To: <1ae00ea1fdd1118b92ac90d67f27a988750b60f2.1538075680.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 14:43:04 -0700
Message-ID: <CAGZ79kZOecyJzXoD0ghZFKFWuWf-V0Sb0bYbBangTcbLGr_xVw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] fetch: do not list refs if fetching only hashes
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 12:24 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> If only hash literals are given on a "git fetch" command-line, tag
> following is not requested, and the fetch is done using protocol v2, a
> list of refs is not required from the remote. Therefore, optimize by
> invoking transport_get_remote_refs() only if we need the refs.
>

Makes sense

> +
> +               /*
> +                * We can avoid listing refs if all of them are exact
> +                * OIDs
> +                */
> +               must_list_refs = 0;
> +               for (i = 0; i < rs->nr; i++) {
> +                       if (!rs->items[i].exact_sha1) {
> +                               must_list_refs = 1;
> +                               break;
> +                       }
> +               }

This seems to be a repeat pattern, Is it worth it to encapsulate it
as a function in transport or refs?

  int must_list_refs(struct ref **to_fetch)
  {
    // body as the loop above
  }
