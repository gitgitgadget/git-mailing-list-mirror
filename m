From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn feature idea
Date: Sat, 21 May 2011 12:03:26 +0200
Message-ID: <4DD78DEE.5060206@drmicha.warpmail.net>
References: <BANLkTi=OHfHaHE86z8Ufj44J+Oxu8ec5ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 12:08:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNj6g-0003XY-HF
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 12:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab1EUKDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 06:03:31 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:60008 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793Ab1EUKD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 06:03:29 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C1CFD20A21;
	Sat, 21 May 2011 06:03:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Sat, 21 May 2011 06:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LpARRwnjJ6WAJN92QTeyyFSW6Bo=; b=M3LyElLcoESDDYfIrcQVC2etHK7eDXI9LbheIQUu7IoNMPrfKa6tDA6D8ehchbffeMJSTImlLPEsiVgKx3A6bk3jSokyuaDxit+8qAg16p//m8TDw3KJWV2PuIeheS+pdhJYpSlF0yjVAjwQ1FCdLK4OnYgKXNUuDTHjskkXWfE=
X-Sasl-enc: F4S2ftT7JQWCAbDJl3HoHx+uNuUgEgQK6DeiwFv8hwyj 1305972208
Received: from localhost.localdomain (p548599DE.dip0.t-ipconnect.de [84.133.153.222])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 23A0F4431C3;
	Sat, 21 May 2011 06:03:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=OHfHaHE86z8Ufj44J+Oxu8ec5ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174116>

fREW Schmidt venit, vidit, dixit 21.05.2011 05:41:
> Hey guys,
> Lately I've been doing a lot of permanent subversion to git
> conversions, and I keep running into braindead repo structures that
> give me pain to export.  The main one is this:
> 
> trying to check out MyProject:
> 
> trunk/MyProject
> trunk/OtherProject
> tags/MyProject-1.0
> tags/MyProject-1.1
> tags/OtherProject-1.0
> 
> So you see I can't just specify to git-svn that tags is the tags dir.
> I know a workaround (check out each tag separately and then use git
> fetch to put them all in the same repo) but that's really inefficient.
> 
> So really what would be great would be to be able to do the following:
> 
> git svn clone $repo --trunk=trunk/MyProject --tag=tags/MyProject-1.0
> (and --branch would be great too)
> 
> Anyway, I am fairly well versed with perl, so I could try my hand at
> writing such a feature, but I wouldn't really know where to start or
> if anyone other than me is even interested in something this.

If you scroll down to the config section in git-svn(1) you will find
that you can use things like this:

fetch = trunk/MyProject:refs/remotes/foo/trunk
tags = tags/MyProject-*:refs/remotes/foo/tags/*

I seem to remember you can even specify these as arguments to -t and
such but haven't checked.

Uh. Wait. We allow only .../*/... and .../* on the left hand side, at
least per the doc. So, you could either use the existing variant

tags = tags/{MyProject-1.0,MyProject-1.}:refs/remotes/foo/tags/*

or use your perl foo and lift the /*/ requirement.

Michael
