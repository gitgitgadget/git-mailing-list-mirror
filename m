Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFB81F404
	for <e@80x24.org>; Mon, 17 Sep 2018 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeIQWh5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:37:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42695 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIQWh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:37:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so18102368wrr.9
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xYb1A4rCcf7PLOXsFoaB8kvpabhUKkVGl+sp0gWA4sU=;
        b=TAgsGdbp6h0RQEE6/rDuJKQ3TbYvH/nEhO028CUyOeuOjOTrjIBsdsvL7Shkecgg+3
         SI+5XhjWuVYy+31J0wQuWvv4dAvlNm2IVSyeeANNBIejMilQZfXqec/7mdb1ajEEyrmq
         ebFADpCv4CAOp7bBqcS6fQVtDqk/79C2hk9b2zHhONqdJAyHAlDqkeV8kUkJt3q8b34M
         oLw7Fc9qd4pw3TNvQscz3Pjv/t9bus42O2NYs43XyzMHekrT5KCByMkWIsutrkzgFSCX
         HJv3ZnwPkc0aSN5W3qOCeVvAWs7rYx0K989zyiNCWl0rcUUiIUa0lgTWO9RuyG6gmZ0g
         EKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xYb1A4rCcf7PLOXsFoaB8kvpabhUKkVGl+sp0gWA4sU=;
        b=GLwe43tkveceDpYQ+ARGQLo36+FyYauzJMHXe/7+5zoFxexe5SPEFx1BWXk67hmi4e
         snarxZjeeDjxygWL+1+yZ6dGcrXvSh5X9ITvubc2iZHYn4fv2nPajw3dGvaxrcF6/IPU
         CmOTVPMFkdjo4aWT/M/YEXNRKZtcjQa0I41VEw10fXdWL/0HRSZ3BY5opN8wEEbWWOFx
         mquLCHaBQUp3g7BOLlwoWz17AJjH37rJQTYg+iqxWarbs61C/7e6iHttBBz3JfRxaGSt
         JJLgQgeCFGi3UnqfKutKWfVNqlUbA5ZGssPyDTRLMC2KVTCibrqC5+hSaZ7XsaoqKrT5
         7EPA==
X-Gm-Message-State: APzg51COSLE8/+lKk8GesgVnp7ML9UWWQnwpeFz/pOt1Xxey0lEtKMKE
        QjedF1CQWLbXGG/EcS/WCko=
X-Google-Smtp-Source: ANB0VdbVf4jdp/mkB/Y5KtCfFD0RSy7VnFNj+9LQKQ9NC9ICR6CnK7p3DYJIc3qn/I7H6kCcwQ/D4g==
X-Received: by 2002:a5d:4d82:: with SMTP id b2-v6mr18689779wru.80.1537204179658;
        Mon, 17 Sep 2018 10:09:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v133-v6sm8376699wma.36.2018.09.17.10.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 10:09:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, jacob.keller@gmail.com
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
References: <20180820154120.19297-1-pclouds@gmail.com>
        <20180916063146.9850-1-pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 10:09:38 -0700
In-Reply-To: <20180916063146.9850-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 16 Sep 2018 08:31:45 +0200")
Message-ID: <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This is about mixing "git add -p" and "git commit -a" (or "git commit
> <path>") where you may accidentally lose staged changes. After the
> discussion with Jonathan, I'm going with a bit different approach than
> v1, this behavior now becomes default, and if the user wants the old
> behavior back, they can use --clobber-index.
>
> Another change is "git commit <path>" is covered as well, as pointed
> out by Jacob.
>
> I will need to add some test cases of course, if this direction is
> still promising. One thing I'm not sure about is whether want to
> deliberately clobber the index often, then perhaps we should add a
> config key to bring the old behavior back.

It usually is safer (simply because you do not have to think about
it) to start a behaviour change like this as a strict opt-in to gain
confidence.

As I often see myself futzing with the same file, adding changes to
it incrementally, so that I can view progress in "diff --cached" and
"diff" output, it would be a serious usability regression if the
last step in the following sequence is rejected by default:

	edit X
	git add X
	git diff --cached X
	git diff X
	... repeat the above number of times ...
	git commit X ;# or "git commit -a" to finally conclude

On the other hand, if I am keeping some change that should never be
in a commit in the working tree file, and building the contents in
the index using "add -p" to incrementally, it would be the same
disaster as you are trying to prevent if I by mistake did a whole
path 'add', even if I catch myself doing so before running 'commit'
i.e.

	edit X
	git add -p X
	git diff --cached X
	git diff X
	... repeat the above number of times ...
	git add X ;# OOPS!
	git add . ;# OOPS! even worse!

Even though this does not involve "git commit -a" or "git commit X",
an unrecoverable damage that requires redoing the manual work is
already done.

The approach to check if the contents in the index matches that in
the HEAD per-path (i.e. "The contents we are adding to the index is
whole working tree contents for that path.  But the index already
has contents different from HEAD for the path---are we losing
information by doing this?"), is a very good one.  But for the
protection to be effective, I think "git commit" and "git add"
should be covered the same way, ideally with the same code and
possibly the same configuration knob and/or command line option to
control the behaviour.

If the information loss caused by the "add/commit X" or "add
-u/commit -a" is so serious that this new feature deserves to become
the default (which I do not yet think it is the case, by the way),
then we could even forbid "commit X" or "commit -a" when the paths
involved has difference between the index and the HEAD, without any
configuration knob or command line override for "commit", and then
tell the users to use "git add/rm" _with_ the override before coming
back to "git commit".

How should this new check intract with paths added with "add -N", by
the way?
