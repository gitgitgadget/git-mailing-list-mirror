From: Stefan Beller <sbeller@google.com>
Subject: Re: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 15:22:34 -0700
Message-ID: <CAGZ79ka0XvmvVpX5WrpeEBXBWKA41RTZm4p7q=QtUTFy18hkoA@mail.gmail.com>
References: <87a8r4ary9.fsf@kyleam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kyle Meyer <kyle@kyleam.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrCdp-0001s5-H8
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbbJ0WWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:22:38 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35383 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbJ0WWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 18:22:34 -0400
Received: by ykek133 with SMTP id k133so52521252yke.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=04EmwYAIiqjD9TsXL9i0k9ysG5A1h66fqgRic+sqVNs=;
        b=OBt0eOKYZAFPzPcmyJpE2hzkyA+01uhbSZcJxaOwot7P4Wa+lMLH7epj8y4273oL34
         suBnkSAxJOiLdOvbtuYhMffRVdnvyAvGSYQeCPp+UorVj2MU9V35HQrXzXAOvz/HX0G8
         0BTy33V1kv0f6UnjYO9yVoi+0yGgr1tu9afKLI6EfnRlZOS3lqDGka3JEqMgzpjxOUW2
         WFYPsBW4pgGwkauAFPs3FelrZf4tjcXdeYxOljKG9OO/Tyf1folSsqgDTNli1K2QAtqT
         koXkNk3ByTRgO7GGR//ThDI0LolJXuOPX5ZVixNOQ5HawjoKq0S7CKvS6fo2qLx73JhN
         K1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=04EmwYAIiqjD9TsXL9i0k9ysG5A1h66fqgRic+sqVNs=;
        b=fDLaQGIQkZ9XsKWwd424dR20clLpwEtMniyEqrYCPOrVOK/MMkxOSUdkmFxJT0HGey
         LyMr577VgtV3+7PU0RthPAZoxqCp5FppkNuBZmCLKWlQtv+7Ob/KGN9D58m513BBYFCA
         LujV48iz0Utn8D+3hv+Ksus8dMZdHIzd111P032iDl+zRETQUTBuAbcj44vvSfEtCJo0
         O91aps6YnfYAWoDIDzCG4fuuB5YXc8I3tVgITDznIORHb3Pt0D4cvT5J5Lt91iwZ2D9E
         HE14vzAUtWHCR8iloSALX+vNWZWaWPAlPsgX1wOO4FRu1Fb+0GLZPoc5T0KR5BAIBHdG
         uSqw==
X-Gm-Message-State: ALoCoQnyBBfG6IXyJ6BFK/p8uAnU7xmHf7mK3joi/0xX/y5RGSE5JVD2/nmti058cLHjphgerqrl
X-Received: by 10.13.230.194 with SMTP id p185mr21541479ywe.320.1445984554098;
 Tue, 27 Oct 2015 15:22:34 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 27 Oct 2015 15:22:34 -0700 (PDT)
In-Reply-To: <87a8r4ary9.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280308>

On Tue, Oct 27, 2015 at 3:04 PM, Kyle Meyer <kyle@kyleam.com> wrote:
> Hello,
>
> When a ".git" file points to another repo, a ".git/gitdir" file is
> created in that repo.
>
> For example, running
>
>     $ mkdir repo-a repo-b
>     $ cd repo-a
>     $ git init
>     $ cd ../repo-b
>     $ echo "gitdir: ../repo-a/.git" > .git
>     $ git status
>
> results in a file "repo-a/.git/gitdir" that contains
>
>     $ cat repo-a/.git/gitdir
>     .git
>
> I don't see this file mentioned in the gitrepository-layout manpage,
> and my searches haven't turned up any information on it.  What's the
> purpose of ".git/gitdir"?  Are there cases where it will contain
> something other than ".git"?
>
> Thanks.

It's designed for submodules to work IIUC.

Back in the day each git submodule had its own .git directory
keeping its local objects.

Nowadays the repository of submodule <name> is kept in the superprojects
.git/modules/<name> directory.

If you are in the submodule however you need to know where the repository is,
so we have a file pointing at ../<up until superprojects root
dir>/.git/modules/<name> directory.

If not using submodules, I'd expect that file to not be there.
If you have a file .git/gitdir which points to plain .git, this is
technically correct,
indicating where to find the repository (containing objects etc).

>
> --
> Kyle
> git version 2.6.1
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
