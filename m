Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D255203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 20:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbcKKUwW (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:52:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936495AbcKKUwV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:52:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CD5B4E7CB;
        Fri, 11 Nov 2016 15:52:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3zrWHf+vwtvi6HrHqt04A5lUos0=; b=Eb5Wx4
        B9adD+fAEBPHrghSXTeuygmRHmj3sN0rkaoVUHFGm3WVxab2pe9MDI5+uMcEN8rJ
        UUyHjahX4YMmcJ+0cxGisDxh42FOq/bMYAlwh4XpPvZ2ZUgVXV9AP7rkTmZkZKB4
        uOghLVR4WnnZuFoqmiQO1mTBO7Jxj0yUP7nxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I9PkKk0jgHu/RaKexJJcFw9j8joSG3eq
        F2kZZBHIfvJKSXJb7b05sE7OPGiluiR+FH/m5kjm9ImLgPMozr1siQedjK7RRI4p
        r3eKV++0lkwCv2djp45U9maDQtq57V5ijFgTg39OMUjW6XQLQk1ZyQ6CEsGALQA3
        mPXWJ/7Lep8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04AD94E7CA;
        Fri, 11 Nov 2016 15:52:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 794704E7C9;
        Fri, 11 Nov 2016 15:52:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611111711210.3746@virtualbox>
        <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
        <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
        <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
        <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org>
Date:   Fri, 11 Nov 2016 12:52:18 -0800
In-Reply-To: <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org> (Johannes Sixt's
        message of "Fri, 11 Nov 2016 21:44:32 +0100")
Message-ID: <xmqq1syh3fjx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC86270A-A850-11E6-9315-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Good to know that I am not alone. This one fails consistently for
> me. I dug into it a bit today, but it drives me mad. Process Monitor
> reports that the redirected-to file (git-stderr.log) gets marked as
> "Delete pending" by git.exe, but I have absolutely no clue where this
> is coming from. Git.exe has no business fuzzing with the file; it just
> has to write() something into it, if at all. When 'git checkout' ends,
> the file is closed, and removed due to the "Delete pending" mark. At
> the same time, git.exe finishes with non-zero exit code. For whatever
> reason.
>
>> FWIW: This patch (which would be the right thing to do anyways) seems to fix
>> the flakyness but I can't be sure ... it needs to run longer...
>>
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 9ff5027..107766b 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -29,8 +29,7 @@ file_size () {
>>
>>  filter_git () {
>>  	rm -f rot13-filter.log &&
>> -	git "$@" 2>git-stderr.log &&
>> -	rm -f git-stderr.log
>> +	git "$@" 2>/dev/null
>
> If I remove the redirection altogether, the test passes for me
> consistently. The redirection isn't necessary anyway, it looks like a
> debugging left-over.

OK, then let's have

	filter_git () {
		rm -f rot13-filter.log &&
		git "$@"
                ...

and call that -rc1; to Windows folks, this is sweeping a mysterious
failure around git.exe under the rug, but for the purpose of the
overall project, it is far lower priority to figure out the reason
why a merely-redirected-into file is considered to be delete-pending
on WIndows than have something the end user can start testing and
complaining about new features and regressions.

Thanks.
