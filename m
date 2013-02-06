From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Adding Missing Tags to a Repository
Date: Wed, 06 Feb 2013 12:18:52 +0100
Message-ID: <51123C1C.4020600@drmicha.warpmail.net>
References: <CANC5J9F5Pnp08KTem-fdcs_4DcmoN+OgqCHR0=r0y--U8=fdog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neil <kngspook@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3324-0006xT-4r
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 12:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab3BFLSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 06:18:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37128 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751734Ab3BFLSw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 06:18:52 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9BFAF211C9;
	Wed,  6 Feb 2013 06:18:51 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 06 Feb 2013 06:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=pEOXTA+akjDPBP4oM38JFn
	WnUJQ=; b=rcPkT6EKLZErGOVH0MCJVAREgXNRLECtSKKNl54lfcV7eIFkxWLjYg
	A8g3RlJ78ychy2gI2PDlD9BDNq1L56+BCmYm6hn/lfP+FPxkYHjvCWWRVQGEWo1n
	ujI+LgaLr9xPwsaHg0G7Jtb6R3P+EygrFu59j0TPom5bZRRBRirpQ=
X-Sasl-enc: XgAXNZaAtbH4Y3+DEI9Iugx3R3FW2ijQOWJ505BvT4nY 1360149531
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 18EC98E0185;
	Wed,  6 Feb 2013 06:18:50 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CANC5J9F5Pnp08KTem-fdcs_4DcmoN+OgqCHR0=r0y--U8=fdog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215574>

Neil venit, vidit, dixit 06.02.2013 05:45:
> Hi everyone,
> 
> A while back I did a svn-to-git migration for my team. Our subversion
> repository had about 30K+ commits, 100+ branches, 2K+ tags, all made
> over a 20+ year period. I was doing the migration using git-svn, and
> my big problem was the tags. git-svn seemed to want to traverse the
> entire history of each tag, which was taking a long time. Because time
> and resources were limited, I ended up just migrating the branches and
> trunk, with the idea that I would handle the tags at a later date. My
> original plan to do that was to crawl the subversion log, find where
> the tags were made, and apply a git tag to the commit that was the
> source of the tag. This was a bad idea.
> 
> I've found that over the years, people have made tags that are only
> subdirectories of the source tree, made tags off of other tags, and
> committed to tags. The latter is the biggest problem, since those
> commits don't seem to be stored in the git repository because they
> never appeared in the branches/trunk.

I think it's fair to say that svn encourages the abuse of tags ;)

I've cleaned up other people's mis-tags myself, and it's no fun. If the
tree layout is messed up then git-svn will often create a new root
commit, so that you have to stitch the history yourself.

In the case of "correct" tags, you're often better of converting the tag
creating commit into an annotated tag, provided that the tree is unchanged.

Tags with tree changes are really branches, usually maintenance branches
after a proper tag.

> So, I'm wondering what my options are to bring back this history. One
> idea is to somehow resume the git-svn download, but changing it to
> also scan tags (it sounds like it should be possible, but I haven't
> tried it yet). Or maybe there's some other tool that will more quickly
> clone the repository including tags, and then I can somehow splice the
> tags back into the repository we're already using?
> 
> Any ideas or suggestions?
> 
> Thanks!
> 

If you add a git-svn refspec to your config and rerun git-svn fetch it
might rescan tags, although you may have to poke around to make it
rescan from revision 1.

Michael
