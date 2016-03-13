From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git-secret - store your private data inside a repository
Date: Sun, 13 Mar 2016 23:52:50 +0000
Message-ID: <robbat2-20160313T211905-684299027Z@orbis-terrarum.net>
References: <CAO_bL1xQ0C+HYdZQVvyHx3ByPaaJTgpQYhY7h9f76eQXHKZ_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: =?utf-8?B?0J3QuNC60LjRgtCwINCh0L7QsdC+0LvQtdCy?= 
	<n.a.sobolev@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 14 00:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afFof-0000xh-94
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 00:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbcCMXwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 19:52:54 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:60644 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294AbcCMXwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 19:52:53 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 2C38734094F
	for <git@vger.kernel.org>; Sun, 13 Mar 2016 23:52:51 +0000 (UTC)
Received: (qmail 14194 invoked by uid 10000); 13 Mar 2016 23:52:50 -0000
Content-Disposition: inline
In-Reply-To: <CAO_bL1xQ0C+HYdZQVvyHx3ByPaaJTgpQYhY7h9f76eQXHKZ_SQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288762>

Have you seen the much older pwstore tool?
https://github.com/formorer/pwstore

It does have some notable features missing from git-secret and similar
tools to this day.
- Whitelist of trusted keys to detect addition of unexpected keys.
- Specify what users/groups have access to any given file (via a header
  in each file, which implies that the file must be plaintext).

I've wondered if storing metadata about the objects in notes might
improve matters: 
- a clearsigned block with verifiable readable data (eg who in a team
  can access)
- an encrypted block with the inner key (nice side effect that this
  separates versioning of the wrapped inner key from the versioning of
  the object).

This also a nice property that when you revoke/remove an outer (user)
key, can know implicitly the old secrets they had access to (which
should probably be rotated, as you don't know if they have a copy of
them outside of the system).

Yes, I'm aware of other system's like Hashicorp's Vault, but do
appreciate the simplicity of git-secret, pass [1], pwstore [2] and other
simpler tools.

[1] https://www.passwordstore.org/
[2] https://github.com/formorer/pwstore
    It's at least as old as the Git history indicates, possibly
	older, I don't know if the Git history included a full conversion of
	SVN history.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
