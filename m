From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFC: default version of the documentation tool chain (git 1.7)
Date: Tue, 11 Aug 2009 11:28:37 +0200
Message-ID: <4A8139C5.9030703@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maq5j-0004GO-Kp
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZHKL41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbZHKL4W
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:56:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57301 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750773AbZHKL4T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 07:56:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6DF97124A6
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:28:52 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 11 Aug 2009 05:28:52 -0400
X-Sasl-enc: /t40KYTebYLzrMVFNToxBtIAPi4yszGduyeq4gsaXm4U 1249982932
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E4826313D8
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:28:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125518>

The current defaults for building the documentation are so that asciidoc
up to 7.1.2 and docbook-xsl 1.69.0 and 1.71.1 need no extra settings,
whereas all other versions need extra options (1 or more of ASCIIDOC8,
ASCIIDOC_NO_ROFF, DOCBOOK_XSL_172, DOCBOOK_SUPPRESS_SP), see below. This
basically means that all current distros need extra options.

I suggest changing the defaults for the git-1.7 cycle. Below I list the
package versions in current mainstream distros, without using third
party repositories, but including the leading edge which foreshadows
upcoming versions.

Based on that, I suggest the following defaults for the git-1.7
documentation build file:
- ASCIIDOC8=yes. Caters for everything non-EOLed (8.0 and above)
- ASCIIDOC_NO_ROFF=yes. Caters for everything non-EOLed (1.73 and above,
1.68.1 and below)

[I'm not sure RHEL is EOLed but I don't think we need to care.]

It would be helpful if people with newer versions (asciidoc 8.4,
docbook-xsl 1.75) could test building the git documentation, in order to
verify "and above" ;)
Also, I don't know about the two proprietary OSes we support.

Cheers,
Michael

Current mainstream versions of asciidoc are:
Debian Etch (EOLed): 7.1.2
Debian Lenny: 8.2.7
Debian Squeeze: 8.4.4
Debian Sid: 8.4.4
Ubuntu Dapper (EOLed): 7.0.2
Ubuntu Hardy: 8.2.2
Ubuntu Intrepid: 8.2.6
Ubuntu Jaunty: 8.2.7
Ubuntu Karmic: 8.4.4
Fedora 9 (EOLed): 8.2.5
Fedora 10: 8.2.5
Fedora 11: 8.2.5
Fedora rawhide: 8.2.5
Fedora Koji (12): 8.4.5
Redhat EL4 extras: 7.0.2
Redhat EL5 extras: 8.1.0
OpenSUSE 10: 8.2.1
OpenSUSE 11: 8.2.7
OpenSUSE factory: 8.4.5
OpenBSD 4.3: 8.2.5
OpenBSD 4.4: 8.2.6
OpenBSD 4.5: 8.2.7

Current mainstream versions of docbook-xsl are:
Debian Etch (EOLed): 1.71.0
Debian Lenny: 1.73.2
Debian Squeeze: 1.75.2
Debian Sid: 1.75.2
Ubuntu Dapper (EOLed): 1.68.1
Ubuntu Hardy: 1.73.2
Ubuntu Intrepid: 1.73.2
Ubuntu Jaunty: 1.73.2
Ubuntu Karmic: 1.75.1
Fedora 9 (EOLed): 1.73.2
Fedora 10: 1.74.0
Fedora 11: 1.74.3
Fedora rawhide: 1.75.2
Fedora Koji (12): 1.75.2
Redhat EL4: 1.65.1
OpenSUSE 11: 1.74.0
OpenSUSE factory: 1.75.2
OpenBSD 4.3: 1.68
OpenBSD 4.4: 1.68
OpenBSD 4.5: 1.68

>From Documentation/Makefile:

#
# For asciidoc ...
#       -7.1.2, no extra settings are needed.
#       8.0-,   set ASCIIDOC8.
#

#
# For docbook-xsl ...
#       -1.68.1,        set ASCIIDOC_NO_ROFF? (based on changelog from
1.73.0)
#       1.69.0,         no extra settings are needed?
#       1.69.1-1.71.0,  set DOCBOOK_SUPPRESS_SP?
#       1.71.1,         no extra settings are needed?
#       1.72.0,         set DOCBOOK_XSL_172.
#       1.73.0-,        set ASCIIDOC_NO_ROFF
#

#
# If you had been using DOCBOOK_XSL_172 in an attempt to get rid
# of 'the ".ft C" problem' in your generated manpages, and you
# instead ended up with weird characters around callouts, try
# using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
#
