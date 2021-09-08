Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB3061108
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347208AbhIHAPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:15:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56309 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbhIHAPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:15:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17CE01460FF;
        Tue,  7 Sep 2021 20:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Me+njo7zVVZWXwPdfrEoS9IMxOHlRecB4fHmk
        t2HYY=; b=Sn6ZLyOgqzPWU94TjERWWELmMhGXV0VCWJdh8r2XUpwFWC9TOHgrh5
        vdGYdCEMBp2nX/riWBVrulc715vN6QbaC92lNsnrRTXbCOX2xdvimbURQnRAWzZK
        2QltqB2VYw4I92K31robQqzPbZlKkTVztIaL0ptoGVDRBBqbeW8wk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 110C91460FE;
        Tue,  7 Sep 2021 20:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 547511460ED;
        Tue,  7 Sep 2021 20:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v4] submodule--helper: run update procedures from C
References: <20210813075653.56817-1-raykar.ath@gmail.com>
        <20210824140609.1496-1-raykar.ath@gmail.com>
Date:   Tue, 07 Sep 2021 17:14:30 -0700
In-Reply-To: <20210824140609.1496-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Tue, 24 Aug 2021 19:36:09 +0530")
Message-ID: <xmqqk0jr9b4p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDB577D8-1039-11EC-A1B8-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> * Fix error message handling of the output of 'run-update-procedure'. While at
>   it, ensure the "checkout" mode error message is stored and printed
>   appropriately.
>
> * In 'run_update_command()' switch from 'run_command()' to
>   'run_command_v_opt_cd_env()' to ensure quoted command update modes are handled
>   correctly.
>
> * Code style and hygiene changes.
>
> * Introduce a NEEDSWORK comment, because the printf() and error return is
>   correct only because the shell caller in the other end redirects it to the
>   correct output stream. Once we switch this completely to C (ie, in the
>   follow-up series), I need to remember to die() instead (or print to stderr) to
>   reproduce the original behaviour.

I didn't see anybody comment on this round (and do not think I saw
anything glaringly wrong).

Is everybody happy with this version?  I am about to mark it for
'next' in the next issue of "What's cooking" report, so please
holler if I should wait.

Thanks.

