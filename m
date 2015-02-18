From: Matthew Brett <matthew.brett@gmail.com>
Subject: Re: Advice on edits to git-rebase man page
Date: Wed, 18 Feb 2015 10:59:33 -0800
Message-ID: <CAH6Pt5q91aEF4X=RTBV8BMHHf7vuiaikn9PT42UAe3Ht6hLr3A@mail.gmail.com>
References: <CAH6Pt5pN8nrZzW+JntU5AWS1P4vu_JmdQBM_oR4Rfnh937wFPQ@mail.gmail.com>
 <vpqa90s4oz2.fsf@anie.imag.fr> <xmqqa90smbhu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Reuben Thomas <rrt@sc3d.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:01:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9sN-00032h-QN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbbBRTAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:00:17 -0500
Received: from mail-yh0-f53.google.com ([209.85.213.53]:37186 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbbBRTAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:00:14 -0500
Received: by yhoa41 with SMTP id a41so2126315yho.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C2YBQYb241rcHOf6gZf05OzrsIE+HbPNnWyqT1Kpejk=;
        b=yJ5X7TAxzpBp/9jr84cib9nnJ4vIw2va3G2O4S7TYYh9lpJybaBHEd2zsxxR+At9b1
         3Uua/LffUSepCr8kFEFCqGNGMJbeiGpBXiGykyBXBoRGymzHUJHwAkN921Izx+5EONo9
         H8kyFrm4WO1fAvzNbdLmnJbUZxtahkdcOpsOUi95kCvNY5CptfyedgKlTnCXrCMPvYJW
         vTgbhZ7AsdZ7xC5CPu/06KITQ5cKNDp7u6DgSQ1463yearqETK0ObkW5aN0xQRXhfMq+
         weIXZE9zc+UzYRwzz9Uar5XPv7zlSK3t8y2IbWgvA5BcAaX6eWfoVPyshwWoaXHRS5vW
         L5EA==
X-Received: by 10.236.26.138 with SMTP id c10mr829451yha.36.1424286013399;
 Wed, 18 Feb 2015 11:00:13 -0800 (PST)
Received: by 10.170.217.69 with HTTP; Wed, 18 Feb 2015 10:59:33 -0800 (PST)
In-Reply-To: <xmqqa90smbhu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264044>

On Thu, Feb 5, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>   NAME
>>        git-rebase - Forward-port local commits to the updated upstream head
>>
>> => Quite technical already.
>
> Very much true, and I would say the description is "technically
> correct" in the sense that "it is not wrong per-se".  There are a
> few points that this fails to state and some that this overspecifies.
>
>  - Rebase is about changing the base of an existing branch, but the
>    description does not even mention the word "branch" [*1*].
>
>  - There is nothing "forward" about it.  I often see myself applying
>    (tentatively) incoming patches on top of whatever commit I happen
>    to have checked out, review it and then rebasing it to apply to
>    older maintenance track if the topic is about fixing an old bug.
>
>  - There is no point stressing "local" commits; all the operations
>    you do to munge commits are local.
>
> Perhaps something like this instead?
>
>     git-rebase - Rebuild a branch on top of a different commit
>
>
>>   DESCRIPTION
>>        If <branch> is specified, git rebase will perform an automatic
>>        git checkout <branch> before doing anything else. Otherwise it
>>        remains on the current branch.
>>
>> => Ouch, do we really want to start a documentation like this?
>
> No.  We should say what the command does and what the command is for
> in more general terms first and then describe how arguments can be
> used to affect it.
>
>> So, the DESCRIPTION part can definitely be improved IMHO. Your notation
>> <graft-point>, <exclude-from> and <include-from> may be an improvement
>> already.
>
> <graft-point>, <exclude-from> and <include-from> aren't technically
> wrong per-se, but I do not think bulk-replacing the words currently
> used in the manual page with these is an improvement at all, unless
> the mental picture the explanation draws is also updated to match
> these new words.
>
> reBASE is about changing the base of the affected branch, and the
> mental picture the current documentation draws is "there is a plant,
> from which you cut a branch, scion. Then you graft the scion onto
> understock".  It calls the original tree (that the branch being
> transplanted is part of) the "old-base", and the understock (that
> the scion is going to be grafted onto) the "new-base".  The word
> "graft" in "graft point" may better convey that we are doing a
> transplanting than the current wording, but the word "point" makes
> it unclear to the readers if it refers to the "point" where the
> scion was cut from or where it is going to transplanted to, I am
> afraid.

Thanks for the detailed feedback, sorry to be slow to reply.

For 'graft-point' - I agree that it is not immediately clear whether
this is the start of the commits that will be moved or the place that
they will be moved to.  <newbase> and <oldbase> are really not too bad
in the current docs.  After all, the command is called reBASE.  On the
other hand, the term 'graft' gives the impression of moving part of a
tree from one origin (base) to another, which I think is correct,
whereas the 'base' terminology doesn't allow an obvious name for the
'shoot' or 'scion'.  For example, I don't think there is such a term
in the current docs, other than 'set of commits'.

> Also <exclude-from> and <include-from> is probably too operational,
> and describing the command with only these two words would miss the
> point that the command is about transplanting a branch.  It is true
> that in order to transplant a branch, you first need to figure out
> the set of commits whose effects are to be replayed, you would need
> <exclude-from>..<include-from> range computation, but it is an
> lower-level implemention detail.

First - the current docs have <upstream> for <exclude-from> and
<branch> for <include-from>.  I find both of these confusing and hard
to read:

* upstream - it isn't part of the semantics of rebase that the exclude
point should be something "upstream", that is only one of the common
uses.  I think this is related to the point you made about "forward"
in the one-line description.
* branch - too generic - does not convey the point that this is the
included end point of the selected history.

Second - I don't understand why the actual use of <upstream> and
<branch> for selecting commits is a lower-level implementation detail.
Is there some higher-level explanation for how these parameters select
revisions?

Thanks,

Matthew
