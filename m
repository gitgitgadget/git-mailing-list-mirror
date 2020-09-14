Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63114C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FABA21741
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ae/enpeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgINUHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:07:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54293 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgINUHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29A469DE3;
        Mon, 14 Sep 2020 16:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dfoXgtcuiKsST4khSJnYCndhMtw=; b=ae/enpeqVBaDBJ06MGKT
        OjkVg/TybGfZnoKW1FN3toE7q5waVDMlJicy/mQKuzD6yBb8ku+pBPkDkRefcMmj
        gDXQe8KO6oosuvbVAnWFZLnExmQNFH5WGsSVNoqUMspYk1Bvo5t28TDG5ILUv1n6
        Ukrr+ABpFVRdfhItSg9P3mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=nSe3Vg63JpiK4ycRzohFXBKd8D5Wq22UElzSEbZ9jcDmq1
        hqG+D0nDvtDWcXnwebvESzuLQwR+aGZsY/t7b/OUX01WWvj/w/235zCzFQTiVWFR
        3DV/wF16r1PG03lv281NkBohjFPEBu5lDfVE5q7m/LlMroegPF5baUSGFS0D4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A455269DE2;
        Mon, 14 Sep 2020 16:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2970F69DE1;
        Mon, 14 Sep 2020 16:07:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] Doc: cover multiple contains/no-contains filters
References: <20200911185754.64173-3-alipman88@gmail.com>
        <20200913193140.66906-1-alipman88@gmail.com>
        <20200913193140.66906-3-alipman88@gmail.com>
        <CAPig+cRaz+HPNW_WFX7UqcqtRwG_Td59LkXWF6HHoYOO1M6=bg@mail.gmail.com>
Date:   Mon, 14 Sep 2020 13:07:33 -0700
Message-ID: <xmqq5z8gktq2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED80ABB0-F6C5-11EA-B988-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> @@ -370,6 +370,10 @@ serve four related but different purposes:
>> +When combining multiple `--contains` and `--no-contains` filters,
>> +`git branch` shows branches containing at least one of the named
>> +`--contains` commits and none of the named `--no-contains` commits.
>
> This is repeated nearly verbatim in the other two documentation pages.
> It makes one wonder if it can be generalized and placed in its own
> file which is included in the other documents via
> `include::contains.txt[]`. Perhaps like this:
>
>     When combining multiple `--contains` and `--no-contains` filters,
>     `git branch` shows references containing at least one of the named
>     `--contains` commits and none of the named `--no-contains`
>     commits.
>
> But perhaps that's too generic?

Replace `git branch` with "this command" and make it even more generic?
Or eliminate the subject by going passive, e.g.

    Only references that contain at least one of the '--contains'
    commits but contain none of the '--no-contains' commits are
    shown

or somesuch?

