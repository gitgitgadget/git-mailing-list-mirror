Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F3C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283EF206B6
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W1svJUnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgKKTSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:18:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60231 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgKKTSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:18:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 098F2A27C6;
        Wed, 11 Nov 2020 14:18:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZElelmHKUvK6jIMN9MMKWuydJCc=; b=W1svJU
        nczbKvx0gla8jkys3WLInhLnLG/gol1BwwyB6+mU5DCK3xh8IGfhEQaqKqkBQnIO
        4mBW+osz/5gR+8lFJzUIGgWbavx87NlBSdL0FN49fRkFVzvZM5NoAf6S99H1iPpV
        lsdrvf4M3EDiwBEPqKIm9ECAHEF/5WD0Mo0Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KyL+YYhO5A+Xd88IDC16R0CoQ0djWSBw
        VPasJ7oHqAuIgWyO3gqljvy/Ps5VzeV2/RN+SLKCU25pFrM4rSF4RbaKBzM9mEj/
        dX9t5Yz69+d52LvZKDUDMMceFNy2QW6sYeWJC7VKs95u3wkJ7muuvQWEaNH/t6KK
        76nm5n3iQBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00748A27C4;
        Wed, 11 Nov 2020 14:18:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71E46A27C3;
        Wed, 11 Nov 2020 14:18:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jinoh Kang <luke1337@theori.io>, Junio C Hamano <junio@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: make diff_free_filespec_data accept NULL
References: <aeb24944-17af-cf53-93f4-e727f9fe9988@theori.io>
        <xmqq4km4lppy.fsf@gitster.c.googlers.com>
        <a0513d6f-1f69-683d-d6c5-75b17b8b6890@theori.io>
        <a096d122-52a3-700a-3a14-30a81b099cd8@theori.io>
        <137f0fc1-fbd9-a62c-bd52-cffd26c364bf@theori.io>
        <5d4315c5-a0ae-2857-fbcc-ec6166d025b6@theori.io>
        <nycvar.QRO.7.76.6.2011111727090.18437@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Nov 2020 11:18:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011111727090.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 11 Nov 2020 17:27:48 +0100
        (CET)")
Message-ID: <xmqqk0ur4s89.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9032FC4-2452-11EB-88BA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Jinoh,
>
> On Wed, 11 Nov 2020, Jinoh Kang wrote:
>
>> diff_free_filespec_data crashes when passed a NULL fillspec pointer.
>> Commit 3aef54e8b8 ("diff: munmap() file contents before running external
>> diff", 2019-07-11) introduced calls to diff_free_filespec_data in
>> run_external_diff without also checking if the argument is NULL.
>>
>> Git uses NULL filespecs to indicate unmerged files when merge conflict
>> resolution is in progress.  Fortunately, other code paths bail out early
>> even before NULL can reach diff_free_filespec_data(); however, difftool
>> is expected to do a full-blown diff anyway regardless of conflict
>> status.
>>
>> Fix this and prevent any similar bugs in the future by making
>> `diff_free_filespec_data(NULL)` a no-op.
>>
>> Add a test case that confirms that running difftool --cached with
>> unmerged files does not result in a SIGSEGV.
>>
>> Signed-off-by: Jinoh Kang <luke1337@theori.io>
>
> ACK!
>
> The patch looks good to go to me.
>
> Thank you!
> Dscho

Thanks, both.
Will queue.


>
>> ---
>>  diff.c              |  3 +++
>>  t/t7800-difftool.sh | 13 +++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/diff.c b/diff.c
>> index d24f47df99..ace4a1d387 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4115,6 +4115,9 @@ void diff_free_filespec_blob(struct diff_filespec *s)
>>
>>  void diff_free_filespec_data(struct diff_filespec *s)
>>  {
>> +	if (!s)
>> +		return;
>> +
>>  	diff_free_filespec_blob(s);
>>  	FREE_AND_NULL(s->cnt_data);
>>  }
>> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
>> index 524f30f7dc..a578b35761 100755
>> --- a/t/t7800-difftool.sh
>> +++ b/t/t7800-difftool.sh
>> @@ -728,6 +728,19 @@ test_expect_success 'add -N and difftool -d' '
>>  	git difftool --dir-diff --extcmd ls
>>  '
>>
>> +test_expect_success 'difftool --cached with unmerged files' '
>> +	test_when_finished git reset --hard &&
>> +
>> +	test_commit conflicting &&
>> +	test_commit conflict-a conflict.t a &&
>> +	git reset --hard conflicting &&
>> +	test_commit conflict-b conflict.t b &&
>> +	test_must_fail git merge conflict-a &&
>> +
>> +	git difftool --cached --no-prompt >output &&
>> +	test_must_be_empty output
>> +'
>> +
>>  test_expect_success 'outside worktree' '
>>  	echo 1 >1 &&
>>  	echo 2 >2 &&
>> --
>> 2.26.2
>>
>>
