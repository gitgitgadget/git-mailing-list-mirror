From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to the command invocation path
Date: Thu, 24 Jul 2008 21:24:13 +0200
Message-ID: <200807242124.14583.johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <200807232112.18352.johannes.sixt@telecom.at> <7vd4l37vz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6RJ-0004De-Bu
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbYGXTYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYGXTYT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:24:19 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:56497 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbYGXTYS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:24:18 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id BE63733CA2;
	Thu, 24 Jul 2008 21:24:15 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3807425F16;
	Thu, 24 Jul 2008 21:24:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vd4l37vz7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89949>

On Donnerstag, 24. Juli 2008, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > It also fixes 'make install' of git-gui as well (sigh!) by not exporting
> > gitexecdir - assuming that Shawn applies the git-gui patch.
>
> Yeah, this seems to break the install quite badly without git-gui patch.

If you squash this in, we don't need the git-gui patch.

-- Hannes

diff --git a/Makefile b/Makefile
index aab23a2..904150e 100644
--- a/Makefile
+++ b/Makefile
@@ -1344,7 +1344,7 @@ install: all
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
-	$(MAKE) -C git-gui install
+	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), 
$(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
