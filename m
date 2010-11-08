From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Newbie question: how to move bunch of files
Date: Tue, 9 Nov 2010 11:14:22 +1300
Message-ID: <AANLkTik9aQaV1OvARuPchekYpQFANu-+k3c2n3wamzXh@mail.gmail.com>
References: <4CD86204.1000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mat <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 23:14:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZyu-0007Aj-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab0KHWOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 17:14:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49023 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab0KHWOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 17:14:23 -0500
Received: by gxk23 with SMTP id 23so3803237gxk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F+g7HEpuIUwmiTpshVSBOBdszQbjvWdDah4XjSlcUwU=;
        b=goXS2/08dzT9bCKq2WU+L+ktWPCEitU4ZyGFp0S8KWYTVDHKY+jcJQI1XGg1oTo4JF
         mLbYj5bOy028UfZ0U2Yt5kyZPjPp6n3+vXMKvSGAUxoRzqiVvzGR7e9UDMKpaBDS5n+m
         5/RVojbh80UUulth68/STIuYkRZPpB8idZb6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Phad+1M9OGARdWqwkKgePe4nxgjhiEA4tCHFx9tYW1by15pE9Tnk1X4d6Q7gbg1EDy
         bj3eBRGRepTPIIA0j6NKVlJfDEotwEVU4bKwmlnuMkzOx+MI6DZ8SZtPE6oqc/txHp+M
         5QNBdwcXdYqMf1p+1BWa5urk5X+gi9Oo38aiI=
Received: by 10.229.193.18 with SMTP id ds18mr5599903qcb.211.1289254462538;
 Mon, 08 Nov 2010 14:14:22 -0800 (PST)
Received: by 10.229.13.8 with HTTP; Mon, 8 Nov 2010 14:14:22 -0800 (PST)
In-Reply-To: <4CD86204.1000805@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160997>

Hi,

On Tue, Nov 9, 2010 at 9:48 AM, mat <matthieu.stigler@gmail.com> wrote:
> Dear list
>
> I am very sorry to bother you with such a simple question, but I sear=
ched
> for a while on the net and did not come up with any satisfying answer=
 :-(
>
> I just want to move a bunch of files (from /R to /pkg/R ), but get th=
e
> error:
> $ git mv R/*.R pkg/R/
> fatal: not under version control, source=3DR/nll_MSAR3.R,
> destination=3Dpkg/R/nll_MSAR3.R

This is the kind of error you get from asking git to move a file it
isn't tracking.

Have you got generated files in the same location as your repository?
I get the same kind of thing if I ask git to move generated files

   git mv foo/*.pyc bar/
   fatal: not under version control, source=3Dfoo/ast.pyc, destination=3D=
bar/ast.pyc

To get around this you could change your wildcard to only include
files you are tracking or specify them individually. Alternatively you
could just use 'mv R/*.R pkg/R/'  then 'git rm' the old files and 'git
add' the new files you want to track, git should detect the renames
after the 'git rm' and 'git add'. As a final alternative you could
also 'git clean -d' to remove the untracked files but be careful with
that as you may not have added some files you are meaning to track.

> What do I do wrong? Would you kindly indicate me what I should do?
>
> Thanks a lot and sorry again!
>
> Matthieu
>
> PS: I am using git 1.7.0.4 on Ubuntu 10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
