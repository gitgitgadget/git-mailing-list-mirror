From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/3] t9903: add tests for git-prompt pcmode
Date: Sun, 16 Jun 2013 21:24:30 -0700
Message-ID: <7vhagxicu9.fsf@alter.siamese.dyndns.org>
References: <cover.1371402672.git.erdavila@gmail.com>
	<cover.1371402672.git.erdavila@gmail.com>
	<c4c2a37da989c8c39e8cd6be2370ce34dd0675a6.1371402672.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	t.gummerer@gmail.com, artagnon@gmail.com, zoltan.klinger@gmail.com,
	hegge@resisty.net, martinerikwerner@gmail.com,
	s.oosthoek@xs4all.nl, jonathan@leto.net, szeder@ira.uka.de
To: "Eduardo R. D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 06:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoQzg-0008Qq-4e
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 06:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3FQEYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 00:24:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab3FQEYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 00:24:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA01823F22;
	Mon, 17 Jun 2013 04:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r5oOOaRASlJjieI0aMGaxirl5Q8=; b=l4kHFA
	5EIMUeS8cl9253VpIZl6Sxnp31UbJ/v3FPpqw1q8fZBM3LUYZUie290m3JJuKXlv
	tLbhZxxm5iJveyjNGAZ2nZmp+eOLH+ZEi+9RrKP1vHVMbY+CrJnaV7q3Bfn7Gfo6
	qIM7ULJPwFhkeWUZ1Orqvf2JHe1ZKPWdPdo+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jiCslcd2STLV2Cb4S5PfFILs8QM9rU0C
	vlweRi7H/xNQkhBwRxS8noQdVc++N3Bu6q1KgkRYr9svcLZuEkK0n7f54hx2/kUb
	8e5shRat8uGac143xV6Og2exwSilRmzBvP8eZEJ5DarqamwDWVmodPFNT9/zhDR4
	1zJO1sKuOuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF5723F21;
	Mon, 17 Jun 2013 04:24:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E235023F1C;
	Mon, 17 Jun 2013 04:24:31 +0000 (UTC)
In-Reply-To: <c4c2a37da989c8c39e8cd6be2370ce34dd0675a6.1371402672.git.erdavila@gmail.com>
	(Eduardo R. D'Avila's message of "Sun, 16 Jun 2013 14:32:10 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEE147A6-D705-11E2-BCB9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228038>

"Eduardo R. D'Avila" <erdavila@gmail.com> writes:

> git-prompt.sh lacks tests for PROMPT_COMMAND mode.
>
> Add tests for:
> * pcmode prompt without colors
> * pcmode prompt with colors for bash
> * pcmode prompt with colors for zsh
>
> Having these tests enables an upcoming refactor in
> a safe way.
>
> Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>
> ---
> 250	0	t/t9903-bash-prompt.sh
>  t/t9903-bash-prompt.sh | 250 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 250 insertions(+)
>
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 15521cc..ebca9de 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -535,4 +535,254 @@ test_expect_success 'prompt - format string starting with dash' '
>  	test_cmp expected "$actual"
>  '
>  
> +test_expect_success 'prompt - pc mode' '
> +	printf "BEFORE: (master):AFTER" > expected &&

Style; redirected filename immediately follows the redirection
operator, i.e.

	command >expected

> +	printf "" > expected_output &&
> +	(
> +		__git_ps1 "BEFORE:" ":AFTER" > "$actual" &&
> +		test_cmp expected_output "$actual" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - branch name' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&

With these escape codes that are hardcoded everywhere, the tests
look pretty much unreadable.  Could they be improved to something
like this (two ${reset} and some other characters may want to be
there):

	printf "BEFORE: (${C_green}master${C_reset}):AFTER"

by adding variable definitions early in this test file?

[the rest of the original left unsnipped for reference; my comments
end here]

> +	(
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" > "$actual"
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - detached head' '
> +	printf "BEFORE: (\\\[\\\e[31m\\\](%s...)\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" $(git log -1 --format="%h" b1^) > expected &&
> +	git checkout b1^ &&
> +	test_when_finished "git checkout master" &&
> +	(
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]*\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	(
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[32m\\\]+\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	git add -u &&
> +	(
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]*\\\[\\\e[32m\\\]+\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	echo "dirty index" > file &&
> +	test_when_finished "git reset --hard" &&
> +	git add -u &&
> +	echo "dirty worktree" > file &&
> +	(
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[32m\\\]#\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	(
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		cd otherrepo &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - inside .git directory' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]GIT_DIR!\\\[\\\e[0m\\\]\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	(
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		cd .git &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - stash status indicator' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[1;34m\\\]$\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	echo 2 >file &&
> +	git stash &&
> +	test_when_finished "git stash drop" &&
> +	(
> +		GIT_PS1_SHOWSTASHSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
> +	printf "BEFORE: (\\\[\\\e[32m\\\]master\\\[\\\e[0m\\\] \\\[\\\e[31m\\\]%%\\\[\\\e[0m\\\]):AFTER" > expected &&
> +	(
> +		GIT_PS1_SHOWUNTRACKEDFILES=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - branch name' '
> +	printf "BEFORE: (%%F{green}master%%f%%f):AFTER" > expected &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" > "$actual"
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - detached head' '
> +	printf "BEFORE: (%%F{red}(%s...)%%f%%f):AFTER" $(git log -1 --format="%h" b1^) > expected &&
> +	git checkout b1^ &&
> +	test_when_finished "git checkout master" &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty worktree' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%f):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{green}+%%f):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	git add -u &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - dirty status indicator - dirty index and worktree' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{red}*%%F{green}+%%f):AFTER" > expected &&
> +	echo "dirty index" > file &&
> +	test_when_finished "git reset --hard" &&
> +	git add -u &&
> +	echo "dirty worktree" > file &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - dirty status indicator - before root commit' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{green}#%%f):AFTER" > expected &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		cd otherrepo &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - inside .git directory' '
> +	printf "BEFORE: (%%F{green}GIT_DIR!%%f%%f):AFTER" > expected &&
> +	echo "dirty" > file &&
> +	test_when_finished "git reset --hard" &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWDIRTYSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		cd .git &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - stash status indicator' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{blue}$%%f):AFTER" > expected &&
> +	echo 2 >file &&
> +	git stash &&
> +	test_when_finished "git stash drop" &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWSTASHSTATE=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - zsh color pc mode - untracked files status indicator' '
> +	printf "BEFORE: (%%F{green}master%%f %%F{red}%%%%%%f):AFTER" > expected &&
> +	(
> +		ZSH_VERSION=5.0.0 &&
> +		GIT_PS1_SHOWUNTRACKEDFILES=y &&
> +		GIT_PS1_SHOWCOLORHINTS=y &&
> +		__git_ps1 "BEFORE:" ":AFTER" &&
> +		printf "%s" "$PS1" > "$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
>  test_done
