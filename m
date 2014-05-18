From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 17:48:06 -0500
Message-ID: <537938a680272_7b90a792fc4a@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <5377994fe8dec_7a27d4b30438@nysa.notmuch>
 <vpqk39jous5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 00:59:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmA33-0003c6-Hn
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbaERW7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:59:13 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:65183 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbaERW7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:59:13 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so5374770obc.12
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=s0PiFyX4Z1hnBAXW+p3aAELjjDA5suZpW2IQS/JoGWE=;
        b=naF7Qae89Qj2Mdy4bbGnLwjLgyAz/yxkMojEIKFlO2CHzITzLop/8qBRAh5sgNeVJl
         5kqbfrJaKjB5Jv8JQcMAXS84SbwgcSa3r6ccQg3H5rZOb6tUgJEBdd48Wwa/toJ+z9NS
         EMWZS9DU83OeOo8qMd2zfOWvBTUkONaJugsOPr4o6szThd4sYqhURPK1TSCG9Fv2VJcU
         Cz5BK8wfEtZUopJqYX5kzpBRFwdf50mf2dsssMAefCp0UyhX3yOxQk68JwC3pNFJOFsA
         y3Ddc9GzAyD4r+PYYmWo1eadSeNRhmlCp+X3EPyTSGdEJneD2lnwDsvKYag9La+O/5rH
         D1qQ==
X-Received: by 10.60.44.100 with SMTP id d4mr22121949oem.6.1400453952485;
        Sun, 18 May 2014 15:59:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id fk10sm28569183obb.24.2014.05.18.15.59.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 15:59:11 -0700 (PDT)
In-Reply-To: <vpqk39jous5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249549>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >  % git fetch
> >  WARNING: git-remote-hg is now maintained independently.
> >  WARNING: For more information visit https://github.com/felipec/git-remote-hg
> >  searching for changes
> >  no changes found
> 
> I don't think the situation is as simple as you claim. In many cases,
> the first step before the ones you are mentionning are:
> 
>   cd $git/contrib/remote-helpers
>   cp git-remote-{hg,bzr} somewhere/in/path

In many cases, but not all cases. In other cases they are:

    ln -s $git/contrib/remote-helpers/git-remote-hg \
        somewhere/in/path/git-remote-hg

Which has to be done only once, and not every time Git is updated.

> They produces no warning if git-remote-{hg,bzr} exist with the warning,
> but "no such file or directory: contrib/remote-helpers" if the directory
> has been renamed or removed.

So? They'll get the warning the next time they try to use it, and their
workflow won't be interrupted, and the warning will be more useful than
"No such file or directory".

> When git-remote-{hg,bzr} are installed with a package manager, the fact
> that they are part of Git's core or not is often irrelevant. For
> example, Debian splits the git.git source into many packages, so a
> Debian user will not see any difference between helpers included in
> git.git or outside (e.g. I have to install the package git-svn if I want
> to use git-svn).

Yet there is no git-hg. And I doubt Jonathan Nieder is going to package
the out-of-tree git-bzr, which as far as I know, is the only out-of-tree
package of these remote helpers in any distro.

-- 
Felipe Contreras
