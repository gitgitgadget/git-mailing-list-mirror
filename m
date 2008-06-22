From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Sun, 22 Jun 2008 17:10:26 +0200
Message-ID: <20080622151026.GA4468@diana.vm.bytemark.co.uk>
References: <20080619214023.27794.97039.stgit@localhost.localdomain> <20080619214201.27794.18891.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 17:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KARE6-00009r-9Z
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 17:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYFVPKj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYFVPKj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 11:10:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4604 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbYFVPKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 11:10:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KARD0-0001E9-00; Sun, 22 Jun 2008 16:10:26 +0100
Content-Disposition: inline
In-Reply-To: <20080619214201.27794.18891.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85783>

On 2008-06-19 22:42:01 +0100, Catalin Marinas wrote:

> If the stgit.smtpserver configuration option does not have a
> host:port format, it is assumed to be an external tool. For example,
> to use sendmail just set this variable to "/usr/sbin/sendmail -t -i"
> (see the examples/gitconfig file).

Some comments below, but it looks good.

> +def __send_message_sendmail(sendmail, msg):
> +    """Send the message using the sendmail command.
> +    """
> +    cmd =3D sendmail.split()
> +    Run(*cmd).raw_input(msg).discard_output()

You could've written this without the "cmd" variable, but I understand
why you didn't. The * operator (or whatever it is) isn't pretty. I
sort of regret not making Run take a list argument instead, frankly.

>  class GitConfig:
>      __defaults=3D{
>          'stgit.autoresolved':	'no',
> -        'stgit.smtpserver':	'localhost:25',
> +        'stgit.smtpserver':	'/usr/sbin/sendmail -t -i',

Hmm. I think it's actually more common to have a misconfigured (or
insufficiently configured) sendmail program than a misconfigured mail
daemon listening to port 25, so I'd argue that the default shouldn't
be changed. But it's not that important.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
