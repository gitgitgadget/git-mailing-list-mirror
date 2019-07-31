Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826441F731
	for <e@80x24.org>; Wed, 31 Jul 2019 11:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGaLZx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 07:25:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:40209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaLZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 07:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564572342;
        bh=JmJZHaX07ECSuIL9xPI8eB6mM9YWtySuGIH/f3fJN0s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RdorbMh8cor0SPrwcqu0pDlg6QysuuFx5Mf3eRmam/Oclum7MywzPNaxQB4WlT3hF
         5yVzvfHpNb+0x/VIjL3Rjd3WIiL3BTJC6LRHJr7YrrKdZ9lBoq0zu2polL+1HZ8X0c
         dbUOCxCBPP9vEwa7ACTM50rS/Xe/nnHsgsy7CeVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1hnzWB2VKj-00V9jd; Wed, 31
 Jul 2019 13:25:42 +0200
Date:   Wed, 31 Jul 2019 13:25:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/12] t/lib-rebase: prepare for testing `git rebase
 --rebase-merges`
In-Reply-To: <20190726210820.GF9319@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1907311306360.21907@tvgsbejvaqbjf.bet>
References: <pull.294.git.gitgitgadget@gmail.com> <ae9e72b73bf2da0de3a5369748ebd358656588d9.1564049474.git.gitgitgadget@gmail.com> <20190726074317.GD9319@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1907261555410.21907@tvgsbejvaqbjf.bet>
 <20190726210820.GF9319@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wjszJ4wHrPG/uP03JWSzAQsmon+OoJ7QIBdQMqLPDuY7+KpMJ18
 tmZUXS1QV6WFPN2RGm53Pin7smIYIn8g4XC+4OneEBxKkcN8PueswZ2K5z4L9VYl7jwjsPa
 gTxfm+8FxBk7Zk/sGBpFSaY7oKus9cv+KhmtbnhfjZdfDOu0McxNiYk6WFnYDv74PxGY3uj
 w1A9FtipDQ2CxxN8vU2OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s/HH5wGF2MQ=:a1uJ+Tu+LE69KM2LQKVgQg
 Nkr7enWTFLHSTEQnSxLQ+wGKePjJNx+TojSYPmMU8qVc313bOGgnDm7zxnMxnv32BuZFsPF8c
 zPF4khoYcbAFgLWTYF4JdgOpKA7wsBVXtKFh+FS8Z1c0bes1nhXswsG5QzHm9mKCGPHx0sSa2
 hcOoD3M8RR/r/tUFGzmxToOX2nqFpDA+ZDDuVzB5Ov+55tLguioyUQteD9Ugbfw3vbZ8QmM/D
 SmbaCYcmItT158zmkwk4RGpYZe3LJ83kyysC0ww46OlzC6EEKsBeTJu+QEv3rvWxN6X2n6pZ5
 AT8zdgoPKTSB7n7ErrHGBSkE+QYW+YF+mA6EGZY6ZPqem68W765RxtZ5UQheqolS66wNzKj0c
 2IiO52ZgTxOOrI5BseeNOxtA8z2ITOp43NqI21qhNtcWyuz8WrB50KMep4ehaHMDPFzJnzV6n
 AgoWXL6lr11OZfQKEvGc3lo/3XS29M0JvAK66g0U5HT8tx3/XCn8V45iyObWlyOodiSmC4DFu
 b7clOtlw7AvNuBDy944RTD+4heoXVIlPvBoQ+h7CFlvjSGgz5ut3erEIGm0sI3tc18e0BJPnA
 Uz2QBYD1FmY9KvkjxHZc8FiM6WINL7jXoIY6uI0RdChQDk2ZfHFLVK75C8NeWQItAeWO2XAZn
 OThxTCrXAGvDlyeNH6ByXDboSrMhzNp0foAhVytDdMeeDzYwbAKUgrJKADBd8m+euXQ7k8/9t
 PbktubMaZcfLVJ11OKGtFa/EqXj8o/eWTu/1WLOjg3frxjfuMQUmtZ67zl29bE6fmWgIRuuW7
 409oFkwKHMDhOiqMElNURNULaRgrSMFgWZxcax02Wpylw5F7iCrF3Dgn/bGtwVi1mSbLs08eh
 b+HzNTkwUDMXpR1gpo7Swri+yM/43/YorBJ7NsQKHjgICCOLWKSPliWvicadJRIhstSM/Bvx4
 CNm0ilrgtUQ5+99GKSqOA6VCvjcnpbAs+sbt+budLYZNiuLRiCB/BLtdkWFpsxe66zPIAsG8w
 sl5zF8YPy++/pnfzLhtRiV/6DIoz8u8x2+AigWfrBpZ6tWYMMN67TcpV4X0om80FhcXnE/EP6
 qfaf0PKUIU92+jrFk2mQYQnK9VxK+b67gWW
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 26 Jul 2019, brian m. carlson wrote:

> On 2019-07-26 at 14:01:03, Johannes Schindelin wrote:
> > Actually, the part that uses it is not shown in the patch (one of the
> > many, many reasons why I try to discourage patch review and encourage
> > code review instead). The relevant section currently looks somewhat li=
ke
> > this:
>
> I feel like I may have communicated poorly earlier, so let me retry
> asking this in a different way.

Actually, your communication was just fine, the misunderstanding was
entirely on my side. My apologies.

> > -- snip --
> > set_fake_editor () {
> > 	write_script fake-editor.sh <<-\EOF
> > 	case "$1" in
> > 	*/COMMIT_EDITMSG)
> > 		test -z "$EXPECT_HEADER_COUNT" ||
> > 			test "$EXPECT_HEADER_COUNT" =3D "$(sed -n '1s/^# This is a combinat=
ion of \(.*\) commits\./\1/p' < "$1")" ||
> > 			test "# # GETTEXT POISON #" =3D "$(sed -n '1p' < "$1")" ||
> > 			exit
> > 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
> > 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
> > 		exit
> > 		;;
> > 	esac
> > 	test -z "$EXPECT_COUNT" ||
> > 		test "$EXPECT_COUNT" =3D $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l)=
 ||
> > 		exit
> > 	test -z "$FAKE_LINES" && exit
> > 	grep -v '^#' < "$1" > "$1".tmp
> > 	rm -f "$1"
> > 	echo 'rebase -i script before editing:'
> > 	cat "$1".tmp
> > 	action=3Dpick
>
> I believe you changed this line to "action=3D\&".
>
> > 	for line in $FAKE_LINES; do
> > 		case $line in
> > 		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
> > 			action=3D"$line";;
> > 		exec_*|x_*|break|b)
> > 			echo "$line" | sed 's/_/ /g' >> "$1";;
> > 		"#")
> > 			echo '# comment' >> "$1";;
> > 		">")
> > 			echo >> "$1";;
> > 		bad)
> > 			action=3D"badcmd";;
> > 		fakesha)
> > 			echo "$action XXXXXXX False commit" >> "$1"
>
> And my question was about this line.

Right. It would append `& XXXXXXX False commit`, which is not a valid
todo command.

So something like

-			echo "$action XXXXXXX False commit" >> "$1"
+			test \& =3D "$action" && c=3Dpick || c=3D$action
+			echo "$c XXXXXXX False commit" >>"$1"

would be needed.

However, what makes me really worried now is that our test suite did not
have a fit about this. The CI build passes the test suite on Windows,
macOS and Linux: https://github.com/gitgitgadget/git/runs/176651523.
>
> > 			action=3Dpick;;
> > 		*)
> > 			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
> > 			action=3Dpick;;
> > 		esac
> > 	done
> > 	echo 'rebase -i script after editing:'
> > 	cat "$1"
> > 	EOF
> >
> > 	test_set_editor "$(pwd)/fake-editor.sh"
> > }
> > -- snap --
> >
> > Most importantly, `action` is used here:
> >
> >                         sed -n "${line}s/^pick/$action/p" < "$1".tmp >=
> "$1"
> >
> > and I changed it to
> >
> > 			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
> >
> > In other words, rather than expecting the lines that are used by the
> > fake editor to start with `pick`, after this patch, the tests expect t=
he
> > todo lists to start with a command consisting of lower-case ASCII
> > letters (which catches `pick`, of course, but also `label`, `reset` an=
d
> > `merge`).
> >
> > After this patch, the fake editor also does not try to replace whateve=
r
> > command it finds by `pick`, but it keeps it as-is instead.
>
> Right, that's how I read it, and that part I agree with. I think my
> question is this: in what case do we execute the "fakesha" case? Are we
> guaranteed that when we do, action isn't "&"? "&" seems fine for the
> right-hand side of a sed s-statement, but not as the beginning of a
> typical line in a sequencer file.

Indeed, the sequencer should throw a real tantrum about this and not
even bother to start.

But then, the same would hold true for an obviously invalid commit hash.

> I ask because if we're testing a failure case, we want it to fail for
> the right reason (e.g., the commit doesn't exist), and not because we're
> producing invalid data.

Indeed. I have even come to the conclusion that our
`test_expect_failure` command encourages exactly this type of problem:
in the beginning, those test cases might actually be correct, but over
time they are prone to fail for all the wrong reasons, because we do not
actually test for a specific failure more, we just say that we expect
this test case to fail (and that this indicates a bug).

> If the answer in this case is, "Well, we'll always have something else
> before it which will set $action properly," then that's fine. This is
> test code, so it need not be bulletproof, but I did want to ask.

I think you are perfectly sane to question this, and to expect me to
double check.

So, double check I did. Turns out there is a single user of the
`fakesha` thing, and it is hidden deep in t3404, prefixed by
`test_must_fail`:

=2D- snip --
test_expect_success 'static check of bad SHA-1' '
	rebase_setup_and_clean bad-sha &&
	set_fake_editor &&
	test_must_fail env FAKE_LINES=3D"1 2 edit fakesha 3 4 5 #" \
		git rebase -i --root 2>actual &&
	test_i18ngrep "edit XXXXXXX False commit" actual &&
	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
	FAKE_LINES=3D"1 2 4 5 6" git rebase --edit-todo &&
	git rebase --continue &&
	test E =3D $(git cat-file commit HEAD | sed -ne \$p)
'
=2D- snap --

As you can see, contrary to my expectations it does verify the output.
It *also* changes the action to `edit`, which is the reason why there is
no `&` ;-)

But I think you are correct, I should make sure that the fake editor is
still correct with respect to the `pick` command.

> If I'm still misunderstanding something, I apologize.

I am really impressed and inspired by your gentle language. Thank you
for this.

Ciao,
Dscho
