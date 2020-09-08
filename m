Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E17AC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8AC20768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9B0Cq8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgIHRSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:18:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61409 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbgIHRSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 13:18:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58EA1E4975;
        Tue,  8 Sep 2020 13:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rJRhnRbya8usrNWuFr8WG3NQO3Y=; b=L9B0Cq
        8xtVt29fkwIk1h49C1vsXJBVWtv0iAV2BeTfirZB2t/geAqffenp9JPKkzPWBzU7
        ez6JP2nO2pKbPjxvZIEaD52yr3mR5xXCSvVgn2V1vCqO5PJvglBh4mvuOAjE5ays
        BjI50+XBbpc7MDcd63TWtp6EwUuH3WepePwhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f6iTfZdHPS/9T2meCdi50MM6/enIB5wF
        2X8CAh1biT6hzgTAL7djxmAKXPjmZVc5OTP5WSOuCToTiKqdVtcgDBuUjVINo4mz
        MnTEN67Ivwbdl9OJJPkVVO3JgtzeKT1sZ3gqnn6qdyjdeRbRkGoFLNq3TtE3XJ7Z
        aHxTyN1m7e0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 517F4E4974;
        Tue,  8 Sep 2020 13:18:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9657CE496E;
        Tue,  8 Sep 2020 13:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com>
        <20200903104537.GA27325@szeder.dev>
        <nycvar.QRO.7.76.6.2009081332020.54@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Sep 2020 10:18:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009081332020.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 8 Sep 2020 13:32:56 +0200 (CEST)")
Message-ID: <xmqq8sdkyypj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 404E666C-F1F7-11EA-8964-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> > index 6c27b886b8..1df9402c3b 100755
>> > --- a/ci/run-build-and-tests.sh
>> > +++ b/ci/run-build-and-tests.sh
>> > @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
>> >  *) ln -s "$cache_dir/.prove" t/.prove;;
>> >  esac
>> >
>> > -make
>> > +make SKIP_DASHED_BUILT_INS=YesPlease
>>
>> Please make sure that this Makefile knob is set in all jobs building
>> and testing Git, or justify in the commit message why it isn't.
>
> The intention was to set it in all jobs (but the jury, AKA Junio, is still
> out on that). Did I not do that?

I already said I understood and agreed with your reasoning why this
should be done everywhere, and as far as I can see, the "make"
invocation we see above is before the job specific case statement
starts doing things differently, and applies to everybody.

If I were "still out on" anything, it is that the proposed log
message of 3/3 does not explain well why this has a (good) effect on
the running of tests, and caused both Szeder and I confusion.  The
log message needs a bit more polishing.

I think the primary cause of the confusion is that it is not clear
to readers that the early three paragraphs refer to the building
(hardlinking) of git-foo in the source tree.  Because the primary
goal of the Makefile change in 2/3 is to stop hardlinking git-foo in
the installed location, it is easy for readers to mistakenly think
that these paragraphs still talk about the git-foo binaries in the
installed directory and miss the fact that we also make them in the
source directory without SKIP_DASHED_BUILT_INS.

Thanks.
