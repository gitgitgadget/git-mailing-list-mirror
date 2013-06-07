From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 7 Jun 2013 12:02:36 -0700
Message-ID: <CAPKkNb4myh9MPNSgLqs5Mku-z1EOsHyWrgK2Qy_3_UOivXvcnw@mail.gmail.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
	<20130607063353.GB19771@paksenarrion.iveqy.com>
	<CAPKkNb5PyurX1eNsCsckdfiwgM3dqb5KpN9OS0NpLZw1+VsSdg@mail.gmail.com>
	<20130607175717.GA25127@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:02:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1vv-0000G5-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179Ab3FGTCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 15:02:39 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38445 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab3FGTCi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 15:02:38 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so2496165lbi.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wMfBZfnwzGSgMwIt1OQ3uH3R4o1To8Za8MvLxFo0Hkk=;
        b=cSIZcAGeEbRWYXIEG/DMQeO3ELmCU6v6PNZ+FfVMTVuORAIOL5uIEFM9FfMMPoZzSo
         Q6pTeOTUc/813S8jrObFneczen9bUOoWxhKJ46GeQfrA6DbHDlvLH+LL3OqDfro8kwXn
         5GEedyLY5IbRg/0XHW1aFVLgBuGhPdyN2sY2uP2PQ/0C8I41Ln7uRw0bZjFUofWAk9vP
         pxUqslRdF9DosKm/1aaB1E1H/VFIHI1DUo2aaOUTqM0y4Ziidji91+aZt7skDkmg/8lh
         sFlW6fG0qN+Sy0IzRwzKZnIQYwIt03xyaumXDrXiAYLThvNt6etAIaEr92viiLSibCGg
         7qGA==
X-Received: by 10.112.35.137 with SMTP id h9mr1002824lbj.20.1370631756826;
 Fri, 07 Jun 2013 12:02:36 -0700 (PDT)
Received: by 10.114.77.1 with HTTP; Fri, 7 Jun 2013 12:02:36 -0700 (PDT)
In-Reply-To: <20130607175717.GA25127@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226673>

On 7 June 2013 10:57, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Fri, Jun 07, 2013 at 10:05:37AM -0700, Constantine A. Murenin wrot=
e:
>> On 6 June 2013 23:33, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > On Thu, Jun 06, 2013 at 06:35:43PM -0700, Constantine A. Murenin w=
rote:
>> >> I'm interested in running a web interface to this and other simil=
ar
>> >> git repositories (FreeBSD and NetBSD git repositories are even mu=
ch,
>> >> much bigger).
>> >>
>> >> Software-wise, is there no way to make cold access for git-log an=
d
>> >> git-blame to be orders of magnitude less than ~5s, and warm acces=
s
>> >> less than ~0.5s?
>> >
>> > The obvious way would be to cache the results. You can even put an
>>
>> That would do nothing to prevent slowness of the cold requests, whic=
h
>> already run for 5s when completely cold.
>>
>> In fact, unless done right, it would actually slow things down, as
>> lines would not necessarily show up as they're ready.
>
> You need to cache this _before_ the web-request. Don't let the
> web-request trigger a cache-update but a git push to the repository.
>
>>
>> > update cache hook the git repositories to make the cache always be=
 up to
>> > date.
>>
>> That's entirely inefficient.  It'll probably take hours or days to
>> pre-cache all the html pages with a naive wget and the list of all t=
he
>> files.  Not a solution at all.
>>
>> (0.5s x 35k files =3D 5 hours for log/blame, plus another 5h of cpu =
time
>> for blame/log)
>
> That's a one-time penalty. Why would that be a problem? And why is wg=
et
> even mentioned? Did we misunderstood eachother?

`wget` or `curl --head` would be used to trigger the caching.

I don't understand how it's a one-time penalty.  Noone wants to look
at an old copy of the repository, so, pretty much, if, say, I want to
have a gitweb of all 4 BSDs, updated daily, then, pretty much, even
with lots of ram (e.g. to eliminate the cold-case 5s penalty, and
reduce each page to 0.5s), on a quad-core box, I'd be kinda be lucky
to complete a generation of all the pages within 12h or so, obviously
using the machine at, or above, 50% capacity just for the caching.  Or
several days or even a couple of weeks on an Intel Atom or VIA Nano
with 2GB of RAM or so.  Obviously not acceptable, there has to be a
better solution.

One could, I guess, only regenerate the pages which have changed, but
it still sounds like an ugly solution, where you'd have to be
generating a list of files that have changed between one gen and the
next, and you'd still have to have a very high cpu, cache and storage
requirements.

C.

>> > There's some dynamic web frontends like cgit and gitweb out there =
but
>> > there's also static ones like git-arr ( http://blitiri.com.ar/p/gi=
t-arr/
>> > ) that might be more of an option to you.
>>
>> The concept for git-arr looks interesting, but it has neither blame
>> nor log, so, it's kinda pointless, because the whole thing that's sl=
ow
>> is exactly blame and log.
>>
>> There has to be some way to improve these matters.  Noone wants to
>> wait 5 seconds until a page is generated, we're not running enterpri=
se
>> software here, latency is important!
>>
>> C.
>
> Git's internal structures make just blame pretty expensive. There's
> nothing you really can do for it algoritm wise (as far as I know, if
> there was, people would already improved it).
>
> The solution here is to have a "hot" repository to speed up things.
>
> There's of course little things you can do. I imagine that using git
> repack in a sane way probably could speed things up, as well as git g=
c.
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
