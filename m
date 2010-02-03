From: Zack Brown <zacharyb@gmail.com>
Subject: Re: Using "git log" to find the files patched at the same time as a 
	named file
Date: Wed, 3 Feb 2010 16:14:02 -0500
Message-ID: <218b69371002031314rb52da81k92c45f79dc6feca@mail.gmail.com>
References: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
	 <7vk4uughzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:14:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcmY9-0004E0-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588Ab0BCVOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 16:14:09 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:56331 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368Ab0BCVOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 16:14:04 -0500
Received: by yxe27 with SMTP id 27so1557081yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9h0195Oo6DUEC8ekxwgn0M63vd4BuV+DenS/TSDbNnE=;
        b=iDZWW9DikNy+BFg9y4zkI+ZwMm5ke2E3X6u+bHFBowYd5eN1DRbPL0nF7bkEyGDjkO
         AmqsZQLRvuujkqdJe1XTC9WCZA9CNLyEW65tGKSAJZA1fy8C1C0cGQp/9B1v3AKKOIF5
         Tc+RIUjqC2obNslHn1he3ZVOzqAoYDqKOc2os=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RkdzcNsvNYdRINL6oxNiCHbdUvKEEeEBsqBNJeERv9KWRnx6bfQRj8XR1wCzL9DK53
         zSHdjzRQWK+aQqyzVqItE8YGm6h8Bgsj48IIDEyf6rEex2eV6MHdeYoyn4exJ02xese1
         tALREez34os3ycCoDJjPn/zO5qRsvlCBV28zI=
Received: by 10.150.56.14 with SMTP id e14mr711386yba.109.1265231642806; Wed, 
	03 Feb 2010 13:14:02 -0800 (PST)
In-Reply-To: <7vk4uughzf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138901>

On Wed, Feb 3, 2010 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Zack Brown <zacharyb@gmail.com> writes:
>
>> If I have a filename I'm interested in, and I want to find other fil=
es
>> that have been modified in the same commits that modified the file I=
'm
>> interested in, how could I do that with git?
>
> Like this?
>
> $ git log --full-diff --name-status v1.6.0..master -- Makefile

Yes! Thank you!

I went back to the man page to see why I didn't find that before.
Here's the text for the --full-diff option:

   "Without this flag, "git log -p <path>..." shows commits that touch
   the specified paths, and diffs about the same specified paths. With
   this, the full diff is shown for commits that touch the specified
   paths; this means that "<path>..." limits only commits, and doesn=92=
t
   limit diff for those commits."

That's all the text that deals with --full-diff in the git log
manpage. I'm not sure what it's trying to say - it seems really hard
to understand. What about something like this:

"Without this flag, "git log -p <path>..." shows commits that touch
the specified paths, but it only includes the diffs from those commits
that affected those specified paths, regardless of whether other paths
were changed in those same commits. With "git log --full-diff -p
<path>...", git still only reports commits that touch the specified
path, but now it also includes the diffs that affected any other paths
changed in those same commits."

Would that be an improvement?

Be well,
Zack

>
> to ask "Which files have changed in the commit that touch Makefile si=
nce
> v1.6.0 up to the tip of the master?"
>



--=20
Zack Brown
