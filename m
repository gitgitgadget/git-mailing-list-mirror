From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Mon, 5 Oct 2009 08:27:55 -0700
Message-ID: <20091005152755.GF9261@spearce.org>
References: <1254593401-18801-1-git-send-email-herve@itaapy.com> <1254593401-18801-2-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Herv?? Cauwelier <herve@itaapy.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 17:32:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MupXx-0001PG-MR
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 17:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZJEP2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 11:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752975AbZJEP2d
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 11:28:33 -0400
Received: from george.spearce.org ([209.20.77.23]:37659 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbZJEP2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 11:28:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D68F1381FF; Mon,  5 Oct 2009 15:27:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1254593401-18801-2-git-send-email-herve@itaapy.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129568>

Herv?? Cauwelier <herve@itaapy.com> wrote:
> diff --git a/src/odb.h b/src/odb.h
> index 2f205b2..0311d78 100644
> --- a/src/odb.h
> +++ b/src/odb.h
> @@ -11,9 +11,10 @@
>   *   uint32_t *fanout = ... the file data at offset 0 ...
>   *   ntohl(fanout[0]) < ntohl(fanout[1])
>   *
> - * The value chosen here for PACK_TOC is such that the above
> + * The value chosen here for IDX_TOC is such that the above
>   * cannot be true for an idx v1 file.
>   */
> -#define PACK_TOC 0xff744f63 /* -1tOc */
> +#define IDX_TOC 0xff744f63 /* -1tOc */
> +#define PACK_TOC 0x5041434b /* PACK */

FWIW, I wouldn't call the magic string 'PACK' PACK_TOC.  TOC here
meant "table of contents".  The magic string '-1tOc' for PACK_TOC
is no accident, its trying to show that this file is a table of
contents file.

I think at the time I meant for PACK_TOC to be the pack-*.idx
header magic string, and PACK_SIG or PACK_HDR to be the magic
string for pack-*.pack.

-- 
Shawn.
