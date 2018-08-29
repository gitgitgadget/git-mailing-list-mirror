Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654091F404
	for <e@80x24.org>; Wed, 29 Aug 2018 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeH2WdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 18:33:03 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40136 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2WdC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 18:33:02 -0400
Received: by mail-ed1-f52.google.com with SMTP id j62-v6so78767edd.7
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iB0ds2ahzkDjPHx7VYLMSmWpz+8qB7N9qkRUpG6m71Y=;
        b=HWFnc9Lb/tk2O0yy07r6vV9eEnKaz247sSLfUxyS6Na99UXeXM6y9DygHkFKz+WYoF
         re+hQdSeBq9zLkH9xpgXdAYJIQWXxoP/4L3GYMZYvXQ5A4JwgaKKAqPxOE7rDN5kVyNE
         7wQRAdxSWA1ATPD93qxvXzNZNlfndtcBJCH2f62T6wC/HhVmlbbOyVi5ckdsh7DKvdoM
         GeY3IyKRoyAhrS/4fq4WsKdqMQCBAXRnyoFezspYJISx4qEtYgkZvguoqQCLo5wWK/LH
         krx8d1F0UhB9Z6zETYNot9O7xHYall5pCnhDd1bod69Xtykatks8mjAEOUXpXhmQPrVK
         Uq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iB0ds2ahzkDjPHx7VYLMSmWpz+8qB7N9qkRUpG6m71Y=;
        b=cVionZ3FDzY1f6noo3CCtt4gAorKuAiUiBdla2A5EyTI7V0Wb4thcDqfLeBimotCYp
         DGgTIf7qi0he6H3RIE6fdcDOQTjBUZmIaRvohF3WvVD93AeiEqzK1Rz1v4ijEDUCPUQB
         F37xq0Qg9oGLX2BLabCD2kftW7YiaXOU7XXNC3IROIWKXAJOs7V++5v7HGIGdjLsrdRm
         r5yPHgKwXeA9zwcrkJ41fsPkegLfIi4QMlOfz3oiGpL9d8Tgr0XvcjAuePAtumVZUSp9
         NldynP5z+Hfa6I/tx4LI637JDN/nPpFbnfi1wjvuk9sIxZt5uwpUIJkaNvgvfvyxVypm
         tkVQ==
X-Gm-Message-State: APzg51Bvklj5kGpNa4yGWd+okXUay95E5eGlCo7FxDZkOA6osv+RMa6j
        eOcRN1W7MEOpc2QAGMFbLiriCgG0WgD4SD4S6zKGTQ==
X-Google-Smtp-Source: ANB0Vda00wm8yV+FSw5d2uCOinm+nxJmt1C24WtlUVHa+OKS8xBo/QagmbndfTHn/CdFVZNwOPNE52IuRZiaRcfp33I=
X-Received: by 2002:a50:cc0a:: with SMTP id m10-v6mr8853998edi.81.1535567691395;
 Wed, 29 Aug 2018 11:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <878t4xfaes.fsf@evledraar.gmail.com> <20180824014703.GE99542@aiede.svl.corp.google.com>
 <877ek9edsa.fsf@evledraar.gmail.com> <CAGZ79kaGb_TL7SiR4CFGFzrfy2Lotioy76o6sUK4=vZK5qwqNA@mail.gmail.com>
 <20180829175950.GB7547@aiede.svl.corp.google.com>
In-Reply-To: <20180829175950.GB7547@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 11:34:40 -0700
Message-ID: <CAGZ79kZsAFNE0GgUHociSDejwB+HsPVscZ4jcq__sFew7g85Bw@mail.gmail.com>
Subject: Re: How is the ^{sha256} peel syntax supposed to work?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:59 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Stefan Beller wrote:
>
> >                  And with that model, <hexdigits>^{sha256}^{tree}
> > could mean to obtain the sha256 value of <hexvalue> and then derive
> > the tree from that object,
>
> What does "the sha256 value of <hexvalue>" mean?

s/hexvalue/hexdigits/
..

And with that model, <hexdigits>^{sha256}^{tree}
could mean to obtain the object using sha256 descriptors
(for trees/blobs/commits/tags) of <hexdigits> (as defined by
the step of the transition plan, it could mean <hexdigits>
to be interpreted as SHA1 or SHA256 or DWIM).

>
> For example, in a repository with two objects:
>
>  1. an object with sha1-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
>     and sha256-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>
>  2. an object with sha1-name ef01ef01ef01ef01ef01ef01ef01ef01ef01ef01
>     and sha256-name abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd...
>

It would be super cool to have hash values to match vice versa,
but for the sake of the example, let's go with that.

> what objects would you expect the following to refer to?

That generally depends on the step of the transition plan
in that specific Git repository.

I thought these format specifiers would only describe how to
output the object names correctly for now, so it could be
possible to have:

$ git show abcdabcd^{sha1}
commit abcdabcd...
....

$ git show abcdabcd^{sha256}
commit ef01ef01e...
....

in one step and

$ git show abcdabcd^{sha1}
commit ef01ef01e...
....

$ git show abcdabcd^{sha256}
commit abcdabcd...
....

in another step, and in yet another step it could mean

$ git show abcdabcd^{sha1}
commit abcdabcd[...]^{sha1}
...

But my question was more hinting to the point that we should not
overload the syntax to mean much more than either output formatting
or hash selection.

The third meaning could be used for verifying objects as we could
use this syntax to mean

  "please verify the signature of the object (as given by ^{hash}"

or it could mean

  "please verify the signature of the object as given and ensure that
    it was signed in this ^{hash} and not in a weaker hash world".

And I would think all the verification should not be folded into this
notation for now, but we only want to ask for the output to be
one or the other hash, or we could ask for an object that is
<hexdigits> in the specified hash, but these two modes depend
on the step in the transition plan.

Stefan
