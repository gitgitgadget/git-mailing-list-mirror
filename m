From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Migrating svn to git with heavy use of externals
Date: Tue, 8 Apr 2008 16:06:37 -0400
Message-ID: <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Tue Apr 08 22:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjK6H-0004Jy-Nc
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 22:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbYDHUGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757061AbYDHUGl
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 16:06:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:24828 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757427AbYDHUGk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 16:06:40 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2853701fkr.5
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ffcYcz27ZpuNSeo992rEdFtk2njzkVQCAaFFLPP9ses=;
        b=EfLh5i3QvWYW03u2To8tVxY75isUoKaiQyqpBwpYBA5VE8e788h5ArrRs88qHhZNsIjg1YAsISPdJMfXQlXP7HX8H6GTxxH6XrBL2ku3Qk2MJlgtxkMSQVvEOpIxen86CzwEsmcgvhGrDDZeoNKieQwAwRIc5UCGHNwmv6aaC5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eof+8UbPgY9huwPYCWDEFm2+cblZG/3VhNEZ3wqnnegLJi+vJnqRGhzAD/5rI/QzhDi+JC+g0RLXxpwq66LilUaEVC6fagrw7yGrk+V8D/bML5IjIAOURTyHFh0vk0gfM6hkC5pbe4majbC9HHwDLAdkGHYjMw5ZnpFkeIXuTFQ=
Received: by 10.82.155.5 with SMTP id c5mr638223bue.62.1207685197796;
        Tue, 08 Apr 2008 13:06:37 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 8 Apr 2008 13:06:37 -0700 (PDT)
In-Reply-To: <47FBB448.3060900@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79021>

On Tue, Apr 8, 2008 at 2:07 PM, D. Stuart Freeman
<stuart.freeman@et.gatech.edu> wrote:
> Maybe I should clarify.
>  I've imported an svn managed project into a git repository
>  with 71 submodules, what I don't understand though is if I
>  have a branch called 2-5-x and another called 2-4-x in each of
>  the submodules and the superproject, is there a way to
>  associate those?

I don't think git-svn currently knows how to import svn:externals
properly.  Basically you'd have to do it yourself, perhaps with the
help of something like git-filter-branch and a shell script.

The equivalent of svn:externals in git is called git-submodule, and
it's actually much more powerful than svn:externals, because you can
link to a *specific revision* and not just a branch.  In other words,
I can set up my application to point at r2956 of a library, so even if
the library changes in the future, my application always gets exactly
that version.  (To have the app use the later version, you have to
'git pull' in the submodule, then make a commit in the application
module.)

See "man git-submodule" and "man git-filter-branch" for more information.

If I'm wrong and git-svn already supports svn:externals, I'm sure
someone will correct me :)

Have fun,

Avery
