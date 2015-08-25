From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Tue, 25 Aug 2015 23:15:21 +0530
Message-ID: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 19:46:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUIIG-000553-1H
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbHYRpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:45:52 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34121 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbHYRpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:45:51 -0400
Received: by obbfr1 with SMTP id fr1so148562213obb.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=wClJwkRldxYLuGNefRasrsJIGipOmNbqhXFIIf6rRcs=;
        b=Kjj2qvAUzk0MviY+GnEH2andNPItS2SNACkdj4sBV0PH6+Ntj/hBqCf/9Ah/YqHRVK
         juodetlfzlGKL17RbGkWJMV91W7fnirkYTS75y3Q/SKIRGJQez3mBHOTSFqDusHVot61
         hRw0P8XpuH7xJbOx0GMft0GNVoQV17a4xOI4mn/+g/lHZgSDGX0wk1suO2MHwGxoGT/p
         NcTFM/a9wC5FlmuUZmAYwX44hcs1Vb1w09k29wg91uD26LazhTAFkWWBtco73a9C/W4L
         pMPDVL0rjV/V+LP09iLm0OtMEsPkYIsp0dJBkWSbh1ujqiuJT0wefcop1Wa73CvZrMXp
         GLfA==
X-Received: by 10.182.33.39 with SMTP id o7mr9344930obi.42.1440524750741; Tue,
 25 Aug 2015 10:45:50 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 10:45:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276551>

I'm working on porting over the printing options of ref-filter to `git
branch -l`.
This is a follow up to
http://article.gmane.org/gmane.comp.version-control.git/276377

Theres a slight issue with this which I'd like to discuss about.

When we use `-a` option in `git branch -l`
It lists local branches and remotes with each having a different output format.
This with reference to ref-filter would mean either

1. Change format in between local and remote refs
2. Have a format like %(if)...local check....%(then)....local branch
format....%(else)....remote format %(end).

I prefer the latter, but that might lead to a large format. Any suggestions?


-- 
Regards,
Karthik Nayak
