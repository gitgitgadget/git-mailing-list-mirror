From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 02 May 2010 16:07:27 -0700
Message-ID: <7vwrvlucls.fsf@alter.siamese.dyndns.org>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
 <20100502181854.GC16051@progeny.tock>
 <19421.54064.178345.489772@winooski.ccs.neu.edu>
 <20100502202943.GB16746@progeny.tock> <m31vdugj2t.fsf@localhost.localdomain>
 <19421.59529.849850.968565@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon May 03 01:07:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8iGJ-00051M-SP
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 01:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696Ab0EBXHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 19:07:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0EBXHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 19:07:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 748FCAF07A;
	Sun,  2 May 2010 19:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/PSALaKhzqnR5qpWytWth62a5k=; b=Mgwfpc
	WQYMVMc0WuqdVZ+rA1wEpiR/hVtfVjb2R2gD8K7JFn9ofWCeFvUdntDejRgr8PnV
	Ahf6IXWOpoGM9C73v45fqgxE7Q6MX9Y7RxKqQzgpmgbmUZqtAuAFmj83v5K5+OZt
	9GsErUaQlmxUwi+eareElkLIOmDxHCO4+3tS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NXWpY7yKOc+dODbeaiLRf6T2vijEBOlI
	6iCdcQLApgxP0InJE7Rb6d5sPzXYJn2kCdgjIX54i+14R9FOKersENkbtgA/Qp3E
	xl5+BOb80CbRgpDXSbB0XSzPoEVe5J6/R5gzXDBH8Lu74YXqJm8rgHDFYqWjLPUj
	X65CtlhSn2I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33CCBAF074;
	Sun,  2 May 2010 19:07:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62BC4AF06D; Sun,  2 May
 2010 19:07:29 -0400 (EDT)
In-Reply-To: <19421.59529.849850.968565@winooski.ccs.neu.edu> (Eli Barzilay's
 message of "Sun\, 2 May 2010 17\:03\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E08BC3C-563F-11DF-A265-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146205>

Eli Barzilay <eli@barzilay.org> writes:

> Good -- the first paragraph is what I thought it would do, the second
> makes it even better.  Perhaps it would be nice to show such manual
> reoslutions from one parent, but I think that that certainly qualifies
> as stuff that is much less interesting than work that was done to
> combine content inside a file, or one of those evil merges.

You need to be careful here.

If you see a conflicted hunk and the result ends up being the same from
one of the parents in that area, then the _result_ is trivial as far as
the merge (and hence --cc) is concerned, even though you may have spent
considerable braincycle to stare at the conflict to decide that taking a
change from one side is the right thing to do.

You keep saying "manual resolutions", but --cc doesn't have much to do
with the resolution being manual, nor if the initial mechanical merge
attempt left conflict markers.  You would need to redo the merge to find
that out, and it can be fairly cheaply done with a temporary index and an
empty temporary working tree elsewhere in the filesystem.
