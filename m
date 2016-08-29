Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8762E1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbcH2XQS (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 19:16:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60474 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932295AbcH2XQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 19:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79E5F39592;
        Mon, 29 Aug 2016 19:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gu89Ueg6+Eof3sJMqEXb1uHeoxQ=; b=UmDuyX
        YHj04g4/02sDHbUHsMVWV8pr9Gznps5Tp8DdvYYPa68u6Pm5mKQ7qGkDlLyYR17W
        NMi6wrv6NcnA/TvR2dPli1UqCFsBx4vFdwtLM5cGyyYXOLw5SFF646g6FSqcUxhL
        fhykYNAf+UZ9UinBY/SYdWhY3U02GXPFKG80g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aWKlKJBNkCW6Ik5XtkXL5ykO/O7XdODK
        ITbGBlnIz6/H09Rpsulwwx7l5Q5u/9ldmQwDQAPKbqw10gBpXfgxB+xN/zd3a36W
        A8HFOHbcN8IombCB/BHKrDMqCyzE5upTs3X5w3ssgUv7uD28NPwRj23PbldkA7hZ
        rs34oi9StaQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7178139590;
        Mon, 29 Aug 2016 19:16:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11D793958C;
        Mon, 29 Aug 2016 19:16:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
Date:   Mon, 29 Aug 2016 16:15:59 -0700
In-Reply-To: <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        (Uma Srinivasan's message of "Mon, 29 Aug 2016 16:04:43 -0700")
Message-ID: <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90FD4948-6E3E-11E6-BEF9-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

> On Mon, Aug 29, 2016 at 2:13 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>> Ok that makes sense. Thanks much.
>>
>> Uma
>>
> With respect to my original problem with a corrupted .git directory
> under the submodule directory, I am thinking of adding the following 4
> lines marked with ### to is_submodule_modified() to detect the
> corrupted dir and die quickly instead of forking several child
> processes:
>
>                strbuf_addf(&buf, "%s/.git", path);
>                git_dir = read_gitfile(buf.buf);
>                if (!git_dir) {
>                  ### strbuf_addf(&head_ref, "%s/HEAD",buf.buf);
>                  ### if (strbuf_read_file(&temp_ref, head_ref.buf,0) < 0) {
>                           ### die("Corrupted .git dir in submodule %s", path);
>                  ###}
>                          git_dir = buf.buf;
>               }
>
> This fixes my issue but what do you think? Is this the right way to
> fix it? Is there a better way?

I think we already have a helper function that does a lot better
than "does it have a file called HEAD" to ask "is this a git
directory?" and its name I think is "is_git_directory" (I know, we
are not imaginative when naming our functions).

As to the check makes sense in the context of this function, I am
not an expert to judge.  I'd expect Jens, Heiko and/or Stefan to
know better than I do.
