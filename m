From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] war on echo in scripts
Date: Thu, 8 Jul 2010 21:46:33 -0500
Message-ID: <20100709024633.GA13739@dert.cs.uchicago.edu>
References: <20100706225522.GA31048@genesis.frugalware.org> <7vpqyz278o.fsf@alter.siamese.dyndns.org> <20100707091633.GB31048@genesis.frugalware.org> <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com> <20100707094620.GC31048@genesis.frugalware.org> <7v7hl6stna.fsf@alter.siamese.dyndns.org> <20100708103552.GF31048@genesis.frugalware.org> <20100708171418.GA18229@burratino> <m2k4p58tum.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jul 09 05:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3yw-0000Es-G7
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab0GIDK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 23:10:26 -0400
Received: from camembert.cs.uchicago.edu ([128.135.11.243]:60866 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0GIDKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 23:10:25 -0400
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 9EB60A0B1;
	Thu,  8 Jul 2010 21:46:33 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 638F22038A; Thu,  8 Jul 2010 21:46:33 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <m2k4p58tum.fsf@igel.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150635>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  die() {
>> -	echo >&2 "$@"
>> +	printf >&2 '%s\n' "$@"
>
> You probably want to use "$*" here, though it wouldn't matter for the
> uses of die in this file.

Hmm, maybe something like this would be easier.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 6131670..b38b40b 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -39,6 +39,10 @@ git_broken_path_fix () {
 
 # @@BROKEN_PATH_FIX@@
 
+echo() {
+	printf '%s\n' "$*"
+}
+
 die() {
 	echo >&2 "$@"
 	exit 1
-- 
