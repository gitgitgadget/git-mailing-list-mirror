From: Stefan Beller <sbeller@google.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 09:54:23 -0700
Message-ID: <CAGZ79ka0WB58HyHYXAkaMYKccWD-NwSxhRUGHvq1TrA_ix+Hxw@mail.gmail.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	<xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew J <andj2223@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:54:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avpCv-0008R3-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbcD1Qy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:54:26 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35067 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcD1QyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:54:25 -0400
Received: by mail-io0-f180.google.com with SMTP id d62so82929527iof.2
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=CmyUzVc6z7NITX06T+LHxxMb7+szW2WAcF4MxQEn52g=;
        b=B+M+HuMbNWV4soWMRgQcmACX9DKnO9GI+Dln/JRbInYUQ3bp9IMG9w3gmBJdOF3VYf
         SUSKzfw00bGgyJihHVQ7KH9tBc6IFveLM5kMAHoKk2KG18onIpdemzCeRswlZoFV8ytu
         zBq3mwAoBKFe/CV03OLPUV47SPoHYl8zgq6gRV6nKMGR0XGTWcTFBhZ5vUBoAyn6gAkF
         Ms7yIhED/WItmOAuUT0oF5JVgZiu8CipLjzwd+3sKHCCUJlzdjGsjcao6/COIi/b24Sb
         bOirqK9eXZa3ck3g9qKNOse4PI/PBcxRNaTAowEuHp0hB49l6fXo6GO02fZjTg2H9Ytq
         zUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CmyUzVc6z7NITX06T+LHxxMb7+szW2WAcF4MxQEn52g=;
        b=BHbWBzDwbd5IlxKFcLJcbI+1ba/54WfTpDBKGfMhJRjoat4Z33FEZDIJbTmkizQzri
         wv4qMXq1BRa5gSgo1hgaWLskQMFGTrVMaPHDmETxt+yFmUMAbtmSvMXgQkgywOG/h25+
         hxGSDAvvSGHoXTl0zjIEnFVdZkjHT8dWR55btEjGjfj+VlfYGooqgkDgzz/+agndj64w
         fV5sTmR25wGV+oWTevsFNqAXvYdMe3WWtcJdnFVrtJfKhVJ4huciNNb2WCq6KAy4QdoX
         3EU+jKIDlHJF/++V3Qv9O/dx4f0fua0LR6YKN2imiuWed4AIhsdfhUFm9FlTuWrJ8lJG
         6LAg==
X-Gm-Message-State: AOPr4FXU9aJbb0lbBivQiaSSY/JGdr98IUQd1kzOx6rxgr1rDktxdM1fE/WH3644x6Tj9Tw8Vrf71inn2ZsKhXPa
X-Received: by 10.107.174.205 with SMTP id n74mr18726176ioo.96.1461862464039;
 Thu, 28 Apr 2016 09:54:24 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 09:54:23 -0700 (PDT)
In-Reply-To: <xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292921>

On Thu, Apr 28, 2016 at 9:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> I think (pure speculation), that it the error is in the context
>> (repository) switching logic.
>> What happens if you alter the order, i.e. give testfile first and then
>> the files in the nested
>> repos?
>>
>>     git add -- file path/to/subdir/file
>>
>> should do internally IMHO:
>>
>>     git add file
>>     git -C path-to-subdir add file
>
> My undertanding of what _should_ happen in the world order as
> currently defined (not necessarily implemented) is:
>
>  * "git add -- A B" must work the same way as "git add -- B A" and
>    "git add -- A; git add -- B"

I agree.

>
>  * "git add -- path/to/subdir/file", when any of path/, path/to/,
>    path/to/subdir/ is a Git repository that is different from the
>    current Git repository, must fail.

I agree that this is the current expectation for the world order.
However I would like to propose to change that eventually.
(Once the submodule groups are there and we can treat
submodules as a special form of narrow checkout, we want to
have the feature of adding across submodules and even committing
across submodules/repos, I would think)

>
> IOW, if 'path' is a repository (whether it is known as a submodule
> to the repository whose working tree contains it, or it is an
> untracked directory from the containing repository's point of view),
> the index of the containing repository cannot get path/$anything in
> it.  If you managed to do so, you found a bug [*1*].
>
> path/.git/index can of course have "to/subdir/file" in it, and from
> that point of view, "git -C path/to/subdir add file" may one day
> become an improved world order.  It is just we haven't discussed
> that possibility or reached concensus that it is a good idea.
>
>
> [Footnote]
>
> *1* Of course, some of the bugs in this class may fundamentally be
>     unfixable and would fall into the same category as "doctor, it
>     hurts when I do this--don't do it then".  For example, you may
>     treat path/ as the top of the working tree of another repository
>     whose git-dir is not at path/.git by arranging GIT_WORK_TREE and
>     GIT_DIR environment variables, but you may do so only when you
>     actually are accessing the contents of path/ as its own project.
>     And when you are using the enclosing project (whose .git/ would
>     sit next to path/), there is no way for "git add path/to/file"
>     to know that everything under "path/" does not belong to the
>     current repository and instead it is part of the project rooted
>     at path/, which is an obvious example of "fundamentally
>     unfixable" case.
>
