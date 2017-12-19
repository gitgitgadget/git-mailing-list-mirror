Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1D891F406
	for <e@80x24.org>; Tue, 19 Dec 2017 19:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdLSTKp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 14:10:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751714AbdLSTKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 14:10:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9FC9D5B52;
        Tue, 19 Dec 2017 14:10:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xh3uv979pNB3
        xR9nv7uw/RjlmrQ=; b=K8bsOhZvABbO8Cog4rAfqzllq0MyPbR4zry6WgdeuhiF
        YRE0A/0DA5+E6DLQUpUhXkeCDlByy+blx+DGbRNy6jcINbHI9BYhLM2EHVuh+yXr
        tdltxkucuJ9O1m1QDSkjnKhFEwmBH2uqNelfgwxnu7oRrXXPZsn8KvctlZ+3ARg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nMdgqq
        vHq6ca8kr9B6O0y1EenWWKqlCY8EGd8DgDu7rUwmtT3xEhmatlwcaxYo8lqO/+0Y
        6i4BKWTa3/WjVWlzOZj7tQQwJkB0pZSyDOHp4EqyOoSBbni8igeLdcF23RY2ff9U
        rAzll63DZJFwv0xhtZjW92acqd+JUJQyudsTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0DD1D5B51;
        Tue, 19 Dec 2017 14:10:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6133D5B50;
        Tue, 19 Dec 2017 14:10:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/5] Makefile: under "make dist", include the sha1collisiondetection submodule
References: <20171208223001.556-1-avarab@gmail.com>
        <20171128213214.12477-1-avarab@gmail.com>
        <20171208223001.556-3-avarab@gmail.com>
        <xmqqvahg6dkc.fsf@gitster.mtv.corp.google.com>
        <87d13oerr0.fsf@evledraar.gmail.com>
Date:   Tue, 19 Dec 2017 11:10:41 -0800
In-Reply-To: <87d13oerr0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 09 Dec 2017 00:15:15 +0100")
Message-ID: <xmqq3746wn2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F209AAA-E4F0-11E7-860E-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I started by trying to come up with something generic which would handl=
e
> future submodules, i.e.:
>
>     git submodule foreach 'git ls-files'

I am not all that interested in that.  The hardcoded list I felt
disturbing was not "what are the submodules we want to include?",
but "what are the files from sha1dc submodule we use?".

IOW, I was more wondering about these selective copies:

...
+	@cp sha1collisiondetection/LICENSE.txt \
+		$(GIT_TARNAME)/sha1collisiondetection/
+	@cp sha1collisiondetection/LICENSE.txt \
+		$(GIT_TARNAME)/sha1collisiondetection/
+	@cp sha1collisiondetection/lib/sha1.[ch] \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/
+	@cp sha1collisiondetection/lib/ubc_check.[ch] \
+		$(GIT_TARNAME)/sha1collisiondetection/lib/
...

As we are assuming that DC_SHA1_SUBMODULE users are not doing the
make dist from a tarball extract, wouldn't something along the
lines of

	git -C sha1collisiondetection archive HEAD | \
	$(TAR) Cxf $(GIT_TARNAME)/sha1collisiondetection -

be a better way to go?
