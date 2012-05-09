From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 10/19] completion: use bash builtins to search for
	repository
Date: Thu, 10 May 2012 00:34:44 +0200
Message-ID: <20120509223444.GH6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-11-git-send-email-szeder@ira.uka.de>
	<7v62c5rv1q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 00:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSFTg-0002g4-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 00:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab2EIWfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 18:35:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:62741 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab2EIWfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 18:35:19 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MFwt0-1SOLzx1ohC-00FD7I; Thu, 10 May 2012 00:34:43 +0200
Content-Disposition: inline
In-Reply-To: <7v62c5rv1q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:m7ffpHmmY0UnBTm/SQl9x48YhZRHyL87Se0Nvpbdq1t
 euAPQSz6U9ZSduN2wZE5iiuu2SFINELahgW+Ftfj+Ef/YriBpX
 ps8QdSxtwCGOceAwIcdtZv9NaFH4g2S+UmfZINCtDWYdYX7ikG
 wgGydo4EiGPxGJHHwl7MwN8tLHKChXFpXyoU/9hSWubM8bfg4M
 Dk52BS2pqpBzRPuyzPzH7VixdOIxWZJbFBU1Qz3UAS/DfjrEcm
 a0S0hyn0Om8ytDCxYEgqF8feiLPPNFozIn5rmgxUF71R5Q8Xlc
 ub5itSXncaWLfoMmAHY3Uksv5cA7x/o/im/vTdGdQA0mo0K6rj
 H2dTvaqfAzJrMzKFW06I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197526>

On Wed, May 09, 2012 at 12:52:49PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > ..., this
> > search is not that thorough either, as it doesn't check whether the
> > found '.git' directory or the directory pointed to by a gitfile is =
a
> > valid '.git' repository.
> > ...
> > Of course, stat()ing in C is much faster than in bash, so there is =
a
> > point when bash builtins will be slower than '$(git rev-parse
> > --git-dir)' despite all the fork()s+exec() overhead.
>=20
> I'd feel safer if this new logic were an opt-in feature, at least in =
the
> beginning, with these pros-and-cons summarized near the beginning of =
the
> file to let the users choose if they want to use "exactly matches the
> command the prompt script is trying to help" version (i.e. rev-parse)=
 vs
> "matches most of the time and faster under these conditions" version
> (i.e. the new logic).

I'm not sure what you mean by opt-in.  It's already opt-in in the
sense that users have to set $GIT_DISCOVERY_ACROSS_FILESYSTEM to
enable this logic.  Or do you mean that
$GIT_DISCOVERY_ACROSS_FILESYSTEM should not implicitly enable this
logic, but it should be controlled by a new dedicated variable?
