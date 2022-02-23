Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D3C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbiBWVYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiBWVX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:23:57 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEEA4ECF5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:23:28 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30FB211F49F;
        Wed, 23 Feb 2022 16:23:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZyfssYE7ee0/
        nBC6LotXMIDrqUJMZaqNjQuNgvSgJig=; b=u1VAxxjEy1r7Hf6Qp040ELMLDfu3
        jd8/fX9oA7+swvO2JjC/YyNsDoOB9epZO/dJUJqT15JYjr6LkKJW7mD3UQd/2AVF
        lLkOXpuG/wexemw7DaaN6gW9gCQ3hMuxu79LfsXT+S/hdmy+Nr6sVnf9DDRtaV1w
        1obnfRKD5XtR2FQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 291DC11F49E;
        Wed, 23 Feb 2022 16:23:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8478E11F49D;
        Wed, 23 Feb 2022 16:23:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Yuri <yuri@tsoft.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: When rebase.autoStash=true is used, 'git pull' merge process
 still complains when incoming changes are in a different place of the file
 than local changes
References: <efdd752b-5cff-c483-80eb-654b53fdde7c@tsoft.com>
        <3101d7c2-c78c-1f96-a7c6-08979d8f246b@gmail.com>
Date:   Wed, 23 Feb 2022 13:23:26 -0800
In-Reply-To: <3101d7c2-c78c-1f96-a7c6-08979d8f246b@gmail.com> (Phillip Wood's
        message of "Tue, 22 Feb 2022 16:37:44 +0000")
Message-ID: <xmqqa6ehtgz5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D738ACEA-94EE-11EC-A05C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 17/02/2022 20:50, Yuri wrote:
>> I have a file "x" that has one local change and some incoming pulled
>> changes.
>> Pulled changes are contextually very far away, so it should be
>> possible to merge them without user interaction.
>> But git still complains:
>> $ git pull
>> Updating 91bfe02..522ccf2
>> error: Your local changes to the following files would be
>> overwritten by merge:
>>  =C2=A0=C2=A0=C2=A0 x
>
> pull only uses rebase.autoStash if you ask it to rebase, if it is
> trying to merge then you need to pass --autostash on the command line
> or set merge.autoStash (assuming you want merge to always use
> --autostash).

I wonder if it would make a good #leftoverbit starter project to
introduce pull.autoStash so that those who want autostash only when
running "git pull" (but not "git merge" or "git rebase") can set it,
ignoring the settings of merge/rebase.autoStash variables.

Thanks.

