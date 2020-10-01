Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53BC4727C
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0772087D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 05:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcSWMap9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgJAFiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 01:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAFiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 01:38:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB8C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 22:38:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so3407711pfp.11
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGYdstZWKJapnXDpgrVcuHP/772h2mzmj0a2vGUIX3s=;
        b=jcSWMap9xQMWuKowNpqCaT+/8JWwQ0RFGtfqrRKpQPlAjhEX2oq4yXqPt6Y6UqZxar
         o0Y41xEjLKcsKJ05xI6YerQQritD07RCqUVf5IYQMGqMVvGE3IHL8qClcVbOQHn4adM+
         GuafU3QucFwYe4cBAUXqadAAYer646pAGMrbfp8UU2j8c4IYtI92WhtjQMNXHAmDDTqw
         QIuyh+grjzuYEVh9p1TXhZH9Enqoe49fM10gF0KpHzqTgN7FH3mS+SFdIIqr/FUpBQVu
         Z6hjS/o9mtZFD1E13BEllG+ezKXbOBu54WzG6K+gXuTLnvxpPM8Cf1nV+g3JgASRoASr
         YvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGYdstZWKJapnXDpgrVcuHP/772h2mzmj0a2vGUIX3s=;
        b=F/m3WMU7vQS0ffV8cQOT6ge9Y9DcDJoNZtNh0qj7UlrejxIqfBR9xnW14Zj0QGMY0u
         KbZPEA+NLxt14pNS6aEAKPurFN1HLvbo8jk5mJFUQDXX3nWSnh5A3iMqyoQ9kybEGFsq
         i0j1NxAfONF1792cdGE/aim9NWUoFqkR2EBWnh+0UGMEg8VtNOC/suPfVzXBC0NljsKh
         KGVOe8MlNX59NcHm/Y0U64ItzKTH7I2xiwcmuDn3zj9Va83wQ42xwjxAT5s29mQJB8CJ
         N06upcJCaQWNcRbl1UOE8CuAZmhxiBQujUhJ+lWCSPzyfK5vfb3CrMJU47NYJ9oEaAoW
         wmww==
X-Gm-Message-State: AOAM531oeVdBUlHIR9/JPdLtIegdVE8oHjSmAXIKzLbCfuSxs/SswJz1
        qtszvshOfUSYvJWtd6X4Yl8=
X-Google-Smtp-Source: ABdhPJzcYdoCoretscYmGtQRZopVNxgtKYjVOMzu9zu9bopcQ2HxYewwCuCrdPcTmK7nD0EumKEtjQ==
X-Received: by 2002:a17:902:8307:b029:d3:89e2:7866 with SMTP id bd7-20020a1709028307b02900d389e27866mr1181570plb.42.1601530685984;
        Wed, 30 Sep 2020 22:38:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id a14sm3914890pju.30.2020.09.30.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 22:38:05 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:38:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Theodore Dubois <tbodt@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] Propagate --quiet on submodule update to merge/rebase
Message-ID: <20201001053803.GC2930867@google.com>
References: <20200930195052.118199-1-tbodt@google.com>
 <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Theodore Dubois <tbodt@google.com> writes:

>> Without this, commands such as
>> git pull --rebase --recurse-submodules --quiet
>> might produce non-quiet output from the merge or rebase.
>>
>> Also fix the parsing of git submodule update -v. Setting GIT_QUIET to 0
>> has the same effect as setting GIT_QUIET to 1, because
>> ${GIT_QUIET:+--quiet} only checks whether GIT_QUIET is set or unset.
>
> Thanks.
>
> Will queue with the following log message.
>
>     submodule update: silence underlying merge/rebase "--quiet" is given

Missing 'when' before '"--quiet"', as Eric noticed.

Aside from that,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, all.
