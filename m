From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 16:14:54 +0200
Message-ID: <86wsluuyht.fsf@lola.quinscape.zz>
References: <482BE5F7.2050108@thorn.ws>
	<alpine.DEB.1.00.0805161148010.30431@racer>
	<alpine.DEB.1.00.0805161403130.30431@racer>
	<200805161539.29259.brian.foster@innova-card.com>
	<a537dd660805160707y3830b164td0605a15e6ae05a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 16:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0j7-0004rH-Vo
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbYEPOPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754521AbYEPOPM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:15:12 -0400
Received: from main.gmane.org ([80.91.229.2]:33099 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbYEPOPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:15:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jx0i6-0005dQ-OE
	for git@vger.kernel.org; Fri, 16 May 2008 14:15:03 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:15:02 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 May 2008 14:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:wcN9DIWEuOUWV2W7C8T7kcDIoTM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82293>

"Brian Foster" <brian.foster@innova-card.com> writes:

>  I'd tend to write this in terms of pointers,
>  something along the lines (untested):
>
> 	char	*p, *endp;
>
> 	assert(1 <= size);
> 	p    = buf;
> 	endp = p + (size-1);
> 	while (p < endp) {
> 		if ((c = getc(in)) == EOF || (*p++ = c) == '\n')
> 			break;
> 	}
> 	*p = '\0';
>
> 	return p - buf;

Leave optimization to the compiler.  Using pointer arithmetic more often
than not screws up loop optimization and strength reduction.

-- 
David Kastrup
