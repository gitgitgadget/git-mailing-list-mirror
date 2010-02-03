From: Zack Brown <zacharyb@gmail.com>
Subject: Re: Using "git log" to find the files patched at the same time as a 
	named file
Date: Wed, 3 Feb 2010 16:52:36 -0500
Message-ID: <218b69371002031352je066f5cvd87025459fade368@mail.gmail.com>
References: <218b69371002031238y6a377b06x76b8f8e87ea0ee46@mail.gmail.com>
	 <7vk4uughzf.fsf@alter.siamese.dyndns.org>
	 <218b69371002031314rb52da81k92c45f79dc6feca@mail.gmail.com>
	 <7vfx5idmt2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:58:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnFH-0000uD-37
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0BCV6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 16:58:42 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:61260 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab0BCV6l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 16:58:41 -0500
Received: by gxk24 with SMTP id 24so2288714gxk.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 13:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rl/rZPE0jcR6H7kZrU2jTqMrQW7NhbzAAOqMb+4/mLk=;
        b=IB44tcR+tbzGFUPyOHoC3IlzlnGLtYfCKvDGk2P1N9mGTCgVKdKJbNZkS3tsqyFMB8
         RG3AdjaAcqIX87ex8gwgQfUWggx9shyl+IlNR/VIB5jFW+2hVBcM1kJdZsjpfUeNaneo
         fQEwRm9slAn52Ol9+j0CXNLvOqePXHN6y8Vgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KJfJ5yHBzyDym1XJmMKywMhOBZezjAZMXvShwpCgdnT8Gsn2jUKhTCCYdoiqS0wNtf
         /oFULYWSBm2ObOgShfv0yolBOPaIoUILtDcPmFX9WSfg7AoCpGzIc9O+OQakoiRUmztY
         o7/QGAvNXO7KNXhBTjcipZXUixaBUJ3TG2hIk=
Received: by 10.150.56.14 with SMTP id e14mr770212yba.109.1265233956037; Wed, 
	03 Feb 2010 13:52:36 -0800 (PST)
In-Reply-To: <7vfx5idmt2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138906>

That looks much clearer. But I would change the final sentence to,
"This option lifts that limit and tells "git log" to include changes
from all paths that were affected by the outputted commits, not just
the changes from the paths specified on the command line."

Be well,
Zack

On Wed, Feb 3, 2010 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Zack Brown <zacharyb@gmail.com> writes:
>
>> ... What about something like this:
>>
>> "Without this flag, "git log -p <path>..." shows commits that touch
>> the specified paths, but it only includes the diffs from those commi=
ts
>
> I would say "s/but/and/", because it is more natural that you get the
> "limited" view after you explicitly stated that you are "only interes=
ted
> in these things" by giving pathspecs.
>
>> that affected those specified paths, regardless of whether other pat=
hs
>> were changed in those same commits. With "git log --full-diff -p
>> <path>...", git still only reports commits that touch the specified
>> path, but now it also includes the diffs that affected any other pat=
hs
>> changed in those same commits."
>
> And "but" on the second line from the bottom makes sense---by giving =
the
> option, you are telling it to work differently.
>
>> Would that be an improvement?
>
> Surely. =A0I would suspect that people would go even further. =A0"-p"=
 is not
> very special (notice I used --name-status in my example).
>
> Also I think the description should start with what it _does_, not wi=
th
> what happens without it.
>
> So how about this?
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 0e39bb6..5dd1c0c 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -49,11 +49,14 @@ include::diff-options.txt[]
> =A0 =A0 =A0 =A0commit was reached.
>
> =A0--full-diff::
> - =A0 =A0 =A0 Without this flag, "git log -p <path>..." shows commits=
 that
> - =A0 =A0 =A0 touch the specified paths, and diffs about the same spe=
cified
> - =A0 =A0 =A0 paths. =A0With this, the full diff is shown for commits=
 that touch
> - =A0 =A0 =A0 the specified paths; this means that "<path>..." limits=
 only
> - =A0 =A0 =A0 commits, and doesn't limit diff for those commits.
> + =A0 =A0 =A0 Show all changes, even outside the given pathspecs.
> ++
> +Pathspecs <path>... given to "git log [<options>] <path>..." =A0limi=
t the
> +output to the commits that touch the specified paths. =A0When option=
s to
> +show changes introduced by these commits (e.g. "-p", "--name-only") =
are
> +given, the output of the changes are also limited to the specified p=
aths.
> +This option lifts the latter limit and tells "git log" to include al=
l
> +changes, even the ones outside of the given pathspecs.
>
> =A0--follow::
> =A0 =A0 =A0 =A0Continue listing the history of a file beyond renames.
>
>
>



--=20
Zack Brown
