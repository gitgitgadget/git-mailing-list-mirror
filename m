Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD6C77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 16:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjEPQLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEPQLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 12:11:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01C9ED5
        for <git@vger.kernel.org>; Tue, 16 May 2023 09:11:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EE2618DC62;
        Tue, 16 May 2023 12:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aqzUBfsH9wYi
        s4B7B+qcpVKaDCF+W0Lu+IUn4dI9Kyw=; b=g4QLgKlcx7vnO4Ufm3rXs9dOqsl4
        KXyf42Zcd4lpIRC7xrbfSZRyiqfamywI8ffyJWH5inr+sDBifGqLawuKi5vsPGmh
        Ri2bnYAhQXqOKyDiXqZUkFFzjbfBZawVxgbpi2qodlXt0SJHv24rvxC6jwbwkRkS
        V+fHRV3+mQRjHtk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6651A18DC61;
        Tue, 16 May 2023 12:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B798418DC60;
        Tue, 16 May 2023 12:10:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] tests: do not negate test_path_exists
References: <20230516022646.648123-1-gitster@pobox.com>
        <20230516022646.648123-2-gitster@pobox.com>
        <CAPig+cRwPUJZdov7eAZbZ1qji9qj_Oh5RQ8bpLWsXW9J+QnvPA@mail.gmail.com>
Date:   Tue, 16 May 2023 09:10:50 -0700
In-Reply-To: <CAPig+cRwPUJZdov7eAZbZ1qji9qj_Oh5RQ8bpLWsXW9J+QnvPA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 15 May 2023 22:53:31 -0400")
Message-ID: <xmqqzg64uuid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3A8CECB4-F404-11ED-855B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 15, 2023 at 10:37=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
>> As a way to assert the path 'foo' is missing, "! test_path_exists foo"=
 a
>> poor way to do so, as the helper is designed to complain when 'foo' is
>> missing, but the intention of the author who used negated form was to
>> make sure it does not exist.  This does not help debugging the tests.
>
> s/a poor/is &/

Thanks.

>
>> Use test_path_is_missing instead, which is a more appropriate helper.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
