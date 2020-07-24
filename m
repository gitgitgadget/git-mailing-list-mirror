Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951CC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1568920737
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T9vDfG46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXTuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:50:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTue (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:50:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF652DD3A0;
        Fri, 24 Jul 2020 15:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UhmNhkli8gdMJsHAcl/YBbHj5AE=; b=T9vDfG
        46LGa6fOJyPVteCIaFjhsunWCSQ68tNO309K6MDrI3GMK5lZn4lPbjfN9jLRjU5t
        c2Fl0Zqz4QCCF6aXBxbwjfDoRwdnLx4RITaCKO07ZCaDwbaO/FsE2AD5y4fg4T2U
        LilsaibWZKtfJzYr7jBuotHQv7SlwYG2Lbcu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wSQF0/zoEIpyji8JxsIug2JQmWZ9xqhw
        qjF/k98hKWXUbo8kUF3dfiL/ro/mOyU27ptgfihVQu9biu9HFhqGGEEbDQDbiGfD
        6PJNxAqVFgN2SsNhSAjP8FQe2bAaPOfvAtVOeF+9LLziloP9yG0Gt4+a6/YoTKmZ
        JlNC2tVD2zU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6EB9DD39F;
        Fri, 24 Jul 2020 15:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CB40DD39C;
        Fri, 24 Jul 2020 15:50:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/18] maintenance: add --task option
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <a09b1c16874c0fad6dd0df3ace573a2ffe34519e.1595527000.git.gitgitgadget@gmail.com>
        <xmqqimeeq8x4.fsf@gitster.c.googlers.com>
        <2c5e5ed3-155e-f963-02c8-2789c799f3f7@gmail.com>
Date:   Fri, 24 Jul 2020 12:50:28 -0700
In-Reply-To: <2c5e5ed3-155e-f963-02c8-2789c799f3f7@gmail.com> (Derrick
        Stolee's message of "Fri, 24 Jul 2020 09:36:35 -0400")
Message-ID: <xmqqtuxwlmkb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDAE847A-CDE6-11EA-99C5-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>  	for (i = 0; !result && i < num_tasks; i++) {
>>> -		if (!tasks[i]->enabled)
>>> +		if (opts.tasks_selected && !tasks[i]->selected)
>>> +			continue;
>>> +
>>> +		if (!opts.tasks_selected && !tasks[i]->enabled)
>>>  			continue;
>> 
>> I am not sure about this.  Even if the task <x> is disabled, if the
>> user says --task=<x>, it is run anyway?  Doesn't make an immediate
>> sense to me.
>>  ...
>> 		if (!tasks[i]->enabled ||
>> 		    !(!opts.tasks_selected || tasks[i]->selected))
>> 			continue;
>
> This isn't quite right, due to the confusing nature of "enabled".

Yes, in the message you are responding to, I was still assuming that
--task=foo that defeat task.foo.enabled=no would be a bug.  If we
want to run disabled tasks by selection, of course the condition
would need to change.

