From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 1/5] Git.pm: allow command_close_bidi_pipe to be called as method
Date: Mon, 11 Feb 2013 17:23:35 +0100
Message-ID: <df0bb01e70629e8170b022867c6e70a8d1b88768.1360599712.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wB5-0001qa-VQ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab3BKQYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:24:00 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:44482 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757878Ab3BKQX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:23:59 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so2782830eaa.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=9PpU5AnJDKz0F+3erb037zmi0ffGMSrYmBFIWQR7YyY=;
        b=fLp5XqeTFV4E8+mqj/8i87voq0M+yNFG1qme59xGG+AgQZ4pHVNNDvoZccbSx+NZZT
         b/XExRhJHxg13dN71JJp5vOdV80Vsdo78ChOL44fh658wnLcJ7J8ZFM+ACVMJeGvjJN8
         gEqFRI/q5F+mjfV7lT43y4g+SufCeKs/ok4ETWX2graZ4+9HjE60XrAgwjg/F6JTsDLA
         ff31nssYttturvg8heMElAuPQTOiOoFtHv1201fKGOXZ9Hz36ypEcvix8KRHaYJ7mSSL
         /vNOXuz5kyLoLAZGdt5u9lZoonWQlv878AN/TM6d5A4htxjwZ7wcirwttR0/7E3yH7xA
         5IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=9PpU5AnJDKz0F+3erb037zmi0ffGMSrYmBFIWQR7YyY=;
        b=W/5kFshLToFd8NjLndxmiGcJNFuybuWg63dpm/GvQI3VD5tJ5qVagqckEedGHUb4Zk
         jFRZsI8pLea/dYwKqxfes4lbmi+IpIf2EcF+MzUZVr5CQIumPh1jtqjD2oNZPKfYhYeW
         FPGTP4KLQBDqqPDCqCgV2Y337g1yWbDOftYb1+/r7jXrE20iNiKrWmiK0PdTUXEVZ8x2
         FpYCRpCpASYtYgnVXIbTM6LYbIeke68sLfA7Xb7xhlks/Yszh6rbAkjqL4Bh2MuEut0O
         Mz0aRPd3rtLCK54uOMfRkx0/FIqU92gu5jYoaAEHaQ4NYnoddXUdH21oKPQSYgRqaaBs
         bWxg==
X-Received: by 10.14.218.132 with SMTP id k4mr52057210eep.27.1360599838227;
        Mon, 11 Feb 2013 08:23:58 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.23.56
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:23:57 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlFbO0efbHJZG0LN3NvTONxLkWopftDzLL660p+5glLJ5E3ro6Ro5DhtiZDLiKO6q4P1UdFxTJZwlqo5gOMdz3BRWwJZuVA/fPWrcd6LGtMoC9BpnVoQAxC8M28N++IcRpWdULJx1YKmVpaMO8UHQRbUeaHfNoPHXHHFvdMyLyHpL5125wpIfe0LrRsE1fGvtE0xPBj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216041>

From: Michal Nazarewicz <mina86@mina86.com>

The documentation of command_close_bidi_pipe() claims that it can
be called as a method, but it does not check whether the first
argument is $self or not assuming the latter.  Using _maybe_self()
fixes this.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 931047c..bbb753a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -430,7 +430,7 @@ have more complicated structure.
 
 sub command_close_bidi_pipe {
 	local $?;
-	my ($pid, $in, $out, $ctx) = @_;
+	my ($self, $pid, $in, $out, $ctx) = _maybe_self(@_);
 	foreach my $fh ($in, $out) {
 		unless (close $fh) {
 			if ($!) {
-- 
1.8.1.3.571.g3f8bed7.dirty
