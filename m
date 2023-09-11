Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763FDEE57DF
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjIKG2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjIKG2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:28:10 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A229BEA
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:28:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5311632DD4;
        Mon, 11 Sep 2023 02:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=gPVSOIbll7bA5q4Dnjo/Alfndqpus8qx+2j2Ra
        mWE/w=; b=KehSlpWDh9FsX1EN+yg31rBEZhGXHi/y+FNtT/n7XJZKGMpdHVW9m2
        ELEboUCkyU0VL5jIg80kQQMYj5RsLzn/C/mpttWKRDsh4b+kw561OIkDtWmye+Ti
        k7vorhxpmsaKGDzpetvKtol6zTmwGa+pO+IvZKke2+JdSHPKtXTvw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4BA3B32DD3;
        Mon, 11 Sep 2023 02:28:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D402832DD2;
        Mon, 11 Sep 2023 02:28:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 26/32] object-file-convert: Implement
 convert_object_file_{begin,step,end}
In-Reply-To: <20230908231049.2035003-26-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Fri, 8 Sep 2023 18:10:43 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-26-ebiederm@xmission.com>
Date:   Sun, 10 Sep 2023 23:28:01 -0700
Message-ID: <xmqqjzsxi5qm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C36A8AE-506C-11EE-A0F8-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> +	const struct git_hash_algo *from = state->from;
> +	const struct git_hash_algo *to = state->to;
> +	struct strbuf *out = state->outbuf;
> +	const char *buffer = state->buf;
> +	size_t payload_size, size = state->buf_len;;

The excess ';' at the end is an empty statment, hence ...

> +	struct object_id oid;
>  	const char *p;
> +	int ret = 0;

... these three violate our "no declaration after statement" house rule.
