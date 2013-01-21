From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 21 Jan 2013 15:18:02 -0800
Message-ID: <7vbocif7md.fsf@alter.siamese.dyndns.org>
References: <50FB1196.2090309@gmail.com> <20130119214921.GE4009@elie.Belkin>
 <vpq622s9jk1.fsf@grenoble-inp.fr> <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
 <CAA01Csrv26WrrJDAo-1cr+rW6rYFGQZpYgtafEh=Wgtzswdv_g@mail.gmail.com>
 <7v622qhouc.fsf@alter.siamese.dyndns.org>
 <7v1udegy2o.fsf@alter.siamese.dyndns.org> <vpqhamapal1.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:18:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxQdJ-0002TB-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 00:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3AUXSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 18:18:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab3AUXSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 18:18:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BEE6B03A;
	Mon, 21 Jan 2013 18:18:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkO6W1PIGpLmo0GqJhOL9qA+yWo=; b=QwB73O
	5UlanoLHMz5dSIgHLQxRHi7php3p8m/S8v+hspxeCrnS/h7VuDBZGJ24WhSk2QC3
	opcgphHOiEgpPOJC8z+zGIWGwR2Upm06RhD1OLfDCrxV9Jr4nk79hNg6IKUmPsnP
	T0Eb1rv76FCTNXluttmjC/cq1Tqw6WwWOIlIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FaATflP7lOTRNLTziLhjUBZRKmXaIRr0
	xn/KeKG4bKZmy4YWSyhi6xDReMLxHcdFGNvdfGll8OO/wXJYQeCS0OiMOiWr8qAE
	e37w8lxpIP1CziR5BI/4E6CisxdfQDJMLufV8gWd94hwAnYHEZ/k0ax+hTR8PiuZ
	LUqrElE7mDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90498B038;
	Mon, 21 Jan 2013 18:18:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17B27B032; Mon, 21 Jan 2013
 18:18:05 -0500 (EST)
In-Reply-To: <vpqhamapal1.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Mon, 21 Jan 2013 21:03:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF1FC510-6420-11E2-B4CA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214174>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But v1.5.2.5~1 (git-add -u paths... now works from subdirectory,
>> 2007-08-16) changed the semantics to limit the operation to the
>> working tree.
>
> Not really. It fixed "git add -u path", not plain "git add -u". A quick
> test checking out and compiling v1.5.2.5~1^ shows that "git add -u ."
> from a subdirectory was adding everything from the root.
>
> My interpretation is that v1.5.2.5~1 fixed an actual bug, without
> thinking about what would happen when "git add -u" was called without
> path, so the behavior is "what happens to be the most natural to
> implement".

I guess at this point it does not matter that much if that was an
unintended consequence of a buggy fix, or a new behaviour by design.
We initially were tree-wide but later limited the operation to the
current directory.

I think your "Check 'git diff' then run 'git add -u'" example may be
a good enough argument that it is a good idea to restore the
originally intended "tree-wide" behaviour in any case.
