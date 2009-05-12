From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 19:18:33 +0200
Message-ID: <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Tue May 12 19:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vcp-0002Om-Hw
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbZELRSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbZELRSe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:18:34 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:23052 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbZELRSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 13:18:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so52578fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jcE5TCCnYpUgiRcUPJocNr60l2c3mFnlEaZ3BmXQ5JM=;
        b=TL+rA8FhNC2Hi8jeD3st/IUXyJKmKcoeyH/2x6LK2X1foEVZPsmW9qqqgeUpFRF5cb
         DSKrhjxNJDjRcL1GnPBOy83dXK7540CfPVVkF34XC+LAiShMOsS3B4k7IyGzKZZLe7MA
         IeE/WJzNMdonsaXEoKwWtjEBHNEvJKlKs/2b4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s0tJLSwuTDjeeEbj2NV8qKqr/g2xEiGMBRaT+Ehfc8MYZKnJuHg6IEnfr5FlUiBy9o
         UXxvUZrseBRjo1t1LeUZXCdsBoPBKQBu9LkCDgd0cFfmqqXwKUfX7kbZRx51u4NIQvLD
         VYgDqxGNy7QrDUaMgKN17JQiIOvpjy4+MAwG4=
Received: by 10.204.59.145 with SMTP id l17mr7801786bkh.28.1242148714068; Tue, 
	12 May 2009 10:18:34 -0700 (PDT)
In-Reply-To: <200905121900.00625.Hugo.Mildenberger@namir.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118932>

2009/5/12 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
>> > Last not least, I managed to reproduce the problem almost exactly:
>> >
>> > 1.) hm@localhost git
>> > clone "git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/blue=
tooth-testing.git
>> > "
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0(Note the trailing linefeed)
>>
>> That's all the command printed? No "Initialized empty Git repository=
" line?
>
> hm@localhost /var/tmp $ git clone "git://git.kernel.org/pub/scm/linux=
/kernel/git/holtmann/bluetooth-testing.git
> "
> Initialized empty Git repository in /mnt/hda1/tmp/bluetooth-testing.g=
it
> /.git/
> remote: Counting objects: 1177836, done.
> remote: Compressing objects: 100% (189467/189467), done.
> remote: Total 1177836 (delta 982785), reused 1176855 (delta 981880)
> Receiving objects: 100% (1177836/1177836), 288.16 MiB | 1288 KiB/s, d=
one.
> Resolving deltas: 100% (982785/982785), done.
> Checking out files: 100% (27842/27842), done.
>
> hm@localhost /var/tmp $ ls
> bluetooth-testing.git? =C2=A0 [Note that question mark replacing \n i=
n repository's name]
>

Ok, clone works. Fully and correctly (even if a bit unexpected).

> hm@localhost /var/tmp/bluetooth-testing.git $ make
> make[1]: /mnt/hda1/tmp/bluetooth-testing.git: No such file or directo=
ry
> make[1]: *** No rule to make target `/mnt/hda1/tmp/bluetooth-testing.=
git'. =C2=A0Stop.

It is just linux build system which does not support compilation in odd=
ly
named directories (which is reasonable, if you ask me).

> hm@localhost /var/tmp/bluetooth-testing.git $ git pull
> fatal: Error in line 2:

That's already fixed. Will send the fix in a minute.
