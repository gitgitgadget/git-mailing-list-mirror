Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04382C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D0C207E8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="feYtogx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgE0VKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:10:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62155 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgE0VKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:10:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F31454FB10;
        Wed, 27 May 2020 17:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=crP+ohUSKi0BqfOtICyDFVF8j+M=; b=feYtog
        x9m2WSTdVkPmw26eC3zm4ZLUQwDMSbs7lgkuza7th524Lutyv3ZyrlUEAQWdU70N
        SdFDI2FqviiZ250ZsjcyMm96Hih8lI2vi1Hewnb8pFE/vdy28dfmXRMAYth+ZFc6
        X1K1u1samWCWUuGqyHJ61WWvZKhpXPhB3F71k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6JnJKvJ3UENLN8uZVvT9UvBysBFdtna
        jbfepZHtr6BmzvXnL/nSEBJXvhgMwYnU/gE8akZ2ZE5dZkakeZr0zPu1ezPyYGNK
        NdKD5S+73L4AqJs5rnlZoK3esrIBF29pUe0Kb0wxQNascXcPiV9CI1IfJ4dWlbMm
        +e19etpzNRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C57E4FB0F;
        Wed, 27 May 2020 17:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2F694FB0B;
        Wed, 27 May 2020 17:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/5] cleanup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200527173356.47364-1-phillip.wood123@gmail.com>
Date:   Wed, 27 May 2020 14:10:04 -0700
In-Reply-To: <20200527173356.47364-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Wed, 27 May 2020 18:33:51 +0100")
Message-ID: <xmqq5zchkrtf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7034D982-A05E-11EA-9C45-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>     -+	git log -1 --pretty="format:%ai" >authortime &&
>     ++	git log -1 --pretty=%ai >authortime &&

It probably wouldn't make too much of a difference in real life, but
I think "--format=%ai" is how the above is customary written.

Some history.

The --pretty="format:<string with per-cent placeholder>" came first,
with an explicit goal of giving us enough flexibility to mimick
canned "pretty print" formats like --pretty=medium, --pretty=short,
etc. (note: it was *not* part of the goal to actually replace the
implementation of canned formats with hardcoded set of placeholder
strings).

If you run "git log --pretty=medium -2", you'd observe that the
topmost commit is shown immediately without any preceding blank
line, then an extra blank line is shown, and then the second commit
is shown, and after that, the output ends without any extra blank
line.  With respect to the "extra blank line", we call this
"separator semantics"---an extra blank is given _between_ two items
that are shown.

Like "git log --pretty=medium", the "format:<custom>" pretty print
format uses the "separator semantics".  There is no "extra LF" after
showing the last item.

Of course, the "separator" behaviour was later found to be
cumbersome if we wanted to mimick "--pretty=oneline".  The payload
of each item in the oneline output format lacks the terminating LF,
so instead of an extra LF between two items, we want an extra LF
after every item.  This, in contrast to "separator" semantics, is
called "terminator" semantics and --pretty="tformat:<custom>" was
introduced to allow.

Later, when we introduced --format=<format>, we made it so that 

 (1) when <format> is equal to one of the canned format names,
     "--format=<format>" is equivalent to "--<format>".

 (2) otherwise, when <format> has placeholders, "--format=<format>"
     acts the same way as "--pretty=tformat:<format>".

as we found out that people are often using custom format that
consists of only one line of payload, quite often as a way to
extract a handful of "fields" from each commit object.

So given all of the above, the "let's grab the author-time in iso
format and nothing else from each commit object" in the above
excerpt from your test is the use case for which --format=%ai was
designed.

