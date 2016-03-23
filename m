From: Jared Davison <jared@medical-objects.com.au>
Subject: Issue with git submodule update --init --depth=1 submodA
Date: Wed, 23 Mar 2016 18:28:02 +1000
Message-ID: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 09:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aie9U-0008Ig-Pv
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbcCWI2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:28:25 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35683 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbcCWI2W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:28:22 -0400
Received: by mail-vk0-f51.google.com with SMTP id e6so9908267vkh.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=momail-medical-objects-com-au.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=GQsjoIuKx8B8oH+CeugJK8sM/RFuaFd/mZeBJwLLt/8=;
        b=PnDECfLRwnULQjLxxP5Mwf7HieP/jpOonQQ5nSlITcHA7YfYSZ8Bayx83Kq7zZuATO
         VUbFO0r5U+PO0sdBjiqZdauZVG+G2bDhFQtXnxwOiDQL+JgCL+gp540T5WmhTZIijP+E
         k5crAtn9MuNYjiN6HdMlF1o7soQYDmE4e5VrmrYjBUOEj/UCz6GeWQvdz9nmZoxGvVnf
         igV8k0+eCDsjkI5TJIRqYgICsFRCF6uyeWXBfb7ZndeM6g7IBtXXXhhm7N8TyDYlQAxB
         RrFAZcBbBXDmR8IDWV/ySrnpA0fKuB59Uw8UThKglFpcgapuhtXfIsIYzXiVhpWxRaTf
         A5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=GQsjoIuKx8B8oH+CeugJK8sM/RFuaFd/mZeBJwLLt/8=;
        b=RIbOLdK7lYGz9aLvwiWTJ+ZbGLRlt44q7Lw3DWbYb7IS0fjRGmKfbEYV+/jkO5Dcx/
         1s7P03I2g3iqX9nJpGYEHU4dynRyormPdvQ6oK4Gp5DN4DyytjuewHCabWjA+sUMuHbt
         +DYGdadpcYASqjg1MeYAiDBkgpK86jmS9Taq8hu/8UL3TqFWD4nkoSiD728RqEYbpTB8
         UcmNI1DFZCu7+JzhWh0h3XdTXhLKvciLEjDjqJm5+RD1VaNaJj+G0W+qwE9s0A9peeq1
         lfSy2tapuZBGliY+nZ+85ZzyZlKaS3YkItkBWCzy19MfF7dwikyN2kw/K2zAZo6gE2mf
         IVIw==
X-Gm-Message-State: AD7BkJId1DEUUhFS2Dqzt96Nodjks00OuwjOKfh+7T3CDIg7uC0s3Ipy1I5pFyGDneesPhSrq1O2CGcjVsWnmw==
X-Received: by 10.176.2.231 with SMTP id 94mr665504uah.106.1458721701598; Wed,
 23 Mar 2016 01:28:21 -0700 (PDT)
Received: by 10.31.96.19 with HTTP; Wed, 23 Mar 2016 01:28:02 -0700 (PDT)
X-Google-Sender-Auth: UvA-QxoOdyhQZKZjYC4612Z8Hf4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289602>

Hello all,

I have encountered a problem with using submodules.

The problem occurs when using

repo-parent$ git submodule update --init --depth=1 submodA

Submodule 'submoduleA' (.../submoduleA.git) registered for path 'submoduleA'
Cloning into 'submoduleA'...
Fetched in submodule path 'submoduleA', but it did not contain
8a1c22151b510160d7b41a019d7642ab2cd5e085. Direct fetching of that
commit failed.

Note the --depth=1 argument.

This all works fine if the head of the submodA master branch is the
revision required by the repo-parent as shown in "git submodule list"

However, if submodA's history has progressed by one commit, then
--depth=2 is required and this works fine. --depth=1 will no longer
work and gives the error as above.

Does depth always have to be counted from the head or most recent
commit in the submodule branch?

Could depth be counted from the required commit reference by the
parent repo instead of the most recent? If so then --depth=1 could
work I think.

The reason I would like to do this is that the history actually
contains some fairly large files and I wish to clone only the history
for the current version of the files in that most recent commit. This
all works great until someone pushes a commit into the submodule. I am
using this as part of a continuous integration process which will
build branches that reference submodules where the referenced commit
may go back a long way back in history.

Trying to determine the correct depth parameter value to use is
impossible as with time it will be a growing amount as commits are
added to the submodule branch.

Another user found the same issue:  http://stackoverflow.com/a/25875273

I have just compiled the git from "next" branch source, "git version
2.8.0.rc4.233.g1aaf96d" and have confirmed this is still the
behaviour.

Thanks for reading my enquiry and for your thoughts on this topic.

Jared
