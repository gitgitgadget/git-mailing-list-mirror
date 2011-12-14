From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] revert: allow single-pick in the middle of
 cherry-pick sequence
Date: Wed, 14 Dec 2011 10:21:48 -0600
Message-ID: <20111214162148.GA481@elie.hsd1.il.comcast.net>
References: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
 <20111210125948.GE22035@elie.hsd1.il.comcast.net>
 <CALkWK0mt03SSNT-svUO1wHdq5OpM=0xQO3FHkSGGEDuW-jUEXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rarat-0002IC-UW
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab1LNQWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 11:22:06 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58213 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371Ab1LNQWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 11:22:04 -0500
Received: by wgbdr13 with SMTP id dr13so2074734wgb.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jjYTRyib9NtwO4Wi25z9Kf1u1gY6BCKXS1rPC6oS5UU=;
        b=kztfcsxj3U3Efgj7SrjTz9zYAb4bRu3RAbxy+6jriqR3JMn59dYcCl0iElnysLB98i
         wNLj9oIr/QLd9Dnb9xlRLiV7QiaetwOMnKk8NRQUcVeGa6KkEySpLZcM+WlLpNMCx77E
         K/pNEW+QmjidWDWN7Q44Er2aLQeJZGjEckQGQ=
Received: by 10.227.60.4 with SMTP id n4mr2849162wbh.9.1323879721911;
        Wed, 14 Dec 2011 08:22:01 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id v10sm4164517wiy.23.2011.12.14.08.21.57
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:22:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mt03SSNT-svUO1wHdq5OpM=0xQO3FHkSGGEDuW-jUEXA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187141>

(out of order for convenience)
Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Suggested-by: Johannes Sixt <j6t@kdbg.org>
>
> Could you link to the corresponding thread with Johannes?

No, I prefer not to.  If I did a good job, the commit message would
explain enough already, and in exceptional cases, the interested
reader can look up the mailing list message the commit comes from and
walk upthread, no?

> Cute feature, although I don't ever recall needing it personally.  Wh=
y
> does this relatively esoteric "feature" belong along with the other
> "maintenance patches" in  jn/maint-sequencer-fixes?

Read ahead in the series, or read the cover letter. :)

>                              What I'm really interested in seeing is
> how you persist opts for "cherry-pick --continue" when a single-commi=
t
> pick fails: in other words, how you manage to get " --continue of
> single-pick respects -x" to pass.

That's a good question.  I did the lazy thing and let the existing
"git cherry-pick" logic take care of it (it writes MERGE_MSG).

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit *cm=
it;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prepare_revis=
ion_walk(opts->revs))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die(_("revision walk setup failed"));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmit =3D get_revi=
sion(opts->revs);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cmit || get_=
revision(opts->revs))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 die("BUG: expected exactly one commit from walk");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return single_pic=
k(cmit, opts);
>> + =C2=A0 =C2=A0 =C2=A0 }
>
> I'd have expected you to reuse prepare_revs().

Why?  The purposes do not overlap much.

>> + =C2=A0 =C2=A0 =C2=A0 if (opts->revs->cmdline.nr =3D=3D 1 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->cmdline.rev->whence=
 =3D=3D REV_CMD_REV &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->no_walk &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !opts->revs->cmdline.rev->flags=
) {
>
> Yuck, seriously.
> 1. I'd have expected you to check opts->revs->commits, not
> opts->revs->cmdline.nr.  Okay, you're using the cmdline because the
> revision walk hasn't happened yet.

It would have been easy to do a revision walk and count and I'm using
the cmdline instead deliberately --- the goal really is "anything more
complicated than a simple rev on the command line should trip the
multi-pick logic".

I admit though that I'm not too familiar with the new cmdline_info
API.  I'd welcome a simpler expression with the same effect.

Also, I probably should have included a test that does some

		git cherry-pick picked^..picked

thing and verifies that this is treated as a multi-pick.  And
documented this. :)

Thanks for pointing out the questionable bits.  I am tempted to reroll
to put this after patch 6/7, which would make it possible to use "git
reset --merge" in the commit message for a more natural explanation.

That would also provide an opportunity to reuse some text from [1],
which in hindsight seems to have explained some aspects of each patch
a little more clearly.

Thanks, and hoping that clarifies a little,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/185716/focus=
=3D186811
