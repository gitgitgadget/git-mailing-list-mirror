From: Dan Porter <dpreid@gmail.com>
Subject: Fwd: git p4: feature request - branch check filtering
Date: Tue, 18 Feb 2014 12:42:47 +0000
Message-ID: <CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
References: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Herron <redbrain@gcc.gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 13:42:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFk0l-0004E4-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 13:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbaBRMmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 07:42:49 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:48060 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265AbaBRMms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 07:42:48 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so7071252igq.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 04:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ut9sAkYewB5a230bsPaJbIq885eZ/I4NhXOx/kPq7s8=;
        b=STSK4wxNWinppCIg58q4/wAuJRvTM1R/YWF7xEEKh00jxAbya9fQQ9nOML50ybkBjR
         aYxXvSbwRGLA+eQz/0axhghccfUmWh/zMelHJZKgvQcb1qkTnO7lNCgKRJeH1f3HitZF
         TPRmBPLx8zjA+eOIxv+b1eub3X4y5IHBOoIDR4ZlO9wbOdJCnTATQj2AwHZByh12wRpw
         uvj+QYgFFNP9sEUlpl6krnmlmUbpuzjUGnPXgGgL4K7XnMB+nQ1cah5NDyDIGdC0On12
         tukHzZ65KdLrTUduj+SCufh3I4dgIERuauCUv6Jso1GIzxEHaBRhZjcLH5PEe7itTBLS
         QpRw==
X-Received: by 10.50.57.1 with SMTP id e1mr21340441igq.42.1392727367919; Tue,
 18 Feb 2014 04:42:47 -0800 (PST)
Received: by 10.64.225.175 with HTTP; Tue, 18 Feb 2014 04:42:47 -0800 (PST)
In-Reply-To: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242298>

Hi,

I'm unable to find a similar issue, and if it's raised on the mailing
list I apologize.

I work at a company that has recently moved all CVS, SVN, and git
repositories to Perforce.  Depots have not been setup correctly in
every case, and there is one depot that contains literally hundreds of
projects under commercial development (and hundreds of branches as a
result)

My project may be in //stupid_depot/commercial/teamporter/rok.  This
is the path I clone with git-p4.  The only branches in this depot that
contain files at this path are titled as
'rok_porter_branch/release_1.x' or similar.

When using '--detect-branches' git-p4 checks each key of branches to
see if any of them have files in the path I've cloned.  Whilst this is
good in practice there is unfortunately 6,809 branches, git-p4
processes about 2 a second and just under an hour to perform any
git-p4 rebase, submit, or similar operation.

I propose the addition of a branch list filtering option
(--filter-branches) that takes either a regular expression or list of
branches it should check.  This may be useful in sane situations where
you don't want to scan every branch in a Perforce repository, or
blacklist branches that have undesirable content (for example, one of
the branches is called 'svn-backup'.  It contains a single, multi-GB
tarball.)

It would be ideal to have this information (after initial clone or
sync) stored somewhere in the git config where is appropriate so that
future submit/rebase operations adhere to this list.

Has something like this been worked on, or has been considered in the
past?  If not I will consider implementing this after reading up on
the Git code guidelines.

Thanks for keeping the Git workflow accessible in painful areas.

Dan
