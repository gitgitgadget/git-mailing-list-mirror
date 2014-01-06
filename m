From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: better document side effects when moving a submodule
Date: Mon, 06 Jan 2014 14:40:16 -0800
Message-ID: <xmqq8uushgz3.fsf@gitster.dls.corp.google.com>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>
	<52A602A2.6060909@web.de> <52CB023C.2050001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:33:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Jfu-0001Hl-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbaAFXdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:33:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932786AbaAFWka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:40:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C14761831;
	Mon,  6 Jan 2014 17:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IVSe220cbjtH7ozreKz+fAWA8EI=; b=QuRtXm
	bgMTqI0/NR/7M53kGfXGh/4DTsuVdSJBEDxnhoIggu9brU0C/bP/FT81qNTfiOqX
	lYUoVPy2kGJ0H7u0vF/hQSI2wTqLxmw8dzMyAbZLJX+uYGzex0p+3nyatl6KNmbV
	jBNH9kgKdlikCaTV6kQux56V55RREpB8rc/lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fZ2V9Ok3c+t5m6l3v9cvha7XwSo6R7w5
	KnXslajZ4/GPkNz7uTB7p54ni3dvrvPa6ej5ZsfNSIqUoTS71E691jVqu0tBE+lD
	5o/PUxzo9ozApelzvproKWCkcNX1f5yknh+Y9Kp24mUqWdCdgG6pcP11LZI59E0R
	WOE9TMGbeAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 676F86182D;
	Mon,  6 Jan 2014 17:40:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D8AB6182B;
	Mon,  6 Jan 2014 17:40:20 -0500 (EST)
In-Reply-To: <52CB023C.2050001@web.de> (Jens Lehmann's message of "Mon, 06 Jan
	2014 20:21:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85C8957E-7723-11E3-8CF9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240085>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The "Submodules" section of the "git mv" documentation mentions what will
> happen when a submodule with a gitfile gets moved with newer git. But it
> doesn't talk about what happens when the user changes between commits
> before and after the move, which does not update the work tree like using
> the mv command did the first time.
>
> Explain what happens and what the user has to do manually to fix that.
> Also document this in a new test.
>
> Reported-by: George Papanikolaou <g3orge.app@gmail.com>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> Am 09.12.2013 18:49, schrieb Jens Lehmann:
>> Am 09.12.2013 11:59, schrieb George Papanikolaou:
>>> Also after mv you need to run 'submodule update' and I think this should be
>>> documented somewhere.
>> 
>> You're right, this should be mentioned in the mv man page. I'll
>> prepare a patch for that.
>
> Does this new paragraph make it clearer?

Don't we have bugs section that we can use to list the known
limitations like this?

>  Documentation/git-mv.txt | 10 ++++++++++
>  t/t7001-mv.sh            | 21 +++++++++++++++++++++

It also may make sense to express the test as "this is what we would
like to see happen eventually" in the form of test_expect_failure;
it is not a big deal though.

>  2 files changed, 31 insertions(+)
>
> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
> index b1f7988..c9e8568 100644
> --- a/Documentation/git-mv.txt
> +++ b/Documentation/git-mv.txt
> @@ -52,6 +52,16 @@ core.worktree setting to make the submodule work in the new location.
>  It also will attempt to update the submodule.<name>.path setting in
>  the linkgit:gitmodules[5] file and stage that file (unless -n is used).
>
> +Please note that each time a superproject update moves a populated
> +submodule (e.g. when switching between commits before and after the
> +move) a stale submodule checkout will remain in the old location
> +and an empty directory will appear in the new location. To populate
> +the submodule again in the new location the user will have to run
> +"git submodule update" afterwards. Removing the old directory is
> +only safe when it uses a gitfile, as otherwise the history of the
> +submodule will be deleted too. Both steps will be obsolete when
> +recursive submodule update has been implemented.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 3bfdfed..e3c8c2c 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -442,4 +442,25 @@ test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
>  	git diff-files --quiet -- sub .gitmodules
>  '
>
> +test_expect_success 'checking out a commit before submodule moved needs manual updates' '
> +	git mv sub sub2 &&
> +	git commit -m "moved sub to sub2" &&
> +	git checkout -q HEAD^ 2>actual &&
> +	echo "warning: unable to rmdir sub2: Directory not empty" >expected &&
> +	test_i18ncmp expected actual &&
> +	git status -s sub2 >actual &&
> +	echo "?? sub2/" >expected &&
> +	test_cmp expected actual &&
> +	! test -f sub/.git &&
> +	test -f sub2/.git &&
> +	git submodule update &&
> +	test -f sub/.git &&
> +	rm -rf sub2 &&
> +	git diff-index --exit-code HEAD &&
> +	git update-index --refresh &&
> +	git diff-files --quiet -- sub .gitmodules &&
> +	git status -s sub2 >actual &&
> +	! test -s actual
> +'
> +
>  test_done
