From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Tue, 22 Jan 2013 23:45:54 +0000
Message-ID: <20130122234554.GI7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 00:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxnY1-0001eO-Az
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 00:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab3AVXqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 18:46:12 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:55884 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3AVXqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 18:46:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 72E25CDA5BF;
	Tue, 22 Jan 2013 23:46:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13b9oU0+mANO; Tue, 22 Jan 2013 23:46:10 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id E77EACDA5B8;
	Tue, 22 Jan 2013 23:46:09 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D726D161E5D5;
	Tue, 22 Jan 2013 23:46:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c3JEZiugY6ZH; Tue, 22 Jan 2013 23:46:08 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5D98A161E5BB;
	Tue, 22 Jan 2013 23:45:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214262>

On Tue, Jan 22, 2013 at 02:44:48PM -0800, Junio C Hamano wrote:
> * jc/cvsimport-upgrade (2013-01-14) 8 commits
>  - t9600: adjust for new cvsimport
>  - t9600: further prepare for sharing
>  - cvsimport-3: add a sample test
>  - cvsimport: make tests reusable for cvsimport-3
>  - cvsimport: start adding cvsps 3.x support
>  - cvsimport: introduce a version-switch wrapper
>  - cvsimport: allow setting a custom cvsps (2.x) program name
>  - Makefile: add description on PERL/PYTHON_PATH
> 
>  The most important part of this series is the addition of the new
>  cvsimport by Eric Raymond that works with cvsps 3.x.  Given some
>  distros have inertia to be conservative, Git with cvsimport that
>  does not work with both 3.x will block adoption of cvsps 3.x by
>  them, and shipping Git with cvsimport that does not work with cvsps
>  2.x will block such a version of Git, so we'll do the proven "both
>  old and new are available, but we aim to deprecate and remove the
>  old one in due time" strategy that we used successfully in the
>  past.
> 
>  Will merge to 'next'.

Would you mind holding off on this?  As it stands there are a couple of
issues with the cvsimport-3 script including:

    * It doesn't read any configuration from "git config" as
      git-cvsimport-2 does.

    * Incremental import is copmletely broken - it needs to pass "-i" to
      cvsps-3 and even then timestamp handling is completely broken.

I have fixes for these that are nearly ready, but to fully fix the
incremental import issue I'll need to persuade ESR to take a patch which
lets us feed cvsps-3 a mapping from branch names to last commit times.

I suspect people are already used to the ways in which cvsimport-2 is
broken so I think we should take a bit more time to get this right with
cvsimport-3, especially since the people most likely to be using this
will be those regularly updating from a CVS repository with incremental
updates.


John
