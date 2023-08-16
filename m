Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FD9C41513
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbjHPXuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbjHPXuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 19:50:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351E010E9
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so13625177b3.3
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692229814; x=1692834614;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W262Tq7XJBw3zOV+GZHIrpk43qMIM1n+ZrtBIGbmtzE=;
        b=byl24w0MOQCMPEQjh9m/k7JeBKeuBssEDJGzk1OkYLQv9ycBSWvU/1OYl6edOmd48J
         5p56oNzbcuZQfLDr4ZzKe+uoOhpubtwpDMs4FMzVDj2xMeh13nztw+PPuXvO24ne5R6/
         YcKiHjMmIo9wMQC7PMmTQrhuBpk0fq7/gADvLF1QSJiFJsyjTJ4adfSe0F7nHghyHjeM
         M7SDGS+Eb4tzuMjNk7M/5ONYngfBIbZtiglTKqZyvQd4QdD39yOlx1lhtRrmyKQdJPbd
         Ev1Lec1nyIxzSED5HJIyx7RWJVZEBsteOs6X3HgYj+5aqqqqmwGMDj+Wz9KWqKUASHw8
         F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229814; x=1692834614;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W262Tq7XJBw3zOV+GZHIrpk43qMIM1n+ZrtBIGbmtzE=;
        b=Ksa1u80IF2keAtKguf7aqO7oSEqxeIcJyABSIu2005ZYnF3PdE8sYUURTFi8A2bZHW
         hupyxsUIzI2lnlfrljKXzNQ3azURYZsd+yuqgAW5c1mta/yPDJ9m3wgh+WNGKWsBdevC
         coa02yGI9h3AMeupu08de8hOenrWbgHLpCxCznKVj9Q4w3sbTk5w0vEmIQt6rP+3/PX0
         EUHdGGmXSv88e2Q5pNW1UC61ZvvMPgIB0Es7fco3Zy4muWTYa4Qadtmzi9U+L3GKDMcv
         j0WJJLnOdvM0/HvbKxTWX4GU3/3VYulxLxxx2kKlFjHKRlOD8Nj/9uvD9T370jpz6TTE
         VO6A==
X-Gm-Message-State: AOJu0Yx5qpJRZPaZwwpeh7LrErU3NlGCmEVGidxsTP6TF9nzP5aQNFjl
        8VkMk6Ht5ckPAJCmfZedWOSEG71qTJdaNUamoprrkU9wwJ+tMaDjc2HT+fhjJ+D+4l2fT4DzbyS
        lB7IEoy1YzeFCp7FouZi+436fNDb/8ZgLE1cVgBDw4uDPzhWlpOrQ7+xvr4KpQiY=
X-Google-Smtp-Source: AGHT+IHTjfeykzcVp0gbxG0jy7gayOxMIddWFG67wzQqIpEoMyczKdtPNuqi62LTK4ib/VX3pd0hMHkKByQp4A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:378f:b204:29bd:7043])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1828:b0:d51:577e:425d with SMTP
 id cf40-20020a056902182800b00d51577e425dmr53729ybb.12.1692229814007; Wed, 16
 Aug 2023 16:50:14 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:50:05 -0700
In-Reply-To: <cover.1692229626.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692229626.git.steadmon@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <81c5148a1267b8f9ce432a950340f0fa16b4d773.1692229626.git.steadmon@google.com>
Subject: [PATCH v6 1/3] unit tests: Add a project plan document
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Describe what we hope to accomplish by
implementing unit tests, and explain some open questions and milestones.
Discuss desired features for test frameworks/harnesses, and provide a
preliminary comparison of several different frameworks.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 220 +++++++++++++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 Documentation/technical/unit-tests.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b629176d7d..3f2383a12c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -122,6 +122,7 @@ TECH_DOCS +=3D technical/scalar
 TECH_DOCS +=3D technical/send-pack-pipeline
 TECH_DOCS +=3D technical/shallow
 TECH_DOCS +=3D technical/trivial-merge
+TECH_DOCS +=3D technical/unit-tests
 SP_ARTICLES +=3D $(TECH_DOCS)
 SP_ARTICLES +=3D technical/api-index
=20
diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technic=
al/unit-tests.txt
new file mode 100644
index 0000000000..b7a89cc838
--- /dev/null
+++ b/Documentation/technical/unit-tests.txt
@@ -0,0 +1,220 @@
+=3D Unit Testing
+
+In our current testing environment, we spend a significant amount of effor=
t
+crafting end-to-end tests for error conditions that could easily be captur=
ed by
+unit tests (or we simply forgo some hard-to-setup and rare error condition=
s).
+Unit tests additionally provide stability to the codebase and can simplify
+debugging through isolation. Writing unit tests in pure C, rather than wit=
h our
+current shell/test-tool helper setup, simplifies test setup, simplifies pa=
ssing
+data around (no shell-isms required), and reduces testing runtime by not
+spawning a separate process for every test invocation.
+
+We believe that a large body of unit tests, living alongside the existing =
test
+suite, will improve code quality for the Git project.
+
+=3D=3D Definitions
+
+For the purposes of this document, we'll use *test framework* to refer to
+projects that support writing test cases and running tests within the cont=
ext
+of a single executable. *Test harness* will refer to projects that manage
+running multiple executables (each of which may contain multiple test case=
s) and
+aggregating their results.
+
+In reality, these terms are not strictly defined, and many of the projects
+discussed below contain features from both categories.
+
+For now, we will evaluate projects solely on their framework features. Sin=
ce we
+are relying on having TAP output (see below), we can assume that any frame=
work
+can be made to work with a harness that we can choose later.
+
+
+=3D=3D Choosing a framework
+
+We believe the best option is to implement a custom TAP framework for the =
Git
+project. We use a version of the framework originally proposed in
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com=
/[1].
+
+
+=3D=3D Choosing a test harness
+
+During upstream discussion, it was occasionally noted that `prove` provide=
s many
+convenient features, such as scheduling slower tests first, or re-running
+previously failed tests.
+
+While we already support the use of `prove` as a test harness for the shel=
l
+tests, it is not strictly required. The t/Makefile allows running shell te=
sts
+directly (though with interleaved output if parallelism is enabled). Git
+developers who wish to use `prove` as a more advanced harness can do so by
+setting DEFAULT_TEST_TARGET=3Dprove in their config.mak.
+
+We will follow a similar approach for unit tests: by default the test
+executables will be run directly from the t/Makefile, but `prove` can be
+configured with DEFAULT_UNIT_TEST_TARGET=3Dprove.
+
+
+=3D=3D Framework selection
+
+There are a variety of features we can use to rank the candidate framework=
s, and
+those features have different priorities:
+
+* Critical features: we probably won't consider a framework without these
+** Can we legally / easily use the project?
+*** <<license,License>>
+*** <<vendorable-or-ubiquitous,Vendorable or ubiquitous>>
+*** <<maintainable-extensible,Maintainable / extensible>>
+*** <<major-platform-support,Major platform support>>
+** Does the project support our bare-minimum needs?
+*** <<tap-support,TAP support>>
+*** <<diagnostic-output,Diagnostic output>>
+*** <<runtime-skippable-tests,Runtime-skippable tests>>
+* Nice-to-have features:
+** <<parallel-execution,Parallel execution>>
+** <<mock-support,Mock support>>
+** <<signal-error-handling,Signal & error-handling>>
+* Tie-breaker stats
+** <<project-kloc,Project KLOC>>
+** <<adoption,Adoption>>
+
+[[license]]
+=3D=3D=3D License
+
+We must be able to legally use the framework in connection with Git. As Gi=
t is
+licensed only under GPLv2, we must eliminate any LGPLv3, GPLv3, or Apache =
2.0
+projects.
+
+[[vendorable-or-ubiquitous]]
+=3D=3D=3D Vendorable or ubiquitous
+
+We want to avoid forcing Git developers to install new tools just to run u=
nit
+tests. Any prospective frameworks and harnesses must either be vendorable
+(meaning, we can copy their source directly into Git's repository), or so
+ubiquitous that it is reasonable to expect that most developers will have =
the
+tools installed already.
+
+[[maintainable-extensible]]
+=3D=3D=3D Maintainable / extensible
+
+It is unlikely that any pre-existing project perfectly fits our needs, so =
any
+project we select will need to be actively maintained and open to acceptin=
g
+changes. Alternatively, assuming we are vendoring the source into our repo=
, it
+must be simple enough that Git developers can feel comfortable making chan=
ges as
+needed to our version.
+
+In the comparison table below, "True" means that the framework seems to ha=
ve
+active developers, that it is simple enough that Git developers can make c=
hanges
+to it, and that the project seems open to accepting external contributions=
 (or
+that it is vendorable). "Partial" means that at least one of the above
+conditions holds.
+
+[[major-platform-support]]
+=3D=3D=3D Major platform support
+
+At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
+
+In the comparison table below, "True" means that it works on all three maj=
or
+platforms with no issues. "Partial" means that there may be annoyances on =
one or
+more platforms, but it is still usable in principle.
+
+[[tap-support]]
+=3D=3D=3D TAP support
+
+The https://testanything.org/[Test Anything Protocol] is a text-based inte=
rface
+that allows tests to communicate with a test harness. It is already used b=
y
+Git's integration test suite. Supporting TAP output is a mandatory feature=
 for
+any prospective test framework.
+
+In the comparison table below, "True" means this is natively supported.
+"Partial" means TAP output must be generated by post-processing the native
+output.
+
+Frameworks that do not have at least Partial support will not be evaluated
+further.
+
+[[diagnostic-output]]
+=3D=3D=3D Diagnostic output
+
+When a test case fails, the framework must generate enough diagnostic outp=
ut to
+help developers find the appropriate test case in source code in order to =
debug
+the failure.
+
+[[runtime-skippable-tests]]
+=3D=3D=3D Runtime-skippable tests
+
+Test authors may wish to skip certain test cases based on runtime circumst=
ances,
+so the framework should support this.
+
+[[parallel-execution]]
+=3D=3D=3D Parallel execution
+
+Ideally, we will build up a significant collection of unit test cases, mos=
t
+likely split across multiple executables. It will be necessary to run thes=
e
+tests in parallel to enable fast develop-test-debug cycles.
+
+In the comparison table below, "True" means that individual test cases wit=
hin a
+single test executable can be run in parallel. We assume that executable-l=
evel
+parallelism can be handled by the test harness.
+
+[[mock-support]]
+=3D=3D=3D Mock support
+
+Unit test authors may wish to test code that interacts with objects that m=
ay be
+inconvenient to handle in a test (e.g. interacting with a network service)=
.
+Mocking allows test authors to provide a fake implementation of these obje=
cts
+for more convenient tests.
+
+[[signal-error-handling]]
+=3D=3D=3D Signal & error handling
+
+The test framework should fail gracefully when test cases are themselves b=
uggy
+or when they are interrupted by signals during runtime.
+
+[[project-kloc]]
+=3D=3D=3D Project KLOC
+
+The size of the project, in thousands of lines of code as measured by
+https://dwheeler.com/sloccount/[sloccount] (rounded up to the next multipl=
e of
+1,000). As a tie-breaker, we probably prefer a project with fewer LOC.
+
+[[adoption]]
+=3D=3D=3D Adoption
+
+As a tie-breaker, we prefer a more widely-used project. We use the number =
of
+GitHub / GitLab stars to estimate this.
+
+
+=3D=3D=3D Comparison
+
+[format=3D"csv",options=3D"header",width=3D"33%"]
+|=3D=3D=3D=3D=3D
+Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or =
ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<ma=
jor-platform-support,Major platform support>>","<<tap-support,TAP support>>=
","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Run=
time- skippable tests>>","<<parallel-execution,Parallel execution>>","<<moc=
k-support,Mock support>>","<<signal-error-handling,Signal & error handling>=
>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
+https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com=
/[Custom Git impl.],[lime-background]#GPL v2#,[lime-background]#True#,[lime=
-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-ba=
ckground]#True#,[lime-background]#True#,[red-background]#False#,[red-backgr=
ound]#False#,[red-background]#False#,1,0
+https://github.com/silentbicycle/greatest[Greatest],[lime-background]#ISC#=
,[lime-background]#True#,[yellow-background]#Partial#,[lime-background]#Tru=
e#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#T=
rue#,[red-background]#False#,[red-background]#False#,[red-background]#False=
#,3,1400
+https://github.com/Snaipe/Criterion[Criterion],[lime-background]#MIT#,[red=
-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[l=
ime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime=
-background]#True#,[red-background]#False#,[lime-background]#True#,19,1800
+https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#Expat#,[lim=
e-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partia=
l#,[lime-background]#True#,[red-background]#False#,[lime-background]#True#,=
[red-background]#False#,[red-background]#False#,[red-background]#False#,4,3=
3
+https://libcheck.github.io/check/[Check],[lime-background]#LGPL v2.1#,[red=
-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[l=
ime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-=
background]#False#,[red-background]#False#,[lime-background]#True#,17,973
+|=3D=3D=3D=3D=3D
+
+=3D=3D=3D Additional framework candidates
+
+Several suggested frameworks have been eliminated from consideration:
+
+* Incompatible licenses:
+** https://github.com/zorgnax/libtap[libtap] (LGPL v3)
+** https://cmocka.org/[cmocka] (Apache 2.0)
+* Missing source: https://www.kindahl.net/mytap/doc/index.html[MyTap]
+* No TAP support:
+** https://nemequ.github.io/munit/[=C2=B5nit]
+** https://github.com/google/cmockery[cmockery]
+** https://github.com/lpabon/cmockery2[cmockery2]
+** https://github.com/ThrowTheSwitch/Unity[Unity]
+** https://github.com/siu/minunit[minunit]
+** https://cunit.sourceforge.net/[CUnit]
+
+
+=3D=3D Milestones
+
+* Add useful tests of library-like code
+* Integrate with
+  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@google.co=
m/[stdlib
+  work]
+* Run alongside regular `make test` target
--=20
2.41.0.694.ge786442a9b-goog

