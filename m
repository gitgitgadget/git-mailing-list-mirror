From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Challenge: Importing Mozilla CVS into git
Date: Wed, 26 Jul 2006 17:08:18 -0400
Message-ID: <9e4733910607261408m6f3980fbxc1793ca432ef3b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 26 23:08:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5qcB-00045o-RA
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 23:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWGZVIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 17:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWGZVIU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 17:08:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:63475 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751154AbWGZVIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 17:08:20 -0400
Received: by ug-out-1314.google.com with SMTP id m3so3364243ugc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 14:08:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nRgbRdhLqJV/fFyv84O6D9irFc1kELt4TVnSJy+Np4x6bJhbrfH02MOI6ZWScef2DKpRaJRuiO2EnMBSabp047BTAu35PW6GFNIyzbAlG8v2N1zwm+DJnIStxSkzJbL5UayCDq0L/Gj8QFJsJzs4od3+VcXfxlsTgnVfLwWXkTM=
Received: by 10.78.122.11 with SMTP id u11mr3469084huc;
        Wed, 26 Jul 2006 14:08:18 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 14:08:18 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24248>

If anyone is looking for a project, it is still not possible to import
Mozilla CVS into git and then do increment updates. As I recall from
the last time I played with it, cvsps throws away some of the branches
because it thinks they are in a loop. parsecvs is unable to complete
the entire import without getting errors and aborting.

cvs2svn can import the entire Mozilla repository correctly. But it
imports it to svn and does not have incremental support.

Best solution would be to use the parser from parsecvs, apply the
change set detection algorithm from cvs2svn, and then add cvsps'
incremental update.

It's also not reasonable to fork git processes, there are about a
million change sets in Mozilla and it takes days of CPU time to do 1M
forks. The import app needs to use a library version of git. Another
tactic to reduce CPU time is to directly write pack files with the
delta in a first pass, and add the change set index in a later pass.

-- 
Jon Smirl
jonsmirl@gmail.com
