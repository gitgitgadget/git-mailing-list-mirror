Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A0320248
	for <e@80x24.org>; Fri,  8 Mar 2019 05:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCHFir (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 00:38:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32921 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCHFiq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 00:38:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id c13so8184275wmb.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 21:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rXkialR0PFhxOZ27ceWHxTnD3f7NkLKk+pyelt5l+/c=;
        b=Buesd2XYYFig04hm4uFGSup+lOp9xYvscOCH5A23pdqGPfMaOT0ZBuJFfndgPmrH5S
         M6xaO5Q2JIFfXYMGuVpLKHXBrav73uIYxdVPepED2Z2IopZUDUp9eLzvJ4pOg+eDBiqg
         K4y8z838KqMCu9TSf3xYwP6GaBBebUgtc0O7t3VFbi6xBqYADosl8IVost8UQoakz48N
         UZ0wQECbJgGZSN9X7VyysJA9pHjDSMTtbSVDqDDl89UjAXbWqf0JyRFPOn/W+BE7eavH
         PUNvBipluIDXCnVmM0I4VZ42pgWAsHFfGeMrm6cm0/1dI1OO0A7xCTk4MrCXRtSwU12l
         F/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rXkialR0PFhxOZ27ceWHxTnD3f7NkLKk+pyelt5l+/c=;
        b=g2Smc6mgxr0iY36kJeohx6OZArSWB8R231KHN7tMUM5QGoj9uMazXnGRlzkJYDaR+0
         H+0D8o8bLUwP474ONFQRqnAzI3oQeWh3d4Kmbz7SjOJi9jvqzXY2LJzqj6gW7FvHEVqJ
         rzpLJgS+1L7vS8280sZVdYeTGLlm4N1Fkp5SM5R1nzqxsTNzQzP1+vCCZFCtvfg5rze8
         /DQtUq65g12V27L1AZvZ/XDX4zFsYIf4fAb5g1UGvtXAQAdrJhC50SvGAdm4r7F3l125
         8ZLTnyn203Apt0OH/uUwQDldOLqrT1GySuULmPPzkjUZueevoUOGTCiQi/QNrbY6I0EC
         h9jg==
X-Gm-Message-State: APjAAAXqbJrr5R8RaTVK1XyksVbckxaCSD1f957TcwKWc5/Kecg3ZMrQ
        4MlfOf+DdzSfpeHKqwKC3E4=
X-Google-Smtp-Source: APXvYqwH3h9nQX98tJD8jh0ycxY0SDK6AkbXlI76+uATFoJuRKWQ4ax/BQllzY24HBcJmKQaqDqZ6w==
X-Received: by 2002:a1c:d0c9:: with SMTP id h192mr8037697wmg.103.1552023524943;
        Thu, 07 Mar 2019 21:38:44 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t133sm5316966wmf.3.2019.03.07.21.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 21:38:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
References: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
        <20190305142149.13671-1-rohit.ashiwal265@gmail.com>
        <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
Date:   Fri, 08 Mar 2019 14:38:43 +0900
In-Reply-To: <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 5 Mar 2019 09:57:40 -0500")
Message-ID: <xmqq7edancws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This patch, due to its length and repetitive nature, falls under the
> category of being tedious to review, which makes it all the more
> likely that a reviewer will overlook a problem.
>
> And, it's not always obvious at a glance that a change is correct. For
> instance, taking a look at the final patch band:
>
>     - ! test -d submod &&
>     - ! test -d submod/subsubmod/.git &&
>     + test_path_is_missing submod &&
>     + test_path_is_missing submod/subsubmod/.git &&
>
> Superficially, the transformation seems straightforward. However, that
> doesn't mean it maintains fidelity with the original or even means the
> same thing. To review this change properly requires understanding the
> original intent of "! test -d".
>
> ... , and
> many (volunteer) reviewers simply don't have the time to delve that
> deeply to make a proper judgment.

True.  The microproject was supposed to be a gentle introduction to
and a practice session of the process of modifying, committing,
submitting, and responding to reviews.  Learning the usual Git
contributor workflow, without spending too much community resources
like reviewers' time (as opposed to the real "here is my itch; let's
improve the system, and please help me doing so").

In any case, I have spent some time with the patch and I think the
changes are generaly OK; some (like using "test_path_is_missing foo"
instead of "test ! -f foo" after "git rm foo" to ensure the path no
longer exists) are improvements.

An unrelated tangent, but what do you think of this patch?  In the
context of testing "git rm", if foo is a dangling symbolic link,
"git rm foo && test_path_is_missing foo" would need something like
this to work correctly, I would think.

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 681c41ba32..dfe0d4aff4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -603,7 +603,7 @@ test_file_not_empty () {
 }
 
 test_path_is_missing () {
-	if test -e "$1"
+	if test -e "$1" || test -L "$1"
 	then
 		echo "Path exists:"
 		ls -ld "$1"






