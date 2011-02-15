From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Tue, 15 Feb 2011 10:06:32 -0800
Message-ID: <7vipwlp3yv.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <201102151606.21040.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 19:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpPIs-0001Ph-TH
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 19:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab1BOSHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 13:07:05 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab1BOSHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 13:07:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C2A72921;
	Tue, 15 Feb 2011 13:08:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zeP6iBvTM/BgI4j+Aor8ROV40jM=; b=SC6+ZZ
	5q0ddq5ggysRe9CXW9Qm+ylRkq+Wk6AlwCcueWda3jwjaIgij0enhmVNFbLBR8bz
	WB6fHPE29hjWisfq9rEp4qN14ZCkpMtXAy681xyqIh2MrCov3uAXY/K+HXJoGzp/
	MFzXxm6lVh2OYGmOJDhA9MH1hw4YOTYr2KR34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P98AZ+uVXOns8yre4ZCX6gVwdMwY2T/2
	AKgm/AibzPlid0VCvk8Bm8hgJiAspnRRxZc2MTmrTZ2EfEzqwrs95oTKqRm9s5ru
	dy00l0Rgx+FDPvcCO3Sl8x728fpOfQdur53TxOZN9pqcDx1u8Dpve9KxC7UDoaco
	Kgl9Dm5llG8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30A3D2914;
	Tue, 15 Feb 2011 13:07:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BEF7290D; Tue, 15 Feb 2011
 13:07:41 -0500 (EST)
In-Reply-To: <201102151606.21040.johan@herland.net> (Johan Herland's message
 of "Tue\, 15 Feb 2011 16\:06\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 831356C4-392E-11E0-A390-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166861>

Johan Herland <johan@herland.net> writes:

> On Monday 14 February 2011, Junio C Hamano wrote:
> ...
> For the foreseeable future (i.e. long after v1.8.0 is out) we will still 
> have to understand and support the traditional "tags are implicitly 
> auto-followed" and "tags live in a single global namespace" concepts 
> (aka. (a) below). For new-style remotes I propose that all refspecs be 
> explicit, and that auto-follow is disabled (aka. (b) below).
>
> But if you try to specify a new-style remote with all tags in a single 
> global namespace, you will NOT get tag autofollowing (aka. (c) below)

Ok.

> (Note that if we cannot reliably detect the difference between old-style 
> (implicit) and new-style (explicit) remotes, we will likely have to add 
> a boolean flag, e.g. "remote.origin.implicitTagFollowing".)

Ok.

>> > ... However, what I've seen at $dayjob is
>> > that more inexperienced users will often push right after
>> > committing, and at that time they're still very much in the
>> > "working-on-one-branch" state of mind (as opposed to the
>> > "administering-multiple-branches" state of mind),...
>>
>> Then "current" mode is a good setting for them, I would presume.
>
> Arguably in some workflows, 'tracking' may be a more suitable default 
> (i.e. safer for newbies) than 'current', but in practice this shouldn't 
> matter much (local branch names usually correspond to remote branch 
> names).

Of course you are right.  The "this pulls from there, and pushes back
to the same place" model was what I had in mind when I wrote the patch; 
I just was confused between the "tracking" vs "current" labels.

> Offtopic PS: Given that we're leaning towards using 'tracking' to 
> describe the relationship between remote-tracking branches 
> (refs/remotes/*) and remote branches, and 'upstream' to describe the 
> relationship between a local branch and the remote branch it 
> follows/merges (on 'git pull'), wouldn't
>
>   push.default == "upstream"
>
> be more descriptive than
>
>   push.default == "tracking"

"Local Branch" and "Remote Tracking Branch", both of which physically
reside on the local end of the communication and are tied by their
"merge/rebase" relationship, are much more distinct than "Remote Branch"
and "Remote Tracking Branch" that are tied by their "fetch" relationship.
A remote tracking branch is a mere (time-lagged) mirror of the remote
branch it tracks, and mental distance between them is much smaller than
that of between a local branch and its @{upstream} that is a remote
tracking branch.  Conceptually the _true_ upstream of a local branch is
the remote branch from which its @{upstream} remote tracking branch copies
from.

So in that sense, I agree "pushing my change to the upstream" would match
the mental model of an end user somewhat better than "pushing my change
back to what I track".

Perhaps leave "tracking" as a deprecated synonym and add "upstream" as the
official name of the mode?
