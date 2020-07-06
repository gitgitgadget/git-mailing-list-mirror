Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445F2C433E1
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116842075B
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BxN0/hNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgGFGXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:23:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52627 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgGFGXP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 02:23:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E02045F12F;
        Mon,  6 Jul 2020 02:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xaZSZvg+FhOt
        3uO3dlITM0ma/7w=; b=BxN0/hNYfZbl/TveuFejEsE8en1XpeqK1VjVSkKccCMF
        TvWn4sK007af7Pw96SercXj+0U+6Q8jyfmAlmAcUVcAjtkI0I36SPK4ScX/gSH/L
        EwLTv3JmKHeBKT0QII4+Yuq0smJra6u7JOHe9MluPHct0ryK/897SUi9/sr5Esg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HHHjrO
        jvtbk0IkjU33Eh8DfS8ky6TGC099bYOnvJk2adKk/pYxAkY/FtlpfMa7XOVQ4hX9
        OkY7FruZLezfradGwEoZ5fg7MlLmGdWRyB2Yr8fwZK0qwk8oI4VVWzvaDdh6nLkr
        z4RZ3Cgx02ZkWJujemOiyQd45h/JOV+UNUGok=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D71445F12E;
        Mon,  6 Jul 2020 02:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5865C5F12D;
        Mon,  6 Jul 2020 02:23:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v6] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v5.git.git.1593587206520.gitgitgadget@gmail.com>
        <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>
        <xmqqv9j5bc4o.fsf@gitster.c.googlers.com>
        <20200703155812.GA4087@danh.dev>
Date:   Sun, 05 Jul 2020 23:23:11 -0700
In-Reply-To: <20200703155812.GA4087@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Fri, 3 Jul 2020 22:58:12 +0700")
Message-ID: <xmqqzh8d9n74.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B0DD3BA-BF51-11EA-82D4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>>     if o=3D$(git config --bool 2>/dev/null mergetool.meld.useautomerge=
)
>>     then
>>     	meld_use_auto_merge_option=3D$o
>>     elif test auto =3D "$(git config mergetool.meld.useautomerge)"
>>     then
>> 	... auto detect ...
>>     else
>> 	meld_use_auto_merge_option=3Dfalse
>>     fi
>
> Something like this should work if we don't write anything to stderr,
> except the complain from git-config:

I did say "Maybe somebody else has a clever idea to reduce the two
calls into one without breaking correctness" but the stress is on
the "without breaking correctness" part, not on "clever" part.  Two
"git config" call may be more expensive than one call, but at least
the resulting code is readable.

If we really wanted to, I think the way to go would actually be to
teach "git config" new options that allows us scripters to express
what we can already say internally like "maybe bool", "bool or int",
etc.  IOW, "git config --bool-or-string" that does something like

int git_config_bool_or_str(const char **dest,
			   const char *name, const char *value);
{
	int v =3D git_parse_maybe_bool_text(value);
	if (0 <=3D v)
        	*dest =3D v ? "true" : "false";
	else               =20
        	*dest =3D value;
	return 0;
}

may help normalizing various ways to spell boolean plus non-boolean
strings into canonical form, so that you can say

	if o=3D$(git config --bool-or-string mergetool.meld.useautomerge)"
	then
		case "$o" in
		true | false)
		        meld_use_auto_merge_option=3D$o # as specified
			;;
		auto)
			... auto detect ...
			;;
		esac
	else
		meld_use_auto_merge_option=3Dfalse
	fi
=09
But I think two calls to config is good enough and it certainly is
not worth making the script ugly with hackeries and/or manually
enumerating all the possible shapes of trues and falses.

Thanks.
