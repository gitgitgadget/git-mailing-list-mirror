From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: possible bug of git stash deleting uncommitted files in corner case
Date: Fri, 22 Apr 2016 13:48:55 +0200
Message-ID: <CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com>
References: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 13:49:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atZa1-0001PE-SO
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 13:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcDVLs6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 07:48:58 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34828 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcDVLs5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 07:48:57 -0400
Received: by mail-lf0-f51.google.com with SMTP id c126so77826885lfb.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=0O0rGCfs+cODMUf8moN58bWRMrfz7C2iPl6xpFPIrac=;
        b=LHrGm/qALBFE/OoRaHQaPhPvsh9CH/JfZ16U4T/51W4DJtVP38KZ1mUi+fJkWgcE06
         wCZiwm1dbYLeYibS1T5sGYQ4O1xvAekT2dfwUH8byl7IIIPFAwR3k4t3N6GfVWZM1dio
         9L5Yp1L+bST6XHLw2drWQZSMeWIs8ZJFOJM1xJtYJ+3mVwssv2QtZvDJyJOyZdI4ugYN
         MCkX47Pu0dBYP02lGDQxosX5tjMMbcMn6BNw9PnNl60O9GAsqRqHMTXV9Dd0xzWzCEsg
         aibKawaby3pz/iRZd6XHZ1QJ+YnGiE8vpoLWYRUqY5Yqf2RCDAjR3KC3oDWJsYyHgXGY
         GqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-transfer-encoding;
        bh=0O0rGCfs+cODMUf8moN58bWRMrfz7C2iPl6xpFPIrac=;
        b=QPWJKKtOatFluqiJaoR81kByqrZqtPzZxF2iQwehYEtw6DPlog9dzINsBybxPCKlgE
         QKqQXsES2JdRNEs8iBJYEAzfhDiD3tcEu1Q4tJswHy4cIGuvR8v23Rbwx7h5OgLFySpF
         cLZPseI9IzBhGAHbdNz6cJc7SpCc7+6NcZ/EG/YaOgPtHZHi1cuomO5oWpatwPYzIZMK
         er9Fk8hfIm2cuM2ZWei7Gn7EOo1CqbMscglGCZ6h+x0Ii2pUxhXK60MZA8sUSWDorXoE
         JpWGW7ghNDCvRTbCyJVPsEDBXjh2IqiH72w4gvytv+h/J/S3rRK05LUrk6Fyf06RoJJY
         UAfg==
X-Gm-Message-State: AOPr4FUUPLkCOmu/nxlfhPsyAVOU9HCoVHMyUa3/eLxLBdkF9Wzl8B39l9DTzQz1KkQwL3nAAY4hd2+fXM0LOw==
X-Received: by 10.25.211.75 with SMTP id k72mr8444852lfg.45.1461325735875;
 Fri, 22 Apr 2016 04:48:55 -0700 (PDT)
Received: by 10.112.143.97 with HTTP; Fri, 22 Apr 2016 04:48:55 -0700 (PDT)
In-Reply-To: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292185>

sorry I forgot:

 $ git --version
git version 1.9.1


On Fri, Apr 22, 2016 at 1:46 PM, Daniele Segato
<daniele.segato@gmail.com> wrote:
> Hi,
>
> my coworker today claimed git stash deleted his files, I made him
> explain me what he did and I think it could actually be a bug even if
> happening only in a corner case better explained with code to
> reproduce:
>
> git init
> echo 'X' > foo
> git add foo
> git commit -m 'foo file committed'
>
>
> what follow is the corner case I'm talking about: he deleted the file=
,
> created a directory with THE SAME name and added lot of files in it,
> in this example I'll only add one
>
>
> rm foo
> mkdir foo
> echo 'B' > foo/bar
>
>
> at this point the working directory looks like this:
>
>  $ tree
> .
> =E2=94=94=E2=94=80=E2=94=80 foo
>     =E2=94=94=E2=94=80=E2=94=80 bar
>
> 1 directory, 1 file
>
>
> but apparently git status does not seem to see foo directory at all:
>
>
> $ git status
> On branch master
> Changes not staged for commit:
>
>           deleted:    foo
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
>
> I expected something more like:
>
>
> $ git status
> On branch master
> Changes not staged for commit:
>
>           deleted: foo
>
> Untracked files:
>
>           foo/
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
>
> Anyway he went on and decided to stash his work:
>
>
> git stash
>
>
> at this point stash deleted the "bar" file, in his case all the work
> on the previous couple of hours, but he didn't know yet
>
>
> $ git stash show stash@{0}
> foo | 1 -
> 1 file changed, 1 deletion(-)
>
>
> the foo directory was gone, replaced by the foo file
>
>
> git stash pop
>
>
> did not complained and deleted foo file again
>
>
> I know my co-worker shouldn't had created a directory with the same
> file he was deleting but I also think git shouldn't have allowed him
> to stash at all, or should have been cleaver enough to actually stash
> the directory with its files.
>
>
> Regards,
> Daniele Segato
