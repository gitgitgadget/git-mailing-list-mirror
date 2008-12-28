From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Git (svn) merge - but ignore certain commits?
Date: Sat, 27 Dec 2008 19:17:25 -0500
Message-ID: <eaa105840812271617n74406517x3335a05d224f5e0@mail.gmail.com>
References: <49562749.9060705@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 01:18:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjMn-000842-A0
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbYL1AR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 19:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbYL1AR2
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:17:28 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:42144 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbYL1AR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 19:17:27 -0500
Received: by gxk6 with SMTP id 6so3449027gxk.13
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 16:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=lUwODbDk4dyUZrc/lUrGx+RXhOqewd8fhuQKGXYn4mk=;
        b=TN8Qd6uuR0XP7jq3VG51e+iN4ylXeeD8Z4thD5ok/ITZhi1U/OErkKhw4OmAd2JW2q
         o2YliGQ/Tl5kgaTM3nzlQv03qwkAMpkPofD2Of0MmXGT00Y14SriHQ292FBjTAFvanL+
         WhqZJ7LccxHMTx8iVdDhMPMARkTt5Gse++i7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=K+8uYRVA22PKtfCHkvwBvglRBJKvjVavZ6E7D63ckasrq24t3BcAPdMvhfGC29iwwn
         Iq5s6q+QBtXqBj4Y02tEwMQSapIqY7tq2In7cX3AkjmFBbzE/ud6+tr95W/LQ9zNUBQj
         wXrPjfXjIOjOmtPCGLWZ2vB+TJ5T5wpWkEKSQ=
Received: by 10.65.200.13 with SMTP id c13mr9465287qbq.35.1230423445383;
        Sat, 27 Dec 2008 16:17:25 -0800 (PST)
Received: by 10.65.214.7 with HTTP; Sat, 27 Dec 2008 16:17:25 -0800 (PST)
In-Reply-To: <49562749.9060705@sneakemail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 7ab50f5d4d2daf65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104036>

On Sat, Dec 27, 2008 at 8:02 AM, "Peter Valdemar M=F8rch (Lists)" wrote=
:
>
> * And now the trick: "git merge" "gitnewbranch" back to master. But I=
 want
> to avoid the "git revert" of the few commits that weren't ready yet.
>
> * "git svn dcommit" master to get the new functionality into svn trun=
k.
>
> How do I "git merge" all of "gitnewbranch" except the reverts?

"git rebase -i trunk" after you "git merge". Delete the lines that
contain the will-be-reverted commits and the revert commits. Actually,
skip the reverts in the first place to save time.

Normally I wouldn't suggest it, since it will throw away your merge,
but "git svn dcommit" does an implicit rebase anyway, so you will lose
nothing.

> Is there a way to "git merge gitnewbranch" excluding the reverts, jus=
t the
> "new functionality", so the log of master doesn't even mention the re=
verts
> and so "git svn rebase" and "git svn dcommit" work properly?

If your branch is so ugly that you want to toss many of the commits
anyway, maybe "git merge --squash" is what you are looking for? Or
maybe you want to "git rebase -i" before merging?

> How do I do this "properly"?

Use many short-lived feature branches, not few long-lived generic
"development" branches. Merge-and-delete is easier than herding
reverts.

Peter Harris
