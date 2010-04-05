From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Mon, 5 Apr 2010 12:50:11 +0000
Message-ID: <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
	 <1270392557-26538-1-git-send-email-avarab@gmail.com>
	 <20100404224324.GB12655@gmail.com>
	 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
	 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
	 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
	 <20100405055139.GA28730@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 05 14:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyll4-0008FO-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 14:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0DEMuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 08:50:14 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:42473 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab0DEMuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 08:50:12 -0400
Received: by mail-ew0-f220.google.com with SMTP id 20so1025647ewy.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HlESX3htCe9n/sP/cf9TOetb4t1xTXxiCn/ssbuQJR8=;
        b=sd0tqUeQ1R+SgbNRAjNXIT3+Eq+SnUXrPWohRvNBsMb2CcsP+9TF5AlVs4k/SEzdiK
         qznoNVEcQo/QWB8WVjRjDNBSmsZO7pCqCjsn3x7HV1TR7Mc52yx+WVz/ztEmfV1G1GvJ
         75wJi0c1co6hXFcfI/ieISYP6w3s2kzOHwoyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i7OfYS2lTYBWVwsN6F2Y9BKEUwBEhPvQQkuFMwS/w49XrMGyMXozrKSz4kJwkUTBj2
         Qy/HZUOZp47y+vFlg205bR8ZQUX8Q2Su6tPC61PgX4V7Y7QHvzlPC9HIZx1+we8mn4IV
         00PA1R6rqvSuZLDaIErxvdKS0ZIPvZz8TAhOQ=
Received: by 10.213.14.201 with HTTP; Mon, 5 Apr 2010 05:50:11 -0700 (PDT)
In-Reply-To: <20100405055139.GA28730@coredump.intra.peff.net>
Received: by 10.213.54.12 with SMTP id o12mr1510472ebg.35.1270471811337; Mon, 
	05 Apr 2010 05:50:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143979>

On Mon, Apr 5, 2010 at 05:51, Jeff King <peff@peff.net> wrote:
> So yes, it sucks that his importer does not support empty comments, a=
nd
> that the OP had to hack around it. But it already doesn't support man=
y
> things (like commits with a large number of files, and from what I ca=
n
> see, files with spaces will break his `find` invocation). The right
> answer is for him to move to fast-import, which will be way faster, m=
ore
> robust, and is actually a supported plumbing interface.

Thanks for looking at the importer, that'll be very useful when fixing
it. But FWIW that `find` invocation isn't a bug. Perl doesn't have a "
" input field separator so "my @files =3D `find . -type f`" does the
right thing, unlike in the shell.

> I don't think it's worth adding new features to support a scripting
> interface that we are trying to discourage. And I haven't seen anothe=
r
> argument in favor of empty commits besides importing. =C2=A0Are peopl=
e
> really wanting to make empty commit messages while using git itself?

I'm sorry that I brought snerp-vortex into this at all. It wasn't the
main motivation behind this patch, just the straw that broke the
camel's back.

I've run into this limitation a lot when playing with and learning
Git. Sometimes I'm e.g. making small throwaway repositories in /tmp
using the porcelain for  experimentation. Those have seen a lot of
"blah!" commit messages immediately following "Git exited abnormally
with code 1".

Miles Bader said it better than I could. Tools should provide sane
defaults and discourage bad practices, but they shouldn't *enforce*
good practices. That'll inevitably burn people whose use for the tools
isn't what you expect.

Even if they Git maintainers don't like this people *do* write
automated scripts and wrappers around Git using the porcelain, simply
because that's what they're used to. Learning to use and switching to
something like git-fast-import(1) or git-commit-tree(1) is too big of
a hurdle for small throwaway scripts that take ~1m to write and aren't
big dedicated importers like snerp-vortex.

There's probably a lot of code out there doing `git commit -m"Yet
another revision"' from some cron job. I sprinkled a lot of such
meaningless messages about when I switched from Subversion (which
supports empty commits in the porcelain) for these automated jobs to
Git.

Of course Junio may disagree (and that's fine!), how much you babysit
your users is ultimately a design decision up to the maintainer. I
just find this inconsistent with the rest of the porcelain which
usually gives me plenty of ammo to blow both my legs of (and the
planet they were standing on) if I so choose :)
