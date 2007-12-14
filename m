From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git gui blame utf-8 bugs
Date: Fri, 14 Dec 2007 04:39:59 -0800 (PST)
Message-ID: <m3k5nhqwkn.fsf@roke.D-201>
References: <20071212091744.GA5377@pvv.org>
	<20071214064709.GH14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 13:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J39qB-0003zf-Cj
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 13:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761633AbXLNMkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 07:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760393AbXLNMkF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 07:40:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:26345 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107AbXLNMkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 07:40:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so911495nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 04:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=hece+VTDElAWwmx94mw8Nc5hyURvoAt9JA6byFbE8BU=;
        b=rU0yyXCZKHeif7hpnokqs5iN/tXfMUMqp6I7i/HGqrfGsuULmv4b8UVUQOgXYtlHcsf7dubS16zpTqDVUbHAyaIGGv0211cvAr82uYBBs4mN9GC83oAXhA60egT0MaY6yFTo2p3GW5ZWwAJUA4Cko5TFfyvcW/WRpFUnrq72sOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=vF62xG3PIKRmEIcl3Od0X6aGi+MYHC+vxfCXfe13IFORTsU5vMUPo6Zhfqh+flplXJmBM/VuPqhgw7jHtjKWygGeP/jDmnqoDSzihszIPdrSIY2D9HUBDkrr+nqP9PLM+bM0EcWDNYooFNGTv5Du5CSykUVwPJXmKzklalvZ5N4=
Received: by 10.86.54.3 with SMTP id c3mr2987676fga.4.1197636000618;
        Fri, 14 Dec 2007 04:40:00 -0800 (PST)
Received: from roke.D-201 ( [83.8.245.165])
        by mx.google.com with ESMTPS id 12sm12211488fks.2007.12.14.04.39.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 04:39:59 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBECds9x004757;
	Fri, 14 Dec 2007 13:39:55 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBECdq1R004754;
	Fri, 14 Dec 2007 13:39:53 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071214064709.GH14735@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68299>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Finn Arne Gangstad <finnag@pvv.org> wrote:
> > git gui has some utf-8 bugs:
> 
> It has several.  :-)
>  
> > If you do git gui blame <file>, and the file contains utf-8 text,
> > the lines are not parsed as utf-8, but seemingly as iso-8859-1 instead.
> 
> Right.  git-gui is keying off the environment setting for LANG, so I
> guess its set to iso-8859-1 on your system but you are working with a
> utf-8 file.  We've talked about using something like .gitattributes
> to store encoding hints, or to just put a global gui setting in
> ~/.gitconfig but neither has had any patches written for it.
> 
> UTF-8 is seemingly the most common encoding that git-gui is mangling
> so maybe we should be defaulting to utf-8 until someone codes a
> more intelligent patch.

Currently there is no config variable for default encoding of file
contents (of blobs) and of filenames (of trees) because those do not
matter for core git.  But they do matter for GUI.
 
> > Also, the hovering comment is INITIALLY shown garbled (both Author and
> > commit message), but if you click on a line, so that the commit
> > message is shown in the bottom window, the hovering message is
> > magically corrected to utf-8.
> > 
> > The text in the lower window (showing specific commits) seems to
> > always be handled correctly.
> 
> That's a "feature".  :-)
> 
> What's happening here is the initial hovering message is obtained
> from the machine formatted output from `git blame --incremental`
> and in that format there is no encoding header so I'm just ignoring
> any encoding problems.

So the correct solution would be to enhance "git blame --incremental"
to output 'encoding' header when needed (when commit has encoding
header and it is different from log output encoding).

> Later when you click on a line it does `git cat-file commit $sha1`
> and gets the proper encoding, and corrects the strings it originally
> had gotten from git-blame.  So the hovering message "fixes" itself
> later on.
> 
> Maybe here too we should be defaulting to utf-8 instead of the
> native encoding.

I think this is a good idea, as git repositories are meant to be
cross-operating system (which means cross-delault-encodings)
compatible.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
