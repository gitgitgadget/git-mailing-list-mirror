From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: push.default???
Date: Tue, 23 Jun 2009 14:59:10 +0200
Message-ID: <4A40D19E.60606@gmail.com>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 14:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ5b9-0006n6-ST
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 14:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbZFWM7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 08:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZFWM7T
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 08:59:19 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:59591 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbZFWM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 08:59:18 -0400
Received: by ewy6 with SMTP id 6so62735ewy.37
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VliLBDBhsLRrkNNubIeI4dnS0JdD/AvBjLDwBg0wmRI=;
        b=S7UcDLxVykUCoqjc5Wi6+rDNGQNK0Ra2GbxOc1UDeQ3hWuMvEJgD2WF40CzKJ/JzYK
         cATODGP2rhPEHPwSWQIGo8CYTzwWg6+s9SOM9IPXF1JjjrEqrzcY2wrfce7B9mXUDOxN
         XYS2BDSjGFh5a51K03hS3WkwX1Q1PBCtvWgKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nj6Gsx7vTvjEpl+zCd8UEGmmeBzd2oxE9Gia0IaYphV60WE3Z+YDb9DbmO440qe9dH
         dCzuwUZiUSTBO3uXEa99IwEh9kd77EHJkcCLAEHtcZHqUFFZR3btJEGB/K6f3TH+D2qI
         Ha7VXzy6sF9j5PIpGWpC1SKPg3sX49ji0kxCA=
Received: by 10.210.128.5 with SMTP id a5mr6324125ebd.47.1245761960114;
        Tue, 23 Jun 2009 05:59:20 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 28sm137417eyg.44.2009.06.23.05.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 05:59:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20081009)
In-Reply-To: <20090623103428.GA4214@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122086>

Finn Arne Gangstad wrote:
> On Mon, Jun 22, 2009 at 12:02:33PM +0200, Paolo Bonzini wrote:
>> Hi all, I just upgraded to git 1.6.3 and found this new little gem  
>> called push.default...
>> [...]
> 
> You should have been here when we discussed this! :)

Yes, mea culpa.  But I would have expected a *lot* more discussion from 
what I remembered about the git list and community. :-)

>> 1) Also in 1.6.3, invent a special refspec for "tracking", something  
>> like "HEAD>" (of course this is not a special case; "refs/heads/*>"  
>> would also work, yadda yadda)
> 
> Yes, this is a weakness righ now - the only way to get tracking
> semantics is to set push.default. I could not find a very good way of
> specifying this. We currently have the magic refspecs : and
> HEAD. Adding a ">" to "HEAD>" would be annoying I think, since it has
> to be quoted in the shell.

Yes, > has the disadvantage of quoting.

> Maybe we can use ":" as an escape, it is not allowed in refspecs.
> Something like "::tracking" (and we cold also have "::matching",
> "::current" and so on for completeness)

But that would lose the possibility to use wildcards.

Before going on, can you explain your use case for --push=tracking (in a 
case where --push=current wouldn't do the same)?

>> 4) in 1.6.4 or 1.7.0, make "git push" fail outright if there is no push  
>> line, with text suggesting [...]
> 
> Hopefully we can get to this stage, that a unconfigured "git push"
> gives a small message, indicating how to configure it, and not push
> anything. Most "oldtimers" should have configured this already, so it
> should not break many setups.

Agreed.  Possibly with a "git remote" command to add a push refspec.

Paolo
