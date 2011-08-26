From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Re* git clean --exclude broken?
Date: Fri, 26 Aug 2011 12:00:25 +0200
Message-ID: <201108261200.25792.trast@student.ethz.ch>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net> <7vfwkqmfsh.fsf@alter.siamese.dyndns.org> <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Todd Rinaldo <toddr@cpanel.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 12:00:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwtDF-00074a-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 12:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab1HZKA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 06:00:28 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12542 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab1HZKA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 06:00:27 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 26 Aug
 2011 12:00:24 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 26 Aug
 2011 12:00:25 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180161>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The documentation and the implementation of "git clean" is quite confused.
> > ...
> 
> So here is a patch to fix the confusion.
> 
> It does not add a new "--except=C" I alluded to, but at least it should
> be the right first step to make the document clearly describe what the
> existing option does.
> 
> -- >8 --
> Subject: [PATCH] Documentation: clarify "git clean -e <pattern>"

It's not exclusively a doc patch, is it?

> +	if (ignored && exclude_list.nr)
> +		die(_("adding exclude with -e and ignoring it with -x is crazy"));

Please also add something like the following patch, so that 'git clean -h' 
does not confuse the user either.

diff --git i/builtin/clean.c w/builtin/clean.c
index 75697f7..33a3df9 100644
--- i/builtin/clean.c
+++ w/builtin/clean.c
@@ -54,7 +54,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				"remove whole directories"),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
-		  "exclude <pattern>", PARSE_OPT_NONEG, exclude_cb },
+		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
 		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
 				"remove only ignored files"),


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
