Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A77420193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943077AbcJ0Wq5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:46:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S942914AbcJ0Wq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:46:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7DE34B9A3;
        Thu, 27 Oct 2016 18:46:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2em8CNbUgWVm1zarOX3DH2y9MrY=; b=PBFVO9
        rqQc21+qSYcp9T0+bbUh0bW2ELXXzOhvMoRYRU0YgvBbyIYjNeE/E2zE1DNYzWhI
        Fh69BpJIcSJSlYkrPXBIbEYOSFPJ39eiU0GzWhFimocKYXQ4MzyCXpjhXJ1Vy4PD
        oAxrAN+cxSik3gNeHTdWF7hdseN6Pe5uKwRuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oqr+znQKxFdJ9v8kr/ffOi3d7IrVqhzd
        WBWPZUG58vB2U441NzFN2uGQLMHSbh/sFmGE8uqeizw0ngoA5/VAxwSvvglYgBY6
        lSNtAYfBs/m0ptxUlvoXYUtVL/kbS8/cIw3XLSMi0wWEiL3Nla7UhDPuZ02HhMMZ
        Vu3CJBOrL5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BED194B9A2;
        Thu, 27 Oct 2016 18:46:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4012B4B9A1;
        Thu, 27 Oct 2016 18:46:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Rood <mr.john.rood@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: feature request
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
        <CAGZ79ka7BvaW2pkjeXe68yKHFq6JsH__x2cXoe6U4tRmZ0rY1A@mail.gmail.com>
        <CALj-rGfAyimf0nFFcDHVHUgj8PQaz6Cvoz_PQfqdhr=QJEpbRw@mail.gmail.com>
Date:   Thu, 27 Oct 2016 15:46:52 -0700
In-Reply-To: <CALj-rGfAyimf0nFFcDHVHUgj8PQaz6Cvoz_PQfqdhr=QJEpbRw@mail.gmail.com>
        (John Rood's message of "Thu, 27 Oct 2016 17:44:20 -0500")
Message-ID: <xmqqwpgt4dgj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4202316E-9C97-11E6-A827-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Rood <mr.john.rood@gmail.com> writes:

> On Thu, Oct 27, 2016 at 5:30 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
>>> Users should be able to configure Git to not send them into a Vim editor.
>>>
>>> When users pull commits, and a new commit needs to be created for a
>>> merge, Git's current way of determining a commit message is to send
>>> the user into a Vim window so that they can write a message. There are
>>> 2 reasons why this might not be the ideal way to prompt for a commit
>>> message.
>>>
>>> 1. Many users are used to writing concise one-line commit messages and
>>> would not expect to save a commit message in a multi-line file. Some
>>> users will wonder why they are in a text editor or which file they are
>>> editing. Others may not, in fact, realize at all that a text editor is
>>> what they are in.
>>
>> Look at the -m option of git commit,
>>

[administrivia: do not top post]

> Thanks, I think changing the default for windows is a good idea.
>
> The -m indeed accomplishes one-line messages when you are voluntarily
> doing a commit. However, the scenario I mentioned is "When users pull
> commits, and a new commit needs to be created for the merge"  In this
> situation, the user isn't issuing the "git commit" command, and so
> he/she doesn't have the opportunity to use the -m flag.

There is --no-edit there.


