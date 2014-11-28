From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [ANNOUNCE] Git v2.2.0
Date: Fri, 28 Nov 2014 10:48:51 +0100
Message-ID: <54784503.80108@drmicha.warpmail.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com> <20141127213224.GA27443@dispater.uplinklabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Steven Noonan <steven@uplinklabs.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 10:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuIAf-0006vd-2Z
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 10:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbaK1Js4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 04:48:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33862 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751041AbaK1Jsx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 04:48:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9DF71204A8
	for <git@vger.kernel.org>; Fri, 28 Nov 2014 04:48:52 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 28 Nov 2014 04:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=YZjJSmMeC1apr5+vbj5O0v
	Dt5Lw=; b=JjczcaLt1AYYSdUXs5UgM55dm5Cs/SjaqqDiirgu22A/WUXfaH+xdW
	4bekHWUFSLosuUaRqu2HNOx9ViEVKhxsC4LANVFzw6kCrHgbFBXw9b5bPlBGLU11
	xQe8doxzF2ut/W54OleA9PuKaqCMkCPFKrGaWU/4ZRmx7JjDhZvOs=
X-Sasl-enc: i9m7sRKn6ke6WLmDdpkzJ8mhz65QLgb5cLao0dgmCHh1 1417168132
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EA5D8C00282;
	Fri, 28 Nov 2014 04:48:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141127213224.GA27443@dispater.uplinklabs.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260359>

Steven Noonan schrieb am 27.11.2014 um 22:32:

> 
> I'm sad to report that I'm getting test failures with this release.
> Built from git and did 'make -C t prove NO_SVN_TESTS=1' and got this
> result:
> 
> $ make -j8
> $ make -C t prove NO_SVN_TESTS=1 PROVE="prove -j8"
> [...]
> Test Summary Report
> -------------------
> t4202-log.sh                                     (Wstat: 256 Tests: 42 Failed: 2)
>   Failed tests:  41-42
>   Non-zero exit status: 1
> t5534-push-signed.sh                             (Wstat: 256 Tests: 7 Failed: 2)
>   Failed tests:  6-7
>   Non-zero exit status: 1
> t5801-remote-helpers.sh                          (Wstat: 256 Tests: 28 Failed: 2)
>   Failed tests:  21-22
>   Non-zero exit status: 1
> t6050-replace.sh                                 (Wstat: 256 Tests: 33 Failed: 4)
>   Failed tests:  30-33
>   Non-zero exit status: 1
> t6300-for-each-ref.sh                            (Wstat: 256 Tests: 134 Failed: 19)
>   Failed tests:  115-133
>   Non-zero exit status: 1
> t7510-signed-commit.sh                           (Wstat: 256 Tests: 10 Failed: 10)
>   Failed tests:  1-10
>   Non-zero exit status: 1
> t7612-merge-verify-signatures.sh                 (Wstat: 256 Tests: 6 Failed: 5)
>   Failed tests:  2-6
>   Non-zero exit status: 1
> t7600-merge.sh                                   (Wstat: 256 Tests: 49 Failed: 2)
>   Failed tests:  48-49
>   Non-zero exit status: 1
> t7004-tag.sh                                     (Wstat: 256 Tests: 136 Failed: 32)
>   Failed tests:  65-66, 69-72, 74-75, 77-100
>   Non-zero exit status: 1
> Files=685, Tests=11975, 88 wallclock secs ( 3.97 usr  0.70 sys + 73.84 cusr 22.10 csys = 100.61 CPU)
> Result: FAIL
> 
> 
> I suspect that gnupg v2.1 is to blame somehow (I've had similar bad behavior
> with my own projects using GPG in automation). Running through several of the
> git tests shows that gpg is failing to sign:
> 
> 
> $ make -C t t7510-signed-commit GIT_TEST_OPTS="--verbose --debug"
> make: Entering directory '/home/snoonan/Development/git/t'
> *** t7510-signed-commit.sh ***
> Initialized empty Git repository in /home/snoonan/Development/git/t/trash directory.t7510-signed-commit/.git/
> expecting success:
> [...]
> gpg: starting migration from earlier GnuPG versions
> gpg: porting secret keys from '/home/snoonan/Development/git/t/trash directory.t7510-signed-commit/gpghome/secring.gpg' to gpg-agent
> gpg: key CDDE430D: secret key imported
> gpg: key B7227189: secret key imported
> gpg: migration succeeded
> gpg: signing failed: Operation cancelled
> gpg: signing failed: Operation cancelled
> error: gpg failed to sign the data
> fatal: failed to write commit object
> gpg: signing failed: Operation cancelled
> gpg: signing failed: Operation cancelled
> error: gpg failed to sign the data
> fatal: failed to write commit object
> not ok 1 - create signed commits
> 
> 
> If I build and install the old gnupg v2.0.26 package, things are
> happier:
> 
> 
> $ make -C t prove NO_SVN_TESTS=1 PROVE="prove -j8"
> [...]
> All tests successful.
> Files=685, Tests=11975, 87 wallclock secs ( 4.02 usr  0.69 sys + 76.41 cusr 21.96 csys = 103.08 CPU)
> Result: PASS
> 
> 
> Using Arch Linux on x86_64. Anyone else able to repro?
> 

Are you running gnome_keyring_deamon by any chance? It think it runs by
default in Gnome, claims to offer gpg_agent functionality but does not
seem to do so fully. I.e., its presence may keep gpg2.1 from starting
its own gpg-agent. But gpg2.1 ("gnupg modern branch") needs a new
gpg-agent which knows how to handle secret keys for gpg2.1.

(I may take a shot at trying, but I'm on Fedora - they're slow and
special in all things gpg/crypto. And compiling gpg2.1 means compiling
all the bits and pieces that monster consists of these days...)

Michael
