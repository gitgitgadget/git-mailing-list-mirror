From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Silence $(CC) command line when compiling test tools
Date: Tue, 29 May 2007 22:48:11 -0700
Message-ID: <7vps4i50bo.fsf@assigned-by-dhcp.cox.net>
References: <20070530031123.GA12044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 07:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtH2i-0005eU-9o
	for gcvg-git@gmane.org; Wed, 30 May 2007 07:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1749667AbXE3FsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 01:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbXE3FsN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 01:48:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38296 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbXE3FsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 01:48:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530054814.KPKQ15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 01:48:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5HoC1X0081kojtg0000000; Wed, 30 May 2007 01:48:12 -0400
In-Reply-To: <20070530031123.GA12044@spearce.org> (Shawn O. Pearce's message
	of "Tue, 29 May 2007 23:11:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48739>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Like our other $(CC) rules in the Makefile we typically build with
> $(QUIET_CC) in front of $(CC) so that we hide the compiler options.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  Makefile |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3680b09..25c3f37 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -956,25 +956,25 @@ test: all
>  	$(MAKE) -C t/ all
>  
>  test-date$X: test-date.c date.o ctype.o
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
>  
>  test-delta$X: test-delta.o diff-delta.o patch-delta.o $(GITLIBS)
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
>  test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
>  test-sha1$X: test-sha1.o $(GITLIBS)
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
>  test-match-trees$X: test-match-trees.o $(GITLIBS)
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
>  test-chmtime$X: test-chmtime.c
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
>  
>  test-genrandom$X: test-genrandom.c
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
> +	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
>  
>  check-sha1:: test-sha1$X
>  	./test-sha1.sh

Hmmm.  One wonders if we can do something about these apparent
similarities with all these rules...
