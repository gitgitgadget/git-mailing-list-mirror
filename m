From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git User's Survey 2008
Date: Fri, 5 Sep 2008 10:45:43 -0400
Message-ID: <20080905144543.GA25022@coredump.intra.peff.net>
References: <200808312329.17312.jnareb@gmail.com> <48BB9742.3000109@gmail.com> <200809011034.48342.jnareb@gmail.com> <48BE8109.9030701@jaeger.mine.nu> <1a6be5fa0809030546n28e2a1besdc4435e874f2f0f9@mail.gmail.com> <94a0d4530809030949v7c8c6ec4uc60bc873a40637d0@mail.gmail.com> <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:47:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbcaQ-0002BL-9x
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbYIEOps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbYIEOps
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:45:48 -0400
Received: from peff.net ([208.65.91.99]:3524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbYIEOps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 10:45:48 -0400
Received: (qmail 18153 invoked by uid 111); 5 Sep 2008 14:45:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 05 Sep 2008 10:45:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Sep 2008 10:45:43 -0400
Content-Disposition: inline
In-Reply-To: <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95019>

On Fri, Sep 05, 2008 at 04:46:02PM +0300, Marc-Andr=C3=A9 Lureau wrote:

> I cannot find yet a good workflow with either mutt, gmail or evolutio=
n
> over imap.
>=20
> If somebody could explain how they handle the git send-mail patches
> they recieve, I would be thankful. How do you create .mbox files? Wha=
t
> is your workflow when you deal with mails?

When I receive patches via mutt, I usually apply them with this:

  macro index,pager A '<pipe-message>git<space>am<enter>'

which will apply in your current directory. For my git folder, I use a
hook to always apply to my git repo:

  folder-hook git macro index,pager A
  '<pipe-message>cd<space>$HOME/compile/git<space>&&<space>git<space>am=
<enter>'

If there are several patches in a series, I may pull them into an mbox
and apply separately:

  [in mutt]
  T pattern [or tag message individually, or Esc-T to tag thread]
  ;C ~/name-of-patch-topic

  [in another terminal]
  cd /path/to/repo
  git am ~/name-of-patch-topic

To send one or two patches, I create an mbox and then use mutt to send:

  git format-patch -s --stdout "$@" >.mbox
  mutt -f .mbox
  rm -f .mbox

and in my muttrc:

  macro index,pager b ":set edit_headers=3Dyes<enter><resend-message>:s=
et edit_headers=3Dno<enter>"

Hope that helps,

-Peff
