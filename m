From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 11:14:39 +0200
Message-ID: <200707191114.39553.jnareb@gmail.com>
References: <3bbc18d20707171103q262eaa8amb319ca9f835dbf67@mail.gmail.com> <1184699486.9831.7.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Matt McCutchen <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 14:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBVPd-0002iq-A5
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 14:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757995AbXGSMrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Jul 2007 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758378AbXGSMrS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 08:47:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:61741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874AbXGSMrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 08:47:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so398111ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 05:47:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cIHhWqOKp35Rdao83ki+kw2rk8oweSJ7LU1zclpootzZP0Ar49kAqt/hKRkpyo7WHeQhB8GNNQcNHzK/M804io4ZBou0nt7t7M8uDa5DSua4oC5TOPR26LWzP9jSH00A3ywscKEvsK2o0J6gdjP+osGsGYpYLr2z+GpKetXxkn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G7bos1e+Tj7l2lT8xStvGBgZf4KDPVhfeUJ7uVTW0SDb3r2mrVLBPE5nEHnxZdN7pvmliJ3lWGOdtyC3Arwn5ONTDQMaEQOBxycAT327ZcASvM1oQsnet/+ldpUjI8V4DPh7dvwcPXUfXx9zOuLwTa2P5RYYdSn7Pjlp2jCrnOE=
Received: by 10.86.28.5 with SMTP id b5mr1913767fgb.1184849236719;
        Thu, 19 Jul 2007 05:47:16 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id m1sm4372321fke.2007.07.19.05.47.15
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 05:47:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1184699486.9831.7.camel@mattlaptop2>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52988>

On Tue, 17 July 2007, Matt McCutchen wrote:

> =A0sub feature_snapshot {
> -=A0=A0=A0=A0=A0=A0=A0my ($ctype, $suffix, $command) =3D @_;
> +=A0=A0=A0=A0=A0=A0=A0my (@fmts) =3D @_;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0my ($val) =3D git_get_project_config('snapsho=
t');
> =A0
> -=A0=A0=A0=A0=A0=A0=A0if ($val eq 'gzip') {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ('x-gzip', 'gz',=
 'gzip');
> -=A0=A0=A0=A0=A0=A0=A0} elsif ($val eq 'bzip2') {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ('x-bzip2', 'bz2=
', 'bzip2');
> -=A0=A0=A0=A0=A0=A0=A0} elsif ($val eq 'zip') {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ('x-zip', 'zip',=
 '');
> -=A0=A0=A0=A0=A0=A0=A0} elsif ($val eq 'none') {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ();
> +=A0=A0=A0=A0=A0=A0=A0if ($val) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0@fmts =3D ($val eq 'non=
e' ? () : split /,/, $val);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0@fmts =3D map $known_sn=
apshot_format_aliases{$_} || $_, @fmts;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0@fmts =3D grep exists $=
known_snapshot_formats{$_}, @fmts;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0
> -=A0=A0=A0=A0=A0=A0=A0return ($ctype, $suffix, $command);
> -}

I would use more permissive (be forbidding in what you accept) regexp
to split gitweb.snapshot value into list of snapshot formats, so one
could use "tgz, zip", or perhaps even "tgz zip", and not only "tgz,zip"
(no whitespace possible). For example

+               @fmts =3D ($val eq 'none' ? () : split(/\s*,\s*/, $val)=
);

or even

+               @fmts =3D ($val eq 'none' ? () : split(/\s*[,\s]\s*/, $=
val));

to allow "tgz zip".


Your regexp for "tgz, zip" would get 'tgz', ' zip' (with leading space)
as snapshot formats to use.

--=20
Jakub Narebski
Poland
