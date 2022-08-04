Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57171C3F6B0
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiHDQKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHDQKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:10:53 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A8A2AC5F
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:10:52 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EA1C1BD934;
        Thu,  4 Aug 2022 12:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1a/GuoE9bXaS4pTBT3ovBZqckJkWwPTiGwe5AE
        RveQA=; b=cAeiuXL5yBg0UsDpNDfZeUfyBb+sVRV0hnPVryPqayI0HCQscpcEzW
        3fV2X+O9U/APxTuxgeon3BpngEY65BSG0K0lOwttDTZnZqtIhEOqUgCHlEaXk4fU
        dKZBhBTM29JNrwF4HZx7jSdxTPq2NNYU6q0HMkm+QxhMIcHmljqnE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 374E11BD933;
        Thu,  4 Aug 2022 12:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6F0A1BD932;
        Thu,  4 Aug 2022 12:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
References: <20220803205721.3686361-1-emilyshaffer@google.com>
        <20220803205721.3686361-3-emilyshaffer@google.com>
        <6803b725-526e-a1c8-f15c-a9ed4a144d4c@github.com>
Date:   Thu, 04 Aug 2022 09:10:47 -0700
In-Reply-To: <6803b725-526e-a1c8-f15c-a9ed4a144d4c@github.com> (Derrick
        Stolee's message of "Thu, 4 Aug 2022 09:05:43 -0400")
Message-ID: <xmqqpmhg6lbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 011B4946-1410-11ED-80A8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/3/2022 4:57 PM, Emily Shaffer wrote:
>
>> +	/* feature.experimental implies gc.cruftPacks=true */
>> +	git_config_get_bool("feature.experimental", &experimental);
>> +	if (experimental)
>> +		cruft_packs = 1;
>> +
>
> This should be grouped into prepare_repo_settings() in repo-settings.c
> so we have a single place to see what is updated by feature.experimental.

Excellent.  I forgot about that.  Thanks.
