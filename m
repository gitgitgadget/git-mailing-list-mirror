From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Sat, 11 Apr 2009 09:11:12 +0800
Message-ID: <46dff0320904101811g3b5dcc8ag195d40005b181c52@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>
	 <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
	 <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
	 <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
	 <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 03:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsRm3-0002nk-G1
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 03:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZDKBLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Apr 2009 21:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZDKBLO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 21:11:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:51022 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbZDKBLN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 21:11:13 -0400
Received: by wa-out-1112.google.com with SMTP id j5so662320wah.21
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 18:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8U5kl5gjhU/4L/VTXiTnLYa1GT4y28cb5+BjYVTifUs=;
        b=LrLPoEf3le1g6zM5r2QCdM4OnamAsE9sTiWo2ZlhChzmOUcL2rDpN5FPSZGeP6zhNN
         clx5FRChBAgDSkNevb7D2KW0fEVyLAQ6kaaAuzIh0h/oe8nJLGm7rKy4/HsQJJua8G+Z
         bc4127T1kBRW5P0XsXYBKHHKXuZID/1EvVFeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pPG2eNiU8ddhA+6Sr3EovEqoorgpTn+QfcfUVvgy75hQ9b9WLUEonmg8CyHay1jYVA
         bi+nFjGWhOl5ShmhjAGtSkU2iKftWr86i3GvWwL2Y8VDj56pCsjnRBu6qsXRaqD5BEuS
         9UunCP6QbBSmp8+alWrrhttJpbdBuF8A1WV+c=
Received: by 10.114.74.18 with SMTP id w18mr2111607waa.205.1239412272651; Fri, 
	10 Apr 2009 18:11:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116285>

On Sat, Apr 11, 2009 at 2:10 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 10 Apr 2009, Ping Yin wrote:
>
>> On Thu, Apr 9, 2009 at 10:00 AM, Ping Yin <pkufranky@gmail.com> wrot=
e:
>> > On Thu, Apr 9, 2009 at 5:30 AM, Johannes Schindelin
>> > <johannes.schindelin@gmx.de> wrote:
>> >> With "git add -e [<files>]", Git will fire up an editor with the =
current
>> >> diff relative to the index (i.e. what you would get with "git dif=
f
>> >> [<files>]").
>> >>
>> >> Now you can edit the patch as much as you like, including adding/=
removing
>> >> lines, editing the text, whatever. =C2=A0Make sure, though, that =
the first
>> >> character of the hunk lines is still a space, a plus or a minus.
>> >>
>> >> After you closed the editor, Git will adjust the line counts of t=
he hunks
>> >> if necessary, thanks to the --recount option of apply, and commit=
 the
>> >> patch. =C2=A0Except if you deleted everything, in which case noth=
ing happens
>> >> (for obvious reasons).
>> >>
>> >> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >> ---
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0I actually promised myself not to rese=
nd this patch, but a
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0certain guy who has a hat now asked fo=
r it.
>> >>
>> >
>> > I am that guy :-). Thanks. Sometimes "add -e" is more useful than =
"add
>> > -p" since i can see the full context when editing the patch. Howev=
er,
>> > sometimes the ability to edit the index directly is even more usef=
ul.
>> > For example, if it's a big change (or rewritten), it is hard to ed=
it
>> > the patch instead of the index (in diff mode with the worktree fil=
e
>> > side by side). I even encounter a case that i can't beat the patch
>> > into a shape i want when using 'add -p' =C2=A0( it will fail to ap=
ply)
>> >
>>
>> How about this?
>> =C2=A0'add --edit=3Dpatch' to edit the patch and "add --edit=3Dindex=
" to edit the index
>
> As others have mentioned, there _is_ a reason we have a working direc=
tory.
> Please understand this as a "I do not like the idea of editing the in=
dex
> directly at all".
>

When doing "add --edit" to edit the patch, do you work on the working
directory? I think they are just different ways to change the index?
