From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/2] sh-setup: explicitly mark CR as a field separator
Date: Sun, 25 Oct 2015 13:16:51 -0000
Organization: OPDS
Message-ID: <36EB0AFDC58D44F3B48BFA044EA15547@PhilipOakley>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <214d877df18f3189b1809946817aab9765450ea9.1445777347.git.johannes.schindelin@gmx.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Chad Boles" <chadbo@microsoft.com>
To: "Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 14:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqLAR-00082e-45
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 14:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbbJYNQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 09:16:53 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:46746 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608AbbJYNQw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 09:16:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2AVJwCc1SxWPOypEVxeGQoBAQIBAQIBgwpUb4ZabbJUhgkdhXoEAoEXTQEBAQEBAQcBAQEBQSQbQQ4Bg10FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMGAQ0GARIIAgECAwGICgMKDAm4dos0AQshhneEfoJQgj2DIYEUBY1RiGUBgSCDe4lfkgaIUIRmPjSBJYVzAQEB
X-IPAS-Result: A2AVJwCc1SxWPOypEVxeGQoBAQIBAQIBgwpUb4ZabbJUhgkdhXoEAoEXTQEBAQEBAQcBAQEBQSQbQQ4Bg10FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMGAQ0GARIIAgECAwGICgMKDAm4dos0AQshhneEfoJQgj2DIYEUBY1RiGUBgSCDe4lfkgaIUIRmPjSBJYVzAQEB
X-IronPort-AV: E=Sophos;i="5.20,196,1444690800"; 
   d="scan'208";a="691235811"
Received: from host-92-17-169-236.as13285.net (HELO PhilipOakley) ([92.17.169.236])
  by out1.ip06ir2.opaltelecom.net with SMTP; 25 Oct 2015 13:16:50 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280145>

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> This is the correct thing to do, really: we already specify LF as
> field separator.
>
> Incidentally, this fixes the problem interactive rebase has when the
> editor wants to save text with CR/LF line endings, as WordPad does
> in Windows 10.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> git-sh-setup.sh               | 2 +-
> t/t3404-rebase-interactive.sh | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 4691fbc..94dfe04 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -13,7 +13,7 @@ unset CDPATH
> # do not equate an unset IFS with IFS with the default, so here is
> # an explicit SP HT LF.

Doesn't this comment also need an update, given the patch title?

> IFS='
> -'
> +'"$(printf '')"
>
> git_broken_path_fix () {
>  case ":$PATH:" in
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 5dfa16a..98eb49a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
>  test E = $(git cat-file commit HEAD | sed -ne \$p)
> '
>
> -test_expect_failure 'editor saves as CR/LF' '
> +test_expect_success 'editor saves as CR/LF' '
>  git checkout -b with-crlf &&
>  write_script add-crs.sh <<-\EOF &&
>  sed -e "s/\$/Q/" <"$1" | tr Q "" >"$1".new &&
> -- 
> 2.1.4
--
Philip 
