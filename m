From: Matthew Brett <matthew.brett@gmail.com>
Subject: Re: Advice on edits to git-rebase man page
Date: Mon, 23 Feb 2015 10:24:25 -0800
Message-ID: <CAH6Pt5p=PvGDsWF3R+=qkhA=HBW6n6WjEZxRF0T7cQNhf4D9gw@mail.gmail.com>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
 <vpqa90s4oz2.fsf@anie.imag.fr> <xmqqa90smbhu.fsf@gitster.dls.corp.google.com> <CAH6Pt5q91aEF4X=RTBV8BMHHf7vuiaikn9PT42UAe3Ht6hLr3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPxgx-0005xN-JT
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 19:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbBWSZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 13:25:08 -0500
Received: from mail-qa0-f45.google.com ([209.85.216.45]:45728 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbBWSZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 13:25:06 -0500
Received: by mail-qa0-f45.google.com with SMTP id j7so23383954qaq.4
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OZjLWGyyRtIYswPafdxt591WrM2S/5T7JmiA8sJN58U=;
        b=BurUTIHQkZPh3TKWYWMz8OTldA1xyduUqZg1o/EGUulpJ45wp/VCz62C5AENwjgxIr
         ryt5zIwQZUSArPMWXVFNpdAt8b1kRnOyJXCVC5V3BmksPTFo5eKkI6cWm+1pZEG6qvjc
         ZCbJQV/m8zSvGChwbQqXh1ZDA5zJMMQv2/epjvHYsDTuFQ4NvEGC+pv8Dj6ic0H7XjI1
         zGHM/6W7Sed4Xj8CPTc1RWS/JBXp5XN2Dz5WgRj4T6xabf9QVE+CGlflo0SmG+FvtykA
         BZ/oEpbkrC/Cw0s5ogemTLx6q9YXsupnfjr2h/OSm10/6XoK+nHRg9jVbtRV2VvptZJd
         dK7Q==
X-Received: by 10.140.135.200 with SMTP id 191mr27918208qhh.25.1424715905851;
 Mon, 23 Feb 2015 10:25:05 -0800 (PST)
Received: by 10.140.51.102 with HTTP; Mon, 23 Feb 2015 10:24:25 -0800 (PST)
In-Reply-To: <CAH6Pt5q91aEF4X=RTBV8BMHHf7vuiaikn9PT42UAe3Ht6hLr3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264278>

On Wed, Feb 18, 2015 at 10:59 AM, Matthew Brett <matthew.brett@gmail.com> wrote:
> On Thu, Feb 5, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>   NAME
>>>        git-rebase - Forward-port local commits to the updated upstream head
>>>
>>> => Quite technical already.
>>
>> Very much true, and I would say the description is "technically
>> correct" in the sense that "it is not wrong per-se".  There are a
>> few points that this fails to state and some that this overspecifies.
>>
>>  - Rebase is about changing the base of an existing branch, but the
>>    description does not even mention the word "branch" [*1*].
>>
>>  - There is nothing "forward" about it.  I often see myself applying
>>    (tentatively) incoming patches on top of whatever commit I happen
>>    to have checked out, review it and then rebasing it to apply to
>>    older maintenance track if the topic is about fixing an old bug.
>>
>>  - There is no point stressing "local" commits; all the operations
>>    you do to munge commits are local.
>>
>> Perhaps something like this instead?
>>
>>     git-rebase - Rebuild a branch on top of a different commit
>>
>>
>>>   DESCRIPTION
>>>        If <branch> is specified, git rebase will perform an automatic
>>>        git checkout <branch> before doing anything else. Otherwise it
>>>        remains on the current branch.
>>>
>>> => Ouch, do we really want to start a documentation like this?
>>
>> No.  We should say what the command does and what the command is for
>> in more general terms first and then describe how arguments can be
>> used to affect it.
>>
>>> So, the DESCRIPTION part can definitely be improved IMHO. Your notation
>>> <graft-point>, <exclude-from> and <include-from> may be an improvement
>>> already.
>>
>> <graft-point>, <exclude-from> and <include-from> aren't technically
>> wrong per-se, but I do not think bulk-replacing the words currently
>> used in the manual page with these is an improvement at all, unless
>> the mental picture the explanation draws is also updated to match
>> these new words.
>>
>> reBASE is about changing the base of the affected branch, and the
>> mental picture the current documentation draws is "there is a plant,
>> from which you cut a branch, scion. Then you graft the scion onto
>> understock".  It calls the original tree (that the branch being
>> transplanted is part of) the "old-base", and the understock (that
>> the scion is going to be grafted onto) the "new-base".  The word
>> "graft" in "graft point" may better convey that we are doing a
>> transplanting than the current wording, but the word "point" makes
>> it unclear to the readers if it refers to the "point" where the
>> scion was cut from or where it is going to transplanted to, I am
>> afraid.
>
> Thanks for the detailed feedback, sorry to be slow to reply.
>
> For 'graft-point' - I agree that it is not immediately clear whether
> this is the start of the commits that will be moved or the place that
> they will be moved to.  <newbase> and <oldbase> are really not too bad
> in the current docs.  After all, the command is called reBASE.  On the
> other hand, the term 'graft' gives the impression of moving part of a
> tree from one origin (base) to another, which I think is correct,
> whereas the 'base' terminology doesn't allow an obvious name for the
> 'shoot' or 'scion'.  For example, I don't think there is such a term
> in the current docs, other than 'set of commits'.
>
>> Also <exclude-from> and <include-from> is probably too operational,
>> and describing the command with only these two words would miss the
>> point that the command is about transplanting a branch.  It is true
>> that in order to transplant a branch, you first need to figure out
>> the set of commits whose effects are to be replayed, you would need
>> <exclude-from>..<include-from> range computation, but it is an
>> lower-level implemention detail.
>
> First - the current docs have <upstream> for <exclude-from> and
> <branch> for <include-from>.  I find both of these confusing and hard
> to read:
>
> * upstream - it isn't part of the semantics of rebase that the exclude
> point should be something "upstream", that is only one of the common
> uses.  I think this is related to the point you made about "forward"
> in the one-line description.
> * branch - too generic - does not convey the point that this is the
> included end point of the selected history.
>
> Second - I don't understand why the actual use of <upstream> and
> <branch> for selecting commits is a lower-level implementation detail.
> Is there some higher-level explanation for how these parameters select
> revisions?

Perhaps this email was not well-directed, or there is not much
appetite for a git-rebase rewrite at the moment.  In any case, I'll
unsubscribe for now, but if you think I can help, please do email me.

Cheers,

Matthew
