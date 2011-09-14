From: Johan Herland <johanh@opera.com>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 14:28:52 +0200
Organization: Opera Software ASA
Message-ID: <201109141428.53163.johanh@opera.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <4E7085E6.3060509@alum.mit.edu> <vpqfwjzxu6i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 14:41:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3omm-0000br-GR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 14:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab1INMlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 08:41:44 -0400
Received: from smtp.opera.com ([213.236.208.81]:46705 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab1INMln (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 08:41:43 -0400
X-Greylist: delayed 756 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Sep 2011 08:41:43 EDT
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p8ECSrcH003243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Sep 2011 12:28:53 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <vpqfwjzxu6i.fsf@bauges.imag.fr>
X-Face: yd/RLXZ@3u;&:C1I$AEH?\d18w+mK:]sZDl52'=Pa{>%,97])P+G2Z<An\_s-+5]S5USYj
	ZV9-'+"}0!v$zY.4.~5V*'(.9b`>|'YyP1]1%Ge/"bi}Z9PaqbK.9K"yXj#v-CuX,i&.8]
	)yTm>+T04D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181355>

On Wednesday 14. September 2011, Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> > I wish that one could annotate a branch (e.g., at creation) and
> > have the annotation follow the branch around.  This would be a
> > useful place to record *why* you created the branch, your plans
> > for it, etc.  The annotation should be modifiable, because often a
> > branch evolves in unforeseen ways during its lifetime.  Anybody
> > could read the annotation to get a quick idea of what kind of work
> > is in progress.
> 
> Would the notes mechanism be able to annotate ref names instead of
> commit sha1?

This has been discussed on the list before, but I'm too lazy to dig up a 
reference, so:

The notes mechanism can in principle annotate anything that has a SHA1 
sum. The notes tree is really only a key->value mapping using SHA1s as 
keys and Git objects (typically blobs) as values.

HOWEVER, "git notes prune" will assume that the SHA1 keys are supposed 
to identify existing git objects, and will delete any note whose SHA1 
key does not identify a reachable git object.

Hence, if you promise to never run "git notes prune" on 
refs/notes/branch-descriptions, you could use that ref to store your 
branch descriptions keyed by the SHA1 of your branch name.

The obvious deficiency with this scheme is that if your branch name is 
different in some repos, the branch description will be lost in those 
repos unless you rewrite the refs/notes/branch-descriptions notes tree 
accordingly.


...Johan

-- 
Johan Herland, <johanh@opera.com>
Core Developer, Opera Software ASA
