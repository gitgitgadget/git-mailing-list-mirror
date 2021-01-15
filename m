Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A5C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F0A2137B
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 01:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbhAOBMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 20:12:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53974 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbhAOBMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 20:12:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 433F911513B;
        Thu, 14 Jan 2021 20:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l7PsSmpo9qvsozJxgWIKNbSlbV8=; b=trbGDd
        92IiE0XnV6PZcqc5Um98WcGH/G7dnMD2WHPZiP/gACPQBXHbjyd9WRmC7bahw/cF
        w/IdMCcQ4YtLMchSBTxzgg8KcrR0YUS5MD7xF+aEmZ4FkxGOVvERgmXqseNQE0xU
        vtKm7eSG6oCl9CidUFeqfK94CZABP6J3//Afo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O8fsEvHKXbfmERXH4EpaJq14FyWIwFuu
        4C+zD0gVpN/PUxKzrVkYvD0GtkiVbycHvDOkBPWC3BBJef7N9aYVC1u3hOTxE1cg
        6ZtZrgZzXZXGfAZFTmUUp7hewv91HaAxVsgGbAO9M1QwJN31Y0H1kw4qgPUpz4Se
        2yfbghXUHxM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BF7C11513A;
        Thu, 14 Jan 2021 20:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 327C4115139;
        Thu, 14 Jan 2021 20:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: add a blank line when a commit has no parent in log output?
References: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us>
Date:   Thu, 14 Jan 2021 17:12:05 -0800
In-Reply-To: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us> (Jason Pyeron's
        message of "Thu, 14 Jan 2021 13:30:11 -0500")
Message-ID: <xmqq8s8vvw9m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF7A5492-56CE-11EB-95A0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> Is there a way to have it look like:
>
> | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> | | |
> | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
> | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)
>
> Or 
>
> | | | #  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
> | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)

This latter variant won't work.  Imagine we are showing --left-right
for example.  Which side does '#' belong to?

The former is not so great in that it wastes a line, and the break
won't be as noticeable when --graph is *not* used with --oneline.

It would be great to show it more like this:

 | | |   * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
 | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
 | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)

The point being that by shifting the column for the commit to the
right, it shows that 5505 is not a child of 3e65 (and 3e65 is the
tip of its lineage), and its parents do not appear in the displayed
history.  In the real life, the independent 'root' may be connected
to the main history somehow, so you may see a graph like this:

 | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history  
 | | |\
 | | | \
 | | *  \  23456789 2021-01-12 merge citest into the main history
 | | |\  * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
 | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) Added defau
 | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from f7daf088)


Hmm?
