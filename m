From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Thu, 19 May 2011 21:10:46 -0700
Message-ID: <20110520041045.GB13582@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org>
 <20110520035856.GA13582@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 06:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNH3B-0005mr-7v
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 06:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab1ETEKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2011 00:10:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62095 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1ETEKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 00:10:51 -0400
Received: by pwi15 with SMTP id 15so1533312pwi.19
        for <git@vger.kernel.org>; Thu, 19 May 2011 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=26e6O5M57kiPqYvh8SNmWZ3Zbgz7hV9Nza6kR+KEuvM=;
        b=XK/FsHWCgd3CETN63ywJTBSHSn3pgWW52cUUzis0zh7hHgHB5LZenfItSYXjrnBxJ6
         NIsWgyJZV/WWRzynO3cjFL38JtOYPiDaIz+Nk9mgnFONxvAyj6HLO2UCOsNeLJw4r3Xy
         uNeMYQyFZggNJXy/aWuUKcJ6DfFy8AZV1Xyo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X6/B3ZKa11RXqTgV/4YX+0O+2KC51RzlqYfUxj16AMUn2tuccVEIJr0jlfKyKJA1J5
         tZtHxXyVE9ynGItQeQN6uRGjVr7evXZU/0HhWR9C9pcYGMK0GETJysBcpaOlw4nUjOo+
         6lWfvQcYPEbjSV4l9rm91YJV/FriqdwdtXJFo=
Received: by 10.68.29.228 with SMTP id n4mr5694398pbh.500.1305864651055;
        Thu, 19 May 2011 21:10:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id r5sm2188080pbe.101.2011.05.19.21.10.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 21:10:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110520035856.GA13582@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174037>

On Thu, May 19, 2011 at 08:59:00PM -0700, David Aguilar wrote:
>=20
> Hello,
>=20
> On Sun, May 15, 2011 at 10:39:18PM -0700, Junio C Hamano wrote:
> > Fr=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes=
:
> >=20
> > > Unfortunately, 'git difftool' does not keep the current working d=
irectory while
> > > launching gvimdiff.
> > >
> > > =3D> Is it done on purpose ?
> > > If not, it is probably a good idea to fix this.
> >=20
> > [...snip...]
> >=20
> > If the answers to both of them are No, then it might be a good idea=
 to
> > change the behaviour.
>=20
> Another thing to consider is ensuring that there is a
> consistency between 'diff' and 'difftool'.
>=20
> When you run 'git diff' from a subdirectory git will show you
> a diff against the entire tree.  In this respect, 'difftool' is
> consistent.  In that sense, yes, this is very much "on purpose".
>=20
> [...snip...]

I just realized that I was focusing on the "whole tree diff"
aspect which really is orthogonal to the "chdir to root"
done by 'git diff' when running $GIT_EXTERNAL_DIFF scripts.

I imagine you want to be able to use vimdiff while diffing
and open files, etc., from the current directory?

In that case, maybe we can have the best of both worlds --
whole-tree diff and keeping the current directory.
That would be kinda like what 'git status' does when it shows
you relative paths above and beside the current directory.

We would have to change the way $GIT_EXTERNAL_DIFF works so
that it preserves the current directory and constructs
paths relative to it.  Patches welcome :-)

I don't really know whether it would be a good thing to do,
though, since I have not dug too deep into how the extdiff
code is structured.
--=20
					David
