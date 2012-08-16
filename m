From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 16 Aug 2012 16:27:31 -0700
Message-ID: <7vvcgixvrw.fsf@alter.siamese.dyndns.org>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
 <20120719115558.GC29774@sigill.intra.peff.net>
 <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com>
 <20120719213438.1cc7ca77a9cb3367a3be0539@domain007.com>
 <E94B0D74-2BB8-4B3E-BFB9-A2CFE9C2A7BB@gmail.com>
 <500904B0.9030309@viscovery.net>
 <068F71AC-DACD-4545-AB21-F911A934DA3E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29TZ-0001yo-OS
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab2HPX1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:27:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932527Ab2HPX1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:27:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5A48FF1;
	Thu, 16 Aug 2012 19:27:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YZkHaLNOVGhfAhBPm0Px1gCkqLQ=; b=S8owl9
	QYVlK1AiKYgpnnav+awh70lLTOBzfpYFUQgl6B3/2rqVNsQ81wGT74Z3Sg6W6dRe
	1NxTTl/tuMDXPBBEq+QB6qxXDLfmSORBFrjmVg+AP945MD2FcpvMqR0tAffsrunh
	RQON7EhuGzbUnx3c8/zZ8WpvwGSRaqnz8Hllc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b90qDn9M++Tn14tC6A+tCbG7yt2TLaHU
	oSk3PUDQtWW9Vz5oJEk1JINbZ0CFOTfgn2Xz3HrZsZgnNGz+W3CBhjP2hDl+15Av
	Q0R9ujYcnco++LnKPX2Csv/zOF/mbuMQkWrDN98vlCr3LFvF10FhihmzXUEvilHi
	/smqzbHi58k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8BB8FF0;
	Thu, 16 Aug 2012 19:27:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03F548FEF; Thu, 16 Aug 2012
 19:27:32 -0400 (EDT)
In-Reply-To: <068F71AC-DACD-4545-AB21-F911A934DA3E@gmail.com> (Alexey
 Muranov's message of "Fri, 20 Jul 2012 09:28:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F45A33E0-E7F9-11E1-97EE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexey Muranov <alexey.muranov@gmail.com> writes:

> On 20 Jul 2012, at 09:11, Johannes Sixt wrote:
> ...
>> Note the difference between "tracking branch" and "remote tracking
>> branch"! The "remote tracking branches" are the refs in the refs/remotes/
>> hierarchy. The "tracking branches" are your own local branches that you
>> have created with 'git branch topic thatremote/topic' (or perhaps 'git
>> checkout -b'). The paragraph talks about the latter.
>
> Hannes, thanks for the explanation, so i was confused once again.
>
> Various blog posts do not make the terminology clear, for example
> http://gitready.com/beginner/2009/03/09/remote-tracking-branches.html
> sais that there are only "two types of branches: local, and remote-tracking"...
> ...
> I think i was also misguided by Konstantin, who wrote that "you
> create a remote tracking branch when you intend to actually
> *develop* something on that branch" :).

I was re-reading the backlog today, and saw this topic fizzled out.

We obviously cannot fix third-party documentation that teach lies to
people, but is there something we can do to improve our own
documentation with respect to this confusion?

As I wrote it elsewhere, I try to avoid the bareword "tracking" in
general, and call the local branch you build on something like "your
'next' branch that forked from origin/next remote tracking branch"
myself.  Perhaps we can start from checking the documentation with
such a phrasing discipline?
