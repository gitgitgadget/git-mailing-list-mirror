Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiCASfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCASfd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:35:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038A583B6
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:34:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id i7-20020a170902cf0700b0015163eb319eso2887648plg.18
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=fF8zlNMrIW2jWwIZWqUP0y+T9AWfQv7Rs8MgmdSX3Vs=;
        b=P0w0O+PoeH4NvxXU3TXaTrj3/uB0XPbRXG1ZeeoMaxo0lEzNIrxXO25Y6rSJ205OYQ
         et5lcZqyc+jGJh2uQaLCpes3AoToicJam+v75YmzkK74VJTRFEVDAmWhlqrylrKoQDSl
         QVow5QhOUwzlOrUd3pUzfrZ/2GyLxghMe8meqSWwnY8aEujo/qPLdOeGAMhV5xazY3m4
         G9ub7HhAjKzKzdA+uhH2sx5DIjmJCdJWNdsOQ3GwopdnmtIYI8vz6q23WhTWBwr1rFxd
         LdQqJ36QwGqjvcLaEHuJlVYcZ8B6NfpFJO5BLrcWo+XPkdlK9CWaI+xXGENg0Pih2EPh
         oS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=fF8zlNMrIW2jWwIZWqUP0y+T9AWfQv7Rs8MgmdSX3Vs=;
        b=1R6zHCnHfor/aHtmVu2u3FWCLW+g/rM8yk/pfcU3JTA8lD1sCwR9UmVK5+a8AYRNw8
         P7YY79vqM8MUUCAT6cBnBJFIeBBoPWlrrVrEMNFtYNmf8fEKRmAmHwLDltqdHpbenf31
         M/WDCLzw9SML6lTT8YzyKim5tFKWNkLpp4TWzYJVK0DpCx21WKo3U+/sGrmbbNhHgv0k
         ZFvT4/WruDG4/qTmhRC06XU6YuwUEM4ByNi0RGl35O6YdVkYrIgQz6xbpL4+XiIFb3ng
         xSiotUM2g+LQ+wLmqA9vV7UQT/bD8QkvxNrB7i32t0NoY4cRWv3G+RbHz2OdLGeHa39B
         neeg==
X-Gm-Message-State: AOAM5312HWqyXV5Y4nGWJ80ltYK8f8OoADVVVDvd8UK6d++WY7/bjei+
        Y4kJSYhzrySoQP2Vu6zD+yT+YcNwVyswLw==
X-Google-Smtp-Source: ABdhPJxLHmrGasKwg1a8VMw0N3ZeI/Wq1mC9psydUz7KDnzolo+rJGt84S9t5a9OkKzsYJWRDTzAdcUAuq9qiA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ceca:b0:14f:ce67:d087 with SMTP
 id d10-20020a170902ceca00b0014fce67d087mr27360899plg.59.1646159691880; Tue,
 01 Mar 2022 10:34:51 -0800 (PST)
Date:   Tue, 01 Mar 2022 10:34:50 -0800
In-Reply-To: <xmqqbkyqt9b2.fsf@gitster.g>
Message-Id: <kl6llexted2t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-14-chooglen@google.com> <220301.86o82q16ib.gmgdl@evledraar.gmail.com>
 <xmqqbkyqt9b2.fsf@gitster.g>
Subject: Re: [PATCH v2 13/13] submodule--helper update-clone: check for
 --filter and --init
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index 2ffc070319..3e8a05a052 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -2543,7 +2543,12 @@ static int update_clone(int argc, const char **a=
rgv, const char *prefix)
>>>  	};
>>> =20
>>>  	const char *const git_submodule_helper_usage[] =3D {
>>> -		N_("git submodule--helper update-clone [--prefix=3D<path>] [<path>..=
.]"),
>>> +		N_("git submodule [--quiet] update"
>>> +		"[--init [--filter=3D<filter-spec>]] [--remote]"
>>> +		"[-N|--no-fetch] [-f|--force]"
>>> +		"[--checkout|--merge|--rebase]"
>>> +		"[--[no-]recommend-shallow] [--reference <repository>]"
>>> +		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),
>>
>> Since this has <repository>, <path> etc. it should still be marked for
>> translation with N_().
>
> Yeah, that sounds like a good idea.  Isn't it already inside N_()?

Did I do this correctly? e.g. an alternative interpretation is that =C3=86v=
ar
misread this as:

  	const char *const git_submodule_helper_usage[] =3D {
      N_("git submodule [--quiet] update"),
      "[--init [--filter=3D<filter-spec>]] [--remote]",
      "[-N|--no-fetch] [-f|--force]",
      "[--checkout|--merge|--rebase]",
      "[--[no-]recommend-shallow] [--reference <repository>]",
      "[--recursive] [--[no-]single-branch] [--] [<path>...]",
