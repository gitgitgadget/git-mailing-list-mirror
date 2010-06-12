From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Sat, 12 Jun 2010 01:22:53 +0000
Message-ID: <AANLkTimfzjZ00ua23FDmUJLil-_OEPEkiS73syVCQ52f@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
	<201006081446.22587.jnareb@gmail.com>
	<AANLkTimq-46ghYT6TqXn1AB0NQIobcDaufsSJ5AEFE5z@mail.gmail.com>
	<201006120301.37931.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 03:23:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONFRR-0007h7-1w
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 03:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab0FLBW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 21:22:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60722 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab0FLBWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 21:22:55 -0400
Received: by fxm8 with SMTP id 8so1206485fxm.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=an3EVECGtinQ/yIK6RfgSEmtwi1O5uQ8stun/VSUuG8=;
        b=W4qgXgESxBBIeOw7/On4adrjpOkUNlp3514IOImxxVfzQ9rh7dyppsJ1zZ++6bw5gz
         boIOM3hj2sXoiYWCX4JctQ3XOYJ05fLD5FZgYFRjLfOwK0TU/aYvh5jDc4tCuv/hM7ee
         +hrASkWK1Fof/bhR2KZ8fT5lFs0TnR9LFBocs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XxnTM4c0iP9yvujoEAkIGyByzBg1TgA9gW8IHbszfE6FAYZn0WFqlZumgg1+Gj0xNt
         b7SqCxczQ5Pq9Mo/eJ+YXitNLzkbzSqb7RB2yaDlPhulI1lyYKPPNFmSfouJY5ncNST5
         abV3JEfYd6gefoCQp8TsgEJWZCbLwHpLE/acQ=
Received: by 10.223.92.136 with SMTP id r8mr2629093fam.40.1276305773763; Fri, 
	11 Jun 2010 18:22:53 -0700 (PDT)
Received: by 10.223.114.10 with HTTP; Fri, 11 Jun 2010 18:22:53 -0700 (PDT)
In-Reply-To: <201006120301.37931.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148981>

On Sat, Jun 12, 2010 at 01:01, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 8 June 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I haven't contributed to Gitweb, nor do I have to deal with it. But
>> I've followed this series and reviewed most of the Perl code in
>> Git. Take these with a grain of salt.
>>
>> It would be very useful for the future of our Perl code if we had a
>> dual-life system in Git. I.e. a cpan/ directory where we could drop
>> CPAN modules that should be shipped with Git.
>
> The standard name for such directory is 'inc/', I think.

Perl itself uses cpan/, but Module::Install started the inc/. What we
call it really doesn't matter though.

> There is for example 'inc::latest' module (unfortunately in core only
> since latest Perl, i.e. version 5.12), which uses modules bundled in
> 'inc/' if they are newer than installed ones. =C2=A0It is in Module-B=
uild
> distribution.

Interesting. I hadn't looked at it.

> BTW. it's a pity that PAR (Perl Archiving Toolkit, par.perl.org)
> is not in core...

It has a bunch of off edge cases unlike its namesake .jar, but in any
case using it wouldn't help us.

>> We already do this in a less sophisticated way for Error.pm, is ther=
e
>> any reason not to expand it to install more CPAN modules if they
>> aren't present on the system? That'd allow us to use them, but still
>> only depend on vanilla Perl.
>
> Sidenote about Error.pm: from what I understand modern consensus is
> that Error.pm was a failed approach, and currently recommended way to
> use exceptions in Perl is via block form of eval, e.g. Try::Tiny or
> TryCatch (this requires Moose and PPI), and not Error.

Yeah, but it was just an example of how we can (and should) bundle
modules with Git.

>> Then we could just use e.g. Config::General (~3k lines of code)
>> instead of writing our own config system. There are probably lots of
>> wheels that we're inventing (and are going to invent) that have been
>> done better elsewhere, with more testing.
>
> The problem with _optional_ Config::General config is that people
> would have incompatibile gitweb config files, some using Config::Gene=
ral
> syntax, some current configuration in Perl.

Isn't the current patch series the first attempt at config file
support? I.e. it's always been editing the source until now.

In any case, proper non-executable config file support could easily be
made optional, hopefully with a transition the non-executable one.

>> Unlike Python or Java, Perl's policy is for core modules is to only
>> include those required to better bootstrap the CPAN toolchain. So if
>> we continue sticking to core Perl our code is only going to drift
>> further away from Perl best practices.
>
> Right.
>
> Still, we don't want to require having half of CPAN in 'inc/' to
> install gitweb. =C2=A0Perhaps "no non-core dependencies" is too stric=
t,
> and should be replaced by "minimal non-core depencencies".

Obviously we'd pick modules to include carefully.
