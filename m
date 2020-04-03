Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E73C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132F206F6
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uhgpLSUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgDCVkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:40:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54274 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 17:40:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AAC64C2D0;
        Fri,  3 Apr 2020 17:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bBSWegtmfgHLo07IaTMKjXu3tuA=; b=uhgpLS
        Uldq7jq/YE0TSVJYc3uw3bJXbGSh0MguQz+sEqsNc7wlikBl+yna0yul9av8Iwt2
        WFT/aJ4blmmNs2yBOz9MlhQ1/eQvwBLlKps1GuIaRb8+zmHO4zRh/DYLJW9OYiWs
        q+5EBKAIKfrvOvgTpxa3aZfeKsDHV5hClA60I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CQcT9k9g3RlSnJJQipajPRi2hn2nhKAM
        3tI6tvCEkTQ2xVwOqZcSCWgLVOLtsDXO/IP3hnPX2kf2qgkVRfgZ0HyzpwW4bwzH
        c8a7jVJeqfZZXBLlOATLU7RueJzm/UVoMkh9CyUDBHWZJCHLnmNlo0WE6sdNM7zy
        WCMszSPIg5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E72A4C2CC;
        Fri,  3 Apr 2020 17:40:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06A9B4C2CA;
        Fri,  3 Apr 2020 17:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 14:40:05 -0700
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Fri, 03 Apr 2020 20:47:59 +0000")
Message-ID: <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEF60E9C-75F3-11EA-A643-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * git run-job <job-name>: This builtin will run a single instance of a
>    maintenance job.
>    
>  * git job-runner [--repo=<path>]: This builtin will run an infinite loop
>    that executes git run-job as a subcommand.

What does this have to do with "git", though?  IOW, why does this
have to be part of Git, so that those who would benefit from having
a mechanism that makes it easy to run regular maintenance tasks but
are not Git users (or those that want to do such maintenance tasks
that are not necessarily tied to "git") must use "git" to do so?

I'll find out later why it is so after reading thru 15 patches
myself, so no need to give a quick answer to the above; it was just
my knee-jerk reaction.

Thanks.




