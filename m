Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E1C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiGUQYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiGUQYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:24:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3C88E02
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:24:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 060431355A8;
        Thu, 21 Jul 2022 12:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k75D9nC2Mb8V
        24Km7yYmV+KQbX7YRySAopDb/gcVtTE=; b=qYEUrp30AxcBr/ZhisedTvtVzEPf
        nqvTb13vzc2Wx4PdwKe0C6jFIe3SzDPa4q9CjRpaHDVg1TINey1XwgYypWMrHPfj
        JtE6YkwX3a9WvR4vEphXF+SHL59AGFNdY8Tm1ne+6Svc8TwE2zmzHR5VODpkAH3i
        /Me4umawDt9+2SU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFFD31355A7;
        Thu, 21 Jul 2022 12:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54BDC1355A6;
        Thu, 21 Jul 2022 12:24:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/7] merge: make restore_state() restore staged state
 too
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:24:37 -0700
In-Reply-To: <91c495c770e3f7f91ae655a503bdd1cd99935e40.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:29 +0000")
Message-ID: <xmqq8roml9h6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9DBA5814-0911-11ED-BE83-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> =C2=A0 =C2=A0* stash the changes, in order to clean up after the strate=
gies
> =C2=A0 =C2=A0* try all the merge strategies in turn, each of which repo=
rt they
>      cannot function due to the index not matching HEAD
> =C2=A0 =C2=A0* restore the changes via "git stash apply"

A tangent that does not make much difference in the end, but I am
finding these lines curious and somewhat annoying.  Why do we have
&nbsp; sandwitching the plain whitespace only on lines that begin
with an asterisk?
