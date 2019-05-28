Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD961F462
	for <e@80x24.org>; Tue, 28 May 2019 19:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfE1TXo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 15:23:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62553 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfE1TXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 15:23:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F02E6D04A;
        Tue, 28 May 2019 15:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NcfzkhFZ6syV
        wmWiv7/AS9iJqj8=; b=wc+SxM3w4nDvvTIyzFChAvxsihV1erYltZ+e7mzvqHJi
        I+xu1el42hj9rpkLQg9ocNW59tpCGyUt36qG4ii/yXJXGvtBVbxK1GRDdk5IHHgl
        zgLU2T8j2OGvW6E3zBPqoolzPjp4gFderbVcWF3G5NUzbOqi6laxlkEVRbRqLs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bhY6JF
        fmm7HVQLpSL07cn+oBMN56pVbVIyNzjfBBcU6N+JaAdF0r3pYfPv7gdpdFqoFIis
        eMaBXFpA13g6iRb1jKHMmX4hC5jj890K7gPKhdOEeat9SAEZ2d7yBSvFb1Lrj30u
        sCm9hMOPA7cPNKc+FahBWNuZlRsJ2bz+W/lz0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 581D86D049;
        Tue, 28 May 2019 15:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87D6F6D048;
        Tue, 28 May 2019 15:23:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        bturner@atlassian.com, tmz@pobox.com
Subject: Re: [PATCH 1/3] diff-parseopt: correct variable types that are used by parseopt
References: <20190524092442.701-1-pclouds@gmail.com>
        <20190524092442.701-2-pclouds@gmail.com>
Date:   Tue, 28 May 2019 12:23:37 -0700
In-Reply-To: <20190524092442.701-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 24 May 2019 16:24:40 +0700")
Message-ID: <xmqqtvde1iyu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18EF4072-817E-11E9-924D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Most number-related OPT_ macros store the value in an 'int'
> variable. Many of the variables in 'struct diff_options' have a
> different type, but during the conversion to using parse_options() I
> failed to notice and correct.

Why does this patch need to be so noisy?  "unsigned identifier" is
the same as "unsigned int identifier", isn't it?

That is, wouldn't this hunk ...

> @@ -169,7 +169,7 @@ struct diff_options {
>  	const char *prefix;
>  	int prefix_length;
>  	const char *stat_sep;
> -	long xdl_opts;
> +	int xdl_opts;

... the only one that matters?
