From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 21:55:48 +0200
Message-ID: <20090723195548.GA28494@Pilar.aei.mpg.de>
References: <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 21:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU4Pf-000062-RP
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 21:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbZGWT47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 15:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbZGWT47
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 15:56:59 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:61815 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbZGWT46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 15:56:58 -0400
Received: by bwz28 with SMTP id 28so1046572bwz.37
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kzCQUBpI+X+tW65JRhqluXdghPn8l0p1YEtx2FkZZAU=;
        b=kUqyeLYdGy1CUVecakK7gK2FgvzfAxeLPe+bA+tgHgQOFud6Ac/vzW44xppnH/wtxE
         z1/WGyEY9oqRFJzcYDC+w4fg7UzoumLQVcXySTmw98zJuRNYTnn5mNKurAVqF99ZvrOy
         K5Rux3lbsKhVwduNkEQlXUJCXTd/uefapWSus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qYq515a4YpHUvUgjDxFBtfDefVMNmec4DKWtrwf0tpGsjhc59K+kVHJxTtLSkcWU2X
         lNZh59f+4hmwmshdSzAX7C1C7BTL6a9vUfjOZ35oxv+mPdo72gLo5wOXomuu+zuoszZ5
         sRj5DbP86qTckn2baVd2otpDz6ePMvoTZQh48=
Received: by 10.103.171.6 with SMTP id y6mr1327397muo.110.1248379017478;
        Thu, 23 Jul 2009 12:56:57 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id j9sm9287583mue.21.2009.07.23.12.56.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 12:56:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123893>

On Thu 23.Jul'09 at 12:13:41 -0700, Linus Torvalds wrote:
> > It will still do _some_ object lookups. In particular, it will do the HEAD 
> > lookup in 'print_ref_list()', even if it's not strictly necessary. But it 
> > should cut down the noise further.
> 
> And this (on top of them all) will basically avoid even that one.

Ok, I applied (both) on top of the first one.

After 7 tests I got these, 

time:

      0.61 +/- 0.08

GIT_DEBUG_LOOKUP=1 git branch |wc -l
    
      9
      
which are in fact only the branches list.

Compared to yesterday, that is a huge improvement (0.6s vs 5.7s)
and (9 vs 2200+). At least for me 0.6s is "instantaneous", so
the issue is really gone.

Thanks a lot to everyone!
