From: pgit@pcharlan.com
Subject: Re: Unexpected "clean -Xd" behavior
Date: Thu, 19 Jan 2012 14:12:18 -0800
Message-ID: <3cb3bb5dbcc4ae803dbdb4a3ff052433.squirrel@webmail.pcharlan.com>
References: <4F1384AE.1050209@pcharlan.com>
    <20120119002904.GA14107@burratino>
    <CACsJy8AE+rwmOVUZez5GRXRHJsTy+W8ekzr59NTd7_C+gB0Byw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Pete Harlan" <pgit@pcharlan.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn Bohrer" <shawn.bohrer@gmail.com>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 23:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro0DZ-0000wM-3y
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 23:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab2ASWMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 17:12:20 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:49729 "EHLO
	homiemail-a55.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754134Ab2ASWMT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 17:12:19 -0500
Received: from homiemail-a55.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a55.g.dreamhost.com (Postfix) with ESMTP id CD62612C0DF;
	Thu, 19 Jan 2012 14:12:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id
	:in-reply-to:references:date:subject:from:to:cc:mime-version
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=jUfkE8MFRe71Mz4wT3D690tY8TM6gDTgmAyZHNZN6/xNa7s7Kj4G+1HjYVshs
	w5HR76o83Pq3Fy759JtszQ4RIDDQ/WdUO8dgu4SyU+j+CI9z0k4pGE2HurtnOTEL
	4bT39a28Yjyh7RzPIvqodlqGYL03+uWhGn7Wn+eDe19JfE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:in-reply-to:references:date:subject:from:to:cc:mime-version
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=LQ/O
	FB0Vg5/3G7ED2mYwdJENGrM=; b=nwjusaBsrsYIM/96DkopGuH5XXUTqMNyblKe
	T+u6XPjKs9ht7Ki/rF3T9G6oIZYq0VfLpQ7MTP+Ju84A80bejZE+4yqLC4Rpgrrt
	YvrFbPYjBlHhAt7DwzGa+hWiYefywGknFrDEU22Vv/tNO0sRzFChThM21IHdQgtC
	ISmBOIM=
Received: from webmail.pcharlan.com (caiajhbihbdd.dreamhost.com [208.97.187.133])
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a55.g.dreamhost.com (Postfix) with ESMTPA id 8839912C0D4;
	Thu, 19 Jan 2012 14:12:18 -0800 (PST)
Received: from 15.251.201.73 (proxying for 15.251.201.73)
        (SquirrelMail authenticated user pgit@pcharlan.com)
        by webmail.pcharlan.com with HTTP;
        Thu, 19 Jan 2012 14:12:18 -0800
In-Reply-To: <CACsJy8AE+rwmOVUZez5GRXRHJsTy+W8ekzr59NTd7_C+gB0Byw@mail.gmail.com>
User-Agent: SquirrelMail/1.4.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188842>

Thank you very much for looking at this.

2012/1/19 "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>:
> 2012/1/19 Jonathan Nieder <jrnieder@gmail.com>:
>> Pete Harlan wrote:
>>
>>> When a directory contains nothing but an ignored subdirectory, that
>>> subdirectory does not get removed by "git clean -Xdf".
>>>
>>> For example, in a new directory:
>>>
>>> # git init
>>> Initialized empty Git repository in /tmp/foo/.git/
>>> # echo a/ >.gitignore
>>> # git add .gitignore
>>> # git commit -m "Initial commit"
>>> [master (root-commit) c3af24c] Initial commit
>>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>>> =C2=A0create mode 100644 .gitignore
>>> # mkdir -p foo/a
>>> # touch foo/a/junk.o
>>> # git status
>>> # On branch master
>>> nothing to commit (working directory clean)
>>> # git clean -Xdn =C2=A0# <--- DOES NOT MENTION foo/a
>
> -X is to remove ignored files _only_ (DIR_SHOW_IGNORED flag). And
> "foo" is not ignored according to .gitignore, so it cuts short there
> and never gets to "foo/a". -x works.

But the presence of a tracked file in foo makes it not cut short there,=
 so
the logic seems a bit off.  (If we're interested in removing ignored fi=
les
only, then the ignored files (not a tracked file) should trigger us
looking into foo.  I don't know Git internals but I'm guessing it's not
quite that simple.)

> May be intentional, may be not
> (we hit a corner case). I don't know. Commit message b991625 might
> help:
>
>     dir.c: Omit non-excluded directories with dir->show_ignored
>
>     This makes "git-ls-files --others --directory --ignored" behave
>     as documented and consequently also fixes "git-clean -d -X".
>     Previously, git-clean would remove non-excluded directories
>     even when using the -X option.

It can (and does) leave foo behind (because it's not ignored), but it
would conform better to the -X documentation if the ignored files were
removed.

BTW the above commit doesn't affect the behavior in this example.

If a fix isn't desirable then as Jonathan said updating the documentati=
on
makes sense.  (And those of us using it as a poor man's "make clean" ca=
n
just fix our Makefiles instead...)

Thanks,

--Pete
