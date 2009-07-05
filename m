From: Antony Stubbs <antony.stubbs@gmail.com>
Subject: cvs import and internal plumbing commands
Date: Sun, 5 Jul 2009 14:43:01 +1200
Message-ID: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 04:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNHhK-0003Tz-CR
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 04:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZGECnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 22:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbZGECnH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 22:43:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:40950 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbZGECnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 22:43:05 -0400
Received: by wa-out-1112.google.com with SMTP id j5so629068wah.21
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 19:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=i7S40an2hh2smGoNCrPtjtFg+lwF9FxrIwpMYL4o4Vk=;
        b=NzFjaTKU8dt4z/xCI6Lsk0luJ/zJDj9rZ9qEEpUFJPTxzKInKNQjOvWMB9rOKJUzsJ
         j5hLxJvBSX/pF45okKopkc3Mbzdwk2ETkqott5H8I8vD1NOEt2EQibosV9fiPnCJb2QZ
         XNoaqtbBz+w1xkIsHw+cSl+lyJgRRZ2t0OccU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=Yy/glHU8y5zznSyF/m9en415cl/vzV/Ywe21Y2p9EiHB1uGHEm6SCiQr9vd3Fy2p6A
         eYCbQw3duFSAwCq3mnhkt1QWvTP/2VwFtfJCTGyfTca/ObC+yje5SeC5ux1Et0etmMvI
         LaKnn7hmfACaOjf099coobu2/Zf/EOVLsYo0g=
Received: by 10.115.23.19 with SMTP id a19mr4850530waj.49.1246761788319;
        Sat, 04 Jul 2009 19:43:08 -0700 (PDT)
Received: from ?192.168.1.5? ([203.160.125.120])
        by mx.google.com with ESMTPS id k21sm8820316waf.24.2009.07.04.19.43.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 19:43:07 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122734>

I've got a new install from mac-ports and am having trouble with cvs  
import not finding the plumbing commands.

It seems that cvsimport still uses all the old style git-hash-object  
type commands, instead of the new " git hash-object" command style.  
And on my system, I don't have any of the old style commands.

I'm working on patching cvsimport to the new style, but would  
appreicate anyone pointing out anything I'm missing...

If i am indeed correct, then a little help with this would be great  
(I'm not a perl programmer):

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e439202..de40933 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -920,7 +920,7 @@ while (<CVS>) {
                         my $pid = open(my $F, '-|');
                         die $! unless defined $pid;
                         if (!$pid) {
-                           exec("git-hash-object", "-w", $tmpname)
+                           exec("git", "hash-object -w", $tmpname)
                                 or die "Cannot create object: $!\n";
                         }
                         my $sha = <$F>;

git: 'hash-object -w' is not a git-command. See 'git --help'.

Regards,
Antony Stubbs

Talk to me about Wicket, Spring, Maven consulting, small scale  
outsourcing to Australasia and India and Open Source development!

Website: http://sharca.com
Blog: http://stubbisms.wordpress.com
Linked In: http://www.linkedin.com/in/antonystubbs
Podcast: http://www.illegalargument.com
