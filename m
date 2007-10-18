From: Sam Vilain <sam@vilain.net>
Subject: Re: [BUG] git-svn not following svn moves
Date: Fri, 19 Oct 2007 11:04:12 +1300
Message-ID: <4717D85C.9050805@vilain.net>
References: <ff7fhg$2eu$1@ger.gmane.org>	<20071018121328.GA5358@xp.machine.xx> <ff7m2j$2eu$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: cho <tobutaz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IidU4-0001wx-JQ
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbXJRWEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759526AbXJRWEW
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:04:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35397 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490AbXJRWEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 18:04:21 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id CEE6E21CFE8; Fri, 19 Oct 2007 11:04:19 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D3D6B21CFDB;
	Fri, 19 Oct 2007 11:04:14 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <ff7m2j$2eu$2@ger.gmane.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61564>

cho wrote:
> I've surprised myself but yes, there is a simple testcase.
> 
> svnadmin create repo
> svn checkout file://$PWD/repo checkout
> cd checkout/
> svn mkdir trunk tags branches
> svn ci -m 'Standard svn layout.'
> cd trunk/
> svn mkdir doc
> touch doc/README
> svn add doc/README
> svn ci -m 'Add README.'
> cd ..
> svn mv trunk/ branches/oldtrunk
> svn ci -m 'Moved trunk.'
> svn mkdir trunk
> svn ci -m 'New trunk.'
> cd trunk/
> touch THIS_IS_THE_NEW_TRUNK
> svn add THIS_IS_THE_NEW_TRUNK
> svn ci -m 'Add marker.'
> cd ../..
> git svn clone file://$PWD/repo --stdlayout git-clone
> cd git-clone/
> tree
> 
> So the testcase basically involves moving the trunk.
> git-svn gets very confused and keeps a mixture of the old and new trunk.

Were you using --follow-parent or not?

Sam.
