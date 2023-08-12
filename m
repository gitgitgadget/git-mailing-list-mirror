Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC87BEB64DD
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 01:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjHLBQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 21:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHLBQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 21:16:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E31BD9
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 18:16:26 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8521A8506;
        Fri, 11 Aug 2023 21:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rFS6TzM1QMKeMUe99FRrB2kwqOCjmrIeEU1rz7JAxM4=; b=ijlx
        IWocqJ5vSTud8iBKDpdHpVpPTFiZL6WSsIpxUwqVnC8NwW5IaoVT8T1F5+rpwj9G
        E9d9t6uICAZBCUvQ09I8TrS0eyB+bHJF1iVW+w3na+e+ZgqprsqYjRlGFUNdzv5z
        IrL7Z9oXSsR7trODnhT5Tj6NdH+VvpTldsHpr9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D44921A8505;
        Fri, 11 Aug 2023 21:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 505F41A8504;
        Fri, 11 Aug 2023 21:16:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Glen Choo <chooglen@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
References: <20230715103758.3862-1-andy.koppe@gmail.com>
        <20230715160730.4046-1-andy.koppe@gmail.com>
        <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
        <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
        <CAHWeT-Zo3nTTGBfJPwNhg50KfLn-GAdpU8WZ96d7fT9_axAQXg@mail.gmail.com>
        <xmqqv8dlqpq7.fsf@gitster.g>
        <61337dad-e1db-4f08-84f5-404bacc6c9bf@gmail.com>
Date:   Fri, 11 Aug 2023 18:16:24 -0700
Message-ID: <xmqqcyztnjpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB37A5DA-38AD-11EE-A7C9-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> On 11/08/2023 21:38, Junio C Hamano wrote:
>> Andy Koppe <andy.koppe@gmail.com> writes:
>>
>>> There are a number of uses of designated initializers already, so
>>> hopefully compound literals aren't too much of an extra challenge.
>>
>> I do not see how one leads to the other here.  I'd prefer not to see
>> use of a new construct we do not currently use mixed in a new code,
>> even if it is mentioned in the proposed log message.
>
> Okay.
>
> Would this style be acceptable to fulfil Glen's request to name the
> fields?
>
> 	case 'D':
> 		{
> 			const struct decoration_options opts = {
> 				.prefix = "",
> 				.suffix = ""
> 			};
>
> 			format_decorations(sb, commit, c->auto_color, &opts);
> 		}
> 		return 1;
>
> Andy

Sounds good to me.
