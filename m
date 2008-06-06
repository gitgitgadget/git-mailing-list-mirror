From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: remove git_blame and rename git_blame2 to git_blame
Date: Fri, 06 Jun 2008 01:24:37 -0700 (PDT)
Message-ID: <m3wsl3x96p.fsf@localhost.localdomain>
References: <1212738812-31277-1-git-send-email-rgarciasuarez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 10:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4XGV-0000oX-1X
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 10:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYFFIYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 04:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYFFIYm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 04:24:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:4314 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbYFFIYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 04:24:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so609034fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+QcjO7anmPODiHnNqmtmnB3pxC2vG/8grmjSaRMhwzs=;
        b=A77hV1amxVGfC+3xJtSG/TiARxLAMdueyZ85T9TXlGSChR1YlpWKS2KXfmlgqkjNwt
         +HjIn5glcrUOy91dxt2/q3v8oqK+COrr9H9/e84BOPBXCKeBuKGPSA1Lmv2dVnPlDmzN
         heKoyAzTomIbmn0d/aJBIWYiQJWB9p0w6YGvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=S2iBEcPo3giSFv8kGIIXFu8TJfmJ8LtBlRNZnP2ZRPuyP52j0DqbMcZEam8X9ubtxY
         pDXiuC/tdVsJTneTUKagGq6JJmOITW5tU1Xce4KPTooVmicaxcaN5MpBi+YSWN0BDtMM
         4qJzFEfDOZcu3PP2t7jaZSnimA89wKr5O4fGw=
Received: by 10.86.65.11 with SMTP id n11mr2976655fga.35.1212740679477;
        Fri, 06 Jun 2008 01:24:39 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.247.141])
        by mx.google.com with ESMTPS id 3sm5250010fge.3.2008.06.06.01.24.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 01:24:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m568OWLs023480;
	Fri, 6 Jun 2008 10:24:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m568OUat023477;
	Fri, 6 Jun 2008 10:24:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1212738812-31277-1-git-send-email-rgarciasuarez@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84038>

Rafael Garcia-Suarez <rgarciasuarez@gmail.com> writes:

> git_blame is dead code. It's possible to plug it in place of
> git_blame2, but I don't know whether anyone does still that,
> because git_blame2 can now be considered stable enough, I think.

First, the two competing subroutines, git_blame and git_blame2
are from the time when there were two competing 'blame'
implementations, respectively git-annotate (in Perl) and git-blame.  
git-blame won, and nowadays git-annotate is builtin alias passing
'-c' option (Use the same output mode as git-annotate) to git-blame.

git_blame and git_blame2 had not only different backend, but have
different output as well.  git_blame uses more columns, showing more
info at first glance, while git_blame2 is simpler and less cluttered.

That said, removing git_blame is a good idea (there was even some
patch on this mailing list doing that, but IIRC it was part of larger
series, and somehow got dropped, at least for mainline gitweb).  There
is always history if we want to check how its output looked like.

Acked-by: Jakub Narebski <jnareb@gmail.com>

(FWIW, as I am not gitweb maintainer).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
