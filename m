From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] send-email: die if CA path doesn't exist
Date: Wed, 25 Nov 2015 10:19:09 +0000
Message-ID: <20151125101909.GF18913@serenity.lan>
References: <27f354a4edb166e42006b0c1f778827a3dfd58ac.1447798206.git.john@keeping.me.uk>
 <554d29f019f52d18cf1d6c5835df0a3a098a1df4.1448407832.git.john@keeping.me.uk>
 <20151124233536.GB13872@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:19:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1XAn-0005YG-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 11:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbbKYKTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 05:19:34 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:43091 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbKYKTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 05:19:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5FAEC866011;
	Wed, 25 Nov 2015 10:19:32 +0000 (GMT)
X-Quarantine-ID: <aC4MYx353r4U>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aC4MYx353r4U; Wed, 25 Nov 2015 10:19:29 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 49895CDA582;
	Wed, 25 Nov 2015 10:19:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20151124233536.GB13872@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281695>

On Tue, Nov 24, 2015 at 06:35:36PM -0500, Jeff King wrote:
> On Tue, Nov 24, 2015 at 11:31:40PM +0000, John Keeping wrote:
> 
> > If the CA path isn't found it's most likely to indicate a
> > misconfiguration, in which case accepting any certificate is unlikely to
> > be the correct thing to do.
> 
> Thanks.
> 
> > Changes since v1:
> > - add missing path to error message
> > - remove trailing '.' on error message since die appends "at
> >   /path/to/git-send-email line ..."
> 
> It won't if the error message ends with a newline. We seem to be wildly
> inconsistent about that in send-email, though.

Interesting.  I think in this case it would definitely be better to add
the newline and avoid printing the location in the script, but it may
make more sense to have a separate pass over git-send-email.perl and fix
all of the die() calls.

I suspect that everything except the equivalent of BUG() should be
suppressing the location in a user-facing script like this.
