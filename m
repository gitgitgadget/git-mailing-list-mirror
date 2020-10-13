Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF16C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 03:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831A420797
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 03:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgT1YOrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgJMDL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 23:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgJMDL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 23:11:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16BDC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 20:11:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b19so9900533pld.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 20:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=resent-from:resent-date:resent-message-id:resent-to:date:from:to:cc
         :subject:message-id:references:mime-version:content-disposition
         :in-reply-to;
        bh=EoMQQASlDOLN+01Msu3PpmXUuW9DD7YB0t5RzG31K7k=;
        b=fgT1YOrxdKWzZ9ZCfiTt4A8tXXmprDTeFEzay9vucxZ2tO6t+7JE7uKIBo4BSppFAr
         sbVOBOmlguknEl4uHuErHnKADS3GWzeb3/6+KRR0+cx9IhiBd3KRLqRbWDou49Ti6vff
         A625GOR2HWf4UqV6+FkKUBsQxipkCIQJ4IFJt7iSrayCMJgI4/Bmo8HyObTUZvLUe6Ym
         TAhquwf0A9zhs029gBoAO3O5a5KFoBvv8zD+yhsbijOuSbwZBkovzVtOXPbNspaDa5QC
         yWNHtnXRgbUbxhA2KitVNKeohIhu1TbHyaTC5brd1DwOCJ/+8aaGb9IIEafUMszicZfl
         14oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EoMQQASlDOLN+01Msu3PpmXUuW9DD7YB0t5RzG31K7k=;
        b=c95M1RqxRU6i/71kUj4wb16B0DbAbjH00bwog51G3AJSFS0Xkp6GVp8TmKPV9h+IeV
         IMSBjIzFqvpinKuDcReEdhNFWAksjo4cqbQqF7wggHdiBrZ62YWAg33bwz2rwZdJTwbF
         juAiNDwuRFnJGb+vTk7YDjdWHSAVB4gvzIO2b5z5qNB6JELtrl4kkiMRRCixlsfBezTf
         VmhXtlMN8MhXETujoxFQBrHbjnTOI4iK6mGwrO5/UPc//yGHLvabQhbdVQKKRtG9NsMz
         t2YZ9JqgjmoSm7ND6IErGe15wCToOwQWi0NHHNhFRFU7Jy9BMjCbD9fa1LkGWYIuY0FR
         GOuw==
X-Gm-Message-State: AOAM533fuCVwyqPd1DRGEN/DkI+ayxRkIW5ns6IFQ+EXhUkK2Db1jDEc
        tIUVm2Rs6lfDoOs3TNQPaf3rEZb5YSA=
X-Google-Smtp-Source: ABdhPJxEVoF6OUcKzgnvrvqxgy/CD22PpC9LBMuNh1a8REAq9o8RMeOZ+wd746HB9wlkfK1593MPng==
X-Received: by 2002:a17:902:b7ca:b029:d3:eca2:d221 with SMTP id v10-20020a170902b7cab02900d3eca2d221mr25110374plz.74.1602558718109;
        Mon, 12 Oct 2020 20:11:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id i25sm21476855pgi.9.2020.10.12.20.11.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 20:11:57 -0700 (PDT)
Date:   Mon, 12 Oct 2020 20:10:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.com
Subject: Re: Introduction - An Outreachy 2020 Applicant
Message-ID: <20201013031056.GC3814681@google.com>
References: <CAGxm6oU+11zAjM6KBNRv4NUhx69CiaLekJ5ZhOhmQA8ofrAzbA@mail.gmail.com>
 <CACyXjPy=322gOBbcKpERvBnYnOsPr1OKeTbQktUGSx0+3SSpPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACyXjPy=322gOBbcKpERvBnYnOsPr1OKeTbQktUGSx0+3SSpPA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Sharpe wrote:
> Amanda Shafack wrote:

>> Good day.
>>
>> I'm Amanda Shafack, an Outreachy 2020 applicant who wishes to
>> contribute to the "Add Git protocol support to Wireshark" project.
>>
>> I have some experience coding in C and I hope to enhance
>> my skill set by contributing to this project.
>>
>> In addition, I'm fascinated by network protocols and it's really
>> exciting to get my hands around these concepts in a real-world
>> project.
>>
>> I'm currently going through the project description and contribution
>> guidelines.
>
> Welcome. There are many helpful people on the list.
>
> It would be useful if you can point us to a protocol description
> document but that can wait until help is needed. It may be that all
> the online resources are sufficient, but if not, do not hesitate to
> use this list to ask questions.

There's an overview of Git's HTTP protocol in the Pro Git book:

  https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols

The official protocol spec in git.git (https://git.kernel.org/pub/scm/git/git.git)
is split between a few files:

  Documentation/technical/protocol-common.txt:
    conventions for protocol docs

  Documentation/technical/pack-protocol.txt:
    overview of Git protocol

  Documentation/technical/protocol-capabilities.txt:
    optional capabilities

  Documentation/technical/protocol-v2:
    protocol v2, the new default (more about this is at
    https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html)

  Documentation/technical/http-protocol.txt:
    how this works with http

  Documentation/technical/pack-format.txt:
    packed representation of Git objects (used both on disk and over
    the wire)

Amanda, if you have any questions, please don't hesitate to ask
(#git-devel on IRC is the best place for that, and email works as
well).  I am there around 15:00-24:00 UTC most days.  In addition to
working on your initial starter contributions, we can start to put
together a plan for the project.

Richard, to set expectations: the internship period for accepted
interns starts in December: https://www.outreachy.org/apply/project-selection/.
Until then, potential interns are often not free full time, so we
focus on smaller contributions that help get their feet wet in the
codebase.

Excited,
Jonathan
