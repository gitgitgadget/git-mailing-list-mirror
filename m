Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11681F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbdARVVo (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:21:44 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38100 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdARVVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:21:43 -0500
Received: by mail-it0-f48.google.com with SMTP id c7so20367675itd.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LQH7tCyrHVhDPvWnkiU5QVCc3bmt2W3kLlLGpqxzMFM=;
        b=tw4VANhooQuQ5QyOLu/4k+nPeNd8cM7f+9nn29v5Fe6XiGUXgpLD0wNC4MzEiTP3pF
         gfmd9gnI6JG4AY/EmPiqmgA/uGVDNGI7AGJIgFnAXJoH27SGL6mZNTxOytXhA9XlV3ig
         KflsOs98doom+GLiddluIsepMJEWBPE4oNGrIGM5XUPOUqNQBq9aGUQcI7KPsReaHMgR
         bmLPCONBBfD7NjRIwsO1YCt2wQ2wUOqhFJXod2NpEAyge4maaDeHvb2475mc7sd0O+kG
         LXRZCUwo/fHA4+QiMUzcAp6baz/if0FSxrH6f4Eq2CFJreObYP7Olu4SkiLbvKWh4esh
         n+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LQH7tCyrHVhDPvWnkiU5QVCc3bmt2W3kLlLGpqxzMFM=;
        b=TnpIvTwHM1L+bpoPWzkVjVWVmTxgHR1I5yJuCvreFayoWTmGGStwwvdt5bRkWpimXl
         4Xg5sd47zUHQgeeVtaYi2TjhL7d0aUUnWFsPLc4iXQbfaXRm/mArxQGLRBW64Yo/D24D
         M4mY4Mvv3dr3jg549dhc8WP1cfl1EBinTVyfTB3vC+JMEBSvrCQ5ojIcAv6oO4R3er7C
         AabavJ+fkFU0GLykJTZ/edWcyv41FEPISssgd9f1p4w06BjqigILCJk2ByT8X9gwOZiQ
         G4i16ce81br15X1fDX8SlzeyfHs9QDrwEihEIuhXFDckQQDrgob7FIHDbm8192VcvYeB
         qSCQ==
X-Gm-Message-State: AIkVDXLngg5qxTfR6n4TVhjL/WhkzpdQoa+DzOxoe/jMW24rRmgKQb96DKd3N5gnYaiO5Rno2/CFOVUYf8kkVc4W
X-Received: by 10.36.169.12 with SMTP id r12mr5382094ite.69.1484772353859;
 Wed, 18 Jan 2017 12:45:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 12:45:53 -0800 (PST)
In-Reply-To: <CAGZ79kZv2=dNt=TeJXbac4S20WcdOZo=iVa-b+4zkOoGVM1OFA@mail.gmail.com>
References: <20170112235354.153403-1-bmwill@google.com> <20170112235354.153403-26-bmwill@google.com>
 <CAGZ79kZv2=dNt=TeJXbac4S20WcdOZo=iVa-b+4zkOoGVM1OFA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 12:45:53 -0800
Message-ID: <CAGZ79kbUcW1f8eiAFcEsaMMeTFwP6BXXwhz3sYxYH1cNo=BU-A@mail.gmail.com>
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 12:39 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jan 12, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
>> -static void prepare_attr_stack(const char *path, int dirlen)
>> +/*
>> + * This funciton should only be called from 'get_attr_stack()', which already
>
> "function"
>
>> +               /* system-wide frame */
>> +               if (git_attr_system()) {
>> +                       e = read_attr_from_file(git_etc_gitattributes(), 1);
>
> read_attr_from_file may return NULL, so we'd have to treat this similar
> to below "root directory", i.e. xcalloc for an empty frame?
>
>> +
>> +               /* root directory */
>> +               if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
>> +                       e = read_attr(GITATTRIBUTES_FILE, 1);
>> +               } else {
>> +                       e = xcalloc(1, sizeof(struct attr_stack));
>> +               }
>> +               key = "";
>> +               push_stack(&core, e, key, strlen(key));
>
> If this is a bare repo, could we just omit this frame instead of pushing
> an empty xcalloc'd frame? (Same for the stack frames of system wide
> and home dir) ?

The next patch moves this issue into the read_attr function.

So in the end we'd either need to fix read_attr_from_file to return
    res = xcalloc(1, sizeof(*res));
if (!fp), or we need to handle NULLs appropriately in 'core_attr_stack' ?
