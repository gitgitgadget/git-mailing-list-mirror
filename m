From: John Keeping <john@keeping.me.uk>
Subject: Re: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Wed, 6 Feb 2013 15:14:47 +0000
Message-ID: <20130206151447.GZ1342@serenity.lan>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
 <7vtxpqslpm.fsf@alter.siamese.dyndns.org>
 <vpqmwvia2n7.fsf@grenoble-inp.fr>
 <201302061503.r16F30UA016375@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, gitster@pobox.com,
	git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36qI-0000LA-4o
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab3BFPW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:22:59 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:51787 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701Ab3BFPW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:22:58 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Feb 2013 10:22:58 EST
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A524F161E384;
	Wed,  6 Feb 2013 15:14:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tnUr865y4ybz; Wed,  6 Feb 2013 15:14:55 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A4988161E4DF;
	Wed,  6 Feb 2013 15:14:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <201302061503.r16F30UA016375@freeze.ariadne.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215589>

On Wed, Feb 06, 2013 at 10:03:00AM -0500, Dale R. Worley wrote:
> > From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> > 
> > In any case, I can't reproduce with 1.8.1.2.526.gf51a757: I don't get
> > undless output. On the other hand, I get a slightly misformatted output:
> > 
> > *   commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 2c1e6a36f4b712e914fac994463da7d0fdb2bc6d)
> > |\  Merge: 2c1e6a3 33e70e7
> > | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> > | | Date:   Tue Feb 5 22:05:33 2013 +0100
> > | | 
> > | |     Commit S
> > | | 
> > | | diff --git a/file b/file
> > | | index 6bb4d3e..afd2e75 100644
> > | | --- a/file
> > | | +++ b/file
> > | | @@ -1,4 +1,5 @@
> > | |  1
> > | |  1a
> > | |  2
> > | | +2a
> > | |  3
> > | | 
> > commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
> > | | Merge: 2c1e6a3 33e70e7
> > | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> > | | Date:   Tue Feb 5 22:05:33 2013 +0100
> > 
> > The second "commit" line (diff with second parent) doesn't have the
> > "| |" prefix, I don't think this is intentional.
> 
> The second "commit" line should start with "| * ":

No.  That would indicate a commit on the branch that is the second
parent of the first commit.  But this is the same commit as the one
above, just with a diff against its second parent instead of its first
parent.

I would argue that the line should start with "| | ", since it really is
just a continuation of the same commit.

| | 
| | commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
| | Merge: 2c1e6a3 33e70e7
| | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
| | Date:   Tue Feb 5 22:05:33 2013 +0100


John
