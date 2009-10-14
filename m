From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 01:08:51 -0400
Message-ID: <20091014050851.GE31810@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:11:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxw8x-00038c-5M
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbZJNFJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbZJNFJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:09:28 -0400
Received: from peff.net ([208.65.91.99]:41796 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZJNFJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:09:27 -0400
Received: (qmail 24587 invoked by uid 107); 14 Oct 2009 05:12:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 01:12:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 01:08:51 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130249>

On Wed, Oct 14, 2009 at 12:44:34AM -0400, Daniel Barkalow wrote:

> +char *get_detached_head_string(void)
> +{
> +	char *filename = git_path("DETACH_NAME");
> +	struct stat st;
> +	if (stat(filename, &st) || !S_ISREG(st.st_mode))
> +		return NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	strbuf_read_file(&buf, filename, st.st_size);
> +	strbuf_trim(&buf);
> +	return strbuf_detach(&buf, 0);
> +}

Would it hurt to tuck this information into HEAD itself, as we already
put arbitrary text into FETCH_HEAD?

-Peff
