From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] Git.pm: require Perl 5.6.1
Date: Thu, 14 Aug 2008 00:30:15 +0200
Message-ID: <1218666615-5152-1-git-send-email-LeWiemann@gmail.com>
References: <48A36002.1030705@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 00:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOs8-0000IU-3g
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 00:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbYHMWaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 18:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYHMWaM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 18:30:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8808 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbYHMWaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 18:30:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so164973fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=YjHblLpY4N3OwSwY1tm4ozvl/T5qEzKPT9/HHNi3g7g=;
        b=iydJ/6DDcmWpEz0ay7bdP+JIl4JRWNRh1SMrBuWScyo/c8XUPFdx+kvd4L/t/3Tnd8
         f9+lNVd9YT2rDBkcHUlZOuTCi2gIxVZGgNx4Dg0aLSFSKJaPOmoqbqJZNTx+gLzOrb2s
         x4VYz4gCuGFhCYiYko3Dhk2kNhy9k133mmUQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=GaTb7Z9ACByUHFxsWuxzAu9A25sALKNU5vYDFpOk/NxViHVtvRQzLqKUPUHxasWEbU
         lVz69c8os86Qsowohmpoy6KkQ5CVNQN8fDtx7ZnrWTldEft1cKpaP8H+vjk1TofaO51H
         4H5VgdZua/mOJkev9ZT3E4tcX0SHnuYWhHwjo=
Received: by 10.86.29.19 with SMTP id c19mr631713fgc.28.1218666610071;
        Wed, 13 Aug 2008 15:30:10 -0700 (PDT)
Received: from fly ( [91.33.235.99])
        by mx.google.com with ESMTPS id 3sm2146502fge.3.2008.08.13.15.30.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 15:30:09 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KTOr9-0001M7-PK; Thu, 14 Aug 2008 00:30:15 +0200
X-Mailer: git-send-email 1.5.6.3.539.g5ceae
In-Reply-To: <48A36002.1030705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92287>

File::Temp is only in Perl 5.6.1, so Git.pm won't usually work with
older Perl versions; this gives a more descriptive error message
('Perl version too old'), rather than erroring out with a 'File::Temp
not found' message.  (File::Temp is probably not installable on older
Perl version anyway.)

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 perl/Git.pm |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 405f68f..91c3fc6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -96,6 +96,9 @@ increase notwithstanding).
 =cut
 
 
+# File::Temp is only in core as of Perl 5.6.1.
+use 5.006001;
+
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
 use Cwd qw(abs_path);
-- 
1.5.6.3.539.g5ceae
