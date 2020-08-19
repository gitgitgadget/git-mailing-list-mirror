Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D24C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6CF20882
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MiQOh9pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgHSVJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:09:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56170 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHSVJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 17:09:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FEC4F5DB7;
        Wed, 19 Aug 2020 17:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z1N2V4zsEth2kUDr4N446WygtSA=; b=MiQOh9
        pFQT2kgWDZDL0pAJXLd7z8JBo0nZi8izeBW4dsf8xnAL3FEo33eXdSbtOJhvcwbz
        hcjppNydrSFetHpIRXS/1kyyWnC5pjiRi6RIzGAuEG8r4A32CqCTrhUSuPNp6OOH
        TwoxALVXT6Q0gLDaNDyBN7OS25/R0dbZ2MEGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=owce0wV3aHLIOlNc0jd0rSuXqSBjVAGS
        gyH7EiM0RH/0SBBzoW9+8iGC+m6FavSOQVysaixKHq73NkpwFqXCpi8aSKS/K/tI
        LxUa/UdynhTQaBa1b5koho/nnPuPUN4z8ipcZXuqB4glxFPIFX4tmo5CEEB44rWj
        mzHRWo/kq2c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28538F5DB6;
        Wed, 19 Aug 2020 17:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A0FBF5DA9;
        Wed, 19 Aug 2020 17:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/4] Handle FETCH_HEAD and MERGE_HEAD generically
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
        <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:09:42 -0700
In-Reply-To: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 19 Aug 2020 14:27:54
        +0000")
Message-ID: <xmqq1rk2tka1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E0E8576-E260-11EA-98BC-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This moves the FETCH_HEAD handling into refs.c as discussed in 
> https://public-inbox.org/git/xmqq5z9pav01.fsf@gitster.c.googlers.com/

Thanks.  The way the support for MERGE_HEAD is added to the series
looks very sensible, too.

Will replace.

>      -+static int refs_read_fetch_head(struct ref_store *ref_store,
>      -+				struct object_id *oid, struct strbuf *referent,
>      -+				unsigned int *type)
>      ++static int refs_read_special_head(struct ref_store *ref_store,
>      ++				  const char *refname, struct object_id *oid,
>      ++				  struct strbuf *referent, unsigned int *type)
>       +{
>       +	struct strbuf full_path = STRBUF_INIT;
>       +	struct strbuf content = STRBUF_INIT;
>       +	int result = -1;
>      -+	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, "FETCH_HEAD");
>      ++	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
>       +
>       +	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
>       +		goto done;
>      @@ refs.c: int for_each_rawref(each_ref_fn fn, void *cb_data)
>        		      struct strbuf *referent, unsigned int *type)
>        {
>       -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent, type);
>      -+	if (!strcmp(refname, "FETCH_HEAD")) {
>      -+		return refs_read_fetch_head(ref_store, oid, referent, type);
>      ++	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>      ++		return refs_read_special_head(ref_store, refname, oid, referent,
>      ++					      type);
>       +	}
>       +
>       +	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
