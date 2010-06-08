From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Tue, 8 Jun 2010 13:50:23 +0000
Message-ID: <AANLkTimq-46ghYT6TqXn1AB0NQIobcDaufsSJ5AEFE5z@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
	<201006081446.22587.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 15:50:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzCI-0003mn-GH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab0FHNuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:50:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33582 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab0FHNuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 09:50:24 -0400
Received: by iwn37 with SMTP id 37so4618976iwn.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l7rJCc2EHOQYOXK0ptH1zjy7vVAadTiEqxtBfSGxsxM=;
        b=kEs70r+7dHfUtKJFOrzf9Xigqsb0M04iw5aODwCHo5kUv4aER/ICm25GQC9Zk5kKPX
         fWF2mBPeMEwiXkdIh1muWoE1Sy0s5QlXuliU7vrffo2cno5EonnznYMjoTPkPgO59ROR
         8lHWwWfuMPoMjNzykKi43dIuD3wzuNr1QEaFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kVlxnKtC69NJa5oWZJD8C6RYytsIHcTZg4elsdHyyLlR/pCHPTjYdhKComq1tDEOni
         V47WdR5h3xPfnViBY7CQoCuv0LUaApfO+sw1vUkrH1a5xkbq/6TJk5xeJlQX1+1vT3T2
         2+abcAzm9esuoFXqIjmCw6JdIbPx8lbtbMaCc=
Received: by 10.231.114.144 with SMTP id e16mr6112734ibq.188.1276005023634; 
	Tue, 08 Jun 2010 06:50:23 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 8 Jun 2010 06:50:23 -0700 (PDT)
In-Reply-To: <201006081446.22587.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148674>

2010/6/8 Jakub Narebski <jnareb@gmail.com>:
> A few generic comments about this whole series.
> [...]
> Third, and I think most important, is that the whole splitting gitweb=
 into
> modules series seems to alck direction, some underlying architecture
> design. =C2=A0For example Gitweb::HTML, Gitweb::HTML::Link, Gitweb::H=
TML::String
> seems to me too detailed, too fine-grained modules.
>
> It was not visible at first, because Gitweb::Config, Gitweb::Request =
and to
> a bit lesser extent Gitweb::Git fell out naturally. =C2=A0But should =
there be
> for example Gitweb::Escape module, or should its functionality be a p=
art of
> Gitweb::Util? =C2=A0Those issues needs to be addressed. =C2=A0Perhaps=
 they were
> discussed with this GSoC project mentors (via IRC, private email, IM)=
, but
> we don't know what is the intended architecture design of gitweb.
>
> Should we try for Model-Viewer-Controller pattern without backing MVC
> (micro)framework? =C2=A0(One of design decisions for gitweb was have =
it working
> out of the box if Perl and git are installed, without requiring to in=
stall
> extra modules; but now we can install extra Perl modules e.g. from CP=
AN
> under lib/...). =C2=A0How should we organize gitweb code into package=
s
> (modules)?
>
> Perhaps having gitweb.perl, Gitweb::Git, Gitweb::Config, Gitweb::Requ=
est,
> Gitweb::Util and Gitweb would be enough? =C2=A0Should it be Gitweb::H=
TML or
> Gitweb::View? =C2=A0Etc., etc.,...

I haven't contributed to Gitweb, nor do I have to deal with it. But
I've followed this series and reviewed most of the Perl code in
Git. Take these with a grain of salt.

It would be very useful for the future of our Perl code if we had a
dual-life system in Git. I.e. a cpan/ directory where we could drop
CPAN modules that should be shipped with Git.

We already do this in a less sophisticated way for Error.pm, is there
any reason not to expand it to install more CPAN modules if they
aren't present on the system? That'd allow us to use them, but still
only depend on vanilla Perl.

Then we could just use e.g. Config::General (~3k lines of code)
instead of writing our own config system. There are probably lots of
wheels that we're inventing (and are going to invent) that have been
done better elsewhere, with more testing.

Unlike Python or Java, Perl's policy is for core modules is to only
include those required to better bootstrap the CPAN toolchain. So if
we continue sticking to core Perl our code is only going to drift
further away from Perl best practices.
