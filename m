From: John Feminella <jxf@jxf.me>
Subject: Rebasing merge commit fails during --preserve-merges when ancestor
 merge is deleted
Date: Wed, 23 Oct 2013 15:25:57 -0400
Message-ID: <CAAcFwk5Vd2+SJWQaos9o9UX1Za1yV=oEUWCj1VmD87BQP0u6Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 23 21:26:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ44o-0007c3-JY
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 21:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab3JWT0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 15:26:39 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:36916 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab3JWT0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 15:26:38 -0400
Received: by mail-ve0-f170.google.com with SMTP id db12so863041veb.15
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 12:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Z9cQ/cxf1wF4fybrAzBs2L516hjJi2lthXNC4K8hqk8=;
        b=BQpgzkG7eXic+wwrEacOZLK1Zzl5Hj3ndd+n4IK4oYOPzY154x8r4jjEH7jbxvZcoj
         Az/vq+YZAO1XomPSscdC78+gCJcsTOAYFsy6pH2oZux1cGxpcC1UEan6O8nPLs8scSpc
         jTEvLHTTefTBi9EclyHlbMp2fqm4jl/UM5r/j/dpoxAOqD+2sOiCy93483cu7J+1g1Xm
         DRlcdoI7+W3bAcjHiS2cWfEJjfhwaTRWV3K2VU2sgA/PaBBvjj1eIBJc4CgvFlxIc2MA
         RuxbLov7ANt2a4GHnesm0FJb5AHDa2UGQTVvUbpp3CcjFEvuV/0PTkzLcmw8v4N1PU/3
         EC4g==
X-Gm-Message-State: ALoCoQlYQFMIZdStNhDiJmaFnuDGMHwhBgoJ52Ovxx1W6x0Livd3pW1R9B2pUlSouUOrrEwIeA0H
X-Received: by 10.58.136.231 with SMTP id qd7mr2306290veb.1.1382556397960;
 Wed, 23 Oct 2013 12:26:37 -0700 (PDT)
Received: by 10.58.144.103 with HTTP; Wed, 23 Oct 2013 12:25:57 -0700 (PDT)
X-Originating-IP: [24.125.129.33]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236550>

I have this situation and an accompanying sample repository
reproducing the issue:

https://gist.github.com/fj/7124501/raw/8d37058c1452379d0ae58bd87b0b9e0380bd80b2/gistfile1.txt

* I would like to rebase and delete a spurious ancestor merge commit
(bbd8966 in the example).

* When I do that, however, a successor merge commit (97ba1d7) that has
the ancestor merge commit (bbd8966) fails with the noted error:

=====
error: Commit 97ba1d761f60b901f56766886da4ed678e56abea is a merge but
no -m option was given. fatal: cherry-pick failed Could not pick
97ba1d761f60b901f56766886da4ed678e56abea
=====
The expected result for me is that a new merge commit that merges
6b8c765 (which now occupies the topological spot of the previous
spurious commit, bbd8966) and 11d8b92.

What am I doing wrong here? Is there a way to fix multiple instances
of this in a history without doing tedious cherry-picking?

Thanks!

~ jf
