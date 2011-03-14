From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 20:39:49 +0200
Message-ID: <AANLkTikkHWFrjmrPMP_poxrkCwE34jqaFDbU1Roouw--@mail.gmail.com>
References: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 19:40:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzCgP-0007Mi-0O
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 19:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1CNSjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 14:39:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38961 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab1CNSju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 14:39:50 -0400
Received: by wwa36 with SMTP id 36so6026191wwa.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=dFaTlX4Kbc2Zu7Uplf2/IXN6Z7JldhDGOUOw1JVEiTg=;
        b=j+bKA9DNdUPFWp88I+/fNWeTT92OkE3wvymiVQ9k7hHDA9xCABov9CN4+Zx+EGuh2o
         CP5Fqxv4WrP1rHNoegqqa+gtVuYEwQUsCZh9UQFf2lz/tNbOPD9Qg2s78GISr9ev9ReF
         Q/eN8ucJ1wCLoHJ0isdVx68PVG6NKO0RNM440=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=wqBras+gRCnsIYZ59U6XBg1SjlW2NcIhPqx/S9bAdIOEUI8dVPcgQknJEeEzVHnJY8
         xyQYyqc0I7CKA6mtz/h1SV7dUwETeB5g9cJcvhIbVSXWRAtQevWTJ1v5zO43YNF1XE93
         1mrXSMUov7S2S6tbS4fJqdFNdqLhgeRgq2j+I=
Received: by 10.216.140.15 with SMTP id d15mr10917950wej.64.1300127989409;
 Mon, 14 Mar 2011 11:39:49 -0700 (PDT)
Received: by 10.216.1.142 with HTTP; Mon, 14 Mar 2011 11:39:49 -0700 (PDT)
In-Reply-To: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169006>

On 14 March 2011 20:29, Alexei Sholik <alcosholik@gmail.com> wrote:
> Hi git,
>
> I cloned git mirror from github[1]. When I run git-status in it's
> working directory, I see no output.
>
> But then, after copying the whole directory with 'cp -r' and running
> git-status in the newly created directory, I get the following:
>
>> # On branch master
>> # Changed but not updated:
>> # =C2=A0 (use "git add <file>..." to update what will be committed)
>> # =C2=A0 (use "git checkout -- <file>..." to discard changes in work=
ing directory)
>> #
>> # =C2=A0 =C2=A0 typechange: RelNotes
>
> git-diff shows
>
>> diff --git a/RelNotes b/RelNotes
>> new file mode 100644
>> index 0000000..56c3863
>> --- /dev/null
>> +++ b/RelNotes
>> ... // the whole contents of the file
>
> Both copies of the repository are on the branch master with the lates=
t
> commit 07873dc. Simply diffing copies of the RelNotes file gives no
> output.
>
> What happened with the copied repository? I've found a couple of
> instances of the word 'typechange' in the source, but no mention in
> the docs. What does it mean and what could be the cause of this
> change?
>
>
> =C2=A0[1]: git://github.com/git/git.git
>
> --
> Best regards,
> Alexei Sholik
>

Right, I've figured out the root of the change.

'ls -l' on the original RelNotes outputs:
  lrwxr-xr-x  1 alco  staff  32 Mar 14 20:35 RelNotes ->
Documentation/RelNotes/1.7.5.txt

'ls -l' on the copied RelNotes outputs:
  -rw-r--r--  1 alco  staff  1810 Mar 14 20:10 RelNotes

So the problem is with the cp, not git. But I wonder if it is
mentioned anywhere in the docs? Probably, git-clone's or git-status'
manpage would be a proper place?

--=20
Best regards,
Alexei Sholik
