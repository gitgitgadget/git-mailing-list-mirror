From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sat, 11 Sep 2010 19:07:49 +0000
Message-ID: <AANLkTi=p1ScGXAWprSYC6=K_FyNS3m2En-NZLtNU_ES_@mail.gmail.com>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
	<20100830030819.GA25415@sigill.intra.peff.net>
	<AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 11 21:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuVQZ-0002aF-RM
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 21:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665Ab0IKTHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Sep 2010 15:07:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47915 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0IKTHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Sep 2010 15:07:50 -0400
Received: by iwn5 with SMTP id 5so3482881iwn.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HJuxH/9SFf04bPRti3KASAeFGfNRdg8+sQk3dCsxEEk=;
        b=pVDR4lH24+n5mAAJB75z+6RPfJvZTI+boCIjrXCUka55Nxtt7Z3zo9OCoNGPAzbfHT
         0qAZpbIYKS2iG6JAkEHQJZptvT/OYqrG5P3dPjn7ZwYyBKMVhV6vbnIrCNy9Df44RPrM
         hxBifTUZO+wSh+E03htmvCrROMT6PdgbpjiQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u8W/aAkZBWNQ2bZ7EkPoGWaigPEKCBBFbvo63j5UAcQhECk7+Pwho2rxDEvXCI0xp1
         20iZnB+Y4zXXchRlOpYUsUjDZRXnsXeiCrwxfX9/P0m8Uh0eVQY++6WAKsVptH54B+ap
         1jx0hKzjgCW4gBRQunNYZwCYkgK1jcxXs7wvw=
Received: by 10.231.157.143 with SMTP id b15mr3273615ibx.113.1284232069393;
 Sat, 11 Sep 2010 12:07:49 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 11 Sep 2010 12:07:49 -0700 (PDT)
In-Reply-To: <AANLkTi=WokEQMDc92SoWXPJW67dy0q79WW9RajrBHRx3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156007>

On Sat, Sep 11, 2010 at 15:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> `On Mon, Aug 30, 2010 at 03:08, Jeff King <peff@peff.net> wrote:

>> I don't understand why you have these at all. Just use "git log
>> --format=3D%H" in your git review above (instead of rev-list), and t=
hen
>> you can just do:
>>
>> =C2=A0git review --grep=3Dwhatever
>> =C2=A0git review -Sfoo
>> =C2=A0git review file
>>
>> Or am I missing something subtle?
>
> You're not missing something, my alias was silly because I brainfarte=
d
> and didn't realize I could do $@, not "$@", so now it's:
>
> =C2=A0 =C2=A0review =3D "!f() { for rev in $(git log --reverse --form=
at=3D%H $@);
> do git show $rev; done; }; f"
>
> Which means I can do all of the commands you suggested above, thanks!

Hrm, actually in the case of that alias doing:

    git review -M ...

Won't do what I want, because it's `git show` that has to be invoked
by -M. An option like --for-each-invoke-pager (or something) could do
the right thing there.
