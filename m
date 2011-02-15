From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Tue, 15 Feb 2011 03:18:28 -0600
Message-ID: <20110215091828.GA22661@elie>
References: <4D596435.9020605@gmail.com>
 <AANLkTimi=d0qbO3_-BEnPEJ+iy9B=_fksF7TiBE7HorC@mail.gmail.com>
 <4D59A39C.9090402@gmail.com>
 <4D5A401B.1050103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Monsen <haircut@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 10:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpH3T-0006Lz-8u
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 10:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab1BOJSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 04:18:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41409 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab1BOJSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 04:18:36 -0500
Received: by gyb11 with SMTP id 11so2458295gyb.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 01:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+IfqQgFbONzuWCjT01JEw7WgDL2L4+UZWjFPpIjqW7I=;
        b=mn+8T1AehMiShMOzXgNvcGjdPrLUtsn0uIijz3+T2ihIz+e2+nNkn+WkAge4Kok2VO
         4GAxpccHIe/2MaaEXueRlw3o4ClvpsgIGNZ5xURa3pujYkCsYs/hLN/XDr9F3rexdeCJ
         dNaUFXGAed/rR1exLC6gdY5zigHYdXR7fVCeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wWlSUDPzo42/XYhG/KMvpmeG1dgqcI1a5DKf3lX3Hoxh+eomNuGqeZfD8N2JHwI6T8
         PCSkxBNk9YZZxxXhaWAtfDdSyQaTNr+wpCT0lWjxpOA6lapUU//flu6WD+2bprEa2rh4
         KQCWsHWBZT8dIfWmWRkZQoL5ZKzek+y+OzIJE=
Received: by 10.236.109.51 with SMTP id r39mr3144018yhg.66.1297761515197;
        Tue, 15 Feb 2011 01:18:35 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id 50sm2211164yhl.29.2011.02.15.01.18.33
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 01:18:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5A401B.1050103@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166831>

Michael J Gruber wrote:

> - If you do want them on the same branch "f-release", you probably know
> beforehand which commits you don't want on master. You can fake-merge
> these ("merge -Xours") to master and merge the others

For the record, I think that should be -sours.

I think it's just a typo but the difference is big --- -sours means
"supersede by pretending to merge but actually keeping our version",
while -Xours means "do a normal merge but be sloppy and favor our
change when encountering adjacent or overlapping changes".

I suppose -Xours should have been named -Xfavor-ours,
-Xsloppy-favoring-ours, or something similarly explicit.

> git checkout master
> git merge f-release
> #be happy if it succeeds, identify problematic commit X if not; decide
> whether X belongs on master; if yes resolve, if not reset and:
> git merge X^
> git merge -Xours X
> #back to start

Thanks for a nice example.
Jonathan
