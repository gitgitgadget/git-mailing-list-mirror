From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 11:00:21 +0000
Message-ID: <CALeLG_=YQDrgMfOoR_GyNRexWxDqQGhFubmaYwM6pqXJuLnO6A@mail.gmail.com>
References: <1492019317.191838.1362650820122.JavaMail.root@openwide.fr>
	<822188477.192374.1362651959144.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 07 12:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDYZB-0001N4-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 12:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218Ab3CGLAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 06:00:25 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:55571 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab3CGLAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 06:00:23 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so232118obh.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 03:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=9IYFeGwxVRpYthtCRXX6jBb5xp/NrRGL9QLnnoMkoyI=;
        b=aVlkjwL51nyLOzVYu9pd57y23fgNi+HobccVDIh/2WaDZQBaGqC349LeIlkVUg8WXC
         lGkVa/8s1YzbuJVwTn1vhMOOuPU/xrLOpnBY1hfPacwunJMbwL/fgnYUgDpxaLyqusdW
         3m1vhJYrhVMFXIIEdRupzVB2IPiKSOru1EomK/Se7vo4VBHMU5n9VqbuKOAyFdvQwYKH
         be6V4D13u+4NNRH79IlmpkEpXUrlSXzVZrZpQmy7YNhQzgi+iiiY3B1iMmgmJw+pMFDy
         /yvnCSwRbC+do7lweXQgQRBUKIREumLOoENOVO3WaZKiq8qvHIIJgvUVKC1emUrbxicx
         zDvw==
X-Received: by 10.182.12.6 with SMTP id u6mr25288500obb.3.1362654021609; Thu,
 07 Mar 2013 03:00:21 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Thu, 7 Mar 2013 03:00:21 -0800 (PST)
X-Originating-IP: [212.219.195.146]
In-Reply-To: <822188477.192374.1362651959144.JavaMail.root@openwide.fr>
X-Gm-Message-State: ALoCoQn7LKhiDTBZfVfA1NN929RT2f+OrH2ngiEWu/pN22e3+gOFzCjQYFtJnQPxMf4G5BSlI1c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217591>

On Thu, Mar 7, 2013 at 10:25 AM, Jeremy Rosen <jeremy.rosen@openwide.fr=
> wrote:
> Hello everybody
>
>
> I am trying to use git-subtree to follow a subproject but I have a co=
uple of problems and I am not sure if I am doing something wrong
>
> Basically I am trying to use a tag on the subproject as my "base" for=
 the subproject but subtree doesn't seem to handle that properly
>
>
> my first attempt was to simply do
>
> "git subtree add --squash git://git.buildroot.net/buildroot 2013.02"
>
> but subtree refused, telling me that the SHA of the tag is not a vali=
d commit.
> Ok it makes sense, though I think this is a very valid use-case...
>
> so I tried
>
> "git subtree add git://git.buildroot.net/buildroot 2013.02^{commit}"
>
> which was refused because git fetch can't parse the ^{commit} marker.
> Again it makes sense, but I really want to start from that tag.
>
>
> so I tried
>
> "git fetch git://git.buildroot.net/buildroot 2013.02"
> "git subtree add --squash FETCH_HEAD"
>
> which worked. Ok at that point I am slightly abusing git subtree, but=
 it seems a valid usage
>
> except that this last attempt causes serious problems when trying to =
split out the tree again
>
> the call to "git commit-tree" within "git subtree split" complains th=
at the SHA of the parent
> is not a valid commit SHA. Which is true, it's the SHA of the tag.
>
>
> At this point I am not sure if I am abusing subtree, if I have a legi=
timate but unimplemented use-case and how to
> fix/implement it.
>
> the squash-commit message only contains the SHA of the tag, should it=
 contain the SHA of the commit ?
>
> "subtree split" can only handle commit SHA, should it somehow follow =
tag SHA too ? how ?
>
> this is probably a trivial fix for someone with good knowledge of git=
-subtree but i'm not there yet, so any hint would be welcomed
>
>     Regards
>
>     J=E9r=E9my Rosen
>

Hi J=E9r=E9my,

Git subtree ignores tags from the remote repo.

To follow a project in a subdirectory I would use git-subtree add
selecting a branch, not a tag, from the other repo. Then use
git-subtree pull to keep yourself updated.

e.g.

To add:

git subtree add --prefix=3D$subdir $repo $branch

Then to update:

git subtree pull --prefix=3D$subdir $repo $branch

If you make any changes on the branch and wanted to push them back you
could do that with:

git subtree pull --prefix=3D$subdir $repo2 $branch2

$repo2 and $branch2 would be different from $repo and $branch if you
wanted to push to your own fork before submitting a pull request.

--=20
Paul [W] Campbell
