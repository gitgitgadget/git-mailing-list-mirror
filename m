Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8888C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7653920790
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 17:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6lqg07v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgJ2RQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:16:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54321 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 13:16:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 325877D0B3;
        Thu, 29 Oct 2020 13:16:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iw3HddhUHMIoZhk8JMN+OOxb/Uw=; b=f6lqg0
        7vTwEwGEOUqjHyF5qzCr/3OMTzOPsh2zbYj71a/Dix0+ZbRf4QB6afyaxdZa4Arf
        PmuQEtDdH0Msgg7Ie7L4DFfLeD0OaCw6HJTMYmNtqWQrPbDzCWHZNX3ON3PI4PjE
        9kJw+CFnp/pHNDgSeZMfuLihvd/xLxO4QYimg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t5avBu4huQVOhkEaA0m81DSy7Z+SCFXn
        cJnvXJSTwvV3+3vlGv/w9GZZgxGMerTcUGWRAbEl3dWpml45Kpymv4jgyNjBgjiO
        f6GUqcIbu+KgjZPDERmIW/GwnGp0B6VM6cJKQTy4RsQ8D5GH90P4vE73t3bPogoq
        M2PNV+/EWyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7EB17D0B2;
        Thu, 29 Oct 2020 13:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC24A7D0AC;
        Thu, 29 Oct 2020 13:16:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
        <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
        <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
        <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
Date:   Thu, 29 Oct 2020 10:16:04 -0700
In-Reply-To: <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 28 Oct 2020 10:31:06 -0600")
Message-ID: <xmqqeelh7y23.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC49982-1A0A-11EB-A8E2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Oct 28, 2020 at 3:09 AM Stefan Haller <lists@haller-berlin.de> wrote:
>>
>> I might not be the representative zsh user, but just as one data point:
>> I have never downloaded the completion scripts from anywhere. I always
>> use the one that comes with my "distro" (which is the Mac git installer,
>> most of the time, which puts it in /usr/local/git/contrib/completion/).
>> I symlink that to ~/.zfunc/_git.

That's one data point.

>> I don't think it makes a difference whether the scripts live in contrib
>> or not. Bash completion is also in contrib, and yet it seems to be
>> shipped and enabled by most distros, as far as I can tell.
>
> Apples and oranges.
>
> There is no default completion for git in bash, neither in bash, nor
> in bash-completion, so if the distribution doesn't install the
> completion in the right place
> (/usr/share/bash-completion/completions/git), then the user would have
> no git completion.

True, as far as I know.  https://github.com/scop/bash-completion does not
seem to have an entry for "git" (/usr/share/bash-completion/completions/git
however is locally there on my box---probably the corp IT folks installed
it there), so what we ship in contrib/ is the most used (if not the only)
implementation of bash completion script.

> On zsh the situation is different; zsh by default has a git completion
> (/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
> it's more complete than git's zsh completion,

How is that completion script developed, maintained and distributed?

By "by default" I believe you mean that it gets installed when you
install zsh automatically.  Is the situation different on macOS land
(which I can believe, unfortunately)?

Stefan?  If at least some people argue what comes with zsh by
default is more complete than the one we have in contrib/, what led
you choose to "symlink" the less complete one to use it instead?

Another question (this is for Felipe).  Is

  https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast

the one that comes with zsh by default, or is it something else
(perhaps it is the go-to version for those who are not satisfied
with the version that comes with zsh by default???)?

Thanks.
