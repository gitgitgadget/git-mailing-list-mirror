Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E63C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F152320748
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 06:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyJVYPlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCaGBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:01:21 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:35542 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgCaGBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 02:01:21 -0400
Received: by mail-pj1-f54.google.com with SMTP id g9so627493pjp.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Q+kzf+kj4DeZdyfhgOn2SzwV8qS4dti6L5hjEKmaIJE=;
        b=dyJVYPlupJcZirLVGWhpgTXGNpOSQf/KU8Xq3IrkU1ssm9JQhMfTW97Ddc2pW58wp5
         vRtRl39feTnb046YsaE1L/b45kKCvIjOinU1Eetihy7h9ITatLyfcqTI+4tSGVyw+8oF
         IKU8FhiCJi6QwjmY36LoMgXsBrUvRCjlAm+QzI0TzrqVwxz2sCAeudlAAWiEXoZe1nQJ
         aWCe3/nMCfPIcW0s02VODnlkA3p+Qs73cpmXaozT12MnN8HF9ra8HESUQ3PdoV77XeNs
         RVnEO9fWdQwqdiq4m2p6FFl4rFwPRttEscU7cKOnsyiI9JunO4CDWLv255KXDrE0IR7a
         icFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Q+kzf+kj4DeZdyfhgOn2SzwV8qS4dti6L5hjEKmaIJE=;
        b=JVCQV6WAkKA3jLCGRJ2DZk+h37jR20F0U133liFd4GE/j/FDMk319YXiJ4tz4DAgeC
         Inhi9XCruSzkwFWX1+zTlehftORzoknfGAN8R8IGULuTRg+mgj2iKrU5+xF3PaojUNwn
         qQEq+9F4t26VoRgT0k2DsYeF7YX/4NjiIQRVfur/e0G3+BuWeUsJU7WWYeieoO5OU7P5
         wIC22St500658I3zBxLQHwZ+9SWTC5S+vCWqrAq7XVokxXulC60Pl15xw0TzB6zQNZTm
         zO9bK44pkNnA/svcD5AIaXqiLMxPdZPs/qVBn3qtvTI/0G5DeEnEpMUK8ucCJ9cMKgPQ
         y7RQ==
X-Gm-Message-State: AGi0PuZvl3ieaqHLQSeAbdb7soBPmiJXdMgHsnTaQB6byo6+6KQvsN0Q
        IhsRw7qbgkHRp8mHeANHRlNk+aE35oo=
X-Google-Smtp-Source: APiQypLMz7ArRNSt0+KHPg6lycVjOFsdGVZpCR5wcmly2T0NBbZ8CYUkRCrYotXeWaSS83vugQoS8g==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr1897590pjb.167.1585634480105;
        Mon, 30 Mar 2020 23:01:20 -0700 (PDT)
Received: from [192.168.0.10] (host-219-69-92-114.static.kbtelecom.net. [219.69.92.114])
        by smtp.gmail.com with ESMTPSA id 66sm11740130pfb.150.2020.03.30.23.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 23:01:19 -0700 (PDT)
To:     git@vger.kernel.org
Cc:     abhishekkumar8222@gmail.com
From:   Angel Pan <dinoallosaurus1111@gmail.com>
Subject: [GSoC/Proposal v2] Unify ref-filter formats with other --pretty
 formats
Message-ID: <7d96914e-bf2e-bfe0-74fa-a9524b81d606@gmail.com>
Date:   Tue, 31 Mar 2020 14:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Big thanks to those who have spent some time reading my proposal.
Special mention toAbhishek, who corrected some of my error and provided
with some useful advice. ;)

Here is version II:

https://docs.google.com/document/d/19Nkesmet7X7U42lsvksXoiEBrnOppKicWHYKneEQsQ8/edit?usp=sharing

---

# Unify ref-filter formats with other `--pretty` formats

## Contact Information

Full name: Yun Pan(Angel Pan)

Email: [dinoallosaurus1111@gmail.com](mailto:dinoallosaurus1111@gmail.com)

IRC: dinoallosaurus

GitHub: dinoallo

Timezone: UTC+8

## Short Biography

I am a first year student in Computer Science at Zhejiang University in
China. It's my first time participating in GSoC. I have had experience
working with C/C++, shell scripts, Python, Go and Perl. I am interested
in writing CLI or system scripts/configurations, which is the main
reason I am applying to Git project. I might be relatively new when it
comes to contributing open-source project. However, I am a quick and
avid learner so if I don’t have enough skills to complete the job, I can
self-learn immediately.

## Working Environment

My operating system is Arch Linux, which I started using it about half
an year ago. Before then I was using Debian-based systems like Ubuntu.
And I have some experience using git on Windows as well.  

I mainly use Emacs and VS Code as my editor but I can use Vim also. I am
able to use both markdown and Org-mode on Emacs for documenting

## Coding/Contributing Experience

C is my *native* language I like to configure my computer and automate
some work on it by myself so I learned shell-scripts and other scripting
languages.  Now I write code related to back-end for the student club at
my university.

Since I used to develop web before, there is a small-project written in
Python with Django on my GitHub page. From the experience of applying to
git, I obtained much deeper knowledge about git and how it works. No
matter what the outcome is, I am looking forward to contributing more to
git and work with all the developers.

### Microproject

Mailing list:
https://lore.kernel.org/git/pull.595.git.1585588586605.gitgitgadget@gmail.com/T/#u

GitHub: https://github.com/gitgitgadget/git/pull/595

Status: Reviewed and now revised(the commit message).

## Introduction

Currently, the placeholder used in ref-filter expansion `%(foo)` has not
yet supported in `--pretty` format.

Using the new ref-filter formats has its own convenience.  For example,
the format `%(foo)` is more human-readable, easy to process, and
extensible if we want to add some options in each placeholder(like
`%(trailers:only=bogo)`) . Hence,  users can just simply add the options
in the placeholder if needed, reducing their frustration in constructing
long and complex output command.

My goal is to unify the the ref-filter formats with `--pretty` formats
and generalize them in git:

### Primary task(s)

* Keep the previous placeholders like `%an`, but add more recognizable
alternatives like `%(authorname)`.
* Check if there are other duplicate formats with `--pretty` , if so,
re-factor them as well.

### Optional task(s)

I don't want to go beyond the border of my main task, so I label this
idea as an optional task that needs to be carefully reviewed and
discussed by many.

* Introduce format-scripting(like the one used in `git-for-each-ref`) to
`--pretty` and even make a field in user's configuration to use default
format-script for `--pretty`.

## Deliverables/Timeline

### ~ May 5th

* I will keep an eye on git project and make more patches to it if
possible.
* At the same time, getting to know more about the community and
collaborating with others.

* Also I will talk to my potential mentor, to get more concrete and
constructive advise about my project. Last, finalize my project.

### May 5th ~ June 2nd

Community-bonding period:

After having rounded understanding about the community and all the past
work, I would like to revise my previous ideas regarding to my project
if there is a much better solution or other problems. Then, I will start
to work on a part of my project:

* Carefully examine `ref-filter` related code to see what I can learn
from(the implementation, etc...) and what to avoid doing.
* Add new placeholders with new formats and names in `--pretty`.
* Commit patches to obtain reviews from the community.

### June 2nd ~ June 10th

The cushion period. Finish the unfinished job from last phase. If all
the job is done, add test scripts and future documentation.

### June 11th ~ July 3rd

I will be occupied in this phase since the final exams take over. I
might not be able to work on some actual change but will be free to
reply to anyone in the community.

### July 3rd ~ July 17th

* Gathering all reviews and criticisms from the community and revise my
previous patches if needed.  

* Add test scripts and documentation.

### July 17th ~ July 28th

* keep commit the patches to obtain reviews from the community.
* Discuss the possibility of adding configuration for `--pretty`.

### July 28th ~ August 12th

* Gathering all reviews and criticisms from the community and revise my
previous patches if needed.  
* Add test scripts and documentation.
* [option] Write a experimental configuration on pretty.

### August 12th ~ August 25th

Final revision and discussion.

### August 25th ~

Submission

*If I complete my job earlier than I plan, than I would like to come up
with more improvements and new features in my project.*

 ### Side-note

* Before my summer vacation, I can code for 2-3 hours per working day
and 4-6 hours on weekend.
* My summer vacation starts from July 3rd to early September, which fits
well with GSoC's schedule. I will be able to spend half of my day on my
project.
* English is not my first language so if I have grammatical or other
errors in documentation or communication, a review will be appreciated.



## Conclusion

First, I would like to say thank you to all developers that have helped
me or replied to me in the mailing list.

I want to join an active open-source community online for a really long
time but I was too shy before and got caught up with the college
entrance exam. I think GSoC is a good platform to start my journey.
Though I was not able to get the information in time and it's late for
me to commit my submission before deadline, I still decided to apply.
Because if I hadn't, I would regret someday.

As I mentioned before, maybe I have little experience to
online-contributing, but I will learn the required skills to overcome
obstacles. My lust for knowledge is my greatest power.

Last but not least, it's a pleasure to join the open-source community.
Let's collaborate and make the world better.

---

On 3/31/20 4:39 AM, Angel Pan wrote:
> Hello everyone.
> Here is my proposal for GSoC. A review or criticism would be appreciated.
>
> Google doc version:
> https://docs.google.com/document/d/19Nkesmet7X7U42lsvksXoiEBrnOppKicWHYKneEQsQ8/edit?usp=sharing
>
> Best regards,
> Angel
>
> ----------
> # Unify ref-filter formats with other `--pretty` formats
>
> ## Contact Information
>
> Full name: Yun Pan(Angel Pan)
>
> Email: [dinoallosaurus1111@gmail.com](mailto:dinoallosaurus1111@gmail.com)
>
> IRC: dinoallosaurus
>
> GitHub: dinoallo
>
> Timezone: UTC+8
>
> ## Short Biography
>
> I am a first year student in Computer Science at Zhejiang University
> in China. It's my first time participating in GSoC. I have had
> experience working with C/C++, shell scripts, Python, Go and Perl. I
> am interested in writing CLI or system scripts/configurations, which
> is the main reason I apply to Git project. I might be relatively new
> when it comes to contributing on-line project. However, I am a quick
> and avid learner so if I don’t have enough skills to complete the job,
> I can self-learn immediately.
>
> ## Working Environment
>
> My operating system is Arch Linux, which I started using it about half
> an year ago. Before then I was using Debian-based systems like Ubuntu.
> And I have some experience using git on Windows as well.
>
> I mainly use Emacs and VS Code as my editor but I can use Vim also. I
> am able to use both markdown and Org-mode on Emacs for documenting
>
> ## Coding/Contributing Experience
>
> C is my *native* language I like to config my computer and automate
> some work on it by myself so I learned shell-scripts and other
> scripting languages.  Now I write code related to back-end for the
> student club at my university.
>
> Since I used to develop web before, there is a small-project written
> in Python with Django on my GitHub page. From the experience of
> applying to git, I obtained much deeper knowledge about git and how it
> works. No matter what the outcome is, I am looking forward to
> contributing more to git and work with all the developers.
>
> ### Microproject
>
> Mailing list: https://lore.kernel.org/git/pull.595.git.1585588586605.gitgitgadget@gmail.com/T/#u
>
> GitHub: https://github.com/gitgitgadget/git/pull/595
>
> Status: waiting to be review.
>
> ## Introduction
>
> Currently, the placeholder used in ref-filter expansion `%(foo)` has
> not yet supported in `--pretty` format.
>
> Using the new ref-filter formats has its own convenience.  For
> example, the format `%(foo)` is more human-readable, easy to process,
> and extensible if we want to add some options in each placeholder(like
> `%(trailers:only=bogo)`) . Hence,  users can just simply add the
> options in the placeholder if needed, reducing their frustration in
> constructing long and complex output command.
>
> My goal is to unify the the ref-filter formats with `--pretty` formats
> and generalized them in git:
>
> * Get rid of unrecognizable placeholders like `%an` to `%(authorname)`.
> * Introduce format-scripting(like the one used in `git-for-each-ref`)
> to `--pretty` and even make a field in user's configuration to use
> default format-script for `--pretty`.
>
> ## Deliverables/Timeline
>
> ### ~ May 5th
>
> * I will keep an eye on git project and make more patches to it if possible.
> * At the same time, getting to know more about the community and
> collaborating with others.
>
> * Also I will talk to my potential mentor, to get more concrete and
> constructive advise about my project. Last, finalize my project.
>
> ### May 5th ~ June 2nd
>
> Community-bonding period:
>
> After having rounded understanding about the community and all the
> past work, I would like to revise my previous ideas regarding to my
> project if there is a much better solution or other problems. Then, I
> will start to work on a part of my project:
>
> * Carefully examine `ref-filter` related code to see what I can learn
> from(the implementation, etc...) and what to avoid doing.
> * Replace the placeholders in `--pretty` with new formats and names.
> * Commit patches to obtain reviews from the community.
>
> ### June 2nd ~ June 10th
>
> The cushion period. Finish the unfinished work from last phase. If all
> the job is done, add test scripts and future documentation.
>
> ### June 11th ~ July 3rd
>
> I will be occupied in this phase since the final exams take over. I
> might not be able to work on some actual change but is free to reply
> to anyone in the community.
>
> ### July 3rd ~ July 17th
>
> * Gathering all reviews and criticisms from the community and revise
> my previous patches if needed.
>
> * Add test scripts and documentation.
>
> ### July 17th ~ July 28th
>
> * Implement the format-scripting in `--pretty`
> * Commit the patches to obtain reviews from the community
>
> ### July 28th ~ August 12th
>
> * Gathering all reviews and criticisms from the community and revise
> my previous patches if needed.
>
> * Add test scripts and documentation.
> * [option] configuration on pretty
>
> ### August 12th ~ August 25th
>
> Final revision and discussion.
>
> ### August 25th ~
>
> Submission
>
> *If I complete my job earlier than I plan, than I would like to come
> up with more improvements and new features in my project.*
>
>  ### Side-note
>
> * Before my summer vacation, I can code for 2-3 hours per working day
> and 4-6 hours on weekend.
> * My summer vacation starts from July 3rd to early September, which
> fits well with GSoC's schedule. I will be able to spend half of my day
> on my project.
> * English is not my first language so if I have grammatical or other
> errors in documentation or communication, a review will be
> appreciated.
>
>
>
> ## Conclusion
>
> First, I would like to say thank you to all developers that have
> helped me or replied to me in the mailing list.
>
> I want to join an active open-source community online for a really
> long time but I was too shy before and got caught up with the college
> entrance exam. I think GSoC is a good platform to start my journey.
> Though I was not able to get the information in time and it's late for
> me to commit my submission before deadline, I still decided to apply.
> Because if I hadn't, I would regret someday.
>
> As I mentioned before, maybe I have little experience to
> online-contributing, but I will learn the required skills to overcome
> obstacles. My lust for knowledge is my greatest power.
>
> Last but not least, it's a pleasure to join the open-source community.
> Let's collaborate and make the online world better.
>
> ----------
