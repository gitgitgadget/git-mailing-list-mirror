From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [ITCH] pull.default
Date: Tue, 19 Mar 2013 00:09:37 +0530
Message-ID: <CALkWK0nT9hE_kRt3DLXfP45OwCSLurMOzuTqepxhkWjagbFDUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 19:40:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHeyw-00012q-7F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 19:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab3CRSj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 14:39:58 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49380 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab3CRSj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 14:39:58 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so7369574iea.21
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=vkQO12tMDkASqGPvkdrCs4jd3c043AG+TTBw8LVyuNY=;
        b=fwMioIrUhGm0JYBVghtK2QXEonZEVayXGW+WwJA9ecz3wwuSngAujM1Ap1qfqo4QbG
         o8t52u9Tp9QEpJg2Ayp76ZdUMRXKJ88Gz0xZAUxVso8BItsyp+OMdVv7edYNmzwwMYK6
         zmJoIZ8qoXuaW37wdn+LRRXPnjeIQktZmJ/djFOSDnx2FbGpfCV8VGFA1CoKb1Vm6FaK
         igdT2kXcqSRTINuoZYJ7ZNUVbLYeTMD8jVvgKstXkdlhZuynbgCbTaHqwqQ5PZBr+aXD
         mw+BGnrdN27xOquNbG+UX9gpN/TEI8OhRuNeXeh6SHRZvgxkrPOmzK5je+IwmcJI9CHR
         /WEQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr57295igb.12.1363631997679; Mon,
 18 Mar 2013 11:39:57 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 11:39:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218436>

Hi,

I usually use `git fetch`, inspect state, and then merge/ rebase
accordingly.  Unfortunately, this is very sub-optimal as I can
automate this 80% of the time.  I want to be able to decide what to do
on a repository-specific basis, and hence propose a pull.default which
can be set to the following:
1. fetch.  Just fetch.  (I will set this as my default in ~/.gitconfig)
2. fast-forward.  Fetch.  If the FETCH_HEAD is directly ahead of HEAD,
`stash`, merge, and stash apply.  Otherwise, do nothing.
3. rebase.  Fetch.  stash, rebase, stash apply. `git pull n` will do
rebase --onto master HEAD~n instead of rebase.
4. reset.  Fetch, stash, reset --hard FETCH_HEAD, stash apply.

Ofcourse, it should print a message saying what it did at the end.

What do you think?

Ram
