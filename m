Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3564E20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 03:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbdK1DrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 22:47:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60198 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751704AbdK1DrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 22:47:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EDD3C1B68;
        Mon, 27 Nov 2017 22:47:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8kEd2oVQOVZRGjC8Q267J87+vgw=; b=jhM9PY
        Z8EWddt1w6ebQz+dnnzZ/EBxonnH5m8s9mLVJyCAGd3SgECxDpxBU4v8mOZ/9xZ2
        rgHffJByYa/nAG8Gkgpx5VQS8M7ZFJkqvJLwkbmmjIk8V76MBi5qDD7Z0r2AME7/
        +UEoEF/XeLTo3l8N5RyyxLtHrwejq/wlPNsqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XeH/SO7diJPXu9niCf86HRF0DUhoHY/n
        NHR8Jwy0einaelCgGmuq0VPwhn+0mQ9rWTrRfunoD03ey+4VI9wpEckLtqa4AyAc
        ZeLZmf6UnrsNb1ddBiYOXxGBrTUP5TEMiduMthy1enOle5gwm0avjUoKI6He+oKW
        s590VxCfPsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33973C1B67;
        Mon, 27 Nov 2017 22:47:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B69CC1B66;
        Mon, 27 Nov 2017 22:47:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox>
        <20171128032538.98071-1-dnj@google.com>
Date:   Tue, 28 Nov 2017 12:47:15 +0900
In-Reply-To: <20171128032538.98071-1-dnj@google.com> (Dan Jacques's message of
        "Mon, 27 Nov 2017 22:25:38 -0500")
Message-ID: <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3C322D6-D3EE-11E7-8E16-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

>> In Git for Windows, we have an almost identical patch:
>>
>> https://github.com/git-for-windows/git/commit/bdd739bb2b0b
>>
>> We just guard the call to system_path() behind a test whether podir is
>> already absolute, but these days, system_path() does that itself.
>>
>> I am too little of a Perl expert to be helpful with the other patches, but
>> I would gladly runa build & test on Windows if you direct me to an
>> easily-pullable branch.
>
> Oh interesting - I've only peripherally looked at Git-for-Windows code,
> since Chromium uses its packages verbatim (thanks, BTW!). I think you're
> correct though - this patch set seems to be doing the same thing.
>
> I've been force-pushing my changes to the "runtime-prefix" branch of my Git
> fork for travis.ci testing. The latest commit on that branch adds a
> "config.mak" for testing, so one commit from the branch head will contain
> the sum set of this patch series applied at (or near) Git's master branch:
>
> https://github.com/danjacques/git/tree/runtime-prefix~1
>
> Let me know if this is what you are looking for, and if I can offer any
> help with Windows testing. Thanks!

FWIW, I plan to include this somewhere on 'pu' for today's
integration cycle, so dj/runtime-prefix topic branch would also be
what can easily be grabbed.
