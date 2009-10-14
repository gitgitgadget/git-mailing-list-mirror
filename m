From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Changing branches in supermodule does not affect submodule?
Date: Wed, 14 Oct 2009 17:39:29 +0200
Message-ID: <4AD5F0B1.4000507@web.de>
References: <alpine.DEB.2.00.0910131115160.14223@ds9.cixit.se> <4AD47C65.5080904@web.de> <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 14 17:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My612-0001Ku-QH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 17:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934136AbZJNPkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 11:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934044AbZJNPkK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 11:40:10 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:43481 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207AbZJNPkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 11:40:09 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9B5B21247628B;
	Wed, 14 Oct 2009 17:39:32 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My5wq-0000ge-00; Wed, 14 Oct 2009 17:39:32 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <alpine.DEB.2.00.0910140728420.16100@ds9.cixit.se>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/ByR9W/fDUOvrjII+csR3eRGLhoLv3C1Tnw+MO
	TUs/A6rH3VExtJHipC9pUS5UxqRPqqqznfNerm9nia5EbaiAgf
	p/f3JyNiKujrpw87Br+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130300>

Peter Krefting schrieb:
> Jens Lehmann:
> 
>> just calling "git submodule update" every time you want the submodule
>> to be updated according to the state committed in the superproject
>> will do the trick (but keep in mind that all referenced commits have
>> to be accessible in the local clone of your submodule, so you might
>> have to do a fetch there once in a while).

BTW: unless you use the -N or --no-fetch option, git submodule update
will do the fetch for you.


> Is it possible to automate this from a hook or something else?

Yep, you can use the post-checkout hook for that, just put a "git
submodule update" in it.

*But*: If you do a checkout in the superproject while the submodule
has new commits not contained in any branch (remember submodules
often have a detached head) you'll silently lose these commits!
Then only the reflog can help you ...
