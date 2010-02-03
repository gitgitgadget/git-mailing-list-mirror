From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 13:57:55 -0500
Message-ID: <32541b131002031057q866d3q95d0e80a0adf6c52@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com> 
	<alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de> <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com> 
	<40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com> 
	<76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com> 
	<vpqeil2kc6b.fsf@bauges.imag.fr> <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com> 
	<1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com> <76c5b8581002031049t5558a700qe2e05bb70d175305@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wincent Colaiuta <win@wincent.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NckQi-0006pI-W4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473Ab0BCS6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:58:18 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:53196 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757239Ab0BCS6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:58:16 -0500
Received: by ywh36 with SMTP id 36so1577432ywh.15
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 10:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=WnKvrgOXnUnr9jFIFOQIPrautBR4Sor72k62ilwN6Ls=;
        b=PI6NBmR8zj5G+ybFEzCUmeuMyY+u2/4rC2YS5syRyfwhvDfrIfeGMq18JJD4G2oGNE
         orR5gdSBBRHKDteDSO66zEoc0rKaRv8q+XLPkD31+GQlPUV30LCCe7lGkehndmJ2AOnr
         mtsUQxG364AT+Mbi0IsuoGz2fJ60k/aw0E4NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OsL0rwi8hov3w6i6bi9mC9JZhsILWURKGf62uyvXudraULra9y0GMfG0xwXQLKra6S
         SPRgjVUeA0/7WJys7GSCn39Z0DmbMntAW02LJa5jHT3uWWL+d9OxBGm4h8P3hI/aIWxi
         ngs7IHy9U8Khd3vcQaOsF4nrxLxncgFLcc28o=
Received: by 10.150.170.9 with SMTP id s9mr411691ybe.198.1265223495136; Wed, 
	03 Feb 2010 10:58:15 -0800 (PST)
In-Reply-To: <76c5b8581002031049t5558a700qe2e05bb70d175305@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138863>

On Wed, Feb 3, 2010 at 1:49 PM, Eugene Sajine <euguess@gmail.com> wrote:
> OK. I admit I got confused with the fact that some editors (vi,
> kwrite, gedit - i just tested them to be 100% sure) do allow you to
> hit save right after the file was opened and the timestamp will be
> changed, while emacs or open office writer or some others do not, if
> no changes has been made. Therefore there is no way to actually change
> the timestamp on the file from editors like emacs without actually
> changing something.

Of course, in such editors you could just hit "space; backspace" and
then save.  Sounds annoying?  Well, so does deleting all the lines in
the commit message just to make it *not* amend.

To reiterate what I said earlier: the mtime idea isn't even
automatically a bad one.  It's about as good as what currently exists,
and the resulting rule (file content or mtime must be modified) is
just as consistent as the current rule (file must be nonempty).  It's
also arguably easier for new users to understand.

But you can't just blindly change the system to always work in a
different way.  People depend on the current behaviour.  Jeff King's
script is a pretty cute solution that lets you have it your way with
no changes to git, though.

Of course, this does open up the question of how to do any global UI
design at all if a decision made once gets locked in forever.  The
reason git is hard for new users is that its UI is crazy and
confusing, but a major reason it keeps gaining in popularity is that
once you learn git, you stick with it, because you don't have to
relearn it with every new version.

Have fun,

Avery
