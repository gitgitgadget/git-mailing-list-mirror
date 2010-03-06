From: BJ Hargrave <bj@bjhargrave.com>
Subject: git-http-backend: hook output not delivered to client
Date: Sat, 6 Mar 2010 17:24:27 -0500
Message-ID: <3C07BFC0-BC5E-4901-A846-A337B5F1B8F4@bjhargrave.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 23:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No2QI-0004Rv-K1
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 23:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab0CFWYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 17:24:33 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54407 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab0CFWYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 17:24:32 -0500
Received: by gwb15 with SMTP id 15so2392695gwb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 14:24:31 -0800 (PST)
Received: by 10.101.128.31 with SMTP id f31mr5840399ann.33.1267914271182;
        Sat, 06 Mar 2010 14:24:31 -0800 (PST)
Received: from hargrave.hargrave.local (125.69.205.68.cfl.res.rr.com [68.205.69.125])
        by mx.google.com with ESMTPS id 4sm1137188ywd.58.2010.03.06.14.24.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 14:24:30 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141622>

I have compiled and installed git 1.7.0.1 on a RHEL4 box and am using Apache httpd with git-http-backend. I have developed a pre-receive hook to validate that incoming commits are from a list of committers. I have tested the hook and it correctly detects invalid committers, outputs error message and exits with a non-zero return code. 

If I push a commit from an invalid committer to a repo using ssh, the hook properly detects this. git-push displays the pre-receive hook's output messages and indicates the push failed.

However if I push a commit from an invalid committer to the repo using http (git-http-backend), the hook is run and detects the invalid committer but the output messages (stderr) end up in the httpd error log instead of being ferried back to git-push. git-push does exit with an error code but the user has no visible indication there was an error on the push. The git-push output look like everything went fine even though the push failed.

So the push properly fails in both cases because the hook exits with a non-zero return code, but it seems there is a problem with git-http-backend not ferrying the hook output messages back to the client. Has anyone seen this? Or have I some how configure the system wrong?

Thanks,
-- 

BJ Hargrave
