From: Jeff King <peff@peff.net>
Subject: Re: BUG: mergetool fails on gitignore:d files
Date: Sun, 31 May 2009 22:03:50 -0400
Message-ID: <20090601020349.GA32740@coredump.intra.peff.net>
References: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com> <20090530215418.GA19241@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 04:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAwsr-0003aE-Q0
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 04:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbZFACD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 22:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbZFACD5
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 22:03:57 -0400
Received: from peff.net ([208.65.91.99]:46108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549AbZFACD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 22:03:56 -0400
Received: (qmail 7000 invoked by uid 107); 1 Jun 2009 02:04:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 31 May 2009 22:04:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 31 May 2009 22:03:50 -0400
Content-Disposition: inline
In-Reply-To: <20090530215418.GA19241@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120440>

On Sat, May 30, 2009 at 05:54:18PM -0400, Jeff King wrote:

> diff --git a/dir.c b/dir.c
> index 0e6b752..bbfcb56 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -396,7 +396,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
>  
>  static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
>  {
> -	if (cache_name_pos(pathname, len) >= 0)
> +	if (!cache_name_is_other(pathname, len))
>  		return NULL;
>  
>  	ALLOC_GROW(dir->ignored, dir->ignored_nr+1, dir->ignored_alloc);

I was all set to write a test for this and re-submit, but you seem to
have beat me to it. Thanks. :)

-Peff
