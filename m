From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Documentation: Add version information to man pages
Date: Mon, 26 Mar 2007 23:55:48 -0700
Message-ID: <7vtzw7qiob.fsf@assigned-by-dhcp.cox.net>
References: <7vircqe389.fsf@assigned-by-dhcp.cox.net>
	<11748238102228-git-send-email-frank@lichtenheld.de>
	<117482381140-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5b4-0001UJ-7P
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXC0Gzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbXC0Gzu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:55:50 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:65476 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXC0Gzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:55:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327065549.VAKF1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 02:55:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fivo1W00V1kojtg0000000; Tue, 27 Mar 2007 02:55:49 -0400
In-Reply-To: <117482381140-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sun, 25 Mar 2007 13:56:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43236>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Override the [header] macro of asciidoc's docbook
> backend to add version information to the generated
> man pages.
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>

This breaks documents other than manpages by making everybody
unconditionally use the header you stole for doctype-manpage.

I needed this to unbreak it.

-- >8 --
[PATCH] Documentation: unbreak user-manual.

The previous one broke generated xml files for anything but manpages,
as it took the header for manpage unconditionally.  This fixes it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/asciidoc.conf |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index a86c31d..fa7dc94 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -31,6 +31,7 @@ ifdef::backend-docbook[]
 {title#}</example>
 endif::backend-docbook[]
 
+ifdef::doctype-manpage[]
 ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
@@ -47,6 +48,7 @@ template::[header-declarations]
   <refpurpose>{manpurpose}</refpurpose>
 </refnamediv>
 endif::backend-docbook[]
+endif::doctype-manpage[]
 
 ifdef::backend-xhtml11[]
 [gitlink-inlinemacro]
-- 
1.5.1.rc2.620.g9a7ad
