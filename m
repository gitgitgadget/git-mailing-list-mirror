From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 17:18:32 -0500
Message-ID: <76718490912111418i6b59056eq69671979613749f7@mail.gmail.com>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
	 <200912111220.40844.jnareb@gmail.com>
	 <4B223C1E.6010403@drmicha.warpmail.net>
	 <200912111500.51982.jnareb@gmail.com>
	 <7v3a3h48lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJDot-0002iW-7U
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 23:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762668AbZLKWS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2009 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761542AbZLKWS0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 17:18:26 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:57448 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761317AbZLKWS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2009 17:18:26 -0500
Received: by iwn1 with SMTP id 1so772444iwn.33
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 14:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GKjXV7mKtCzvcWRKscq+G7Wgx7OxIiVfTypQq7Fh5Zk=;
        b=jNX3OTS/2dr0TqrT3N7ctMOP7q5qfjZ8OiXWF9aTGtdltU/7PsvlAPvqknUafCjtX4
         NheGkjFeKZcAG0au3jcyaHQmfJC0nif8up+eqZOmvjRgBnuj2X/4axcD5i51n64PG0U3
         Tf22I4TX1b8xzS6vjvIjhxbUNIA86504F0d9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uLkv6xZNoLkr5J9uyiZ20cv5SGpQO615j4z4RMBdJsgrJkYoCDG0YozlX4kaKl4oq1
         1LRi/gmXqq/0je9whnDRfoHC77AtgfZ2d5BRtzcQC9YvHq2iyeSCTEgT3+tAWxGeRUwE
         OcwL/pgz004Ol/mkSjToz8RNTiiQUvhe8fWIo=
Received: by 10.231.120.90 with SMTP id c26mr1876833ibr.1.1260569912602; Fri, 
	11 Dec 2009 14:18:32 -0800 (PST)
In-Reply-To: <7v3a3h48lz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135105>

On Fri, Dec 11, 2009 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0- This was done about only one year after git was born. =C2=A0Y=
ou should not
> =C2=A0 take it granted that the workflow it wanted to support makes s=
ense.
>
> =C2=A0 Considering that using "git add" to mark the resolution is to =
declare
> =C2=A0 that you are _finished_ with that path, using it for other pur=
poses
> =C2=A0 (e.g. leaving a note that says "I've looked at and have one po=
ssible
> =C2=A0 resolution in the file in the work tree, but I haven't verifie=
d the
> =C2=A0 result yet", which is what the commit talks about) is simply a=
n
> =C2=A0 (ab|mis)use of the index. =C2=A0Lossage of higher stage inform=
ation by this
> =C2=A0 misuse is user's problem, and there is this thing called pen &=
 pencil
> =C2=A0 the user can use for taking notes if s/he does not want to los=
e the
> =C2=A0 original conflict information from the index.

Just a little more data. What happened in my case was that I was using
a visual merge tool and accidentally saved instead of canceled, so git
mergetool automagically added my results. I had resolved about 15
files, and made a mistake with only one, so I was sad when I couldn't
determine how to unresolve that one file (at which point I saved off
the other 14 resolutions, reset, re-did the merge).

My intuition led me to try "git reset <path>" since that's how one
normally unstages additions to the index. But of course that didn't
work, where "of course" only makes sense if you know how the index is
used during a merge.

> In fact, considering that there are many ways conflicts can be left i=
n the
> index and there are only two ways that they are resolved in the index=
 by
> the user (and both eventually uses a single function to do so), it wo=
uld
> make perfect sense to do the following:
>
> [...excellent list of suggestions elided...]

Also, I think we could improve the output of "git status" during merge
resolution, both before and after conflicts have been resolved in a
file. Immediately after a conflict, the conflicted files are shown as
"unmerged":

$ git status
foo: needs merge
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	unmerged:   foo
#
no changes added to commit (use "git add" and/or "git commit -a")

"unmerged" is good. But the instruction to use "git checkout --
<file>" to discard changes is wrong in this context:

$ git checkout -- foo
error: path 'foo' is unmerged

Then, after resolving foo and adding it:

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   foo
#

Well, yes, I can use git reset, but that just keeps my side of the merg=
e.

So I think with your suggested changes to the index, we can do better
with the status output during a merge.

j.
