From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Thu, 5 Nov 2009 19:09:48 -0600
Message-ID: <20091106010947.GB4425@progeny.tock>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Lee <richard@webdezign.co.uk>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 06 02:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6DBo-0006ef-ED
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 02:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756955AbZKFBAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 20:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbZKFBAV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 20:00:21 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:57574 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbZKFBAU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 20:00:20 -0500
Received: by ywh40 with SMTP id 40so522159ywh.33
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JXilMk8c3JwcN9t7fRzocbRHiBoHUQxz44A5+Eqcx+U=;
        b=cqE3lVdPvkej7ov5O4kNN2gL+FHtBRUFxgOY3eYHb9/qdI7wOPuRGZHngZGLX2Y1Gu
         57STg/WgQhI/TGdmSiKVZJj25YgRcfd4rb1kPSNfcwL8oUxEAEJGxFqpevKmwfx0l0ne
         iTYVTaqZLlohNQolkQEuHso/smzY1qNmncsYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YOZtpEdIdPlQKVA1iAEFBljJEjeTJrvjA5Hg0vVi9qXSS5Ow3Sd/rvKn1X33tQk+Gr
         d3m3ZLrKQk8bWHv2ktvShPHxBA6Dfxeur16T302QBV2Zeh+EO/HwRmyl52FZTWz15sLF
         ftzC8bp9S68nejvDhdjVV6Bv/dPx0x5kg2bhY=
Received: by 10.101.129.1 with SMTP id g1mr2350992ann.124.1257469223547;
        Thu, 05 Nov 2009 17:00:23 -0800 (PST)
Received: from progeny.tock (wireless-239-184.uchicago.edu [128.135.239.184])
        by mx.google.com with ESMTPS id 22sm1181648yxe.39.2009.11.05.17.00.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 17:00:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091105232848.GA1939@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132264>

Bj=C3=B6rn Steinbrink wrote:

> I guess Richard took the "branch topic1, merge topic1, branch topic2,
> merge topic2" thing just as an example because that ends up with two
> fast-forwards.

Hmm, I found Richard=E2=80=99s example pretty realistic.  I used to wor=
k like
that, and I don=E2=80=99t think I am the only one.

> And your example _still_ has such a fast-forward.

Yep, if you really want to avoid fast-forwards, please use "--no-ff"!

But what I was trying to make clear was that in some workflows, the
fast-forwards are not so harmful.  They even make the history a little
cleaner (easier to read and understand).

> Instead of:
>=20
> A---B---C---D---E (topic2) (master)
>      \
>       F---G---H (topic1)
>=20
> He wants:
>=20
>       F---G---H (topic1)
>      /
> A---B-----------M (master)
>      \         /
>       C---D---E (topic2)
>=20
> So he can see at which point topic2 got merged. This allows to ask "w=
hich
> commits got merged here" (and for a merge-once topic branch this mean=
s:
> Which commits are related to that topic), by using for example:
>=20
> git log M^1..M^2 # Will show C, D and E

You can get the same information locally even with a fast-forward:

git log master@{1}..master

But to someone reading the published history, it is not available.
Depending on your way of working, this may or may not be reasonable.

Perhaps your merge commit messages contain important information about
the branch=E2=80=99s overall purpose and provenance, which would be imp=
ossible
if there is no merge commit.

On the other hand, if the goal is just to present the fact of a merge,
to explain where a patch falls in the larger scheme of things, then
how large a chunk of changes I decided to call a feature does not seem
too important.

Imagine a patch series, cleaning up some ugly code that has been
bothering me for a while:

 base [master] --- A --- B --- C [cleanup]

It looks good, so I merge to master with --no-ff.

 base --------- D [master]
     \         /
      A---B---C [cleanup]

Looking at that code inspires me to build a new feature that is much
easier with the cleaned up version.  So I fork a branch from cleanup
(Or master?  Their content is the same, but somehow I choose one) and
write some patches for the new feature.

 base --------- D [master]
     \         /
      A---B---C [cleanup] --- E --- F --- G

It looks good, so I merge.

 base --------- D --------- H [master]
     \         /           /
      A---B---C---E---F---G

Is this really any easier to read than base---A---B---C---E---F---G?
In hindsight, was this logically really two series, or is the D commit
extra cruft?

Almost always, a fast-forward comes from a continuation of this kind,
since that is what it means for a commit to be the logical commit to
fork from.

Of course, these things are a matter of taste.  I just wanted to
explain why a fast-forward could at least sometimes be the right
result from merging a topic branch (and why, in practice, some people
never end up needing to use --no-ff).

Regards,
Jonathan
