From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 23:28:41 -0800
Message-ID: <7vr4lfgfkm.fsf@alter.siamese.dyndns.org>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com> <20130120234205.GC3474@elie.Belkin>
 <20130121010643.GA25437@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Jan 21 08:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxBoY-0002ST-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 08:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087Ab3AUH2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 02:28:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874Ab3AUH2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 02:28:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F45B8639;
	Mon, 21 Jan 2013 02:28:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNZDtEKN73ertXkRzWnsVOEwQQE=; b=L8wF0q
	YyUkw1yAunWK2XWHKk+r+1R7/3evupECBSn+taBFPOVneLzHGAnmtTJobE7VpbuZ
	eP7UgkUsHdweK72BmRXkZkmKWmkSb68yIaR/D5Y4Ps1LJxBNRZDOwvoNSBVUQPRp
	zpSV0JZzjTr4GG6dyfZoYEc7uRjbNWIrQDpNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZI61+I3P5QRQCH2VBaMdvcLeTTOVEFt
	FTaAsKw5G5OBKNIRrAIjzh0IQhgdaE0xJB3OH9JPttgkl1eWykyPs6seUh7DTggO
	HEz1RTilNPZmFuspwtxgD+c+G9AdOdsYIqP3Czk6GJ13JgxneEToJwdbU5NIgNra
	ejNEwHWhDm0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9360A8636;
	Mon, 21 Jan 2013 02:28:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ADDB8633; Mon, 21 Jan 2013
 02:28:42 -0500 (EST)
In-Reply-To: <20130121010643.GA25437@thyrsus.com> (Eric S. Raymond's message
 of "Sun, 20 Jan 2013 20:06:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F160432-639C-11E2-8DF3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214088>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Jonathan Nieder <jrnieder@gmail.com>:
>> Junio proposed a transition strategy, but I don't think it's fair to
>> say he has chosen it without discussion or is imposing it on you.
>
> I have said everything I could about the bad effects of encouraging
> people to continue to use cvsps-2.x, it didn't budge Junio an
> inch, and I'm tired of fighting about it.  Quibbling about the 
> semantics of 'impose' will neither change these facts nor make
> me any less frustrated with the outcome.

I am not quite sure if I follow you.

The primary thing I am aiming for is to rob an excuse from people
and from their distros to block newer Git and cvsps3.  I've already
cited a few URLs where we can see cvsps3 is blocked with an excuse
"it does not work with Git yet".

If we ship new version of Git that only works with cvsps3, we will
end up giving an excuse "this version of Git no longer works with
cvsps2" for distro packagers whose cvsps distro maintainer is slower
than others to pick up cvsps3 for whatever reason.

You may care deeply about CVS conversion part of the system, but you
need to realize that majority of Git users do not care a whit about
cvsimport. I do not want to give those distros that ship stale cvsps
an excuse to pin their users at an old version of Git.

By shipping both cvsimport-2 and cvsimport-3, we will rob from these
distros the excuse to block shipping the version of Git that does
support cvsps3 output.  They can choose to update cvsps to 3.x and
disable cvsimport-2 altogether at the build time, or if their cvsps
distro maintainer is slow, they can ship both cvsimport-2 and -3 and
let the user install cvsps 3.x under their $HOME if they want.

If you want to abandon cvsps2 users, that is perfectly fine by me.
As long as cvsps3 and cvsimport-3 combo works, Git before this
series will have a _working_ cvsimport as far as I am concerned.

In other words, I am fine to add a paragraph at the top of the
Release Notes saying that

 (1) cvsps2 is no longer maintained;

 (2) using cvsps3 is the future direction for the users; and

 (3) if their distro is slow to adopt cvsps3, however, cvsimport can
     still be used with cvsps2, but bugs in it or cvsps2 are not
     expected to be fixed.

to nudge distros to adopt cvsps3.

> I will continue to do what I can to make cvsps-3.x and cvs-fast-export as
> bug-free as possible, given the innate perverseness of CVS.  They
> won't be perfect; they will be *better*.

Yes, that is what we want.
