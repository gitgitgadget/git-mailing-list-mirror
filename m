From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] convert filter: supply path to external driver
Date: Mon, 20 Dec 2010 06:41:59 -0800
Message-ID: <20101220144159.GB30945@honk.padd.com>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <4D0F0DFB.20502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 20 15:47:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUh1i-0005cX-ND
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 15:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588Ab0LTOrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 09:47:45 -0500
Received: from honk.padd.com ([74.3.171.149]:50319 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932571Ab0LTOrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 09:47:45 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2010 09:47:45 EST
Received: by honk.padd.com (Postfix, from userid 7770)
	id B875A2187; Mon, 20 Dec 2010 06:41:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D0F0DFB.20502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163996>

j.sixt@viscovery.net wrote on Mon, 20 Dec 2010 09:04 +0100:
> Am 12/19/2010 22:29, schrieb Pete Wyckoff:
> > Filtering to support keyword expansion may need the name of
> > the file being filtered.  In particular, to support p4 keywords
> > like
> > 
> >     $File: //depot/product/dir/script.sh $
> > 
> > the smudge filter needs to know the name of the file it is
> > smudging.
> > 
> > Add a "%s" conversion specifier to the gitattribute for filter.
> > It will be expanded with the path name to the file when invoking
> > the external filter command.
> 
> What happens if there are any shell special characters in the path name
> (or spaces, for that matter). Does this shell-escape the substituted path
> name anywhere in the call chain?

Good catch---it doesn't.  I'll see if running everything through
sq_quote_buf will help.

Incidentally there appears to be no way to quote spaces in
filenames listed in .gitattributes, although fnmatch wildcards
can be used to work around that.

		-- Pete
