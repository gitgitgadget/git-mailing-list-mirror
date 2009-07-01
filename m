From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Wed, 01 Jul 2009 10:37:37 +0200
Message-ID: <4A4B2051.7020606@gnu.org>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628185218.GB8634@sigio.peff.net> <20090628210117.GA7821@old.homeip.net> <20090630053304.GB29643@sigio.peff.net> <20090630151442.GA20688@old.homeip.net> <20090630153347.GA3547@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Renold <martinxyz@gmx.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:37:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLvKA-0000vM-L3
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 10:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbZGAIhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 04:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZGAIhk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 04:37:40 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:53879 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbZGAIhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 04:37:39 -0400
Received: by ewy6 with SMTP id 6so904404ewy.37
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ury1UIWAwZtr/XF9ep6uNOsCS28M7RbhkTl65hqOKr0=;
        b=qWGxJaAQU3M1nz530cT8XvweOl05LfTrtvJ6y2tPi/bv/7Qc5zt3MbxQdtaYLJ3tcL
         Oge6114Dz0daNAtR+ExMLEOqOoPD8nrh3cvcUCEFtaR64oq9PWbqGs349lHpiH0RC3ic
         0Yk8XTWl7sq1uffJx8iCLWKZ52NxrsyooOI0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=sMqF0wDXzRDHpap04Etia8sDIn/Z9KtKeCMDpqDGNrk7likJbH8caxnMpFdYI13edd
         5zt7YPUQ3/NhfH2ifiNdidIaUo/hri9Qh3JwCgUg3W7USykBqWjwbjGTfMS0+EOLXlyb
         L6CCDkHsH2yeXT/LCHWMN6vBLBcijcmcCnYc0=
Received: by 10.210.63.18 with SMTP id l18mr1375572eba.71.1246437461632;
        Wed, 01 Jul 2009 01:37:41 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 7sm2421892eyg.47.2009.07.01.01.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 01:37:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20090630153347.GA3547@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122576>


> There has been much discussion about an alternate command that would be
> more like "svn status", and even some partial implementations. But it
> needs somebody who really cares about the feature to step up and
> complete it.

An alias

         changes=diff --name-status -r

already does almost the same function as "svn status -q".  If you wanted 
full svn status with untracked files you could use this:

	changes = "!sh -c 'git status | sed -n 
\"/Untracked/N;//N;1,//d;s/^#/?/p\"; git diff --name-status -r \"$@\"' -"

Paolo
