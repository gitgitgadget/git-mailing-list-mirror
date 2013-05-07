From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Tue, 07 May 2013 08:15:43 -0700
Message-ID: <7vr4hilt28.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
	<5188B165.3050709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 17:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjcO-00038W-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab3EGPPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:15:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab3EGPPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:15:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14B51CBEF;
	Tue,  7 May 2013 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HKOmlA7ria7S1tL1eoKvWZ8+ko4=; b=CanqJs
	tDM53W1C693mDUjoKs/sal5m+N30WQszWOmzJMFqv3Ang1bI0El9quBNUp02Pvnd
	aLhg0qvhAluUaov68dBQJFRScxipaln3MsKF4Ks8cAREywxIF1f6SjIM0qq0gYYp
	H92FuYU8sipL1N7BXpTsbdL8GstEmYXXermig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vlP4ecvdxXWMoXVEyCtxmDEIQQlAY8eM
	9VjwMxSFYkfsi2TJTpN2zQ3UBb/at7szqZwkDXpytAxvFZfN+bRkb10J+jBEErUT
	XpgLk9wSY4K3n9/OKtF+GaHcwPVWiRFoOlitm33qGC50+pxQRCjZKSsMX5WCWoFy
	wggW+YegDpk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8C601CBEE;
	Tue,  7 May 2013 15:15:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C09DE1CBED;
	Tue,  7 May 2013 15:15:45 +0000 (UTC)
In-Reply-To: <5188B165.3050709@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 07 May 2013 09:46:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC90E52-B728-11E2-B440-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223577>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> My understanding is that we are waiting on two things:
>
> 1. Consensus from the community.  I would characterize the feedback on
> the mailing list as limited in quantity but strongly positive [1-4] and
> I think that most/all of the wishes for post-receive-email features that
> were originally omitted from git-multimail have been implemented in the
> current version.  Some of the mailing list feedback was about earlier
> versions.  Do you want people to give feedback specifically about the
> current version?
>
> 2. For me to figure out what part of the git-multimail history I think
> should be included in the Git project, do any necessary repository
> rewriting, and submit a pull request to you.

Both are intertwined.

I was looking at the history of your project at GitHub.  I got an
impression that it is better to evolve as a standalone project with
its own rich history, and the longer I looked at it, the more
convinced I got that I shouldn't pull history from you.

As "batteries included" service for the end users, it may be
convenient to have a copy of a stable release of the script in the
contrib/ area, but I do not think if it is the best for the script
to further develop it in my tree.  I'd be just an unnecessary
bottleneck.

I have a mildly strong suspicion that a better approach might be to:

 - Copy the current stable snapshot to the contrib/ area, but mark
   it clearly that the copy is merely for convenience, meant for end
   users who choose not to pull from your authoritative GitHub
   repository, and the real development happens elsewhere;

 - Keep the development at your GitHub repository, with you as the
   project lead.  People who are interested in evolving it gather
   and work there; and

 - Update what is in contrib/ in my tree with a stable snapshot,
   every once in a while (close to the release points of Git project
   or of MultiMail project).
