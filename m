From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why not preserve file permissions?
Date: Fri, 05 Dec 2008 14:23:55 -0800 (PST)
Message-ID: <m38wqui7lz.fsf@localhost.localdomain>
References: <87tz9igzbr.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 05 23:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8j6p-0005J1-Jb
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 23:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbYLEWX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 17:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbYLEWX6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 17:23:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:64838 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYLEWX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 17:23:58 -0500
Received: by ey-out-2122.google.com with SMTP id 6so98530eyi.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=o3tAWnpxvPLzcEOk9jOUcZxTrZEJnOLzSbruKQyZvKI=;
        b=gTxsDHlJlB+W3pp+4yZ4Sd5ARshfdCIkWlonBP4amza3IpmFrZuGR9KEYwQc6DLAOO
         qBv4NDHz3jNClImcTSQN9z1RZtXkWstN8dMlqbc7dm00vF3J4crt+l8BBu3SnBUcSVs7
         drRfvdMjQd8YeWujVHCdxkvCim5XU85btzw38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=MMO3ETyiPYfgjUnXBOzDzJKtNGmU/GtIv9WtSf5rgMcQTumOWgEBhebn5gegtW0ozS
         /tWN7RgAdEYJLjBoH+EBC4SeHc31pwvFW3FkYb0MzB2idya6HCtB1f8dwigC63I+OK4n
         BQueNz0os6CRbNWS/fKQSE/DKaKpiRPgEe29Y=
Received: by 10.210.136.10 with SMTP id j10mr441429ebd.188.1228515836189;
        Fri, 05 Dec 2008 14:23:56 -0800 (PST)
Received: from localhost.localdomain (abwe217.neoplus.adsl.tpnet.pl [83.8.228.217])
        by mx.google.com with ESMTPS id 20sm431287eyc.58.2008.12.05.14.23.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Dec 2008 14:23:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mB5MNswe014474;
	Fri, 5 Dec 2008 23:23:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mB5MNrOm014471;
	Fri, 5 Dec 2008 23:23:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87tz9igzbr.fsf@jidanni.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102418>

jidanni@jidanni.org writes:

> Why not preserve permissions the way you find them, instead of just
> using 644 and 755? It certainly couldn't be more complicated than what
> you are doing now, and that way one could do things like use git to
> update system administration files across a sneakernet containing e.g.,
> # dlocate -lsconf exim4-config|sed 's/ .*//'|sort -u
> -rw-r-----
> -rw-r--r--
> -rwxr-xr-x
> 
> > git was made for tracking source code, not 640 files.
> 
> On the sneakernet no public patches would be sent, and the
> administrator would remember to make the sensitive .git directories
> 700. And sure, git should enforce umask or no set-uid or whatever when
> doing a checkout etc. The deluxe edition of git could even print a
> warning: "you are trying to track a 640 file but your .git permissions
> are less restrictive." However I recommend no premium or deluxe
> editions for now.

Git was made for tracking _source code_ among _different_ machines, as
a way to collaborate in development.  This means that different users
of the same repository can have and usually have different user,
different user-id, different group, and perhaps different group
permission settings on a files.  Git supports only ordinary files,
executable ordinary files, directories and symbolic links for
a reason: otherwise it would be very easy to propagate spurious
permission changes because some contributor has different setup.

Side note: git can be used on operating systems / with filesystems
which do not have UNIX notion of permissions (think MS Windows).


Also changes _now_ to the repository format (and keeping full
permissions would require changing format of 'tree' objects) would
have to be extremely well substantiated.  And using git to store
system administration files, as a kind of cross between (amost) single
machine version control and backup system is possible even now: see
Etckeeper and IsiSetup tools (you can find them at git wiki at
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools page).  Or you
can use tools like CFEngine...

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
