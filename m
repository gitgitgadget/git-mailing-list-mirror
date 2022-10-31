Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E62FECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJaUQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJaUQM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:16:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4449CE0FF
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:16:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i127so14959129ybc.11
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxpfSY/Rr26o74FFSYoUoRsKypBrCql/mVP6Jij4KAU=;
        b=Mgqhq/dnnZ+2Z/b1tqRCn2W4g3igi5v00NSMF4Q2eUNADbqe/BZdSJUHvy6YX3T2o5
         l0Sxks8kkIXIpP9HOk4TnHBhtFKAO9FjVWN3lT/qhWU2KBA5do9Y618ysLCX2CUwsBG4
         hJCR9IspxNfrAFhiqHlTiVB0UA+zji/6EuOUpkAmcIUkA1va0jZjHMKpIb3dkkU9m5sw
         Bf/uillg//TxpaPQMqEDN9UopNpAL4Bj6o80jiJc8Cz+hiVNzDEjTm9IezIQnZ+u4OY4
         ForfAWCisLhyfx9K/CFlfSNAKgkYH98g0eeQ8cqOo649nFzHNVGTmD8q5MSdbv9tWaS2
         28Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxpfSY/Rr26o74FFSYoUoRsKypBrCql/mVP6Jij4KAU=;
        b=AJfwbLJPnlGLvFP2iqPIMss1M02ZBwgJBZ8Zqo8NwJO7g3Zbet/0i0BS/yIu3+SSVI
         K6W7S+nXIJmcoc0ItDO8lIHM/QwdIitTcUbc3Gs+vaPINFwmOylZvtRWDbMQTlDkRJ++
         gNua3L6bOSVrVTETMfBw9k/jHNXm/LrEO1aPAgw9mFE1BLkWWd96qaFW/C4a2xjzV6tn
         tThVG9c1ypkbxpH8+3+Ekn6sULQWkIS4zWQ4QvOYQldNcS+Pte7azbUS6vuByqCeUfbC
         LwVfkaKNhDdhRMuG7iUikTaDJ3dJ0WhqbAc5FMdMtUtojL5kEKtXvKhtMXe0bOYZHBO5
         SQhQ==
X-Gm-Message-State: ACrzQf3cR4JoC4/cECs8FhlXE+7b+lHOyYO+0Ml5g3TLhefBsiSdc3SK
        T0X7D3SEFle8zapk91QOmIB2CEiSrtaDbJBlatXZK1ss7fiQh39a
X-Google-Smtp-Source: AMsMyM5wTxh+Bk2+hcRdnPscAqv8ZJZGmDtKVD66MLtl+fMw3ZA50WHUSNtNQ+0yfuFBLKSFynocxrYOukiGTvYHmtw=
X-Received: by 2002:a05:6902:1088:b0:6b0:2054:7dfd with SMTP id
 v8-20020a056902108800b006b020547dfdmr14754545ybu.163.1667247368233; Mon, 31
 Oct 2022 13:16:08 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Mon, 31 Oct 2022 23:15:57 +0300
Message-ID: <CA+PPyiEnnjeTUCoqddsKDqR2xw8+_gFvQeVJ6wmj_n1JtEUoew@mail.gmail.com>
Subject: [OUTREACHY V3] Unify ref-filter formats with other --pretty formats[proposal]
To:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,
This is the third version of my proposal. I have addressed Hariom's
comments and other comments are welcome. I look forward to having a
fine proposal by Friday. Looking forward to your reviews

Google docs version:
https://docs.google.com/document/d/1Kdx8DVWF3c5pwV5-A8Z4n-SoRHlMDncI1gNeGCi=
LNsE/edit#

Name: Nsengiyumva Wilberforce

Major: Software engineering

Mobile no.: +256 785065399

Email: nsengiyumvawilberforce@gmail.com

IRC: wilber4c

Github: nsengiyumva-wilberforce

Linkedin: https://www.linkedin.com/in/nsengiyumva-wilberforce-623664192/

Time Zone: EAT (UTC + 03:00)

##About me

I am doing a Bachelor of Science in software engineering at Makerere
university in my 4th year(final). I spend most of my time writing PHP
applications. I am also interested in Java and embedded systems
development and I have participated in embedded systems development
projects like <https://www.ademnea.net/>.

##Microproject
When I was browsing the outreachy projects on outreachy website, I was
super excited about Git because I use it in most of my college work.
At first, it was intimidating for me to introduce myself to the
community. But I am glad I took a step. I am glad that I completed my
microproject and the whole process gave me confidence on how to submit
patches, communicate with the community members and interestingly, it
was a big learning process for me.  The following are the details
about my microproject with public-inbox links to different versions.

Mailing List for the microproject:
<https://public-inbox.org/git/pull.1362.v4.git.git.1665772130030.gitgitgadg=
et@gmail.com/>

Github:  <https://github.com/git/git/pull/1362>

Status: master


##Review on a tiny Git project
While preparing my proposal and making some corrections suggested by
my mentors, another outreachy applicant came in. She first had trouble
with submitting her patch and I immediately intervened to help. She
was having difficulties with an incorrect commit author name and I
advised her to set it
locally<https://github.com/git/git/pull/1372#issuecomment-1294407743>.
This advice helped the applicant solve the problem and she was able to
submit her patch. It was so interesting and I believe I will help more
new people.


##Proposed Project

##Abstract
Git has an old problem of duplicated implementations of some logic.
For example, Git had at least 4 different implementations to format
command output for different commands. The foremost aim of this
project is to simplify codebase by getting rid of duplication of a
similar logic and, as a result, simplify adding new functionality.
The current task is to reuse ref-filter formatting logic to minimize
code duplication and to have one unified interface to extract all
needed data from the object and to print it properly.

##Previous Work
JayDeep Das(GSoC) tried to =E2=80=9Cadd a new atom =E2=80=98signature=E2=80=
=99=E2=80=9D. However, I
have not been able to find his complete work in the public box, it
seems his work was not complete. According to
<https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e7165c72218=
8093e>
which was suggested at the outreachy website, it looks like he did not
complete writing the tests for the signature atom he was unifying.

JayDeep=E2=80=99s tests were not able to know if the signature is bad or go=
od,
so he was supposed to add two tests one to handle good signature and
another to handle bad signature like this

test_expect_success 'test signature atom with grade option and good signatu=
re' '

git verify-commit signed 2>out &&

grep "Good signature from" out &&

echo "G" >expected &&

git for-each-ref refs/heads/signed --format=3D"%(signature:grade)" >actual =
&&

test_cmp actual expected

'


test_expect_success 'test signature atom with grade option and bad signatur=
e' '

git verify-commit master 2>out &&

! grep "Good signature from" out &&

echo "B" >expected &&

git for-each-ref refs/heads/signed --format=3D"%(signature:grade)" >actual =
&&

test_cmp actual expected

'

##What=E2=80=99s up with the signature atom?
Hariom says in his final report that the signature
atom<https://github.com/harry-hov/git/commits/cc-signature2> was
implemented like the new email
formats<https://public-inbox.org/git/aeb116c5aaaa23dfefbc7a6f4ac743a6f5a3ad=
e8.1595882588.git.gitgitgadget@gmail.com/>,
but he again says that it was supposed to be refactored according to
Junio=E2=80=99s comment<https://public-inbox.org/git/xmqqzh7jcqv7.fsf@gitst=
er.c.googlers.com/>.
JDeep addresses this by introducing 2 functions namely:
signature_atom_parser() where the comparison happens and
grab_signature() where the parsing
happens<https://github.com/JDeepD/git-1/commit/85ddfa4b33f2b6f05524e648e716=
5c722188093e>
which I think was a pretty good idea.He also faced an issue of putting
2 blank lines between the tests that he wrote yet it=E2=80=99s supposed to =
be
one according to git=E2=80=99s coding guidelines[Christian=E2=80=99s commen=
t]

Hariom Verma contributed(https://harry-hov.github.io/blogs/posts/the-final-=
report)
tremendously towards =E2=80=9CUnifying ref-filter formats with other --pret=
ty
formats=E2=80=9D during GSoC'20 internship. Hariom finished most of the
formatting options and this will help me build on his work.  His work
looks smart and understandable thus adding on his work will be easy.
And also his blog is very fabulous, it=E2=80=99s a shooting point for me to
start understanding the codebase very well.

 Hariom mentions in his report that 30 % of the log related tests are
failing, he also mentions that the cause of tests failure is because
of the missing mailmap logic and mbox/email commit format in
<https://github.com/harry-hov/git/commits/pretty-lib-2.0.2>. Hariom
also says the failure might be because
<https://github.com/harry-hov/git/commits/pretty-lib-2.0.2> does not
handle unknown formatting options. I plan to start with his advice
about the cause of the failure of these tests. In log-tree.c, these
following two parts were not tested. I am still understanding more
about how this can be handled;

if (opt->use_ref_filter)

ref_pretty_print_commit(&ctx, commit, &msgbuf);

else

pretty_print_commit(&ctx, commit, &msgbuf);



if (opt->show_log_size && !opt->use_ref_filter) {

fprintf(opt->diffopt.file, "log size %i\n", (int)msgbuf.len);

graph_show_oneline(opt->graph);

}

##Hariom=E2=80=99s Remaining work?

-Branch without new file format-support.{c,h}:

Why does it exist? Junio
thinks<https://public-inbox.org/git/xmqqlfid1305.fsf@gitster.c.googlers.com=
/>
there is no point in adding new format-support.{c,h} if we were only
making pretty.{c, h} static functions public

-Branch with new file format-support.{c, h}.

Why does it exist? Initially, Hariom had
thought<https://public-inbox.org/git/7a64495f99ec97258687695d41d106e3f946d5=
51.1597687822.git.gitgitgadget@gmail.com/>
it would be nice to have another pair of files to keep the functions
that would be used in pretty.c and ref-filter.c but Junio
says<https://public-inbox.org/git/xmqqlfid1305.fsf@gitster.c.googlers.com/>

-Branch with new new signature atom for ref-format

Why does it exist? This new signature atom had been implemented just
like the new email formats were initially
introduced<https://public-inbox.org/git/aeb116c5aaaa23dfefbc7a6f4ac743a6f5a=
3ade8.1595882588.git.gitgitgadget@gmail.com/>,
but Junio thinks it should be refactored this
way<https://public-inbox.org/git/xmqqzh7jcqv7.fsf@gitster.c.googlers.com/>.

ZheNing Hu=E2=80=99s <https://public-inbox.org/git/CAOLTT8SxHuH2EbiSwQX6pyJ=
Js5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com/>
 work was mainly in 3 stages namely;

Stage 1: Implement `git cat-file =E2=80=93batch` driver in ref-filter.*
support `%(raw)` atom in ref-filter, which can print raw data of the
object.

Stage 2: refactor `git cat-file =E2=80=93batch` to use reuse the logic of r=
ef-filter

Stage 3: Optimize ref-filter performance.


Olga<olyatelezhnaya@gmail.com> has done great work in =E2=80=9CUnifying Git=
=E2=80=99s
format languages=E2=80=9D during Outreachy Round 15 and continued even afte=
r
that [from 28-09-2017 to 04-04-2019]. Her work is mostly related to
`cat-file` and `ref-filter`.

She already did a pretty nice job in preparing ref-filter for more
general usage of its formatting logic.

##Why is Olga=E2=80=99s and ZheNing Hu=E2=80=99s approach problematic?

Christian Couder
says<https://public-inbox.org/git/CAP8UFD2skja6kE+w1vPewueQ2wzEck61wiZMftUy=
A+q=3DJZ+SMA@mail.gmail.com/>
that their project used ref-filter format in cat-file which was a very
hard approach due to performance issues.

##The Plan

My task is to look at how pretty formats are different from ref-filter
formats. When some format is supported by the pretty formats but not
by the ref-filter formats, and should prepare some patches to support
the ref-filter format. I will basically build on Hariom=E2=80=99s previous
work

Step 1:List down all the formats supported by the pretty format but
are not supported by the ref-filter format e.g

User formats like %ah, %ch, %d, %D, %(describe[:options]), %S,
%GG,%G?, %GS, %GK, %GF, %GP, %GT, %gD, %gd, %gn, %gN, %ge, %gE, %gs.

Step 2:Read through different patches related to pretty and ref-filter
formats submitted by different contributors to get a solid and a
thorough understanding of the pretty and ref-filter formats.

Step 3:Understand an implementation of one or two pretty formats, and
then look at how it was implemented in ref-filter format. This is
going to give me direction to refactor the remaining pretty formats

Step 4(possible approach): Pick one format option at a time and
convert it to use ref-filter option format


##Estimated Timeline

Tasks:Community bonding

Time Period:December 5,2022 - January 2, 2023

-understanding all the logic of pretty.* and ref-filter.*

(what functions are used and how all formatting process is going)

-Working with mentors and identifying the best candidates to be converted f=
irst.

-Converting a couple of formatting options to reuse ref-filter
formatting logic and updating the documentation

Period:December 25, 2022
Christmas celebrations :Join my parents for celebrations

period: January 1, 2023
New year=E2=80=99s day holiday: Join my parents for celebrations

period:January 3 - February 3, 2023
Task:Coding Phase 1
-Add on Hariom=E2=80=99s work:Converting more formatting options to reuse
ref-filter formatting logic.
-Finish his incomplete work
-Update Documentation.
-Possibly look at Olga=E2=80=99s work

period: January 18, 2023
My Birthday: Cake cutting with my  friends

From January 6 - January 18, 2023:Semester Exams
 I will be working for a few hours per day and always be available to
reply to any communication

period: February 3 - March 3, 2023
Coding Phase 2
-Final touch-ups and bug fixes(if any)
-Update Documentation
-Wrapping up.

##Blogging about Git

I do love writing a lot however much I have not taken time to put out
my personal opinions and thinking. Being an avid reader, I think it=E2=80=
=99s
now my time to start letting other people read what I write, to let
people know what I think, what I am doing with my life. And guess
what, I am super excited to start with Git.

I have created a blog site that I will be using
https://nsengiyumva-wilberforce.github.io/

##Availability

I can easily devote 30-40 hours per week since my college just
requires 15 hours per week. I plan even to work more extra hours for
my internship tasks when time allows.

##Post Outreachy

Apart from being an Outreachy intern, I plan to remain a member of git
community even after my internship, because I believe there is more to
do even after the Outreachy internship

Here are some other things I=E2=80=99d like to do beyond Outreachy

-Mentor other students

-Doing code reviews for other contributors

-May be complete the work that I will have left pending after my internship

-Keep learning from all of you...

##Experience with Open Source

I have little  experience with open source, so I hope to learn a lot
through my internship with Git from you all.


##Motivation

Git being a world=E2=80=99s best developer version control system, I feel
overjoyed that even my little first patch was accepted. The community
is very welcoming, the people there answer questions very first and
this turns everything overwhelming to a simple process


##Closing remarks (Optional)

I am a consistent and passionate learner. Even if solving a problem
may look tricky to me, I just give it all my 100% time and think of
1000s of ways to approach it. I know I do not have the required
expertise to begin working with a skilled team like Git but I believe
in learning slowly by slowly until I will make it to the peak.


I hope you consider and give me a chance to work with git. It=E2=80=99s a
great hope I have that this opportunity is bringing me closer to my
dreams. Thanks for your consideration.


Best Regards


Nsengiyumva wilberforce
