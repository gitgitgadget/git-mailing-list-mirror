From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Sun, 18 Jun 2006 16:44:47 +0200
Message-ID: <20060618144447.GB2446@diana.vm.bytemark.co.uk>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> <8aa486160606150426q19b0a661s@mail.gmail.com> <7vk67gbbe9.fsf@assigned-by-dhcp.cox.net> <20060618112404.GA2446@diana.vm.bytemark.co.uk> <7vzmga1y9k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi <sbejar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 16:45:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FryWN-0000R3-OL
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 16:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWFROoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Jun 2006 10:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFROoy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 10:44:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:22798 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932190AbWFROox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 10:44:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FryW7-0001EA-00; Sun, 18 Jun 2006 15:44:47 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmga1y9k.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22082>

On 2006-06-18 04:47:19 -0700, Junio C Hamano wrote:

> Thanks for the explanation.
>
> If that's the case, I think it makes the original problem Santi
> brought up a non-issue. In this sequence:
>
>         make prefix=3D/home/santi/usr
>         make install prefix=3D/home/santi/usr/stow/git
>         cd /home/santi/usr/stow/
>         stow -v git
>
> the building phase could have used the same prefix as the install
> phase uses, and git can find its subprograms in gitexecdir (=3D
> ~/usr/stow/git/bin) just fine. It probably is even slightly more
> efficient since it does not have to go through the symlink stow
> installs.

Yes, exactly. I've always built git like this:

  $ make prefix=3D/usr/local/stow/git
  $ sudo make prefix=3D/usr/local/stow/git install
  $ cd /usr/local/stow
  $ sudo stow git

It works for all other programs I've tried too (most of which only
require me to specify the prefix once, with ./configure --prefix=3D...)=
=2E
The programs never need to know about the symlinks; they're only there
for when other programs need to access them (via PATH, etc.).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
