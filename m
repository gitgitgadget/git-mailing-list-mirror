Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0446A1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 23:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbeIFEEf (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 00:04:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39715 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeIFEEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 00:04:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so4260798pff.6
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ON4uDRUhN1dzCqJThbv3UPzhgpWGbW0vl6o+s5CAmKw=;
        b=ItNxTSnkxvrNO99otgnFdzc4tTprJUTvMkYCio+N3NF1lSdhDrPsG+5Wr8Nwh0nztC
         FMZzVsVb1w0ToOb0wV7pisvBswEs01PCdLnt4RPPrJqZA4V2nIGw7P8o229tufJ0Z+2t
         NM1niT+g/RI9X1Mi4sRMbQJ6+EVBjXjyr8O/eapHngBUw438lvH55ETLKynBgp43GlZ6
         57RmHELWRfYSOScWcdRhHtsDqVvEC6p9IUVMUNpzQC9sgqDOrkKrkBPiu+Tq9WUUcq/t
         kt06P1lBamYt+8MSAcEThIZw0f+SkpYfWASwMy6DiI3ZwOFj/quA9wWQlZhurICmi5uF
         Wvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ON4uDRUhN1dzCqJThbv3UPzhgpWGbW0vl6o+s5CAmKw=;
        b=Gx/V3igMXSIk8iC3/xPk103e02nN6f760bo4v0NM4NNYTr7xd2bhsOg4eijvuAtD15
         gMERHu+aWHgUFu7B+WFsTX/1+RFD2Ig9TXZr3s/rwehf8vEJYjbd/mo7zDRLSQ31aTmx
         9e7GawpgXQJHqGAVyyjLvZ//MwyKtUhn0glJeWCzC84sPJAMTEtcI9bG3R3VVN/KjPTB
         Ymt6Xz1eABo/4YZcftvRzMwQB/pch7tPgmoN+wLrPHu4zwNVeo8qbBnT3Ry+9Q2k35lr
         bj7Q9ZAfr0tNMdqzWACXuUCSHt8FxbE0YbReKn+k4RcjNnElSfLxFDLDcp6jOp9cHnkO
         KG4A==
X-Gm-Message-State: APzg51ABAaPuXJ85rIbMSeUB8+gwmh7jZ/kLafZOlp+FgMTnTspkPM96
        hKfFXmUDyhxFfgYYfDztao5ArHCx
X-Google-Smtp-Source: ANB0VdZieU2hV8MehiRHia12lms79aAU4OX/mCD7XIPm1S3uVBIF49Hn3gsvdr5g43+efS72WpWrnw==
X-Received: by 2002:a62:fcd2:: with SMTP id e201-v6mr49360pfh.101.1536190326165;
        Wed, 05 Sep 2018 16:32:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w72-v6sm6620109pfa.26.2018.09.05.16.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:32:05 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:32:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule commit in
 recursive actions
Message-ID: <20180905233203.GE120842@aiede.svl.corp.google.com>
References: <20180905231952.28145-1-sbeller@google.com>
 <20180905231952.28145-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905231952.28145-2-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Subject: submodule.c: warn about missing submodule commit in recursive actions

Nit: the diff already tells me what file the change is in.  What I'd
be more interested in is the subsystem or what commands this affects.
Does this affect all --recurse-submodules commands, or just some?

Here, I think it's about common submodule code, so I guess
'submodule:' would be a fine prefix.

> By checking if a submodule commit exists before attempting the update
> we can improve the error message from the
>     error(_("Submodule '%s' could not be updated."), path);
> to the new and more specific
>     error(_("Submodule '%s' doesn't have commit '%s'"),
>           path, oid_to_hex(new_oid));

Maybe it's just me, but I find this formatting where I cannot
distinguish between a line that was wrapped early and the start of a
callout hard to read.  Some extra line breaks would help:

  By checking if a submodule commit exists before attempting the update
  we can improve the error message from the

      error(_("Submodule '%s' could not be updated."), path);

  to the new and more specific

      error(_("Submodule '%s' doesn't have commit '%s'"),
            path, oid_to_hex(new_oid));

Beyond that, I still don't know what this change does.  Can you give
an example?  For example, what command would I run before and what bad
result would I get, and what result does this patch produce instead?

Thanks,
Jonathan
