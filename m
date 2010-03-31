From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 17:59:49 -0400
Message-ID: <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
References: <18137.1270056387@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx5xH-0001TL-Iw
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab0CaV76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 17:59:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50754 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab0CaV75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 17:59:57 -0400
Received: by gwaa18 with SMTP id a18so319904gwa.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dU3bvzA738kxsgW7zaYFtvn46BGmxVsoBMazzy6qjxM=;
        b=mtWpwn4NUiRH84gIgjYAqGvC7f1LEyCir87TjtUEPalAnqNNm2FJa9W7z510r7Uelq
         kn1+lROUEYHqiXAT6Ru6BMqlX8CMcHQnEcd07KILwhoC4lEhbYaQ1TQHmv7671zcBgLU
         lEFpVaCjyaO7EvNuSdhnCqN/6Iei9g6/f64GM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CqRajd8I7GC8HeaQc4dud1ILxoO3YkjEKlZL74UlkpCdZOX8aRboGf22crThY/bPa3
         FVrz831Pg8ZPVH83lde9ZmAnZJJ3foRHYEankoO3dYsUtGTSnnZI6QvM0Y9ZHNDMIXqW
         30mou8Xrz+StEi7yRv27hSruMf2V68cN4dcn8=
Received: by 10.231.19.131 with HTTP; Wed, 31 Mar 2010 14:59:49 -0700 (PDT)
In-Reply-To: <18137.1270056387@relay.known.net>
Received: by 10.101.170.33 with SMTP id x33mr411768ano.139.1270072789796; Wed, 
	31 Mar 2010 14:59:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143694>

On Wed, Mar 31, 2010 at 1:26 PM, layer <layer@known.net> wrote:
> In git 1.6.6.1 & 1.6.3.3, "git branch -a" output is like this
>
> * master
> =C2=A0remotes/origin/foo
> =C2=A0...
>
> instead of like this for 1.6.1.3
>
> * master
> =C2=A0origin/foo
> =C2=A0...
>
> Is this a feature or bug? =C2=A0I searched the mailing list archives =
and
> announcements couldn't find any reference to this change.

=46eature. Introduced in 1.6.3:

http://article.gmane.org/gmane.comp.version-control.git/116404

See "builtin-branch: improve output when displaying remote branches"

> This is important to me because I use the output of "git branch -a" i=
n
> scripts.
>
> I should add that the scripts are merely testing for the existence of
> remote tracking branches in the local repo.  If there's a better way
> to do this, I'm game.  Thanks.

git branch is a so-called porcelain command, and as you've now been
bitten by, the output of porcelain's is subject to change.

You probably want git for-each-ref.

Aside, the only list of plumbing vs porcelain commands I'm aware of is
in the bash-completion script under contrib. See
__git_list_porcelain_commands here:

http://git.kernel.org/?p=3Dgit/git.git;a=3Dblob;f=3Dcontrib/completion/=
git-completion.bash

Those are generally commands whose output you do not want to be
parsing. All the other git commands installed under git-core are
mostly plumbing upon which you can build additional functionality.

(Note to git list: there should be a man page that has a single-line
summary of each command and states whether the command is plumbing or
porcelain. Maybe there is and I just don't know it.)

j.
