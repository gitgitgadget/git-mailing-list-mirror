From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-cvsserver: pserver-auth-script
Date: Fri, 2 Jul 2010 21:34:11 +0000
Message-ID: <AANLkTimts_MlrWGKaiu3frk7vOnK9B70RE7It2Wml3on@mail.gmail.com>
References: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu>
	<AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
	<m31vbloa6m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 23:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUnsJ-0003Js-Dh
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 23:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab0GBVeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 17:34:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38656 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab0GBVeN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 17:34:13 -0400
Received: by iwn7 with SMTP id 7so3674749iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cgPeois5gRZvgL8L7JamJKRfQrc0lRHfvYgc8YF7iAc=;
        b=NI8Toep4irKmLcGPj4MfKAm+stPaxr7aFQOhtSFg2NdYJRA+LwVNiLbkugKdvf73W6
         jLDFYppAgK2sj2FjMsE3WtcfcczIlxT70a7+BYoep0kzOCPv2wfZQDUW84NB7+fTfmUR
         53inhqSyVACAsOW4jxwh5AO6y/d/qPPwN5hdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dQHzszf+Acmf98IvDVmYVPhbLzftdv6pg5YR25px1XeAcORYrq0CDy4HZw0N9ahe3M
         Z8iOD2J0cjOHcx0n6MGvSdmtZ+8f247RQRfXV3TmOlUWABoeN4LsbXg/rWryhtYXS5Rc
         wO1trJdlu9QGiDPi/O7qYkn2HMYg65/KB2ltQ=
Received: by 10.231.35.199 with SMTP id q7mr1405340ibd.47.1278106451577; Fri, 
	02 Jul 2010 14:34:11 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 2 Jul 2010 14:34:11 -0700 (PDT)
In-Reply-To: <m31vbloa6m.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150169>

On Fri, Jul 2, 2010 at 21:31, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> On Fri, Jul 2, 2010 at 07:54, L=C3=A1szl=C3=B3 =C3=81SHIN <laszlo.as=
hin@neti.hu> wrote:
>>
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open SCRIPTIN, '|' . $a=
uthscript or die $!;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print SCRIPTIN $user . =
"\n";
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print SCRIPTIN descramb=
le($password) . "\n";
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close SCRIPTIN;
>>
>> Nit: Nice use of three-arg open, but you should use lexical
>> filehandles instead. I.e.:
>>
>> =C2=A0 =C2=A0 open my $script, '|' . $authscript or die $!;
>> =C2=A0 =C2=A0 ...
>
> This is two-argument open, not three-argument magic open. =C2=A0There=
 is
> string concatenation operator '.' there, not a comma ',' delimiting
> arguments.

Well spotted, I misread that.

> It should be
>
> =C2=A0 open my $script_fd, '|-', $authscript
> =C2=A0 =C2=A0 =C2=A0 =C2=A0or die "Couldn't open authentication scrip=
t '$authscript': $!";
>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (not exists $cfg->{g=
itcvs}->{authdb}) {
>
> Why not elsif?
>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print "E =
the repo config file needs a [gitcvs] section with an 'authdb' paramete=
r set to the filename of the authentication database\n";
>
> Overly long line. =C2=A0Perhaps it would be better to split it into
> concatenated parts.
>
>
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $auth_ok;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open my $passwd, "<", $=
authdb or die $!;
>
> And here you use three-argument form of (ordinary) open.

This and the code below were already part of the code. But the patch
would be better if it didn't move so much code around so that this
would be obvious.

>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (<$passwd>) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m{^\Q=
$user\E:(.*)}) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (crypt($user, descramble($password)) eq $1) {
>
> Why nested if, and not short-circuit &&?
>
> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if (/^\Q$user\E:(.*)/ &&
> =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0crypt($user, descramble($password)) eq $1) {
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
