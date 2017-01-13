Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD48E20756
	for <e@80x24.org>; Fri, 13 Jan 2017 20:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdAMUHP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 15:07:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62038 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750923AbdAMUHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 15:07:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F3525E168;
        Fri, 13 Jan 2017 15:01:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGS3GYPVk14r3OGJ8s6FrC5QVps=; b=VnzCwD
        ZcO7//1de1AxzbHINbvsZagjNBUqZS7Jvw4gJlJL0jlVq+8xsnu1F3/G5uRezvwQ
        JGA+p2/gBDl95jmy1DQDzMFs+KVnHZGy0VTJ4Ja6VoTfYwZtLG8gTeHTRL4/fX4k
        sbWSlXJ6UQFziBwa2F3KbkqsIngfkZkqd94t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QrBfr+4rOJXaantmcipNVxghSgOOdjU+
        SQx+e0ag6Y5/axIcjmt9R2kp7sqO5O0mR1cwbxZy6SfzXXAvq+yPRHCYJ2drIrHs
        OvgFme/peFJt9w4rv7zE7S2MmXJkNfeXr2zSKL2wZk/5+hSZYGv12ar0Yqnoj5iu
        Mq8J/IhKKkg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 84D0D5E167;
        Fri, 13 Jan 2017 15:01:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E523A5E166;
        Fri, 13 Jan 2017 15:01:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
        <20170112055140.29877-3-pat.pannuto@gmail.com>
        <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
        <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
        <alpine.DEB.2.20.1701121118170.3469@virtualbox>
        <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
        <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
        <20170113024842.GA20572@starla>
        <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
        <20170113185246.GA17441@starla>
Date:   Fri, 13 Jan 2017 12:01:40 -0800
In-Reply-To: <20170113185246.GA17441@starla> (Eric Wong's message of "Fri, 13
        Jan 2017 18:52:46 +0000")
Message-ID: <xmqq37gmhgpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A054C7A-D9CB-11E6-A4AB-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>> > Pat Pannuto <pat.pannuto@gmail.com> wrote:
>> >> You may still want the 1/2 patch in this series, just to make things
>> >> internally consistent with "-w" vs "use warnings;" inside git's perl
>> >> scripts.
>> >
>> > No, that is a step back.  "-w" affects the entire process, so it
>> > spots more potential problems.  The "warnings" pragma is scoped
>> > to the enclosing block, so it won't span across files.
>> 
>> OK, so with "-w", we do not have to write "use warnings" in each of
>> our files to get them checked.  It is handy when we ship our own
>> libs (e.g. Git.pm) that are used by our programs.
>
> Yes.  "use warnings" should be in our own libs in case other
> people run without "-w"

Would it mean that we need both anyway?  That is, add missing "use
warnings" without removing "-w" from she-bang line?

> Yes, "-w" will trigger warnings in third party packages.
> Existing uses we have should be fine, and I think most Perl
> modules we use or would use are vigilant about being
> warnings-clean.  If we have to leave off a "-w", there should
> probably be a comment at the top stating the reason:
>
> #!/usr/bin/perl
> # Not using "perl -w" since Foo::Bar <= X.Y.Y is not warnings-clean
> use strict;
> use warnings;
> use Foo::Bar;
> ...

Good.

Speaking of Perl, I recall that somebody complained that we ship
with and do use a stale copy of Error.pm that has been deprecated.
I am not asking you to do so, but we may want to see somebody look
into it (i.e. assessing the current situation, and if it indeed is
desirable for us to wean ourselves away from Error.pm, update our
codepaths that use it).

Thanks.
