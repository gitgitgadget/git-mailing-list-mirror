From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 15:13:38 +0100
Message-ID: <20091111151338.3df1faa7@perceptron>
References: <1257945756.26362.79.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:13:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8DxK-0006gL-5l
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 15:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbZKKONl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 09:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZKKONk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 09:13:40 -0500
Received: from zoidberg.org ([88.198.6.61]:45254 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756197AbZKKONj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 09:13:39 -0500
Received: from perceptron (xdsl-78-35-135-64.netcologne.de [::ffff:78.35.135.64])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Wed, 11 Nov 2009 15:13:43 +0100
  id 004D0121.4AFAC697.00000535
In-Reply-To: <1257945756.26362.79.camel@heerbeest>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132657>

Hi,

> git pull -r*) URL says: [...]
>         branch.master.remote = <nickname>
> and after cut-and-pasting that into .git/config, replacing
> <foo> with values, I get [...]
>     fatal: bad config file line 17 in .git/config
> where line 17 is [without any indentation]
>     branch.master.remote = eddy

The confusion is that while you can set values with this syntax if
you're using git config (git config branch.master.remote <some value>),
they're written differently in actual config files:

  [branch "master"]
  remote = <nickname>
  merge = <remote-ref>
  
  [remote "<nickname>"]
  url = <url>
  fetch = <refspec>

I can't think of a message of comparable length that would make this
clearer, though.

> Jan.  -- who just finds out the uninstall target is missing?!?
> 	 See attached.

I have no comments about the patch contents themselves, but please read
Documentation/SubmittingPatches. Most importantly, patches are
usually sent inline here, and without a signoff line they can't be
accepted for inclusion in the official repository.

> *) I've been wondering why GIT lacks a "update", ie
>    pull-without-merge command.  You almost never want
>    to git pull /without/ -r?

-r stands for "rebase", i.e. it makes git pull use rebase instead of
merge. Rebase has certain problematic implications for decentralized
development, which is why it should only really be used in specific
circumstances (for rebasing commits that haven't been published in any
way yet).

"You" may almost never want to use git pull without rebase, but "many
others" do, and very often. Personally, I donn't recall a single
occasion where I have used git pull --rebase (not counting git-svn
stuff).

Anyway, look at config options branch.autosetuprebase and
branch.<nickname>.rebase to see how you can make pull use rebase by
default.

-Jan
