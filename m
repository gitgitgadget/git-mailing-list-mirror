From: Junio C Hamano <gitster@pobox.com>
Subject: Re: serious problem with `git format-patch' & `git am'
Date: Fri, 27 Feb 2009 09:53:50 -0800
Message-ID: <7vr61jkbpt.fsf@gitster.siamese.dyndns.org>
References: <20090225.230352.177616203.wl@gnu.org>
 <6HVVE8kW9V0CsNfW21a_Tqpt2s-IrJbt2_qdAvQ8r1tetEhb6jr18g@cipher.nrlssc.navy.mil> <m3ljrsvg0e.fsf@localhost.localdomain> <7viqmwpr2x.fsf@gitster.siamese.dyndns.org> <zE3C931NyNaTaadZOgAI_rGf6gmkKr-3ZHRVXh87mHpCMs-0hfnhYg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Werner LEMBERG <wl@gnu.org>,
	git@vger.kernel.org, keithp@keithp.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 27 18:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld6w3-0002u7-VB
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 18:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbZB0RyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 12:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbZB0RyH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 12:54:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbZB0RyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 12:54:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 804522BDE;
	Fri, 27 Feb 2009 12:54:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 96EA52BDC; Fri,
 27 Feb 2009 12:53:52 -0500 (EST)
In-Reply-To: <zE3C931NyNaTaadZOgAI_rGf6gmkKr-3ZHRVXh87mHpCMs-0hfnhYg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri, 27 Feb 2009 09:47:49 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D98BE98-04F7-11DE-BCF3-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111689>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> What does this line do?
>
> git-am.sh line 375:
>
>     case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
>
> It appears to do nothing.  It has existed since the beginning of git-am.sh,
> and there has never been another reference to $keep_subject in this script.
> Is it possible that $keep_subject is supposed to be $keep?

I do not think it is doing anything, and I do not think it makes sense to
"fix" it to allow adding "[PATCH] " in front either.  I'd vote for
removing the entire thing.

The $keep_subject variable and "add [PATCH] only to later strip" logic was
borrowed from git-applymbox and git-applypatch pair, see 6bff6a6 (Teach
applymbox to keep the Subject: line., 2005-08-16) especially for the
change that affects tools/git-applypatch in the commit.  I think there was
a reason that -k refrained from adding the prefix in git-applypatch but
the option to git-am needed to add the prefix which seems inconsistent but
I do not recall the details.  Maybe the list archive may know.
