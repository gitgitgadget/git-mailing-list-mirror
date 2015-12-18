From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-svn: add support for prefixed globs in config
Date: Fri, 18 Dec 2015 00:42:47 +0000
Message-ID: <20151218004247.GA2203@dcvr.yhbt.net>
References: <1450387227-7952-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 01:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9j8G-0003xq-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 01:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933586AbbLRAms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 19:42:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54049 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454AbbLRAms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 19:42:48 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E79205DE;
	Fri, 18 Dec 2015 00:42:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1450387227-7952-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282689>

Victor Leschuk <vleschuk@gmail.com> wrote:
> --- /dev/null
> +++ b/t/t9168-git-svn-prefixed-glob.sh
> @@ -0,0 +1,136 @@
> +#!/bin/sh
> +test_description='git svn globbing refspecs with prefixed globs'
> +. ./lib-git-svn.sh
> +
> +cat >expect.end <<EOF
> +the end
> +hi
> +start a new branch
> +initial
> +EOF
> +
> +test_expect_success 'test refspec prefixed globbing' '

<snip>

> +echo try to try >expect.two &&
> +echo nothing to see here >>expect.two &&
> +cat expect.end >>expect.two

What happens when the cat fails?

Should probably be folded into the subsequent test case.
(I used to write tests with "set -e", but it's not descriptive
as far as failure goes).

> +test_expect_success 'test left-hand-side only prefixed globbing' '
> +	git config --add svn-remote.two.url "$svnrepo" &&


> +echo "Only one set of wildcard directories" \
> +     "(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'" >expect.four &&
> +echo "" >>expect.four

Same with echo...

> +test_expect_success 'test disallow prefixed multi-globs' '
