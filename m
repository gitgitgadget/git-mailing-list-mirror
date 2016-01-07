From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 10:49:14 +0100
Message-ID: <568E349A.30902@drmicha.warpmail.net>
References: <568E10A7.5050606@drmicha.warpmail.net>
 <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
 <568E3282.1060508@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:49:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH7C6-0006nq-5i
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 10:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbcAGJtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 04:49:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50351 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751775AbcAGJtQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 04:49:16 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 7829F2113B
	for <git@vger.kernel.org>; Thu,  7 Jan 2016 04:49:15 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 07 Jan 2016 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4jpd1vPTMriBR+2ZWmGHPKKCjXw=; b=CLPitU
	+sC57U2a5BmBgbzZQE9Uf/vczDYeUoNLaW9JwAe0WZ6t2M10niohL0gGzr+3HBY3
	BeZ9ZEOBfgvSOqkFM+2WPj+32KLFov/CcIX5hwY9tnPEJAEVTQlJDMdUKYNuLiFF
	ONhau+gD5v8QNotoBoEmJWMnaWuA5EQJ75A7k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4jpd1vPTMriBR+2
	ZWmGHPKKCjXw=; b=K0+wGQmaPFmaAvEVUagO6ys6KQg4c+zkib1hevM/cgwLTL0
	xXsMv09fwChyHlj1Sftq8uM+UWKrKQp643u2J47UEO/cGRAaBGPIm27CIU4AIVq4
	fQGl5l3wDMfxfCPoLTRpTwZQnAMBuNMNFjsjRyXqlrYamnVyz8iOyv4CvF2c=
X-Sasl-enc: Xcjm18LvQAVV4ANV14c02v5d0daosDKPEHgW2rykfegI 1452160155
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 021E4680194;
	Thu,  7 Jan 2016 04:49:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <568E3282.1060508@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283476>

Michael J Gruber venit, vidit, dixit 07.01.2016 10:40:
> Duy Nguyen venit, vidit, dixit 07.01.2016 10:26:
>> On Thu, Jan 7, 2016 at 2:15 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Hi there,
>>>
>>> sorry I can't dig deeper now, but the worktree code from next seems=
 to
>>> get confused now as soon as you cd to a subdir of a worktree (other=
 than
>>> the main worktree) and use an alias:
>>>
>>> git help ss
>>> `git ss' is aliased to `status -s -b'
>>> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git status -s -b
>>> ## exam
>>> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git ss
>>> fatal: internal error: work tree has already been set
>>
>> You forgot to mention what version you used. But it's probably relat=
ed
>> to d95138e (setup: set env $GIT_WORK_TREE when work tree is set, lik=
e
>> $GIT_DIR - 2015-06-26). This commit fixed your problem (and was
>> released) but it introduced some other regressions so it's been
>> reverted in 'next'. 'pu' has a re-fix on top of the revert.
>=20
> Well, I mentioned "from next", which I admit is not super-precise (it=
's
> next not older than a day or two, plus some local additions). In fact=
 it is:
>=20
> ef7b32d (Sync with 2.7, 2016-01-04)
>=20
> which "has" d95138e (as per git branch contains) but also df1e6ea87
> which reverts it. (I guess --really-contains would be neat but diffic=
ult.)
>=20
> So while I didn't notice the problems that lead to the revert, I noti=
ced
> the problems the revert created... Early adopters' luck.
>=20
> As for the fix on pu, do you mean that one:
> ac78663 (run-command: don't warn on SIGPIPE deaths, 2015-12-29)
>=20
> I'll give it a shot then.
>=20
> Michael

Meanwhile you had answered my question before I even asked it. Great
user support over here :)

And hooray, merging ac78663 saves my problem, thanks!

Since I didn't notice the problems that the earlier fix caused I can't
say whether the newer fix avoids them.

Michael
