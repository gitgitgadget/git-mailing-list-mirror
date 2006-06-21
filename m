From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] send-email: Use setlocale in addition to $ENV{LC_ALL} to set locale
Date: Wed, 21 Jun 2006 13:18:40 +0200
Organization: At home
Message-ID: <e7b9u7$974$1@sea.gmane.org>
References: <7v3bdy5178.fsf@assigned-by-dhcp.cox.net> <11508811631669-git-send-email-jnareb@gmail.com> <e7b796$lj$1@sea.gmane.org> <20060621104941.GB15748@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jun 21 13:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0jj-0003Ka-Ts
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFULTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 21 Jun 2006 07:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWFULTE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:19:04 -0400
Received: from main.gmane.org ([80.91.229.2]:65454 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932077AbWFULTB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 07:19:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft0jU-0003Hh-Vk
	for git@vger.kernel.org; Wed, 21 Jun 2006 13:18:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 13:18:52 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 13:18:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22263>

Eric Wong wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
>>=20
>>> $ENV{LC_ALL} =3D 'C'; does not change locale used by strftime.
>>> Use setlocale( &LC_ALL, 'C' ); instead.

> I'm responsible for the $ENV{LC_ALL} =3D 'C' setting but I never actu=
ally
> tested how things would work with a non-English locale (not being
> well-versed in these things myself, either).

It looks like I have broken locale badly somewhat, as I yesterday
sent patches successfully without the patch. I suspect that sendmail
removes incorrect Date: header and adds it's own... unless Date:
header contains characters outside US-ASCII.

It means that sendmail can deal with
  Date: wto, 20 cze 2006 13:14:11 +0200
instead of correct
  Date: Tue, 20 Jun 2006 13:14:11 +0200

but cannot deal with (iso-8859-2 encoded I think)
  Date: =C2=B6ro, 21 cze 2006 09:48:02 +0200
from git-send-email.perl without patch, instead of correct
  Date: Wed, 21 Jun 2006 11:25:52 +0200
with the patch.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
