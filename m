From: Christian Goetze <christian.goetze@appdynamics.com>
Subject: Pulling git tags from multiple sources incorrectly reports stale tags
Date: Thu, 19 May 2016 16:25:25 -0700
Message-ID: <CACuwOqNZC3NipCVJ5YbTA_0d-P+i2KmQ5V2HzYPhZFQn4Kuwkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 01:25:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XJq-0006uJ-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbcESXZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:25:27 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36265 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbcESXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:25:26 -0400
Received: by mail-io0-f171.google.com with SMTP id b78so10366522ioj.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 16:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appdynamics.com; s=google;
        h=mime-version:date:message-id:subject:from:to;
        bh=ZEilXg887d/XmZxTJyPK9P9mLRZn4hDry1qlhV+/Lbs=;
        b=Z0i2NfBK0cuzJTEq+sGy9lbbVxnV7SZ9uko8Xy0aP66L7NgB2kVyxFXB0D90zSRstp
         ujBm3DvC3J8YdM0e+1qGCJDFpd14sKyzuAvoOU6gk1zo35W3b0mQq9I+1OUOMBL0k0cs
         IZ3ofXzvOAnQZYMrFdV3VNbaytLTDftKWVNUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZEilXg887d/XmZxTJyPK9P9mLRZn4hDry1qlhV+/Lbs=;
        b=XpImC9D44X7UYlsjLR0E0WccfwCn5aicxRl5+HBKLVY75Fk7IlRn47kcN/vESJ9jf8
         ZqkUsbuI8POM7oCuJa8IVldfqopGeptLq+yIznzOowawuwXu6w+TXh4B+7EdtznT66kU
         wP1ieerj2UFsI7hCUSWBxSowujqh68qwZbheuxVCsrnPv5WJ0NJzJToHtRYq4lKG5rTS
         XpOHGhr8fQC/UVl9AYb7C0PX//ONjXsAR5QssBoz039DyQEsma6zqmHYMO8hF5biP+ie
         pZe6csVmRNBh1i3d0OMDp4Y/Hky5XIcqk9pFmxLt9okhuC5zSdYFVWiX8xklXA0T6bUu
         EnTw==
X-Gm-Message-State: AOPr4FXnmTSThYU8LwjRmBB+d97eR6epKVGE4p9//SijzhbCvvRdk+QYdpf3JmhalY6z0IxQ+Wi9MXl2v/OsrNvT
X-Received: by 10.36.69.33 with SMTP id y33mr297952ita.84.1463700325909; Thu,
 19 May 2016 16:25:25 -0700 (PDT)
Received: by 10.79.131.67 with HTTP; Thu, 19 May 2016 16:25:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295133>

See https://gist.github.com/cg-soft/62ac3529cf9ad6f6586e07866de43bc4
and discussion here:
http://stackoverflow.com/questions/37330041/merging-git-tags-from-multiple-reference-locations

Essentially, using this git config to pull tags from multiple remote
refs works fine:

[remote "origin"]
    url = /Users/christian.goetze/git/tag-merge-demo/origin
    fetch = +refs/heads/*:refs/remotes/origin/*
    fetch = +refs/private/tags/*:refs/tags/*
    fetch = +refs/tags/*:refs/tags/*

But this, leaving out the last line,  doesn't:

[remote "origin"]
    url = /Users/christian.goetze/git/tag-merge-demo/origin
    fetch = +refs/heads/*:refs/remotes/origin/*
    fetch = +refs/private/tags/*:refs/tags/*

I would expect either to work the same way.
