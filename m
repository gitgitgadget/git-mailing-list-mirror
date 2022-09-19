Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B0ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiISRl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiISRl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:41:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3D39B8B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:41:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D27C1CF136;
        Mon, 19 Sep 2022 13:41:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gWQOWdqbuRoBu3Z+OmrrvJTTniDAoBSJCMIwOa
        fIbWo=; b=MXn6WYJmxaOFTwQUxk0/+41bOWwfOknj8CI8FWIXWBC88qGAe+UDUb
        Di+iFy0C/OLzJWJBPsYAxjgWDMvuaW1ootiDTpvB/MgKJEVf0Zi5YtTRJCY9C72c
        WoJIUZxKmSZ1YpSBZnY/mmimE1V36/ApRBtDj/7kuC53dUCNbyzUc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35E121CF135;
        Mon, 19 Sep 2022 13:41:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E55E1CF132;
        Mon, 19 Sep 2022 13:41:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] commit-graph: Fix missing closedir in
 expire_commit_graphs
References: <20220919141441.5644-1-linmq006@gmail.com>
        <4f1cf64e-2864-a979-6f75-d9d4148d57da@github.com>
Date:   Mon, 19 Sep 2022 10:41:21 -0700
In-Reply-To: <4f1cf64e-2864-a979-6f75-d9d4148d57da@github.com> (Derrick
        Stolee's message of "Mon, 19 Sep 2022 11:04:46 -0400")
Message-ID: <xmqq7d1zb6ta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46E32B00-3842-11ED-B3BA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/19/2022 10:14 AM, Miaoqian Lin wrote:
>> The function calls opendir() but missing the corresponding
>> closedir() before exit the function.
>> Add missing closedir() to fix it.
>
> Thanks for the patch, Miaoqian.
>
> I only have a very tiny nitpick with the line breaks in your
> commit message. Either the "Add missing..." sentence should
> start immediately after the previous sentence or have another
> line break between the paragraphs. This shouldn't merit a
> re-roll, but keep it in mind for future contributions.
>
>>  out:
>> +	if(dir)
>> +		closedir(dir);
>>  	strbuf_release(&path);
>>  }
>
> This change looks correct to me. Thanks!
> -Stolee

Thanks, both.  Looking good.
