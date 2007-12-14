From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] provide advance warning of some future pack default changes
Date: Thu, 13 Dec 2007 22:32:36 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
 <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 04:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J31IL-0007ie-5G
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 04:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbXLNDci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 22:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbXLNDci
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 22:32:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32676 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbXLNDch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 22:32:37 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT00034YSI96X01@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Dec 2007 22:32:34 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68216>


Signed-off-by: Nicolas Pitre <nico@cam.org>

---

On Mon, 3 Dec 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Two things I would like to see in the next version (1.5.5) as well, for 
> > which we could provide early warnings now:
> >
> >  - repack.usedeltabaseoffset defaulting to true
> >
> >  - pack.indexversion defaulting to 2
> 
> I think the former would be sensible, the latter I fear might be a bit
> too new but I do not recall the exact version dependency.
> 
> Could you draft a patch to ReleaseNotes to explain the consequences of
> these changes using ordinary user's vocabulary, like:
> 
> 	Starting v1.5.5, repack.usedeltabaseoffset will default to true,
> 	which will give denser packfile (i.e. more efficient storage).
> 	The downside is that git older than version X will not be able
> 	to use a repository packed using this setting.

Here it is.

diff --git a/Documentation/RelNotes-1.5.4.txt b/Documentation/RelNotes-1.5.4.txt
index 6645565..d6fd3dd 100644
--- a/Documentation/RelNotes-1.5.4.txt
+++ b/Documentation/RelNotes-1.5.4.txt
@@ -43,6 +43,17 @@ Deprecation notices
  * "git peek-remote" is deprecated, as "git ls-remote" was written in C
    and works for all transports, and will be removed in the future.
 
+ * From v1.5.5, the repack.usedeltabaseoffset config option will default
+   to true, which will give denser packfile (i.e. more efficient storage).
+   The downside is that git older than version 1.4.4 will not be able
+   to directly use a repository packed using this setting.
+
+ * From v1.5.5, the pack.indexversion config option will default to 2,
+   which is slightly more efficient, and makes repacking more immune to
+   data corruptions.  Git older than version 1.5.2 may revert to version 1
+   of the pack index with a manual "git index-pack" to be able to directly
+   access corresponding pack files.
+
 
 Updates since v1.5.3
 --------------------
