From: Loet Avramson <loet@forter.com>
Subject: Re: Submodule's .git file contains absolute path when created using
 'git clone --recursive'
Date: Thu, 5 May 2016 22:20:46 +0300
Message-ID: <CAK1enhO-2Ne4XVqRNXz+6Jd7uEEHde8-_xzwWzXh=b01bZhj0g@mail.gmail.com>
References: <loom.20160505T140253-275@post.gmane.org>
	<CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 21:20:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayOpQ-0002K7-BS
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbcEETUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:20:48 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33467 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbcEETUr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:20:47 -0400
Received: by mail-yw0-f178.google.com with SMTP id t10so157548717ywa.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forter-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tSKJ5Mxg94b7aFqz3a9C2dH49gIne9yvYQ7XZfpQu88=;
        b=gD+LH1wA1/rjtiYf6GOXwhctu3hLEtAOlcb/fEm435IFBmGqNrCh/jIQ00L7b82UZY
         G7eXHBLQMOzhnk84hEd18kU68tHSRzot8t8ww64n7JrzCW8A5t4rkjxiSNSFPCA9uVFC
         HhJ8fWkoThJH1F0UUfpoW6pvHBxoyZBC3pxe885hhD14xMw1eIO8GxK75chbA2VrabA1
         yl/31nJGuN3/z32IkBvXsEmfNr06J7sZ93l9D3RHRqFhv7WZ8Xn24wpF4Ua908PCsDXt
         7a9RaLduEA8gU/o8+gaPQvq5LrltQHME45MsFdo2leg6iLZqWIna2kfpRCx8zzUQHQUr
         5AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tSKJ5Mxg94b7aFqz3a9C2dH49gIne9yvYQ7XZfpQu88=;
        b=EuZRjkvgMGpWXw/W/q5DbHNR69WnOBUitm+RnOihOoNaNSDDGsK4PL/ui6ktM79Czq
         UbcsVC497yU5YX5sqrHKHbWL5ffxY9a4k2JdW6w8PzWp4YFrmYuYEPk3R/WkiYD2D9qN
         /nFe7P5ZE46IfSCkME9YMrkgJyQ46fepK22BmEgRE1YnzT7dTk4VG6KfiSYgD+HbIxzs
         EKuGWTFlgxJ6wOPFLtVDHIO6RlSlNJ1Pr+/As4VEtM1APVTnbvMLmCBG3BQ0xtLrEev2
         GrvqT7CTC+TNQarNRndzz+L8lenvi2a+P31c7zLhoIWjNSXH3rPdzqI8ZFUbGkFc54wZ
         ymQw==
X-Gm-Message-State: AOPr4FV6O4WTo8hWqwbiGdmog1wUzj+EdnID46V+KEMTYWdIzPct4LybrEftPmMuXqrulJ1KFNXBvxXlII+w3dkO
X-Received: by 10.159.33.234 with SMTP id 97mr10121846uac.90.1462476046498;
 Thu, 05 May 2016 12:20:46 -0700 (PDT)
Received: by 10.176.0.147 with HTTP; Thu, 5 May 2016 12:20:46 -0700 (PDT)
In-Reply-To: <CAGZ79kYmh9wtzXdThzPTdEZ5SsKznYxze6EvmbaZdGog4yydNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293664>

It happened on 2.8.1, also reproducible on 2.8.2.
Haven't had the time to dive deeper into the code but my guess is that
relative_path() returns different results in those 2 cases or maybe
the way git-submodule.sh handles it.

On Thu, May 5, 2016 at 8:22 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 5, 2016 at 5:51 AM, Loet Avramson <loet@forter.com> wrote:
>> Hi,
>>
>> According to git-clone man page - running 'git clone --recursive' "...is
>> equivalent to running 'git submodule update --init --recursive' immediately
>> after the clone is finished...", though I found a little difference between
>> the two regarding the submodule's .git file:
>>
>> 1. Running 'git clone' and 'git submodule update --init --recursive'
>> separately will create the .git file in each submodule containing a relative
>> path to the superproject's .git directory as expected.
>>
>> 2. Running 'git clone --recursive' will create the .git file containing an
>> *absolute* path to the superproject's .git directory. (as it was expected
>> using git versions 1.7.8 - 1.7.10 as far as I understand)
>>
>> Not sure if that's a bug but it got stuff behaving really weird in a specific
>> usecase on one of our environments. It would be highly appreciated to update
>> the docs at least.
>
> Which version of Git are you using?
>
> See[1] for how clone handles submodules. (It's a call to submodule
> update --init --recursive)
>
> There was a bug with recursive submodules in the 2.7 time frame and
> that got fixed in [2].
>
> So could you make sure your version of Git contains these fixes?
>
>
>
> [1] https://kernel.googlesource.com/pub/scm/git/git/+/master/builtin/clone.c#734
> [2] https://kernel.googlesource.com/pub/scm/git/git/+/7307dd898988c79fc687051e783b3cac8488a559
> specially https://kernel.googlesource.com/pub/scm/git/git/+/f8eaa0ba98b3bd9cb9035eba184a2d9806d30b27
>
>
>
>>
>> Thanks.
>>
>>  -Loet
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
