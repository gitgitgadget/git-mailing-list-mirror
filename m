From: Florian Aspart <florian.aspart@gmail.com>
Subject: Re: Using clean/smudge filters with difftool
Date: Fri, 19 Jun 2015 17:04:03 +0200
Message-ID: <CAGA3+++uZcVQdYme5H5HqayK2R6N41j1DVOndok3LVRDjcMZkQ@mail.gmail.com>
References: <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan> <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
 <20150618142852.GL18226@serenity.lan> <CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>
 <20150618160133.GO18226@serenity.lan> <xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>
 <20150618223927.GP18226@serenity.lan> <xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
 <5583D993.4090305@drmicha.warpmail.net> <20150619093251.GQ18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 19 17:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5xqP-0005De-OC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 17:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbbFSPEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 11:04:31 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:32892 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbFSPEY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 11:04:24 -0400
Received: by yhpn97 with SMTP id n97so79994823yhp.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vo3FARMFcnV6YmsmQNmhcwuyLBJ/5EoOL6at4wFQZQI=;
        b=juGOm1FqibCvZ/2kZ3/OQr1iBqYGaWcQ08Z8vuoim7dBwO2QJgkU0IbTgoJHGDshI0
         AWt50n/Zmb5Ylh6OAxTguXF+fDAm2fwihAVLN+vDdk6a4S+OBRIe9jGCcA/ltQm+lkYZ
         x+ud4cak1GVHia86G7cF/g5l/iexr/L4P6xo9fDrEwYDtBaRvQjAHKBhyGgphGhZL8XN
         LREwDH+K/sc2kG/gpz/jpNtT+woDJJrQ/hOdk8Uojokzqh7Z3ITCRhciumDkGHWnTJX5
         tzPVAIYFvPoKcZ7KGOBqwkGS7huO6hLBTBGNrKGqct9MjKzZFyEBhPcIZgayaeW2mLvr
         +2BA==
X-Received: by 10.170.67.66 with SMTP id j63mr20289442ykj.83.1434726264089;
 Fri, 19 Jun 2015 08:04:24 -0700 (PDT)
Received: by 10.37.114.85 with HTTP; Fri, 19 Jun 2015 08:04:03 -0700 (PDT)
In-Reply-To: <20150619093251.GQ18226@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272160>

2015-06-19 11:32 GMT+02:00 John Keeping <john@keeping.me.uk>:
> On Fri, Jun 19, 2015 at 10:57:55AM +0200, Michael J Gruber wrote:
>> Junio C Hamano venit, vidit, dixit 19.06.2015 00:55:
>> > John Keeping <john@keeping.me.uk> writes:
>> >
>> >> I think the summary is that there are some scenarios where the ex=
ternal
>> >> diff tool should see the smudged version and others where the cle=
an
>> >> version is more appropriate and Git should support both options. =
 It
>> >> seems this is a property of the filter, so I wonder if the best s=
olution
>> >> is a new "filter.<name>.extdiff =3D [clean|smudge]" configuration
>> >> variable (there's probably a better name for the variable than
>> >> "extdiff").
>> >
>> > Not just the external diff, but the textconv filter obeys the same
>> > rule.  The setting should be done the same way for both, if we are
>> > going to go in that direction.
>> >
>>
>> textconv is a "one-way" filter from "blob" to "readable blob". Exter=
nal
>> diffs may prefer to work on "blob" rather than "readable blob", but =
the
>> currect setup does not seem to produce surprises.
>>
>> clean and smudge are two-way filters: clean from "worktree blob" (ak=
a
>> file) to "repo blob", smudge the other way round.
>>
>> Typically, the user perceives these as inverse to each other. But we
>> only require clean to be a left-inverse of smudge, i.e. "(cat-file t=
hen)
>> smudge then clean" should give the same "repo blob" (as "cat-file").
>>
>> We don't require that the other way round, i.e. we don't require smu=
dge
>> to be a left-inverse of clean, and in most setups (like the current =
one)
>> it is not: smudge does not recreate what clean has cleaned out. It i=
s a
>> no-op (the "identity", while clean is a "projection").
>>
>> Now, since external diff runs on smudged blobs, it appears as if we
>> mixed cleaned and smudged blobs when feeding external diffs; whereas
>> really, we mix "worktree blobs" and "smudged repo blobs", which is o=
kay
>> as per our definition of clean/smudge: the difference is irrelevant =
by
>> definition.
>
> I agree with this.
>
> But I was wrong that "should diff clean"/"should diff smudged" is a
> property of the filter.  I can also imagine a situation where a more
> intelligent external diff tool wants to see the smudged version where=
 a
> na=C3=AFve tool would want the clean version.
>
> For example, some of the big file stores (e.g. git-lfs [1]) use
> clean/smudge filters and I can imagine a diff utility that avoids
> needing to fetch the data for large files and instead shows the diff =
on
> the server when both blobs are available there.  In that case we
> generally want to use the smudged copy for external diff, so the filt=
er
> would use that setting, but the diff utility knows better and would w=
ant
> to override that.
>
> [1] https://github.com/github/git-lfs

I can understand why they are not fed with the clean copy by default.
Since some external diff tool enable modifying the working copy file,
this would correspond to apply the cleaning filter to the working copy
version.

Nevertheless, in my case it would be really helpful if there were an
option to feed the external diff tool with the cleaned version.
Otherwise, I'll probably write a custom script which does this.
