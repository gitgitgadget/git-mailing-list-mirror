From: <Patrick.Higgins@cexp.com>
Subject: RE: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Thu, 12 Jun 2008 16:44:03 -0600
Message-ID: <911589C97062424796D53B625CEC0025E46159@USCOBRMFA-SE-70.northamerica.cexp.com>
References: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>, <tytso@mit.edu>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 01:05:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6vrY-0000Vc-8i
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbYFLXEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbYFLXEp
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:04:45 -0400
Received: from mx02.cexp.com ([170.131.136.83]:44019 "EHLO mx02.cexp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875AbYFLXEp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 19:04:45 -0400
X-Greylist: delayed 1240 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jun 2008 19:04:45 EDT
Received: from mailgate2.cexp.com (uscobrmfa-se-07.cexp.com [170.131.144.37])
	by mx02.cexp.com (Postfix) with ESMTP id 038FF1E4C0A
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 16:44:05 -0600 (MDT)
Received: from USCOBRMFA-SE-70.northamerica.cexp.com ([10.128.26.35]) by USCOBRMFA-SE-51.northamerica.cexp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jun 2008 16:44:04 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Added mergetool.kdiff3.doubledash config option
Thread-Index: AcjMzGqkBRoy6JNwRa+TomJcw3MjwQADPbCQ
X-OriginalArrivalTime: 12 Jun 2008 22:44:04.0621 (UTC) FILETIME=[D0FE13D0:01C8CCDD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84809>

From: Junio C Hamano [mailto:gitster@pobox.com]

> Patrick Higgins <patrick.higgins@cexp.com> writes:
> 
> > +mergetool.kdiff3.doubledash::
> > +	A boolean to indicate whether or not your kdiff3 supports a '--'
> > +	on the command line to separate options from filenames. If you
> > +	built it without KDE, it probably doesn't have this support and
> > +	you	should set this to false.  Defaults to true.
> 
> The above description makes it clear that there is an issue 
> that needs to
> be addressed.  I however am wondering if this can be either 
> autodetected
> at runtime, or if it can't, the user should be able to 
> specify the option
> when the user runs mergetool from the command line.  It would 
> be necessary
> to countermand whichever choice you configured in your config when you
> need to run kdiff3 with KDE from one machine and the one without from
> another machine, wouldn't it?

I have found the following to be a way to distinguish the two versions based solely on exit status. The broken one exits with 255.

kdiff3 --auto -o /dev/null -- /dev/null /dev/null

I'll work up another patch that uses this. This check adds about 0.5s overhead. That seems a little high to me, but given that mergetool is interactive, I guess that could be acceptable.
