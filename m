From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset" during a merge
Date: Fri, 14 Mar 2014 13:55:44 -0700
Message-ID: <xmqqa9csh54f.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
	<5323131C.7070506@xiplink.com>
	<CADgNjan9kCTMPczFzO4jQvM63EU4x7KnJKszhno5PjHivE9ENg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 21:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZ98-0001x5-Mn
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 21:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbaCNUz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 16:55:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755812AbaCNUzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 16:55:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0D575FCF;
	Fri, 14 Mar 2014 16:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kut/bRBiDlyF9xO8xfI7+3DUlZg=; b=RZkZvB
	3eoTBUSu944hmrBlLd67NaXL3FDZfkh0NFU+HCin+iAIBCMJmnDiOVUMWv4S3m7W
	1RX+YontJFklwU/PvUlilqhS4Sy2zl9aGHGnWuNAG2zYSexltoYdWsZKiVRinIvo
	kO2JTwBOdTI0WV1apzUOvYcb8QFWqPCRQLkj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xlHj01IuOpJT6wjBik8PPcXiZ+TV7Fsd
	2dmtp+CBmdr8LuUxrWnwQ1+Dng+5GxorcLtTPoEdwiZVh7C7AIh5/2cwImUP3X7Z
	e1b2W0HVan5nMzx+qV76eU/dBRO4SRn5GlkB/3Vr0E4vCi/TexPgfe7uA6NwCeyi
	Vyfyi+sqchg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E7C75FCE;
	Fri, 14 Mar 2014 16:55:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAE2F75FCD;
	Fri, 14 Mar 2014 16:55:46 -0400 (EDT)
In-Reply-To: <CADgNjan9kCTMPczFzO4jQvM63EU4x7KnJKszhno5PjHivE9ENg@mail.gmail.com>
	(Andrew Wong's message of "Fri, 14 Mar 2014 13:04:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0434EF86-ABBB-11E3-8AEB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244108>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Fri, Mar 14, 2014 at 10:33 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> I know this approach was suggested earlier, but given these dangers it seems
>> silly to give this big warning on a plain "git reset" but still go ahead and
>> do the things the warning talks about.
>>
>> Is there any issue with changing "git reset" to error-out now but letting
>> "git reset --mixed" proceed?  Something like (note the reworded warning message):
>
> Yeah, I would have preferred to have "git reset" error out right now,
> because the messed up work tree can be quite a pain to clean up. The
> main argument for issuing the warning is about maintaining
> compatibility.
>
> For the users that really did mean "--merge", the warning is silly.
> It's basically saying "We know that you're about to mess up your work
> tree, but we let you mess up anyway. Learn the correct way so that you
> don't mess up next time".

I suspect that you meant "--mixed" instead of "--merge" here.

I do not agree with the "We know that you are about to mess up"
above.  Whoever is issuing that warning message may not know better
than the user who is running "reset".  As you wrote "most likely not
what the user wants" in your proposed log message, the only thing we
know is that it _often_ is a newbie mistake.

I recently needed to manually cherry-pick only one half of a patch,
and the way I did so was

	git show $that_commit >P.diff
        git apply -3 P.diff
        ... conflicts are expected; that is why I used -3 in the
        ... first place
        git reset
        git diff HEAD
	edit
        ... edit away the other half I did not want to cherry-pick
        ... while fixing the conflicted parts that happened to be
        ... in the part I did want to cherry-pick

"git cherry-pick --no-commit $that_commit" could have been used as
a replacement for the first two steps but being able to run the
"reset" without erroring out was an essential part to make this
workflow usable.

So I am OK with "eventually error out by default", but not OK with
"we know better than the user and will not allow it at all".
