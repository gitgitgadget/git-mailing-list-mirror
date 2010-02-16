From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] Refactoring: remove duplicated code from
 builtin-send-pack.c and transport.c
Date: Tue, 16 Feb 2010 02:29:58 -0500
Message-ID: <20100216072958.GH2169@coredump.intra.peff.net>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
 <1266276411-5796-2-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 08:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHsp-0004Bh-AV
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 08:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670Ab0BPHaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 02:30:00 -0500
Received: from peff.net ([208.65.91.99]:50071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657Ab0BPH37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 02:29:59 -0500
Received: (qmail 30283 invoked by uid 107); 16 Feb 2010 07:30:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 02:30:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 02:29:58 -0500
Content-Disposition: inline
In-Reply-To: <1266276411-5796-2-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140081>

On Mon, Feb 15, 2010 at 11:26:47PM +0000, Michael Lukashov wrote:

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 8654fa7..d3b9d8a 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> [...]
> @@ -224,7 +224,7 @@ static int update_local_ref(struct ref *ref,
>  
>  	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
>  		if (verbosity > 0)
> -			sprintf(display, "= %-*s %-*s -> %s", SUMMARY_WIDTH,
> +			sprintf(display, "= %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
>  				"[up to date]", REFCOL_WIDTH, remote,
>  				pretty_ref);

If you are refactoring, can all of these fetch lines just call
print_ref_status, which handles the summary width stuff itself? The push
and fetch formats are meant to be quite similar.

-Peff
