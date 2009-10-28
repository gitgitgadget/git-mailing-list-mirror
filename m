From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: possible usability issue in rebase -i?
Date: Wed, 28 Oct 2009 13:20:03 +0100
Message-ID: <40aa078e0910280520t497f1289sf374a3a501856a23@mail.gmail.com>
References: <40aa078e0910270313j5dc68576v86a3947f0dc7f9f@mail.gmail.com>
	 <2faad3050910270817l71394722nda55265ed96722df@mail.gmail.com>
	 <40aa078e0910270850u6ffec41cj372da11d9df533f@mail.gmail.com>
	 <2faad3050910271405k4a391184vb978b9b35484383b@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37Ve-0000rw-HA
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbZJ1MUD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 08:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbZJ1MUC
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:20:02 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44514 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbZJ1MUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 08:20:00 -0400
Received: by bwz27 with SMTP id 27so914068bwz.21
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 05:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gNgT0mlRW8w3vZoUKlQaKz+aEygH9N6lhuDwg++z2F0=;
        b=MNwHZJTvbySwj31DrhtELoj0bki65oFV+MAdM3RcVYE2sbBCpWCWUJ1CpXPyXipIwI
         9BYKPwX2EEqudQvxw/qd4lh1zb5NH95tsrWBaGVwBn9jvrUaCFJfc40lnmNlYH7GnWe1
         kLdESi+Fxiit39QqfxpGdA6XwwrXS9SE5X3P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=o1WC24C3ISIi9PbU1jOVynXh+UZ/F6IuuUVKfk/G9wd9fxegrXyCZIxP64afz/nN0z
         V61kkN9y21NNBqBp4jdFMjpQrPeNoZLjxpO/FxPjMn1ZiH1LHuOcJeeMO4pEnD9iUCFx
         xjU865oBNVM09XByVrWI/yRoXy1XLvQ7Q6Nio=
Received: by 10.204.32.76 with SMTP id b12mr2942536bkd.165.1256732403742; Wed, 
	28 Oct 2009 05:20:03 -0700 (PDT)
In-Reply-To: <2faad3050910271405k4a391184vb978b9b35484383b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131456>

On Tue, Oct 27, 2009 at 10:05 PM, Baz <brian.ewins@gmail.com> wrote:
> I'm fine with this way of fixing it, but I'd make a few more changes.=
=2E.

=46eel free to make a patch-series that addresses more issues - I'm not=
 going to.

We make patches of one change at the time in Git. Other (related)
usability issues becomes separate patches, preferably grouped together
in a patch-series. This change would be one patch in such a series.

>> =A0OPTIONS_SPEC=3D"\
>> =A0git-rebase [-i] [options] [--] <upstream> [<branch>]
>
> Use the dashless form and be more consistent with the help - and
> mention '--root' here, it appears in the
> help below:
>
> -git-rebase [-i] [options] [--] <upstream> [<branch>]
> +git rebase [--interactive | -i] [options] [--onto <newbase>] [--]
> <upstream> [<branch>]
> +git rebase [--interactive | -i] [options] --onto <newbase> --root
> [--] [<branch>]
>

I'm not sure I follow - aren't dashless options, uhm, dashless? Do you
mean to use the long-form instead of the short-form? I'll assume
that's what you mean for now, since you changed "-i" to "--interactive
| -i".

If so, I'm not 100% convinced it's a clear win: some grep'ing
indicates that both the short and long form are both widely used, with
short-option bein a slight favor:
$ git grep " \[--" | grep -v " \[--\]" | wc -l
    228
$ git grep " \[-[^-]" | wc -l
    243

Also, the usage isn't the only documentation. I think it makes sense
to try to keep the usage short and to the point, there's a list
describing each option (showing the full-name) further down in the
usage-message. And if that's not enough, there's the "git
help"-command.

If I've misunderstood you and you only want the usage-string to match
that of the manpage, perhaps that might be a good idea. I dunno.

>
>> -git-rebase [-i] (--continue | --abort | --skip)
>> +git-rebase [-i] [-m] (--continue | --abort | --skip)
>
> Again, dashless. And I'd not mention the useless -i here, the man pag=
e
> doesn't either:
>
> -git-rebase [-i] (--continue | --abort | --skip)
> +git rebase (--continue | --abort | --skip)
>

It was already there, so I didn't consider it, but I guess it makes
sense. Besides, I aimed at not loosing any information while making it
a bit clearer.

> These two items are misplaced in the help (I think). They're not like
> abort, continue, skip, but then, the man page doesn't group those
> separately either.
>
> +no-verify =A0 =A0 =A0 =A0 =A0override pre-rebase hook from stopping =
the operation
> +root =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebase all reachable commmits up to=
 the root(s)
>

Agree.

>> =A0Actions:
>> =A0continue =A0 =A0 =A0 =A0 =A0 continue rebasing process
>> =A0abort =A0 =A0 =A0 =A0 =A0 =A0 =A0abort rebasing process and resto=
re original branch
>
> As above, remove the next two lines after your patch:
>
> -no-verify =A0 =A0 =A0 =A0 =A0override pre-rebase hook from stopping =
the operation
> -root =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebase all reachable commmits up to=
 the root(s)

I don't follow this. Are you repeating yourself now? :)

--=20
Erik "kusma" Faye-Lund
