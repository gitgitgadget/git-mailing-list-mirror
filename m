Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04671C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3BD2098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x0dD95sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDXVYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:24:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgDXVYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:24:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 97AD6D5BBE;
        Fri, 24 Apr 2020 17:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8sGkinVm4SjB/9aaCak0WQILff8=; b=x0dD95
        sgoDbQQ87FUdHAbzxEt6R2HHRUVLg8Jun2/bFSHlOqzIKbtpzNWIIdH9YUcnCkCd
        HrMu5JvHcMCId18VIcph5eMo00Ied6YJGm2L0sYucWL5G8fuG6IcqnsZIvLaBAqz
        uXF+RAjuWUzHqXLMIKSi9THPGZ+zHOEw6OwrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UJxm4q9atm95ccHBcH7fpoM5OK7T/ZCp
        nxhOQQD0rdLZqn+OB3ARkZSmkwIX23LA4/8kKoCA89Na5CHaG6uyFuRJP0dbW15M
        osSDRk3eVUJ32NY4+AEgSpBtQ2hseQeaxnJ/hNpGlW+wgaDJQuhpmW5J1/dNgBib
        C0FrXJPPrd0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8FA51D5BBD;
        Fri, 24 Apr 2020 17:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4AE7D5BBC;
        Fri, 24 Apr 2020 17:24:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: fix GitHub workflow when on a tagged revision
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
        <xmqqlfmkbob4.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004242306450.18039@tvgsbejvaqbjf.bet>
Date:   Fri, 24 Apr 2020 14:24:45 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004242306450.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 24 Apr 2020 23:12:11 +0200
        (CEST)")
Message-ID: <xmqqd07wbmqq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05BCDC36-8672-11EA-BF8E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 24 Apr 2020, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > However, our GitHub workflow does not trigger on tags, therefore, this
>> > logic results in a missing build for that revision.
>>
>> Thanks for noticing.  The arrangement we had, which essentially said
>> "we know we will always build tagged version, so a push of a branch
>> that happens to have a tagged version at the tip can be ignored",
>> served us wonderfully.  Now the maintainers of projects (not just
>> this one) are forbidden from tagging the tip of master, queue
>> something else on top and push the result out, as it won't build or
>> test the tagged version, which is a bit sad.
>
> Nobody forbids this... ;-)
>
> And I was wrong, our current GitHub workflow _is_ triggered by tags. See
> e.g. https://github.com/git-for-windows/git/actions/runs/83103626 which
> was triggered by v2.26.2.windows.1.
>
> However, you also see that it failed due to the reason I described in the
> commit message.
>
> I guess that we should either go with this patch (which would trigger full
> runs also on tags), or we could alternatively trigger only on branch
> pushes (and not tag pushes)?

Hmph, even if we were to go with this patch (which should be safer),
we'd definitely need an updated log message, then.

Thanks for double-checking.

