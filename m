From: Patrick Palka <patrick@parcs.ath.cx>
Subject: git-reset does not seem to respect GIT_WORK_TREE
Date: Fri, 14 Feb 2014 13:57:36 -0500
Message-ID: <CA+C-WL_x=+OPn4Ec-6Y13w1+dd5G5v8W6=i15WH47pyP3ggjuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 19:57:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WENxF-0000kr-U5
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 19:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaBNS5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 13:57:38 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64870 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaBNS5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 13:57:37 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so12709675pbc.14
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 10:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=/S+xzROruan0aAd5Os9z6vVh8vICxCrbJi1MkFAE2CI=;
        b=XfTa03Dtmb93SnWneHDJM3IVuxr3OhoqoMx4hIhTlge1oJysMKDerVg3gRkD5v61fX
         hZd44WrRAdxE7mQxN6L1ECmy2DBeuvMWQhOn95QpK5NFtpcpyCp2sPcPkGREWQw2cBeo
         IJM4EeOluxmmbZN/CkdRJJJvkD5POGR+I0q/jvYSPAAdMq0ws/9Viwbi6FnFlO9kJORb
         yn+m0x+Wj75cBizq0N051mmEkigJQV1F5c1nLSJtqGyzvgX83xj5vOJjGRpRbXTqnCHw
         934wqzvyB2Dm6VCaQj7bMZd/dHwZIxuS8vmSk6uBzKFA5PcMItfzT5cTHxMZUbt5fVEs
         0q7w==
X-Gm-Message-State: ALoCoQme4Kg75bDq28dVVmma7LNI8BmF86edsc7wp6tZiJhUHhNBR36pufZvg/zG3tfhSbNHTlVa
X-Received: by 10.68.139.73 with SMTP id qw9mr10722581pbb.121.1392404256923;
 Fri, 14 Feb 2014 10:57:36 -0800 (PST)
Received: by 10.70.54.162 with HTTP; Fri, 14 Feb 2014 10:57:36 -0800 (PST)
X-Originating-IP: [67.83.169.196]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242119>

Hi everyone,

I noticed that git-reset does not seem to respect GIT_WORK_TREE.  Here
is a simplified test case:

$ mkdir src_dir && cd src_dir
$ git init
$ touch A && git add A && git commit -m "Dummy commit."
$ mkdir ../build_dir && cd ../build_dir
$ export GIT_WORK_TREE=../src_dir
$ export GIT_DIR=../src_dir/.git
$ git reset
Unstaged changes after reset:
D       A

The final command "git reset" erroneously suggests that the file "A"
does not exist in the working tree.  Does anybody know why git-reset
behaves this way?

Thanks,
Patrick
