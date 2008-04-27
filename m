From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document functions xmemdupz(), xread() and xwrite()
Date: Sat, 26 Apr 2008 23:12:04 -0700
Message-ID: <7viqy3j07f.fsf@gitster.siamese.dyndns.org>
References: <20080424235823.GA22898@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:13:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq08I-000136-9u
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYD0GMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbYD0GMR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:12:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYD0GMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:12:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B4FFA4EE3;
	Sun, 27 Apr 2008 02:12:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 350FD4EE2; Sun, 27 Apr 2008 02:12:11 -0400 (EDT)
In-Reply-To: <20080424235823.GA22898@zakalwe.fi> (Heikki Orsila's message of
 "Fri, 25 Apr 2008 02:58:23 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80416>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
>  git-compat-util.h |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a18235e..7498bee 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -268,6 +268,12 @@ static inline void *xmalloc(size_t size)
>  	return ret;
>  }
>  
> +/*
> + * xmemdupz() allocates (len + 1) bytes of memory, duplicates "len" bytes of
> + * "data" to the allocated memory, zero terminates the allocated memory,
> + * and returns a pointer to the allocated memory. If the allocation fails,
> + * the program dies.
> + */

Ok.

>  static inline void *xmemdupz(const void *data, size_t len)
>  {
>  	char *p = xmalloc(len + 1);
> @@ -329,6 +335,11 @@ static inline void *xmmap(void *start, size_t length,
>  	return ret;
>  }
>  
> +/*
> + * xread() is the same a read(), but it automatically restarts read()
> + * operations with a recoverable error (EAGAIN and EINTR). xread()
> + * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
> + */

Ok.

>  static inline ssize_t xread(int fd, void *buf, size_t len)
>  {
>  	ssize_t nr;
> @@ -340,6 +351,9 @@ static inline ssize_t xread(int fd, void *buf, size_t len)
>  	}
>  }
>  
> +/*
> + * xwrite() is similar to xread()
> + */

Well, up to "how recoverable errors are handled" they may be similar but
would the last sentence apply to it as well, or does it need rewording?

>  static inline ssize_t xwrite(int fd, const void *buf, size_t len)
>  {
>  	ssize_t nr;
> -- 
> 1.5.4.4
