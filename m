From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 11:25:04 -0500
Message-ID: <20100422162504.GA4913@progeny.tock>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
 <20100422144433.GB28923@coredump.intra.peff.net>
 <20100422145455.GC28923@coredump.intra.peff.net>
 <20100422150325.GB4801@progeny.tock>
 <20100422151708.GA15039@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 22 18:29:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4zHm-0005XY-D4
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 18:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab0DVQ3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 12:29:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:19339 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab0DVQ3p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 12:29:45 -0400
Received: by fg-out-1718.google.com with SMTP id d23so497010fga.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ENs/UsKD4EFZ0cF+wo/kr0wRbqzDaCyfeqEjHxP5bzM=;
        b=IIVKPt2Kq45HqVY54nGIhWqAkInyzCTurHChbdLzRfvE6bhqRATaTbwt93WsglIWUJ
         6VbQkFs0ZaJMqZNs58lj0fRcyNt/8l+oPUOJsrL+6uBw8ORd3EYkTO6wqPzyZ66Dg11W
         YayOc/a5l1vh/eFeouMB/38HhQzgKOalL8HpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r//KoPvyAgl/Y7Sgt2v0JSvPkAnILilYeYSTIshX3FK4aVsj+dCwzHrW82FWzfTguw
         D1Kf8RFz4QtSjYyN6czaoZuJPfGx+XEXhI/Uvvxj4LluYEkU3kqaHcHbkF0ASb7RST9+
         Kk0IMV++qdis2aaNwUpHa8Rjcszqn9aqFHPfI=
Received: by 10.223.35.12 with SMTP id n12mr324474fad.35.1271953495330;
        Thu, 22 Apr 2010 09:24:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm46697fah.20.2010.04.22.09.24.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 09:24:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422151708.GA15039@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145542>

Hi Ted,

maximilian attems attems noticed that =E2=80=98git name-rev=E2=80=99 ha=
s trouble with
some commits from the ext4 tree [1].  Jeff King investigated:

Jeff King wrote:
> On Thu, Apr 22, 2010 at 10:03:25AM -0500, Jonathan Nieder wrote:
>> Jeff King wrote:

>>> Still looking, but definitely some kind of skew problem.
>>
>> That explains it, then:
>>
>> $ git log --format=3D%cd' %h' 19f5fb7 ^v2.6.34-rc1~200
>> Sun Jan 24 14:34:07 2010 -0500 19f5fb7
>> Mon Dec 7 10:36:20 2009 -0500 d2eecb0
[...]
> Thanks for confirming, that was the same stretch of history I ended u=
p
> looking at.

It seems that the committer date is set to coincide with the author
date for ext4 patches, which breaks some assumptions by git that each
commit has a later or equal committer date than all parents (modulo
some skew).

How is the ext4 tree generated from your patch queue?

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/145449

>> Is the rule that every commit must be at most one day before each of
>> its parents?  This should probably be documented somewhere, since it
>> is possible to override the committer date with GIT_COMMITTER_DATE.
>
> There is no hard and fast rule. We have to deal with _some_ clock ske=
w,
> but I think it has been anybody's guess how much. One can always trea=
t
> the graph purely topologically (which is what my first patch removing
> the cutoff_date check did), but that usually means more computation. =
In
> this case, we go all the way to the roots instead of looking at a
> "recent" subgraph. I think we also look at timestamps in rev-list whe=
n
> linearizing to avoid doing a full topo-sort, but I don't remember wha=
t
> effects clock skew can have there.
>
> So what should we do with this incident?
>
>   1. Declare it too much clock skew and ignore it.
>
>   2. Drop the cutoff optimization in favor of correctness. We already=
 do
>      this for --stdin, as there is no sensible cutoff for multiple
>      inputs. So you can see how much slower it is:
>
>        $ time git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
>        a1de02dccf906faba2ee2d99cac56799bda3b96a undefined
>
>        real    0m0.163s
>        user    0m0.140s
>        sys     0m0.020s
>
>        $ time echo a1de02dccf906faba2ee2d99cac56799bda3b96a |
>          git name-rev --stdin
>        a1de02dccf906faba2ee2d99cac56799bda3b96a (tags/v2.6.34-rc1~199=
^2~35)
>
>        real    0m3.411s
>        user    0m3.244s
>        sys     0m0.164s
>
>      So perhaps it is something one would want to enable with a
>      command-line option. Or even something we could fall back on
>      automatically as a "slow case" when coming up with an un-nameabl=
e
>      rev.
>
>   3. Bump the slop date. 60 days would work here. What's reasonable? =
A
>      year? At one year, we are still noticeably slower:
>
>        # patched for CUTOFF_SLOP_DATE (365*86400)
>        $ time git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
>        a1de02dccf906faba2ee2d99cac56799bda3b96a
>        tags/v2.6.34-rc1~199^2~35
>
>        real    0m1.075s
>        user    0m1.028s
>        sys     0m0.044s
>
> -Peff
