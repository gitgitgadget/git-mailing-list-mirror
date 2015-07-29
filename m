From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Wed, 29 Jul 2015 19:47:50 +0700
Message-ID: <CACsJy8A-cyXvFoK8HrubVnP9fP47oW_zJ9j5fLurEFB=2cLBrQ@mail.gmail.com>
References: <loom.20150727T133256-715@post.gmane.org> <CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
 <loom.20150728T115023-269@post.gmane.org> <vpqsi88qp6q.fsf@anie.imag.fr>
 <xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com> <vpq3808p40o.fsf@anie.imag.fr>
 <CACsJy8ABsHBA1TubB+6fypT0LGQF_O+CmHPqL+C7nMVjjWy38w@mail.gmail.com> <vpq8u9zjgzl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ed Avis <eda@waniasset.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 14:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKQmX-0000OD-MV
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 14:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbbG2MsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 08:48:21 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35444 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbG2MsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 08:48:20 -0400
Received: by iodd187 with SMTP id d187so19956090iod.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CoX4Fp0qcsuuDeoT9O2GLgMJ0GzaqMv1pViLrq9u068=;
        b=fYyCmstmJcGmQ2+t/9dU7UpAYVoC+fivGZdWnaVG08YXX0I+088MO6dU4tnpBnQg+R
         63a0tw/Vw62S8RO0YyD2kHTKIvwjH1J0JzNBhNljXJ/XPC53f+gsOVYaIgpNVQnE0Ld4
         ZXjJwv73Oqtrur5NCH8TqEu7TcnmgUQoru8x0Rdb2qlJDLhQ3In5sc89riwxtBP8YGXr
         Cis9jcA8PEl9a99f46lr66ePjFXm77LvY4S4k41wqYl7bTxE8lwYq9QNReDdX9ZpwnZu
         ogSpqr9v+Ifh76HOpAkjmZ9DlNxSsFjFzF9F/jll6BAkq+Hg64ggsHRn5yQaMHCiKhk9
         Lc/Q==
X-Received: by 10.107.15.210 with SMTP id 79mr1092352iop.192.1438174100144;
 Wed, 29 Jul 2015 05:48:20 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Wed, 29 Jul 2015 05:47:50 -0700 (PDT)
In-Reply-To: <vpq8u9zjgzl.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274894>

On Wed, Jul 29, 2015 at 7:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jul 29, 2015 at 12:48 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> If the user wants whatever she types in the resulting commit
>>>> literally, there is the "--cleanup=<choice>" option, no?
>>>
>>> $ GIT_EDITOR=touch git commit --cleanup=verbatim
>>> [detached HEAD 1b136a7] # Please enter the commit message for your changes. Lines starting # with '#' will be kept; you may remove them yourself if you want
>>> to. # An empty message aborts the commit. # HEAD detached from 5e70007 # Changes to be committed: #     modified:   foo.txt # # Changes not staged for commit
>>> : #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> You really don't want that in day-to-day use.
>>
>> How about --cleanup=scissors?
>
> I can read this in two different ways:
>
> 1) Keeping git as-is and suggest users to use --cleanup=scissors
>
>    This has the same problem as --cleanup=verbatim: it doesn't work as-is
>    since Git doesn't insert the scissors. You can hack around it by
>    adding them by yourself when you need it, but it's really not
>    convenient. You have to anticipate that you're going to require a #
>    and call commit with --cleanup=scissors, add the scissors. And repeat
>    it if you need to "commit --amend".
>
> 2) Modify Git to add scissors by default, and use --cleanup=scissors by
>    default.
>
>    This is actually more or less what SVN does: it inserts a line
>    "--This line, and those below, will be ignored--", and the equivalent
>    of what Git adds as comments in the template is inserted below this
>    line.
>
> I don't think option 1) is good. The fact that we have the --cleanup=
> option shouldn't serve as an excuse to do nothing. I'd be fine with
> option 2), but I find it much more intrusive than to allow a simple
> backslash-escaping as I suggest.

auto backslashing could cause some annoyance. Emacs supports
rearranging a paragraph to fit in a fixed text column. This generated
backslash may be moved around, no longer at the beginning of the line,
and it will remain in the commit message. I don't know how popular
this feature is outside emacs.

Having said that, even scissors has its own (and probably bigger)
problem: when you commit after conflict resolution, git inserts a
"Conflicts:" paragraph, prepended by core.commentChar. With default
settings, it serves as a reminder, but will be automatically stripped.
With scissors, it stays by default because it's placed before the
scissor line.
-- 
Duy
