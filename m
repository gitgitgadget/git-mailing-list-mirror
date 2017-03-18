Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBCA2095E
	for <e@80x24.org>; Sat, 18 Mar 2017 01:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdCRBsF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 21:48:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751037AbdCRBsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 21:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E17157A5BA;
        Fri, 17 Mar 2017 21:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lqtzCB/oowTt2499F+Sx4ah56mo=; b=rXbRWq
        sLLuINBehX8Q6JsyGMsC0yiDn21zsKTbQZP46TlH+GKBvWWqobu21GJytSPXIRCI
        QyubKqSn9twc18jlLJ/I35xo3GVdQms0wYKZwtNxn05mHkbJ3zVDvnFjVfh7KIs3
        UNv3esDgMpfizYgZ9jXg2y4nv4RdilL8G+MH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZfT6NG/wIDGPX6kUUSFY0SH7TcKLTalg
        H/UamfT8HVzmAv8bAgJecJ+Z8xiF/VIc6y+brhpoY76krNEPArYiLx6lPY+6QTj3
        v6VFa54Oasxbq2hx6KrT36x5TP9ksXxMS+lpb+r+Z92naSLW+Ddv43eO3WSbLaKx
        886VKCTiIbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA0BA7A5B9;
        Fri, 17 Mar 2017 21:47:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55B377A5B8;
        Fri, 17 Mar 2017 21:47:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
        <20170317225532.GR26789@aiede.mtv.corp.google.com>
Date:   Fri, 17 Mar 2017 18:47:29 -0700
In-Reply-To: <20170317225532.GR26789@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 17 Mar 2017 15:55:32 -0700")
Message-ID: <xmqq1stv5pam.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9A892A2-0B7C-11E7-8DFA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I'm not sure I agree with this distinction.  "worktree" is just a
> short name for "working tree".

That is probably primarily my fault.  Loooooooooong before the "git
worktree" that is meant to replace the "workdir" thing in contrib/
was invented, some people said "working tree" while some other
people called the same thing "worktree", simply because it is
shorter.  Unfortunately I was among the latter, and wrote quite a
lot of documents and in-code comments, so it got stuck.  But later
we somehow ended up deciding on using "working tree" to refer to the
hierarchy of files that are checked out from a $GIT_DIR.

So if you see a message in the list archive, or an in-tree document
or in-code comment that was written way before that "let's call the
thing non-bare repositories have 'working tree'" decision was made
and have not been updated since, you are likely to find "worktree"
used to refer to "working tree".

And then relatively recently, Duy's feature started calling itself
"worktree".  The mention of "worktree" in git-worktree.txt, by
definition, is a lot newer than the "let's call the thing a non-bare
repository has 'working tree'" and was written after the word
"worktree" gained the new meaning, and it refers to that "different
things that can be referred to by setting your $GIT_DIR at them".



