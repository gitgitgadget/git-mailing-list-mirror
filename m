From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git feature request: --amend older commit
Date: Sat, 18 Aug 2012 14:57:19 -0700
Message-ID: <7vr4r3rhhc.fsf@alter.siamese.dyndns.org>
References: <20120817154749.11762.qmail@science.horizon.com>
 <20120818014139.GA11100@gentoo.cinci.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "George Spelvin" <linux@horizon.com>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 23:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2r1N-00028O-Fi
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 23:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab2HRV5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 17:57:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490Ab2HRV5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 17:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C95248C2C;
	Sat, 18 Aug 2012 17:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uLKpYst3MpmIp1brAsMCtRlokIo=; b=qFD1rA
	Q4PdQ9GHWSnu7r2teau0FqMn+JNW81kZzH/3DmVjV3bW8boSvfPXyDgBG7EkrweP
	s5UXWrRPKEdEKpvZq+ZHcS4mTeDiwy/0NdnvSLPzjtpeo7yyK4yvOFtNkL6XUOrD
	osEW+E7Gxhjh6V1F4kq26+SNiF3VthQ2jD584=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bmOL0oAuqydnwsHOIiQKYCQ4elX1frLz
	M8CKTwYmOOI2CGHj6XHkx01Bmqo93/bYxW+ErRbf+ik3cZMas6s0fjE+Pn+ygnwP
	P9BTz8I704ZMOozjMmi7kMNRUI+oVr+BWBY/gBHLgPQPK/SSiUeM2jOEkp4/K2aM
	OXLzv6yHcuE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B723A8C2B;
	Sat, 18 Aug 2012 17:57:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28A728C2A; Sat, 18 Aug 2012
 17:57:21 -0400 (EDT)
In-Reply-To: <20120818014139.GA11100@gentoo.cinci.rr.com> (Jared Hance's
 message of "Fri, 17 Aug 2012 21:41:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF76D864-E97F-11E1-ABA1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203703>

Jared Hance <jaredhance@gmail.com> writes:

[administrivia: do not deflect a direct response to you away by
using mail-followup-to header, thanks]

> On Fri, Aug 17, 2012 at 11:47:49AM -0400, George Spelvin wrote:
>> Something like "git commit --fixup HEAD~3", where "git commit --fixup HEAD"
>> would be equivalent to "git commit --amend".

Yes, as an end-user facing command set, "git commit --amend HEAD~3" would
not be a bad addition.

> Such a simple task shouldn't require an interactive command.

In some cases, yes.  But the devil is in the details, and whoever
wants to work on must be prepared to see cases where the remainder
of the commits after rewriting an older commit will not replay
cleanly on top of it.  At that point, it won't be a simple task
anymore.  At least, it must make it clear what the user should do
when "commit --amend HEAD~3" (and subsequent rebuilding of HEAD~2,
HEAD~1 and HEAD on top of the amended result) needs a help from the
user to resolve conflicts.  It may be just the matter of mentioning
"from here on, follow the procedure you would use when you are
running 'rebase -i'", if the chosen mechanism to implement the
sequencing behind the "commit --amend HEAD~3" UI is "rebase -i".
