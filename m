From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Awkward and confusing question in git --send-email
Date: Sun, 24 Apr 2016 12:31:44 -0700
Message-ID: <xmqqlh42n6qn.fsf@gitster.mtv.corp.google.com>
References: <20160423182235.GA20615@jocasta.intra>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Darrington <john@darrington.wattle.id.au>
X-From: git-owner@vger.kernel.org Sun Apr 24 21:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPl8-0003WW-9W
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcDXTbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 15:31:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753278AbcDXTbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 15:31:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 832E714057;
	Sun, 24 Apr 2016 15:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvfS48UM7KaxWnupUjDOHDyqmv0=; b=il16Q4
	gPr2GHlz2H0U7d1kYzmBMwZVq/NY2ORBCrEqTb5wo6c/1p8neJJB+86td/ukodUy
	cPZK4fN6cjlZqf5vBXcNb1ghtvgpM1DsmtXfQuCdWUyMkru/n/FoqpFuYpbBFTTu
	ACs/DcjTZodU2CBLuFhe+daE0aWeOocQWGn+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kjMbX2dkcZnCPLRZDaqMR7IfXiUVCHNU
	0xBGaWUN0F5bQv3yEZT/9ubCjQ9hvDr8E5jfWxQ7mn+zmmZyMYTx/jiM8dDUJ4sM
	WZzjHTHHHw4FDNKwseSHoGwXAHewocnF8M2HYdd1ktPgyG6otAFvZvzrKaspHg+9
	lK1hgMcwzEE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A88E14056;
	Sun, 24 Apr 2016 15:31:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9F3C14055;
	Sun, 24 Apr 2016 15:31:45 -0400 (EDT)
In-Reply-To: <20160423182235.GA20615@jocasta.intra> (John Darrington's message
	of "Sat, 23 Apr 2016 20:22:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E66671E-0A53-11E6-A8F8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292434>

John Darrington <john@darrington.wattle.id.au> writes:

> Git --send-email poses the question:
>
>  "Who should the emails be sent to (if any)?"
>
> Apart from sounding clumsy (not to mention incorrect grammar), it took me a while to work out what this meant.
>
> I suggest this be changed to :
>
> "To whom should the email be sent (if anyone) ?"

Sounds good.

-- >8 --
Subject: send-email: fix grammo in the prompt that asks e-mail recipients

The message, which dates back to the very original version 83b24437
made in 2005, sounds clumsy, grammatically incorrect, and is hard to
understand.

Reported-by: John Darrington <john@darrington.wattle.id.au>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c45b22a..1ef94f6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -827,9 +827,10 @@ sub file_declares_8bit_cte {
 # But it's a no-op to run sanitize_address on an already sanitized address.
 $sender = sanitize_address($sender);
 
+my $to_whom = "To whom should the emails be sent (if anyone)?";
 my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
-	my $to = ask("Who should the emails be sent to (if any)? ",
+	my $to = ask("$to_whom ",
 		     default => "",
 		     valid_re => qr/\@.*\./, confirm_only => 1);
 	push @initial_to, parse_address_line($to) if defined $to; # sanitized/validated later
@@ -924,7 +925,7 @@ sub validate_address {
 			cleanup_compose_files();
 			exit(0);
 		}
-		$address = ask("Who should the email be sent to (if any)? ",
+		$address = ask("$to_whom ",
 			default => "",
 			valid_re => qr/\@.*\./, confirm_only => 1);
 	}
