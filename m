From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: failed to lock
Date: Wed, 14 Apr 2010 17:02:52 -0400
Message-ID: <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
References: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:10:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29r7-0002uZ-1V
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab0DNVKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:10:34 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46694 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0DNVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:10:33 -0400
Received: by pwj9 with SMTP id 9so603746pwj.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type;
        bh=cUcdt2j7BSL9sxlUX7RtQuXBNjYF/tbA82lSZ86dYY8=;
        b=AulF1fZhQufI3HfBLW4mFdPPfJUxtXT0XIZOqmeUJtXMCOAxJyAiZ7Ol9WvdPfiC75
         DUY5+47rFJMpcpgNmKOR3fchHQCZ7u60gI+IOGWJMI2Y/dQZeyjvxb3yr9S/IwyQrbNN
         NAWlDy3mqK7g/ppzJkClR7GwMNrVJXJcKSkiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=M8Gxz0k/UPJEoKpqVOkMq8eSX+sZLVUMSQZeZRTnGmTmGVuwQ4zy+apGLlHXXaxuqH
         7dF0cuU691HgHXhuBrnXXC7TWmY95s8ICCj+ekrD/lrNP4M4aSrLe5t1mDaZfZuoz1Nc
         qnOPZ21GCvJf8NOQFAQyQREr3NL/LKEXIy4A0=
Received: by 10.231.36.9 with HTTP; Wed, 14 Apr 2010 14:02:52 -0700 (PDT)
In-Reply-To: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
Received: by 10.142.249.16 with SMTP id w16mr3693637wfh.134.1271278972773; 
	Wed, 14 Apr 2010 14:02:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144916>

On Wed, Apr 14, 2010 at 4:49 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> The problem is reproducible. Any idea where I should start debugging it?

Ah, this is the problem:

$ git push mirror
Total 0 (delta 0), reused 0 (delta 0)
error: Ref refs/remotes/origin/master is at
81358fbe72926d74bdeda85669d655e144572c48 but expected
3c0a87afc2e9248890dd6de40b5039bcb48c8516
remote: error: failed to lock refs/remotes/origin/master
To ssh://mirror/repo
   3c0a87a..81358fb  origin/HEAD -> origin/HEAD
 ! [remote rejected] origin/master -> origin/master (failed to lock)
error: failed to push some refs to 'ssh://mirror/repo'

The origin/HEAD symref and --mirror do not get along together. Hmm.

j.
