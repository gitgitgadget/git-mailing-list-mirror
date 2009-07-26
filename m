From: demerphq <demerphq@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 12:23:33 +0200
Message-ID: <9b18b3110907260323h575a0b06rcf058c8b3370b742@mail.gmail.com>
References: <20090723195548.GA28494@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
	 <20090724234648.GA4616@Pilar.aei.mpg.de>
	 <20090725004122.GA28477@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
	 <20090725215739.d074e947.tihirvon@gmail.com>
	 <20090725203130.GB1640@glandium.org>
	 <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
	 <20090726075455.GA22525@glandium.org>
	 <alpine.DEB.1.00.0907261214220.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV0xA-0008WG-LQ
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZGZKXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jul 2009 06:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZGZKXf
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:23:35 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:34074 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbZGZKXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 06:23:34 -0400
Received: by an-out-0708.google.com with SMTP id d40so3564653and.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2009 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1d+b39uHtsr84zpQAlgC+6cIW9djEITXiB+eWFksCO0=;
        b=ZAtVnHhlo/MrDFx3rS9NEKCtJz5oOeVcrHbr+KdHKKIPbWXaLYukGJ19GE/pcgvGQm
         PlO8XgTIb5ITM/3l4knDH0gqBO2/1Enkff/96SfxKsnJVwaj5Yn+8PronbwZIcCbiGG7
         M6inNyuwplujbJTKu+jhvUVrvt/l3ShSJxxVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ke1yG2em+NowhkomHenp6+OqM3TdYu9J4UCjRWhfwJ5tTU8RDk+8vevjZwAKrZoUlg
         pcr05NeV1evXLZnSN1wqowhglzFUTNKKc3NFG9k5YFSKwExkO8bojyjlUvRcdk94eRQy
         s68VUbtY1GC05/PWMIbvt/JyuixP8/gcvnuec=
Received: by 10.231.18.69 with SMTP id v5mr1789960iba.26.1248603813944; Sun, 
	26 Jul 2009 03:23:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907261214220.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124118>

2009/7/26 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Sun, 26 Jul 2009, Mike Hommey wrote:
>
>> On Sat, Jul 25, 2009 at 02:02:19PM -0700, Linus Torvalds wrote:
>> >
>> >
>> > On Sat, 25 Jul 2009, Mike Hommey wrote:
>> >
>> > > On Sat, Jul 25, 2009 at 09:57:39PM +0300, Timo Hirvonen wrote:
>> > > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > > >
>> > > > > So curl really must die. It may not matter for the expensive=
 operations,
>> > > > > but a lot of scripting is about running all those "cheap" th=
ings that just
>> > > > > add up over time.
>> > > >
>> > > > SELinux is the problem, not curl.
>> > >
>> > > I think it's NSS, the problem, not SELinux. Linus's libcurl is b=
uilt
>> > > against NSS, which is the default on Fedora.
>> >
>> > Well, it kind of doesn't matter. The fact is, libcurl is a bloated
>> > monster, and adds zero to 99% of what git people do.
>>
>> Especially consideting the http transport fails to be useful in vari=
ous
>> scenarios.
>
> I beg your pardon? =A0Maybe "s/useful/desirable/"?
>
> In many scenarios, http transport is the _last resort_ against overze=
alous
> administrators. =A0The fact that you might be lucky enough not to nee=
d that
> resort is a blessing, and does not give you the right to ridicule tho=
se
> who are unfortunate enough not to share your good luck.

I think he meant that it is buggy and does not work correctly in
various scenarios.

Eg: Last I checked it couldn't handle repos where the main branch
wasn''t called master, and I've seen other messages that make me think
it doesn't work correctly on edge cases.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
