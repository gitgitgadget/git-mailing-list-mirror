From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Do not include diff in spec file when just
 preparing p4
Date: Mon, 13 Jan 2014 19:06:13 -0500
Message-ID: <20140114000613.GA11594@padd.com>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maxime Coste <frrrwww@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 01:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2rWV-00029K-CY
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 01:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaANAGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 19:06:19 -0500
Received: from honk.padd.com ([74.3.171.149]:39676 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaANAGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 19:06:18 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 90C6B70F4;
	Mon, 13 Jan 2014 16:06:17 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 62175201FC; Mon, 13 Jan 2014 19:06:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20140113121011.GA9711@nekage>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240379>

frrrwww@gmail.com wrote on Mon, 13 Jan 2014 12:10 +0000:
> Hello,
> 
> On Sun, Jan 12, 2014 at 05:29:46PM -0500, Pete Wyckoff wrote:
> > Thanks for the patch, but I'm curious how you'd like this to
> > work.  I never use the option myself.
> > 
> > As it is, --prepare-p4-only generates a file in /tmp/ that has
> > exactly the contents you'd see in the editor during "git p4
> > submit".  It includes the diff of the change, presumably to help
> > with writing the description.
> 
> Yes, I believe it makes sense to display the diff in this case, as we
> can remove it later programmatically.
>  
> > Now you can't actually feed this file directly to "p4 submit"
> > without deleting the diff.  That's the part you don't like?
> 
> Yes, I do not use that for submitting, but for shelving. I can run
> git p4 submit --prepare-p4-only followed by p4 shelve -i < /tmp/...
> and perforce will shelve the corresponding change.
> 
> Removing the diff could be done externally, however git-p4 itself
> tells the user it can submit using the generated file, which is
> not the case if we keep the diff in it.

I'm convinced.  That explanation makes sense, thanks.

It would be nice to do a few more things with this patch.  Here's
some ideas, sorted in priority order.

    1.  Put slightly more text into the commit message, possibly
    from your email above.

    2.  Refactor out that big chunk of code instead of just
    moving it.  Selectively call it only if not prepare_p4_only.

    3.  Modify the t9807 test 'submit --prepare-p4-only' to make
    sure the diff isn't there.

    4.  Documentation update?  Probably not necessary.

Let me know if you're interested in doing any of this.

		-- Pete
