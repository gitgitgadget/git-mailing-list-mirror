Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34687C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD80820801
	for <git@archiver.kernel.org>; Sun, 10 May 2020 19:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5gbR7z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgEJTK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 15:10:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59392 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgEJTK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 15:10:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 118C8CA947;
        Sun, 10 May 2020 15:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L30Wv71dxr9b1oWNQnAIo6NdzFI=; b=Y5gbR7
        z8G23XDgl8MrrMnA+LMo7AOHXVwGETUUTws4dD2MJVwDW0jDB0I1lTBrl8SnRV8o
        h6ekcfX8oqfZVmURFiURQisBFBA2QW5sI2T1w/PU2FQLbn17MIDpDP6VuiP+MD3T
        Yov7etzwbi1Ybr8FwUPx3lcsjoM0eVJM12TkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q1xgBwC6v6ta9T8hU8bc4NQ8lchOqNwn
        p6r83Wd080TAGQQ7oZ4fefJYvFN5pfD24uIjqiZjhMdN/Jy6hNYvtKDwm91xLlFO
        SYZqZQvphY9923ehxTCeH4EwS5BMOGautWwj6LJr2WihIHE5m8Iq0gShtEVFwt9K
        lktCa8ma3kk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A456CA946;
        Sun, 10 May 2020 15:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 53196CA945;
        Sun, 10 May 2020 15:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Brown <321.george@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
        <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
        <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
        <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
        <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
        <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
        <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
        <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
        <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
Date:   Sun, 10 May 2020 12:10:48 -0700
In-Reply-To: <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
        (George Brown's message of "Sun, 10 May 2020 19:34:09 +0100")
Message-ID: <xmqqk11jtxl3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F633449E-92F1-11EA-B637-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Brown <321.george@gmail.com> writes:

> I think with this change all editors can benefit.

I am worried not only about the editors that are launched by
git-jump that runs GIT_EDITOR, or the use case where you run
git-jump from within your editor.  "git jump" that is launched from
a process, whose standard output steam is not connected to a
terminal, used to spawn the specified editor just fine.  Imagine a
user wanted to spawn a graphical editor via git-jump from within a
GUI script (probably launched from a window manager menu and has no
terminal).  With git-jump with this patch, such a use will be
broken, no?  The GIT_EDITOR the user set is totally ignored.

At the very least, we should have an escape hatch to help those this
patch is hurting, perhaps like

        open_editor() {
                if ! test -t 1 && test -z "$GIT_JUMP_IGNORE_STDOUT_CHECK"
                then
                        cat "$1"
                else
                        editor=`git var GIT_EDITOR`
                        eval "$editor -q \$1"
                fi
        }

so that at least they can spawn their chosen editor, not "cat", from
the tool they have been using.  

Because this is a new feature, instead of breaking existing users
and forcing them to do something different they did not have to
(namely, set and export the GIT_JUMP_IGNORE_STDOUT_CHECK environment
variable), we should instead make this a non-default behaviour and
those who want it should explicitly opt-in to trigger it, perhaps
like:

        open_editor() {
                if ! test -t 1 && test -n "$GIT_JUMP_AUTO_CAT"
                then
                        cat "$1"
                else
                        editor=`git var GIT_EDITOR`
                        eval "$editor -q \$1"
                fi
        }

so that existing users won't get affected by this change at all,
while allowing you and other vim users to set and export the
environment variable just once.  

Unilaterally breaking, and ignoring when you are told you are
breaking, possible existing users, without giving them any escape
hatch, is simply irresponsible, and not something done in this
project.  But I am sensing that you are not listening to and
thinking about what you hear before you respond, so I will stop
spending time on this topic for now, and wait until others chime in.

