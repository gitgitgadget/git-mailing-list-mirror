From: Sam Vilain <sam@vilain.net>
Subject: Re: Converting from svn to git
Date: Sun, 17 Aug 2008 21:11:58 +1200
Message-ID: <1218964318.2149.3.camel@maia.lan>
References: <e0b44a890808100611t27ddfcb6v21eecea89484c90b@mail.gmail.com>
	 <20080810132409.GE18960@genesis.frugalware.org>
	 <e0b44a890808100754l536bc4f3kfd953b52044f6e59@mail.gmail.com>
	 <g7n1mk$67t$1@ger.gmane.org>
	 <e0b44a890808100848p367f5c66qfa21cba1b3ba12a0@mail.gmail.com>
	 <e0b44a890808111046q2626defdnab31b0d7b1c4578@mail.gmail.com>
	 <g8421k$qcs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Sun Aug 17 11:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUeK1-0008Fm-U4
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYHQJML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYHQJMJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:12:09 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43459 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbYHQJMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 05:12:08 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E914D21C93E; Sun, 17 Aug 2008 21:12:06 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RDNS_DYNAMIC
	autolearn=no version=3.2.3
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D69C321C803;
	Sun, 17 Aug 2008 21:11:58 +1200 (NZST)
In-Reply-To: <g8421k$qcs$1@ger.gmane.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92590>

On Fri, 2008-08-15 at 15:58 +0200, Michael J Gruber wrote:
> A while ago I "complained" that rebase would skip empty commits. You 
> might experiment with that. Alternatively, the following works for me:
> 
> git filter-branch --commit-filter 'cmd="git commit-tree"; test `git show 
> --pretty=oneline $GIT_COMMIT|wc -l` = 1 && cmd="skip_commit"; $cmd "$@"' 
> -- --all
> 
> This skips all commits which introduce no diff. It will not remove 
> branches or tags which are related only to those subdirs.
> 
> I am sure there will be more elegant ways to do that (esp. the test with 
> wc).

something like this should work:

  --commit-filter 'if [ "$1" = `git rev-parse HEAD^{tree}` ]; then
skip_commit "$@"; else git commit-tree "$@"; fi'

Sam.
