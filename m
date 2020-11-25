Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EAAC2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADAD20BED
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZWD7Iml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKYBxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:53:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57083 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKYBxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 20:53:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A02AF4954;
        Tue, 24 Nov 2020 20:53:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N2lREnSsdKxvWBM0LrA8XQTBjxU=; b=iZWD7I
        mljK3ORVluQHmTUQxqbIMjpL5N7UGvREOZ9K/wgw9s3YcW60iX8QpWZErk4WFdga
        2/isH5/CZ1cpKdFxT+hTNh54cJwj++8B8/GBrYq2e+TmjxOI03Daa0Cgy2Z4+7Wi
        xRWPjrHI+xKjRRNKLhXTZJXw5IX3MokZ7pA3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WocR7186ZYXpm/cR1KQianPT9/8n3D5u
        6ivXlpCVq/lX2H2fsb3rdxP94wAdroO/zBR1VJyFkImVh2jaZBH9jSdCX+V5EGt7
        eWpxK5ny6ZuSvI3uy6knqJ7cJtDrSmuUgHXUYllbl0iHK/LAC/PQm68d4GMJXBG8
        X5W5TmmI0VI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FE9FF4953;
        Tue, 24 Nov 2020 20:53:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BB42F4951;
        Tue, 24 Nov 2020 20:53:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v2] refspec: make @ a synonym of HEAD
References: <20201125001102.111025-1-felipe.contreras@gmail.com>
        <xmqqblfmgtlg.fsf@gitster.c.googlers.com>
        <CAMP44s2ChcCjhjksS0s5BoYznqLAoXyFvSkP4GxSCh_ALusOtQ@mail.gmail.com>
Date:   Tue, 24 Nov 2020 17:53:11 -0800
In-Reply-To: <CAMP44s2ChcCjhjksS0s5BoYznqLAoXyFvSkP4GxSCh_ALusOtQ@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 24 Nov 2020 18:43:29 -0600")
Message-ID: <xmqq360ygq2g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA5CB792-2EC0-11EB-9D2B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Nov 24, 2020 at 6:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> > +test_expect_success 'push with @' '
>> > +
>> > +     mk_test testrepo heads/master &&
>> > +     git checkout master &&
>> > +     git push testrepo @ &&
>> > +     check_push_result testrepo $the_commit heads/master
>> > +
>> > +'
>>
>> This is OK, but shouldn't this be placed before the tests with
>> various configuration?  Something along the lines of the attached,
>> but with the body of the loop properly reindented, would also give
>> us a better test coverage at the same time.
>
> I don't see much value in those tests, since I don't see how if one
> passes another one would fail. But I guess it cannot hurt.

That can only be said based on the knowledge of the implementation
detail of the code immediately after this patch gets applied.  Any
future change to the code for whatever reason (e.g. refactoring) can
make the current assumption invalid.

As the proposed log message says,

    Since commit 9ba89f484e git learned how to push to a remote branch using
    the source @, for example:

      git push origin @:$dst

    However, if the right-hand side is missing, the push fails:

      git push origin @

we care about both of these forms working, not just the singleton
form, so it is not just "not hurt", but is actively a good thing, to
protect both forms from future breakage.  After all, that is why we
have tests.

Thanks.


