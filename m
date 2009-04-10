From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Fri, 10 Apr 2009 09:43:59 +0800
Message-ID: <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>
	 <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
	 <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 03:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls5oG-0004jr-OA
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 03:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934753AbZDJBoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 21:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935011AbZDJBoB
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 21:44:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:62261 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935004AbZDJBoA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 21:44:00 -0400
Received: by wa-out-1112.google.com with SMTP id j5so471364wah.21
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=J3m5ZahFPcStvQG6GNG2kSceEQmmAAZn5GO6V4162uM=;
        b=kMTrMDXze7GkizJfnsftCAAPQChj/nTnX0i49OZmPdq7i1icuLWsp3USE3QA7PrqiF
         JiT7pNz7sawjTmm2S7UEv6EI6tFduK1B+qgfB8H9JJVekDmlzqpEjr//36GslNATjz21
         BXp0qGUgs2LsyBcao+Ry26mHqi+UfGAvhXEeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FRSzruzY8cp/ZhZSsQ8YrvYn92J9kJURM2Pxc4zhn4A7wMcLPcrD7nBNRv784kG+TQ
         UL4H0tAFyvvXXG/NQvPFky3RB5uMWeYmIhaNVJB+QUSQVV+iOHei3h6U7eEkLck3GTUD
         6WlYTwo1pCMZjNgxiELGM4Pix3blwdWsgZL/s=
Received: by 10.114.148.2 with SMTP id v2mr1693479wad.26.1239327839517; Thu, 
	09 Apr 2009 18:43:59 -0700 (PDT)
In-Reply-To: <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116232>

On Thu, Apr 9, 2009 at 10:00 AM, Ping Yin <pkufranky@gmail.com> wrote:
> On Thu, Apr 9, 2009 at 5:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> With "git add -e [<files>]", Git will fire up an editor with the cur=
rent
>> diff relative to the index (i.e. what you would get with "git diff
>> [<files>]").
>>
>> Now you can edit the patch as much as you like, including adding/rem=
oving
>> lines, editing the text, whatever. =C2=A0Make sure, though, that the=
 first
>> character of the hunk lines is still a space, a plus or a minus.
>>
>> After you closed the editor, Git will adjust the line counts of the =
hunks
>> if necessary, thanks to the --recount option of apply, and commit th=
e
>> patch. =C2=A0Except if you deleted everything, in which case nothing=
 happens
>> (for obvious reasons).
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0I actually promised myself not to resend =
this patch, but a
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0certain guy who has a hat now asked for i=
t.
>>
>
> I am that guy :-). Thanks. Sometimes "add -e" is more useful than "ad=
d
> -p" since i can see the full context when editing the patch. However,
> sometimes the ability to edit the index directly is even more useful.
> For example, if it's a big change (or rewritten), it is hard to edit
> the patch instead of the index (in diff mode with the worktree file
> side by side). I even encounter a case that i can't beat the patch
> into a shape i want when using 'add -p' =C2=A0( it will fail to apply=
)
>

How about this?
 'add --edit=3Dpatch' to edit the patch and "add --edit=3Dindex" to edi=
t the index
