From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] allow a single form feed in pre commit hook
Date: Tue, 18 Dec 2007 02:27:52 -0800 (PST)
Message-ID: <m3prx4paam.fsf@roke.D-201>
References: <5d2716640712180147x36aa3178ja8658e30842c4e52@mail.gmail.com>
	<7v4peg1f33.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Hannes Eder" <hannes.eder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 11:28:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ZgS-0000PP-Ol
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 11:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbXLRK15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbXLRK15
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:27:57 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:15169 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbXLRK14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:27:56 -0500
Received: by mu-out-0910.google.com with SMTP id i10so3392920mue.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 02:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=bKLqZgzmZfrc3urLa5gjMs+efXQnzaEp1dtrCmg33P0=;
        b=Wn8Fa3S2aDVSF1x6iOB912YGffHc3VksXmXJ2m1u75URQk7tQE+hRrQ4tto4QNg6ftj/ULdXv/lOFZUwcsFw3KUeUMsd5+Pq3pwLjhhiaPLH8+xYdUIyXcJzBimBMUYKBgpe0IQeUIrqQa8oAKKlrKyYpxXv/qDPGZPk6Ot3O4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=pHKZuudlWjugEuuvwzO73dgXI/Opaei0bZDeyGXE4KTfNuNdx3IHupI84XE01NhanyJTBWP1bzBFqhaS0gA3JSlvjRN/E6bpuFXU11P0CJ3hNvVvs1vgl6txitR7REByd+SI3uW7H0zWvBr+ESZw7jO2S6vgbZtF3HtCSp+GUxs=
Received: by 10.86.36.11 with SMTP id j11mr7483415fgj.34.1197973674324;
        Tue, 18 Dec 2007 02:27:54 -0800 (PST)
Received: from roke.D-201 ( [83.8.255.201])
        by mx.google.com with ESMTPS id 4sm3617569fge.2007.12.18.02.27.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 02:27:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBIARmTb011504;
	Tue, 18 Dec 2007 11:27:48 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBIARkvD011500;
	Tue, 18 Dec 2007 11:27:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7v4peg1f33.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68726>

Junio C Hamano <gitster@pobox.com> writes:

> "Hannes Eder" <hannes.eder@gmail.com> writes:
> 
> > It's not uncommon to have a lines with a single form feed in it, e.g.
> > the default GPL COPYING and also in .c files and others. Attached
> > patch allows this in the pre-commit hook.
> 
> Hmm.  The current trend is to get rid of the whitespace checks from this
> hook and enrich git-diff --check and git-apply --whitespace=error.
> 
> I've been planning to add a new whitespace error rule that allows ^M at
> the end of line, post 1.5.4.  Another rule that allows a lone ^L would
> match what you are doing here, and it would be a good addition as well.
 
There probably should also be 'trailing-empty-lines' rule; also
'eol-at-eof' could be useful as well (ensuring that final line ends
with newline character).

By the way, the check in pre-commit hook also checks for merge
conflict markers.  Those are not whitespace errors, but are quite
similar.  It would be nice to have this also .gitattributes
controlled, to avoid false positoves for changes in
Documentation/*.txt; althought perhaps more strict checking would be
enough...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
