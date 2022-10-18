Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B1C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiJROsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiJROsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:48:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED01D77D5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666104493;
        bh=V7SF6mgO/h6Gi0rdjgDOIx9qTE/IQ7bUWys9+PDYAcQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KzB/gBSS82CYHLurRQV7KP4AAgbacfK+BE/InWw5bUB73r7siGsQDXDHiITBkURQ4
         DWIGjyyK2imGU+SD0gd3z4g38IJMAX6kQLU3pPI3YAeVSdL7A6AKd75R91Tx1aQnRe
         uQfzGBpocnEKPayEadhBuWZmsw6oarRKuX5iXSUk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1otqQf3cZd-0095Tp; Tue, 18
 Oct 2022 16:48:13 +0200
Date:   Tue, 18 Oct 2022 16:02:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye <vdye@github.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/5] cmake: make it easier to diagnose regressions in
 CTest runs
In-Reply-To: <3df77ffd-85a2-3a54-9005-34a24ec6e82d@github.com>
Message-ID: <29r609np-s0r1-r904-16o3-6918930o2ror@tzk.qr>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com> <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com> <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com> <3df77ffd-85a2-3a54-9005-34a24ec6e82d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TqA91jQuedauEIxcm+nIY4mcwlo7mfCMwpT1QFrGqNDJIRiS1zR
 UBp+KVkn2qnf6DzUKzqOJDyYyaqDsn/FgxkG91rGBLMURHyzZ4qzGpe1/15nIcN1FAjUy7E
 qloYbHQwZ508RMiwyWrl89NKNP7AmZMDCi4SPLMk3WohbqMEkUsVdeT+bI+a5ML8AIGnsfz
 fQP3xd/S2SQaFToimNOZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G404wj22eRs=:QPpgbK6i1q7Fg33JybrbVN
 sdQrW1Y42o9I8poeWtfkk2yfb3SXePkEj8LCj8xKFruvTfwwm2YA892TKCiiEvCZ6vW0qTuBO
 EKbpAIMpTS6NP8vSABgodHP3YFoNLSyDXP0kkNHIBYPdVyVcFJM5ZZYYSgMCJJonuuTMQRFFM
 opI4K9Tmxo2lH7w+hOi4eb2MpBNPLLQpD54P8lIln9Xy82FjITA3OYDmgbKBCV/Wu/P/b4T3B
 SSlEN1A8s3bTIwkgSSMr/cPf9ImueGSRJgLdoNz/38plvumdbkuiD6vAiolQ7da1KJOwZgM8i
 svyaQ7bGQ+MY3IPNVv+RIlNTCQ2RHlCdX6EIwUxUVdbDR5awi5EOvrFTHftVyLajwsY0vHxg1
 wsQYI6Omr0O5/VEs+ifwOQBh/CPHlVCm/gjhwURKCwNj5BnyynaDXlXzo9jUVCkPSGjl9uxXt
 9ad7ZMyiPwx4d25TdFwBkmz7K48oogPbCoveOf2CWAhAStsDpfAMHuVPp63C5SbIFL05k6uq+
 G1srkcshMUsR58dozFnk8PAsNVR18afPTSRmNjUS1eBmRyl43bD2fGuWmmdb4k2GGnmX66vRQ
 WtmDV6iyW5dhrCW+U81BIkSz3X5eNc9sB+o+WA9JhtcW6toNSBd/nu/e+0AhqA1HjfCpEIR40
 ueEhKPmv1fSUEMrgyud2sp22Kq6bgz9ju6vmIJ3QosTLv5G/ja34cvoGTef1x8AzUJdGdCo8X
 3HHhUJWgZws2Af3eRpQpF9WkX/J2G5XN7pUQDpD0ZXrb2uxNaen3nk+Sc+nqQBfyz2HAsCIRM
 OCN44JTT4TEF+vRb7q9TEBZxvqygWgIAhVtOVxqxoWxlZcSP+21q8mIIxEensma8jylfNJrfe
 T7wh371ua2XSt4Ds4UMg8eg3gHx6UDuWSeNCJCA5xeCb6aDwbFkQ6oE1+l9k2pxa3mH6Qv4I1
 dWp/0ZpMMzbbiRn0tnPMgos/s1XEbrsVFbRiqGGPZgQNMV987SVAMdbZZDBj3HZMSJMew/OSQ
 7wU4/SanABJOw0PNH2V+grWHBApGP8u8fDGQXcMfeMP1y8EVaAm9AAdrOmYKXK2wBR+AYmaj1
 oNUmhvX3qfQFZdDicwp/JQ98R09jdW0CWuYnpyT3rrpTn0lf/Xp2/h07Ey86R1Nc1EYdqlzPz
 CAuv07FEHlV24NrGr0S36gWaiAQszOJjQBND4mzvIvnOkI2etcPsvDdy5vmkrcBTP7FO+gMVZ
 XV+ETU6Wb0px/scBQ0l5NBUbWYVp+j5tMPwLoXlMOQ5nnjE3aOpuwJNqqCmj+n9fBlefhl20O
 sHxEO2obMQyU9YJbc+DBi9hrtdxrQP+k/OfGDd5LHBzVDIuVjpHCMC07itRVzfqVWeULU6dKB
 uJqYz3n/7+/XTW13GBJn5ixiD62AToWSfob/BMR+A+CO6FtM9742qNjZAtp2CycdEH2KRlf53
 7X0+DDKqGxQMV/0MBHgnQsIRRwFYBL+MX5PlORjFl3dAP2riPuFvJfQdSMmSsaaRz6cHsZGe7
 4XJpysVoTBUXqbF/mwGURIm29xKFC0ZuuhJQNq8b/aZXwAGWrmyLda6q/sa2I5nFgXQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 7 Sep 2022, Victoria Dye wrote:

> Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When a test script fails in Git's test suite, the usual course of acti=
on
> > is to re-run it using options to increase the verbosity of the output,
> > e.g. `-v` and `-x`.
> >
> > Like in Git's CI runs, when running the tests in Visual Studio via the
> > CTest route, it is cumbersome or at least requires a very unintuitive
> > approach to pass options to the test scripts.
>
> At first I wondered whether there's a way to make arg specification more
> intuitive, rather than silently changing defaults. Unfortunately, it loo=
ks
> like even in the latest versions of CTest don't really support passing
> arguments through to tests [1] (and the workarounds are unpleasant at be=
st).
>
> But then, you mentioned that there *is* a cumbersome/unintuitive approac=
h to
> passing the options; what approach were you thinking?

Thank you for pointing out that I assumed this to be more obvious than it
actually is.

The cumbersome way is to edit this part of the CMake definition
(https://github.com/git/git/blob/v2.38.0/contrib/buildsystems/CMakeLists.t=
xt#L1091-L1096):

	#test
	foreach(tsh ${test_scipts})
		add_test(NAME ${tsh}
			COMMAND ${SH_EXE} ${tsh}
			WORKING_DIRECTORY
			${CMAKE_SOURCE_DIR}/t)
	endforeach()

To pass an option like `-v --run=3D1,29`, the user would have to edit the
line `COMMAND ${SH_EXE} ${tsh}`, appending the options, and then
re-configure the CMake cache. And then not forget to _only_ run the test
script in question because those options do not make sense for the other
tests. And then not forget to undo the changes and re-configure the CMake
cache.

> [1] https://gitlab.kitware.com/cmake/cmake/-/issues/20470
>
> >
> > So let's just pass those options by default: This will not clutter any
> > output window but the log that is written to a log file will have
> > information necessary to figure out test failures.
>
> Makes sense, I don't see any harm in providing more verbose output by
> default here.
>
> >
> > While at it, also imitate what the Windows jobs in Git's CI runs do to
> > accelerate running the test scripts: pass the `--no-bin-wrappers` and
> > `--no-chain-lint` options. This makes the test runs noticeably faster
> > because the `bin-wrappers/` scripts as well as the `chain-lint` code
> > make heavy use of POSIX shell scripting, which is really, really slow =
on
> > Windows due to the need to emulate POSIX behavior via the MSYS2 runtim=
e.
>
> I'm a bit more hesitant on including these. I see how the performance
> benefit (on Windows in particular) would make typical user experience ni=
cer.
> But, if someone develops locally with '--no-chain-lint' specified, they'=
ll
> be much more likely to miss a broken && chain (personally, I get caught =
by
> chain lint errors *all the time* when I'm adding/updating tests) and cau=
se
> unnecessary churn in their patch submissions. So, my recommendation woul=
d be
> to drop '--no-chain-lint' here (unless it's less important to the averag=
e
> developer than I think it is).
>
> It's also possible that '--no-bin-wrappers' does something weird with th=
eir
> local installation of Git but I think it's safe enough to make the defau=
lt
> if the performance gain is substantial.
>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index 1b23f2440d8..4aee1e24342 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0=
-9]*.sh")
> >  #test
> >  foreach(tsh ${test_scipts})
> >  	add_test(NAME ${tsh}
> > -		COMMAND ${SH_EXE} ${tsh}
> > +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>
> As you have it here, I don't think there's a way for a user to override
> these defaults (unless there's something about the manual workaround you
> mentioned earlier that allows it). Since a user could feasibly want to s=
et
> their own options, could you add a build variable to CMakeLists.txt like
> 'GIT_TEST_OPTS'? You could use it to set the default options you have he=
re,
> but a user could still specify their own value at build time to override=
.

Indeed, there is no way to override this, unless the user edits the
(Git-tracked) `CMakeLists.txt` file and then re-configures the cache.

In my experience, the most common scenario where a developer needs to pass
options to test script is when they need to restrict execution to
individual test cases via, say, `--run=3D1,29`.

Such a use case cannot be covered via the CMake approach because it is not
fine-grained enough: any options the user could set would apply to the
entire test suite.

I added a comment to the commit message advising users to run the test
script manually via Git Bash instead, if they wish to pass a different set
of command-line options to the test script.

Thanks,
Dscho

>
> >  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
> >  endforeach()
> >
>
>
