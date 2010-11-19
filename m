From: Drew Northup <drew.northup@maine.edu>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 15:34:53 -0500
Message-ID: <1290198893.13785.68.camel@drew-northup.unet.maine.edu>
References: <20101117095233.GA23817@basil.fritz.box>
	 <20101117101516.GA12416@burratino>
	 <20101117143855.GA1987@sigill.intra.peff.net>
	 <20101117154829.GE23656@basil.fritz.box>
	 <20101119175424.GA13276@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 21:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJXhR-0007Bs-4R
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 21:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab0KSUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 15:36:43 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:36589 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0KSUgn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 15:36:43 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id oAJKYxVC018106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 19 Nov 2010 15:35:04 -0500
In-Reply-To: <20101119175424.GA13276@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oAJKYxVC018106
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: s
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1290803709.55748@18fWB36omZgRLQPNLoqAhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161781>


On Fri, 2010-11-19 at 12:54 -0500, Jeff King wrote:
> On Wed, Nov 17, 2010 at 04:48:29PM +0100, Andi Kleen wrote:
> 
> > On Wed, Nov 17, 2010 at 09:38:55AM -0500, Jeff King wrote:
> > > On Wed, Nov 17, 2010 at 04:15:16AM -0600, Jonathan Nieder wrote:
> > > Andi, I would be curious to hear which asciidoc and docbook-xsl versions
> > > you are using.
> > 
> > I see this with the git rpms in opensuse 11.3 which I didn't build.
> > But presumably it's built with asciidoc 8.4.5-5.1 and 1.75.2-7.1
> 
> Thanks. I think technically that is a bug in opensuse's packaging, as
> they are not setting the right knobs for their version. However, I think
> these days we can make it easier for them. Perhaps it is time to apply
> this:
> 
> -- >8 --
> Subject: [PATCH] docs: default to more modern toolset
> 
> When the ASCIIDOC8 and ASCIIDOC_NO_ROFF knobs were built,
> many people were still on asciidoc 7 and using older
> versions of docbook-xsl. These days, even the almost
> 2-year-old Debian stable needs these knobs turned.
> 
> So let's turn them by default. The new knobs ASCIIDOC7 and
> ASCIIDOC_ROFF can be used to get the old behavior if people
> are on older systems.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These defaults work on Debian stable and further. It sounds like
> opensuse 11.3, too. I don't know about Fedora, but I suspect they are at
> least as far along as Debian stable.
> 
> RHEL5 has asciidoc8, but docbook-xsl 1.69, which means it still needs
> ASCIIDOC_ROFF enabled. RHEL6 is just out last week. So we are
> technically breaking at least RHEL5 people (along with anybody with
> ancient systems) until they tweak their knobs.

Once I imported the DocBook XML XSL 4.5 files into my local cache it
seemed to make the man pages just fine on my RHEL5 machine even with the
posted patch applied.

[root@host ~]# rpm -qi asciidoc
Name        : asciidoc                     Relocations: (not relocatable)
Version     : 8.6.3                             Vendor: Dag Apt Repository, http://dag.wieers.com/apt/
Release     : 1.el5.rf                      Build Date: Thu 18 Nov 2010 08:35:22 AM EST
...
[root@host ~]# rpm -qi docbook-utils
Name        : docbook-utils                Relocations: (not relocatable)
Version     : 0.6.14                            Vendor: Red Hat, Inc.
Release     : 5.1                           Build Date: Wed 12 Jul 2006 03:55:00 AM EDT

I didn't inspect each and every one for errors, but I didn't see any
problems in the ones I did look at.


-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
