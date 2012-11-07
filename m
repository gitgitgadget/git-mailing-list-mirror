From: "Jack O'Connor" <oconnor663@gmail.com>
Subject: Bug? Subtree merge seems to choke on trailing slashes.
Date: Tue, 6 Nov 2012 17:58:34 -0800
Message-ID: <CA+6di1m7OCMjahP9sN3NcYdxLRRi4vmttFa5=pnHrgKp=E4+jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 02:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVuvJ-0004QJ-FE
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 02:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab2KGB7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 20:59:07 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56410 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2KGB7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 20:59:06 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so1081814vbb.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9hi/1TpWUWPDug5xBoAfC/nfkyIM0o0EZSPv4dI2ch4=;
        b=fL9DF6F/OA1ZJmqb4l4+YikQKmTBfMxTE7Fj3W7L2AxR23xKt3SpGDlbCcngQaqMtn
         +Bpc228CTt5FPwDPbk64VMmtBHkH6n9NyHmvEtLlAcXcOe58LoI554mGliXdHZtonq0M
         bBqP4bMsVYO+/Plj+yRlCRYzDNtbADwkqxQZOTAzaV5DX/myTHGZyYEphN+pl7kIx5oq
         dIfR7Zq8vO+tbUo/+9SMeM4waQvIqDR3yMXUZw7hID/jpxVn5kw6z7TrSJLFF+DGUEnh
         kA6u8TUCOnOxXov395BEpyb4SwIPMidWZK0jzjQfQc8Rkt8CXVSOQkEcIN8u3by55JLB
         /wSA==
Received: by 10.220.150.82 with SMTP id x18mr2738810vcv.73.1352253545247; Tue,
 06 Nov 2012 17:59:05 -0800 (PST)
Received: by 10.220.113.210 with HTTP; Tue, 6 Nov 2012 17:58:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209129>

I'm summarizing from here:
http://stackoverflow.com/questions/5904256/git-subtree-merge-into-a-deeply-nested-subdirectory

Quick repro:
1) I do an initial subtree merge in what I think is the standard way
(http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html).
My prefix is simply "test/".
2) I try to merge more upstream changes on top of that with the
following command:
git merge --strategy-option=subtree='test/' $upstream_stuff
3) Git fails with an obscure error:
fatal: entry  not found in tree daf4d0f0a20b8b6ec007be9fcafeac84a6eba4f0

If I remove the trailing slash from the command in step 2, it works just fine:
git merge --strategy-option=subtree='test' $upstream_stuff

Note in the error message above, there's a double space after "entry".
Is it looking for a tree with an empty name? Did my trailing slash
imply a directory named empty-string?

Thanks for your help.

-- Jack O'Connor
