From: Sam Vilain <sam@vilain.net>
Subject: Re: git-svn init/fetch: wow that's slow
Date: Wed, 22 Apr 2009 23:05:52 +1200
Message-ID: <1240398352.20236.26.camel@maia.lan>
References: <E26B8975-74D3-4F01-A9D9-DAAB96C8FC85@gmail.com>
	 <fabb9a1e0904220255w55c8fee1uf534aad07cefa818@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Lachlan Deck <lachlan.deck@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwaIe-0005Xv-4P
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbZDVLF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 07:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbZDVLF5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:05:57 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42419 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbZDVLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 07:05:56 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D237C21C324; Wed, 22 Apr 2009 23:05:47 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 1278421C15A;
	Wed, 22 Apr 2009 23:05:43 +1200 (NZST)
In-Reply-To: <fabb9a1e0904220255w55c8fee1uf534aad07cefa818@mail.gmail.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117191>

On Wed, 2009-04-22 at 11:55 +0200, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Apr 22, 2009 at 09:40, Lachlan Deck <lachlan.deck@gmail.com> wrote:
> > Okay, so I'm using git 1.6.2. I assume this is all a 'known issue'. Has
> > there been any work / plans towards improving this?
> 
> This can be improved by using svn 1.5's delta feature, however, Eric
> (the author of git-svn) does not have the time to do this, and no-one
> has stepped up to do this.
> A workaround is to not clone from r1 but instead start at a more
> recent revision.

Fetching over plain svn:// is IME much faster.  But let's face it, SVN
is no race-horse and was never designed for the case where people like
to look at their history much.  Developing with a trunk was so painful,
people would rather just forget... 

One workaround is to use SVK to do the initial mirroring, and the
--use-svm-mirror flag to convert your SVK mirror path to git.  See
http://utsl.gen.nz/talks/git-svn/intro.html for a guide for the second
part of that.  SVK has implemented some of the harder parts of the SVN
API to get right, such as request pipelining - see
http://code.bestpractical.com/svk/trunk/lib/SVK/Mirror/Backend/SVNRaPipe.pm for how the SVN API "supports" this.  As a result of this dedication to the cause, SVK does this part very quickly.

Sam
