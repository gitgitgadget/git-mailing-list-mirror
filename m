From: Jakub Narebski <jnareb@gmail.com>
Subject: git diff -B: splitting up complete renames
Date: Sat, 5 Jan 2008 18:18:38 +0100
Message-ID: <200801051818.40009.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 18:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBCg3-0005pv-6W
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 18:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbYAERSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 12:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYAERSq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 12:18:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:37083 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYAERSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 12:18:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3861782fga.17
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ik/yLSNAfoBrsHLOoln+saWQrS61aB6SkAu42ea5RJw=;
        b=JW31mm2m/gjfy+UIRa2CVBac+k5T3Z5RYLyq19MNQpaug3+TP8Iq5jUsGGtiiKspaOv66dosYKrmDFxow6PnEGV8PIYpKDvKgnQRNCvYIGLvF5XsGwoaAqqWh5MBSuMuJ+9QDDu/qeVIoH0gZdIxJ4T3k48KV4nGdSyIxx7w/zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rt+GyWM+9Uk//A3Z0iTi3TxVzsx5hj3x7jr1kO0ZLOvqLl2Ahj1eQkJ29GyM6t7FjVO5ceBax5H4tagBPSyk35xlZGMPh6KGRO21fzX/ebjMMNF6rcuUuENoyzO4umcFX3uIWE1y3qzyX+y5shVeN0AaCvPGrNnR2/iFOJUJewY=
Received: by 10.82.158.12 with SMTP id g12mr5495968bue.18.1199553523187;
        Sat, 05 Jan 2008 09:18:43 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.190.130])
        by mx.google.com with ESMTPS id y34sm25870254iky.6.2008.01.05.09.18.40
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 09:18:41 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69678>

First: in Documentation/diffcore.txt there is an example of broken pair

  diffcore-break: For Splitting Up "Complete Rewrites"
  ----------------------------------------------------

  The second transformation in the chain is diffcore-break, and is
  controlled by the -B option to the git-diff-* commands.  This is
  used to detect a filepair that represents "complete rewrite" and
  break such filepair into two filepairs that represent delete and
  create.  E.g.  If the input contained this filepair:

  ------------------------------------------------
  :100644 100644 bcd1234... 0123456... M file0
  ------------------------------------------------

  and if it detects that the file "file0" is completely rewritten,
  it changes it to:

  ------------------------------------------------
  :100644 000000 bcd1234... 0000000... D file0
  :000000 100644 0000000... 0123456... A file0
  ------------------------------------------------

Shouldn't the last block read for the modern git read:

  ------------------------------------------------
  :100644 000000 bcd1234... 0123456... M99 file0
  ------------------------------------------------

or is it only for '-B' togehter with '-M' or '-C'?


Second: do you have per chance good examples of broken (and perhaps 
merged together) pair, such that it is affected by --diff-filter=B;
with -B<num> or -B<num1>/<num2> parameters needed, if required. COPYING 
and Makefile are one good example, but do you have literal files with 
similar behavior? 

Third: Do "git diff --no-index" (filesystem diff) can show breaking / 
use dissimilarity? I couldn't make it work...

-- 
Jakub Narebski
Poland
