From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 14:56:28 +0100
Message-ID: <AANLkTinu+Wq84x2H0vB3rUSXbwreumrDC7k2dr5nOfjC@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
 <AANLkTinvM6OhLdeKt5MqEeNhZJx63X+KzOy_ngEsy0A2@mail.gmail.com> <AANLkTi=G1ZpiaRN8vWYBJ33_ZOXo1t616X5gQU+jNda_@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 14:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKtMd-0004xM-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab0KWN4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:56:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60195 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0KWN4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:56:50 -0500
Received: by fxm13 with SMTP id 13so3881093fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=6HtjNRVmUQvv/bewERjAltVB1o9mt+UzjfJz+yS8cOA=;
        b=T1fNB4EBDW2RqnhxNVia6ZAp2mbrXTuYt6HO3CEAH7ToP+l3DaHYvRXbMmV+vdXPlW
         X9D7BLrGTp8ojj62OCykF2v569mAlUxdFVgDPYSNINfir3FI7Frjb5R1DXEOSIZrQHju
         qWdi+l9iuInnfq5EzhN2DINJHp4jfJZTQe37U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=xaM5W6SvYE8vUU2wfNRZGmdJiMIGLLHnhLZ/rJwLpZxGPZvzT0i5o4NoxIi3GB4hZn
         IByOiZRqjtYGDKZx9uufCnmzV2M1nb3YiPBuU4g6Bh+Xhwj5lU2Dl3fjJH3eA0seyXT5
         fLmNjF8o03uj5KbiRNLmYyS+YBS/im7ifwseM=
Received: by 10.223.72.14 with SMTP id k14mr6394197faj.45.1290520608708; Tue,
 23 Nov 2010 05:56:48 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 05:56:28 -0800 (PST)
In-Reply-To: <AANLkTi=G1ZpiaRN8vWYBJ33_ZOXo1t616X5gQU+jNda_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161963>

On Tue, Nov 23, 2010 at 2:47 PM, Tarek Ziad=E9 <ziade.tarek@gmail.com> =
wrote:
> On Tue, Nov 23, 2010 at 2:22 PM, Erik Faye-Lund <kusmabite@gmail.com>=
 wrote:
>> On Tue, Nov 23, 2010 at 1:23 PM, Tarek Ziad=E9 <ziade.tarek@gmail.co=
m> wrote:
>>> Hello,
>>>
>>> I am new to Git and I tried to run "git st"
>>>
>>> I have found one small bug: "status" is not listed in the help scre=
en
>>> Git displays in that case.
>>>
>>> $ git st
>>> git: 'st' is not a git command. See 'git --help'.
>>>
>>> Did you mean one of these?
>>> =A0 =A0 =A0 =A0reset
>>> =A0 =A0 =A0 =A0stage
>>> =A0 =A0 =A0 =A0stash
>>>
>>
>> This isn't strictly speaking a bug. Git uses Levenshtein distance
>> (http://en.wikipedia.org/wiki/Levenshtein_distance) to figure out wh=
at
>> to suggest. If any command has a sLevenshtein distance of less than =
6
>> (given our coefficients), then all commands with that distance is
>> suggested. But perhaps we should do something different
>>
>> But perhaps we could do better. We have some commands that are
>> considered more "important", ie the ones listed when doing "git help=
"
>> without "--all". "status" is one of these. Perhaps these commands
>> should always be included if they are below the Levenshtein distance
>> threshold or something?
>>
>
> Oh, interesting ! Levenshtein is great for typos but highly depends o=
n
> the fact that the word I am entering has about the same length as the
> command I am looking for.
>
> When I typed "st" I was thinking about an alias/shortcut. So the
> question would be: is "st" a common alias in the git community for th=
e
> "status" command ?
>
> If the answer is yes, and if there are other common aliases used out
> there, I would suggest keeping the Levenshtein distance as it is now,
> but complete the list of suggestions by using a "common aliases
> mapper."
>

I experimented a bit around, and the last idea I played around with
was to keep the Levenshtein-suggestions as-is, but to add all common
commands that had the entered command as a prefix. That's a bit more
generic than what you suggested, but also not as flexible as it would
have to be a strict prefix.
