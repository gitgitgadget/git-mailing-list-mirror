From: Stefan Beller <sbeller@google.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Wed, 27 Apr 2016 09:08:22 -0700
Message-ID: <CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew J <andj2223@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:08:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avS0q-00033j-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbcD0QIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:08:25 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36133 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbcD0QIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:08:24 -0400
Received: by mail-io0-f182.google.com with SMTP id u185so58852763iod.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BEksaZRGjWFPqIhwoOTNS27qtLoYTrD8QdgUM0KR3hk=;
        b=pJMu9f8SKlwQos4ityPDSQopCnebEyrd98f+LeZr0yCHnD9AYYtPHMDtnxdwqcE3Dm
         WVMeegNkIE170uVgJEgHZSMymlorFB47EMjA7zZCbc1cPTeRqYGSdtrbsRuzJvRP3XnU
         twQkR315QmgpTXVaqhyQze4pv5zT4bsEeY1fTvIoNUY5vzzaL2l3YQ/TgZIHTmrPcRn0
         Y/i02PJiKmQ1eU/DW7ZdG9khR+PSYN/Wk4KcWqcECLToE6BZfe/NCCOJiOHukhetSbr5
         0Tfr3XQyDel6ZjgbURLqVsGkSnJv25cPNch9gL7EM8Ignx49hxIhB6lKrVgXTMiL8+Kt
         fxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BEksaZRGjWFPqIhwoOTNS27qtLoYTrD8QdgUM0KR3hk=;
        b=m8cPu49Qfg9qM43SVdswzh/pGMRQnJPT6AuL+X2xSN8CCLrb0CE7sTIR/g7RGYpYBc
         ag85/mVFwT6JoNHrELbpGMgvxQ0T140r0EOSnUN4KXSZbcN2IubFEPVX0H8byC+9xl8z
         o2GOxLiSNAyJBwCys+9QgbIJxHWOngjK4AMbgYklIH2VJGvOBbQgF5hcaR5LakFfdcec
         Zmr/oP+btFwCeklarw8UnmVwn5y/R8AakmBexYXf5GqfuRS3Hq8fqIkyruHAxriTVT1y
         EEzV0x1F1a+BI7Njkj7hSIE2URcnJ1CT8SCDAzXeLw6bKHVEhwWvhi3I7APOJEBx4YC3
         jrTg==
X-Gm-Message-State: AOPr4FUGKM7mWnS/bvdf5d8P1VhR6wY9ZH/91fbtVOSz9dwXeb1V6NYJaujYx5goPfiroAocSEzcP4xs3+yvdlKo
X-Received: by 10.107.161.68 with SMTP id k65mr12734893ioe.110.1461773303038;
 Wed, 27 Apr 2016 09:08:23 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 09:08:22 -0700 (PDT)
In-Reply-To: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292738>

On Wed, Apr 27, 2016 at 1:31 AM, Andrew J <andj2223@gmail.com> wrote:
> I've noticed some strangeness with git-add and nested repos.
>
> This tar.gz has a reproduction script, parent repo, and nested repo
> that exhibits the issue:
> https://drive.google.com/uc?export=download&id=0Bwjufq6oAZMfcGVxZ2dlMElEVlE
>
> If you extract the archive and do the following (on linux please, I
> haven't even tried this on Windows):
> cd git-add-bug
> ./bad-git-add.sh
> (Examine the script before running, please)
>
> It will echo what I'm encountering to the screen, so it should be
> straightforward to follow, but I will summarize here:
> If I run a git-add command where one or more of the files live in
> nested repositories, like so (command is shortened here, includes more
> files in the script):
> git add -v -f --
> src/chromium/src/third_party/libFuzzer/src/FuzzerInterface.h testfile
> As confirmed by git-status, this results in testfile being added, but
> FuzzerInterface.h not being added.
> FuzzerInterface.h is inside of a nested repository
> (src/chromium/src/third_party/libFuzzer/src/), while testfile is in
> the current main repository.
>
> On the other hand, the following command:
> git add -v -f -- src/chromium/src/third_party/libFuzzer/src/FuzzerInterface.h
> Results in FuzzerInterface.h being added, as confirmed by git-status.
> Excluding testfile from the git-add command seems to do the trick.
>
> My expectation:
> Both testfile and FuzzerInterface.h should be added if they are
> specified in the git-add command, regardless of whether they are
> specified along with another file that doesn't happen to live in a
> nested repository ("testfile" in this example).

I would call it a bug. [This use case is interesting for working with submodules
(though your nested repositories do not seem to be submodules), so worth
looking at for me.]

>
> If someone could help me understand what's going on here, I'd appreciate it.

I think (pure speculation), that it the error is in the context
(repository) switching logic.
What happens if you alter the order, i.e. give testfile first and then
the files in the nested
repos?

    git add -- file path/to/subdir/file

should do internally IMHO:

    git add file
    git -C path-to-subdir add file

Thanks,
Stefan

>
> Thanks,
>
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
