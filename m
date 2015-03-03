From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Tue, 03 Mar 2015 21:17:33 +0100
Message-ID: <54F616DD.8040904@web.de>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de
To: Anton Trunov <anton.a.trunov@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:17:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStGB-0004eU-Om
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbCCURk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:17:40 -0500
Received: from mout.web.de ([212.227.15.14]:63825 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbbCCURj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:17:39 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LfReL-1Xj8FT0oSf-00p8LP; Tue, 03 Mar 2015 21:17:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
X-Provags-ID: V03:K0:JIoZny/302xHHlKZj7GMftIJ5etQE22TFQmrOXM2tHDHzizhSVn
 2v2MkgeWzEXKSxGw8SPoxTfvNOio4yIn4/fVVVJ6x+1VBuh7acWbgt5p16l+BP2wRln7EOb
 KeoaK0hDv6QxmIjZZJhbAaUFZl/12ccTqwckacRpc/Z/A5WSKcnDLyGFZCekCiV4w7Dn79q
 MU7rAyWnTibp2vMWyB3Yw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264680>

On 2015-03-03 18.37, Anton Trunov wrote:
[]
> Signed-off-by: Anton Trunov <anton.a.trunov <at> gmail.com>
Should we use the "real email" here (with the '@') ?
> ---
>  t/t3032-merge-recursive-options.sh | 43 ++++++++++++++++++++++++++++++++++++++
>  xdiff/xmerge.c                     | 10 ++++-----
>  2 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
> index 4029c9c..4cbedb4 100755
> --- a/t/t3032-merge-recursive-options.sh
> +++ b/t/t3032-merge-recursive-options.sh
> @@ -204,4 +204,47 @@ test_expect_success '--ignore-space-at-eol' '
>  	test_cmp expected actual
>  '
>  
> +# Setup for automerging with whitespace-only changes
> +# on both sides and in *all* lines
> +
> +test_expect_success 'setup: w/s only changes in all lines on both sides' '
> +	git rm -rf . &&
> +	git clean -fdqx &&
> +	rm -rf .git &&
> +	git init
missing &&
> +
> +	echo " two words" >text.txt &&
> +	git add text.txt &&
> +	test_tick &&
> +	git commit -m "Initial revision" &&
> +
> +	git checkout -b remote &&
> +	echo " \t\ttwo     words  " >text.txt &&
> +	git commit -a -m "remote: insert whitespace only" &&
> +
> +	git checkout master &&
> +	echo "    two words" >text.txt &&
> +	git commit -a -m "master: insert whitespace only"
> +'
> +
> +test_expect_success 'w/s only in all lines: --ignore-space-change preserves ours' '
[]
