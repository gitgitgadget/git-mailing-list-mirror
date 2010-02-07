From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 11:57:58 +0100
Message-ID: <cb7bb73a1002070257g8f1e59dvf124c8966cdf3270@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002062314.00631.jnareb@gmail.com> <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com> 
	<201002070220.36897.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 11:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne4qQ-0005hK-7E
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 11:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933650Ab0BGK6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 05:58:21 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:50867 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242Ab0BGK6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 05:58:19 -0500
Received: by ewy28 with SMTP id 28so1500567ewy.28
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 02:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=evlW+R0zNELyuG8qpJzr84MMcjNWXafn7jgOeZLIIAM=;
        b=WpnIjbIvgFZGzjEwNnVN0trX0k2P1fQkCbl03sbF20m9PAPNQZkjWKohDoMuu0gKUd
         3QLxl6G+ssm5bQm97bzc/E2CUo1B+YrppTAkR6dmFh89AJECxiaOyJqUrSu6c7zj1pas
         m8lxsP5ErgbNHXJbdvS3U0OHqB81VJJhVgpvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sXDI07xwiHTmG4D3WimrURlxfzR60YSaJ4uDPE83wkzUJ7FD4P62HY/PbznhmiOaqu
         gBVzfYAVyuD9nQ/P2XyetarFSl9a0TTlfNuEo45vlPnFbZL+W5Xkl7Vl/aRQmqcdM4/n
         KsaDXDWQs1HTT4K/QsQKMtRLvLdV73kIf8EMQ=
Received: by 10.213.109.199 with SMTP id k7mr2571873ebp.66.1265540298314; Sun, 
	07 Feb 2010 02:58:18 -0800 (PST)
In-Reply-To: <201002070220.36897.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139231>

On Sun, Feb 7, 2010 at 2:20 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
>> On Sat, Feb 6, 2010 at 11:14 PM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>> So it is to be single shell-glob / fnmatch (I think) compatible pat=
tern,
>>> isn't it?
>>
>> Sort of. fnmatch doesn't do brace expansion, which is a pity IMO, bu=
t
>> that's just my personal preference.
>
> Well, fnmatch is what I think git uses for <pattern> e.g. for
> git-for-each-ref.

fnmatch is the function to use to match a single component. The
question is how to group components together in a single spec (aside
from shell globs and []); my personal choice would be brace expansion,
colon-separated was suggested by (IIRC) Junio. Of course, for gitweb
I'll go with whatever is chosen for core.

>> Colon-separated, fnmatched components is probably the easiest thing =
to
>> implement to have multiple refs. I'll go with whatever is chosen for
>> core.
>
> I think that having actual list of patterns in $feature{'notes'}{'def=
ault'}
> might be more clear; you would still need colon separated (or space
> separated) list of patterns in per-repo override in gitweb.notes conf=
ig
> variable.
>
> So it would be
>
> =A0$feature{'notes'}{'default'} =3D ['commits', '*svn*'];
> =A0$feature{'notes'}{'override'} =3D 1;
>
> but
>
> =A0[gitweb]
> =A0 =A0 =A0 =A0notes =3D commits:*svn*
>
> Note that refs names cannot contain either colon ':' or space ' '
> (see git-check-ref-format).

That makes sense. Colon-separated values will probably be allowed in
$feature{'notes'} too, which will keep the code more consistent.

[...]

>>> The above fragment of code is tested that it works. =A0You would pr=
obably
>>> need to replace dies with something less fatal...
>>
>> On the other hand, as mentioned by Junio, this approach is not
>> future-proof enough for any kind of fan-out schemes.
>
> On the third hand ;-P you propose below a trick to deal with fan-out
> schemes, assuming that they use 2-character component breaking.
>
> Also, perhaps "git notes show" should acquire --batch / --batch-check
> options, similar to git-cat-file's options of the same name?

There is little doubt that batch note processing should be available
in core, be it with git notes show --batch(-check), git ls-notes, or
both. I also agree with Johan that gitweb should use these mechanisms
as soon as they are available. The approaches we're discussing here
are basically a temporary workaround for the missing core support.

[...]

>> If we have a guarantee that the fan-outs follow a 2/[2/...] scheme,
>> the open2 approach might still be the best way to go, by just trying
>> not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
>> Horrible, but could still be coalesced in a single call. It mgiht al=
so
>> be optimized to stop at the first successfull hit in a namespace.
>
> Nice trick! =A0It seems like quite a good idea... but it would absolu=
tely
> require using 'git cat-file --batch' rather than one git-show per try=
=2E

Oh, that's a given. git-show was just the only approach I could think
of not knowing about the batch processing git commands.

>> I'm not getting these in the repo I'm testing this. And I think this
>> is indeed the behavior of current git next
>
> Errr, I not made myself clear.
>
> I have added a note to a commit, using "git notes edit d6bbe7f". =A0N=
ow if
> you take a look at gitweb output for this commit (e.g. 'commit' view =
for
> this commit) using gitweb without your changes, you would see that it
> flattened notes at the bottom of the commit message (which I think is
> intended result by notes implementation).
>
> If you run the command that parse_commit runs, namely
>
> =A0$ git rev-list --parents --header -z --max-count=3D1 \
> =A0 =A0d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3
>
> you would get (up to invisible NUL characters) the output shown above=
=2E

And that's what I don't get. git version 1.7.0.rc1.193.ge8618. If I
remember correctly, the behaviour of automatically displaying notes in
git log & friends was changed recently. So git log -1
e8618c52b5f815624251f048609744c9558d92a1 gives me the notes I put
there for testing, git rev-list --parents --header -z --max-count=3D1
does not.

--=20
Giuseppe "Oblomov" Bilotta
