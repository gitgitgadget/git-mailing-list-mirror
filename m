From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff hunk header regex.
Date: Sat, 23 Mar 2013 00:38:37 +0000 (UTC)
Message-ID: <loom.20130323T011153-345@post.gmane.org>
References: <loom.20130322T144107-601@post.gmane.org> <7vehf78olw.fsf@alter.siamese.dyndns.org> <514CD34F.70107@kdbg.org> <7vhak35ami.fsf@alter.siamese.dyndns.org> <514CE53F.3080308@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 01:39:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJCUT-0004zL-U8
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 01:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701Ab3CWAiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 20:38:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:44815 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933549Ab3CWAiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 20:38:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UJCUM-0004xA-66
	for git@vger.kernel.org; Sat, 23 Mar 2013 01:39:14 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 01:39:14 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 01:39:14 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218871>

Johannes Sixt <j6t <at> kdbg.org> writes:

> > I also wonder if 
> > 
> > 	label :
> > 
> > should also be caught, or is it too weird format to be worth
> > supporting?
> 
> It's easy to support, by inserting another [ \t] before the first colon.
> So, why not?

 This is really nitpicking, but if we do it, then it should be "[ \t]*". And the
"*" after the label should actually be a "+". So the full line becomes


  "!^[ \t]*[A-Za-z_][A-Za-z_0-9]+[ \t]*:([^:]|$)\n"


 But then I've never actually seen git putting labels incorrectly into the hunk
headers while I did see the problem this patch tries to fix, with wrong method
appearing in the header because the correct one was skipped due to this ignore
regex, quite a few times in the past.

 Regards,
VZ
