From: "lode leroy" <lode.leroy@gmail.com>
Subject: Re: Q: howto rebase
Date: Tue, 25 Sep 2007 16:54:33 +0200
Message-ID: <b41dbf4a0709250754o189d99fcn4767b37b9ebbdf06@mail.gmail.com>
References: <b41dbf4a0709250748l52b64155k65b6adb16e8dbcd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 16:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBoA-0006i3-7l
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 16:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbXIYOyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 10:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbXIYOyg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 10:54:36 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:21758 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbXIYOyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 10:54:35 -0400
Received: by el-out-1112.google.com with SMTP id v27so327879ele
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=a2bIa3YKMuZ5ZYXTP9WY+BTUqXVxcbPy3YWd8/MqCFI=;
        b=otBXkF7GkeEiUUZ2uxw/96jyGEKKrIAUForHKum8BFQb+4JbdLWvySE45aM8cdV3Bo3xo+WGR7/pjVChKEPj7UHGewunfKsxCHxbx7Nj5H2zOJds+cXJpBZroqELHnW6yr6pnX+RMs4efATXuLE8Ax7G6Qfzk3pQOkrdTFQurl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odVgBoXWaOAwuJ6EgFsnqfdfORWNAUEGYOAJhtK4+Fbw0WDb+p5lGkwYVxZ5OHx6HD1tDv+iOMqBkabzqgO5zQmvudsVjm/aTUtnx3QXdw9VwngXnA1B2PeWPF85QemrZUlB35YNxOZ92mU/iAkOvGrhhMPE7QT2xJNeUWXb9Ow=
Received: by 10.142.177.7 with SMTP id z7mr2236882wfe.1190732073954;
        Tue, 25 Sep 2007 07:54:33 -0700 (PDT)
Received: by 10.141.82.5 with HTTP; Tue, 25 Sep 2007 07:54:33 -0700 (PDT)
In-Reply-To: <b41dbf4a0709250748l52b64155k65b6adb16e8dbcd5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59132>

I'm trying to understand how rebase works, but I need some help to get it.
Suppose I do the following workflow... (see below)

In "version B" I introduce the "fix c", but in "version D" I realize
it should have
been in some other place. (commit D moves the fix to its proper place).
A-B-C-D-E

Now I want to 'rewrite history'.
I would like to move commit D after B
A-B-D'-C'-E

and then fold the commits B and D' into a single commit.
A-B'-C'-E

I somehow managed to get this done using "rebase -i"
by exchanging the 2 appropriate lines, and then deleting the second one,
but I'd like to understand how to do this from the command line...

Could anyone enlighten me? I've read git-rebase(1) several times,
but don't seem to get it right...


cat > file <<EOF
a
b
d
e
g
h
EOF
git add file
git commit -m 'A' -a
cat > file <<EOF
a
b
d
e
g
c
h
EOF
git commit -m 'B' -a
cat > file <<EOF
a
b
d
e
f
g
c
h
EOF
git commit -m 'C' -a
cat > file <<EOF
a
b
c
d
e
f
g
h
EOF
git commit -m 'D' -a
cat > file <<EOF
a
b
c
d
e
f
g
h
i
EOF
git commit -m 'E' -a
