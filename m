From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 1/5] Git.pm: allow command_close_bidi_pipe to be called as method
Date: Thu,  7 Feb 2013 15:01:17 +0100
Message-ID: <80ccd09ea28fe5282ec97f4d20896a9c55720913.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3S3K-0005g7-FT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686Ab3BGOBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:36 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:32988 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758684Ab3BGOBf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:35 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so1206849eaa.19
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=zdy+oC2biu2ase6/JdBxKkw8fGrXf3lqVWbI/sN0eww=;
        b=U49LbZThZIb3QcG6/Za04FcgLGkvux/eYETIvZQB2IJq+348CDDUmjWOEfKnjhXeLL
         9Of3a9LsvxV4jYpwwzELTgeYLpIcpZ0SpS01oWvOqV+a+T21qITOCmVNHVboPQE6tpzO
         WirJ+D5RQnw/1yv0FAd7LSNVQXPPTZ37jVb8qhul47FwMEWN3/GotYInL+/HmgvOUdrb
         z6TtRtGpqkdfpEUYhBHk+MLnXDFA1tN+Z9BkJRqh0XohNbnIyR/hJnWSGEjPDcFZIsK6
         DsrWVqgEUsvpufSWl83ORahcJWlQLzWUadFGJlNMm+vP09AWg6xAQqKCcUKXFF5eCdfg
         NXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=zdy+oC2biu2ase6/JdBxKkw8fGrXf3lqVWbI/sN0eww=;
        b=PjpfAsiVXIcZZxlb4y9757y6PMiK8mY6j3dCG6nRtQ+BlshOrWDLSgnT9fVenMkxng
         V7zQOHhN8loeYaJcCEh6WgxWRrnrHmvOc5suG0xeTkHKxw4aztvFFDvc+NkQw2t2z9sR
         a7GVZGppsbHGtOLJ8YKCFxtodpgIIu0xRnGy9yw1m7Oo3LUVTiE95rakaHfII/prxdTj
         QlOsUwvXR84kVcUR3fexoBBgbI7+bIvscEyIblHCr8ZdZP+aHg4p4+8YWNtpk0NVPXaB
         +Ima/Y/SR5R5Iqnkp7yJJPKxuvJxowmzS3/JSQ2Yo73dvdFsnMUN0B8dVeOg77THm6QL
         /ZAA==
X-Received: by 10.14.211.137 with SMTP id w9mr4254565eeo.39.1360245693680;
        Thu, 07 Feb 2013 06:01:33 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.32
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:32 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
In-Reply-To: <cover.1360242782.git.mina86@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQkn4HC8Sy1kSYaZv7hF+dvztLAT1/VUroUvpU7YlSYIf3kQx7YlxaOk1hp2OkXV6vz8uZpO/Ms1RmTMPb1PF14JmyBIgL49AqKBOWj6qzHbtOMC6Q9sxoSJZXgyvvWrVtBTeJj3HLmLom1OGVBej8DaxP0l16WCZYmtoqpZz0lMTT9oyeuSuV2+Sof4EFTCeEM3+gb0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215695>

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
1.8.1.2.549.g1d13f9f
