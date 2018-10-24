Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298251F453
	for <e@80x24.org>; Wed, 24 Oct 2018 04:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeJXNUf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:20:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40745 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXNUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:20:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so3977909wro.7
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GownWpzZJSba0XFv8rZhOnJNy9n7HU7v+LmGQKOgypc=;
        b=ISSEgX90BffcCQmONzxslWLf/dDKLIK4Zv4uY6E7nlx3AmICCSF/a6Ni5kGFbqsf5j
         Ucq9uEgMUxs10gA4QW25WPg0JKReQitNmHgE4aj/Z2htUcZXBak/Wx9M6iapoGJ4ZQll
         8yBp25ghx4N4IqBkUo0T0vLzOJIbHQVOxFksEpcfX+UuDUNQoMY0OJ+qu16QxcW9GlCG
         1apeEt8UZHbCdZcgdiExKoh0n23bm0s5Tn3mc+pcFzcsH4XrK4zoWtId+0gkYFQTeIAh
         iwXs7jrqISKR2ZvMUxyHyojEC63B4YJ9558jKnDJLAeX7/FDN5Qm5NincpTzv1KYS4dF
         lnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GownWpzZJSba0XFv8rZhOnJNy9n7HU7v+LmGQKOgypc=;
        b=dQzjS5weKILmjvQsW6MufIZpaqv/FVxWRcWj45lsrvrHriKWpHDIkbRm6BAShhNfrz
         82RmTHbvm1STtBi66Zzwla/CM8d2kNU1RhzkDdPWXRttsbVlI0Kp3kdiGkngY3GxtzN7
         IpBZ5Z/CbUKtewpORbtnyRXt1K3PfxzdTrWdzCwXGY9SYpQ2XzTTPu8wge582fQSsSym
         osIY95Bvm/CkDJRtNOmpMYg6KeU2x+lQ0E3ZUHHprR4EcHU0WpTXCj9MCVNWBc60X+34
         E5Wydbqod/xDNtPEk9nYfRKCwRyHySbB0+pjwwCTZ6lXt8eW0qGFrvRCWJzm6qycz0o6
         hysw==
X-Gm-Message-State: AGRZ1gLixUMhm6c2YhyjJ/Ct/e07FkDuCBI0wd0NktDleUrYoItPgzYQ
        4Kaac+C47SvMjNxBtcLDjT4=
X-Google-Smtp-Source: AJdET5fz4n4hYKlwZ1ErWZsA8rgefvOKD+QP1EJgkhPJFO1ziCZoks+xReQjjkjnt5TnumZ1fi7Auw==
X-Received: by 2002:adf:9592:: with SMTP id p18-v6mr1103576wrp.202.1540356847239;
        Tue, 23 Oct 2018 21:54:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l67-v6sm5280409wma.20.2018.10.23.21.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 21:54:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH] revision.c: drop missing objects from cmdline
References: <20181023215745.245333-1-matvore@google.com>
Date:   Wed, 24 Oct 2018 13:54:05 +0900
In-Reply-To: <20181023215745.245333-1-matvore@google.com> (Matthew DeVore's
        message of "Tue, 23 Oct 2018 14:57:45 -0700")
Message-ID: <xmqqa7n4osgi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> No code which reads cmdline in struct rev_info can handle NULL objects
> in cmdline.rev[i].item, so stop adding them to the cmdline.rev array.

"The code is not prepared to have cmdline.rev[].item that is NULL"
is something everybody would understand and agree with, but that
does not automatically lead to "so ignoring or rejecting and dying
is OK", though.  The cmdline thing is used for the commands to learn
the end-user intent that cannot be learned by the resulting objects
in the object array (e.g. the user may have said 'master' but the
pending[] (and later revs.commits) would only have the object names,
and some callers would want to know if it was a branch name, a
refname refs/heads/master, or the hexadecimal object name), so
unless absolutely needed, I'm hesitant to take a change that loses
information (e.g. the user named this object that is not locally
available, we cannot afford to add it to the pending[] and add it to
revs.commits to traverse from there, but we still want to know what
object was given by the user).

> Objects in cmdline are NULL when the given object is promisor and
> --exclude-promisor-objects is enabled.

A "promisor" is a remote repository.  It promises certain objects
that you do not have are later retrievable from it.  The way you can
see if the promisor promised to later give you an object is to see
if that missing object is reachable from an object in a packfile the
promisor gave you earlier.  

"The given object" is never a "promisor", so I am not sure what the
above wants to say.  Is 

    When an object is given on the command line and if it is missing
    from the local repository, add_rev_cmdline() receives NULL in
    its "item" parameter.

what you meant?  Is that the _only_ case in which "item" could be
NULL, or is it also true for any missing object due to repository
corruption?
