From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Git Architecture Question
Date: Wed, 29 Dec 2010 03:58:52 +0000 (UTC)
Message-ID: <loom.20101229T043516-592@post.gmane.org>
References: <20FFFEFA-5808-4673-B876-C5F76B52D12E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 05:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXnDc-0005qV-2u
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 05:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab0L2D7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 22:59:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:38914 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab0L2D7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 22:59:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PXnBm-0005TH-RH
	for git@vger.kernel.org; Wed, 29 Dec 2010 04:59:02 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 04:59:02 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 04:59:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.7.62 Version/11.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164303>

Anuj Gakhar <anuj.gakhar <at> gmail.com> writes:

> 
> Hi all,
> 
> I am new to Git and learning this powerful tool these days.
> 
> I have a simple question :-
> 
> I work on a project that has 3 different environments. dev, staging  
> and production. dev is obviously the local git repo that all dev's  
> work on. staging is where most of the development takes places on a  
> daily basis. and production is where least development happens but we  
> still do it because sometimes we have to fix things quickly directly  
> on the production server.
> 
> So how should I set this up ?
> 
> 2 branches staging and master (default) ?

I wouldn't use "master" for the production branch, I'd call it simply 
"production" (there's nothing special about master, except that it's the 
default when you start). However, it's quite easy to change it anytime. 
Especially, each developer may create their own private branches at will. When 
working on multiple topics concurrently you'll probably create multiple shared 
"staging" branches. It's all very fast and very easy to do.

> How can I make it so that the staging branch gets deployed to a  
> different folder on the server and the master branch gets deployed on  
> a different folder ?

You can control both the working tree directory and the git directory using 
environment variables (GIT_WORK_TREE and GIT_DIR), so it's easy, e.g.

cd stagingFolder; GIT_DIR=..../.git git checkout staging

You can use options like --git-dir instead, s. http://www.kernel.org/pub/
software/scm/git/docs/

> Once a week, we would merge all the staging work into production and  
> make a release.
> 
> Any ideas ?

It may be useful to have a single person responsible for this merging.
