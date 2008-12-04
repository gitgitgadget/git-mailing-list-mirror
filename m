From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 2/2]
Date: Thu, 04 Dec 2008 06:56:37 +0000
Message-ID: <49377F25.9020005@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE68.6030009@gmail.com> <7v4p1kalno.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 07:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L889w-0005Yn-Kb
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 07:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYLDG4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 01:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbYLDG4o
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 01:56:44 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:31317 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYLDG4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 01:56:43 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1663617eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tPWOqXScsA5r9EEedGa+JpTzNYyRVow0pK1Zf9qd9NE=;
        b=W+MCsYKqhcvod/VK+Vv4Absu+PNgaG9myF1bDlX+PZvDJg+K4Kmi3xmu6L5G6ezovA
         yTEj1RC0nmFH1UIBT1zzDJrMpbtQKjrVitxiph5ueXsQNTwe4DpYEKskeN6S5mnMOrl1
         AByOKj86s1XNNPb+Q0NC8YIadUyMe09Pe4Alo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iJHMfRExl+pwZoXDJqr6uU2OGitmSiKwsy2Kl8g47N676IrYFGcO/1L4As4egYw49w
         lDUDAOc3Vif42ngHprrqUWK0m5FW6ek2e41EC+MdEnulJF0p/0NgPBsQ5ZibHnqI5XDJ
         ckAfwxg2rH1LuSVdA5Mts86XRBwdNcfBXoLO4=
Received: by 10.210.51.18 with SMTP id y18mr16242173eby.103.1228373801522;
        Wed, 03 Dec 2008 22:56:41 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id p10sm1754833gvf.12.2008.12.03.22.56.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 22:56:40 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7v4p1kalno.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102327>

 From b039fb8aa03efab3faf46c0a0a8d84cea974f26f Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Thu, 4 Dec 2008 06:48:57 +0000
Subject: [PATCH 2/2] Add 'g' command to go to a hunk.

When a minor change is made while the working directory
is in a bit of a mess (and the user should have done a
stash before making the minor edit, but didn't) it is
somewhat difficult to wade through all of the hunks using
git add --patch.  This allows one to jump to the hunk
that needs to be staged without having to respond 'n' to
each preceding hunk.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   26 ++++++++++++++++++++++++++
  1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b25a841..555c981 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -800,6 +800,7 @@ y - stage this hunk
  n - do not stage this hunk
  a - stage this and all the remaining hunks in the file
  d - do not stage this hunk nor any of the remaining hunks in the file
+g - select a hunk to goto
  j - leave this hunk undecided, see next undecided hunk
  J - leave this hunk undecided, see next hunk
  k - leave this hunk undecided, see previous undecided hunk
@@ -946,6 +947,9 @@ sub patch_update_file {
  		if ($ix < $num - 1) {
  			$other .= '/J';
  		}
+		if ($num > 1) {
+			$other .= '/g';
+		}
  		for ($i = 0; $i < $num; $i++) {
  			if (!defined $hunk[$i]{USE}) {
  				$undecided = 1;
@@ -979,6 +983,28 @@ sub patch_update_file {
  				}
  				next;
  			}
+			elsif ($other =~ 'g' && $line =~ /^g(.*)/) {
+				my $response = $1;
+				my $i = $ix > 10 ? $ix - 10 : 0;
+				while ($response eq '') {
+					my $extra = "";
+					$i = display_hunks(\@hunk, $i);
+					if ($i < $num) {
+						$extra = " (<ret> to see more)";
+					}
+					print "goto which hunk$extra? ";
+					$response = <STDIN>;
+					chomp $response;
+				}
+				if ($response !~ /^\s*\d+\s*$/) {
+					print STDERR "Invalid number: '$response'\n";
+				} elsif (0 < $response && $response <= $num) {
+					$ix = $response - 1;
+				} else {
+					print STDERR "Sorry, only $num hunks available.\n";
+				}
+				next;
+			}
  			elsif ($line =~ /^d/i) {
  				while ($ix < $num) {
  					if (!defined $hunk[$ix]{USE}) {
-- 
1.6.1.rc1.37.g83daf.dirty
