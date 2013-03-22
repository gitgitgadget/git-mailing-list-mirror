From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Re: [PATCH] Avoid false positives in label detection in cpp diff hunk header regex.
Date: Fri, 22 Mar 2013 17:27:41 +0000 (UTC)
Message-ID: <loom.20130322T182517-342@post.gmane.org>
References: <loom.20130322T144107-601@post.gmane.org> <7vehf78olw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 18:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5lX-0007Xs-AP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709Ab3CVR16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:27:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:32775 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422677Ab3CVR15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:27:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UJ5lK-0007Kz-4y
	for git@vger.kernel.org; Fri, 22 Mar 2013 18:28:18 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 18:28:18 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 18:28:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218824>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Vadim Zeitlin <vz-git <at> zeitlins.org> writes:
... 
> > diff --git a/userdiff.c b/userdiff.c
> > index ea43a03..9415586 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -125,7 +125,7 @@ PATTERNS("tex",
> > "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> >          "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
> >  PATTERNS("cpp",
> >          /* Jump targets or access declarations */
> > -        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
> > +        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"
> 
> Hmm.  Wouldn't "find a word (possibly after indentation), colon and
> then either a non-colon or end of line" be sufficient and simpler?
> iow, something like...
> 
>        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:]|$)"

 This works too, of course. I didn't know why did the original regex
contain ".*$" part so I decided to keep it but your version is indeed
how I would have written it myself if I were doing it from scratch.

 Should I resubmit an updated patch or could you please just apply
your version?

 TIA!
VZ
