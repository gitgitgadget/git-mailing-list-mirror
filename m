Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0382CC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhLQAef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:34:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58443 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:34:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 388B9EFAF0;
        Thu, 16 Dec 2021 19:34:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IhcfmNnlLiBJrvshuCFOSDF2ydxfE5VgUnjOi9
        LLvic=; b=hMEFm9ReX+9DcYoCJjEX8kxS4wdbZXmUl5GM0LRJ8X0TcSCMpI9VN/
        j5y8D8oMlXEhe0qONn+cYDy2rF65muV6F+bCcDqvsVjUjwf4o+l7Ei4WmPRVIgI1
        gCSftZSICsnms+ifqXpMrKd85szVrLe24c5aiXghV4rHxo3KTYFlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F012EFAEF;
        Thu, 16 Dec 2021 19:34:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87D6AEFAED;
        Thu, 16 Dec 2021 19:34:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5 0/5] implement branch --recurse-submodules
References: <20211216003213.99135-1-chooglen@google.com>
        <20211216233324.65126-1-chooglen@google.com>
Date:   Thu, 16 Dec 2021 16:34:32 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 16 Dec 2021 15:33:19 -0800")
Message-ID: <xmqq35ms6pd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AFEFC94-5ED1-11EC-93FD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This series implements branch --recurse-submodules as laid out in the
> Submodule branching RFC (linked above). If there are concerns about the
> UX/behavior, I would appreciate feedback on the RFC thread as well :)
>
> This series is based off js/branch-track-inherit.

Sigh.

When a series is labelled as "based off of X", I expect that the
series either apply on the tip of branch X I have, or it applies on
top of the merge result of branch X into 'master'.  It shouldn't be
forked at a random point on the 'seen' or 'next' branch, as you'd
end up depending on not just X but all the other topics that are
merged before X is merged to these integration branches.

This seems not apply on either c99fa303 (config: require lowercase
for branch.autosetupmerge, 2021-12-14), which is the tip of the
js/branch-track-inherit topic, or 47e85bee (Merge branch
'js/branch-track-inherit' into gc/branch-recurse-submodules,
2021-12-15), which is a merge of that topic into 'master' I prepared
to queue the previous round of this topic the other day.
