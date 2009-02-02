From: William Pursell <bill.pursell@gmail.com>
Subject: Re: [PATCH 1/3] git-add -i/-p: Change prompt separater from slash
 to comma
Date: Mon, 02 Feb 2009 09:17:28 +0000
Message-ID: <4986BA28.10608@gmail.com>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com> <1233546159-30347-2-git-send-email-gitster@pobox.com> <4986A334.6070903@gmail.com> <7vy6wpl1mx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 10:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuxL-0004aB-M9
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 10:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZBBJRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 04:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbZBBJRf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 04:17:35 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:57927 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbZBBJRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 04:17:34 -0500
Received: by ewy14 with SMTP id 14so1728320ewy.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 01:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=y82iOyYUnfszfzi301FyuIb7zYJ6B12wzwGiZSUqV5s=;
        b=JMWCdsD/Us20/FssNHjqwvu/3DnMC65epnlcaaq1noZH0nxHC3CZ8jmdBPGga/EInH
         MW1gm1MS8h6PqRKuVVqquKxSkGHla3hMitR26d4FNpQMISFCpckRIXaZEuf7RgNZQdtk
         1BByTx1bibUDduA6NvR5q52Q+JRXERyi7pEZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OQUfekLNxeKKy5lNQ869zn46MeXKfYYVjHLHMwjh/iB2LEHcfNzE7lMq/P4UHJBX38
         9ZOtxVJh0zigAN0BzAnnGtFTjxd0oWKBQvLKHE1fsC211qywn0oApIT3FtIy1CiXkyoO
         cLJptdDXDmJCNQ4B46o56gEmWJ3iyM0AqdOYQ=
Received: by 10.210.34.5 with SMTP id h5mr1035917ebh.161.1233566252294;
        Mon, 02 Feb 2009 01:17:32 -0800 (PST)
Received: from clam.local (5ad36962.bb.sky.com [90.211.105.98])
        by mx.google.com with ESMTPS id j8sm3417116gvb.21.2009.02.02.01.17.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 01:17:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <7vy6wpl1mx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108075>

Junio C Hamano wrote:
> William Pursell <bill.pursell@gmail.com> writes:
> 
>> Not a major complaint, but how about localizing the occurence
>> of the separator.  Something like this:
> 
> I think that is sensible.  I've already queued the resurrected series to
> 'next' and am deep in the process of tonight's pushout preparation (this
> time I've even written What's cooking), so I'd rather not rewind what I
> have already and redo it.  Could you send an incremental update on top of
> what's in next (more specifically ace30ba (In add --patch, Handle K,k,J,j
> slightly more gracefully., 2008-11-27) please?

Here's a patch against ace30ba.  Minor change from the initial
patch includes adding '?' to the join argument for consistency
with previous prompt string, and adding '/' to the initialization
of $other to accomodate dd971cc.


Localize the command separator.

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
 git-add--interactive.perl |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 30ddab2..4500e62 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -922,7 +922,7 @@ sub patch_update_file {

 	while (1) {
 		my ($prev, $next, $other, $undecided, $i);
-		$other = '';
+		$other = 'ynad/';

 		if ($num <= $ix) {
 			$ix = 0;
@@ -930,25 +930,25 @@ sub patch_update_file {
 		for ($i = 0; $i < $ix; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$prev = 1;
-				$other .= ',k';
+				$other .= 'k';
 				last;
 			}
 		}
 		if ($ix) {
-			$other .= ',K';
+			$other .= 'K';
 		}
 		for ($i = $ix + 1; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
 				$next = 1;
-				$other .= ',j';
+				$other .= 'j';
 				last;
 			}
 		}
 		if ($ix < $num - 1) {
-			$other .= ',J';
+			$other .= 'J';
 		}
 		if ($num > 1) {
-			$other .= '/g';
+			$other .= 'g';
 		}
 		for ($i = 0; $i < $num; $i++) {
 			if (!defined $hunk[$i]{USE}) {
@@ -959,13 +959,14 @@ sub patch_update_file {
 		last if (!$undecided);

 		if (hunk_splittable($hunk[$ix]{TEXT})) {
-			$other .= ',s';
+			$other .= 's';
 		}
-		$other .= ',e';
+		$other .= 'e';
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color, "Stage this hunk [y,n,a,d,/$other,?]? ";
+		print colored $prompt_color, "Stage this hunk [" .
+			join(",", split("", $other . "?")) . "]? ";
 		my $line = <STDIN>;
 		if ($line) {
 			if ($line =~ /^y/i) {
-- 
1.6.1.265.g9a013.dirty




-- 
William Pursell
