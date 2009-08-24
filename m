From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis-lite
Date: Mon, 24 Aug 2009 20:05:19 +0530
Message-ID: <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
	 <m3ab1pmk1c.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfadu-0003VL-BO
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZHXOfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 10:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbZHXOfT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:35:19 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:40339 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZHXOfS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 10:35:18 -0400
Received: by iwn42 with SMTP id 42so959715iwn.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bhECssQxPbFIirjf9dWaumEg9lLuI66I6e5wpJz/3U0=;
        b=vTTBjezBasPMrReHPSKxWzwCQJ+iQCQVchCRBMxMYJ+ZAw36uMTLNinAEjZUpcim+Y
         +6ixx+FCrsm+o4PXGO/u5/UMgxpIPCsSm8L/9WSuNIUZBsPYWCSOa7uYseUXRlfKXNGP
         zupNwXcb9Nb7V87nZI2PMgex2EdLNHuFRdctQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hm4WwMfiMUNHri46MWajP2lznWnjHuxeTs7ycKJjd18NE/wxchWA07C0XUakkdovRA
         C0+i/w5dvQwKjM4+Ob8gJgCZ6XMIm81lHbG2XQILa16WWD+ejgUrzLgvAkE1/uF4ypOB
         UcQ2bRsxwN/5mnN9rUq5C5yxUQCRpfsLP7Duw=
Received: by 10.231.32.138 with SMTP id c10mr2204735ibd.28.1251124519662; Mon, 
	24 Aug 2009 07:35:19 -0700 (PDT)
In-Reply-To: <m3ab1pmk1c.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126932>

On Mon, Aug 24, 2009 at 6:43 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:

> Could you add information about this tool (perhaps after confirmation
> / deciding on project name[1]) to Git Wiki page
> =A0http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
> somewhere below Gitosis? =A0Please do not forget to include that it i=
s
> written in Perl; see other entries for example.

Will do; though I'll probably wait until at least one person
other than me has used it :)

> You wrote in project's README.markdown that you were inspired by
> Gitosis (which requires Python and python-setuptools) and
> Documentation/howto/update-hook-example.txt (which uses bash).
> Why not contrib/hooks/update-paranoid (which is written in Perl)?

Hmmm several reasons.  To start with, it appears to me that
update-paranoid assumes each user has his own ACL file, and
I'm going the other way -- you'll notice I have exactly one
file as a single ACL source for many *projects*, leave alone
users.

Secondly, I want to stick to the gitosis philosophy -- it
has served very well, and I'm not sure how "in use"
update-paranoid is.

Thirdly, I'm not comfortable having a hook be so complex.
The whole thing is 10 lines shorter than all my code put
together :)

And finally, it's far too complex for me, leave alone some
of my users.  I count 6 pipe opens in there, and the ACLs
are read by git cat-file or something :) I'll be honest: I
came away feeling very stupid after trying to read and
understand that program.  It was... humbling :(

> Using Perl code for configuration is simple and fast, but not very
> secure. =A0Why not use git config format (via "git config -l -z" like=
 in

Not secure in what sense?  Only the "git admin" (whoever
owns the account in which gitosis-lite is running) will be
able to generate it, and only scripts that run with his
authority (by way of hooks in repos he owns) can run it.

It cannot do what he did not intend to do, and what he wants
to do he can do anyway, whether it's JSON or perl.

Except for umasking the file, I don't see anything I missed.
Could you help me understand?

> gitweb), or YAML or JSON (or Storable)? =A0Well, YAML might be overki=
ll.

One of the objectives is to work *as is* on any Unix system
that managed to install git (which implies Perl).  So, no
JSON or YAML.  Storable would be fine (I think it's also
part of core perl) so if I find a compelling reason I don't
mind switching to that.

All I really have is a nested hash to be saved and restored
-- nothing more complex, no objects, no blessed refs, etc.

> BTW. if you blog about gitosis-lite (http://sitaramc.blogspot.com/)
> it could be picked up by Perl Iron Man Blogging challenge, and you
> could get wider review.

Will do; thanks.  I did not know my blog got picked up by
anything; till date it has never come up on a google search
or a blog search anywhere, and it's more of a rant-box +
annotated bookmarking service for myself :)

> [1]: gitosis-lite doesn't look like CPAN-y name. =A0Git::Admin perlha=
ps?

Too presumptuous for someone like me -- makes it sound like
the "one true way to Admin git" :)

Thank you very much for your comments!

--=20
Sitaram
