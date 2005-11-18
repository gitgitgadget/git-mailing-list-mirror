From: John Benes <smartcat99s@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 19:23:32 -0600
Message-ID: <437D2D14.5080205@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>	<b0943d9e0511160311k725526d8v@mail.gmail.com>	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com> <7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 02:25:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecuyl-0006z0-EM
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 02:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVKRBXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 20:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVKRBXs
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 20:23:48 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:42310 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751335AbVKRBXr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 20:23:47 -0500
Received: by zproxy.gmail.com with SMTP id 13so73475nzn
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:23:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=kiM3rX1S+4WHT1yqzBV7K6ENg8W2XJASn9D/7RjjEiCWHMxHGHO4/7UnmaX0ACNnRw7L9nMJgc8BSaaDmA/up1D0kyLsLxYzPMdiR/4cFEX6Kf1BFVY5bADutCSkV2qRpVEZ2eS01WYNPgR7dHFnHYakD+iKfnXSxPz02TpIq3E=
Received: by 10.36.71.15 with SMTP id t15mr1779726nza;
        Thu, 17 Nov 2005 17:23:46 -0800 (PST)
Received: from ?192.168.0.198? ( [68.96.128.241])
        by mx.gmail.com with ESMTP id 40sm313749nzf.2005.11.17.17.23.45;
        Thu, 17 Nov 2005 17:23:46 -0800 (PST)
User-Agent: Thunderbird 1.5 (Windows/20051117)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12182>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>> As it turned out, not the git.c is guilty, but the missing
>> NO_MMAP=YesPlease in Cygwin section. I had it for a long time and
>> accidentally removed by the recent pull. BTW, I couldn't find nowhere
>> on original branch. Was it never submitted?
> 
> Neither 'git-whatchanged Makefile' nor 'git-whatchanged
> -SNO_MMAP Makefile' reports such on my end.  Do we need one?

The patch with the commented out option seems like it would work...

> Johannes said he tests on Cygwin as well, and I am sure there
> are others with Cygin on the list.  Help us out here please?


I was able to compile master and pu on Cygwin without NO_MMAP=YesPlease
in the Cygwin section.  However, the make test failed on the
binary-apply on both master and pu, output follows.

Commit ID's used for testing:
refs/heads/master	4e1da85d7d0480b6d9973317da4f7a5aa603fcb5
refs/heads/pu		3b4587eb3c549649af7e84659b4808003c34c2d3

make test barfing on master:
*** t4103-apply-binary.sh ***
*   ok 1: stat binary diff -- should not fail.
*   ok 2: stat binary diff (copy) -- should not fail.
*   ok 3: check binary diff -- should fail.
*   ok 4: check binary diff (copy) -- should fail.
*   ok 5: check incomplete binary diff with replacement -- should fail.
*   ok 6: check incomplete binary diff with replacement (copy) -- should
fail.
* FAIL 7: check binary diff with replacement.
        git-checkout master
                 git-apply --check --allow-binary-replacement BF.diff
* FAIL 8: check binary diff with replacement (copy).
        git-checkout master
                 git-apply --check --allow-binary-replacement CF.diff
*   ok 9: apply binary diff -- should fail.
*   ok 10: apply binary diff -- should fail.
*   ok 11: apply binary diff (copy) -- should fail.
*   ok 12: apply binary diff (copy) -- should fail.
*   ok 13: apply binary diff without replacement -- should fail.
*   ok 14: apply binary diff without replacement (copy) -- should fail.
* FAIL 15: apply binary diff.
        do_reset
                 git-apply --allow-binary-replacement --index BF.diff &&
                 test -z "$(git-diff --name-status binary)"
* FAIL 16: apply binary diff (copy).
        do_reset
                 git-apply --allow-binary-replacement --index CF.diff &&
                 test -z "$(git-diff --name-status binary)"
* failed 4 among 16 test(s)
make[1]: *** [t4103-apply-binary.sh] Error 1

make test barfing on pu:
*** t4103-apply-binary.sh ***
usage: git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r]
[--root] [<co
mmon diff options>] <tree-ish> [<tree-ish>] [<path>...]
***SNIP***

usage: git-diff-tree [--stdin] [-m] [-s] [-v] [--pretty] [-t] [-r]
[--root] [<co
mmon diff options>] <tree-ish> [<tree-ish>] [<path>...]
***SNIP***

* FAIL 1: stat binary diff -- should not fail.
        git-checkout master
                 git-apply --stat --summary B.diff
* FAIL 2: stat binary diff (copy) -- should not fail.
        git-checkout master
                 git-apply --stat --summary C.diff
*   ok 3: check binary diff -- should fail.
*   ok 4: check binary diff (copy) -- should fail.
*   ok 5: check incomplete binary diff with replacement -- should fail.
*   ok 6: check incomplete binary diff with replacement (copy) -- should
fail.
* FAIL 7: check binary diff with replacement.
        git-checkout master
                 git-apply --check --allow-binary-replacement BF.diff
* FAIL 8: check binary diff with replacement (copy).
        git-checkout master
                 git-apply --check --allow-binary-replacement CF.diff
*   ok 9: apply binary diff -- should fail.
*   ok 10: apply binary diff -- should fail.
*   ok 11: apply binary diff (copy) -- should fail.
*   ok 12: apply binary diff (copy) -- should fail.
*   ok 13: apply binary diff without replacement -- should fail.
*   ok 14: apply binary diff without replacement (copy) -- should fail.
* FAIL 15: apply binary diff.
        do_reset
                 git-apply --allow-binary-replacement --index BF.diff &&
                 test -z "$(git-diff --name-status binary)"
* FAIL 16: apply binary diff (copy).
        do_reset
                 git-apply --allow-binary-replacement --index CF.diff &&
                 test -z "$(git-diff --name-status binary)"
* failed 6 among 16 test(s)
make[1]: *** [t4103-apply-binary.sh] Error 1

- --
John Benes
GPG Fingerprint: D519 25DB BB5C 38FC 9D02  02E7 596D BC50 F880 27FA
"It is not only the living who are killed in war." - Isaac Asimov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBQ30tE2F0oWcU9kCNAQKzRQ/8DEoZTRYDcU80mzddq8AS8ClctLx8CorY
OJYY/sTAivjot7R/bPUj97Ie+FaUKC0mpTOGZTT8KkSpRg2mbZ6YlTUoHAtf4iq3
F9vQs2qVJqyUJqbXcP+X68huIZF7vHZI47e9ExTO1RrxZCGxDp8JigfhmlS4CN4K
Dee1NSMnoWGklNEXvZMwkvhLerV+9Xs6UTGZ5AeRHRiHiLqK+I9eDNaULABHwAYO
JSsat0HDjKMKrgNNFo43TpRTm17gq7N83LOJJkxiNYnRPh8nGpIOgfNx8riWP5DB
tMw3FWvA9bv3tllvTFC4wx92Rgfs255cvXEunqfRTsMzGG7rhdg4UY92I0yB8k6b
g6nucu93VtwEkHZ1b9ZTBwz85ZuTImS/72pHbRPvOaeSuDArBI9i+Lwrb+z+0vUS
iMMuAxtWhKUFr87A6ljdu27IfE+pJaEgGEySGkquU3EexuNRMz62raveRsEpLSu8
iqbKoMeC1A7CtcbV3OBdktfFyM3rR8/G9OpjBNdkojo08BOvsoMCU45jLdXFIFtu
MGMajhGEu8EwAdItq6Qq0fXOfU6ph5oN4tg1pKt83QDkDFJyEJzOH1CMLh+qxXR3
m25wLSJcV8YbNfQVMumw2aFXn3ojwkP3kEheoTKexTFVkwGS0dU/j9kpQ8wj9Pqv
1ttxTdlX2HM=
=OthK
-----END PGP SIGNATURE-----
