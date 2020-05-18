Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7BC433E2
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BF1206D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a+ii9ZR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgERUC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:02:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58041 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:02:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD569C97E5;
        Mon, 18 May 2020 16:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nOIFDFsx5LT8
        lG4T8+onK34CyqM=; b=a+ii9ZR20AgGZz9Tt4JVSyP+S4mW8bx1sz5o0LosQ9bT
        vj+Q57oXKBs3h1YoY/j5LN7ldi7FLo2YiHvxnounHgNL6KXN4PEj2CW5c6d30DpB
        2aYZ2uWfaIk49tn+8Hc9j6frx8UR9Z3+K4gVqZI6nfbQU0iJZ6WvZ1SXVRQ5lCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zuxh+x
        NYXil5N9lstIzdnQ0LMnBEkJfIV+Nnc8GBEYAvrv8y4ZMV4Uwp3tlPcSHWM46BQG
        p1L+c6TqVw5+s6H5HEza/FqbCH9jHJVWkzTWcI2VJ4L9Pi+LM3BGUdiQpGFhFu0z
        c2vGGAotmMuY7IbyLNxlKFp0r/AvY00Hi3Nro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6101C97E4;
        Mon, 18 May 2020 16:02:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11D68C97E2;
        Mon, 18 May 2020 16:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v6] diff: add config option relative
References: <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
        <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
        <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
        <xmqqzha541la.fsf@gitster.c.googlers.com>
        <20200518172103.GA2110@spk-laptop> <20200518191954.GB1999@danh.dev>
Date:   Mon, 18 May 2020 13:02:50 -0700
In-Reply-To: <20200518191954.GB1999@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Tue, 19 May 2020 02:19:54 +0700")
Message-ID: <xmqq5zct2eqd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E34403A-9942-11EA-980E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-05-18 19:21:03+0200, Laurent Arnoud <laurent@spkdev.net> wrote:
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-optio=
ns.txt
>> index bb31f0c42b..167b451b89 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -651,6 +651,8 @@ ifndef::git-format-patch[]
>>  	not in a subdirectory (e.g. in a bare repository), you
>>  	can name which subdirectory to make the output relative
>>  	to by giving a <path> as an argument.
>> +	`--no-relative` can be used to countermand both `diff.relative` conf=
ig
>> +	option and previous `--relative`.
>
> Nitpick:
> Please mentions --no-relative in option list:
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index 167b451b89..8761c04bc2 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -645,6 +645,7 @@ ifndef::git-format-patch[]
>  	on-disk file to tree contents.
> =20
>  --relative[=3D<path>]::
> +--no-relative::
>  	When run from a subdirectory of the project, it can be
>  	told to exclude changes outside the directory and show
>  	pathnames relative to it with this option.  When you are
>
> Together with Eric suggesstion, this patch looks good to me.

Yeah, good suggestions all.

Thanks.
