Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3A41F461
	for <e@80x24.org>; Fri, 23 Aug 2019 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406170AbfHWUZh (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 16:25:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55645 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbfHWUZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 16:25:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61C9317036F;
        Fri, 23 Aug 2019 16:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PSJnnyXJc9wzvXbIDiaWUH1YW8Q=; b=ZTxgGE
        EYVVOf6BRz53MyELknSrjxSjy58Vkk1I1JhjDw7SDnQ43aKIw6xjxxnwhAQdN1L7
        OaYeiPLz6jLE1HN93srJ/C+UgqPMwcHg4byvgYkgsShFQ8DQuyQZH7wDKnWI5WnN
        qMYAevNDjnwUqJc4sS/0ZM6WkWD0E6NQZ23kA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gHa/V8J6YnhGYGg9SpVVdBLCHCdfRybJ
        dAGgcyhYBBEmAx/rwn2KcpXcvZqdrieZbPn9IWQJHHmv8jeZvDD0ufIdb/OfQrNG
        CBYCbuWB3UTpFPgzgnnufDW8mIUrm3+0c52KHkLuu4t8Xi/L3Vh5WqK+icHFZ33M
        vYJSu72ZMKk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5907717036E;
        Fri, 23 Aug 2019 16:25:34 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B80EC17036D;
        Fri, 23 Aug 2019 16:25:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] format-patch: learn --infer-cover-subject option (also t4014 cleanup)
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <xmqqsgptnedb.fsf@gitster-ct.c.googlers.com>
        <20190823181956.GB14048@archbookpro.localdomain>
Date:   Fri, 23 Aug 2019 13:25:32 -0700
In-Reply-To: <20190823181956.GB14048@archbookpro.localdomain> (Denton Liu's
        message of "Fri, 23 Aug 2019 14:19:56 -0400")
Message-ID: <xmqqwof3ljcz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28B56B1C-C5E4-11E9-8638-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> For housekeeping, since this patchset now exists as two branches
> (dl/format-patch-cover-letter-subject and
> dl/format-patch-doc-test-cleanup), would you prefer any new revisions
> exist as one big patchset or two separate patchsets targeting each
> individual branch?

I think any updates to the last step would need to build on top of
the clean-up series.  You might be able to add new tests and update
docs in such a way that is independent from the clean-up and then
worry about possible merge conflicts later, but with the clean-up
series being in reasonably good shape already, I'd expect that the
bigger clean-up series can be polished enough before we work on
polishing the last step.  So perhaps we just focus first on the
clean-up series, have them graduate to 'master', and then build the
new feature on top, perhaps?

