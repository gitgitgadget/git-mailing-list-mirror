From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: gitignore design
Date: Sat, 30 Jul 2011 18:01:24 +0200
Message-ID: <20110730160124.GA7545@toss.lan>
References: <1311934832699-6632987.post@n2.nabble.com>
 <m3pqktql6s.fsf@localhost.localdomain>
 <4E32B637.1030201@viscovery.net>
 <201107292339.51753.jnareb@gmail.com>
 <CACsJy8CurvKd_=hdRQyjjzWLvKF0jbWOQhbLSsmk1BqB_dK3og@mail.gmail.com>
 <CAA01Cspv4yShnKBKFFrf8K1tbARahyYf7KZPqbiDFrvFsX9hwg@mail.gmail.com>
 <CACsJy8DcFJUK91cJm3EmHn8BMyA78gzu_pMtqJ0z9oO1RF+suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Ferry Huberts <mailings@hupie.com>
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 18:02:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnBzm-0001b7-LS
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 18:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab1G3QBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 12:01:35 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:56748 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751118Ab1G3QBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 12:01:34 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id B35322C400C;
	Sat, 30 Jul 2011 18:01:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACsJy8DcFJUK91cJm3EmHn8BMyA78gzu_pMtqJ0z9oO1RF+suw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178208>

On Sat, Jul 30, 2011 at 08:22:14PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, Jul 30, 2011 at 1:45 PM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
> > I was using assume-unchanged for some time but stopped after some
> > weird problems during updates. I'm not sure if this was caused by this
> > or by sparse-checkout (and I use git-svn too). Anyway, after stopping
> > using assume-unchanged and sparse-checkout mysterious problems
> > disappeared.
> 
> I'm interested in the problems you had (even better if you found a way
> to reproduce).

Hi, Same here.

Concerning the OP's question, I've also written this FAQ entry,
which explains two methods to deal with the problem:

 https://git.wiki.kernel.org/index.php/GitFaq#How_do_I_tell_git_to_ignore_tracked_files.3F

It also mentions assume-unchanged and sparse checkout as a third
option, but it warns that these features were not designed for that
purpose. Apart from the bug fixed in aecda37 I have never had a
problem with them myself. But it's not a particularly convenient
solution in any case.

As far as a possible 'exclude untracked' mechanism is concerned, I
am not sure that is a good thing to have. It's like saying "I want
to track changes to those files, but I do not want to commit
changes by default (e.g. commit -a, add -u etc.)." That may sound
reasonable at first, but I think the desire to ignore changes to
tracked files usually indicates a design problem. And it can almost
always be solved using either option (a) or (b) from the FAQ entry
above.

On the other hand, such a feature bears some risk.  The repository
is not guaranteed to be in a certain state, even if git status is
empty.  You could still have ignored changes somewhere. And it's
all too easy to forget about those. I know I always forget about
the rules I have in my .git/info/exclude.

Maybe I should not be trying to protect users from shooting
themselves in the foot. But I would be very curious to hear from
the OP why options (a) or (b) above are not a solution for his use
case, before adding yet another "dangerous" mechanism to git.

Clemens
