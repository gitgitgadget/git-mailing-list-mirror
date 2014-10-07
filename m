From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Wed, 08 Oct 2014 00:24:23 +0400
Message-ID: <87fvezsk5k.fsf@osv.gnss.ru>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
	<xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 22:24:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbbJ9-0000Lc-8p
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 22:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbaJGUY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 16:24:27 -0400
Received: from mail.javad.com ([54.86.164.124]:44762 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbaJGUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 16:24:26 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 59EAF61878;
	Tue,  7 Oct 2014 20:24:25 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XbbJ1-0005kX-Lw; Wed, 08 Oct 2014 00:24:23 +0400
In-Reply-To: <xmqqzjd7enet.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 11:37:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257956>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> This option allows to create merge commit when fast-forward is
>> possible, and abort otherwise. I.e. it's equivalent to --ff-only,
>> except that it finally creates merge commit instead of
>> fast-forwarding.
>>
>> One may also consider this option to be equivalent to --no-ff with
>> additional check that the command without --no-ff  would indeed result
>> in fast-forward.
>>
>> Useful to incorporate topic branch as single merge commit, ensuring
>> the left-side of the merge has no changes (our-diff-empty-merge).
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>
> The workflow this implements sounds like "because we can", not
> "because it will help us do X and Y and Z".

Well, I do have full time job, and while I think I can instantly invent
quite a few things from the "because we can" camp, I usually don't.

> Why would it be useful to limit the history to a shape where all
> merges are the ones that could have been fast-forwarded?

Except by true merge, how else can I express with git that 'n'
consequitive commits constitute single logical change (being originally
some topic branch)? Now I just want such special kind of merge to be
entirely trivial merge on one side. i.e. perfectly clean merge every
time.

Moreover, as topic branches are usually rebased before merge anyway,
why shouldn't I have simple capability to enforce it?

> I cannot justify that sensibly myself, which in turn makes the
> feature smell to me that it is encouraging a wrong workflow.

What's wrong, exactly, in enforcing rebasing of topic branches before
merge? Basically, I need --ff-only, only I don't want git to forget that
this entire set of commits is logically single unit. Neither do I want
to loose the structure of commits that --squash offers.

-- Sergey.
