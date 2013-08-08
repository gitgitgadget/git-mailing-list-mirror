From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message (gitml: message 5 of 20) (gitml: message 6 of 20)
Date: Thu, 8 Aug 2013 17:28:27 +0200
Message-ID: <87txj0i4mc.fsf@inf.ethz.ch>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
	<87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
	<9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost>
	<vpqli4cfhhe.fsf@anie.imag.fr>
	<813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost>
	<vpqfvukfgr5.fsf@anie.imag.fr>
	<edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
	<87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Stefan Beller" <stefanbeller@googlemail.com>
To: Ben Tebulin <tebulin@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 17:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7S8k-0006sq-V9
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 17:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965835Ab3HHP2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 11:28:35 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:31286 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965297Ab3HHP2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 11:28:34 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug
 2013 17:28:24 +0200
Received: from hexa.ethz.ch (46.126.8.85) by CAS21.d.ethz.ch (172.31.51.111)
 with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug 2013 17:28:31
 +0200
In-Reply-To: <5203B100.30008@gmail.com> (Ben Tebulin's message of "Thu, 08 Aug
	2013 16:53:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231897>

Ben Tebulin <tebulin@googlemail.com> writes:

> Am 08.08.2013 16:20, schrieb Thomas Rast - trast@inf.ethz.ch:
>> Can you try to reproduce with a version older than v1.8.3?
>> E.g. v1.8.2.3.
>> I'm asking because the above points at packed_object_info(), which I
>> recently rewrote to be nonrecursive.
>
> It seems to run 'much better' 
>   v1.8.2.3 : 3/10 runs do fail
>   fb56570  : 9/10 runs do fail

The good news is that this shifts the blame away from my commit ;-) as
the problem clearly existed even before that.

The bad news, of course, is that this is another hunch that turned out
to be wrong.  I'm running out of ideas.

> They always fail on a big blob (39MB) as I wrote in my first e-mail:
>
> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
> error: sha1 mismatch 49cdd0b21a351f3366008615d2cf8d03ca943978
> fatal: bad object 49cdd0b21a351f3366008615d2cf8d03ca943978
> 0
> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a351f3366008615d2cf8d03ca943978 | wc -c
> 39517156

Hrmm.  I wonder about the significance of those 39MB.  What is your
core.packedGitWindowSize?  (Judging from the pastes you seem to be on
64bit, so the default would be 1GB.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
