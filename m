From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to 
	committer with --mine
Date: Tue, 3 Nov 2009 16:21:50 -0200
Message-ID: <55bacdd30911031021s6d5ac03aka0f0b5aae273db1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5O1P-0003IX-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 19:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbZKCSWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbZKCSWG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 13:22:06 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:44824 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZKCSWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 13:22:05 -0500
Received: by ywh40 with SMTP id 40so5638816ywh.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 10:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=WMHHZWW5S6xAotNGRvHxzotf0LrCJsalWpKb+CohmQM=;
        b=bTqRalGXyVe50lVFklhg20ChgfjXPg6qgnlL5Op55Mp5yJyJlg0/kyDEuNBDGS685P
         Z5oOHcO8TUE/vdnBlcP+z3U5dS9rCJtWxDlqBoO+9AJ8EkbpG6TB61uCtuAdGSUvgt/1
         O0TADve3wHRmIIaD/BVyAPe60nYsTfNuZzgGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=NeLAdPRLRviKbIo2RBbh/8IpBTn8sWR6I4Gz9xd7RJQBeYz9lKysFAbl31HqD9Nq7+
         ulZuVemJMvnvD946L7UssJfCy1x/O9Ll5CBN3w6dqPKDnqHuj666klfaFJ12ly+HG2iV
         0F3rh+K46PwPHNS7xE0DRkwEEz2moovkvBRl4=
Received: by 10.150.90.20 with SMTP id n20mr767062ybb.149.1257272530103; Tue, 
	03 Nov 2009 10:22:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131985>

Please don't forget your comments down here wasn't about the last sent
patch.  Please see it, in case you don't have it, at:
http://marc.info/?l=3Dgit&m=3D125712272606721&w=3D2

Anyway I am answering your comments down here:

2009/11/2 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> 2009/11/1 Junio C Hamano <gitster@pobox.com>:
>>> Erick Mattos <erick.mattos@gmail.com> writes:
>>>
>>>>> =C2=A0 =C2=A0% git commit --claim --author=3D'Erick Mattos <eric@=
mattos>' -C HEAD
>>>>>
>>>>> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do =
you have a test
>>>>> that catches this error?
>>>>
>>>> It works as intended. =C2=A0Both together.
>>>
>>> That does not make any sense. =C2=A0If you are saying this is yours=
 and it is
>>> his at the same time, there can be no sane way to work "as intended=
", no?.
>>
>> I am adding a new option not changing the option --author already in
>> git. =C2=A0So it does work together.
>
> Somebody who says "this commit is mine, and its author is this other
> person" is not making any sense. =C2=A0The resulting commit can eithe=
r have
> that person (i.e. the committer) as the author, which is what the "cl=
aim"
> option means, or it can have the person named with --author as the au=
thor,
> but both cannot be true at the same time.
>
> When you introduce a new option, sometimes it cannot sanely be used w=
ith
> an existing option. =C2=A0In such a case, two options (the new one an=
d the
> existing one) are called mutually exclusive. =C2=A0And you add some c=
ode to
> catch an user error to use them together.

As --author text says: "override author for commit".
As I see, something that OVERRIDES supersedes everything else.
IMHO --author shouldn't be blocked by the new option.  Probably your
point is about "mine" name.
Cutting --author away would make impossible for someone to force a new
author with a new timestamp in case he is templating.  Of course he
can be using the --author because he is doing a change in a computer
not his own or something alike.  So I would not wipe "author" out from
the new option.
Please don't forget that I am just being a small contributor.  I am
just suggesting things.  You have the final word.

>>>>>> + =C2=A0 =C2=A0 git commit -c HEAD <<EOF
>>>>>> + =C2=A0 =C2=A0 "Changed"
>>>>>> + =C2=A0 =C2=A0 EOF &&
>>>>>
>>>>> What editor is reading this "Changed"?
>>>>
>>>> Nobody cares... =C2=A0Just a text to change the file.
>>>
>>> I actually care. =C2=A0Who uses that Changed string, and where does=
 it end up
>>> with? =C2=A0At the end of the log message? =C2=A0At the beginning? =
=C2=A0What "file"?
>>
>> I didn't get it. =C2=A0-c option does not accept -m option and start=
s an
>> editor to change the message. =C2=A0The text "Changed is just a forc=
ed
>> message. =C2=A0I can not use an editor in interactive mode in a scri=
pt...
>
> How are the existing tests that try "commit -c" do this? =C2=A0I do n=
ot think
> there is any here-text redirect into "git commit".

Sorry, it was automatic for me.  Just supposing a here-text...   :-)
I am going to fix it.

> It is sometimes easier to show by example than by giving nudging word=
s
> that only show direction, so here is a suggested rewrite on top of yo=
ur
> patch. =C2=A0I am not very happy with the option name "mine" either, =
but at
> least I think this gets the semantics right.

We could call it --reset-author.  What do you think?

> + =C2=A0 =C2=A0 =C2=A0 if (force_author && renew_authorship)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Using both --=
mine and --author does not make sense");
> +

As previously said up there.
