From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/5] make "git unpack-file" a built-in
Date: Fri, 22 Jan 2010 10:26:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001221022121.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain> <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain> <alpine.LFD.2.00.1001220826230.13231@localhost.localdomain>
 <7vmy06vwvy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 19:32:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYOIr-00070n-CN
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 19:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab0AVScM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049Ab0AVScM
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 13:32:12 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38044 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755881Ab0AVScL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 13:32:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MIQCiU027909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 10:26:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MIQCl4020479;
	Fri, 22 Jan 2010 10:26:12 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vmy06vwvy.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137771>



On Fri, 22 Jan 2010, Junio C Hamano wrote:
> >  {
> >  	unsigned char sha1[20];
> >  
> > -	git_extract_argv0_path(argv[0]);
> > -
> >  	if (argc != 2 || !strcmp(argv[1], "-h"))
> >  		usage("git unpack-file <sha1>");
> >  	if (get_sha1(argv[1], sha1))
> >  		die("Not a valid object name %s", argv[1]);
> >  
> > -	setup_git_directory();
> 
> This will now require "git unpack-file -h" to be run in a git controlled
> directory, so strictly speaking it changes behaviour.
> 
> Not that anybody would care that much, though.

Heh. You didn't notice the same change in the merge-tree conversion that 
you already accepted ;)

Yeah, any usage messages will now run after setup for the commands that do 
the whole RUN_SETUP thing. That's pack-redundant, unpack-file, mktag, 
merge-index and merge-tree. So they'll now report "Not a git repository" 
before they report invalid arguments.

			Linus
