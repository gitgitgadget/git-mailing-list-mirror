From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/4] gitweb: show notes in shortlog view
Date: Thu,  4 Feb 2010 17:18:56 +0100
Message-ID: <1265300338-25021-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:19:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4QK-00070M-TJ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933236Ab0BDQTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:19:17 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33285 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221Ab0BDQTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:19:15 -0500
Received: by bwz19 with SMTP id 19so469633bwz.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+Fxy98NFB2S+MP9EsPeCbsUgLidxaI2gELQUGU73RK0=;
        b=n3RQFWgmIuABeITeY+mkbMJ8K8OfZRnTBQJof655s++GoIIZ3F3xwZk72ZeXPd1Qs3
         4Z/wCnWEQqaSwVcA/R+89ZX8uQpsRTiHDEeeVxmRQi2d3GTmDGpoMopzP9hUTD7lNEcb
         zofaKEQaIl3/76+O7xCRi9BCXMiqBHGR5ZzoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oamE04Q9KWeDnPJvSZvXSGG/I2Ftg2SkBdPoVj4IxZqyUYWAYXYc+kJwqZH9XCjO5D
         oD9zMcQJ7NZ+CJ1c14rn8qhB37f/bHdNZleraaVEKvF5giO0hTQh0jX7yR52+ytBnFn8
         Nrp/vJ4pZvFag/dxK0Gprp+8VmNdYcHpbPIAc=
Received: by 10.204.7.139 with SMTP id d11mr793273bkd.162.1265300354069;
        Thu, 04 Feb 2010 08:19:14 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 13sm149356bwz.2.2010.02.04.08.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:19:13 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.193.ge8618
In-Reply-To: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138972>

The presence of the note is shown by a small icon, hovering on which
reveals the actual note content.
---
 gitweb/gitweb.css  |   29 +++++++++++++++++++++++++++++
 gitweb/gitweb.perl |   30 +++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 50067f2..7d1836b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -572,3 +572,32 @@ span.match {
 div.binary {
 	font-style: italic;
 }
+
+span.notes {
+	float:right;
+	position:relative;
+}
+
+span.notes span.note-container:before {
+	content: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAgMAAAC5YVYYAAAAAXNSR0IArs4c6QAAAAlQTFRFAABnybuD//+t5rXizQAAAAF0Uk5TAEDm2GYAAAABYktHRACIBR1IAAAAGElEQVQI12MIDWXIWglDQHYIQ1YAQ6gDAFWPBrAKFe0fAAAAAElFTkSuQmCC');
+}
+
+span.notes span.note {
+	display:none;
+}
+
+span.notes span.note-container img {
+	content: normal;
+}
+
+span.notes span.note-container:hover span.note {
+	display:block;
+	content:normal;
+	background-color:#ffffad;
+	border:1px solid #c9bb83;
+	padding:4px;margin:0;
+	position:absolute;
+	top:0;right:0;
+	z-index:10;
+	overflow:visible;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9ba5815..1701ed1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1628,6 +1628,33 @@ sub format_subject_html {
 	}
 }
 
+# display notes next to a commit
+sub format_notes_html {
+	my %notes = %{$_[0]};
+	my $ret = "";
+	while (my ($ref, $text) = each %notes) {
+		# remove 'refs/notes/' and an optional final s
+		$ref =~ s/^refs\/notes\///;
+		$ref =~ s/s$//;
+
+		# double markup is needed to allow pure CSS cross-browser 'popup'
+		# of the note
+		$ret .= "<span title='$ref' class='note-container $ref'>";
+		$ret .= "<span title='$ref' class='note $ref'>";
+		foreach my $line (split /\n/, $text) {
+			$ret .= esc_html($line) . "<br/>";
+		}
+		$ret .= "</span></span>";
+	}
+	if ($ret) {
+		return "<span class='notes'>$ret</span>";
+	} else {
+		return $ret;
+	}
+
+
+}
+
 # Rather than recomputing the url for an email multiple times, we cache it
 # after the first hit. This gives a visible benefit in views where the avatar
 # for the same email is used repeatedly (e.g. shortlog).
@@ -4595,6 +4622,7 @@ sub git_shortlog_body {
 		my %co = %{$commitlist->[$i]};
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
+		my $notes = format_notes_html($co{'notes'});
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -4605,7 +4633,7 @@ sub git_shortlog_body {
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      format_author_html('td', \%co, 10) . "<td>";
 		print format_subject_html($co{'title'}, $co{'title_short'},
-		                          href(action=>"commit", hash=>$commit), $ref);
+		                          href(action=>"commit", hash=>$commit), $ref . $notes);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
-- 
1.7.0.rc1.193.ge8618
