From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: allow disabling expensive broken symlink checks
Date: Sun, 01 Feb 2009 19:03:47 -0800
Message-ID: <7vbptlo7zg.fsf@gitster.siamese.dyndns.org>
References: <200901311414.58205.markus.heidelberg@web.de>
 <20090201021844.GB18855@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 04:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTp8E-0007Eh-0T
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZBBDD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZBBDDz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:03:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZBBDDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:03:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 277E6940BC;
	Sun,  1 Feb 2009 22:03:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBF93940BB; Sun,
  1 Feb 2009 22:03:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FFFA31E-F0D6-11DD-884B-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108038>

Eric Wong <normalperson@yhbt.net> writes:

> Since dbc6c74d0858d77e61e092a48d467e725211f8e9, git-svn has had
> an expensive check for broken symlinks that exist in some
> repositories.  This leads to a heavy performance hit on
> repositories with many empty blobs that are not supposed to be
> symlinks.
>
> The workaround is enabled by default; and may be disabled via:
>
>   git config svn.brokenSymlinkWorkaround false
>
> Reported by Markus Heidelberg.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

How common is this breakage in people's subversion repositories that
dbc6c74d (git-svn: handle empty files marked as symlinks in SVN,
2009-01-11) works around?

What's the way to recover from a broken import, when the subversion
repository does have such a breakage, and the user used git-svn that
predates dbc6c74?  Is it very involved, and it is much better to have the
safety by default than to force everybody else who interacts with
non-broken subversion repository suffer from this performance penalty?

Because the fix (that is broken from the performance angle) is relatively
recent, I am wondering if it makes more sense to turn it off by default,
and allow people with such a broken history to optionally turn it on.
