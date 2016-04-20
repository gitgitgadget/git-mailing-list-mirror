From: Stefan Beller <sbeller@google.com>
Subject: Re: problems serving non-bare repos with submodules over http
Date: Wed, 20 Apr 2016 09:14:08 -0700
Message-ID: <CAGZ79kYS-F1yKpNP7jmhTiZT1R_pucUBBTCbmHKZz6Xd6dy8EA@mail.gmail.com>
References: <20160420152209.GH23764@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Gurus hangout <git@vger.kernel.org>,
	Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>, Jens Lehmann <Jens.Lehmann@web.de>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asulc-0007ZY-LA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbcDTQOL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 12:14:11 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34045 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDTQOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 12:14:10 -0400
Received: by mail-io0-f173.google.com with SMTP id 2so57418856ioy.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=m/eDIDoLRfKme+AoYuhMGVgF9nvru2TMXFTirObv7iQ=;
        b=OvpEElGbL6yYXj6plKkEhefxL5seLfuZPXyRJD8oCEHpuC0GvAQwoy9Elvmblx7KiT
         +vlkKO2IwfoGuIva1QO/CmtGxcJSSTBvUxhlkHzUFIPGN7sLfiNxaC3/iJ0pEa0nIqEr
         trg/PabXZN9r7YGrXNkXOjT+Y6/lsLYbRvyc9+k2eJWP8zar9H9LKerU5vcWjQmosmzV
         DZuqiLtz6uoJcgqmsJ2JdGHP01CXlCI2B7IQHaPsc8mQmkbDAoHP3iD1+nb3mA6vVT+S
         ul5WfG6CrM7eXQec4wuDkpVbxZvoKpjsKXmlM6z1rbSXOFLIFHQkXj/G8Yz5LfC66jD6
         aGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=m/eDIDoLRfKme+AoYuhMGVgF9nvru2TMXFTirObv7iQ=;
        b=aKfR1wAeGJMZuBmblpqLLL1mqTuB/EQJt0Tazb6hqBUzP112FiB+pcwqxnCz8EOiF0
         46Nu9RiRNW7C9s4RUB83dJqwUei+RGZ2H9dhw6aOdlAPUYmvDgOdV/FtVNrLU7zlUEY4
         sbvw5wI+Aks+B9eG7DttQ6Pib/2Q2e59t7dr4uO1xOt02n50pHMRK9hFa5liaqULuX10
         e4gDTtQ0jBVl3GpvVWQ1mD938AaGEfVzVSL4Qs8OFGYr5KMpLzd46w2qnfn/NtBSb5kB
         jJPb9/4SfVRMAisCw1LWHLzRRv7iZzaONUKNGx784vv3yzcZISWxJjNtDi+iIOj0kcRI
         c6oQ==
X-Gm-Message-State: AOPr4FWV0Z87vyiByT4XAuJj7KCWqWoPaHiyYHmUsXaZLTNLU0sfZyqH17Z/0xrd1o+INI7T2DWGn/LXpBLx9E+c
X-Received: by 10.107.53.200 with SMTP id k69mr3705449ioo.174.1461168848873;
 Wed, 20 Apr 2016 09:14:08 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 20 Apr 2016 09:14:08 -0700 (PDT)
In-Reply-To: <20160420152209.GH23764@onerussian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292037>

On Wed, Apr 20, 2016 at 8:22 AM, Yaroslav Halchenko <yoh@onerussian.com=
> wrote:
> Dear Git Folks,
>
> I do realize that the situation is quite uncommon, partially I guess =
due
> to git submodules mechanism flexibility and power on one hand and
> under-use (imho) on the other, which leads to discovery of regression=
s
> [e.g. 1] and corner cases as mine.

Thanks for fixing the under-use and reporting bugs. :)

>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/288064
> [2] http://www.onerussian.com/tmp/git-web-submodules.sh
>
> My use case:  We are trying to serve a git repository with submodules
> specified with relative paths over http from a simple web server.  Wi=
th a demo
> case and submodule specification [complete script to reproduce includ=
ing the
> webserver using python is at 2] such as
>
> (git)hopa:/tmp/gitxxmsxYFO[master]git
> $> tree
> .
> =E2=94=9C=E2=94=80=E2=94=80 f1
> =E2=94=94=E2=94=80=E2=94=80 sub1
>     =E2=94=94=E2=94=80=E2=94=80 f2
>
> $> cat .gitmodules
> [submodule "sub1"]
>     path =3D sub1
>     url =3D ./sub1
>
>
> 1. After cloning
>
>     git clone http://localhost:8080/.git
>
>    I cannot 'submodule update' the sub1 in the clone since its url af=
ter
>    'submodule init' would be  http://localhost:8080/.git/sub1 .  If I=
 manually fix
>    it up -- it seems to proceed normally since in original repository=
 I have
>    sub1/.git/ directory and not the "gitlink" for that submodule.

So the expected URL would be  http://localhost:8080/sub1/.git ?

I thought you could leave out the .git prefix, i.e. you can type

     git clone http://localhost:8080

and Git will recognize the missing .git and try that as well. The relat=
ive URL
would then be constructed as http://localhost:8080/sub1, which will use=
 the
same mechanism to find the missing .git ending.

>
> 2. If I serve the clone [2 demos that too] itself, there is no easy r=
emedy at
>    all since sub1/.git is not a directory but a gitlink.

Not sure I understand the second question.

>
> N.B. I haven't approached nested submodules case yet in [2]
>
> I wondered
>
> a. could 'git clone' (probably actually some relevant helper used by =
fetch
>    etc) acquire ability to sense for URL/.git if URL itself doesn't p=
oint to a
>    usable git repository?

So you mean in case of relative submodules, we need to take the parent
url, and remove the ".git" at the end and try again if we cannot find
the submodule?

>
>     I think this could provide complete remedy for 1 since then relat=
ive urls
>     would be properly assembled, with similar 'sensing' for /.git for=
 the final urls
>
>     I guess we could do it with rewrites/forwards on the "server side=
",
>     but it wouldn't be generally acceptable solution.
>
> b. is there a better or already existing way to remedy my situation?
>
> c. shouldn't "git clone" (or the relevant helper) be aware of remote
>    /.git possibly being a gitlink file within submodule?

Oh. I think that non-bare repositories including submodules are not des=
igned
to be cloned, because they are for use in the file system. Even a
local clone fails:

    # gerrit is a project I know which also has submodules:
    git clone --recurse-submodules https://gerrit.googlesource.com/gerr=
it g1
    git clone --recurse-submodules g1 g2
    ...
fatal: clone of '...' into submodule path '...' failed

So I think for cloning repositories you want to have each repository
as its own thing (bare or non bare).

The submodule mechanism is just a way to express a relation between
the reositories, it's like composing them together, but by that composi=
tion
it breaks the properties of each repository to be easily clonable.

I think we should fix that.

I guess the local clone case is 'easy' as you only need
to handle the link instead of directory thing correctly.

=46or the case you describe (cloning from a remote, whether it is http =
or ssh),
we would need to discuss security implications I would assume? It sound=
s
scary at first to follow a random git link to the outer space of the re=
pository.
(A similar thing is that you cannot have symlinks in a git repository p=
ointing
outside of it, IIRC? At least that was fishy.)

Thanks,
Stefan

>
>
> Thank you in advance for your thoughts and feedback on this case.
>
> P.S. Please maintain the CC list in replies.
> --
> Yaroslav O. Halchenko
> Center for Open Neuroscience     http://centerforopenneuroscience.org
> Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
> Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
> WWW:   http://www.linkedin.com/in/yarik
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
