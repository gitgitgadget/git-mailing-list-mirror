From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 10:40:18 +0100
Message-ID: <568E3282.1060508@drmicha.warpmail.net>
References: <568E10A7.5050606@drmicha.warpmail.net>
 <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:40:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH73b-0008FH-95
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 10:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbcAGJk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 04:40:28 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37368 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbcAGJkU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 04:40:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id B015D21578
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 04:40:19 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 07 Jan 2016 04:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Kq8rdvDRoPPY2Axv6SGNMI4c7ws=; b=RIklwN
	zpb9imL5C5v+wVkZx4JKdAFnA6HOJd4kP3wuapsfoabnbYwij8lACRFPM8Q5MODM
	6vUk03zsU2qtrXcF9xPCdujfMgSo9G705McsRsagmhZ8IusCV+KKHlb7QoyQbswg
	lS5VrxoMxm45i+JKUoJyddgGEktAzwa4/To58=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Kq8rdvDRoPPY2Ax
	v6SGNMI4c7ws=; b=BgiTtr+hJ/V50RK9s8INoSrU21EPH5aaCwrXFnO2Zi0jUKA
	s3Y0HMzETyRIvo38bs3GFSe9c2ty896axXap36BieoyaMePdzSvvaL87fTZQzLor
	nEjJAEWZV12JCcXitb/cQojaH7NFT/y7oUqXQ2fbIvnGkN3HlNIFz62/z8KI=
X-Sasl-enc: bAcfHoIqQGV8LrwFblJfk99uD+5FoaYNQmETpYlBBbtA 1452159619
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3C8D2C016DA;
	Thu,  7 Jan 2016 04:40:19 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283474>

Duy Nguyen venit, vidit, dixit 07.01.2016 10:26:
> On Thu, Jan 7, 2016 at 2:15 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Hi there,
>>
>> sorry I can't dig deeper now, but the worktree code from next seems =
to
>> get confused now as soon as you cd to a subdir of a worktree (other =
than
>> the main worktree) and use an alias:
>>
>> git help ss
>> `git ss' is aliased to `status -s -b'
>> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git status -s -b
>> ## exam
>> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git ss
>> fatal: internal error: work tree has already been set
>=20
> You forgot to mention what version you used. But it's probably relate=
d
> to d95138e (setup: set env $GIT_WORK_TREE when work tree is set, like
> $GIT_DIR - 2015-06-26). This commit fixed your problem (and was
> released) but it introduced some other regressions so it's been
> reverted in 'next'. 'pu' has a re-fix on top of the revert.

Well, I mentioned "from next", which I admit is not super-precise (it's
next not older than a day or two, plus some local additions). In fact i=
t is:

ef7b32d (Sync with 2.7, 2016-01-04)

which "has" d95138e (as per git branch contains) but also df1e6ea87
which reverts it. (I guess --really-contains would be neat but difficul=
t.)

So while I didn't notice the problems that lead to the revert, I notice=
d
the problems the revert created... Early adopters' luck.

As for the fix on pu, do you mean that one:
ac78663 (run-command: don't warn on SIGPIPE deaths, 2015-12-29)

I'll give it a shot then.

Michael
