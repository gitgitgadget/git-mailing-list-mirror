From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] Small code readability improvement in
	show_reference() in builtin-tag.c
Date: Wed, 7 Nov 2007 22:51:21 +0100
Organization: glandium.org
Message-ID: <20071107215121.GA30248@glandium.org>
References: <Pine.LNX.4.64.0711031219530.4362@racer.site> <1194095285-18651-1-git-send-email-mh@glandium.org> <1194095285-18651-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 22:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpspJ-0003lA-HA
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbXKGVwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbXKGVw3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:52:29 -0500
Received: from vawad.err.no ([85.19.200.177]:47562 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755065AbXKGVw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:52:29 -0500
Received: from aputeaux-153-1-97-76.w86-217.abo.wanadoo.fr ([86.217.119.76] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1Ipsos-0000Mu-OK; Wed, 07 Nov 2007 22:52:21 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1Ipsny-0007tm-1p; Wed, 07 Nov 2007 22:51:22 +0100
Content-Disposition: inline
In-Reply-To: <1194095285-18651-2-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63868>

I think this patch got lost with my bad behaviour of sending another
series of patch not including this one.

Cheers,

Mike

On Sat, Nov 03, 2007 at 02:08:05PM +0100, Mike Hommey wrote:
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  builtin-tag.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin-tag.c b/builtin-tag.c
> index e57f57f..3ed5759 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -84,14 +84,13 @@ static int show_reference(const char *refname, const unsigned char *sha1,
>  		sp = buf = read_sha1_file(sha1, &type, &size);
>  		if (!buf)
>  			return 0;
> -		if (!size) {
> +		/* skip header */
> +		sp = strstr(buf, "\n\n");
> +
> +		if (!sp || !size) {
>  			free(buf);
>  			return 0;
>  		}
> -		/* skip header */
> -		while (sp + 1 < buf + size &&
> -				!(sp[0] == '\n' && sp[1] == '\n'))
> -			sp++;
>  		/* only take up to "lines" lines, and strip the signature */
>  		for (i = 0, sp += 2;
>  				i < filter->lines && sp < buf + size &&
> -- 
> 1.5.3.5
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
