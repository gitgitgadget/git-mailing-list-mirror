From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 11:51:11 +0200
Message-ID: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 11:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCpXq-0002wj-BP
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 11:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835Ab2C1Jvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 05:51:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61593 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2C1Jvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 05:51:52 -0400
Received: by pbcun15 with SMTP id un15so1553923pbc.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type;
        bh=68Qt3Hxu1E4rIlzlPgEkBppNpGr42Jt0nHE0wKneY+U=;
        b=WkPbYQdRzaan0IJ3LE3Yfb0yaaaVoUrx8G7FmXUL7WeFZY1SxBCiO2njBPIV/8/1CH
         0DxY78aW1J7Jc7FlkD7rWzBqpBvSnJNBCCvz0kQgHUbWk5ODeb1eoczhLZg8BxmAjN2Q
         /8Xlc/MPy3PPcszV/+Ntplv5OLVRGuk5np2tRLNTHmk6mY3VBzYb154yc+qsBp2zveaF
         m7WUUZW+9CUKHRODcigQkFBnc3zwVm5s0hUcZYe4T0hKPMQiwBe6veIMTwzPZj2B9Ck6
         hxvQi0IhhyCzhlqM5LDUBC7XFpyQOfWk8oYCCCcX8YrHb5s8M1xQgZbonc7X6jhKMnpv
         KwHw==
Received: by 10.68.196.163 with SMTP id in3mr71044871pbc.118.1332928311531;
 Wed, 28 Mar 2012 02:51:51 -0700 (PDT)
Received: by 10.68.1.135 with HTTP; Wed, 28 Mar 2012 02:51:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194115>

I'm running git version 1.7.9.msysgit.0.390.g01fca.dirty, and I've
noticed a puzzling behavior with "git add -p" on a conflicted file: it
seems to simply spew the diff and exit the process.

Is this the expected behavior? It doesn't seem very useful to me...

Here's how to reproduce the behavior:

git init /tmp/git-add--p-conflict
cd /tmp/git-add--p-conflict/
echo "foo" > bar.txt
git add bar.txt
git commit -m.
echo "bar" >> bar.txt
git stash save
echo "baz" >> bar.txt
git commit -am.
git stash pop
git add -p bar.txt
