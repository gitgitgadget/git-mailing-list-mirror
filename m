From: David Reitter <david.reitter@gmail.com>
Subject: merging two equivalent branches
Date: Thu, 7 Jan 2010 13:17:35 -0500
Message-ID: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 19:18:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwve-0004rH-5q
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab0AGSRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 13:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753253Ab0AGSRq
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:17:46 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:44507 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0AGSRp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:17:45 -0500
Received: by yxe26 with SMTP id 26so17917739yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=ZLyaz5surzQEBOe86dgSILN/UfnL904DR9/mWUWMfvo=;
        b=HBd/0W2Ggmnpb1yJPQsVnSOkzzDWApeX+ylY8vucDcGH8X+1XwdNZxTrY0QRieExlB
         tZsU3F3nkRc+o1Zru8Fzo2B6Bj8CTyXe6dhmCa3S3n+oShAH1em0tfmYYSqt0IUYTv+W
         Y09cZvLe1edVyxjoXFNP72fGM0bKoqop+bEYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=ObEzwnP67v+09YRBmIWsA2GNikYO/PPvLHohHaeQsyznWPxCazvoj6HhvFNhmtjFZs
         KWH0LlQRshfHAOQDNccHWUSgp/Rc/5U9HR0Ze82weCo/JLxkCRhJBq5S7Qzmi19KNeFo
         /pNOjZOC/AFhm6cdUgl+9kzi1InWHjiLaty6k=
Received: by 10.150.75.16 with SMTP id x16mr32190542yba.251.1262888263473;
        Thu, 07 Jan 2010 10:17:43 -0800 (PST)
Received: from cmu-365842.wv.cc.cmu.edu (CMU-365842.WV.CC.CMU.EDU [128.237.225.56])
        by mx.google.com with ESMTPS id 15sm8840782yxh.58.2010.01.07.10.17.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 10:17:41 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136377>

Hello,

I have a problem with my git project, resulting from an upstream branch beyond my control being rewritten.

Can I specify parents for a revision whose history is hidden from git-log?

Concretely, I need to merge two branches that represent different conversions of the same original CVS branch (with >100k revisions).  
I've been working with converted branch B, but now we have a new branch A.  Revisions A150 and B145 correspond to the same tree, but there is no common ancestor:

A1 -> A2 -> A3 -> .. -> A150 (A)
B1 -> B2 -> B3 -> .. -> B145 (B)

I have a published downstream branch C with my own changes that started somewhere from B and has occasionally merged new developments from B.  I'd now like to switch it to A.     Future development will show up on A and I'd like to be able to merge it into C when that happens.

Using "git-merge -s ours" does this job nicely so that I can pull further development from the remote branch into mine.

However, git-log follows both parents of the new merge commit and thus shows many redundant commits.  This is OK from the logical perspective, but because I have used the "ours" merge strategy, we're guaranteed to have only one revisions in the final tree.  Thus, I wouldn't want to see all these revisions in the resulting branch.  Grafts/rewrites or git-replace would probably lead to the same issue, I reckon.

Thanks for your help.