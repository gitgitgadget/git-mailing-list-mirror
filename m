From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: [PATCH] gitweb: Add hash parameter in feed URL when a hash is specified in the current request
Date: Fri, 21 Mar 2008 19:38:38 +0100
Message-ID: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 19:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcm9B-000881-S4
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631AbYCUSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbYCUSil
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:38:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:41500 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbYCUSik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:38:40 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2020939fkr.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=2/Oy6Zo0vUYAGdMh71kW/sdrZfs3f3CYqvFEYR7TbOE=;
        b=j+IL3zzJU7zAQ76TTUsBoiFS79J1KBupOR5aA5XM2ZvRyN5XTt5BVRlz6kcS61h6ydCDXZXHX8AEXQAbGj+AQiGGJJYdG50JyVFx8JzU1ZCXNQe7kANNdirPC17UH1BrwGHs1vMbvv8rXmIXDaWJWaKzrM21jUG50AypaOG9GGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=gvVAsn0Wp4ZpNF/VPMmLJPG5eKizSI+/MKAz3hqbidEyDiNtNzTKZ+Q9/V9X2Q1Pva5c2XfOFnfScj1Dp8aIyNWDIRUyMBLRCJ8xBf7t7AATMJy/XfwItTBbcPRHlI2bnzcuGMEs8BUVkB0HkEawS58w0Z3QiZiq3aKzzYaK/C4=
Received: by 10.78.183.8 with SMTP id g8mr621845huf.78.1206124718384;
        Fri, 21 Mar 2008 11:38:38 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 21 Mar 2008 11:38:38 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 2471c12054dc73ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77755>

Hi list,

I was annoyed with the RSS feed link at the bottom of gitweb because I
couldn't find a way to have a specific feed for every branch.  With
this patch, the generated links include the hash parameter so that
feeds are context-dependant.

Hope it helps!

---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..7d013bd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -615,6 +615,7 @@ sub href(%) {
        my %mapping = @mapping;

        $params{'project'} = $project unless exists $params{'project'};
+       $params{'hash'} = $hash unless exists $params{'hash'};

        if ($params{-replay}) {
                while (my ($name, $symbol) = each %mapping) {
-- 
1.5.4.1-dirty
