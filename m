From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Introduce rename factorization in diffcore.
Date: Fri, 07 Nov 2008 04:55:31 -0800 (PST)
Message-ID: <m3vduzelwt.fsf@localhost.localdomain>
References: <20081030220532.3325.54457.stgit@gandelf.nowhere.earth>
	<20081030221645.3325.78288.stgit@gandelf.nowhere.earth>
	<2faad3050811070328t31babed4v1ba895a6ac36df94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Yann Dirson" <ydirson@altern.org>, git@vger.kernel.org
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 13:57:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyQtc-00065l-MR
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 13:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYKGMzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 07:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbYKGMzf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 07:55:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:59143 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYKGMze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 07:55:34 -0500
Received: by ey-out-2122.google.com with SMTP id 6so508319eyi.37
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CKUj8WYuKn3/O6RkhXvPnrDTPbs2JSxKWcMnKKE26Xg=;
        b=VWAB4pW4o343pPRacpC9b0lwayNdsIMhTY/hx78kSqA5UIfGhJ8wIwsMf8orTO9F+G
         kA8VhCs+8bCwxBHZJKPraRny6983NWMHWlpDEVSAwkUXAkDNsHR4WE5CIkh9C08inn1Y
         aiD9WejkqLekDeFzeF6T9OZPYefVk+cL23bYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Db1Snl517aMo1b6krWWl1krUUlM8PWPUulapezNKYDJsa1H8kZKmFH5WGMYMxSlSNv
         RfQ6cFFTTzlvfcC+gf0GUVP2ySZYIBn2eaXIH1lil9eczHYVjH1zIU8YtTxcRSwLhw5X
         2+W6OSwxW61A0wk3CsMElP238RyF1dEhRGmBw=
Received: by 10.210.79.14 with SMTP id c14mr3853218ebb.194.1226062532541;
        Fri, 07 Nov 2008 04:55:32 -0800 (PST)
Received: from localhost.localdomain (abvq140.neoplus.adsl.tpnet.pl [83.8.214.140])
        by mx.google.com with ESMTPS id d2sm1936075nfc.20.2008.11.07.04.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Nov 2008 04:55:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mA7CsuGl017122;
	Fri, 7 Nov 2008 13:55:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mA7CshkV017118;
	Fri, 7 Nov 2008 13:54:43 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2faad3050811070328t31babed4v1ba895a6ac36df94@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100310>

Baz <brian.ewins@gmail.com> writes:
> 2008/10/30 Yann Dirson <ydirson@altern.org>:

> > Rename factorization tries to group together files moving from and to
> > identical directories - the most common case being directory renames.
> > This feature is activated by the new --factorize-renames diffcore
> > flag.
> 
> Sorry to bikeshed a bit here, but this isn't what 'factorize' means,
> and adding a flag with this name unnecessarily adds to the
> git-specific terms users have to learn.

Well, I think from _mathematical_ (arithmetic) point of view it makes
perfect sense.  Before you had:

  (rename-of-sub1-file1 rename-of-sub1-file2 rename-of-sub1-file3)

and after you have

  (rename-of-sub1) * (changes in files)
 
> Looking back through the archives, there's only a few people who've
> used the word 'factorize', and /mostly/ it seems to have been used as
> a synonym for 'refactor' in comments; not common usage but
> understandable. However in this case, factorize is being used in the
> opposite sense from its dictionary definition - to break down into
> factors - and instead is being used to mean to /combine/ things; I
> don't think that should be in the UI.
> 
> Why not just '--group-renames'?

That said, I think that '--group-renames' makes better sense (and is
shorted than '--detect-directory-renames')

+1 for '--group-renames'

-- 
Jakub Narebski
Poland
ShadeHawk on #git
