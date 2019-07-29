Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73EFC1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 05:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfG2FTW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 01:19:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53603 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfG2FTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 01:19:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DE218D1D5;
        Mon, 29 Jul 2019 01:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UIB/MjnolgvTTiMoig+nkKFBcOA=; b=RL0RBR
        Ze+EZVLtJCsRi2Y90mSFZSVEiGgbAwl/WtzGyQaSySiRvGGJR1UQMGGiq6Mhsiew
        /tbP81Wh4dqRVcAngWi02jx5RjsL6ishuJvKRvrOSA97xtf/lkI1rMjYKqM4VcUZ
        zSS+U/Lp5WP58QnUXm/7K92uj2+hBB8bSeuhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tAGDwx5jSi+h5NU/kZkfZ6KXsmkJQEPf
        KtxxaPRvrfGb2+cIrI2ErbSLfIaDkPi+RLt1/AAvySr+bSdpchYierBNOlFsA9a4
        +u/7ZJtZFk+CrSy4W0TENWo3eCsba6tWLEGG3g4r/RQJ0dhjvmAExOhg8JGR+jmb
        a/Hv7sjuRtk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14D4F8D1D4;
        Mon, 29 Jul 2019 01:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C8C48D1D3;
        Mon, 29 Jul 2019 01:19:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christopher Head <bugs@chead.ca>
Cc:     git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
        <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com>
        <0DC4FE1B-90A9-414B-AFAC-E328608C4F98@chead.ca>
        <xmqqv9vnkxg1.fsf@gitster-ct.c.googlers.com>
        <C021D654-ECD4-4A23-9DE0-D272C3A3D901@chead.ca>
Date:   Sun, 28 Jul 2019 22:19:14 -0700
In-Reply-To: <C021D654-ECD4-4A23-9DE0-D272C3A3D901@chead.ca> (Christopher
        Head's message of "Sat, 27 Jul 2019 14:43:06 -0700")
Message-ID: <xmqqa7cxl8od.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 696B7170-B1C0-11E9-A935-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christopher Head <bugs@chead.ca> writes:

> On July 27, 2019 1:57:18 PM PDT, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>In the reverse direction, I think "git fetch" supports the notion of
>><group> of repositories, so that fetch from multiple remotes can be
>>initiated with a single command, but I am not sure if we added the
>>same <group> concept to the pushing side.
>>...

> If I understand what remote groups are (separate remotes but you
> can act on all of them with one command?) then they should be
> perfect. However it does not look like they work for
> pushing.

Yup, you are confirming what I already said ;-).

I do not offhand think of a fundamental reason why the <group>
concept should only apply to the fetching direction.  I am not sure
about a few design issues if we were to have "push" groups, though,
and somebody who wants to have the feature must think hard about.

Should the same <group> be usable for both fetching and pushing, or
should there be two separate and independent namespaces, one for
fetch groups and the other for push groups, so that the set of
repositories "git fetch groupA" fetches from could be configured to
be different from the set of repositories "git push groupA"?  It can
be argued for both ways, but I am unsure about the pros and cons.

How should the feature interact with push atomicity?  We obviously
would not want (and probably cannot afford) to arrange two or more
repositories coodinate by participating in two-phase commit etc., so
the best we could do may be to not even initiate push after seeing
a push to one destination fail, but there may be a better definition
people can come up with.


