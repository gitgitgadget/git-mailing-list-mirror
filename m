From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 13:40:09 +0100
Message-ID: <5655AC29.20801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ZMu-0002tG-F8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbbKYMkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:40:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46312 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752568AbbKYMkL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2015 07:40:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5474E2081D
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 07:40:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 25 Nov 2015 07:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=EN2
	3DrfWGxRHgYZ8jCaiMVS5ur0=; b=PgJ712TMWy6riLPVUvUVxUZmA9bt8FJcgFC
	92rrmOvjOAXjNil38KhMqt1KNA58yneYfetMOjAcFqvMYidOFr2D/XgQhhp0fFGj
	Sl4x3wV6AaKH0gpys1SJhPVDW6dtDrjhylYDoaK4sETN44xyIWVT/FOVkSn2PJ7U
	b/2DDzI4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=EN23DrfWGxRHgYZ8jCaiMVS5ur0=; b=O3Vlb
	nbgsi03EOFTnPTMmw55ByvFy81O8JJrBYh4yzducNzo/3248RlS9zwzWK17uQT0P
	arJ0oTD3NpiejMjmLxGftN5vlTFlI+pF0cs/d2rE5kHFPWMc16By8161xA9o5M2g
	CtT9kCaRgTjYgQ78LV/jI97BClO/SWv5oGVnsk=
X-Sasl-enc: WMEiQ+QDzr9nfbQOdNHS6SwFWRg5bYXc4H8GjUTeo/Hx 1448455210
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id EAA05C016DB
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 07:40:09 -0500 (EST)
X-Mozilla-News-Host: news://news.gmane.org:119
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281709>

Hi there,

I'm wondering how much it would take to enable worktree specific sparse
checkouts. From a superfluous look:

- $GIT_DIR/info/sparse_checkout needs to be worktree specific
- We don't have much tooling around sparse to speak of at all.

The endgoal would be to have something like

git checkout [--sparse <pattern>]...

which sets up the sparse_checkout file and "git worktree" to pass any
--sparse option on to "git checkout".

While in an ideal world we all have micro repos, in the real world we
often have larger repos with mostly independent subdirs. For a quick fix
on a side branch in a subdir, a new sparse worktree would be an ideal
lean solution.

As it is, "git stash save && git checkout" is leaner but interrupts the
workflow more, and a local "git clone" with links and alternates is
leaner, too, but conceptually overkill if you want to work quickly on an
existing side branch.

Cheers,
Michael
