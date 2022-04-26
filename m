Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B80CC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiDZRDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 13:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiDZRDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 13:03:39 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495C2C122
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:00:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e194so20816756iof.11
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=TD/T1R9t+hszJy1sTdePStu1kXVn0vFkYNlolSFOhQ4=;
        b=SANeAhQGjltDdWW/QZtFup5Wf0rRnqf+Iv9qb5/N6aXhsbTHWt3v6gOGO6Bzm82ATH
         wtxW+OBI1lIYE1WLZJmyuJRGoYBKk5Ufrj6QAa0K1CM9BbfH3whlieMu6AlgxwUJzkOv
         d+CTmxqOU0Wrb8hSvshQu1womzQzWiel68w9Je0p+1L8nSKEmzrCs5tjZrjv4Cy3XwhI
         aNULm7bEilkF733jdOfAN/Nc55WF8ZDm2S8fHHtPwUQdx44sN8WrAoEINC9JD/fxhFY5
         JWpS2jKkUh166I7EzHyO8IuXl459WVQv2J+tdDsNjWdVw8lDM8XKqX5LeS3/bXDpJUkJ
         kGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=TD/T1R9t+hszJy1sTdePStu1kXVn0vFkYNlolSFOhQ4=;
        b=HYhsgb3Piq/wz7PKHTp1OxeaAMh3GSWhiQSZh0bBBksuAWtisrcDW+HJ2MeATZXaoc
         GHaXYhIR/k/qD6M8IdknmaXkz+fN0CEIfdYhOPcHDmGVZYiiqfif9SW72YwmBoRnIUmc
         VFq6Fws8k0xXRq65fm65vBZiRIS4ktUERmNxDf8GbLFGCZjXWMqgqbywlZOkyJ5RWyzO
         112UHzcVwU235He79Uhm5pRf7W42OfnOP4WrR1jsLJzcujsCPJFSwn2URi1xTz2zkONU
         7dV1ijX76bJrsOOmbqg5UE8/B0meIS7YRKFS/KmqGVHzIMSHZaBuKhgkaoT8iD3gWj02
         918g==
X-Gm-Message-State: AOAM5309qrB96KgmGKJUPtSj10LHc3ZOOwKpxkN2qMXI5NUnZUX7yvY7
        2lP75ODLmofnhwftT36L8kF2U6T2z/R+PIIJsq9reeYY/VS7NLvH7PbZTPVsFFilTLnaGzvNOO4
        TDEbO1vsN4JWOl1pNe6evzP3M7R7TRBBcWOBdcUfsENAQZ1jIpWXBkVSm+HIgbMz+YLLq3Q==
X-Google-Smtp-Source: ABdhPJy/bt8y9T7/Fsej8zbmkN0OqArllGCdyerAuGXer/qM7U96CXF7bu2dw79BcZN+sSvIMss+ww==
X-Received: by 2002:a05:6e02:1e03:b0:2cd:8f32:b3b6 with SMTP id g3-20020a056e021e0300b002cd8f32b3b6mr5248283ila.105.1650992429368;
        Tue, 26 Apr 2022 10:00:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6dbb:3c4:4900:218b? ([2600:1700:e72:80a0:6dbb:3c4:4900:218b])
        by smtp.gmail.com with ESMTPSA id m8-20020a92cac8000000b002ca9d826c3fsm8220850ilq.34.2022.04.26.10.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 10:00:28 -0700 (PDT)
Message-ID: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
Date:   Tue, 26 Apr 2022 13:00:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
Subject: [Discussion] What is Git's Security Boundary?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been having a few discussions internally and externally with folks
about the 2.35.2 release and the safe.directory config value. After
stumbling a little with a too-technical proposal, I (along with Taylor)
figured out that I was jumping into "solutions" mode without first talking
about the problem and agreeing on common language there.

Specifically, the issue at the root of CVE-2022-24765 [1] is that a
machine can have an "untrusted" Git repository on-disk. The actual exploit
uses hooks as an attack vector. The protection we put in place was the
safe.directory config key, which is only read out of "protected" config
files.

[1] https://github.com/git-for-windows/git/security/advisories/GHSA-vw2c-22j4-2fh2

I had started going down a rabbit hole of additional ways to harden our
security stance using this concept of "protected" config files, but that
was premature.

I'm hoping to start a conversation in this thread about "What is Git's
security boundary?" so we can have an established base to work from for
future security incidents or protections.

The only documentation I could find is our security policy [2], but that
doesn't try to define this boundary. Recent discussions on the config-
based hooks have also talked about the security boundary [3].

[2] https://github.com/git/git/security/policy
[3] https://lore.kernel.org/git/20200425205727.GB6421@camp.crustytoothpaste.net/


What is Git's Security Boundary?
================================

From my discussions, I've seen two different perspectives on Git's
security responsibility:

1. When Git interacts with another _machine_ over a protocol, then Git
   must be hardened against malicious actors across that protocol. Git
   expects data on disk from that point on to be created by "trusted"
   actors. Any files checked out from a remote source are expected to
   be inspected by the user before they are used.

2. Users expect Git commands, especially those that do not communicate
   over a network, to be as safe to use as a text editor. If there is
   a realistic vector where an unprivileged actor with access to a
   mounted disk can create a malicious repo on disk and convince another
   user to run a Git command, then Git should protect against this attack
   to the best of its ability.

The choice here is not an either-or: (1) is obviously an important case to
handle. The question is "how much of (2) are we responsible for?" I admit
that this area has no strict boundary, but instead must be inspected on a
case-by-case basis. The level of social engineering must be taken into
account. It is probably clear that we shouldn't protect against someone
who was tricked into running `git bisect run rm -rf /*` but most cases
require more inspection.

The case that came about in the recent security release had an attack
vector that is identical to using a shared repository, which is a valid
use case. Hence, the `safe.directory` config value was created. Users
using shared repositories like this (now marked with `safe.directory`) are
susceptible to someone modifying the repository-local config in a
repository they have been using without issue. This allows an actor with
access to one user's credentials to gain access to other users on that
machine, spreading their access. The ability to change the executable run
by Git via local config is the critical piece of this attack.


Example: Out of security boundary: improper filesystem permissions
------------------------------------------------------------------

It can be helpful to include a case of something that is outside of our
security boundary. In particular, if the machine has filesystem
permissions set improperly (and different than the default upon install),
then the following things can happen:

1. An attacker could replace the Git executable.

2. An attacker could modify `~/.gitconfig` to change config and have Git
   execute arbitrary code.

3. An attacker could modify `~/.bashrc` (or equivalents) to change
   environment variables such as the `PATH` or anything else.

Hopefully we can all agree that if the machine is in such a state, then
there is nothing we can do and would not call this a vulnerability _in Git_.


Example: Out of security boundary: "clone and make"
---------------------------------------------------

A well-established example is the case where a combination of social
engineering and lack of user care lead to an attack. This is most
commonly of the form of "clone this repo, go into it and run 'make'".

Building code right after cloning is a common workflow for developers,
but that does not mean that this is an attack. Running content that
could execute arbitrary code on your machine should always be checked
carefully.

This "attack" vector is considered outside of the boundary because of
the social engineering aspect (the attacker needs you to clone the
repo _and_ run something inside it) and the lack of care by the user.
The user has ample opportunity to check what they are about to do
before running that second execution step.

The other side of this situation is this: there is nothing Git can do.
Once Git has cloned the data it was asked to clone, no part of this
attack uses Git itself. There is no opportunity to intervene. Git is
doing exactly what it is asked to do: nothing less _and nothing more_.


Question: Is there a better way to describe the boundary?
---------------------------------------------------------

Please submit your attempts to clarify the boundary in replies.


Question: Is "protected" config _really_ more trustworthy?
----------------------------------------------------------

This leads to an interesting question: Do we think that `~/.gitconfig`
and `/etc/gitconfig` are "more trustworthy" than `.git/config`?

I think that if an attacker has access to write to system or global config,
then they have access to do more harm without Git. On the other hand,
local config overrides the other config values, so local config can "unset"
any potentially-malicious values in system and global config. I don't
think such "defensive config" is common.


Example Security Boundary Question: Unprotected Config and Executing Code
-------------------------------------------------------------------------

We have a lot of ways of executing external code from within Git. This is
a key extensibility feature for customizing Git functionality. One way to
do this is to create executable files in the $GIT_DIR/hooks/ directory.
Git will discover these hooks and run them at the appropriate times.

There are also many config options that specify external commands to run:

* `core.fsmonitor=<path>` is executed before scanning the worktree for
  created or modified files.

* `core.editor` specifies an editor when writing commit messages, among
  other user-input scenarios.

* `credential.helper` specifies an external tool to assist with connecting
  to a remote repository.

* `uploadPack.packObjectsHook` chooses an alternative for `git pack-objects`
  during `git upload-pack`.

The list is actually quite long. This last one, `uploadPack.packObjectsHook`
_does_ do a check for protected config: it does not allow its value to
come from repository-local config.

However, most of these options really do want to have customization on a
per-repository basis, hence this proliferation of config options and
local hook directories.

I'm concerned that as long as we allow arbitrary execution to happen based
on repository-local data, we will always have security risks in Git. For
that reason, I'm interested in exploring ways to change how we execute
code externally, even if it means we would (eventually) need to introduce
a breaking change.

The idea would be to allow repository-local customization by selecting
from a list of "installed" executables. The list of "installed"
executables comes from protected config (and the Git binary itself).

The plan I would like to put forward is to restrict all external execution
to be from one of these sources:

1. Specified in system config (`/etc/gitconfig`).
2. Specified in global config (`~/.gitconfig`).
3. An allow-list of known tools, on $PATH (e.g. `vim`).

Such a change would be a major one, and would require changing a lot of
existing code paths. In particular, this completely removes the
functionality of the `$GIT_DIR/hooks/` directory in favor of a config-
based approach. This would require wide communication before pulling all
support for the old way, and likely a 3.0 version designation. After the
old hook mechanism is removed, the "safe.directory" protection from 2.35.2
would no longer be needed.

At minimum, in the short term, this would affect the proposed design of
config-based hooks.

I think this is a good example to think about at a high level before going
into the technical details. We can use it to test any proposed security
boundary definitions to see if it lands on one side or another. Here are
some points:

1. These config-based executables cannot be set in a full repository by
   a "git clone" operation.

2. These config-based executables can be set in an embedded bare
   repository, but the user needs to move deeper into the repository for
   that to have any affect. This leads to some amount of social engineering
   being involved in the attack. See [4] for recent discussion on this.

   [4] https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/

3. If users are sharing a common Git repository, then if an attacker gains
   control of one user's account, they can use the shared repository as an
   attack vector to gain control of the other users' accounts. For this
   case, do we consider the "safe.directory" config as an indicator of
   "I trust this repo and all users that can access it _in perpetuity_" or
   instead "I need to use this repo, even though it is owned by someone
   else."

4. Git's dedication to backwards compatibility might prevent any attempt
   to change how hooks are specified or config can be used to customize
   its behavior.

5. The technical challenge of converting all possible execution paths may
   be too daunting to ever feel the project is "complete" and be able to
   confidently say "Git is safe from these kinds of attacks".


Conclusion
----------

I look forward to hearing from the community about this topic. There are
so many things to think about in this space, and I hope that a lot of
voices can share their perspectives here.

Please collect any action items here at the end. I would love to add a
doc to the Git tree that summarizes our conclusions here, even if it is
only a start to our evolving security boundary.

Thanks,
-Stolee
