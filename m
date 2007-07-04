From: Mark Levedahl <mlevedahl@gmail.com>
Subject: gitk - error in git repo on cygwin
Date: Wed, 04 Jul 2007 09:33:44 -0400
Message-ID: <468BA1B8.4010406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:33:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64zO-0004uh-U4
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759699AbXGDNds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759512AbXGDNds
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:33:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:22299 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758929AbXGDNdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:33:47 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2081207wxd
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 06:33:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=OhGDhe4L7kHDvgwQiiJ4BoWtWkDXV+mlIIqjeaeEP4Oi4vTuwUQEuUZFHmUMkdmMrqNAK2Ik18QtMjO/+/hApp00AeWHgYwkXOr5cbeEk6VnPx83U4j3i+8MZnI0JnOUetSFuMgqaSaROFPY4SqawPujVNX+Z9B6L4gaG0CPdjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cDB/qS7tZ49H21U3BLx4XtqyDIb18jGYtoF6+Sn+XKGQB20hLSTMHjLwLJMVlA6xPlVhy4xOyDixcKRTD2SHlLVTx46rJg4fx1FFEUsFIGi5L923li1A9XXeloUc9maQyw+/6sj4G24PtB2oHgdRUm5jf4sflgdfbgiV+/ptfo4=
Received: by 10.90.80.8 with SMTP id d8mr7077116agb.1183556026726;
        Wed, 04 Jul 2007 06:33:46 -0700 (PDT)
Received: from ?192.168.100.117? ( [72.66.70.164])
        by mx.google.com with ESMTP id 20sm21458409agb.2007.07.04.06.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jul 2007 06:33:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51612>

Beginning with commit "[66e46f37de3ed3211a8ae0e8fc09c063bc3a1e08] gitk: 
Store ids in rowrangelist and idrowranges rather than row numbers", gitk 
run on Cygwin encounters an error looking at the git repository. The 
error occurs during startup (just run gitk on master), with error:

can't read "commitrow(0,8572)": no such element in array
can't read "commitrow(0,8572)": no such element in array
    while executing
"lappend linenos $commitrow($curview,$rid)"
    (procedure "rowranges" line 14)
    invoked from within
"rowranges $id"
    (procedure "optimize_rows" line 21)
    invoked from within
"optimize_rows $rowoptim 0 [expr {$rowoptim + $nr}]"
    (procedure "layoutmore" line 16)
    invoked from within
"layoutmore $tlimit $allread"
    (procedure "chewcommits" line 9)
    invoked from within
"chewcommits 0"
    ("eval" body line 1)
    invoked from within
"eval $script"
    (procedure "dorunq" line 9)
    invoked from within
"dorunq"
    ("after" script)

This doesn't happen on my Linux box, so this is most likely due to a tcl 
feature introduced more recently than the tcl used in Cygwin (8.4.1). My 
guess would be that the more recent tcl is more forgiving of an 
attempted access to a non-existent element.

Mark
