From: Geoffrey Thomas <geofft@MIT.EDU>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Fri, 30 Jan 2009 17:22:07 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu> <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT1lz-00074F-NJ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbZA3WWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752950AbZA3WWO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:22:14 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61466 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752213AbZA3WWN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 17:22:13 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n0UMM808011213;
	Fri, 30 Jan 2009 17:22:09 -0500 (EST)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as geofft@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n0UMM8Is014921;
	Fri, 30 Jan 2009 17:22:08 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107875>

> Good point (even if your commit message has lines much longer than 72
> chars, ASCII ones at that).

Oops; I'll fix that.

> But how certain are you at that point that the authors are in UTF-8
> format?  IOW what encoding conversions were possibly performed up to that
> point?

I don't believe there are any encoding conversions performed up to that 
point. IIRC git doesn't require any encoding but encourages UTF-8; if it's 
something obscure, I have no way of knowing how wide in screen columns the 
author field is because I likely don't have a library for it in git at 
all. I do have a utf8.c, though.

Currently, however, printf("%*.*s", width, width, author) is simply wrong, 
because printf only cares about bytes, not screen columns. Do you think I 
should fall back on the old behavior if i18n.commitencoding is set, or if 
at least one of the author names isn't parseable as UTF-8, or something? 
Or should I be doing this with iconv and assuming all commits are 
encoded in the current encoding specified via $LANG or $LC_whatever?

-- 
Geoffrey Thomas
geofft@mit.edu
