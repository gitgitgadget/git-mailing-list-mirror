From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 1/4] send-email: Cleanup { style
Date: Sat, 10 Apr 2010 10:53:53 -0400
Message-ID: <1270911236-32476-2-git-send-email-brian@gernhardtsoftware.com>
References: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c4c-0006Uv-Sv
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0DJOyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:54:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35745 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0DJOyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:54:06 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 3247E1FFC057; Sat, 10 Apr 2010 14:54:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.103.20])
	by silverinsanity.com (Postfix) with ESMTPA id AC85A1FFC057;
	Sat, 10 Apr 2010 14:53:57 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.251.g42f41
In-Reply-To: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144553>

As Jakub Narebski pointed out on the list, Perl code usually prefers

  sub func {
  }

over

  sub func
  {
  }

git-send-email.perl is somewhat inconsistent in its style, with 23
subroutines using the first style and 6 using the second.  Convert the
few odd subroutines so that the code matches normal Perl style.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 git-send-email.perl |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ce569a9..26fe624 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -761,8 +761,7 @@ sub extract_valid_address {
 # We'll setup a template for the message id, using the "from" address:
 
 my ($message_id_stamp, $message_id_serial);
-sub make_message_id
-{
+sub make_message_id {
 	my $uniq;
 	if (!defined $message_id_stamp) {
 		$message_id_stamp = sprintf("%s-%s", time, $$);
@@ -817,8 +816,7 @@ sub is_rfc2047_quoted {
 }
 
 # use the simplest quoting being able to handle the recipient
-sub sanitize_address
-{
+sub sanitize_address {
 	my ($recipient) = @_;
 	my ($recipient_name, $recipient_addr) = ($recipient =~ /^(.*?)\s*(<.*)/);
 
@@ -863,8 +861,7 @@ sub sanitize_address
 # This maildomain*() code is based on ideas in Perl library Test::Reporter
 # /usr/share/perl5/Test/Reporter/Mail/Util.pm ==> sub _maildomain ()
 
-sub maildomain_net
-{
+sub maildomain_net {
 	my $maildomain;
 
 	if (eval { require Net::Domain; 1 }) {
@@ -876,8 +873,7 @@ sub maildomain_net
 	return $maildomain;
 }
 
-sub maildomain_mta
-{
+sub maildomain_mta {
 	my $maildomain;
 
 	if (eval { require Net::SMTP; 1 }) {
@@ -898,8 +894,7 @@ sub maildomain_mta
 	return $maildomain;
 }
 
-sub maildomain
-{
+sub maildomain {
 	return maildomain_net() || maildomain_mta() || $mail_domain_default;
 }
 
@@ -907,8 +902,7 @@ sub maildomain
 # In actuality, the whole program dies when there
 # is an error sending a message.
 
-sub send_message
-{
+sub send_message {
 	my @recipients = unique_email_list(@to);
 	@cc = (grep { my $cc = extract_valid_address($_);
 		      not grep { $cc eq $_ } @recipients
-- 
1.7.1.rc0.251.g42f41
