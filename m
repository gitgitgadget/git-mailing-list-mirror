From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Mon, 20 Sep 2010 10:15:34 +0200
Message-ID: <AANLkTim0X-3PFccXTjH3Mo5eEHL+7zBcifqHu9hWp_RP@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <201009171854.03476.jnareb@gmail.com> <AANLkTinkikwt5cUxuXECfeQrKZthu271U82F3ebSrEmd@mail.gmail.com>
 <201009200102.22960.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 10:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbXd-0001Jb-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab0ITIP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 04:15:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33930 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab0ITIPz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 04:15:55 -0400
Received: by iwn5 with SMTP id 5so4079283iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=i+1T9+MIezlHQsrufuh6XNvGLrIzvfJKa9rJbtL+wTU=;
        b=xB0zoJFswXTav/wpCIkJoWwEfA0Jd3nlSnQ8xBrwbsEDnWJ6Ny8aLoZUtr1IFGsWvi
         JcihCRvgl80vA9f1zgu6tjdjp9/zPOCWEjdoFbU9x1Zktpjfyr0M14zFND+y5947jlgV
         vaX3nCqXKb1GZ0Fq5keIP//yLpSKd6fGTWQho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KvT2S117Y4ixqg8Gaks2UoycGq9e8zsndBmGGIIyVosTLJpu6xKNGTXu+gES7pxyId
         DG5BVIexWHuP5NwLQlYse2LqEKVT/fcpx0VVQlvqYTG5i67HbSjGS/SL8CnaGNPrz7w+
         tVZsoCFAXgDLzXqbK86gj3dncHrnT/GW+V8lE=
Received: by 10.231.13.140 with SMTP id c12mr9980490iba.25.1284970554179; Mon,
 20 Sep 2010 01:15:54 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Mon, 20 Sep 2010 01:15:34 -0700 (PDT)
In-Reply-To: <201009200102.22960.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156558>

On Mon, Sep 20, 2010 at 1:02 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> When thinking about how display information about remotes and
> remote-tracking branches in 'summary' view, we have to consider that
> this view is meant to be what it says: a *summary*. =A0That is why bo=
th
> the 'heads' and the 'tags' section displays only 15 items.
>
> Without grouping remote heads the natural solution was to simply repe=
at
> what we used for 'heads' subsection, namely limit displaying to 15
> remote-tracking branches in 'remotes' subsection of the 'summary' vie=
w.
>
> With grouping it is more complicated. =A0We can limit number of remot=
e
> head *per remote*, we can limit number of remotes... but what makes
> IMVHO least sense is limit number of remote heads *then* do grouping.

This is something I absolutely agree with, BTW. It is the way it's
implemented currently because it was the quickest way to ship a
prototype out for discussion.

> The solution (1) i.e. limiting number of remote heads per remote, wit=
h
> or without limiting number of remotes behaves, as you wrote, most
> similarly to other components of 'summary' view. =A0On the other hand
> with large number of remotes, and large number of remote heads in tho=
se
> remotes it might be too large for a *summary* view.

So you maintain that limiting the amount of data in summary view
should be primary wrt to limiting the amount of time?

> The solution (3) i.e. displaying only list of remotes (perhaps limite=
d
> to 15 remotes) is simple and fast to render. =A0On the other hand it =
offers
> least information and might be too little in the case of single remot=
e.

If time spent processing is not an issue, we can retrieve the number
of heads for each remote and display that, for example. Or even play
with some more dynamic stuff like making each group collapsible,
starting with it collapsed and then display the content when the user
hovers it with the mouse, for example.

>> If we go with option 3, it does make sense to get all remote names a=
nd
>> all remote branches at once, and thus to make the git_get_remotes()
>> call do all of the work.
>
> Not if subroutine is called git_get_remotes(), IMVHO. =A0Perhaps
> git_group_remotes()?

That I can do.

>> It's the only current use but I believe that, since it's factored ou=
t
>> now already and since it may be used in other views too (think:
>> grouping heads or tags by prefix) it might make sense to keep it thi=
s
>> way.
>
> If it could be used for other blocks (like 'readme', or 'heads',
> or 'tags') itself it would be even better.

That's a possibility, although it would change the layout some (which
is not necessarily a bad thing)

> If remote doesn't have remote-tracking branches associated with it
> (e.g. push-only remote, or remote predating separate remotes layout)
> the value would be undef for given remote as key in hash.

Yes, this is something I have to take into consideration. Skip
displaying them is probably the best idea (unless we have other ways
to gather information about them).

--=20
Giuseppe "Oblomov" Bilotta
