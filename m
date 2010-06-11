From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Question about tracking multiple Subversion repository from the 
	same git repository with git-svn
Date: Fri, 11 Jun 2010 09:18:37 +0200
Message-ID: <AANLkTim_wx9lQ_IClmajo5etFKay0xPCTz1UrKilGWln@mail.gmail.com>
References: <AANLkTimMOPXecB0lZM3v2MaZgbhJWwtxOUIGgkxr_PGF@mail.gmail.com>
	<20100610190417.GA15731@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 11 09:18:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMyVq-0006K3-V1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 09:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab0FKHSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 03:18:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59494 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab0FKHSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 03:18:39 -0400
Received: by wyb40 with SMTP id 40so515985wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0yf1Ei0K3b58JmAa66olS262BeytN96WplvKrIL0+Ng=;
        b=EH8jkVY/RhE9RJeAUwOxYojImtWdpvDJiQ2/ZNanO+2VC9czHJSi3kbPliyFaT4ttU
         rwS9yArSSdouwyWiygFTXOeI61YunHA3BN4/4tHZU+AINloPTehnqMVq7T6TvDhn/AjJ
         V6bqttgrlwWzcje66JUMqV3y/wI/6UMbbC7Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DtM+fFXEgiIC6ZT9895ULceMCrJl8R067m8L2pe2VgbZB+g+8eI9d5zVO3UJd9WfBn
         m5ZTrtZ5hLE++idAmZtwesNLmkl8kZ5AW23RRtIHNp5SBKKYAzUTHbjt4hgJYvSLCMF0
         YQok4Ji+aGXHNl/i7CLJKRTxkb1emyuKCfbec=
Received: by 10.216.184.136 with SMTP id s8mr444130wem.4.1276240717538; Fri, 
	11 Jun 2010 00:18:37 -0700 (PDT)
Received: by 10.216.70.210 with HTTP; Fri, 11 Jun 2010 00:18:37 -0700 (PDT)
In-Reply-To: <20100610190417.GA15731@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148927>

On Thu, Jun 10, 2010 at 9:04 PM, Eric Wong <normalperson@yhbt.net> wrot=
e:
>> 1. Is there a way to tell git that abc/trunk is a branch of svn/tags=
/1.2.3 ?
>
> You need to use grafts.

this one?
https://git.wiki.kernel.org/index.php/GraftPoint

seems what I need..

in this case, I had a question:

since if I use this feature my commit will have different SHA-1. I
used to write the commit SHA-1 in some of the svn tags. If I do this
they will no longer be valid.
I think with git SVN the "best" way to identify a commit is using the
"Tree" object SHA-1, it should be the same for every revision that
contains the same content...
so..
1b. Can I extract the tree sha-1 from a commit?
1c. Is there a way to get every commit pointing to to a tree?

Ideally I would do something like

git contain-tree <sha-1-of-the-tree>
[list of commit's here]

does this make any sense to you?

>> 2. can I rename svn-remote "svn" to something like "main" without si=
de effect?
>
> You should be able to (and use GIT_SVN_ID=3Dmain in the env),
> though I haven't used these features in a while.

Renamed, thanks.
do you know if I can set a GIT_SVN_ID (default) per-repository instead
of using the environment
variable?
(since I use git-new-workdir it would be best if I can use a default
per workdir)

>> 3. after 2) can I also rename all the names of the remote branches t=
o
>> main/* instead of svn/* ?
>
> It should be possible... =C2=A0you need to edit $GIT_DIR/svn/.metadat=
a, too.

thanks, did it.

>> 7. if the merge --squash cause a lot of conflicts is there a way to
>> split the conflict resolution across different persons?
>
> I'm not sure what you mean... multiple people working on the same
> working tree? =C2=A0On a shared screen session? =C2=A0I don't see why=
 not.


no,
what I had in mind was a "migration team" to work on the migration of
the customization
to a product to the new version of the main product.

What I have in mind here is some kind of "selective merge".
=46or example...

I merge a group of commits, someone else, on another computer with
git-svn or subversion merge another part and so on..

like...

git merge --squash -- path/to/something
or something like

git merge --squash --interactive

this could give you a way to choose different paths you want to "merge"=
=2E

I know this is not very like a merge but I hope I gave you the idea of
what I meant.

Regards,
Daniele Segato
