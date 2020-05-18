Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EE5C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4360C20758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTSQ4URJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgERRDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:03:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62095 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:03:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A306949B3C;
        Mon, 18 May 2020 13:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HbPr5E5hKjBg
        HGzUyj/plcuGzOg=; b=WTSQ4URJNA1iWYPZA4XHJfwPDSwQsOAPBh/9dzyeNXYv
        7rlV5dAobeMXLfxQ8/HmU6uOrz9yMR3XPQzYWZw/JXIGBGdENt3t+pH1EWRuOmpE
        lSHgwy2OMskJvmTN0eBuP41DJBdw3IuzVozy5LondLmb9JvLlEumOoh+BAgzVr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=miFdbJ
        hhtMoLCRg1RM3ITOywgVzctcqjZKWleaHPjD6j69Q4kesb4vg90MpxldjrfW3QAZ
        iqTq2nklPpjeB+flApvRmQwGREVmuHkXDLxqPndnDrf1POYYfuQicsnufztOWoPh
        +xNO/DbjXHqMTJBzqzlVN6c8aJtjrXobRmdjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98FD949B3B;
        Mon, 18 May 2020 13:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20CD549B39;
        Mon, 18 May 2020 13:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
References: <20200515155706.GA1165062@spk-laptop>
        <20200515233130.GC6362@camp.crustytoothpaste.net>
        <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
        <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
        <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
Date:   Mon, 18 May 2020 10:03:45 -0700
In-Reply-To: <20200518135656.GB1980@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Mon, 18 May 2020 20:56:56 +0700")
Message-ID: <xmqqzha541la.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89B8A9E2-9929-11EA-BE4D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> @@ -4558,6 +4563,8 @@ void repo_diff_setup(struct repository *r, struc=
t diff_options *options)
>>  		options->b_prefix =3D "b/";
>>  	}
>>=20
>> +	options->flags.relative_name =3D diff_relative;
>> +
>
> Nitpick:
>
> I don't think this option is too special to add a newline to separate
> it from the rest :)
>
> Sorry about not seeing this earlier, I'm a very careless person.
>
> Anyway, I think (just a matter of my _personal_ preference),
> it's better to move it up 21 lines, together with:
>
> 	options->flags.rename_empty =3D 1;

Sounds like a reasonable improvement of readability.

>> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
>> index 258808708e..ac264ccc2a 100755
>> --- a/t/t4045-diff-relative.sh
>> +++ b/t/t4045-diff-relative.sh
>> @@ -8,7 +8,8 @@ test_expect_success 'setup' '
>>  	echo content >file1 &&
>>  	mkdir subdir &&
>>  	echo other content >subdir/file2 &&
>> -	blob=3D$(git hash-object subdir/file2) &&
>> +	blob_file1=3D$(git hash-object file1) &&
>> +	blob_file2=3D$(git hash-object subdir/file2) &&
>
> This rename from blob to blob_file2 is a noise to this patch.
>
> Not sure if we should make a preparatory patch to rename, though.

I personally do not mind this one.  It is crystal clear from the
patch text: "We used to use only one and managed to get away without
blob1/blob2 but now we use more than 1, so let's use names with
number suffix".  On the other hand, a "preparatory patch" that
renames blob to blob_file1 before we need the second one is a noise.

> *I* would say yes, and another patch to move all git-related code
> into test_expect_* family. Then, all new testing code for git in this
> patch should be placed inside test_expect_*, too.

The latter clean-up to make sure we won't notice Git failure outside
test_expect_* block may make sense, but I do not know if we want to
make it a preparatory clean-up or "remember to do so later when the
dust settles".  If this single-patch topic needs to touch only a
small part of the existing test to do its job, and such a clean-up
ends up touching far wider parts of the script, then I would say we
can do so as a post-patch clean-up, not as a part of the topic.

>
> I think it's better to wait for other's opinions :)
>
>> @@ -86,4 +87,80 @@ do
>>  	check_$type . dir/file2 --relative=3Dsub
>>  done
>>=20
>> +	diff --git a/$expect b/$expect
>> +	new file mode 100644
>> +	index 0000000..$short_blob_file2
>> +	--- /dev/null
>> +	+++ b/$expect
>> +	@@ -0,0 +1 @@
>> +	+other content
>> +	EOF
>> +	test_expect_success "config diff.relative $relative_opt -p $*" "
>> +		test_config -C $dir diff.relative $relative_opt &&
>> +		git -C '$dir' diff -p $* HEAD^ >actual &&
>> +		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&
>
> Please this leftover from debugging.

Thanks for a careful review, again.
