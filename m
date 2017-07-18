Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A3320356
	for <e@80x24.org>; Tue, 18 Jul 2017 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdGRRzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 13:55:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751413AbdGRRzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 13:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D8817AE30;
        Tue, 18 Jul 2017 13:55:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=opqB7pQY1AkXXkjPPKD1aGfnnG4=; b=a8s/HL
        rQGXobggWZV+Iy0ZhY6DfSZBJeR/ggRHp4h2AS4ivxdpc8xDOQtvb7LmiHhKfJUA
        f9wAisSrng/seCd7KU0441mzhIhEAtYIaOIbO3yCLL5VbcecqBFlsLNA92H1UVBH
        sDuVPV9nw8JmhudfNX0uiGXIa+8ya8Fnlejrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pN46+6cTmSSnvBlugK3vPCxbNint45rc
        ewRgmXZhvUxQwJOyfnCvahwEktf1Vn5XzmgHQWhwxT/elOQYtqD17L2uhoXw4SOY
        DdXiTALhcRMnrUxwjS2XvcD2zNycdd2cm2lj5dNXH2QmMJOgOLvmu9OTQcelAeH9
        huMH1t4p7hI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75F927AE2F;
        Tue, 18 Jul 2017 13:55:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEEAB7AE2E;
        Tue, 18 Jul 2017 13:55:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <596ddaa620821_77f83e7330107c4@ss1435.mail>
        <CAGZ79kaPFDMn2K0f529-Crzv+vhU3XUMsSM6w3QV4RXKBv5s_g@mail.gmail.com>
        <xmqqa841fylf.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYohev8BdBEL9qnfmZ6quMwZPDRqZ44qCKV_wMwR=Etiw@mail.gmail.com>
Date:   Tue, 18 Jul 2017 10:55:32 -0700
In-Reply-To: <CAGZ79kYohev8BdBEL9qnfmZ6quMwZPDRqZ44qCKV_wMwR=Etiw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Jul 2017 10:41:21 -0700")
Message-ID: <xmqqy3rleijv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BEB8E08-6BE2-11E7-B173-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I'd be more worried about segfault we seem to be getting only on
>> Windows from this:
>>
>>     git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ > actual
>>
>> in https://travis-ci.org/git/git/jobs/254654195 by the way.
>
> Thanks for bringing that to my attention, (I do not follow the travis builds
> as closely, as there is no yelling email in my inbox).
>
> Windows builds on travis seem to be flaky.
> (sometimes they do not start), but there are also
> successful builds, including the -rc0, which may indicate
> bw/grep-recurse-submodules may be faulty on Windows.

I can get valgrind complaints locally from

    $ cd t && sh t7814-grep*.sh --valgrind -i -v

so this may not be Windows only.  Can repo_worktree_path() return a NULL
in repo_read_gitmodules() to cause git_config_from_file() barf on a NULL
gitmodule_path?

==20383== Syscall param open(filename) points to unaddressable byte(s)
==20383==    at 0x5153140: __open_nocancel (/build/eglibc-SvCtMH/eglibc-2.19/io/../sysdeps/unix/syscall-template.S:81)
==20383==    by 0x50DDED7: _IO_file_fopen@@GLIBC_2.2.5 (/build/eglibc-SvCtMH/eglibc-2.19/libio/fileops.c:228)
==20383==    by 0x50D23D3: __fopen_internal (/build/eglibc-SvCtMH/eglibc-2.19/libio/iofopen.c:90)
==20383==    by 0x569107: git_fopen (/home/gitster/git.git/compat/fopen.c:22)
==20383==    by 0x55B1ED: fopen_or_warn (/home/gitster/git.git/wrapper.c:439)
==20383==    by 0x4A2A32: git_config_from_file (/home/gitster/git.git/config.c:1442)
==20383==    by 0x540317: repo_read_gitmodules (/home/gitster/git.git/submodule.c:269)
==20383==    by 0x434389: grep_submodule (/home/gitster/git.git/builtin/grep.c:422)
==20383==    by 0x4348C8: grep_tree (/home/gitster/git.git/builtin/grep.c:580)
==20383==    by 0x434867: grep_tree (/home/gitster/git.git/builtin/grep.c:576)
==20383==    by 0x436034: cmd_grep (/home/gitster/git.git/builtin/grep.c:622)
==20383==    by 0x4063DC: handle_builtin (/home/gitster/git.git/git.c:330)
==20383==  Address 0x0 is not stack'd, malloc'd or (recently) free'd


