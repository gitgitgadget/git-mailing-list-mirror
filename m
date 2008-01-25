From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: managing signed-off-by lines
Date: Fri, 25 Jan 2008 15:30:26 +0100
Message-ID: <20080125143026.GA10132@diana.vm.bytemark.co.uk>
References: <9e4733910801241227n659a5b34x7f77f25101aa225f@mail.gmail.com> <20080125083853.GA5804@diana.vm.bytemark.co.uk> <9e4733910801250534s7ab11b15uff3c782165a8e2ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 15:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIPaD-0000ZQ-Fm
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 15:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYAYOad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 09:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbYAYOad
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 09:30:33 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1635 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYAYOad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 09:30:33 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIPZa-0002f5-00; Fri, 25 Jan 2008 14:30:26 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801250534s7ab11b15uff3c782165a8e2ea@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71708>

On 2008-01-25 08:34:53 -0500, Jon Smirl wrote:

> On 1/25/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > What command are you using to export patches?
>
> I am using "stg export" from one branch and then "stg import -s" on
> another. After I import the patch and do 'stg edit' on it, it has
> the signed-off-by line in it. When it is export from that branch the
> signed-off-by get added again.
>
> You don't want to strip the signed-off-by lines on import, they may
> be from other people. I would think that on export you could look
> and see if my signed-off-by line is already on the patch before
> adding it again.

I haven't set up my templates to add sign-offs on export; instead, I
give --sign to "stg import". This always does the right thing:

  1. It's smart enough to notice if my sign-off is already there, and
     don't add another copy.

  2. My sign-off is propagated even if the patches are transferred by
     pulling instead of by email or "stg export".

=46or patches that I write myself (so that they are never "stg
import"ed), I add the sign-off manually in the commit message, with
the aid of this elisp snippet:

  (defun sign-off ()
    "Insert sign-off line."
    (interactive)
    (git-append-sign-off (git-get-committer-name) (git-get-committer-em=
ail))))

Adding the sign-off conditionally in "stg mail" and "stg export", as
you suggest, could of course be done. But that would have to be
command line options, since the template system can't really express
that kind of transformation.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
