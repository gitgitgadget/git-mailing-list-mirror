Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084BD1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeDJS1f (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 14:27:35 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:44047 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDJS1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 14:27:35 -0400
Received: by mail-yw0-f175.google.com with SMTP id z21so4338956ywg.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TfoBIiBcJleKPSg9xhXB4hTAbRNCEWzae49aSpEUaas=;
        b=Hm1WFI+uKCxNAAJSo90E7N1/BJAsXIaoPNGypXx4QyzPbmdwImWM9byXCjZ64vvqce
         49o3MkULVgImf66UULQa8omsQ58km2Cp8HPuFc9+JypLk9Oa5RV7YGhiirJKRgbz39xB
         KjZD9NZNdQsz+j8LLXj+rmQapGLYO+w2W7iLUBaTRrqQpPRJBPExaeGtquzsVRaF5cPG
         X138sY+ic8kuctzLEMXBItnQIunTG6oepK5m9KTHubZHrupQrQaK5w3ChPjkrB3E/WdA
         YmJC+ZC0g6snBa6H6ZNOIww0U5ziTqW1xfW6qfXxMiKRNiPpz7qAdwIOHwVTKyQNqgRw
         FbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TfoBIiBcJleKPSg9xhXB4hTAbRNCEWzae49aSpEUaas=;
        b=eMqNo79nS8NFEQrGictOemp7cDn5WnDhUVNToixH4VKXuFFL5i8fRdS5hNz7Me1Pwh
         pOpiPHFY0GjAg2QgZzOC4Uq/BrU2ynAUgGHB+9frmYUvSNRuEvRSEw9/cpQuAvDzmEaT
         wPMh8hctz4rYA53mZjt2eQzKRT4ZUhyQbab5X484N0pKuxEZKsS4/7LWwSnv+KV/u1GB
         M2CkZ/UmdCwPNrRUAZok9D/tsuPp0yeZn3zk5xX9QA6Q9m3bKkJSudEbJjkIq7Ll1uTJ
         YRG2TKEkyvCoSxb5VFOnEHJMnR0CotEyFolsY4BhGkOQT1RbFLShKBhDLFC68cJmOcDB
         nZyg==
X-Gm-Message-State: ALQs6tBiNJrGaPlpC7vpCccQefKt+pfDscb6XHHmG8hd3yge8jbBEcnI
        UOHnHQCbaEhhQ5TbXJO4WsLVWeEAQk6+zwiQiemJWg==
X-Google-Smtp-Source: AIpwx4+TFlbY1zVJWUYa66mqWeRH1GZKrTqOGlouLD89W56k0Ba/8pLvXn39s/Lc3DpWCNWeoSwxhxe6444YDoEqFQ0=
X-Received: by 10.129.232.5 with SMTP id a5mr955576ywm.421.1523384853843; Tue,
 10 Apr 2018 11:27:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 11:27:33
 -0700 (PDT)
In-Reply-To: <d338f068-4ccd-292d-c65b-342fab4cd018@alum.mit.edu>
References: <20180406232136.253950-1-sbeller@google.com> <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-8-sbeller@google.com> <d338f068-4ccd-292d-c65b-342fab4cd018@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Apr 2018 11:27:33 -0700
Message-ID: <CAGZ79kbAaHVAGXPhL9zBmkQp9f4=su7NdXn7RSy_PP=5Gd-Z5w@mail.gmail.com>
Subject: Re: [PATCH 07/16] refs: add repository argument to get_main_ref_store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        sunshine@sunshineco.us, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, Apr 10, 2018 at 6:36 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/10/2018 12:45 AM, Stefan Beller wrote:
>> Add a repository argument to allow the get_main_ref_store caller
>> to be more specific about which repository to handle. This is a small
>> mechanical change; it doesn't change the implementation to handle
>> repositories other than the_repository yet.
>>
>> As with the previous commits, use a macro to catch callers passing a
>> repository other than the_repository at compile time.
>
> This seems OK to me from a refs perspective.
>
> The macro trick is surprising. I guess it gets you a compile-time check,
> under the assumption that nothing else is called `the_repository`.

Yes. Credit goes to Jonathan Tan for this trick.

> But
> why actually commit the macro, as opposed to compiling once locally to
> check for correctness, then maybe add something like `assert(r ==
> the_repository)` for the actual commit?

The eternal struggle of contributing patches that are easy to review. ;)

With the assert we'll have a run time check, which is not desirable
compared to a compile time check. And from a reviewers point of view
running a "rebase -x make" on the series that Junio queued is easier
than to reason about the "assert(r = the_repository)" IMHO.

> But I don't care either way, since the macro disappears again soon.

Glad you're ok with this approach.

Thanks for looking at the refs specific code,
Stefan
