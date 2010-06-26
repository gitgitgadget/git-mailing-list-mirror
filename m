From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-gui and gitk-git as submodules
Date: Sat, 26 Jun 2010 13:31:54 -0500
Message-ID: <20100626183154.GA13581@burratino>
References: <4C24C34B.20403@web.de>
 <7vlja3j7hu.fsf@alter.siamese.dyndns.org>
 <20100625190147.GA17493@burratino>
 <AANLkTimqXhGw5fAAgZsoDAI9s6kaIzcka9mbFEW8j05v@mail.gmail.com>
 <4C25E83E.4080905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:32:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSaAq-0001XL-26
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0FZScM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 14:32:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36950 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0FZScK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 14:32:10 -0400
Received: by iwn41 with SMTP id 41so3082378iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1XJn/fsVM6oAkXLQMlWFLVDz6cIw9uuCFAV9HEJt40s=;
        b=suLqT4zklyrDm58nxhyg+Go6JosymGZ5d/CgeOO6bX8yMxPwGzsymcwax7ht0lcak0
         leYNODEJT5te8yV9F5iH7jVQAsaKcxVAFEQFKlsOJcTtiiFqB8hkyucn1SGbnaioVK0q
         /I1VzOJ2HMm/GLoEp5LkroHey3h2ZBAJMCTJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BKRVXs9za7HEkyeUN11Zretq/jD4oXh7ygbVzE8W0v9B2RO09O+y071XXPg5zXYj6V
         bBJoaeUkRqbgS3LYQUzBYkN6hRyT3bf88PpdgJkohgUdHlwHRHeQZSRNdjc4Z1uvGsd+
         i3AOpkhoQmpz+N7RY0GrfxP67ccW+fmtvkbh0=
Received: by 10.231.155.3 with SMTP id q3mr2782405ibw.20.1277577129833;
        Sat, 26 Jun 2010 11:32:09 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm52893293ibu.12.2010.06.26.11.32.08
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 11:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C25E83E.4080905@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149770>

Jens Lehmann wrote:

> 1) Switching branches, merging, rebasing and resetting in the
>    superproject must result in a checkout of the matching submodule
>    work tree

Switching branches can change the HEAD commit of an already checked
out submodule, and switching branches can change the list of
submodules.

=46or the latter, maybe it would make sense to introduce =E2=80=98git c=
heckout
--recursive=E2=80=99 which runs =E2=80=98submodule update --init --recu=
rsive=E2=80=99 after
checkout.  IMHO, in git 2.0 this even ought to be made the default.
One could use --no-recursive to access the more flexible traditional
behavior.

> 2) On "git clone" the submodules must be cloned and checked out too

Does =E2=80=98git clone --recursive=E2=80=99 take care of it?

The Makefile would need to be tweaked to give a reasonable message
when the caller forgets to check out an important submodule.

> 3) Switching between commits in the superproject where a directory
>    is replaced by a submodule or vice versa doesn't work right now.
>    Submodules should handle this situation, otherwise the commit
>    putting gitk and git gui into submodules would become a barrier.

Yes, this is the fatal problem imho since it would affect basic
maintainance tasks.  I consider maintainance of the branch (rather
than consumption) the most important piece to begin with; for a branch
not in next, usability problems can be resolved over time.

> I am working on these issues, but that will take some time. But when
> they are solved, me too thinks that these two should become submodule=
s.

Thanks for the explanation.
