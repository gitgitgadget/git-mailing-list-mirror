From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Mon, 9 May 2011 21:07:31 +1000
Message-ID: <BANLkTikUjGLBH6_ze7EvRfoKb9h-RREmuA@mail.gmail.com>
References: <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
	<BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
	<20110506065601.GB13351@elie>
	<BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
	<20110506172334.GB16576@sigill.intra.peff.net>
	<BANLkTikDVBgOqd1U=qSL99U3K8EtLVTxtw@mail.gmail.com>
	<20110509073535.GA5657@sigill.intra.peff.net>
	<BANLkTi=tfxPN=WLmfn=d+jrHV3U-Rp8T=A@mail.gmail.com>
	<20110509081219.GB6205@sigill.intra.peff.net>
	<BANLkTimKRo_36Ce2aFWWXdM1a+EgQ-u77Q@mail.gmail.com>
	<20110509104446.GB9060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 13:07:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJOJO-0007s5-AT
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 13:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302Ab1EILHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 07:07:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63660 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1EILHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 07:07:32 -0400
Received: by vxi39 with SMTP id 39so5627677vxi.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 04:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3wgeA9cDHMsbbg1mGdbI8MSWoUL3DQmJF45y4XDCTJY=;
        b=t16qppiYkUvbGnAAJuI1BLilyXQeANKyiyQ4H/vzHpngXuJifV60o2vyFoe4kRa87v
         DsI3lCTMjYV9uejMr41gwMHFD6b27kOuIZMVsx4jSUEC4kH/wGTXlwpc8c9Ad4B+aGhK
         o/Uq8EblL5+grSh0iCmdoXcDztm9/NERpisgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b/rjYbdC200Rn6cK0X2At3GJ1itgDj/0VXdwgKScZpl2erT4UFAQ0xTBxskautqj+y
         wjEpdfGE9Hhde4G5Q7GBG9TAl+svxq4A34Q+ld8uE9gVJLGZWQNKy4lTMLAEGwvmMpNB
         0IYpBBHKs2y/1YQcaWyAXP+OCiZfxEHLIOiVo=
Received: by 10.52.76.106 with SMTP id j10mr718184vdw.39.1304939251814; Mon,
 09 May 2011 04:07:31 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Mon, 9 May 2011 04:07:31 -0700 (PDT)
In-Reply-To: <20110509104446.GB9060@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173219>

On Mon, May 9, 2011 at 8:44 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 09, 2011 at 06:45:56PM +1000, Jon Seymour wrote:
>
>> I am starting to think that deploy-via-zip/tar is unworkable for the
>> case where the extension wants to supply html, since I think an
>> attempt has to be made to deploy HTML in the path reported by git
>> --html-path for reasons of HTML =C2=A0linkability from extension bac=
k to
>> the pages from git-core.
>
> Yeah, I don't see a way around that without post-processing the HTML
> links at install time (or creating a symlink farm with all of the HTM=
L
> pages).
>
>> So, suppose we call it --preferred-extension-path*, then if the user
>> (root or otherwise) defines
>>
>> =C2=A0 =C2=A0 git config core.preferrred-extension-path ${HOME}/.git=
plugins
>>
>> then they get to choose where the installer next run will install ex=
tensions.
>
> I thought about suggesting that, but a config option didn't seem a go=
od
> fit to me. The decision of where to put a package seems more likely t=
o
> be related to which _package_ it is, than which user you are. So a
> command-line option would make more sense. And even if you have a con=
fig
> option, you would sitll need a command-line one to override, so it's =
not
> like you are reducing the amount of code or complexity.
>
> Which again makes it not a git issue at all, but an issue for
> package-writers who want to provide a script. It's their job to inter=
act
> with the user and find out where the user wants to put things (i.e.,
> personal or system directories).
>
> I don't really see any need for git's role in this to be more than:
>
> =C2=A01. Check a set list of directories for extra paths to add to PA=
TH and
> =C2=A0 =C2=A0 MANPATH.
>
> =C2=A02. Tell the packager's script what that set list is, so they ca=
n be
> =C2=A0 =C2=A0 sure to put their files in the right spot.
>

The problem with presenting a list of possible directories is that
given a list, the choice is ambiguous. Sure a decision procedure can
be arrived at to choose, but it might be hard for the user to predict
what decision the procedure will reach. In that case, the user must be
prompted for a selection.

Ideally most extension installs would not require any kind of
configuration or decision by the user - simply a statement, I want
this installed and I want it to be available immediately.

The idea, I think, is to make this decision once, not every single
extension install. Chances are
git's default guess will be pretty good (say, /usr/local), but if a
user decides that he wants to install
this, and all future extensions in ~/.gitplugins, then this can be
indicated once, with global configuration
that overrides the compiled in default.

Again, part of the idea is to give the extension installer some degree
of confidence that the selected prefix/bin is, in fact,
in the path and to give the user an override in case the compiled in
default isn't workable for some reason (for example, due to a
permissions issue).

jon.
