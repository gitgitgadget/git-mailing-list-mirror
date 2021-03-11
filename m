Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4026C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7460164FA0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 18:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCKSMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:12:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58808 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKSMK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 13:12:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 358EAB434B;
        Thu, 11 Mar 2021 13:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7jjYDco3Gh7V5kCr3bpYgSgEMfo=; b=x4uWw0
        odoaUyMjQQdiVnLBmR2cWkcPONpPl9gaEMR6CJ0MuaPSyXktsBj237R8nW0JTe8V
        nfayZOueVc2alCFG7cCLyCbRdJJsAjUqllE3bMuBk1ybw+Ug7RRqVwa2uMZwmcVO
        WPcSmAyYTxt3spCxXpu4iTC9FXCYIpA7MSHtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lcw02h9Gy9LQb1IuUA8ZMzua532DpTgO
        K5w9cNXtcBOp7W/LGPPPdlvHDftcyGWHn1V6YUZ6u/77Rd24qfBPuuNAi+WGfXvZ
        LjP33OPJtViFASKmE+x0hgvAMc8jqb3XmCt6Tzxf6DrNQjZK83EH1e2PtJDzh0zS
        0THaAwEYpmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A2F1B434A;
        Thu, 11 Mar 2021 13:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ACD3B4349;
        Thu, 11 Mar 2021 13:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
        <CAFQ2z_NL1NYunAKwGGF2eK4hMS11gz_4VUw1rhd2rmPw60OZ9Q@mail.gmail.com>
Date:   Thu, 11 Mar 2021 10:12:05 -0800
In-Reply-To: <CAFQ2z_NL1NYunAKwGGF2eK4hMS11gz_4VUw1rhd2rmPw60OZ9Q@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 11 Mar 2021 14:01:27 +0100")
Message-ID: <xmqq35x1ef0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A39ACE8-8295-11EB-9956-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> However, the primary reason nothing has changed is that I posted a
> large round of updates early December, in response to reviews from
> Google's git team, and I haven't gotten any code review or other type
> of feedback since (except your one message about the errno side band)
>
> Is there anything I should do to get this moving again?

Unfortunately there aren't many effective things the patch authors
can do (other than making sure their series are easily digestible
and by begging X-<) when nobody is looking at their patches and
potential reviewers and those who may show interest in the series
are running around producing their own changes instead of giving
reviews, both positive and negative.

I try to chip in with my own reviewing time but I am only a single
person, so help from others are required.

Thanks.

