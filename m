From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Thu, 30 Jul 2015 09:24:02 -0700
Message-ID: <xmqqoait7gwt.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<CALKQrge31G7-Ng8kZmy8=MgB+WQ3-bKimxCxOHOOwUMDuvRBzA@mail.gmail.com>
	<xmqqzj2fa764.fsf@gitster.dls.corp.google.com>
	<CALKQrgfeFrr5SygixW=pJoOCheGR9kUhqwjNyuXGvzJnWU_LyQ@mail.gmail.com>
	<xmqqpp3aapj9.fsf@gitster.dls.corp.google.com>
	<CALKQrgeLMWCKzEnPfv_WeL1-=eDQYtEk=tOejSG4JwPaoEGt=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:24:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKqcz-0006IB-80
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 18:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbbG3QYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 12:24:06 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36119 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbG3QYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 12:24:04 -0400
Received: by pacum4 with SMTP id um4so2200748pac.3
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uvEix7rVOouS9368iA+mhLO2+1i3xlsS1mAabbym5yU=;
        b=P4iDrgP2KKX5+/S376oIXXiQz8o0rz2DuWu7riFFmuLOnzJRGt2r8tTTMGTkARIgad
         D4iFdwp/kQwpxcMvDIefn0IjEGH3QRrh/vL2nNROAzUdu9iQW8FIwn0bmxS9oG5uZhyR
         bjKWFXn/vtoU+UmDVKllvQUg8BISAur2PXV7M6+iRTdg8Ukf6fSz/az8epzDKzQToJme
         5Gr+Lzf2up4xT3qoldgNPFMZjYk9CoHoj2pvOW2xbEIqarWwTBE/b/WB8S8tHzERAN5B
         Wg2/d4bdVd77JlpA9+kTJwX3olqHOpT5ZiONS6QP7ajaeUcmrICQuWsoDjUuhE0ExCa3
         g5oQ==
X-Received: by 10.66.119.70 with SMTP id ks6mr106516566pab.113.1438273444199;
        Thu, 30 Jul 2015 09:24:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id cq5sm3029019pad.11.2015.07.30.09.24.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 09:24:03 -0700 (PDT)
In-Reply-To: <CALKQrgeLMWCKzEnPfv_WeL1-=eDQYtEk=tOejSG4JwPaoEGt=Q@mail.gmail.com>
	(Johan Herland's message of "Thu, 30 Jul 2015 08:05:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275018>

Johan Herland <johan@herland.net> writes:

>> Actually, the name "linked worktree" is probably a misnomer.
>> ...
> Makes sense, although currently, IINM, those multiple $GIT_DIRs must
> be associated with strictly different branches, which is completely
> unrelated to the desired notes-merge restriction (which applies to
> notes refs - not branches). But this has been discussed to death,
> already.

Yeah, when we enhance "linked worktree" to make it easier to create
"bare worktree", we'd need to make sure it is easy to make them in
the detached HEAD state, i.e. not tied to any particular branch.

>> The user could attempt to start different notes merges in her
>> multiple $GIT_DIRs.  The question is to what degree we want to
>> support her.
>>
>> Is it sufficient to have these per $GIT_DIR, when the user has two
>> $GIT_DIRs connected to the same repository and wants to do two
>> "notes merge" acting on different ref in refs/notes/*?  Or are there
>> some other states in the shared part kept, which would be stomped on
>> by simultaneously running "notes merge" instances in different
>> $GIT_DIRs, that make this not to work?  Any other problems in the
>> remainder of the current implementation of "notes merge"?
>
> Still, I believe the answer is "No".

Good.  So the following would be a viable way forward.

>> But if there isn't, "[PATCH] notes: handle multiple worktrees" is
>> the absolute minimum thing we could
>> do to make "notes merge" usable by making sure that the user does
>> not attempt merging the same refs/notes/commits in two different
>> places.
>
> Sure. There's no point in delaying a patch that works well in practice
> just because I have a delusion of a theoretically cleaner solution
> that won't make any difference in practice.

I think the part of that patch that refactors the mechanism to
notice and disallow symrefs pointing at the same thing (with various
tweaks suggested during the review) is a good idea in the longer
term.  If we were to switch to a "you can do multiple notes merges
inside a single repository without any additional linked worktree"
paradigm in the future, we would not want (or need) to use that
"avoid pointing this symref to the same thing" code for notes merge
codepath, but that is not something we need to decide now.
