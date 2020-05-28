Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74FAC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6338F208B8
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCxobdh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406355AbgE1T3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:29:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406289AbgE1T3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:29:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFC7058DBD;
        Thu, 28 May 2020 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2957OHn6DcMHWCl2mG0wTs7k1qA=; b=gCxobd
        h3ccCzEqtIm8NQ5rcIVKTgexR9TPuJMUMqM9b9cZx5+1+OnS3zEZDPRPlcoN+eiG
        1vROweplGuB0njLhU5x6MKMrOsNQyWNw+DnvytaBJJe/K4uEvW8qT77y0i1HBZKU
        j/49T04TLf5TbOaTBIhzDdB3QYgcJmA+KLEKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tamLuoJcOOuNReToHL9ILNKRgmylzoGn
        JNJxSNqpwR3x1PWMMAUBm74OlkMFq+1vYkzPAZdHGNdKLqsHm6bIardsXKGAW257
        lJxTKZKB+UwKZU/xAKUG5rs9X5WaNEoVDClm5CeC0SIEZj/TtjNpuuHzy5WKLYp7
        UyxK7kPIyoU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B62BD58DBC;
        Thu, 28 May 2020 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0743F58DBA;
        Thu, 28 May 2020 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@his.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200525232727.21096-1-keni@his.com>
        <20200525232727.21096-4-keni@his.com>
        <xmqqy2pb3new.fsf@gitster.c.googlers.com>
Date:   Thu, 28 May 2020 12:29:20 -0700
In-Reply-To: <xmqqy2pb3new.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 28 May 2020 11:49:27 -0700")
Message-ID: <xmqqo8q73lkf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87A8F11E-A119-11EA-980F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Kenneth Lorber <keni@his.com> writes:
>
>> +Git uses identifiers in a number of different namespaces:
>> +
>> +* environment variables
>> +* files in $GIT_DIR
>> +* files in the working trees
>> +* config sections
>> +* hooks
>> +* attributes
>
> The names of the subcommands "git" can spawn is a shared resource.
> You can install "git-imerge" program in one of the directories on
> your $PATH and say "git imerge" to invoke the program.  
>
> Two third-party developers may have to coordinate to avoid giving
> the same name to their totally-unrelated tools, if they hope that
> both of their tools to be useful in the larger Git ecosystem.

Also names of worktrees that are attached to a single repository.
If a third-party tool wants to make it "easy" for its users by
automatically taking a name to do its job (instead of forcing the
users to come up with a name and giving it to the tool), the name
must be chosen in such a way that it does not collide names in use
and names the user (or other third-party tools) will pick in the
future.

I (or others) may come up with other things that must be named and
name collisions must be avoided.  Even though I already said that I
didn't think the "suggestions to avoid name collisions" given by the
RFC PATCH are well done, I do think it is worth being aware of the
problem space, and enumerating what kind of names are shared and
limited resource is the first step to become so.

Thanks.


