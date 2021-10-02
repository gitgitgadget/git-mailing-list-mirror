Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C9EC433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118D361B06
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 13:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhJBNkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 09:40:47 -0400
Received: from mout.web.de ([212.227.15.14]:58151 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhJBNkq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 09:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633181931;
        bh=kj8tBdB19VbMm+9Tdz4P493A0u4XFAts+Pqg1rEZmnk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ach7W2U4QjIhkgvo7I/g2bweyTyi/LD7peTaesaip1ZwQXYgi16X5IUeUZD/W+Qz+
         HyrzjopjMPCk5ew6+R6EC8vlsGvSY46LviQ7XbLSvc6vWmSxRv6HRAQ8Ov3mEGcP+w
         cihnkzZryuN+XM8H5mjekNel6cMUin0MmtZIi+I0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N1uAv-1mvBFS0RdB-011sYM; Sat, 02 Oct 2021 15:38:51 +0200
Subject: Re: [PATCH 00/11] rebase: reset_head() related fixes and improvements
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <xmqqbl482rby.fsf@gitster.g> <xmqq4ka02fc4.fsf@gitster.g>
 <ddf5e9c2-3211-cec2-cd18-2a083e279ccb@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5af2ddb1-0330-a987-9887-14331f6ea006@web.de>
Date:   Sat, 2 Oct 2021 15:38:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ddf5e9c2-3211-cec2-cd18-2a083e279ccb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O38AXgx0jYhQmFylQ/4Rbur576o8kX+QYCt3m7vJ5MUZYcdGKtJ
 10A6TFfzmSgwGxOSNrwmFOEqQVuRBDeNDqAfs3MbX0hIjQqhW2KetXqaua7eTmwJLxhkd8r
 QMNV7DKE8lfuy57zsUNURzyeE9gfHA/AjRE6QZVpoXQJha4RF8+O9VXxvPbvxxN+hdyCapc
 BF44sIu1o6noMvGX7TrvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4UKinRcnhMI=:kk8B74V8YriAzwXPL+Usmk
 DORSOE0EdNZ7Rq8sWcYp+TNrVY5aajEYy6AMUT8HZBQhjVhS9J1L4vKfj0Inc8xEPYqulh/yC
 jI8WcYOKxYM7HK02BM2hrpM/x0jzw7GMq1ei3E+F5HFfZTsyuijHcPiMo+r9vd9rvIpSbFamI
 WetDjrhiRjOU8nEswTBWCP7IN+oriFhyQEwD/7e46SFCyzNmF3bUJI5ByDH5DbWbZTQQQpoFV
 I4hNhg0WwrWpi49qDNKjrWyJWvFdY9OS0Fve2sV1j5Yq2nJGJuq2MkXeU6mdVGUvPomM9Rm69
 7B0tbZllMs/+P4TjxfottC79/MY/0v9HbM4OHSAmexfAbeQRuvBRfJLiuB9DW45jYn/hM7AU2
 lX3lTQYGPcItmVUn0TGH8/dZS4ZrBUxwDw/EYB6mWezSPyHPB3loe4L/zr9U/bOLbDPm9siR9
 pN8utFTAy2T2JOo8/3QxUNf0f3Hi7+rxZpbFelxhMC0VRxMxm2mrBYz6LGDPOEh8BQBawz1Dv
 L8RARYlQjT5q38zKmfusz/EjPkQokidY24q2blLcmlL8s7dyEb75SoqF5Z/QFoKs3nXgKYH+o
 UybDFiUOdZr59MWxaJSiVOgeYtgA4pcXlTOG5Nz9YRY9s936p4f5JWS6paK/hI+UJ+sBgd4f5
 5gd2Y2hOd0yus3Iq7P04nomHEAv8kEXOuNSXjkdDBecRqrxph1r3/T9T4lJC+u7aqt8gHni53
 J+4t4WO+YWjerRiupQLNRlgUypn3rr44rok+2Qv7W5nS4k4SZeQKqRl3Fi1dOs/1Lqeqxn7rz
 eeyM/GlYVuWc1fzDCjFZkAOW0rj2mwwW6hLEbYqABW5C9sj14vhieTM0wP84Y/N9fuRjwhQmD
 cFSlzgKk5eXGufy3Z3UP0cTyKqjCdMRNx9lamQq8n50e21xUgLbr0QKmiihY4QCafrrDyWij0
 +k07lXb/pE3bh2IwcoVQ4hRgKC0t4itMYTJdGLEfXaLmK/q/fWF94m8uXd8eP3fVCy8MmwJ3X
 wgSdUeIQo4suHB62BxdjE3zhNjk4gs/bWrXeJVL1NBFxgNsWqcvKMq1nFO1Udva7/HTp1+HLE
 k1aXFpAaII2tZc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.10.21 um 14:27 schrieb Phillip Wood:
> Hi Junio
>
> On 02/10/2021 05:58, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> When merged with other topics in flight in 'seen', this seems to
>>> fail the t1092 test (most likely, ds/add-rm-with-sparse-index is
>>> what this interacts badly with).
>
> Oh dear, thanks for letting me know.
>
>> There are Two CI runs at GitHub:
>>
>> =C2=A0 - https://github.com/git/git/actions/runs/1297117791 (d3a1c4e)
>> =C2=A0 - https://github.com/git/git/actions/runs/1297232973 (a1108c2)
>>
>> The difference between the former (which passes all the tests) and
>> he latter (which fails) are only two topics:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 $ git log --first-parent --oneline d3a1c4e..a1=
108c2
>> =C2=A0=C2=A0=C2=A0=C2=A0 a1108c2b1b Merge branch 'hn/reftable' into see=
n
>> =C2=A0=C2=A0=C2=A0=C2=A0 e575f29006 Merge branch 'pw/fix-some-issues-in=
-reset-head' into seen
>>
>> I think the following is the same failure I saw earlier
>>
>> =C2=A0=C2=A0=C2=A0 https://github.com/git/git/runs/3773780195?check_sui=
te_focus=3Dtrue#step:6:5033
>>
>> that the write-tree codepath hits assertion failure by detecting a
>> corruption in the cache-tree data structure.
>
> The test that fails (t1092-sparse-checkout-compatibility.sh:'merge, cher=
ry-pick, and rebase') was introduced by c0b99303db ("t1092: add cherry-pic=
k, rebase tests", 2021-09-08) and is in v2.33.0. It does not test the "app=
ly" backend of rebase, changing it to do so makes it fail on the current m=
aster as that backend already uses reset_head() for the initial checkout s=
o it is an existing bug that is exposed by the changes in this series. It =
seems to be a use-after-free (see below) I'll try and investigate but I've=
 got no idea what is going on at the moment - the index is not my area of =
expertise.
>
> Best Wishes
>
> Phillip
>
> =3D=3D74345=3D=3DERROR: AddressSanitizer: heap-use-after-free on address=
 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
> READ of size 4 at 0x606000001b20 thread T0
> =C2=A0=C2=A0=C2=A0 #0 0x557cbe82d3a1 in verify_one /home/phil/src/git/ca=
che-tree.c:863
> =C2=A0=C2=A0=C2=A0 #1 0x557cbe82ca9d in verify_one /home/phil/src/git/ca=
che-tree.c:840
> =C2=A0=C2=A0=C2=A0 #2 0x557cbe82ca9d in verify_one /home/phil/src/git/ca=
che-tree.c:840
> =C2=A0=C2=A0=C2=A0 #3 0x557cbe82ca9d in verify_one /home/phil/src/git/ca=
che-tree.c:840
> =C2=A0=C2=A0=C2=A0 #4 0x557cbe830a2b in cache_tree_verify /home/phil/src=
/git/cache-tree.c:910
> =C2=A0=C2=A0=C2=A0 #5 0x557cbea53741 in write_locked_index /home/phil/sr=
c/git/read-cache.c:3250
> =C2=A0=C2=A0=C2=A0 #6 0x557cbeab7fdd in reset_head /home/phil/src/git/re=
set.c:87
> =C2=A0=C2=A0=C2=A0 #7 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
> =C2=A0=C2=A0=C2=A0 #8 0x557cbe5bd151 in run_builtin /home/phil/src/git/g=
it.c:461
> =C2=A0=C2=A0=C2=A0 #9 0x557cbe5bd151 in handle_builtin /home/phil/src/gi=
t/git.c:714
> =C2=A0=C2=A0=C2=A0 #10 0x557cbe5c0503 in run_argv /home/phil/src/git/git=
.c:781
> =C2=A0=C2=A0=C2=A0 #11 0x557cbe5c0503 in cmd_main /home/phil/src/git/git=
.c:912
> =C2=A0=C2=A0=C2=A0 #12 0x557cbe5bad28 in main /home/phil/src/git/common-=
main.c:52
> =C2=A0=C2=A0=C2=A0 #13 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/lib=
c.so.6+0x27b24)
> =C2=A0=C2=A0=C2=A0 #14 0x557cbe5bcb8d in _start (/home/phil/src/git/git+=
0x1b9b8d)
>
> 0x606000001b20 is located 0 bytes inside of 56-byte region [0x606000001b=
20,0x606000001b58)
> freed by thread T0 here:
> =C2=A0=C2=A0=C2=A0 #0 0x7fdd4bacff19 in __interceptor_free /build/gcc/sr=
c/gcc/libsanitizer/asan/asan_malloc_linux.cpp:127
> =C2=A0=C2=A0=C2=A0 #1 0x557cbe82af60 in cache_tree_free /home/phil/src/g=
it/cache-tree.c:35
> =C2=A0=C2=A0=C2=A0 #2 0x557cbe82aee5 in cache_tree_free /home/phil/src/g=
it/cache-tree.c:31
> =C2=A0=C2=A0=C2=A0 #3 0x557cbe82aee5 in cache_tree_free /home/phil/src/g=
it/cache-tree.c:31
> =C2=A0=C2=A0=C2=A0 #4 0x557cbe82aee5 in cache_tree_free /home/phil/src/g=
it/cache-tree.c:31
> =C2=A0=C2=A0=C2=A0 #5 0x557cbeb2557a in ensure_full_index /home/phil/src=
/git/sparse-index.c:310
> =C2=A0=C2=A0=C2=A0 #6 0x557cbea45c4a in index_name_stage_pos /home/phil/=
src/git/read-cache.c:588
> =C2=A0=C2=A0=C2=A0 #7 0x557cbe82ce37 in verify_one /home/phil/src/git/ca=
che-tree.c:850
> =C2=A0=C2=A0=C2=A0 #8 0x557cbe82ca9d in verify_one /home/phil/src/git/ca=
che-tree.c:840
> =C2=A0=C2=A0=C2=A0 #9 0x557cbe82ca9d in verify_one /home/phil/src/git/ca=
che-tree.c:840
> =C2=A0=C2=A0=C2=A0 #10 0x557cbe82ca9d in verify_one /home/phil/src/git/c=
ache-tree.c:840
> =C2=A0=C2=A0=C2=A0 #11 0x557cbe830a2b in cache_tree_verify /home/phil/sr=
c/git/cache-tree.c:910

Looks like cache_tree_verify() indirectly triggered ensure_full_index(),
which throws the cache_tree away, then kept going using stale pointers.
It should instead stop and start over in such a case, no?

> =C2=A0=C2=A0=C2=A0 #12 0x557cbea53741 in write_locked_index /home/phil/s=
rc/git/read-cache.c:3250
> =C2=A0=C2=A0=C2=A0 #13 0x557cbeab7fdd in reset_head /home/phil/src/git/r=
eset.c:87
> =C2=A0=C2=A0=C2=A0 #14 0x557cbe72147f in cmd_rebase builtin/rebase.c:207=
4
> =C2=A0=C2=A0=C2=A0 #15 0x557cbe5bd151 in run_builtin /home/phil/src/git/=
git.c:461
> =C2=A0=C2=A0=C2=A0 #16 0x557cbe5bd151 in handle_builtin /home/phil/src/g=
it/git.c:714
> =C2=A0=C2=A0=C2=A0 #17 0x557cbe5c0503 in run_argv /home/phil/src/git/git=
.c:781
> =C2=A0=C2=A0=C2=A0 #18 0x557cbe5c0503 in cmd_main /home/phil/src/git/git=
.c:912
> =C2=A0=C2=A0=C2=A0 #19 0x557cbe5bad28 in main /home/phil/src/git/common-=
main.c:52
> =C2=A0=C2=A0=C2=A0 #20 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/lib=
c.so.6+0x27b24)
>
> previously allocated by thread T0 here:
> =C2=A0=C2=A0=C2=A0 #0 0x7fdd4bad0459 in __interceptor_calloc /build/gcc/=
src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:154
> =C2=A0=C2=A0=C2=A0 #1 0x557cbebc1807 in xcalloc /home/phil/src/git/wrapp=
er.c:140
> =C2=A0=C2=A0=C2=A0 #2 0x557cbe82b7d8 in cache_tree /home/phil/src/git/ca=
che-tree.c:17
> =C2=A0=C2=A0=C2=A0 #3 0x557cbe82b7d8 in prime_cache_tree_rec /home/phil/=
src/git/cache-tree.c:763
> =C2=A0=C2=A0=C2=A0 #4 0x557cbe82b837 in prime_cache_tree_rec /home/phil/=
src/git/cache-tree.c:764
> =C2=A0=C2=A0=C2=A0 #5 0x557cbe82b837 in prime_cache_tree_rec /home/phil/=
src/git/cache-tree.c:764
> =C2=A0=C2=A0=C2=A0 #6 0x557cbe8304e1 in prime_cache_tree /home/phil/src/=
git/cache-tree.c:779
> =C2=A0=C2=A0=C2=A0 #7 0x557cbeab7fa7 in reset_head /home/phil/src/git/re=
set.c:85
> =C2=A0=C2=A0=C2=A0 #8 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
> =C2=A0=C2=A0=C2=A0 #9 0x557cbe5bd151 in run_builtin /home/phil/src/git/g=
it.c:461
> =C2=A0=C2=A0=C2=A0 #10 0x557cbe5bd151 in handle_builtin /home/phil/src/g=
it/git.c:714
> =C2=A0=C2=A0=C2=A0 #11 0x557cbe5c0503 in run_argv /home/phil/src/git/git=
.c:781
> =C2=A0=C2=A0=C2=A0 #12 0x557cbe5c0503 in cmd_main /home/phil/src/git/git=
.c:912
> =C2=A0=C2=A0=C2=A0 #13 0x557cbe5bad28 in main /home/phil/src/git/common-=
main.c:52
> =C2=A0=C2=A0=C2=A0 #14 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/lib=
c.so.6+0x27b24)
>
> SUMMARY: AddressSanitizer: heap-use-after-free /home/phil/src/git/cache-=
tree.c:863 in verify_one
> Shadow bytes around the buggy address:
> =C2=A0 0x0c0c7fff8310: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
> =C2=A0 0x0c0c7fff8320: fd fd fd fa fa fa fa fa fd fd fd fd fd fd fd fa
> =C2=A0 0x0c0c7fff8330: fa fa fa fa 00 00 00 00 00 00 00 02 fa fa fa fa
> =C2=A0 0x0c0c7fff8340: fd fd fd fd fd fd fd fa fa fa fa fa 00 00 00 00
> =C2=A0 0x0c0c7fff8350: 00 00 00 02 fa fa fa fa fd fd fd fd fd fd fd fa
> =3D>0x0c0c7fff8360: fa fa fa fa[fd]fd fd fd fd fd fd fa fa fa fa fa
> =C2=A0 0x0c0c7fff8370: 00 00 00 00 00 00 00 02 fa fa fa fa fd fd fd fd
> =C2=A0 0x0c0c7fff8380: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 02
> =C2=A0 0x0c0c7fff8390: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
> =C2=A0 0x0c0c7fff83a0: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
> =C2=A0 0x0c0c7fff83b0: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
> =C2=A0 Addressable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 00
> =C2=A0 Partially addressable: 01 02 03 04 05 06 07
> =C2=A0 Heap left redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fa
> =C2=A0 Freed heap region:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd
> =C2=A0 Stack left redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f1
> =C2=A0 Stack mid redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f2
> =C2=A0 Stack right redzone:=C2=A0=C2=A0=C2=A0=C2=A0 f3
> =C2=A0 Stack after return:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f5
> =C2=A0 Stack use after scope:=C2=A0=C2=A0 f8
> =C2=A0 Global redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 f9
> =C2=A0 Global init order:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f6
> =C2=A0 Poisoned by user:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f7
> =C2=A0 Container overflow:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fc
> =C2=A0 Array cookie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ac
> =C2=A0 Intra object redzone:=C2=A0=C2=A0=C2=A0 bb
> =C2=A0 ASan internal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fe
> =C2=A0 Left alloca redzone:=C2=A0=C2=A0=C2=A0=C2=A0 ca
> =C2=A0 Right alloca redzone:=C2=A0=C2=A0=C2=A0 cb
> =C2=A0 Shadow gap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cc
> =3D=3D74345=3D=3DABORTING
>
>
>> e575f29006 (i.e. without the reftable topic) fails t1092.=C2=A0 If you
>> revert e575f29006^2 (i.e. the "do not fork 'git checkout'") from
>> that merge, all tests pass including t1092.
>>
>> The reftable topic is queued near the tip of 'seen' not necessarily
>> because it _breaks_ CI (I do not think it does), but it needed a
>> handful of fixup commits on top.=C2=A0 The topic needs rerolling with t=
he
>> fixes squashed in.
>>
>> Thanks.
>>
>

