From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC?] Telling git about more complex relationships between commits (Was: Re: FFmpeg considering GIT)
Date: Fri, 4 May 2007 12:39:18 +0100
Message-ID: <200705041239.22300.andyparkins@gmail.com>
References: <loom.20070502T111026-882@post.gmane.org> <200705040921.33443.johan@herland.net> <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johan Herland" <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 13:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjw8b-0005Yy-Cs
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbXEDLjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbXEDLjp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:39:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:61046 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbXEDLjo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:39:44 -0400
Received: by ug-out-1314.google.com with SMTP id 44so631080uga
        for <git@vger.kernel.org>; Fri, 04 May 2007 04:39:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MPjKc1FWPvqT/nxd50Ph0DlDeljIXNF0hL0mluBPIVtgj/b6O0gZc0kim0ixdtwikWAkMWJ+E2970NyM5QE6LHInokSt4PPfxaGQpMC7HYCoW1Q2sMM0A9fwmayGViqXA7ZDh3T3aWIJunY/YmhvD5eVGTswYiQhlBVw73vaTzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fE+ljVGt7UeUqXihQ0BN5OoGllkwesmIVS6Bs/SwsbdXwDPGqA2N/S4E3WqXLlEI63wxfmIndGQwNA7W6tlySDBdVXPi9LIeBUqLDvJ5VefBFgIZ+osLJutkpVDfDvV02KbCRQvb4KdwTNvlCk0RYMXKetaivi5UQsgcgDiTYWI=
Received: by 10.82.123.16 with SMTP id v16mr6298912buc.1178278782507;
        Fri, 04 May 2007 04:39:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm27279ikz.2007.05.04.04.39.36;
        Fri, 04 May 2007 04:39:40 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <81b0412b0705040236w1d5f26bx8ac351ade2f4ea6a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46173>

On Friday 2007 May 04, Alex Riesen wrote:
> On 5/4/07, Johan Herland <johan@herland.net> wrote:
> > 1. "Reverts": Mark a commit as reverting another commit. This could be

> These are completely useless after the first "git gc --prune" or "git

Agreed for the cherry pick (and the rebase), but the original of a revert 
won't be pruned - in fact it's almost certain that the original is a subset 
of the revert itself (otherwise the revert wouldn't have applied cleanly).

 * --- * --- X --- * --- !X --- * --- *

See?  X won't ever be pruned without !X having been pruned first.

It doesn't seem unreasonable to record in a machine readable manner that !X 
undid X.  It might be useful to someone one day.

As for custom headers - it's a great idea; here's the one that would be most 
useful:

 X-Git-SVN-ID: 9553f0bf-9b14-0410-a0b8-cfaf0461ba5b

That way git-svn wouldn't (necessarily) need to keep its .rev_db file, and it 
wouldn't need any special handling to allow the repository to be cloned.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
