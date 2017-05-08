Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E434C20188
	for <e@80x24.org>; Mon,  8 May 2017 03:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdEHDlJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 23:41:09 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36833 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdEHDlH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 23:41:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so8126550pfd.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I9cGvHW7QfyZFL9RPPvPA/AVAzZTeNzhvhzTrH2WVEk=;
        b=PLFBMabVYt4elImweTRePPwPRVDmuUWOf7MCmKTe+Mk11Xk6tnm4NtLKvWzQxhT+jl
         FISZCZftCHzghMcQQqL45rThG4XCoj7JiQF1k0Qa6fB508pnZ6eHu2xVj7LjTU9yE/rF
         Gw3x6JfwTJOkd3014wKuvXH7KwcI01+uiwjf6kJRu+wFWgml9oj4dji7IjgHVVRXMlT2
         s0eXQ54Z+NCCXS8a16VIL6PXMz4pJcLg3UShCKaPxjP3BrIVeGdN+ENDQtwrr8ejLWiC
         2mUvT4gNfueDuPT/zWZoVQD5wnyB6z9bfWbrD1j2Aq1L9CdCXfqLmVMDOECVv/CVD2ir
         r9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I9cGvHW7QfyZFL9RPPvPA/AVAzZTeNzhvhzTrH2WVEk=;
        b=NIz7/Mr+OhcYtXflRUNCOmG90x1oNBAYZJF9xakKR7zDCZ+D44sXF0x1RoEhj6SWiT
         LvS7gusa5kY6qEJUuCzoGQSA00c+qNpzHwG5Mk3/FLHZZg4AlwNxBCJbngrgCSrRVFza
         QcEb3J0KsNbAX5lqbzqkg9eoKiNi1sYXFHoNsncjtir4mcGAuGIPEqd1EyDAwY2KMw0j
         LoOsHjCf9VA9lUDw9juEM4XrdaE7Bhfqi0cYEys7jXshSuXU1GCqdJH2AmOeaODmm2zN
         +liLxrnssM/JNOHuBakR8u+lENec4LhgaEMv/DR1JR7m1UQEWNXgGUuMa8JfEfpkSkGS
         r2Hw==
X-Gm-Message-State: AN3rC/7+5jqvnCPYG4BxPjmgeM654N6pbq7z9e0o0ncRZlRrUY5/CbVa
        xtBAakpy7AYoXA==
X-Received: by 10.84.230.135 with SMTP id e7mr83003627plk.20.1494214866492;
        Sun, 07 May 2017 20:41:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id 15sm21082846pfl.110.2017.05.07.20.41.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 20:41:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] Add warning when git discard changes on another branch?
References: <20170507233512.GA9332@HP>
        <xmqqzieo9hfo.fsf@gitster.mtv.corp.google.com>
        <20170508111836.GB3014@HP>
Date:   Mon, 08 May 2017 12:41:03 +0900
In-Reply-To: <20170508111836.GB3014@HP> (Yubin Ruan's message of "Mon, 8 May
        2017 19:18:39 +0800")
Message-ID: <xmqqvapc9fsg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yubin Ruan <ablacktshirt@gmail.com> writes:

> I understand this. I just suggest that git add some warning in case some users
> are not aware of this, as it does when , on branch 'issue', changes to 'lala.txt'
> are based on a commit different from where the checkout happened, i.e.
>       
>      on branch 'master'
>          |
>          |  <-- git checkout -b issue
>           \
>            \  <-- modification to git happened on a commit different from where
>                   the checkout happened
>  
> in this situation, git would warn us something like this:
>  
>      error: Your local changes to the following files would be overwritten by checkout:
>      	lala.txt
>      Please, commit your changes or stash them before you can switch branches.
>      Aborting

That does not have much to do with "are commits the same?".  If
'master' and 'issue' branches are pointing at different commit, as
long as they record the same content at the path "lala.txt", you can
check out between these branches freely, as we can do so without
having to resort to merging the edit the user made to the working
tree to the different contents of "lala.txt".

There already is an indication that you have local modification in
the working tree when we check out another branch (you would have
seen "M lala.txt" when you did a "checkout" of another branch while
you have local changes to the path).  

Because it is a quite commonly used feature that you can checkout
another branch and carry local changes with you, making it error out
like we do when the branches record different contents for the
locally changed paths when we do not have to would be a bad change
that hurts productivity of users who do use Git correctly, which
would mean that we need to make it an opt-in feature. 

But to help "some users are not aware of this" situation, an opt-in
"feature" would not help all that much.  The same number of lines in
the documentation to tell end-users how to toggle on such a "safety"
feature can be spent to teach them that their local changes in the
working tree do *not* belong to any particular branch, and as soon
as it is understood, the user would be OK.

So...


