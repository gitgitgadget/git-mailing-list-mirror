From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Sat, 24 Sep 2011 14:42:15 +0530
Message-ID: <CALkWK0mggSNoxxqzUaGp1-AxGWSpCb0HnRmBxSkcVrHnhwMr1Q@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
 <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com>
 <4E676F6A.3060906@drmicha.warpmail.net> <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com>
 <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com>
 <alpine.DEB.2.00.1109080753460.12564@debian> <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com>
 <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
 <alpine.DEB.2.00.1109090900301.12564@debian> <alpine.DEB.2.00.1109122139110.12564@debian>
 <7vwrdaqxpk.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1109151956040.12564@debian>
 <alpine.DEB.2.00.1109201254020.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 11:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ON1-0002kJ-Kb
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 11:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1IXJMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 05:12:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33955 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab1IXJMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 05:12:36 -0400
Received: by wwf22 with SMTP id 22so4628147wwf.1
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uDKJyKutVQ3BIKQUxLgYEBrCUkAl5MKwABRHMSSDLHw=;
        b=ceYigzGZmOcgKd1UipAUKuhHL8TX42ya8ACGHSg5Ts2FbcU2119oGsra6fWp60gW04
         c8hAlE/qTeKAkYtSB+ScoqGRbnsKnwdrGJBXT1oeceH27xyWJpo2VLv1JLkAO2RUb4XF
         zzZ0Q8NeVl3Mljd8xUVn0ZUata6bwFWWGXWec=
Received: by 10.216.80.69 with SMTP id j47mr6373453wee.102.1316855555079; Sat,
 24 Sep 2011 02:12:35 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Sat, 24 Sep 2011 02:12:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109201254020.12564@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182023>

Hi Martin,

Martin von Zweigbergk writes:
> I have started implementing the changes to git-am.sh now. I have made
> it not use mailinfo when in $rebasing mode, as you suggested. So now
> git-am works even if only a list of
>
> =C2=A0From $sha1 Mon Sep 17 00:00:00 2001

Ah, nice :)

> Now the question is how to generate such lines, without the overhead
> of a full format-patch call. We still want the --ignore-if-in-upstrea=
m
> functionality, so we can not use plain rev-list. We also want it to
> work with --root, so we can not use git-cherry. Finally, we can not
> use 'git rev-list --cherry-pick --right-only' since it seems to be
> inherently for symmetric ranges and therefore does not support
> git-cherry's <limit> parameter.

Using git-format-patch for anything except emailing patches to the
maintainer/ list is a mistake imo.

> I would go for teaching git-cherry --root, unless the "rev-list
> --cherry-pick for asymmetric ranges" option would be useful
> elsewhere. Either way, teaching git-cherry --root would not be a bad
> thing, I think.

Either this, or we have to write another wrapper around git-patch-id.

> =C2=A0[1] Long term, would it make sense to teach 'git cherry-pick' a=
 '-2'
> =C2=A0 =C2=A0 option instead of using the '-3' option to 'git am'? (W=
here 'git
> =C2=A0 =C2=A0 cherry-pick -2' would try "apply && write-tree && commi=
t-tree"
> =C2=A0 =C2=A0 before falling back to merging.)

Yeah, in the wake of scripts already doing "apply && write-tree &&
commit-tree" by hand, I think this proposal for git-cherry-pick makes
a lot of sense.  I'm not sure if the option should be called '-2'
though.

Thanks.

-- Ram
