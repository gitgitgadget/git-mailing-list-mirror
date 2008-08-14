From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCHv2 1/2] Make xdi_diff_outf interface for running xdiff_outf diffs
Date: Thu, 14 Aug 2008 00:31:58 -0500
Message-ID: <20080814053156.GE4396@lavos.net>
References: <7viqu4gx8c.fsf@gitster.siamese.dyndns.org> <1218690802-30536-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:33:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVSU-0002OJ-PY
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYHNFcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 01:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbYHNFcM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:32:12 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:50536
	"EHLO QMTA03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757AbYHNFcL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 01:32:11 -0400
Received: from OMTA02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by QMTA03.westchester.pa.mail.comcast.net with comcast
	id 24Kt1a00q0QuhwU535Y86z; Thu, 14 Aug 2008 05:32:08 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA02.westchester.pa.mail.comcast.net with comcast
	id 25Y81a0044BqYqi3N5Y8WT; Thu, 14 Aug 2008 05:32:08 +0000
X-Authority-Analysis: v=1.0 c=1 a=tmmThHdVLlEA:10 a=I6cZIE6449MA:10
 a=kkY-qNM3VnMZRLI-5tMA:9 a=W3wN7iKeFzTPidE0vcueOGVf3I0A:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id 48BC7309F23; Thu, 14 Aug 2008 00:32:02 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <1218690802-30536-1-git-send-email-bdowning@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92318>

On Thu, Aug 14, 2008 at 12:13:21AM -0500, Brian Downing wrote:
> @@ -141,6 +141,17 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
>  	return xdl_diff(&a, &b, xpp, xecfg, xecb);
>  }
>  
> +int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
> +		  struct xdiff_emit_state *state, xpparam_t const *xpp,
> +		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
> +{
> +	int ret;
> +	xecb->outf = xdiff_outf;
> +	xecb->priv = state;
> +	ret = xdl_diff(mf1, mf2, xpp, xecfg, xecb);

Sorry, this was wrong.  It should call xdi_diff.  (Unfortunately, the
tests passed anyway.)  I'll resubmit.

> +	return ret;
> +}
> +
>  int read_mmfile(mmfile_t *ptr, const char *filename)
>  {
>  	struct stat st;

-bcd
