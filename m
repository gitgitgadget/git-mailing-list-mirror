From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Fixed non-literal format in printf-style calls
Date: Mon, 10 Nov 2008 13:47:55 -0600
Message-ID: <3t9bmcAj9kThyafdZ9mPENosknipZInn9Qq9u9oVuN7X7qwiI4GqZg@cipher.nrlssc.navy.mil>
References: <1226344517-16120-1-git-send-email-dlowe@bitmuse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Lowe <dlowe@bitmuse.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzclJ-0005Pt-Ci
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYKJTsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbYKJTsI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:48:08 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57264 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYKJTsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 14:48:07 -0500
Received: by mail.nrlssc.navy.mil id mAAJlueQ019132; Mon, 10 Nov 2008 13:47:56 -0600
In-Reply-To: <1226344517-16120-1-git-send-email-dlowe@bitmuse.com>
X-OriginalArrivalTime: 10 Nov 2008 19:47:56.0126 (UTC) FILETIME=[3A0DF7E0:01C9436D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100552>

Daniel Lowe wrote:

<snip>

>  }
> diff --git a/grep.c b/grep.c
> index e2c190a..1db60d9 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -514,7 +514,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
>  				if (from <= last_shown)
>  					from = last_shown + 1;
>  				if (last_shown && from != last_shown + 1)
> -					printf(hunk_mark);
> +					printf("%s", hunk_mark);

Perhaps these should by changed to use fputs() instead.

<snip>

> diff --git a/path.c b/path.c
> index eb24017..ae2c724 100644
> --- a/path.c
> +++ b/path.c
> @@ -41,7 +41,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
>  	len = vsnprintf(buf, n, fmt, args);
>  	va_end(args);
>  	if (len >= n) {
> -		snprintf(buf, n, bad_path);
> +		snprintf(buf, n, "%s", bad_path);

and these should use strlcpy.

-brandon
