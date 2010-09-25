From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: .gitignore Bug Report on the behavior of *
Date: Sat, 25 Sep 2010 20:53:57 +0000
Message-ID: <AANLkTinF2Bk0O96hPiB+WFzWAwEqu=wqdXEnM39+JOoN@mail.gmail.com>
References: <201009251923.o8PJNJYE031841@no.baka.org>
	<201009252203.48820.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 25 22:54:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozbkw-00063w-Vz
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 22:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab0IYUx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 16:53:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61890 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab0IYUx6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 16:53:58 -0400
Received: by iwn5 with SMTP id 5so3454718iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IProk7GlXScBcxsD9KdlNgl4ZD2KMWa2WGn149IrGKw=;
        b=dbpiiB/dB4eRY7Idc2Bm8SdIhkSh+lfrJS66Dtzk8CIlSYGWZCBDY0dj96yZsP4igH
         Jy2YvAOlvtOGdkxpMxhCXzPjFfbbYVp/w0T1RB2Au3n0nvQ44olQm7KL0NbZyhp3hvW6
         iz89diAXxmCgjRH7EWaqEvwNu/IL/13fr/AF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UnOA2RAH9C6qMWPi7F0nZvY3oWTf68vyJ1kzkDPREkUb7hrUi4NWocl1IGzGHwt636
         BIt5Vm4Zqw2wYQ37B19sO/OWRKlJhahW4+8vq7+1kK7KqkA46j+8fgaLRNnutOTvqnRW
         TigrAtPzPeInG/VM4Z53kYOa6elCbkT6S16po=
Received: by 10.231.14.72 with SMTP id f8mr1972383iba.171.1285448037600; Sat,
 25 Sep 2010 13:53:57 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 13:53:57 -0700 (PDT)
In-Reply-To: <201009252203.48820.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157199>

On Sat, Sep 25, 2010 at 20:03, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 25. September 2010, Seth Robertson wrote:
>> # Properly shows X and B/XX as untracked, as I expected
>> echo X > X; echo XX > B/XX; git status
>>
>> # I expected B/XX to show up as untracked
>> rm -f .gitignore B/.gitignore
>> echo '*' > .gitignore; echo '!*' > B/.gitignore; git status
>
> You should update your expectations to match what you got. ;-)
>
> To show why your expectations are wrong, consider a *huge* and *deep*
> directory with thousands and thousands of subdirectories, call it "us=
r", that
> should be ignored. The .gitignore at the top-level would just say:
>
> =C2=A0/usr
>
> Do you really expect git to walk down this ignored directory, just to=
 make
> double-sure that really, really down there does nowhere exist a .giti=
gnore
> that says "oh, wait, don't ignore *this* file"?

That wouldn't be so expensive if the expectation that the .gitignore
in /usr would only be considered if it had already been commited. Then
we'd just have to check if we have a tree for /usr, and whether
there's a gitignore there.

But doing this in the top-level .gitignore if possible is the best
solution.
