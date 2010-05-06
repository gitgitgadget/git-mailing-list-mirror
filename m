From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 14:00:58 -0600
Message-ID: <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com> <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com> 
	<o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com> 
	<i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com> 
	<alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 06 22:01:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7GC-00084R-0q
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab0EFUBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 16:01:22 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:59797 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0EFUBV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 16:01:21 -0400
Received: by ywh36 with SMTP id 36so229944ywh.4
        for <git@vger.kernel.org>; Thu, 06 May 2010 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=jtpI0hqNFdyti3TJoGJeyM0WLl9mHgJUzl/t60sgyZ4=;
        b=tAxS8N+dIaS7Tb365Nj0Dufhob6AmywwTcvv9/0+lq+5ksoQ8IaG/tbNuKi1nt7rRS
         RoZIRZzdCGF1xDgDbLDEgIYkBpxrLrKd0Rh+sB6pSVl9vxlZO/LaHvU5GrTu+PZYvvCW
         dbAPURi6HzMtt8bkjkp2U9AsB2SJJ+p+0gj/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=mCvRhAq2cRlkOlJPLuVpxnbvbtNNMKAHEtuMyKsbilEvE4C2Bwn6sgVb2DnLXffmiU
         KH8ZT5Dn/Gz4OsreDVGdYPwFHK+ORzxKuTfY68d/ewKS8shvCJBhrpyCLDf6XQ1txNOo
         OY73CuaNND4kF1c++kGXcg/t/pWkyU0vAIEAU=
Received: by 10.101.48.15 with SMTP id a15mr9848542ank.108.1273176079907; Thu, 
	06 May 2010 13:01:19 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Thu, 6 May 2010 13:00:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146490>

On 6 May 2010 11:15, Linus Torvalds <torvalds@linux-foundation.org> wro=
te:
>
>
> On Thu, 6 May 2010, hasen j wrote:
>>
>> I don't know all linux editors, but I've yet to see one that can't
>> handle CRLF endings.
>
> A _lot_ of UNIX editors will handle CRLF endings, but if you change a
> file, they often write the result back with _mixed_ endings. Some wil=
l
> also show the CR as '^M' or some other garbage at the end.
>
> A number of tools will also end up confused, including very fundament=
al
> things like "grep". Try this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo -e "Hello\015" > f
> =C2=A0 =C2=A0 =C2=A0 =C2=A0grep 'Hello$' f
>
> and notice how the grep does _not_ find the Hello at the end of the l=
ine,
> because grep sees another random character there (this might be
> unportable, I could easily imagine some versions of grep finding it).
>
> So I would strongly suggest against CRLF on UNIX. It really doesn't w=
ork
> very well, even if some tools will handle it to some limited degree.
>
> In short: having 'core.autocrlf' set will likely make it much more
> pleasant to work across different platforms.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0Linus
>

When I'm on windows, I prefer LF (unless the project already uses
CRLF, or it's outside my control).

VB is very windowsy; I *really* doubt most VB developers use (or even
know) grep, so I don't think it's a problem if a VB project
standardizes line endings to be CRLF.

My problem with autocrlf is that, well, it converts line endings in
the working directory to CRLF, even though I don't always want it to.
(most of the time, I don't).

The other problem is, git will get confused if you set autocrlf *after
the fact*; i.e. you already cloned and have the files checked out,
maybe even made some commits.

Overall, I ran into many awkward situations with autocrlf (and I can't
remember them now), but if you google you can find some of the issues
people are having.

The whole problem would go away if there was no crlf, and that's not
impossible: any decent text editor can read/write files with Unix line
endings.

I wasn't aware that Visual Studio doesn't have an easy way to have it
write LF endings by default; I'm sure there are addons to make that
easier. Plus most open source projects are not usually setup with VS
as the development environment anyway, so it's really not a big
problem.

So yeah, I think LF everywhere is the better way to go most of the time=
=2E
