Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D34E1FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941271AbcLVWn4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:43:56 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941232AbcLVWnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:43:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DA7758B44;
        Thu, 22 Dec 2016 17:43:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XqGFZHwY128Vq9MVfwppJklHz5w=; b=CKZYNn
        oek+V1c3f7gfyYVvM+uC9b1lkIA8g0NbxITz2D8wCYLbxVqIVpL6CaVRYiC5FlIR
        MKP9jl/Il1jTjfn0WLlkWHvYFqxahBKz/A/rZuM1GAK1LV8Cu7xG7xd+csBQQo1O
        bIAYhHM0PVDtonlHgI4WZ7FpELQ+cMdsRKLJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=APEK7n/TJUpKklaHoaFpR+pApSaJ8l93
        xBM7cXfaIJlOEZEE5OkCjWNZe0MYr3pY0Dhb/4tz20iF0LXOWn+i/BcNN8y47zOE
        ev+SnW7WSkW9U3v+qcYxM+/cKh9b9GHNpgqMeKw1fmsL64nqCG1fWicJwVxB+hVP
        n8LPqQxUFPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0411558B42;
        Thu, 22 Dec 2016 17:43:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7784E58B41;
        Thu, 22 Dec 2016 17:43:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
        <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
        <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrkp-qiUVmfeLUcaMP-RSDbH4u3vCjVoQN8=mhz25Cd3A@mail.gmail.com>
Date:   Thu, 22 Dec 2016 14:43:53 -0800
In-Reply-To: <CA+P7+xrkp-qiUVmfeLUcaMP-RSDbH4u3vCjVoQN8=mhz25Cd3A@mail.gmail.com>
        (Jacob Keller's message of "Thu, 22 Dec 2016 13:41:38 -0800")
Message-ID: <xmqqpokjeg9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DFD11E4-C898-11E6-AD61-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>                 { OPTION_LOWLEVEL_CALLBACK, 0, "compaction-heuristic", NULL, NULL, N_("Use an experimental blank-line-based heuristic to improve diffs"), PARSE_OPT_NOARG, parse_opt_unknown_cb },
>>
>
> The unchanged context line should have its description re-worded to
> something like "Use an experimental heuristic to improve diffs" as it
> no longer uses only blank lines.

Thanks.  The final copy I pushed out has that change.

