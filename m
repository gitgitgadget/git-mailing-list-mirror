From: Chris Patti <cpatti@gmail.com>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP files.
Date: Mon, 30 Aug 2010 12:27:22 -0400
Message-ID: <AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 18:27:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq7Ck-0006gN-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 18:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0H3Q1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 12:27:24 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49755 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936Ab0H3Q1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 12:27:23 -0400
Received: by bwz11 with SMTP id 11so3837893bwz.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cpUNpSfLz9SUlkNhVPQ+XpOI0xVddkqF2HPpP7HhLKg=;
        b=hVsrhmsee1Y7p687WUGQMZTf46kdu4OqEBBz3/AzMfbHlXTA/lFrUBJV+OVCx14XXY
         6b0wukwZVZZJ+d+3481ynZcJzSZDOTLbcpMsMMzx+LQ2NZOM1fEsluyHZMrDIUrXq7kJ
         dh0Ug/jSAOfnuAOT6zhYVnlVX5W/Dq1bPA+w0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=upFEdsLhARaCmRRjraAjH8txYegQehYwmtxyL5uSsZTPhIFk05/AqdL89q8ilJ7sp9
         wE4VYMCZEWltFKrTp4mIRzjcFh38R7sBagYYYmke2ceOx3B+waOAYPbZf0WU7O2jfjZL
         Z1jvLRtZ8900wgrUuc6qRzl99b9VEQQeYebgQ=
Received: by 10.204.68.136 with SMTP id v8mr3508994bki.88.1283185642224; Mon,
 30 Aug 2010 09:27:22 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Mon, 30 Aug 2010 09:27:22 -0700 (PDT)
In-Reply-To: <20100830141602.GF2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154828>

On Mon, Aug 30, 2010 at 10:16 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Chris Patti wrote:
>
>> That's great, thanks! =C2=A0That gets me the file names. =C2=A0Now, =
how do I get
>> to the contents of each file?
>
> Why not "git diff --raw" (or its plumbing equivalent "git diff-tree")=
?
>

OK, went down this path and hit a brick wall.  What if this is the
first time a new ref is being pushed?  Then, old-ref is 000000 and git
diff --raw throws up a hairball :)
---
[12:23][cpatti@build1:~/src/relengtest(test-branch)]$ git push origin
test-branch
Counting objects: 10, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 684 bytes, done.
Total 7 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (7/7), done.
ns: 9f75c41fe7ec26ddf318929d62ebb26f3c1d3d0c
os: 0000000000000000000000000000000000000000
refname: refs/heads/test-branch

fatal: bad object 0000000000000000000000000000000000000000
Syntax checker hook is malfunctioning.  Can't execute git diff --raw.
=46ailing gracefully and allowing this push.
To /home/git/relengtest
 * [new branch]      test-branch -> test-branch

Any further thoughts?

Thanks!
-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
