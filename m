From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add --path-prefix option to git-fast-import
Date: Tue, 29 Dec 2009 07:08:44 -0800
Message-ID: <20091229150844.GC6152@spearce.org>
References: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Gisle Aas <gisle@aas.no>
To: Gisle Aas <gisle.aas@it.uib.no>
X-From: git-owner@vger.kernel.org Tue Dec 29 16:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdgz-00085v-1N
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 16:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbZL2PIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 10:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbZL2PIs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 10:08:48 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:40153 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbZL2PIr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 10:08:47 -0500
Received: by gxk3 with SMTP id 3so5244479gxk.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 07:08:46 -0800 (PST)
Received: by 10.100.243.16 with SMTP id q16mr19753790anh.113.1262099326818;
        Tue, 29 Dec 2009 07:08:46 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm11903228iwn.11.2009.12.29.07.08.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 07:08:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1262091083-25401-1-git-send-email-gisle.aas@it.uib.no>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135805>

Gisle Aas <gisle.aas@it.uib.no> wrote:
> I found this useful when import multiple external repositories to be merged
> into a single git repo.  Not having the files be renamed during the merge
> made it easier to follow the history of the individual files.
> 
> Signed-off-by: Gisle Aas <gisle@aas.no>
> ---
>  Documentation/git-fast-import.txt |    6 ++++++
>  fast-import.c                     |   24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 0 deletions(-)

Interesting.  Test cases?
 
> +static const char *path_prefix_prepend(struct strbuf *sb, const char *p)
> +{
> +	if (p != sb->buf) {
> +	    strbuf_reset(sb);
> +	    strbuf_addstr(sb, p);
> +	}

I'd be a bit happier about the change if you could check not only
that p != sb->buf, but that p is not within sb->buf + sb->alloc.

I can't remember if all of the cases below are safe such that
any time you call the function with a p that p isn't pointing to
something within the strbuf you are handing in.

-- 
Shawn.
