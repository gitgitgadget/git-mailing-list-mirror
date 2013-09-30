From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 11:24:07 -0400
Message-ID: <52499797.9030100@xiplink.com>
References: <52327E62.2040301@alum.mit.edu>	<CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com>	<xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com>	<523D3FD2.4090002@alum.mit.edu>	<20130924075119.GD7257@sigill.intra.peff.net>	<alpine.LFD.2.03.1309251834210.312@syhkavp.arg>	<5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com> <5247ACB9.40208@alum.mit.edu>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmk=?= =?UTF-8?B?ZXRv?= 
	<cmn@elego.de>, Michael Schubert <mschub@elegosoft.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 30 17:36:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQfWd-0007sx-U1
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab3I3Pgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 11:36:33 -0400
Received: from smtp112.dfw.emailsrvr.com ([67.192.241.112]:42743 "EHLO
	smtp112.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab3I3Pgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 11:36:31 -0400
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2013 11:36:31 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 21C9F1E0A18
	for <git@vger.kernel.org>; Mon, 30 Sep 2013 11:25:21 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp82.ord1c.emailsrvr.com (smtp82.ord1c.emailsrvr.com [108.166.43.82])
	by smtp21.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id 02EEE1E0A17
	for <git@vger.kernel.org>; Mon, 30 Sep 2013 11:25:20 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp3.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 45F4D50177;
	Mon, 30 Sep 2013 11:24:08 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp3.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D268A5013B;
	Mon, 30 Sep 2013 11:24:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <5247ACB9.40208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235615>

On 13-09-29 12:29 AM, Michael Haggerty wrote:
> On 09/28/2013 11:42 PM, Johan Herland wrote:
>> On Sat, Sep 28, 2013 at 2:20 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>>> * How would somebody (e.g., an interim maintainer) suck down tags from
>>>   a project into his own refs/tags/* namespace?  (Would it even be
>>>   necessary?)
>>
>> I'm not convinced it would be necessary. I have yet to see a case where
>> a (suitably unambiguous) remote tag would not fulfill the same purpose
>> as the equivalent local tag. The only exception is for dealing with
>> ambiguous remote tags, where a local tag could be created to serve as a
>> tie-breaker.
> 
> I guess I was wondering how the interim maintainer would get Junio's
> tags into his public repo (which he would want to do, so that users can
> get everything from a single clone).
> 
> I think that the new version of "git push --tags" should *not* push all
> tags from all remotes; it should push only refs/tags, like now.  So I
> was thinking that the interim maintainer would want to import Junio's
> tags into his own namespace, then
> 
>     git push --tags $URL
> 
> But I guess it would be cleaner just to push using an explicit refspec:
> 
>     git push $URL 'refs/remotes/origin/tags/*:refs/tags/*'

(Thanks for the awesome summary!)

You seem to be considering the case of an interim maintainer who, prior to
becoming the maintainer, has his own clone of the "official" repo and now
wants to make his clone the "official" repo, perhaps only temporarily.

But what if the interim maintainer has his own tags in his clone?  What if,
after he is no longer the interim maintainer, he wants to remove the
"official" tags from his clone's local namespace?  The interim maintainer
might also have his own branches in his clone, which shouldn't be part of an
"official" repo.

It seems to me that an interim maintainer would be wise to simply mirror the
"official" repo and publish with that mirror.  So the gymnastics you're
contemplating don't seem necessary to me.

>>> [...]
>>> * How would this help somebody who wants to fetch content from multiple
>>>   projects (e.g., git, gitk, gitgui) into a single repo?  There might
>>>   be tags with the same names but very different meanings, and it would
>>>   be awkward if there were ambiguity warnings all over the place.

Why would there be ambiguity warnings?  The fetch command shouldn't issue any
warnings, since all the remotes' names get safely tucked away in distinct
namespaces.

Are we talking about DWIM warnings?  Aside from git-describe I don't see why
such warnings would be a problem.  To DWIM-resolve a tag name look in
refs/tags/* and refs/remotes/*/tags/* -- much like it's done for branches
already.  If a tag name has multiple matches then it's ambiguous.  Git could
be clever and check for matching SHA1 values, but why bother?  It almost
seems like a disservice to silently disambiguate such names.  I would think a
user would prefer to know about any possible ambiguities, rather than have
some suddenly appear (and maybe also disappear).

And as for git-describe, I think it should only consider remote namespaces
when asked to via a command-line option or configuration setting (again
following the behaviour of git-branch).  Let whoever implements such an
option define whatever disambiguation rules they like.  Although I'd suggest
that the first implementation be very simple so that we can learn how people
expect it to work.  We may just find that users don't want git-describe to
consider remote namespaces at all.

Aside from that, I guess I just don't see a problem with using the existing
branch name disambiguation rules.  Am I missing something?

		M.
