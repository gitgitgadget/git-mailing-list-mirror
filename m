From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Ignore dirty submodule states during stash
Date: Mon, 16 May 2016 09:09:40 -0700
Message-ID: <CAGZ79kZESuKiEt2RJJdWJPBySgbDA6abGkZMiTFgzaNCUP1_mA@mail.gmail.com>
References: <20160516020735.GA7884@gmail.com>
	<CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com>
	<20160516154606.GA8797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Vasily Titskiy <qehgt0@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon May 16 18:09:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2L5W-0003z7-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbcEPQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:09:42 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36325 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbcEPQJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:09:41 -0400
Received: by mail-io0-f180.google.com with SMTP id i75so210209305ioa.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=xYW/k5nikQTLUWa+aP2jb/c7Dpfo9DJFxC2c5SweXpY=;
        b=m/tpwhKyqEC35fNu7j/MsjkuNz+sG0ePuyO44PYNpUod2xZlC9VcbHcCrk0dLVjQVB
         9F5JrybYYayinY1Yqz0+NRz+7wMEA/DV6uAtsKILQ3teDHydMWj/eDEm7b5yPJLq09cs
         dOVKwQZ1XUWrCR00ODkVrQGh7+Np/NFUWyOSPO/494ZLp9Wal2VNSG11pJ0si60POkwl
         6/Q/GEgLPrKlgBmhDJBpX1+00BxNP7TwnEnPGyFyoxwF6XqlC10j3nWRZq5Ov1CGO6FN
         jEW2FSl+dhj3QQ2ucg8gg+E7iudnXlEKGD0sSROU7nJRzmcJj/Rejgf60C48eBOr84W3
         YvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xYW/k5nikQTLUWa+aP2jb/c7Dpfo9DJFxC2c5SweXpY=;
        b=N9McTVNd7k9R29TJ8DarlABcgumuIIxU4piKdPYgNWI89nPvwJ3r5cWxJeDNLqQWMw
         BJFsLuHzoXdE7IEoKACO1W0LUe5XOxjOFqrkjqTZoVuVIA+5UW5YIWGMkhDmlQWzsDXj
         xv+Umt2l7l+24o1dHVAEwIDOk6W1SEbfar2OBpGGA42mZE2LDekAMLaEuVKb7Q1V8eUc
         CAwG5NYEtFgG/ljaH2OwHT/niR6cIydpB53QYA0c5uZGb/pD6CfHtORTiy8p35t9Bvto
         5595RySs/DA0Mn9kBgkI/Sx/57fsrxB5onhTL3LNzaUTHM1tniClEsQk8QNzbAwHD/ze
         e7cw==
X-Gm-Message-State: AOPr4FXCh9IFKjm5YWpgKujqVfwjbUN2TqLiqYzdc5YoW8PM+mSJq7VSCcv56+2bzG59+beT+zToOVcQPiPRYPq2
X-Received: by 10.36.253.9 with SMTP id m9mr10593533ith.52.1463414980705; Mon,
 16 May 2016 09:09:40 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 09:09:40 -0700 (PDT)
In-Reply-To: <20160516154606.GA8797@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294749>

On Mon, May 16, 2016 at 8:46 AM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> Hi Stefan,
>
> On Sun, May 15, 2016 at 11:37:20PM -0700, Stefan Beller wrote:
>> On Sun, May 15, 2016 at 7:07 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
>> > Do not save states of submodules as stash should ignore it.
>>
>> Can you explain why this is a good idea?
>> (It is not obvious to me either way.)
> Actually, submodules are already ignored by stash, but not fully (it was introduced in commit 6848d58).
> Current behavior is counter-intuitive, for example (if one has a project with a submodule):
>  $ cd sub1
>  $ edit .. commit .. edit .. commit. Alternatively, just checkout some other commit
>  $ cd .. # back to main project
>  $ git stash save
>    No local changes to save
>  $ # so, stash declares there are no changes
>  $ edit main.cpp
>  $ # For example, I need to update my working tree to latest master
>  $ git stash save # save local changes of 'main.cpp'...
>  $ git pull --recurse-submodules && git submodule update --recursive # update to latest
>  $ git stash pop # I expect to get stashed changes for 'main.cpp', but...
>    warning: Failed to merge submodule sub1 (commits don't follow merge-base)
>    Auto-merging sub1
>    CONFLICT (submodule): Merge conflict in sub1
>
> So, this is the issue. Instead of getting my local changes, I got a conflict (and stash is not
> poped out). The root cause is the 'stash' command does not know how to deal with submodules,
> but currently it tries to save the state of submodules, and even tries to re-apply the state
> (and it fails of course). The proposed solution fixes this behaviour.
>
> All internal tests work fine with the change.

I think you could take the example as above and make it into a test?
Showing that this change actually fixes a bug.

Looking for a good place, I would have expected t/t3906-stash-submodule.sh
would be a good place to put your code, but I am not sure how to
properly integrate that test there.

Maybe we can put the test in t3903 instead?

>
>
>>
>> Do we need a test/documentation updates for this?
> I don't think so, 'stash' have never claimed submodule support.

But it also never explicitly claimed it doesn't support it.

Maybe we want to squash in something like
(with better wording):

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 92df596..b2649eb 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -41,6 +41,8 @@ the usual reflog syntax (e.g. `stash@{0}` is the most recently
 created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible).

+Stashing ignores submodule operations completely.
+
 OPTIONS
 -------


Thanks,
Stefan



>
>>
>> >
>> > Signed-off-by: Vasily Titskiy <qehgt0@gmail.com>
>> > ---
>> >  git-stash.sh | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/git-stash.sh b/git-stash.sh
>> > index c7c65e2..b500c44 100755
>> > --- a/git-stash.sh
>> > +++ b/git-stash.sh
>> > @@ -116,7 +116,7 @@ create_stash () {
>> >                         git read-tree --index-output="$TMPindex" -m $i_tree &&
>> >                         GIT_INDEX_FILE="$TMPindex" &&
>> >                         export GIT_INDEX_FILE &&
>> > -                       git diff --name-only -z HEAD -- >"$TMP-stagenames" &&
>> > +                       git diff --name-only --ignore-submodules -z HEAD -- >"$TMP-stagenames" &&
>> >                         git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
>> >                         git write-tree &&
>> >                         rm -f "$TMPindex"
>> > --
>> > 2.1.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe git" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
