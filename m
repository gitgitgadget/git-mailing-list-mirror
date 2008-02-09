From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking pickier
Date: Sat, 09 Feb 2008 15:45:35 -0800 (PST)
Message-ID: <m363wxhey1.fsf@localhost.localdomain>
References: <20080209162234.GA25533@fieldses.org>
	<alpine.LNX.1.00.0802091251430.13593@iabervon.org>
	<20080209185038.GB25533@fieldses.org>
	<7vr6fletkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:46:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNzOe-0006Xm-RI
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbYBIXpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbYBIXpi
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:45:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:35503 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986AbYBIXph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 18:45:37 -0500
Received: by ug-out-1314.google.com with SMTP id z38so101963ugc.16
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=eWHdR7rtXmqQc8aFIT6PteYbkgqZEwZ2fL12X/EL8Pg=;
        b=CrsPlDnp0ws5wITv4AKB7a0lLJZKCCut5vAFTot4IoyWYzR7QvpGPDMMsmJNCwCLEzoumTl5d1cma3cQFgq2+P8C8JlExDd5IaidLl3K1mNYuDz/oFYTe1dhxqR2YGSFlxq0TZc3GRh6Xr8lTzyS3t0WY3hN6z54omgtXJy7ZYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=LwlgNKn3VhHUc7scq0mB4m7XM/jIilG962HPjhq9BikowENXUtckSRF4fRQ/1V3kS1GtffNywgbiv2ZSPR/8SstK5xsYwivf3BNEy6RujQ4OjOkmsnME6zhAKPJKJ7gyYjpTaNt6O8Mnh7Due7UCUaBluWuqExx0wc0j5HhuWtA=
Received: by 10.67.26.7 with SMTP id d7mr7188374ugj.23.1202600736776;
        Sat, 09 Feb 2008 15:45:36 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.105])
        by mx.google.com with ESMTPS id z33sm15695292ikz.0.2008.02.09.15.45.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 15:45:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m19NjTQ1007916;
	Sun, 10 Feb 2008 00:45:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m19NjRds007913;
	Sun, 10 Feb 2008 00:45:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vr6fletkl.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73277>

Junio C Hamano <gitster@pobox.com> writes:

> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Yeah, fair enough.  Hard to know where to start, though.  OK, just to
> > get an idea, I committed a completely empty tree, made a diff (with
> > --binary), then applied with --whitespace=fix and compared to the
> > original.  In some cases these seem to be accidental, in some cases
> > (git-p4) I assume they're intended to use the different style.
> 
> I personally have this in .git/config
> 
> [core]
> 	whitespace = indent,trail,space
> 
> and the following three lines in contrib/.gitattributes (untracked)
> 
> *.py whitespace=!indent,trail,space
> *.el whitespace=!indent,trail,space
> fast-import/git-p4 whitespace=!indent,trail,space

I would also exclude gitweb/gitweb.perl

-- 
Jakub Narebski
Poland
ShadeHawk on #git
