From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 23:06:00 +0000
Message-ID: <20130212230600.GB22779@river>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 00:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Ovu-00081D-UM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab3BLXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:06:15 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:35438 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab3BLXGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:06:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A9FE3CDA330;
	Tue, 12 Feb 2013 23:06:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WC5QYYrR9Gs7; Tue, 12 Feb 2013 23:06:14 +0000 (GMT)
Received: from river (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 14D2DCDA5E3;
	Tue, 12 Feb 2013 23:06:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216217>

On Tue, Feb 12, 2013 at 02:57:25PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I _think_ exporting mandir/html/infodir from the top-level Makefile
> > is wrong to begin with.  We should drop the "export mandir" from
> > there.
> 
> Ah, it is this thing, isn't it?
> 
> commit d8cf908cb6012cd4dc3d1089a849daf646150c2e
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sat Feb 2 17:58:49 2013 -0800
> 
>     config.mak.in: remove unused definitions
>     
>     When 5566771 (autoconf: Use autoconf to write installation
>     directories to config.mak.autogen, 2006-07-03) introduced support
>     for autoconf generated config.mak file, it added an "export" for a
>     few common makefile variables, in addition to definitions of srcdir
>     and VPATH.
>     
>     The "export" logically does not belong there.  The make variables
>     like mandir, prefix, etc, should be exported to submakes for people
>     who use config.mak and people who use config.mak.autogen the same
>     way; if we want to get these exported, that should be in the main
>     Makefile.
>     
>     We do use mandir and htmldir in Documentation/Makefile, so let's
>     add export for them in the main Makefile instead.
>     
>     We may eventually want to support VPATH, and srcdir may turn out to
>     be useful for that purpose, but right now nobody uses it, so it is
>     useless to define them in this file.
>     
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks like it - I tried this for the first time today (with pu) so I
didn't realise it was a recent change, and I didn't think to blame the
export line.


John
