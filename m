From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Stable ab/i18n branch
Date: Tue, 19 Oct 2010 08:05:30 +0200
Message-ID: <4CBD352A.8040304@drmicha.warpmail.net>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org> <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com> <20101014200027.GA18813@burratino> <7vwrph4eeb.fsf@alter.siamese.dyndns.org> <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com> <7vmxqb2hqk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 08:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P85K4-0001OM-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 08:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318Ab0JSGFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 02:05:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49616 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840Ab0JSGFL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 02:05:11 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A8D9D28A;
	Tue, 19 Oct 2010 02:05:10 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 19 Oct 2010 02:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pVgwPAzliMUAl6LSiMiS65KDgm8=; b=rMygk76VyvUQBcCzVBad7ho5EsH5KkP4ooqcI5FwkpevrMEC8+EqYznRclxxJhQBpqhdUun0ouakQyiatljwc3JuOqya0PdY69VVUlkTfzN19pLgh6CXeqZ84Fl7e4fcW67fnGzqNHFChdbZ9UwW5r49rREbvF0Pc3BZ71q5OfA=
X-Sasl-enc: W+yLugNB6SuxbdvgFjCkHWwf7kFMtUe3mdqnWPR18q9H 1287468310
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C77065E3675;
	Tue, 19 Oct 2010 02:05:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vmxqb2hqk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159305>

Junio C Hamano venit, vidit, dixit 19.10.2010 01:39:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
>> Do you mean to re-arrange it so that there's a patch at the front of
>> the series that introduces gettext.h with only the fallbacks:
>>
>>     #define _(s) (s)
>>     #define N_(s) (s)
>>
>> And then merge the ~120 gettextize patches first and do the
>> infrastructure later?
>=20
> Not really.
>=20
> Two pieces that would be nice to have in 'master' (or even 'maint', i=
f we
> consider avoiding merge conflicts and mismerges when fixes are queued
> there) are:
>=20
>  1. preparatory fixes to code that builds message string by concatena=
ting
>     parts of speech in English word ordering into buffer or emitting =
to
>     output stream piece by piece; they should convert them to some fo=
rm of
>     sprintf-like format strings plus arguments.  This does not necess=
arily
>     have to mark the format strings with _(s).
>=20
>  2. the empty definitions for _(s) and N_(s).
>=20
> I would consider the first one part of general clean-up job, which we=
 know
> will help i18n, but which we would want to do regardless of i18n.  An=
d it
> is probably the most error prone part in the whole process.  The soon=
er
> the result of these two steps hit 'master', the less pain for everybo=
dy.
>=20
> And then:
>=20
>  3. actual marking of strings with _(s) and N_(s).
>=20
> which can be merged to 'next' after vetting for regression (the first=
 two
> classes).
>=20
>  4. Adding and polishing of *.po files for actual messages and langua=
ges,
>     i.e. l10n.
>=20
> This can happen pretty much independently from 3.  Honestly I would b=
e
> happier if I do not have to keep track of the actual l10n part.
>=20
> I think the current series to some degree conflates steps 1. and 3.  =
As
> the list of risks I outlined in the previous message show, mistakes i=
n 1.
> is much more grave than mistakes in 3. (iow, no big deal for having a=
 few
> untranslated messages during early rounds of i18n support); I would h=
ave
> preferred these two steps were clearly separated, so that we can push=
 the
> first two steps out to the 'master' sooner.

I'd just like to second (or third or..) Junio's points here since I had
suggested a split like that earlier already, and I think the current
state of affairs simply makes many potential reviewers (at least one
that I know of) go away.

1.,2. and (maybe to a lesser degree) also 3. should be able to find man=
y
reviewers, thus making the potentially problematic parts as solid as
possible. (I'm still waiting for a conceptual approach to 4., i.e.
glossary first, but that is a different issue.)

Michael
