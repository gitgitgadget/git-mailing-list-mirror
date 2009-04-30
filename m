From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history
	of subtrees separately.
Date: Thu, 30 Apr 2009 10:58:53 +0200
Message-ID: <20090430085853.GA21880@pvv.org>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com> <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzS6j-0001NS-Ka
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbZD3I64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbZD3I6z
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:58:55 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:46077 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbZD3I6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:58:54 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LzS6Y-0000PH-0R; Thu, 30 Apr 2009 10:58:54 +0200
Content-Disposition: inline
In-Reply-To: <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118005>

On Wed, Apr 29, 2009 at 10:27:44PM -0400, Avery Pennarun wrote:
> Many projects are made of a combination of several subprojects/librar=
ies and
> some application-specific code. =A0In some cases, particularly when t=
he
> subprojects are all maintained independently, 'git submodule' is the =
best
> way to deal with this situation. =A0But if you frequently change the
> subprojects as part of developing your application, use multiple bran=
ches,
> and sometimes want to push your subproject changes upstream, the over=
head of
> manually managing submodules can be excessive.
>=20
> 'git subtree' provides an alternative mechanism, based around the
> 'git merge -s subtree' merge strategy. =A0Instead of tracking a submo=
dule
> separately, you merge its history into your main project, and occasio=
nally
> extract a new "virtual history" from your mainline that can be easily=
 merged
> back into the upstream project. =A0The virtual history can be increme=
ntally
> expanded as you make more changes to the superproject.

We have the exact same situation. I wanted to attack this from the
other end though, make submodules useable also in this scenario. The
subtree solution seems to be much easier to do in git, so maybe this
is a better approach!

Let's say you have three different projects that all use some shared
modules, The following operations should all be easy and fully
supported:

a) Modify project + some shared modules (in your project) with single c=
ommit
b) Push project + shared modules (for your project)
c) Push modifications to shared modules
d) Merge upstream version of shared modules into your project.

My quick analysis:
Your subtrees: a & b are easy, c & d are painful
Current submodules: a & b are painful, c & d are tolerable (somewhat te=
dious
with many shared modules, easy with one)

Subtrees also have the advantage that all the existing local tools
will be a lot more useful without any modifications (gitk, git gui,
git diff/patch/am/log/...)

To make subtrees realy useful, it would be good if you could improve c
& d, syncing with the shared modules!

- Finn Arne
