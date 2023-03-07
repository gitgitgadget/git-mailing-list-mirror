Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CCC678DB
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCGSAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjCGSAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:00:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE407498B7
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 09:54:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p20so14942278plw.13
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 09:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678211655;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxwQ9+rySAh2KJ490QJYwGKLSJqsSi7ScV7u1BqfkMY=;
        b=iueOB/uPKeWPLJ9o5nIhU0PITK3QZM+n0j8pU7hxDRf87QTzUstaD3dh1wRo57jn6Y
         x38ksPJ35oCVqOp+95/aX3ZLMC5BFO1j0U6HyyKzC8BX/PzeItWe5oG/o46uuSa6ZYCh
         RBxT4gKTkifFmB86qJFWigwDVkKETueu2Otnplufcr0PzLF7JSkTkw8xceaiL1CoJIAp
         tFHYONkzoLseVVK+L5fO1LsOR+pvvc/XU3qvh1nF3CzyjX90WIYQVlRuayW2FnkI4o4q
         NedYE8PvDNMdNV1VwlTuN7lv7oaJP43xEr7/g1U38BvyO7gnFMbfF6yFm5HaBqgn6qQb
         UFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678211655;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kxwQ9+rySAh2KJ490QJYwGKLSJqsSi7ScV7u1BqfkMY=;
        b=OF3N/n6ImbaYYaPI1dbqrRWfqQPOFmOmFMkGLmldj9fMb8sOGbThZ1O/fmBpnXV8K1
         ti1mxn9rorxT1oZ1xEQlaT9CzP+gNi6OH4xaEbJNZWWOaTsf7eu8/BdU+gX++HJbXsUs
         nbhDlyPSYkdT+o6go53SU5O0D9OsYW+LX79MpZEovVPbKV7BbxOpiXzpmwvXe+evan0J
         VC19Z+v3/TQaOr/ogB8Es57NPWDud96mikPUwwWC4Xg+YDygwUcAxg694imzspRmylWW
         tXAmZqZwqrUgkONfYah4NoJEnUs6MQ/NE93R6/rsvfY/BlIzrWm16INBOTG1xbfNvywG
         vrtA==
X-Gm-Message-State: AO0yUKXA85GAjQ8QxS4pqMNtmLjVVs5/WNFjTU31//AUWh7521f6FqZ8
        uENrNAZttbwTpV9tNDAVNGk=
X-Google-Smtp-Source: AK7set/sjQOdVHlFyopZMM3NwPQL556T6Qp9N6zNBQG7VkzvzZqp+J/GtClarycCqu0FDGNTZTZesA==
X-Received: by 2002:a17:90b:3909:b0:234:41c:74cc with SMTP id ob9-20020a17090b390900b00234041c74ccmr15553163pjb.42.1678211654974;
        Tue, 07 Mar 2023 09:54:14 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r13-20020a17090b050d00b002372106a5c2sm9424453pjz.37.2023.03.07.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:54:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru>
Date:   Tue, 07 Mar 2023 09:54:14 -0800
In-Reply-To: <878rg8j2vg.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        07 Mar 2023 13:02:27 +0300")
Message-ID: <xmqqzg8ozbuh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> We are walking in rounds here. Let me try to find at least some common
> ground. Could we try to agree on *one* of these 2 mutually exclusive
> statements, please:
>
> 1. Current -m behavior is useful
>
> 2. Current -m behavior is useless
>
> To me it looks like Junio thinks 1 is the case, and you, Glen, think
> it's 2 that is the case, ...

I agree you two are going around in circles and it may be time to
agree to disagree and move on.

I am not Glen but I do not think anybody is arguing "-m" that
does not do anything by itself is useful.  By definition, without
help with "-p", it is a no-op, so by itself, it cannot be useful.

The reason why I am not enthused by your series is because changing
behaviour of "-m" can be harmful, because "-m -p" is not the first
choice people would make when they choose to view what a merge
commit did.

Back when "-m" was invented (yes, "-p" came first before "-m"),
people were fairly content with "git log -p" that shows only
individual changes.  After all, merges were to integrate what these
individual changes on each side of the merged history did.  And you
need to be aware that "-c" and "--cc" did not exist, let alone
"--remerge-diff", even as a concept.  The philosophy of Git back
then stressed that these parts of Git were working as building
blocks to feed necessary data to be used by tools people who were
working at higher, end-user facing layers, would write.  And because
we ourselves have been mostly content with "git log -p" output that
omits patches for merge commits so far, a quick approach to give
output for such tools to consume without losing information was what
became "-m -p" output that shows pairwise diffs that such tools can
combine or do whatever they want to do.  This choice was also
influenced by the fact that we considered stronger than we do now
that all sides of a merge are equal---the idea that the first parent
chain was somehow special came much leter with the "--first-parent"
option.

So, given that background, "-m" that came as a modifier for what
happens (only) when "-p" was in use, is perfectly understandable.
In hindsight, it may appear to you that it should imply "-p", and
that it is an oversight that it does not imply it.

But it is more like how "git log --histogram" does not produce patch
output.  The mental model that allows it is that "--histogram" is to
affect the way how "-p" computes the diff---a purist in you may
argue that it should also imply "-p", but in reality, nobody
complained that "--histogram" does not imply "-p", probably because
nobody sane would say "--histogram" when they do not mean to show
diff out of "git log" anyway.

As somebody who saw how various options were invented while they
were added to the system, I view "-m" as an option to decide what
"-p" does when encountered a merge commit, and do not find it any
more odd that it is a no-op without "-p" or it does not imply "-p"
than "--histogram" vs "-p".

