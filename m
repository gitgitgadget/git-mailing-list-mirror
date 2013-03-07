From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 12:02:21 +0000
Message-ID: <CALeLG_k=8S0Q-89CUvNPQT91gkJm1NdDN6YtCkdTQZZi9RUjWA@mail.gmail.com>
References: <CALeLG_=YQDrgMfOoR_GyNRexWxDqQGhFubmaYwM6pqXJuLnO6A@mail.gmail.com>
	<1938485067.193912.1362654351290.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 07 13:02:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDZX6-0003ep-TD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 13:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab3CGMCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 07:02:22 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49857 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3CGMCW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 07:02:22 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so444875oag.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 04:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=a78wYZTXRGtup4gmOgYtC5q1Bu2lfUBAwb0E+eA/st4=;
        b=ZwdAIBxDUZ7hKQJT23/082lUEjb1xvP50DM9A8daBNxmbLPJQhdzMlRt+tor7v3f+j
         Fbr6SffOyW7x4rFOhOnNnpfEdARRr1Ch9g3myxklhL3rD8XC7wSnuuei6ThkYWlYlZCz
         4oBQUrEFeWKGvtA615k6l3AUO74DSXK3d8U+VIGmdX8wHDVXlpADY3Q/1N8xOj+PGz4G
         4ICZBd8cSYukr1FGPM2cs0fyUttMdyf9/bLMd3utchzGKvLjQU/tinH5WlzW5eRj8s2h
         w5OuCRocCU6TyqfiY9+bcvVfa9GURUAGzUu7pVNIbfJ+Hh3Ji6pa7LaWmvWu+kDtfoTt
         tWCw==
X-Received: by 10.60.10.34 with SMTP id f2mr25241986oeb.104.1362657741368;
 Thu, 07 Mar 2013 04:02:21 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Thu, 7 Mar 2013 04:02:21 -0800 (PST)
X-Originating-IP: [212.219.195.146]
In-Reply-To: <1938485067.193912.1362654351290.JavaMail.root@openwide.fr>
X-Gm-Message-State: ALoCoQmZQkBzkDqdx+/gkLLSOhCjRsBZ5giRc601/KI7lBk7Oz0FQeCOGas/Co8zZoYEYB13VpQU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217594>

On Thu, Mar 7, 2013 at 11:05 AM, Jeremy Rosen <jeremy.rosen@openwide.fr=
> wrote:
>>
>> Hi J=E9r=E9my,
>>
>> Git subtree ignores tags from the remote repo.
>>
>
> is that a design decision or a case of "not implemented yet"

I'm not sure. If you imported all the tags from all your subtrees
repos, you could easily end up with duplicate tags from different
repos. They could be namespaced, but there is no concept of namespace
in git-subtree. That even assumes that you can tag a subtree (I've not
tried).

>> To follow a project in a subdirectory I would use git-subtree add
>> selecting a branch, not a tag, from the other repo. Then use
>> git-subtree pull to keep yourself updated.
>>
>
>
> well... yes, but releases are marked by tags, not branches so what I =
really want is a tag.
>
> I still use git so I have the possibility to update and can traceback=
 what happened later
>
>> e.g.
>>
>> To add:
>>
>> git subtree add --prefix=3D$subdir $repo $branch
>>
>> Then to update:
>>
>> git subtree pull --prefix=3D$subdir $repo $branch
>>
>
>
> ok, that probably works with branches (didn't test)
>
>> If you make any changes on the branch and wanted to push them back
>> you
>> could do that with:
>>
>> git subtree pull --prefix=3D$subdir $repo2 $branch2
>>
>> $repo2 and $branch2 would be different from $repo and $branch if you
>> wanted to push to your own fork before submitting a pull request.
>>
>
> shouldn't there be a subtree split somewhere ? IIUC pull is only merg=
e from the remote to my local repo,
> not the other way round

Oops, that should have been git subtree push, which uses git subtree
split internally.

--=20
Paul [W] Campbell
