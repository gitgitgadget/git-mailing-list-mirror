From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 13:25:24 +0100
Message-ID: <56DEC4B4.2000902@web.de>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 08 13:26:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adGiA-0000Ts-1h
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 13:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbcCHMZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 07:25:52 -0500
Received: from mout.web.de ([212.227.15.14]:59455 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784AbcCHMZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 07:25:50 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MHGJ1-1ahRqd1cF1-00E3k3; Tue, 08 Mar 2016 13:25:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
X-Provags-ID: V03:K0:t+369m4I2R3KM/IT5jZeS0+6QsvJE2OLe7JhMk96lAe45E8EuOo
 QCN5P7gXGtDDSNiMaXTb/UfDG0h4jzSA+zho+2bp5fqAFf09M1HsUL9ahD05uXbl3JT5RHj
 wQmZTH/w1MOLwHAtr2GhDC1KMd5VtyWJ/k6GqJOL0pWLMSQwYDFud9JldJKDm64K+9oYpOS
 saQlhi7cRIyb1k43aRxaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1p0gM1fqOvw=:2KVkKZVMkQRocmBwYl2bcM
 ylV8hD7D8V37N3Lyatv7qtSw4OxAnftl7tZhpr3j4SVxeUj93XWC1V0eFtdC0u9zKmhm+WOdW
 zooD7mfIL7eJqPyrnJY7NLOQxzU0HJ4BHxrbXft/Ega7IgU0XkZl5JWSmr0rD9mVnpBSw26qf
 KuA1ce9u+psx282qP92PREbTRqNpAvhjl9NAfBU/xjhd776iGTmihZr8kfxnSduVOlE8pgusw
 KwBF2RuSZQoMIAyK9tVIyeDxInGfsF/pOIapNNJG7nLFHpCk0eDmQQveBIbolnmBKQJ4+NPqP
 yEQbsm6/1ay+Dr05gI4llW8seybfT07sR0KRkd+Ub1BFZ4mH3Y92hcvO7cm9CV7g7gPoOKXCL
 A74LLwnf4CjotO6bPf7hH2Ivkv1p5uKazKME02gY2Z662OUf8O9n1KyGo087bP+PFl1xuwxd/
 9bmS4Z4MUk8TrxTMe4pF5USGP9xV/3IdCV4UDH2tZ3ectEwqsd7m5H9I3EoQY4aRogxZ4LEHF
 CBjcIK2F07vSLncV47sU6lLmhrZv3Dj1Oi4aDBOrZ1k6i/kaXvOlDhxbdkemPnddyCOtNxzKZ
 4h5Lirq2E/DWNQO2G4WfMtlVHmY8F28QImsB3JF5OhecEb4RaoZ12SBSOSg4W178wv8erVd8e
 gyBI8dgr5Wtnt3ZPgj6SzaOCKuxnGvj0X9qmRS5AnBjlo8pkfqKs8F4zqJCkpkf2N8WRVuKRS
 RT1kHg+A+IVEOtwuG/Sq6Qk2yFUcvhkf8Qi9ICaVMq0LS+dy2rmG+XbaMM01wzqAPbYeIuE+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288429>

On 03/08/2016 08:59 AM, Anders Kaseorg wrote:
> The included test case, which uses rebase -p with non-ASCII commit
> messages, was failing as follows:
>
>    Warning: the command isn't recognized in the following line:
>     - Binary file (standard input) matches
>
>    You can fix this with 'git rebase --edit-todo'.
>    Or you can abort the rebase with 'git rebase --abort'.
>
> Possibly related to recent GNU grep changes, as with commit
> 316336379cf7937c2ecf122c7197cfe5da6b2061.  Avoid the issue by using sed
> instead.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>   git-rebase--interactive.sh        |  2 +-
>   t/t3409-rebase-preserve-merges.sh | 21 +++++++++++++++++++++
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index c0cfe88..0efc65c 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1241,7 +1241,7 @@ then
>   			# be rebasing on top of it
>   			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
>   			sha1=$(git rev-list -1 $rev)
> -			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
> +			sed "/^[a-z][a-z]* $sha1/d" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
>   			rm "$rewritten"/$rev
>   		fi
>   	done
> diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
> index 8c251c5..1f01b29 100755
> --- a/t/t3409-rebase-preserve-merges.sh
> +++ b/t/t3409-rebase-preserve-merges.sh
> @@ -119,4 +119,25 @@ test_expect_success 'rebase -p ignores merge.log config' '
>   	)
>   '
>   
> +test_expect_success 'rebase -p works with non-ASCII commit message' '
> +	(
> +	mkdir non-ascii &&
#The cd should be done in a subshell:
(
> +	cd non-ascii &&
> +	git init &&
> +	echo a > a &&
> +	git add a &&
> +	git commit -m a &&
> +	echo b > b &&
#Style: No space after ">" (and even above and below)

echo b >b


> +	git add b &&
> +	git commit -m b &&
> +	git branch foo &&
> +	git reset --hard HEAD^ &&
> +	git cherry-pick -x foo &&
> +	echo c > c &&
> +	git add c &&
> +	git commit -m "$(printf "I \\342\\231\\245 Unicode")" &&
> +	git rebase -p foo
> +	)
> +
#end of subshell
)
> '
> +
>   test_done
