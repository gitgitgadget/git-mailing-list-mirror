From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 06:34:47 -0800
Message-ID: <8c9a060911090634p4e036208mfb3160eb4c4430e9@mail.gmail.com>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> 
	<loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> 
	<alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VRc-0004YN-MC
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZKIOmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 09:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbZKIOmA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:42:00 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65096 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbZKIOl7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 09:41:59 -0500
Received: by pwi3 with SMTP id 3so645975pwi.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=UynNFq3XTKKqKySCwYFiOEC1qRnLyvA948Xx+GxSS/c=;
        b=biZvhXyQEd5WQfiLj7C0rH68Bb8U/RWhL/rcn2lRUvVCPkw0gl1DshIwqbz2JUcv9Y
         QuM8UtFREnZmEIYtpynkHQGD+NSp/KZU2Xk0crVAZNOoqWs6f8gg7jjKssv6xHyzsD8v
         gPbJEJQNQTUQyB8mdaMVsWi00B5zHqQelWm2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=r/5A92N6s9MQD3S5oUpYZ80PU+z999yFj4Nl+7+t+HwrQSpTBgviIKDWRmF2NqyyDj
         tgATLDc2kYX0pzcnfriVSNTJAF0MoWFV9ru9JnIJWqMd8FZIbGgQ3gNaIEr58jTrYoqi
         EqbkkEuwXmXzjCISPiWyyktj1B73R761/V5RI=
Received: by 10.140.191.12 with SMTP id o12mr455477rvf.163.1257777307059; Mon, 
	09 Nov 2009 06:35:07 -0800 (PST)
In-Reply-To: <loom.20091109T084539-720@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132461>

On Sun, Nov 8, 2009 at 23:53, Dmitry Smirnov <divis1969@gmail.com> wrot=
e:
> =C2=A0<david <at> lang.hm> writes:
>
>> going back to the initial poster's comments. if the android repo is =
1G,
>> eliminating the history will probably have significantly less impact=
 than
>> you expect it to.
>
> Do you have 2 or more copies of the same repository at the same time?
> If yes, can I skip cloning new copy from network?
> Or even skip cloning it at all?
> Is it possible with Git to chekout into two (few) working trees?
>

Take a look at git-new-workdir.  It's in the contrib directory of
git.git.  This lets you skip re-cloning the same repository over
again, if you want a new working copy of it.  It'll also give you some
space savings, by sharing certain key things in the .git directory
between working copies, by using symlinks.

It does have a few caveats, however.  If you have the same branch
checked out in two different working copies created using
git-new-workdir, and update the branch in one of them, then the other
will appear to have a bunch of staged changes, even though you haven't
done anything in it. The branch pointer will have been updated out
from underneath it, and it will be "confused".  As long as you
remember not to update a branch that is checked out in more than one
place on your machine, you'll never notice, thuogh.
