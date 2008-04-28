From: Timur Tabi <timur@freescale.com>
Subject: git-send-email: Skipping  - not found.
Date: Mon, 28 Apr 2008 16:15:24 -0500
Message-ID: <48163E6C.60104@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 23:16:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqai6-0005gw-2B
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 23:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936286AbYD1VPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935577AbYD1VPm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 17:15:42 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:64024 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935987AbYD1VPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 17:15:41 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m3SLFPFO020264
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:15:25 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SLFO7D005915
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 16:15:24 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.13) Gecko/20080313 SeaMonkey/1.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80616>

When I issue this command:

git-send-email  --from Timur Tabi <timur@freescale.com> --suppress-cc=all --to
timur@tabi.org --smtp-server remotesmtp.freescale.net
0001--PATCH-Update-CS4270-driver-to-ASoC-V2.patch

I get this output:

Skipping  - not found.
0001--PATCH-Update-CS4270-driver-to-ASoC-V2.patch
OK. Log says:
Server: remotesmtp.freescale.net
MAIL FROM:<timur@freescale.com>
RCPT TO:<timur@tabi.org>
From: Timur Tabi <timur@freescale.com>
To: timur@tabi.org
Subject: [PATCH] Update CS4270 driver to ASoC V2
Date: Mon, 28 Apr 2008 16:13:34 -0500
Message-Id: <1209417214-17376-1-git-send-email-timur@freescale.com>
X-Mailer: git-send-email 1.5.5

Result: 250 2.0.0 m3SLDY4k005131 Message accepted for delivery


I don't know enough about Perl to debug this, but I presume the problem is in
this code:

for my $f (@ARGV) {
	if (-d $f) {
		opendir(DH,$f)
			or die "Failed to opendir $f: $!";

		push @files, grep { -f $_ } map { +$f . "/" . $_ }
				sort readdir(DH);

	} elsif (-f $f) {
		push @files, $f;

	} else {
		print STDERR "Skipping $f - not found.\n";
	}
}

My guess is that "$f", at some point, is an empty string or a blank space.

-- 
Timur Tabi
Linux kernel developer at Freescale
