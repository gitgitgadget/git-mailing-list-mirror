Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CBEE14B0
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 17:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjIFR0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFR0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 13:26:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D12B199B
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 10:26:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0A672B71E;
        Wed,  6 Sep 2023 13:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vV+jfLgMEoTH
        8uI/fK7sjiS4GkkEhFkXmd3hgQfZt2M=; b=cv3kzEhTgqaMdPwy3qWbCawT1jtd
        4MheuqOBIVywSrYIz+GqNPEpc16m3rylZOr+Gx5MsmcbuvBy+a72GPMC8aE2No7A
        ojKrGJCpWmn09hexmr21yK+OqUN5jC15fvN6J/zKyamHmmeEvEge28KdHf5ODO7u
        j35g9DM4wDx3V1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D92822B71D;
        Wed,  6 Sep 2023 13:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 465142B71C;
        Wed,  6 Sep 2023 13:26:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Young <hanyang.tony@bytedance.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] show doc: redirect user to git log manual instead of
 git diff-tree
In-Reply-To: <CAG1j3zFYbeXokd9kwN06RG7Wih_WsLVBf6jSi-JKtUpa=i4QJg@mail.gmail.com>
        (Han Young's message of "Tue, 5 Sep 2023 23:09:58 -0700")
References: <20230905121219.69762-1-hanyang.tony@bytedance.com>
        <xmqq7cp4p5gd.fsf@gitster.g>
        <CAG1j3zFYbeXokd9kwN06RG7Wih_WsLVBf6jSi-JKtUpa=i4QJg@mail.gmail.com>
Date:   Wed, 06 Sep 2023 10:26:09 -0700
Message-ID: <xmqqbkefnrgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 787BDB82-4CDA-11EE-9574-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Young <hanyang.tony@bytedance.com> writes:

>> Strictly speaking, "options to control how the changes are shown"
>> are options that are meant for "diff" command (e.g. "--stat", "-w"),
>> but "log" understands some of the "diff" command options, the
>> updated text is *not* incorrect.
>
> On a closer look, the manual page of git show does lists
> all the "diff" options by including diff-options.txt.
> The options omitted are revision parsing related.

The primary difference between "log" and "show" is that the latter
is not about walking a range of commits.  Both grok "diff" related
options that control how the changes introduced by each commit are
shown equally well.  But in the context of "show", options that
control revision traversal (i.e. which commits are chosen to be
shown and in what order) do not make much sense.

So ...

> Perhaps we remove the line
>
>> The command takes options applicable to the git diff-tree command to
>> control how the changes the commit introduces are shown.
>
> And rephrase the line
>
>> This manual page describes only the most frequently used options.
>
> to
>
>>=C2=A0 This manual page describes only the most frequently used options=
.
>> Some options that `git rev-list` command understands can be used to
>> control how commits are shown.

... I do not find the above an improvement.

Perhaps we should start with just "diff-tree" -> "log" and doing no
other damage to the existing text.  That will give us some baseline
that is a strict improvement.

Thanks.

