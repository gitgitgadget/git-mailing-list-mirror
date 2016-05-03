From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] preparatory patches for the submodule groups
Date: Tue, 03 May 2016 14:32:38 -0700
Message-ID: <xmqqfutylte1.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<xmqqwpnalwf8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kakayOhPkCK4hbRkj-h2Bt+PqD69EgHk-chbu4xCA8_pA@mail.gmail.com>
	<xmqqoa8mlutg.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbm5y+LeyA_dwQWKFNaa42280cOvwQYZTP=-aRnySsB1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:32:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhvy-0006bJ-TO
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbcECVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:32:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756541AbcECVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:32:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C71C1185D8;
	Tue,  3 May 2016 17:32:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EzN3tp/3FQWtFDE3b5Oy2LO1n5Y=; b=UUg/t1
	erik635SLazFoWeXjoxHBHabk5I+nahOyNJkxJnxTSi7t4slCnW3iIiduRRtwoCE
	oedzrhmmsEVVOoiclxkH5uZM7MczHBkslDMvfeY77G7PcQey0btfbx+s4tCSwGoo
	+zOe2N/Sfw/ltfH4BwQfzMhz6SD+NDmLHhIUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qwr8VtSBXdVxyW2+bbvagjgMZoKVZmI3
	Ri672uKoD4Gbxlifxy5tz10vwB6g+SfB7JvbMaZHDuCdtCgovzuPPHYR7onqKiO7
	+2wPKfF2ughfnazehPLch4cOMhArMYBQAF4XQPFNcy2OTJlKupenjp1X9G0nWcEN
	rzgU99AiCXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF9A8185D7;
	Tue,  3 May 2016 17:32:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38E79185D6;
	Tue,  3 May 2016 17:32:40 -0400 (EDT)
In-Reply-To: <CAGZ79kbm5y+LeyA_dwQWKFNaa42280cOvwQYZTP=-aRnySsB1A@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 14:12:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90154898-1176-11E6-A096-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293460>

Stefan Beller <sbeller@google.com> writes:

>>> * I think we want to head for consistency, eventually.
>>>    e.g. commands with no arguments such as tag, branch
>>>    give a list of their respective domain.
>>
>> Isn't that a historical mistake we are regretting, though?  Only
>> after many other operation modes were invented and "create X" proves
>> not to be the only primary modes we had to invent "tag -l" and
>> "branch -l".  Aren't we better off not having "no option means list"
>> kind of default?
>
> listing is not destructive, and I really like to not type a single dash
> for some commands.

Actually, listing is destructive to the user's cognitive state.

I wouldn't be surprised if many people wished that "git branch" did
not list (and required "git branch -l" to list) to scroll everything
they are looking away but instead showed what the current branch is.

>>>    Subcommands do not give lists by default, e.g.
>>>    `git stash clear`, `git remote prune`
>>>    which are the moral equivalent to
>>>    `git submodule deinit` just work as they were told, no --switch needed.
>>
>> I wouldn't say "git rm" should remove everything by extending that
>> logic, but I can certainly buy if somebody argues "git submodule
>> deinit" is not destructive enough to warrant extra safety.
>
> `git rm` is a command, not a subcommand though.

Yes, it is a command, just like branch and tag you brought up.

"git branch -d" is not a command, but a mode of operation.  If we
did the "mode word" UI [*1*], it would have been a subcommand.  And
I certainly would not say it should remove everything if there is no
argument on the command line.

I am not sure where you are going with that though anyway.

I think the "safety" is about forcing user to be more explicit when
triggering mass destruction, and I do not think it matters if that
destruction is done by a first-class subcommand of "git", or
subsubcommand.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
