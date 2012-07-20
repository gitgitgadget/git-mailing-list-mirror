From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH] Only call record_resolve_undo() when coming from add/rm
Date: Sat, 21 Jul 2012 00:22:51 +0200
Message-ID: <87liievzr8.fsf@thomas.inf.ethz.ch>
References: <e0e9ce3599d898c974c56c818d9858638e343f5b.1342819276.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 21 00:23:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsLbA-0004ex-2Y
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 00:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab2GTWWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 18:22:55 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:19341 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2GTWWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 18:22:54 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 21 Jul
 2012 00:22:52 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 21 Jul
 2012 00:22:51 +0200
In-Reply-To: <e0e9ce3599d898c974c56c818d9858638e343f5b.1342819276.git.trast@student.ethz.ch>
	(Thomas Rast's message of "Fri, 20 Jul 2012 23:28:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201795>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas and me discovered this while hacking on index-v5.  It would be
> a bit tricky to handle there: the index is structured according to the
> directory layout of the files it contains, and the REUC data is the
> same as the conflict (stages) data plus a flag bit, for (future)
> easier toggling between them.  With the behavior before this patch, it
> is possible to have directories that do not have any "live" files, yet
> contain REUC records.  For example, in git.git,
>
>   $ git checkout 8e17b34c33^1
>   $ git merge 8e17b34c33^2
>   $ g ls-files -s | grep arpa
>   $ g ls-files --resolve-undo | grep arpa
>   100644 0d8552a2c6dc3a5fee5360ea2ff468463461e3bf 1       compat/vcbuild/include/arpa/inet.h
>   100644 0d8552a2c6dc3a5fee5360ea2ff468463461e3bf 3       compat/vcbuild/include/arpa/inet.h

We just discovered that this merge is no longer in current git.git.  It
went into master as b7f7c079, and the example works with that.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
