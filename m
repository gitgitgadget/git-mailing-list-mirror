From: John Szakmeister <john@szakmeister.net>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Sat, 22 Jun 2013 05:55:07 -0400
Message-ID: <CAEBDL5WYCdMEOsoXtxgfNDmJrkj2DR8DgTwKY72iUJjQyJ-bRw@mail.gmail.com>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
	<CAEBDL5UNNHnogHb2ztq2G8OxyCNMoLia7xYFNSy+kfHD3pS1pQ@mail.gmail.com>
	<7vli63mlro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 11:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqKXX-0007q7-KU
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 11:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab3FVJzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 05:55:10 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41161 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab3FVJzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 05:55:08 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so1295588wiv.8
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1Q5zMlB8x8ayPpwimMmNpdllcfF8QYZ2GBodiWZVSOI=;
        b=VP6xjPS33In6oAfzF498i+w+e019bnNzCaa25DamlqytorPsYohmbZ2tm58ss0ptNI
         vb+B3FkuetmSYw0UL8sMkdfWxPiVhmtlE97dOnqKqiXf5xhApCSs8eSg7ssXXLrtxSN7
         HTx3qN7C7RyVz3CYn24WZiQn96Rm/3+8CSZlx/0HcjTOtCB9uNgoMyCyCQMNkb0tTKPf
         gRe18El6O4+OynMnI3mDz9ngrpmWU630gWFcUPVm545OrU47x9p5XFtDfOwHDsFpSFEv
         RINQZOVUsPuImxDSM3txQ68W7e+hWleVeG0GHcEab3sTXF5FOp/1b6MSBqSgM+wssT+b
         Y6rA==
X-Received: by 10.180.75.110 with SMTP id b14mr1291582wiw.6.1371894907378;
 Sat, 22 Jun 2013 02:55:07 -0700 (PDT)
Received: by 10.180.24.5 with HTTP; Sat, 22 Jun 2013 02:55:07 -0700 (PDT)
In-Reply-To: <7vli63mlro.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: IiA5NfhIthmEJ5EOTQOQ4pAsHpM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228693>

On Fri, Jun 21, 2013 at 1:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Szakmeister <john@szakmeister.net> writes:
[snip]
>> I can see where this is confusing, but can also see how it's useful
>> information to have.  On clone, it's probably not that useful since
>> you're looking right at the url, but I could see that information
>> being more useful on a pull or push with the default arguments (when
>> the source and destination aren't quite as obvious).
>
> The "extra" error messages is not the first one, but the last one,
> and the suggested revert is a proposal to remove the latter, not the
> "repository $URL not found".

Sorry for the confusion.  I realize they were talking about removing
the remote helper line.  What I meant was that with the url there,
it's a bit easier to determine which part of git failed (http, hg, or
bzr remote helper, for instance).  What I was trying to say was
perhaps there are paths through here where it's really helpful to know
that things failed in the remote helper, so we may not want to
wholesale remove it.  Some of remote helpers, such as ones that talk
to foreign VCSes, do quite a bit more than just transfer data, so it
might be helpful to know that it's not core git that's failing but the
remote helper.  Seeing the URL is a reminder that you're interacting
with a remote helper, and it may not be helpful there.  But other
commands don't necessarily show that to you, and it may be more
helpful to have that reminder that it was a remote helper that failed.

I hope that makes more sense.

-John
