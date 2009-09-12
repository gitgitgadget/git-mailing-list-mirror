From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v7 2/6] fast-import: put marks reading in it's own
	function
Date: Sat, 12 Sep 2009 11:47:06 -0700
Message-ID: <20090912184706.GP1033@spearce.org>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com> <1252247748-14507-2-git-send-email-srabbelier@gmail.com> <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	vcs-fast-import-devs@lists.launchpad.net
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmXcv-000476-I7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZILSrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbZILSrE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:47:04 -0400
Received: from george.spearce.org ([209.20.77.23]:44268 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbZILSrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:47:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A84DA381FD; Sat, 12 Sep 2009 18:47:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128283>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> All options do nothing but set settings, with the exception of the
> --input-marks option. Delay the reading of the marks file till after
> all options have been parsed.
...
> diff --git a/fast-import.c b/fast-import.c
> index b904f20..812fcf0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -315,6 +315,7 @@ static struct object_entry_pool *blocks;
>  static struct object_entry *object_table[1 << 16];
>  static struct mark_set *marks;
>  static const char *mark_file;
> +static const char *input_file;

Sorry I didn't notice this earlier in the series, but input_file
is too generic of a name for a global in this program.  Its *not*
the input stream, and I fear that it might be confused as such.

Likewise now mark_file is also confusing.  I would suggest renaming
these two:
  
  static const char *export_marks_file;
  static const char *import_marks_file;

-- 
Shawn.
