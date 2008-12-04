From: William Pursell <bill.pursell@gmail.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Thu, 04 Dec 2008 06:55:20 +0000
Message-ID: <49377ED8.4050905@gmail.com>
References: <492F0CAD.3010101@gmail.com> <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com> <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com> <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE63.209@gmail.com> <7vd4g8alp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 07:56:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L888l-0005Jr-7K
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 07:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbYLDGz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbYLDGz3
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 01:55:29 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:41365 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbYLDGz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 01:55:28 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1663501eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 22:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=LXr6eJS4ij5XOj5omLL187RXwkEMb8jqyT6gi7AWdPk=;
        b=mI6f9XvF5kNXsWG/mJga01CWbQg0lg6n6Ebe16K9xCliSk6sbNmc1W954L9uo4M3rC
         8E8eZwrVSleQuYTKQfOXVPBNRTEaeB3brDRgjA4Y/yN2LmS1L/GTYPmfSOJwX/wUn0Kx
         RUJHHmTR56RFBBqz8I0ai1M9RDwmZjr7b5txU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PTnge0WwPGRXYsn75jDMXGzbTfDaguN65HFtkynzT8ehuzp47AOtGbyTZXZRTcWh+y
         7CyjMl+PeDKdNbq5E2XUihkgx+qjRN5pm4SSnM/bM5Eu6OC2yGwuXCGHpJkp6VmzmP3y
         MdV6nEkjPr2m3y324jGylzG//3/PcPmUDMleQ=
Received: by 10.210.67.4 with SMTP id p4mr3546124eba.183.1228373725765;
        Wed, 03 Dec 2008 22:55:25 -0800 (PST)
Received: from clam.local (5ace1311.bb.sky.com [90.206.19.17])
        by mx.google.com with ESMTPS id p10sm4124010gvf.24.2008.12.03.22.55.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 22:55:23 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Macintosh/20081105)
In-Reply-To: <7vd4g8alp7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102326>

Junio C Hamano wrote:

> Do you really want the surrounding @@ in the result, by the way?

Oddly, I liked it before.  But now that you mention it, it does
seem ugly.

> How well does substr() work with utf-8 and other multi-byte encodings
> these days, I have to wonder...

Hopefully, it works well.

Here's another go, with your suggestions applied.


 From 92ab9b7c694ba98b43984bbbdfcd5eeb9cbb7d56 Mon Sep 17 00:00:00 2001
From: William Pursell <bill.pursell@gmail.com>
Date: Thu, 4 Dec 2008 06:09:50 +0000
Subject: [PATCH 1/2] Add subroutine to display one-line summary of hunks.

This commit implements a rather simple-minded mechanism
to display a one-line summary of the hunks in an array ref.
The display consists of the line numbers and the first
changed line, truncated to 80 characters.  20 lines are
displayed at a time, and the index of the first undisplayed
line is returned, allowing the caller to display more if
desired.  (The 20 and 80 should be made configurable.)

Signed-off-by: William Pursell <bill.pursell@gmail.com>
---
  git-add--interactive.perl |   42 ++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b0223c3..b25a841 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -836,6 +836,48 @@ sub patch_update_cmd {
  	}
  }

+# Generate a one line summary of a hunk.
+sub summarize_hunk {
+	my $rhunk = shift;
+	my $summary = $rhunk->{TEXT}[0];
+
+	# Keep the line numbers, discard extra context.
+	$summary =~ s/@@(.*?)@@.*/$1 /s;
+	$summary .= " " x (20 - length $summary);
+
+	# Add some user context, the first changed line that contains
+	# some non-white character other than a bracket.
+	for my $line (@{$rhunk->{TEXT}}) {
+		if ($line =~ m/^([+-][][{}()\s]*[^][{}()\s])/) {
+			$summary .= $line;
+			last;
+		}
+	}
+
+	chomp $summary;
+	return substr($summary, 0, 80) . "\n";
+}
+
+
+# Print a one-line summary of each hunk in the array ref in
+# the first argument, starting wih the index in the 2nd.
+sub display_hunks {
+	my ($hunks, $i) = @_;
+	my $ctr = 0;
+	$i = 0 if not $i;
+	for (; $i < @$hunks && $ctr < 20; $i++, $ctr++) {
+		my $status = " ";
+		if (defined $hunks->[$i]{USE}) {
+			$status = $hunks->[$i]{USE} ? "+" : "-";
+		}
+		printf "%s%2d: %s",
+			$status,
+			$i + 1,
+			summarize_hunk($hunks->[$i]);
+	}
+	return $i;
+}
+
  sub patch_update_file {
  	my ($ix, $num);
  	my $path = shift;
-- 
1.6.1.rc1.37.g83daf.dirty



-- 
William Pursell
