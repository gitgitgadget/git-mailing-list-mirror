Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3332C20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 22:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdIVWQh (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:16:37 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:50673 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdIVWQh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:16:37 -0400
Received: by mail-pg0-f49.google.com with SMTP id p5so1268575pgn.7
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXo+Kr8tuTaoyiIOf9JkEDhk0RVGrrugtsAe1q0cUrg=;
        b=uBSY46LXrsBDc1AKIg6+oK1ARIGtpl58XvnJFiqtAOkBR2OdRwtkyxhHUWm43Z3/Mt
         LwZz4i8LY8+3A4SY2hTvFg8rjFG4fp3lWhcMulUugFLIS/HLM7TsllPXPCY02oSB2xHH
         Xlj/oZsSUb1irQZDiiNm3+Z2aSwLVxV090hEXSUYnVqZDA+8J8RKMAZFlTgi1tZl1ExB
         Mv6D73VpKodZNO2Lx6UmmzKPA19hknUd/DNdDzUlGASXpXKroIbLDEH3Rv41QkgdlU//
         zscIvBQIAOEdlLo/mWuF3cg+w+uITKG/Q9jPYKTQz3Eh/v+dnnxqU5e3TVybFbDKeJ4X
         vGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXo+Kr8tuTaoyiIOf9JkEDhk0RVGrrugtsAe1q0cUrg=;
        b=EVuOlMIo7ZDuacI3Pa2j0p3le4h1+9GHyBJlE2HQt4f5wCIgVRKyO/0QrkklufoYVO
         NY+3sL3AMbb+I1feba1X2gfZljKh6yFvHE7oj483mx5K/3u+jK71XOljnRYqjNxNC1MP
         wbwILVa4YuHtsVxyIht8SJlmGOJNp5/EMuM7WV5Y8iAmFA+f/fie17r7UQg255rj71ej
         NtqPJ6Bh6W+zn8lcP5RpY2dn10ZfA1sytRApx0uhsKogaBdtLkcS4UVVTj6OndrRs1Pd
         Ks1iryaOqsidOvoW6Syf5oeyKcjmgJvWOaSbADAlzCnfSBXai+QUjO7FDiPLGCMPcVQu
         64Yw==
X-Gm-Message-State: AHPjjUgIFpZ5kqRs0rnegQ3HFpzCVwdoJbdAdnWkbS7F5QA4ryweei0X
        NmQKltJlmlz9Xbd0nkjOSJtarg==
X-Google-Smtp-Source: AOwi7QCg/AV2cVTLWemFdrqadryIp4VU7gWYweIR6WQHRWkVtJJ1zZOJ2yfE25ejwOYqlaGTRH1VzQ==
X-Received: by 10.84.238.206 with SMTP id l14mr489319pln.156.1506118596531;
        Fri, 22 Sep 2017 15:16:36 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:840f:cadd:b54e:2e8c])
        by smtp.gmail.com with ESMTPSA id 65sm886688pgh.31.2017.09.22.15.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 15:16:35 -0700 (PDT)
Date:   Fri, 22 Sep 2017 15:16:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v4] connect: in ref advertisement, shallows are last
Message-Id: <20170922151635.9c058ce5a06c67ed9610fc6e@google.com>
In-Reply-To: <20170922210104.GB24036@google.com>
References: <20170922164504.GD77641@google.com>
        <20170922201551.15012-1-jonathantanmy@google.com>
        <20170922210104.GB24036@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 14:01:04 -0700
Brandon Williams <bmwill@google.com> wrote:

> > +static void process_capabilities(int len)
> > +{
> > +	int nul_location = strlen(packet_buffer);
> 
> It may make more sense to not rely on accessing a global buffer here
> directly and instead pass in the buff you're working on, much like your
> are doing with len.

I wanted to preserve the existing code's behavior of using the global
buffer, and it didn't make sense for me to alias it (like the existing
code does).

I pass len in because I need to read beyond NUL.

> I'm not the biggest fan of dynamically allocating this and then using it
> to compare.  Maybe we can check to make sure that the oid matches the
> null_oid and that the name matches the "capabilities^{}" string?  That
> way you can avoid the allocation?

The dynamic allocation happens only once per process, since it is
static. To check the oid matches null_oid, I would have to parse it
first, and that seemed unnecessary.

Ideally I would just check again "000...000 capabilities^{}", but
writing it in source code would be error-prone, I think.

> > +static int process_ref(struct ref ***list, unsigned int flags,
> > +		       struct oid_array *extra_have)
> 
> So from comparing this to the current code it doesn't look like there is
> a check in 'process_ref' that ensures that a 'capabilities^{}' line
> doesn't show up after a normal ref, or am I missing something?

Ah...yes, you're right. I'll fix this by adding a check in
process_ref().

This is getting more complicated than I thought, so I'll wait a while
for other comments before sending out an updated patch.
