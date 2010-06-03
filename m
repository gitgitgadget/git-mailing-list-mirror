From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 15:54:34 +0000
Message-ID: <AANLkTikUmFA658jzd27cu1NmjJsV8T9Hkrd7z2WNY3R7@mail.gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
	<20100603152030.GD20775@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	jnareb@gmail.com, chriscool@tuxfamily.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:54:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCkj-00040q-OI
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab0FCPyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 11:54:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52572 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab0FCPyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 11:54:35 -0400
Received: by gye5 with SMTP id 5so205962gye.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SBMOWh2x3yuTtSREASbfACjFOqY6vR0+vXnsAMgwWtA=;
        b=Io5RPTw4eX6f9ZH6fiXs8cwKzEKLeKjyKSDbTbheqlX+Z/iHt0u7H+Ta1Spbd5mNfy
         AiujLA242vTmjBdMEuA3QGuQWTNf2SxwlL4/i9p8csthMdwnSYeJdWsHLwJe/Js/6pHT
         k5A3BJ1GQrereMaB6hF+ygMUmWQhPMPkMkT/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yDFWWpGNm6aEJjaC5OhD1yJJ69yfWC8/3owntR0stiIEV3UDC0EpjxvPCTJj04aywm
         EYJTelBRH+A4FcwSSkCOn1CVL/DiZJ4I8q2kxahsi1etbseAY2RlNm1P/JfBvkdRYBE2
         iDOfcqFSP/Hy+hXDdWAcWQY5EOG+gtju3rNTA=
Received: by 10.42.7.142 with SMTP id e14mr1419615ice.1.1275580474846; Thu, 03 
	Jun 2010 08:54:34 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 3 Jun 2010 08:54:34 -0700 (PDT)
In-Reply-To: <20100603152030.GD20775@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148338>

On Thu, Jun 3, 2010 at 15:20, Petr Baudis <pasky@suse.cz> wrote:
> On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote:

>> -our $t0;
>> -if (eval { require Time::HiRes; 1; }) {
>> - =C2=A0 =C2=A0 $t0 =3D [Time::HiRes::gettimeofday()];
>
> Why is this moved to Gitweb::Config? Shouldn't this be rather part of
> Gitweb::Request?

>> +our @ISA =3D qw(Exporter);

This is also re-arranging deck chairs on the Titanic, but 'use base
qw(Exporter)' is nicer.

>> +# __DIR__ is taken from Dir::Self __DIR__ fragment
>> +sub __DIR__ () {
>> + =C2=A0 =C2=A0 File::Spec->rel2abs(join '', (File::Spec->splitpath(=
__FILE__))[0, 1]);
>> =C2=A0}
>> -our $number_of_git_cmds =3D 0;
>> +use lib __DIR__ . "/lib";
>
> Wouldn't it be more elegant to use FindBin? I'm just not sure how lon=
g
> is it part of core Perl.

No, those don't do the same thing as discussed in previous
reviews. FindBin finds the invoked binary, Dir::Self finds the the
current file.
