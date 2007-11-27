From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 11:18:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711271115300.27959@racer.site>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyT2-0004c7-NF
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbXK0LSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbXK0LSp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:18:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:56318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753836AbXK0LSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:18:44 -0500
Received: (qmail invoked by alias); 27 Nov 2007 11:18:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 27 Nov 2007 12:18:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hnyYGmU1hbxqA3Op+hAUS5jbVuty0hiv+CNdccc
	hCwW/FeQUrjljj
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66187>

Hi,

[commenting on the patch is a little cumbersome when the mailer does not 
quote it for you...]

On Tue, 27 Nov 2007, Alex Riesen wrote:

@@ -550,6 +557,8 @@ static int parse_and_validate_options(int argc, const char *argv[])
                        free(enc);
        }

+       if (all)
+               cached_only = 0;
        if (!!also + !!only + !!all + !!interactive > 1)
                die("Only one of --include/--only/--all/--interactive can be used.");
        if (argc == 0 && (also || (only && !amend)))



My reply> I would rather add another !!cached_only to the existing if().



@@ -678,7 +688,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
        }

        if (!prepare_log_message(index_file, prefix) && !in_merge) {
-               run_status(stdout, index_file, prefix);
+               if (!cached_only)
+                       run_status(stdout, index_file, prefix);
                rollback_index_files();
                unlink(commit_editmsg);
                return 1;


My reply> Would it not make more sense to avoid run_status() when no_edit?

My reply> Ciao,
My reply> Dscho
