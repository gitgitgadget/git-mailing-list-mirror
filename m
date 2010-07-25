From: Johan Herland <johan@herland.net>
Subject: Re: [WIP/RFC 09/13] git notes merge: Initial implementation handling
 trivial merges only
Date: Sun, 25 Jul 2010 16:14:31 +0200
Message-ID: <201007251614.32124.johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
 <1279880104-29796-10-git-send-email-johan@herland.net>
 <4C4AA500.7010205@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 16:14:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od1yV-0007LX-MF
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab0GYOOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 10:14:37 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58958 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab0GYOOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:14:37 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6400BEGA89W570@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 16:14:33 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id DBCA61EA550A_C4C46C8B	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 14:14:32 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C33EF1EA2E8D_C4C46C8F	for <git@vger.kernel.org>; Sun,
 25 Jul 2010 14:14:32 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L64005EJA88C010@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 25 Jul 2010 16:14:32 +0200 (MEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-ARCH; KDE/4.4.5; x86_64; ; )
In-reply-to: <4C4AA500.7010205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151744>

On Saturday 24 July 2010, Stephen Boyd wrote:
>   On 07/23/2010 03:15 AM, Johan Herland wrote:
> > +	if (1<  argc) {
> > +		error("too many parameters");
> > +		usage_with_options(git_notes_merge_usage, options);
> > +	} else if (1>  argc) {
> > +		error("too few parameters");
> > +		usage_with_options(git_notes_merge_usage, options);
> > +	}
> > +
> 
> Looks like it only takes one <notes_ref>. In that case wouldn't it be
> better to say
> 
>      if (argc != 1) {
>          error("Must specify a note ref to merge");
>          usage_with_options(git_notes_merge_usage, options)
>      }

Thanks. I'll squash the following into the next iteration:

...Johan

diff --git a/builtin/notes.c b/builtin/notes.c
index f2bc767..ca0e4d9 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -780,11 +780,8 @@ static int merge(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_merge_usage, 0);
 
-	if (1 < argc) {
-		error("too many parameters");
-		usage_with_options(git_notes_merge_usage, options);
-	} else if (1 > argc) {
-		error("too few parameters");
+	if (argc != 1) {
+		error("Must specify a notes ref to merge");
 		usage_with_options(git_notes_merge_usage, options);
 	}
 


-- 
Johan Herland, <johan@herland.net>
www.herland.net
