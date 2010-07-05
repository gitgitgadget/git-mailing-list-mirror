From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: help moving boost.org to git
Date: Mon, 5 Jul 2010 19:32:17 -0400
Message-ID: <AANLkTimAqL8gvgIisLpWE6xj2p0jEZD5wetdGYJnOpdr@mail.gmail.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org> 
	<4C32668E.9040000@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 01:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVv9q-0004E8-UI
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 01:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab0GEXco convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 19:32:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39243 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0GEXcn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 19:32:43 -0400
Received: by gwj21 with SMTP id 21so917506gwj.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pxctpVoko9ba66t79VH240BwCA93pPRjdtzbTkSnzao=;
        b=N1k9eDAxmIoxywlzjKAk/P586HOc92DHdwAzHyglNRq0QCcY/jsEUOdFRWg3Rlf3cm
         reaDPMletaCm4AqBoKrI0Q9nFi7z/00S1i71Ou0W+VlUsQNLAv3hAHfADYfinc15BsII
         53AjlkxOMG+UoLdU5oe+DztvrwsArk5pi1mD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CnVuJBsNa/HhEmXSq5BHCnDFrkskq6EDrpVj4kwDGWWdubD0TV8bGA/jQkVFV0Rh2g
         4/+X3D2Kvrjjx/5sDkKcSvSjQV1oDhDE0Up7KjiTRnTrjtGpJkwv8Q7udIuxpH0UK8Tl
         iRFx7yp+aDSMPfl3pIEsN/ii+nLsLIryOKdm0=
Received: by 10.90.83.20 with SMTP id g20mr3826175agb.90.1278372759649; Mon, 
	05 Jul 2010 16:32:39 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Mon, 5 Jul 2010 16:32:17 -0700 (PDT)
In-Reply-To: <4C32668E.9040000@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150302>

(note: on this mailing list, you shouldn't drop names from the cc:
line when replying to a thread)

On Mon, Jul 5, 2010 at 7:11 PM, Eric Niebler <eric@boostpro.com> wrote:
> On 7/5/2010 6:04 PM, Finn Arne Gangstad wrote:
>> This
>> should fit eaily into a single repository. The Linux kernel is much
>> larger, and that is sort of the canonical single repo git project. I
>> _strongly_ recommend that you go for a single repo if you can make i=
t
>> work.
>
> It does fit into one repo, but that doesn't meet our needs for the
> future. Users want to install and build library X and its dependencie=
s,
> not all of boost. This is increasingly becoming a problem as boost
> grows. Imagine if a perl programmer had to download all of CPAN to us=
e
> or hack on any one perl module. Or if contributing to CPAN meant gett=
ing
> the whole shebang, history and all. I'm sure even in the Linux kernel=
,
> not *every* third-party driver is maintained in the master git repo.

Actually, that's mostly not true; there are a few third-party drivers
that don't make it into the core Linux repo, but that's mostly because
they haven't been accepted by the kernel maintainers for whatever
reason (often quality or duplication, I guess).  The goal for the vast
majority of Linux drivers is indeed to get merged into the Linux core.

=2E..and it works pretty well, all things considered.  It's certainly
not the only way to do it for every project, but it's actually a
pretty good way.  The kernel repo history runs to hundreds of megs
nowadays, but on a modern Internet connection that's not a big deal.
And then you never have to worry about downloading more modules later.
 You also never have versioning problems.

> We are aiming to make boost a clearing-house for C++ libraries (like
> CPAN, or PyPi for python), turning the official boost distribution in=
to
> little more than a well-tested collection of the libraries that have
> passed our peer-review and regression test process.

Of course you will want to have some kind of really excellent
versioned dependency fetching system (exactly like CPAN or PyPi or
ruby gems) if you want this to be nice.  git's submodules stuff is
almost certainly not going to add any features you need/want.  On the
other hand, cloning a separate git repo is pretty easy to write your
CPAN-like script around.

> In fact, the modularization has already been done, and work is well
> underway on the infrastructure to support dependency tracking. But th=
e
> modularization is not history-preserving and needs to be redone.

If your code doesn't move too many files around, then splitting out
the history is pretty easy with git-subtree (a tool I wrote that's not
part of git):

   git subtree split --prefix=3D/path/to/subdir

And you get a new history for just that subdir.  That might do exactly
what you want.  It also works iteratively, so you can export your
history from svn, then re-export the changes as they occur over time.

>>> So,, what are the options? Can I somehow delete from each repositor=
y the
>>> history that is irrelevant? Is these some feature of git I don't kn=
ow
>>> about that can solve this problem for us?
>>
>> How do you define "irrelevant"? Do you only require enough history f=
or
>> git annotate/blame to give correct results? =A0Or does this only ref=
er
>> to multiple repositories sharing the same ancient history?
>
> If multiple repositories share the same ancient history, wouldn't tha=
t
> give git annotate/blame enough information? Sorry, git newbie here.

Yes, it would.  But how much of the ancient history do you want?  If
you want all of it, you don't save any space in your repo.

> The plan is to move to git. However, we don't expect this to happen
> overnight, so a way to continue to pull changes from a svn mirror whi=
le
> the new git repositories are being set up would be ideal.

This isn't too hard to do; you just need some scripts around git-svn
and git-subtree (or whatever tool you use to do the splitting).  We've
done this at work for a couple of years now and it's working fine.

The confusing part is taking *submissions* back through both channels.
 If you value your sanity, you probably want to only allow submissions
back via svn while you're running the two in parallel; but that makes
git's added features a lot less useful, so you probably want to run in
parallel for only a short time.

Have fun,

Avery
