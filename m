Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3CAC4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37FA24178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 21:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDqLkzmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504430AbgJUV5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:57:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51075 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502421AbgJUV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 17:57:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C0B31046DD;
        Wed, 21 Oct 2020 17:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ff973nrVRdVDAcRXSCwx5EeZvIY=; b=QDqLkz
        mYNwOglQAH3YAq0yVTtO/YSWd4zlSCVqkHk376elSKsPC/kukADmcwOsLN0UgP2n
        TqJ2AOWpu2zRJ7ThmPNmrO/tfOVUrEJ3/uhdVl/MSwKUL/2UEVupfvtqdmCrfqZd
        8YnYPCZ8ocsCPsi+Ui/7NpXQTWb/4nvvsc30w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o79/0DGk0BUBgRMkMQEbkrZBAQcA7D1A
        nGcoaogQuaziWdPussv0wWgrkZQu3rS6fkooP3n6XXw9duwedF631PfTTPedtvyY
        +hpFO4LzPQzTclfwvH1MSlQV2eh3FUzHlpO8G9RfJ4LD3/o0CuaA44V6proaJl4e
        FiwA8rZwXv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 850421046DC;
        Wed, 21 Oct 2020 17:57:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEE3C1046DB;
        Wed, 21 Oct 2020 17:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
        <fc5fecec-1a77-871d-d1f9-dad1bae8920c@gmail.com>
        <xmqq4kmn8lpp.fsf@gitster.c.googlers.com>
        <CEI_CVj6T-VEnw0cl0U6E5BSJ3Z6ZdYXAwnV96r8u0qbLK3EgS3b0Sqan1D_AgNqPm22FGPSL_easRZyLukEAIbbVCvxsiC9QVawVJBiTbI=@protonmail.com>
Date:   Wed, 21 Oct 2020 14:57:24 -0700
In-Reply-To: <CEI_CVj6T-VEnw0cl0U6E5BSJ3Z6ZdYXAwnV96r8u0qbLK3EgS3b0Sqan1D_AgNqPm22FGPSL_easRZyLukEAIbbVCvxsiC9QVawVJBiTbI=@protonmail.com>
        (Joey Salazar's message of "Wed, 21 Oct 2020 21:42:54 +0000")
Message-ID: <xmqqft675jjv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 683FF8E4-13E8-11EB-B1D7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Salazar <jgsal@protonmail.com> writes:

> Hi Phillip, Junio,
>
> Thank you for your reviews and support, they're much appreciated and I'm happy the patch looks ok.
>
>> I'll probably have to hand-edit the authorship before applying
>> (check the From: of the e-mail) so that the identity on the
>> signed-off-by trailer matches the author, but other than that the
>> patch looks quite good to me, too.
>
> My big apologies Junio, I mistook "authorship" to mean my `git config --global user.name` and `git config --global user.email` settings.
>
> Should I resend the patch email?

No need to apologize and no need to resend. You may want to send a
patch to yourself to prepare your procedure, but that is something
you can do without sending patches to the list.

Thanks.
