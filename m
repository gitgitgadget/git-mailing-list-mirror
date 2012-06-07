From: cheng renquan <crquan@gmail.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Wed, 6 Jun 2012 22:17:46 -0700
Message-ID: <CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
	<CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster-vger@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScV6X-0000OK-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 07:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab2FGFRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 01:17:49 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:49100 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2FGFRs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 01:17:48 -0400
Received: by weyu7 with SMTP id u7so117786wey.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LYsrXMr7XeY6yK0AWh9Rgcs/abkykgCd9QTZ4MX2fqc=;
        b=HEapU4+m8VdcR97QBY1Ujqv+A/3S8uIYzdKXGUcoi0hcOOkCpHmlCpCOnV1b+cRto3
         iCt1LBXm98arkwfy8Vffx+RtOtgZZ7tZ3ssysEQseCeKF6BWnM02iWMbmuHls7tZ3XzX
         P6SEqWujtL3W+oHoIFgOS+DCOrc46beKgqMPq0N5RcMt5Cc2ep7ozn4tO+7cg9y47HcK
         L9hirQu3wcjCadAs4sCaHJ7efsH1dUEPB33V8pQy5BAYEt3OjL42bcw8YntTYdra851y
         U3Z4EcsMLngJEMs8B3H22ZVQFxX2eh4xgJ0CQeMMQzMsohugT1fN6OD6m4yWAelmN210
         rSKA==
Received: by 10.216.196.218 with SMTP id r68mr669252wen.122.1339046267020;
 Wed, 06 Jun 2012 22:17:47 -0700 (PDT)
Received: by 10.216.136.80 with HTTP; Wed, 6 Jun 2012 22:17:46 -0700 (PDT)
In-Reply-To: <CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199369>

On Wed, Jun 6, 2012 at 9:37 PM, Junio C Hamano <gitster-vger@pobox.com>=
 wrote:
> On Wed, Jun 6, 2012 at 6:40 PM, cheng renquan <crquan@gmail.com> wrot=
e:
>>
>> Someone maybe like me is working in the way of following one central
>> git repository
>> while sometimes need to fetch some code or tags from a 3rd git repo,
>> but unfortunately the 3rd repo may contain a lot of tags not all I w=
ant
>> to fetch to mess up my local repo, at this time I want to fetch only=
 one tag
>> from the 3rd repo, but the syntax of
>> =C2=A0`git fetch 3rd-repo the-tag-name`
>>
>> really fetched the code of the-tag-name from 3rd-repo, but forgot th=
e
>> tag itself;
>
>
> The subject of "forgot" in that sentence is you, not "git fetch".
> You told "git fetch" to grab it but not store it locally in your
> refs/tags namespace.
>
> There is a convenience short-hand "tag <tagname>", i.e.
>
> =C2=A0 git fetch 3rd-repo tag the-tag-name
>
> that is equivalent to
>
> =C2=A0 git fetch 3rd-repo refs/tags/the-tag-name:refs/tags/the-tag-na=
me
>
> So I do not think your patch is necessary for your use case, and
> obviously it will
> break other people's use case where they just want to fetch (and insp=
ect what is
> left in FETCH_HEAD) but do not want to store.

No, I tried what you said but it doesn't work as expected:

  git fetch linux-stable tag v3.4.1

My [linus-git] is following torvalds' tree and now I want to fetch
just one tag v3.4.1 from
linux-stable tree, but the above command would fetch all tags from linu=
x-stable

linus-git	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
(fetch)
linux-stable	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable.git
(fetch)


[linus-git] $ git fetch -v --dry-run linux-stable tag v3.4.1 |& head
=46rom git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e
 =3D [up to date]      v3.4.1     -> v3.4.1
 * [new tag]         latest     -> latest
 * [new tag]         v2.6.12.1  -> v2.6.12.1
 * [new tag]         v2.6.12.2  -> v2.6.12.2
[...]


I didn't know this syntax before, but Yes, this syntax should serve
the one-tag-only goal better,
  `git fetch 3rd-repo tag the-tag-name`
maybe I'd better to fix that?
