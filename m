From: Evan Shelhamer <shelhamer@imaginarynumber.net>
Subject: Re: Branches & directories
Date: Wed, 17 Aug 2011 14:47:02 -0400
Message-ID: <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 20:47:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtl8w-0005Yu-K3
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 20:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab1HQSrG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 14:47:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46520 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab1HQSrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 14:47:03 -0400
Received: by vws1 with SMTP id 1so911540vws.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 11:47:02 -0700 (PDT)
Received: by 10.52.175.129 with SMTP id ca1mr1324264vdc.372.1313606822196;
 Wed, 17 Aug 2011 11:47:02 -0700 (PDT)
Received: by 10.52.168.234 with HTTP; Wed, 17 Aug 2011 11:47:02 -0700 (PDT)
In-Reply-To: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179526>

Hey Hilco,

I'm not sure exactly what you did because you didn't give a list of
git commands, but I'm guessing you ran into the fact that git doesn't
track empty directories.
=46or instance if I do:

(in repo on your branch)
mkdir test_dir
touch test_file
git add *
git commit -m "test commit"

test_file will be tracked but test_dir will not (because it is empty).
To avoid this problem, a convention is to add an empty ".gitkeep" file
to directories. For example:

(in repo on your branch)
mkdir test_dir
touch test_dir/.gitkeep
touch test_file
git add *
git commit -m "test commit (with directory)"

Will commit the directory as expected in your branch, and when you go
to checkout another branch it will not exist.

Hope that helps. Sorry if you already know this and I misunderstood
your question.
Evan Shelhamer

On Wed, Aug 17, 2011 at 2:35 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Hi all,
>
> I have been noticing strange behaviour that I would like to be able t=
o
> explain or report as a bug as the case may be.
>
> What happens is that I create and commit a new directory in branch
> 'next' and then when I checkout 'master' this new directory is still
> there. I think this is wrong as this new directory does not exist yet
> in 'master'. Is my understanding correct?
>
> I tried recreating this scenario in a clean Git repo with a simple
> mkdir and commit but when I did a checkout of 'master' the new
> directory was removed. So the basic scenario seems to work the way I
> expect it to.
>
> Assuming I ran into a bug, I would like some suggestions to properly
> investigate this. Clearly, I'm doing something else that triggers the
> behaviour I'm seeing but I'm not sure what it is. What might trigger
> Git "remembering" a directory? Or what would prevent it from removing
> a directory when checking out a different branch?
>
> Extra information: "git status" (in 'master') yields nothing. But
> after adding a new file in the directory-that-should-not-be-there, Gi=
t
> treats the entire directory as untracked and new (as one would
> expect). I can also safely remove the directory with no (obvious) ill
> effects.
>
> Cheers,
> Hilco
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
