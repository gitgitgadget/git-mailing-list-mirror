From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: commit-id fails after cg-init
Date: Thu, 5 May 2005 11:22:02 +0400
Message-ID: <200505051122.03111.snake@penza-gsm.ru>
References: <1115150585.28520.11.camel@dv> <20050503211301.GA15995@pasky.ji.cz> <4278E6D4.6060807@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 05 09:15:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTaaE-0005rD-Me
	for gcvg-git@gmane.org; Thu, 05 May 2005 09:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVEEHWL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 03:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVEEHWL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 03:22:11 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:4584 "HELO
	penza-gsm.ru") by vger.kernel.org with SMTP id S261973AbVEEHWH
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 May 2005 03:22:07 -0400
Received: (qmail 14506 invoked from network); 5 May 2005 07:22:05 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 5 May 2005 07:22:04 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <4278E6D4.6060807@dwheeler.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wensday, 04 May 2005 19:14 David A. Wheeler wrote:
> Joel Becker said:
> > Well, cg-init in this case creates no objects.  I'd say,
> >instead, it should create an empty tree object (representing a project
> >with no files) and commit that.  That would be your initial commit, and
> >would put something valid in heads/master.
>
> That would actually make sense; commits would go all the way
> back to the "empty tree" as the ultimate initial tree.
>
> There's an interesting side-effect of this; I _think_ it's
> fine but it might be worth thinking through. If all
> new projects start with an empty tree, that creates a
> "common root" that all projects can appeal to.
> That means that in theory a merge between any two project root
> trees can eventually find a common ancestor: the empty tree.
> I _think_ that's okay... is it?
>
> That also means that empty directories will end up with the
> "empty tree" as well.  Is there a risk of multiple empty directories
> causing problems later?  As far as I can tell, there aren't
> any problems with that, and does seem logically sound.
I think this problem can be easily solved with:
1) Restricting to auto-select empty commit as the merge base
2) Make an exception from rule (1) for first real commit

By (1) we will restrict accidental bad merges that can happen due to crasy 
operator - he will need to explicitly select empty commit as merge base.

By (2) we will allow to pull and merge projects that is just started 
envolving.

-- 
Respectfully
Alexey Nezhdanov

