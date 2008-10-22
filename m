From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Does a `git pull' write to the origin repository in any way?
Date: Wed, 22 Oct 2008 15:25:17 +0200
Message-ID: <20081022132517.GM3988@gmx.de>
References: <a65d095e0810220200q42936427o917cdac067d04135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 15:26:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsdjQ-0001PG-Df
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 15:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbYJVNZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 09:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbYJVNZW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 09:25:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:60341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752161AbYJVNZV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 09:25:21 -0400
Received: (qmail invoked by alias); 22 Oct 2008 13:25:18 -0000
Received: from pD9E09255.dip.t-dialin.net (EHLO nixos) [217.224.146.85]
  by mail.gmx.net (mp041) with SMTP; 22 Oct 2008 15:25:18 +0200
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1/acwclNTPaB6aFftBVMGQDwCQa96Q424TQ9/c8Ly
	JM/eCbNOvCUzSs
Received: by nixos (sSMTP sendmail emulation); Wed, 22 Oct 2008 15:25:17 +0200
Mail-Followup-To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <a65d095e0810220200q42936427o917cdac067d04135@mail.gmail.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98866>

On Wed, Oct 22, 2008 at 08:00:11PM +1100, Brett Ryan wrote:
> Greetings, the reason I ask this question is because my pattern of
> development is to create local source git repositories on my home
> directory, then pull them to the central location. I found myself
> getting the error `unable to create temporary sha1 filename
> .git/objects/11: File exists' which after investigation found that
> there were paths in `.git/objects/' owned by root which is who I use
> to do the pull from my home directory using sudo. 
Aeh.. about which repo are you talking here? I guess it's not the one
owned by root because otherwise this would be normal..

Hi Brett, I'm not sure where the problem comes form. But I feel your dev
cycle is kind of wired.
If you can login as root using ssh you can also do it the "normal" (?)
way:

# user dir
git remote add root_repo ssh://root@localhost/path-to-root-repo
git pull root_repo # then resolve conflicts if any
git push root_repo # update the root repo

This way you always have conflicts in your local repo and never on the
root one which is preferable (IMHO)..

git-fetch doesn't list a way to access another repo by "su(do)" which
might be the best way here ? This could be convinient because you
would'nt have to setup an extra group to access the same repo as root
and user (?)

You're right that git pull *should not* modify any files from the repo
its pulling from.. But I don't know enough about git internals to say
more about this. All I know is that git clone might have created some
hardlinks.. But I'm not sure how this interfers with file permissions.

I hope someone else can give a more accurate reply.

Marc Weber
