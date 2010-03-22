From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 11:14:03 -0300
Message-ID: <55bacdd31003220714qa9fb915k9fe152019b4d88b4@mail.gmail.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 
	<3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 15:14:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtiOk-0001qU-EA
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab0CVOOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 10:14:25 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:46860 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab0CVOOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 10:14:24 -0400
Received: by yxe12 with SMTP id 12so1807616yxe.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3hz5m83ixePdRja9ZZhREMkk2fsCxaqObMQErZz40ZI=;
        b=cRsI5IQc/8IgBGRzZagb72w87BXcbgXeNJVsvLuMxEIGK/HgmENQf1czrnGo0NI/KP
         L+5lkIEBuSl9OSVQuUZgvZAIKAAJSzrMZqwAsjW/a9UrVbJN+TW+ju+6H9Kp2xCzqduH
         fjLU3T+XAQAm1bhqPLmAXgrVcj1voSjObY5hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qfOg0lGgXEUkmPQVbgUhxPloAsHzJYNcVvQVf/rMkU4EGhR+dV/FiXoUfMAABfBamr
         2hZVL//VWyXu8J3oKU7K/v7ibLMsH5UdltRKS/rJAs8KXmyxstzzU0qyuz9twk7rGpPq
         vIfPvoRFyYjUhRzyC5h4w91OwMaSi8BNovLT0=
Received: by 10.150.184.14 with SMTP id h14mr3275658ybf.51.1269267263083; Mon, 
	22 Mar 2010 07:14:23 -0700 (PDT)
In-Reply-To: <3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142932>

Hi,

2010/3/22 Chris Johnsen <chris_johnsen@pobox.com>:
> On 2010 Mar 21, at 10:34, Erick Mattos wrote:
>>
>> Similar to -b, --orphan creates a new branch, but it starts without =
any
>> commit. =C2=A0After running "git checkout --orphan newbranch", you a=
re on a
>> new branch "newbranch", and the first commit you create from this st=
ate
>> will start a new history without any ancestry.
>>
>> "git checkout --orphan" keeps the index and the working tree files
>> intact in order to make it convenient for creating a new history who=
se
>> trees resemble the ones from the original branch.
>>
>> When creating a branch whose trees have no resemblance to the ones f=
rom
>> the original branch, it may be easier to start work on the new branc=
h by
>> untracking and removing all working tree files that came from the
>> original branch, by running a 'git rm -rf .' immediately after runni=
ng
>
> Maybe use double quotes in the above command to be consistent with th=
e rest
> of inline commands in the commit message.
>
>> "checkout --orphan".
>>
>> Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
>> ---
>
>> diff --git a/Documentation/git-checkout.txt
>> b/Documentation/git-checkout.txt
>> index 37c1810..5a50997 100644
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>
>> @@ -90,6 +90,25 @@ explicitly give a name with '-b' in such a case.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Create the new branch's reflog; see linkg=
it:git-branch[1] for
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0details.
>>
>> +--orphan::
>> + =C2=A0 =C2=A0 =C2=A0 Create a new branch named <new_branch>, unpar=
ented to any other
>> + =C2=A0 =C2=A0 =C2=A0 branch. =C2=A0The new branch you switch to do=
es not have any commit
>> + =C2=A0 =C2=A0 =C2=A0 and after the first one it will become the ro=
ot of a new history
>> + =C2=A0 =C2=A0 =C2=A0 completely unconnected from all the other bra=
nches.
>> ++
>> +When you use "--orphan", a new unparented branch is created having =
the
>> +index and the working tree intact. =C2=A0This allows you to start a=
 new
>> +history that records set of paths similar to that of the start-poin=
t
>> +commit, which is useful when you want to keep different branches fo=
r
>> +different audiences you are working to like when you have an open s=
ource
>> +and commercial versions of a software, for example.
>> ++
>> +If you want to start a disconnected history that records set of pat=
hs
>> +totally different from the original branch, you may want to first c=
lear
>> +the index and the working tree, by running "git rm -rf ." from the
>> +top-level of the working tree, before preparing your files (by copy=
ing
>> +from elsewhere, extracting a tarball, etc.) in the working tree.
>> +
>> =C2=A0-m::
>> =C2=A0--merge::
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0When switching branches,
>
> (American) English is my first language, but that does not imply that=
 I
> speak, read, or write perfectly.
>
> "unparented" sounds a bit awkward to me.
>
> "unconnected from all": the usual constructions are "unconnected to",
> "connected to" or "disconnected from"; might be better as "disconnect=
ed from
> all" or "not connected to any"
>
> "unparented" sounds odd to me, especially "unparented to". For "unpar=
ented
> branch", I would use "branch without parents", maybe "history-free br=
anch".
>
> I think the repeated uses of "unparented" in the first and second
> paragraphs, and its description can be coalesced into the the first
> paragraph, leaving the later paragraphs to describe the "common paths=
" and
> "no common paths" cases.
>
> The second sentence of the second paragraph seems overly long and get=
s a bit
> muddled near the end. I can not parse "audiences you are working to".=
 Maybe
> it should be "audiences you are working with" or "... for"?
>
> In the third paragraph, "first clear the index and the working tree" =
bit
> could be taken to mean "clear the index and working tree before creat=
ing the
> new branch" (which might work, but leaves a possibly confusing state =
if the
> user is distracted between "rm -rf" and "checkout --orphan" (still on=
 the
> original branch, the deletion of everything has been staged)). Also, =
use
> backquotes to properly format the example command.
>
> Here is my take on these paragraphs:
>
> -->8---->8--
> --orphan::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Create a new, 'orphan' branch named <new_b=
ranch>, and start it
> =C2=A0 =C2=A0 =C2=A0 =C2=A0at <start_point>. The first commit made on=
 this new branch will
> =C2=A0 =C2=A0 =C2=A0 =C2=A0have no parents (it will be the root of a =
new history that is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not connected to any the other branches or=
 commits).
> +
> An orphan branch allows you to start a new history that records a set=
 of
> paths similar to <start_point>.
> This can be useful when you want to publish the tree from a commit wi=
thout
> exposing its full history.
> You might want to do this to publish an open source branch of a proje=
ct
> whose current tree is "clean", but whose full history contains propri=
etary
> or otherwise encumbered bits of code.
> +
> If you want to start a disconnected history that records a set of pat=
hs
> that is totally different from <start_point>, you may want to clear t=
he
> index and the working tree after creating the orphan branch.
> Run `git rm -rf .` from the top level of the working tree, then prepa=
re
> your new files by copying them from elsewhere, extracting a tarball, =
or
> otherwise populating the working tree.
> --8<----8<--
>
> --
> Chris
>

I am in favor of changing the whole texts to your versions.  Let's
wait for Junio's opinion.

After this wonderful English and modesty lessons, I started thinking:
since Git is a worldwide spread software why it is not using gettext
to have its translations?  It would not be a hard job because gettext
separates the job of translation from normal work flow with just minor
changes to inline message constants.

Best regards to all
