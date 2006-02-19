From: linux@horizon.com
Subject: Re: [PATCH] git-rev-list --help anywhere
Date: 19 Feb 2006 06:26:27 -0500
Message-ID: <20060219112627.18989.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 12:26:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAmiA-0005La-3v
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 12:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBSL0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 06:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWBSL0d
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 06:26:33 -0500
Received: from science.horizon.com ([192.35.100.1]:10795 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932398AbWBSL0c
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 06:26:32 -0500
Received: (qmail 18990 invoked by uid 1000); 19 Feb 2006 06:26:27 -0500
To: raa.lkml@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16431>

>+	for (i = 1 ; i < argc; i++)
>+	    if ( !strcmp(argv[i], "--help") )
>+		usage(rev_list_usage);

You might want to try something more like:

+	for (i = 1 ; i < argc; i++) {
+	    if ( !strcmp(argv[i], "--help") )
+		usage(rev_list_usage);
+	    if ( !strcmp(argv[i], "--") )
+		break;
+	}

So that you don't break in the perverse but legal case of
having a file named "--help".
