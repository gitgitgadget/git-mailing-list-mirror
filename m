From: Stefan Beller <sbeller@google.com>
Subject: Re: --progress option for git submodule update?
Date: Wed, 9 Sep 2015 16:40:32 -0700
Message-ID: <CAGZ79kYRYqVE35_i5+DvqOj7G6LvhBQgsQok5gabLY6x20F80w@mail.gmail.com>
References: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Vitali Lovich <vlovich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 01:40:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZoyk-000153-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 01:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbbIIXkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 19:40:35 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35518 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbIIXkd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 19:40:33 -0400
Received: by ykdu9 with SMTP id u9so40942921ykd.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ANYzPHbMywXe+g7fn8FfHtpsdMlmnx89fOqLTF0EC+k=;
        b=WhMtBPoSfqKFKuvWSyvrd3YlDmoUXnOU0ZkdoJtRXj5j+vLndZ0PVuxodUyjIimr2A
         uQ5FYeck/6ipsERdJXdrpHef06/9pcuJm2/EgklcOlXMmj/sSiZy396OJ2hF62LPO6Qo
         D3epKhw8iR89E7c2aDhY/a4zvbcVd8eofqB4wLXaeANxKHMerReMEdz3iUdV31TZMVU2
         pnf0IXAVs8lZCMsh6fD1SS30O4jHPCg8KERKTfd+Ce2vX5RtBXNKqhNLl1wdHp7T6jB/
         l7GCN1XtR52x1FeC1D/b6+tWap6wdqtDiU8RVCHQdkuDsx8PFvYZjbEwnCVvCB/XjeGm
         SzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ANYzPHbMywXe+g7fn8FfHtpsdMlmnx89fOqLTF0EC+k=;
        b=Y5sI/8B5LrincyC1AD0bzf/TZz7d5WmrcbJgGzsp/uPIJpO28szWv5gaGSJbVXh52O
         IQ1zaJ+BK78TeaAVcfH4XzTNXKjtnjRloWJ97mddGGhcHVsnpdfDgKyS1hj10ITJnupa
         lPRXsWFCEPQW/ZJ1UCGdpfzWYS/aTkuAcZP5bzPVmSkAv+5qUCHz6tk9hJg9MAE+WGRA
         K9yFBblqXoquaL53aJY6JHzWiO++6CD9nZkWbrEcyeFqZDbe79tLs9wO6cxcK4zCGVtr
         sbE3enBCDjzbWixkz9U4Hi7mnwt1xDP1tV1bpMwjt7e43V1MwU3l9I2/qA3binfmvHEg
         3nJQ==
X-Gm-Message-State: ALoCoQlv4fLJ6UxHzSCMQY1lWYo/+I9M135WaViwM77uGeCWViZlZTvlMxWo8o2xay0oHTO0V1tT
X-Received: by 10.170.196.201 with SMTP id n192mr40180591yke.16.1441842032926;
 Wed, 09 Sep 2015 16:40:32 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 9 Sep 2015 16:40:32 -0700 (PDT)
In-Reply-To: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277569>

So submodules...

I am currently working on improving submodules (some basic performance
improvements have been done, soon to be merged upstream, I currently
try to get parallelism working for git fetch --recurse-submodules and f=
or
git submodule update eventually. I sent some early working patches for =
that,
but I am doing a whole new redesign without threads now).

On Wed, Sep 9, 2015 at 3:52 PM, Vitali Lovich <vlovich@gmail.com> wrote=
:
> Hi,
>
> Git submodule doesn=E2=80=99t have a --progress option like regular c=
lone/fetch does.  This means that it can hang a long time without outpu=
t as it=E2=80=99s transferring data, particularly for large repositorie=
s.

=46or repositories with nested submodules it is impossible to estimate
the progress because you don't know how many there are.
Say you have a layout like:

A
 -> B
-> C
-> D
    -> E
    -> F

whereas each letter is a repository and B,C,D are submodules of A and
E,F are submodules of D.
So if D is not cloned yet, it looks like A has only 3 submodules, but
in fact we need to update 5
submodules.

> This is problematic in automation scenarios where there can be upper-=
bounds on how long a process may run without any output (to protect aga=
inst processes hanging for long periods of time without forward progres=
s).

Maybe a better error-out-if-hanging would be better IMHO ?
Another option would be to enumerate the submodules and give the
currently estimated upper bound ?

Doh! I see what you're missing now after rereading the email closely.
You can add a --quiet option,
but --verbose or --progress just errors out, but you want that as a
possible argument for git clone
inside the git submodule update code.

Thanks,
Stefan

>
> I=E2=80=99m sure this has been asked for before but having this optio=
n would be really nice for automation system (like buildbot) to take ad=
vantage of.  The only alternative is a hacky solution to clone locally =
first with the =E2=80=94progress option
> & then somehow set up the submodule to use the local clone as a refer=
ence.
>
> Thanks,
> Vitali--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
