From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn of both trunk and tags while having no access to the
 'parent' of those
Date: Wed, 18 Nov 2009 14:56:57 +0100
Message-ID: <4B03FD29.3090001@drmicha.warpmail.net>
References: <20091117025945.GE17964@onerussian.com> <4B03B7D3.8050905@drmicha.warpmail.net> <20091118133205.GB17964@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAl2o-0001wm-Jb
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbZKRN5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757080AbZKRN5u
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:57:50 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40650 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756988AbZKRN5u (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 08:57:50 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EC496C0D69;
	Wed, 18 Nov 2009 08:57:55 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 18 Nov 2009 08:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=CVsmoNq8fpY5y/XZ9xGinh4SNOI=; b=PL3q5b5pp77cU/jUb1zEpakI2miKsRTN54ho0m9H9iZuswtfNfFUBo6eUAjafe3wEjVW+FdvsYTGTvaepAhvNlDMXkNbwJoovWon6zTQG+LlbGil+DePjHxtJgwaJxLJaRBjYeQbAKttRty0yRc8EloA7tRvgZriXNEG1wtby5Q=
X-Sasl-enc: 3peKyWSuws+sUM6YFijeJ4LRRocttoJP3pAsNU/Xy1WO 1258552675
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5CAC54B2F21;
	Wed, 18 Nov 2009 08:57:55 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <20091118133205.GB17964@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133175>

Yaroslav Halchenko venit, vidit, dixit 18.11.2009 14:32:
> 
> On Wed, 18 Nov 2009, Michael J Gruber wrote:
> 
>>> git svn clone --prefix=upstream-svn/ -T trunk -t releases http://domain.com/svnrepo svnrepo.gitsvn
> 
>> Your problem description seems to match perfectly with the description
>> of the "--no-minimize-url" option in git svn's man page. I'm sure it's
>> worth a try.
> 
> ;-) oh I did I did ;)
> I've used
> 
> git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t releases  http://domain.com/svnrepo/trunk svnrepo.gitsvn

Is the trunk really at svnrepo/trunk/trunk?

> that initialized repository, went through a lengthy list of 
> 
> trace: built-in: git 'config' 'svn-remote.svn.tags-maxRev' '...'
> 
> with last command reported
> 
> trace: built-in: git 'gc' '--auto'
> 
> and resulted in nothing being cloned/checked out or even a single ref.
> The only file under .git besides the ones created by git init
> 
> ./svn/refs/remotes/upstream-svn/trunk/.rev_map.33fb83da-1015-0410-9b9b-96027f9a4af8
> 
> and if I omitted trunk/ from url -- the same story of needed
> authentication

I would try both

git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t
releases  http://domain.com/svnrepo/ svnrepo.gitsvn

and also the seemingly equivalent

git svn clone --no-minimize-url --prefix=upstream-svn/ -T
http://domain.com/svnrepo/trunk -t http://domain.com/svnrepo/releases
svnrepo.gitsvn

Also, I assume you can svn list http://domain.com/svnrepo/trunk and
http://domain.com/svnrepo/releases ;)

Michael
