From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Tue, 18 Sep 2007 14:58:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181453220.28586@racer.site>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com> <11900740142347-git-send-email-krh@redhat.com>
 <11900740153845-git-send-email-krh@redhat.com> <11900740154136-git-send-email-krh@redhat.com>
 <1190074016669-git-send-email-krh@redhat.com> <11900740163661-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXdbu-0000N6-LF
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXIRN7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbXIRN7V
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:59:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:38729 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753753AbXIRN7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:59:20 -0400
Received: (qmail invoked by alias); 18 Sep 2007 13:59:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 18 Sep 2007 15:59:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YfJkTjb1YQCyAVsCmeJqIdgv1uzF6dv5JQbM/mC
	uKdX6bcc8sYMwa
X-X-Sender: gene099@racer.site
In-Reply-To: <11900740163661-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58610>

Hi,

very nice!

Four nits, though, and a half:

- it would be nicer to put the option parsing it option.[ch] (you would 
  also need to pass the usage line then, instead of hardwiring it to 
  "git_commit_usage"),

- it seems more logical to me to call it "parse_option()" than 
  "scan_options()", since that is what it does,

- you might want to rename OPTION_NONE to OPTION_BOOLEAN, and maybe even 
  allow "--no-<option>" in that case for free,

- wt_status_prepare() could take a parameter "index_file", which would 
  default to git_path("index") when passed as NULL, and

- launch_editor() is defined in builtin-tag.c, which is not part of the 
  library, and therefore it would be technically more correct to either 
  move the function to editor.c (my preferred solution), or declare it in 
  builtin.h instead of strbuf.h.

As you can see, my nits are really minor, which means that I am pretty 
happy with your work!

Thanks,
Dscho
