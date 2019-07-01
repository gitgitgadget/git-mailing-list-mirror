Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513991F461
	for <e@80x24.org>; Mon,  1 Jul 2019 19:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfGATfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 15:35:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54103 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGATfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 15:35:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F15DA14B46B;
        Mon,  1 Jul 2019 15:35:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nvMpcs49fcNJZ+bUhrp6tVdwNg=; b=c9Xtjo
        kvp1sYSzZ/Rso6z/pj8+GoYtLXBajSbLBL5HxZMvvMP0jJRKnM0d6ctHPvkreN8i
        pHmOFHwdPdDRWC2XrBjpbsPwkXlaU546bo8DfotxY7G7Uf2uGCEiHBCGv6U51HwT
        YzDci2pW6PpTkojuFTlqDN1LEpYa4HL2/WeeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kxKK/x8NlDkV9IvuXnNj0l7nKVMYQwcK
        Hu7M1kzvyiFGgbrSyJiCKyZEF2QxXWo7iFKCPYbD+qS9nkvF0RMJwGW14+JvMtDG
        M6P8h+xFHLAFLArIo0MMPzTsTDe07AFHSjCW85ebcWCVIcrQEKu1FHVMzuLEgzV7
        Mp47Ks2ZkMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C741614B46A;
        Mon,  1 Jul 2019 15:35:00 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA73114B469;
        Mon,  1 Jul 2019 15:34:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Kulcyk <Eric.kulcyk@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Tracking parent branches in Git
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
Date:   Mon, 01 Jul 2019 12:34:58 -0700
In-Reply-To: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
        (Eric Kulcyk's message of "Mon, 1 Jul 2019 18:50:43 +0000")
Message-ID: <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5088AF54-9C37-11E9-AD18-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Kulcyk <Eric.kulcyk@microsoft.com> writes:

[Overly long lines are not appreciated around here.]

> We would like to track parent branches so that creating pull
> requests can automatically determine the correct branch to merge
> against.  I understand that this would require tracking more
> information than is currently available right now in git.  Also,
> it seems that if some cases, it is not possible to determine a
> parent branch, in which case it would just be empty/null.

Do you mean by "parent branch" what people usually call "upstream
branch" (i.e. when that branch on the other side gains more commits
independent from what you have been working on, then you would want
to rebase your work on top of the updated state of that branch on
the other side) around here?  Perhaps "git help glossary", look
for "upstream branch" and start from there?  The entry mentions the
configuration variables used to keep track of that information,
which are described in "git help config", I think.

> If I made a change to track the parent branch for each branch,
> would this feature be accepted/welcomed as part of git, even if it
> off by default?

Regardless of what is being proposed, this is often not a very
useful question.  Something worth doing for yourself is worth doing
whether others also find it useful ;-)  And others usually do not
have enough information to judge if such a change is welcome until
seeing it in a bit more concrete form.

Thanks.

