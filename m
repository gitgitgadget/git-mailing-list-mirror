Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B3C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFD42089D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 08:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lamizhZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUIyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:54:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:37705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfKUIyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 03:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574326455;
        bh=BsVAhw0F5d2+OSAHrJrH6ilFC5AoP8UOpCVRFUmBnaA=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=lamizhZSCChuvdW+h6WAqCfjKlIg68ljhMkmwmIxfva9+qIpkBy/ZWgaqgS0/nORb
         Hhjolbyu2vxPNrh+N0642awUnXRps2kw3fIgGFX2Gteu/CrBCYrBdv3Dz+i7oJ9JFu
         Jmvo6sC2bIZo2C6THrQNxuhZEoR9Sg+Mnb1htITw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1hyNbo2hj1-00aDzV for
 <git@vger.kernel.org>; Thu, 21 Nov 2019 09:54:15 +0100
Date:   Thu, 21 Nov 2019 09:54:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     git@vger.kernel.org
Subject: A helper for interactive rebases with conflicts
Message-ID: <nycvar.QRO.7.76.6.1911210941570.31080@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aYOI5EpgpO7V6jVbT1ibj5aYT6Ynp4DBZFcBj5QtNKNbNRM4QHo
 bKGZt+eDHtLzBqkkeNSbM1lUe2k1CSiXNu3G7NVm1f9XoXxlUWbIb0Cs1HufOSLqcybAH2n
 1ijzy7ej+9pTIflvDUNnuUugJAFbXG3vaKEAGBr90GbM/bcTY+a2uIVg2/WCDWmjZ4q9X/C
 YMgm4ODK2aqD+GnjJeDaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Smot12mKJY=:pYW5IFfNhinxxUXagKR6qT
 0Er8/LMldp2QqA+k6RRMhUO8Qs5BR+wQ99VB4ocDHk7EW6C1ccAqHW3Nm6MEbTFgPBofyX2Kz
 uVcsi7qBVTgfLGZ7qVtAEfMalri6xLrAykGQt33gPUkabE2cUpQF18zs6s5W2aD6y/SumxUO6
 J8N4Rtsy1fcCwIyikS9axX+ss2tikXWzLYhf99JEBrS8wRawCh221u+F3wLgJO2qsgfqCEolq
 9THNCXRPTLvoNsNutBN00B32txaREYUGVAbnWmr5MuTAaJLuLRj88zikoNdufIU3i/uPvmq1v
 ikyc47lucbAsd+jP6yHhycraloy7oYtH2LUtua3eQx9ACMMBNCY3ocqWSltTc7v0oTI44yshQ
 po06Qb0vD/R/wdG6mYzl1UjGlLFsptoNdFF59UNTQCCCux26r/4I/M+R/PqcdNjtQ4KjxOLdK
 lpwJ9yJlS/F8szf2gxAk+JuMYRmUeMYDS/ZCjuC1XEpvOuNpafhWC7IIaKo+AcihMfduZeqxI
 gCb3ZnXk5RnaB8UiResR8DemlGIUqiNwzfmgbiAc7o8w/oVGdC100KvOZBxUAJViO+Lt3fTd3
 gQkrl/lAu1ZAhU90DT5DEgybKSuDhTfEIujblfuACMPoQdO0LfRt4WCBiNlo7JA7fDsCZWc+o
 4iMoqA7ee+w8oS3/RSnAyTa4q61hgQr35PkIjceuf4nb9abEwmw1GZLfJFxkHqAiHrYMMWvGo
 S2dh+7754ahBpraOexgEcOOurhQygFK6mIa0xzcal+1Y4pOrLK9ml63KtpcAxv1S8QPo4C4pP
 4hwPQfQo40BONHvhkNl+SAFZO0WsGg1JDVL3jEE7Oe8mPublkw2xsSE96i0azCrHgbkbU++PL
 3gZMNr9xioJ1rDz6Y6eVdOPpToWtXjTCLddyKdrgplHKNz/74vO5B+XygGHt+GjbGexJHMe0t
 b6O0kqxDw+ZKac4u4qnjqs53bmWamPhwolX4cWeJL8+BnUKm3d+9l1y04tB2mTIwvCXJhv9uM
 m+P5QSoDSwguPlW6K0G05cq4i44SZy6UmAQq4y03JboyA2d0slBpO8jZz9KSL7vI+kMPwvdUU
 efCv2eUEKnFSQ/Lw/jpujXdYxeHnyQEw4vL6CR6UGb60ceK9IlNS2xRxzKZtPkkkVtB7wbHgP
 lm4nDv7Q5WxU38wQW4D/qXuKy9QJQzqKSL9MPwN7ushRmVgbawdNBohFTeA5fdSq7cdOzcQj5
 x8AF9nDWQH7T6YMf++J/dqM/Y5SU/HXylzgaB6kviAM+MZ5EE7odQb2A1kTY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

I frequently find my interactive rebases being interrupted with conflicts
due to already-upstreamed patches. Typically, these patches should be left
out from the todo list (because it uses the `right_only` flag of the
revision walker), but that logic can fail when passing an `--onto`
parameter: the upstreamed patch might not be part of the symmetric range
used to generate the todo list.

For these cases, I wrote this little script, which looks at the oneline of
the commit which could not be cherry-picked, tries to find it in the
commits reachable from HEAD (but not from the cherry-picked commit), and
once found, runs a range-diff:

-- snip --
#!/bin/sh

string2regex () {
	echo "$1" | sed 's/[]\\\/[*?]/\\&/g'
}

compare_to_upstream_commit () { # [<tip-commit>] [<upstream-branch>] [<commit-count>]
	tip=HEAD
	upstream=upstream/master
	count=1

	test $# -gt 0 ||
	test ! -f "$(git rev-parse --git-path rebase-merge/stopped-sha)" ||
	set -- stopped-sha

	case "$1" in
	stopped|stopped-sha)
		tip="$(cat "$(git rev-parse --git-path rebase-merge/stopped-sha)")" &&
		git rev-parse -q --verify "$tip" ||
		die "Could not get stopped-sha; Not in a rebase?\n"
		upstream=HEAD
		shift
		;;
	*[^0-9a-f]*) ;; # not a tip commit
	?*) tip="$(git rev-parse --verify "$1"^0)" || die "Could not parse $1"; shift;;
	esac

	case "$1" in
	*[^0-9]*) upstream="$1"; shift;;
	esac

	case "$1" in
	''|*[^0-9]*) ;; # not a count
	*) count=$1; shift;;
	esac

	test 0 = $# ||
	die "Unhandled argument(s): $*"

	oneline="$(git show -s --format=%s $tip)" &&
	regex="$(string2regex "$oneline")" &&
	upstream_commit="$(git rev-list --no-merges -1 --grep="$regex" $tip.."$upstream")" &&
	{ test -n "$upstream_commit" ||
		upstream_commit="$(git rev-list --no-merges -1 -i --grep="$regex" $tip.."$upstream")"; } &&
	{ test -n "$upstream_commit" ||
		upstream_commit="$(git range-diff -s $tip^..$tip $tip.."$upstream" |
			sed -n 's/^[^:]*:[^:]*=[^:]*: *\([^ ]*\).*/\1/p')"; } &&
	{ test -n "$upstream_commit" ||
		upstream_commit="$(git range-diff --creation-factor=95 -s $tip^..$tip $tip.."$upstream" |
			sed -n 's/^[^:]*:[^:]*=[^:]*: *\([^ ]*\).*/\1/p')"; } &&
	test -n "$upstream_commit" ||
	die "Could not find upstream commit for '$oneline'"

	git range-diff --creation-factor=95 "$tip~$count..$tip" "$upstream_commit~$count..$upstream_commit"
}

compare_to_upstream_commit "$@"
-- snap --

As you can see, this script does more than just handle interrupted
rebases: it also allows you to specify a tip commit, an upstream branch
and a commit count to conveniently find the tip commit in the upstream
branch and then do a range-diff of <commit-count> patches.

Obviously, the described logic fails badly when the oneline has been
changed, so the script falls back to running a full range-diff and seeing
whether it can identify the upstream commit that way. If that fails, too,
it runs the range-diff again with a looser net.

Maybe this script will prove useful to somebody else than me, too?

Ciao,
Johannes
