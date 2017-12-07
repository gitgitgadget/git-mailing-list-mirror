Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AF520C39
	for <e@80x24.org>; Thu,  7 Dec 2017 20:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdLGUum (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:50:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59299 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751002AbdLGUul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:50:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A88EC4A7A;
        Thu,  7 Dec 2017 15:50:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wtMKkCrgIZLwVCKZ0008aKic3Qc=; b=vbraOy
        x1C/rr2hoiqjN4+f/DNbpgnSuHkfr8FgR0295FXVr+uLZzhnp5eW1eoeeGDykmq9
        Xh1KKbzIAOzchZ4Of7iL8SfSguaCJWWHnuu6s1KbtGb6U1ppxtO23I3qkX0VXExC
        9ybhIcZS7uUFXeL/Fi6LtmiFO+Y+NR8IQTsTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wj4FbtenjGSrf1qzK2i8QoZOdMqBqu8H
        M4G2EMO0HQ5DFlytIuzfXvr5zvHGUcavoe9VyLFNSS+3CxrboC0NqWuOM/9L/VqT
        hJ0FOMsOySWpUAnsN45Xj6OoCO/PqjUqcPo4kiDkrJRllrJOBMffclKkjF9FNBDd
        ikFWOumsPZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C12FC4A79;
        Thu,  7 Dec 2017 15:50:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 953E5C4A78;
        Thu,  7 Dec 2017 15:50:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #01; Mon, 4)
References: <xmqqmv2ykvy4.fsf@gitster.mtv.corp.google.com>
        <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
        <alpine.DEB.2.21.1.1712071643410.4318@virtualbox>
        <20171207202201.GA3693@zaya.teonanacatl.net>
Date:   Thu, 07 Dec 2017 12:50:39 -0800
In-Reply-To: <20171207202201.GA3693@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Thu, 7 Dec 2017 15:22:02 -0500")
Message-ID: <xmqqlgiecleo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4919C0D2-DB90-11E7-92C4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Johannes Schindelin wrote:
>> That is not the only thing going wrong:
>>
>> 	https://travis-ci.org/git/git/builds/312551566
>>
>> It would seem that t9001 is broken on Linux32, t5616 is broken on macOS,
>> and something really kinky is going on with the GETTEXT_POISON text, as it
>> seems to just abort while trying to run t6120.
>
> I thought the verbose logs from the test might be useful, but looking
> at the travis output for that job[1], there's an unrelated problem
> preventing the ci/print-test-failures.sh script from running properly:
>
>    $ ci/print-test-failures.sh
>    cat: t/test-results/t1304-default-acl.exit: Permission denied
>    ------------------------------------------------------------------------
>    t/test-results/t1304-default-acl.out...
>    ------------------------------------------------------------------------
>    cat: t/test-results/t1304-default-acl.out: Permission denied
>
> [1] https://travis-ci.org/git/git/jobs/312551595#L2185
>
> I didn't see the same failure for other build targets at a glance, so
> the permission issue might only be a problem for the linux32 builds.

Curious.  

The acl stuff hasn't changed for a long time and I do not think of a
reason offhand why the test should behave differently between say
'maint' and 'pu', yet 'maint' is passing while 'pu' is not...

I wouldn't be surprised if Git::Error change is causing t9001
failure, as that can explain why 'pu' is different.
