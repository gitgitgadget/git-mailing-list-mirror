From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] cat-file: Remove unused includes
Date: Sat, 10 Jan 2015 01:15:27 +0600
Message-ID: <CANCZXo4x_xv8qA0FLmakVHj7p4zP9f8jQ5iSKx4-EZgoAmTsAg@mail.gmail.com>
References: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
	<CANCZXo7_yUT4x5fBvwNdc7d+ew5M7yaayGE_yXaeLxiPHzK9GA@mail.gmail.com>
	<CANCZXo4=TydW=DH9pU4aTOCZRgMnZr1inhmwNPUaDQZMMYt4Ww@mail.gmail.com>
	<xmqqiogfdb8p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:16:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9f22-0008Oo-3K
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 20:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbbAITPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 14:15:30 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:62123 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbbAITP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 14:15:28 -0500
Received: by mail-oi0-f54.google.com with SMTP id u20so13167091oif.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LFWBXZIIPJ0KLOnH0JHkMoRgtCnNsCOpZZYaFvU6m/U=;
        b=Hys/Ll4h0jhaORZY5WgJAaqkE6b4XbeffGY+fAUQpLL11qnTOl2nfdeyBy6GhWmw1D
         AsCSzLV0bBwDxfBKB8yteGqW30nUchnTzFEm/lXDcv+UABLapRVbVcrCApHMPh+1maKw
         H5sfxHZ4aSf0HngO1RHtxBRdz45upKxcOd4TfdbHRkM+KjQGMDZIQY35q5MCFj8tVgAD
         NHWxWVyiz8H/LOTD05USuo/7Acma29XZMBCCNiO4OnvvT7mlNgvMEEPioaa6UirhRfvu
         QRuUGXylTdHTrgE+WEnVvDhV45EkUCh9lYfUlsThf3egA6UaRIhJivUTfyXbLzU8izIg
         sWsQ==
X-Received: by 10.60.92.40 with SMTP id cj8mr10101734oeb.43.1420830927361;
 Fri, 09 Jan 2015 11:15:27 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Fri, 9 Jan 2015 11:15:27 -0800 (PST)
In-Reply-To: <xmqqiogfdb8p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262240>

Hello Junio,

Thanks for such great explanation, i understood you. I will update
this patch and resend it tomorrow.

Thank you.

2015-01-10 1:07 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> userdiff.h used in git_cat_file_config for getting textconv driver
>
> Yeah, but you know that I already know that when I pointed out about
> e5fba602 in the message you are responding to.  And your patch does
> not remove it, we still need to include it; we do not need to dig
> that part of the change.
>
> Two corrections to my message you are responding to are in order.
>
> I said:
>
>>>> I didn't dig further to find out the answer to the last question,
>>>> but a patch to remove these include should explain these in its log
>>>> message, I would think.
>
> but I think "should" was a bit too strong, especially without
> explaining why.  "It would have been nicer with such explanation"
> is what I should have said.
>
> And while on the topic, I should explain why.
>
> Most of the time, removal of "#include" is done because we used to
> include the header for a good reason (i.e. the source used to need
> something that is declared in it) but with a code change to remove
> the last such reference we no longer need to include it.  Commit
> 6d63baa4 (prio-queue: factor out compare and swap operations,
> 2014-07-14) [*1*] is an example.  We used to mention 'struct commit'
> in the implementation of prio-queue, but the commit realizes that
> the use of prio-queue does not have to be limited to queuing
> commits, and removes the need to include "commit.h".
>
> But this clean-up patch removes #includes without doing anything
> else.  It is clear we _can_ remove them; the submitter of such a
> patch would have made sure that the code compiles and links fine
> without these includes.  So "Why can we remove them?" is not a very
> interesting question.
>
> The interesting question is "Why remove them *now*?"  Why do we have
> these unused #includes?  Were they unnecessary from the start?  Were
> they necessary but during the course of the development, we did
> something else that made them unnecessary and forgot to remove them?
>
> These are the natural questions that somebody reading a clean-up
> patch like this one may ask, and that is why I think it would have
> been nice if the proposed log message answered them before being
> asked.
>
> So here is an update after I dug a bit more.
>
>  - "exec_cmd.h" became unnecessary at b931aa5a (Call builtin ls-tree
>    in git-cat-file -p, 2006-05-26), when it changed an earlier code
>    that used to delegate tree display to "ls-tree" via the
>    run_command() interface (hence needing "exec_cmd.h") to a direct
>    call to cmd_ls_tree().  We should have removed the include in the
>    same commit, but we forgot to do so.
>
>  - "diff.h" was added at e5fba602 (textconv: support for cat_file,
>    2010-06-15), together with "userdiff.h", but "userdiff.h" can be
>    included without including "diff.h"; the header was unnecessary
>    from the start.
>
>  - "tag.h" and "tree.h" was necessary since 8e440259 (Use blob_,
>    commit_, tag_, and tree_type throughout., 2006-04-02) as the code
>    used to check the type of object by comparing typename with
>    tree_type and tag_type (pointers to extern strings).
>
>    21666f1a (convert object type handling from a string to a number,
>    2007-02-26) made these <type>_type strings unnecessary, and it
>    could have switched to include "object.h" to use typename(), but
>    it forgot to do so.  Because "tag.h" and "tree.h" include
>    "object.h", it did not need to include "object.h" in order to
>    start using typename().
>
>    In today's code, we do not even have to include "object.h" after
>    removing these two #includes, because "builtin.h" includes
>    "commit.h" which in turn includes "object.h" these days.  This
>    happened at 7b9c0a69 (git-commit-tree: make it usable from other
>    builtins, 2008-07-01).
>
>
> Having said all that, what the above satisifies is mostly curiosity,
> and gives whatever value Postmortems have by analysing what we could
> have done better.
>
> It is OK to omit the postmortem and instead just say "These are no
> longer used; remove them.", which was your original.  So I shouldn't
> have said "*should* explain".
>
>
> [Footnote]
>
> *1* I pulled this randomly from "git log -Sinclude --grep=include"
>     output.



-- 
_________________________
0xAX
