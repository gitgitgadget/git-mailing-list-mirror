Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35BC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjHEOhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOht (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:37:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC7FE7
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246261; x=1691851061; i=l.s.r@web.de;
 bh=k6v4gvXR0gGDlIXmis3AUbBW039nh4y/TI6Isi8pHTE=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=WTpXi0J1jeONg+cSZM8RkXm6P5jyd4toF5fCk6CquA7N37M7/XqkJulA3ZlxsLwN4hxog6v
 4fzrgAFtCRz1q/9aJ7tfFJlM8yLiR28SidReaIF/T+479AJovTgbM7fUB7yLgzR2EgUysD/Ye
 0VnIVRDgeY8R0NmwfcJQ2KM2ywZr9QmRVfthiMql1L0PfLZysAq9jLwzk27voxO/VND5ztRGe
 dGqIqvDARublsf7QAIDoHsgUlN6PQuQzZ/mZKeT1s22rA7OfrmmIe2fkGhbfKOPRyq8fCYjP9
 UVGBkqNAW+g/sIUdBoYowFSURDyAQT4yvzU0lt8oUKBW0m0Z9fxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1qaIka0vob-00AFth; Sat, 05
 Aug 2023 16:37:41 +0200
Message-ID: <d9bb18cc-0290-c244-c2ef-19050d69d584@web.de>
Date:   Sat, 5 Aug 2023 16:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 1/8] subtree: disallow
 --no-{help,quiet,debug,branch,message}
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X1Nqzxs0mVW4vo3GnqmC4VgmOdv+L1Zwspjsx/R/xFg0z9od3dJ
 3dt80xZq92j6O9kLk1G1MW8JABRlEomUQhczyu+3zbtC+9QrOOM7TBxrXJIiEZktZCdVl3k
 lHPxeEIwDlhDdKQB1MhUQTVtILkqULajwt50cxtKMIak93jUAENwmBQh1H9XI3rqLFLrgg6
 PbuOeaEJ3rmzGA/t8pm0Q==
UI-OutboundReport: notjunk:1;M01:P0:xIk42tJfR3o=;pCs5AsodWQ246OVihbvgeVFbbUq
 53Qi3GBnp24m36uCmW4IRe1FIy5y1+6qmVCinB0F9BBamo5ewPZ5DcW03hMkYXNbdRaRHaqwS
 Gl65vGHRsXXtAyw4j8xnvPZdx0ptcUQpMWOKDPjXtLzBE7R0OxH21Q29qhDlroTZwZZ5WbTEe
 2GETiENKUm/B/n94WxRglttA7xuAu7IcoHR3q5Oato4rqrDODQmW6ZetW0R/w0RFP0Q5rwqFC
 D0ezqzTzMw5EdQ+Fq1Vjf4NSmGLu8tJKt5d71PpjY075j/ch9LwzBaAR5PSsdcPqsk7HcsHNK
 OaOKEkCMaPfMV+C80cwXBPhSg9BqeeAwpMKXY1z4OrQYl7O8NYviyePxGSJFgD/Tm+k/y0iaa
 MUI8gb/ZXcQ46x7LOYt7fAXCOEw3ignR3Xt+J3/N33tsOmG1aIRWZ9X/4nWUl8H9ap7KQFvPr
 yn5tpaQX0PDPsNl70doM9HVnlN7vK4CSoiJv0z2rJZ38lLTbaA8YzBvuFXg2GSBpq3fLMjdPu
 Iw67hNa8kxZc+BjscdpZsAlPrPa3DI7gXRglwvjF1iWZyXwWjdb5e7hpNWUtysxqA6Te8o0r/
 pdND2+Je3b6sGpHfA+4xZi0WIzxCETnbxRD7r3iY6UYYkxIYPunDeihLW/qsWxnpnoh65hy5t
 p4hxXV/jS0MDep35OuaER6KehRMV0HW6wqbHshVRdBuA+NLdmvDvVQEEin7uI4/I1BPizXuSQ
 TldW6PndNYmj5SbLTMsLHHocSU0fVPeGUYKXUiWMv9mcB3p5ZlUQ7RF80yxsHvH9a9LcOjisT
 unVm2hSOCFZ2+oUNEjPUASRf86zBRjI7P8Owy23frK4ZFAuQk1NhPIEccbjF1xmOIZFWC8nKi
 Z5MdgJlu/XaEtYZzxHo2yJwEWXCypH2Wt7acV0IG5CIvd/NvGFbonErGj/77VEkRtjx39Elpr
 U6I7FQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git subtree" only handles the negated variant of the options annotate,
prefix, onto, rejoin, ignore-joins and squash explicitly.  help is
handled by "git rev-parse --parseopt" implicitly, but not its negated
form.  Disable negation for it and the for the rest of the options to
get a helpful error message when trying them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 contrib/subtree/git-subtree.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.=
sh
index 7db4c45676..e0c5d3b0de 100755
=2D-- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -33,19 +33,19 @@ git subtree split --prefix=3D<prefix> [<commit>]
 git subtree pull  --prefix=3D<prefix> <repository> <ref>
 git subtree push  --prefix=3D<prefix> <repository> <refspec>
 --
-h,help        show the help
-q,quiet       quiet
-d,debug       show debug messages
+h,help!       show the help
+q,quiet!      quiet
+d,debug!      show debug messages
 P,prefix=3D     the name of the subdir to split out
  options for 'split' (also: 'push')
 annotate=3D     add a prefix to commit message of new commits
-b,branch=3D     create a new branch from the split subtree
+b,branch!=3D    create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=3D         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add' and 'merge' (also: 'pull', 'split --rejoin', and 'push=
 --rejoin')
 squash        merge subtree changes as a single commit
-m,message=3D    use the given message as the commit message for the merge=
 commit
+m,message!=3D   use the given message as the commit message for the merge=
 commit
 "

 indent=3D0
=2D-
2.41.0
