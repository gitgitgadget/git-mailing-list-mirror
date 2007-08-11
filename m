From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-bundle - use buffered reads for bundle header
Date: Fri, 10 Aug 2007 17:31:20 -0700
Message-ID: <7vk5s2rjxj.fsf@assigned-by-dhcp.cox.net>
References: <7vvebnq9nv.fsf@assigned-by-dhcp.cox.net>
	<11867920441883-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 02:31:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJet7-0002PE-HR
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 02:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762698AbXHKAbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 20:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762646AbXHKAbX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 20:31:23 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:51942 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760255AbXHKAbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 20:31:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811003121.BFVF2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 20:31:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aQXL1X00D1kojtg0000000; Fri, 10 Aug 2007 20:31:20 -0400
In-Reply-To: <11867920441883-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Fri, 10 Aug 2007 20:27:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55580>

Is this just me (I am writing this from an unfamiliar terminal),
or is your patch somehow breaks all indentation?

 /* returns an fd */
 static int read_header(const char *path, struct bundle_header *header) {
 	char buffer[1024];
-	int fd = open(path, O_RDONLY);
+	int fd;
+    long fpos;
+    FILE *ffd = fopen(path, "r");
