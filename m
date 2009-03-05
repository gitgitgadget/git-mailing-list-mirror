From: John Tapsell <johnflux@gmail.com>
Subject: Re: bisect run, was Re: More git bisect modes
Date: Thu, 5 Mar 2009 11:18:08 +0000
Message-ID: <43d8ce650903050318g6ab81e6es9869b9f526c5eb24@mail.gmail.com>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
	 <20090305190542.6117@nanako3.lavabit.com>
	 <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
	 <7vvdqo1csl.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903051207480.6524@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBc6-0005yn-Na
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZCELSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 06:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbZCELSM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:18:12 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:50051 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZCELSL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 06:18:11 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4487987wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I/X+nE36fes+W+7dpyNnPlXy4K31LuPoULhzka0Id4Y=;
        b=GL25BSrnPlNxyOxU590z+sl+BSYuXlx3zBpP2BfY7pLxF80h85VqFURBFp5016NWH7
         /6q/eK95ECyGuZaOzeNlI9PSZ8emrH7Sx6L8TpRaq+mmih+9aUqtQtu/R/xN3dwF1Otc
         YZ6IYq6c9BSLVImCJqnTkmDrDKv0/ktLJaD2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kZ6zOoxo3LS7v+Y8MIl3nRYpr1mkcg4oToT1IlDESNrBpqG0WXqAewcGQ8V3AOxwN2
         sfLZ7qId1yToVZ0TmzQaXRTas7xEl5XLGtwLmjkwA+Jdx8J8PpqgcSO7qqv9ff3lSpz0
         YXWjWaUHoGKA6Q1wU8PU6j0qVe2K6SoDn+rsQ=
Received: by 10.142.194.1 with SMTP id r1mr481127wff.138.1236251888738; Thu, 
	05 Mar 2009 03:18:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903051207480.6524@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112299>

2009/3/5 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Thu, 5 Mar 2009, Junio C Hamano wrote:
>
>> [...] personally I never felt the need for "run" to work without any=
 bad
>> one, as the first few rounds would almost always end up to be a
>> debugging session of the run script for me, as in:
>>
>> =C2=A0 =C2=A0 =C2=A0 ... oh, somebody broke this somewhere ...
>> =C2=A0 =C2=A0 =C2=A0 ... write a validate script ...
>> =C2=A0 =C2=A0 =C2=A0 $ edit runme ; chmod +x runme
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ ./runme
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... yeah, it is broken and runme script =
detects breakage
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ git checkout HEAD~200
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ ./runme
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... ok, it used to work here and runme e=
xits Ok
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ git bisect good
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ git bisect bad @{-1}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ ./runme
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... ok, runme script appears to be ok
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ git bisect run ./runme
>
> That reminds me of a personal gripe with "bisect run": You cannot use=
 it
> like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git bisect run 'make test'
>
> as it interprets 'make test' as a name of an executable. =C2=A0That m=
akes
> 'bisect run' rather less useful to me.

A very quick test seems to show that:

$ git bisect run make test

Works as you want.  Maybe a quick example of this could be added to
the man page.

>
> Ciao,
> Dscho
>
>
