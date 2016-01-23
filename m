From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Sat, 23 Jan 2016 07:31:50 +0100
Message-ID: <56A31E56.9040700@web.de>
References: <cover.1453482052.git.johannes.schindelin@gmx.de>
 <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 07:32:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMrkY-0007Nd-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 07:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcAWGcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 01:32:02 -0500
Received: from mout.web.de ([212.227.17.12]:53701 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbcAWGcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 01:32:00 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MRU72-1aXxXl0ndo-00Sh6s; Sat, 23 Jan 2016 07:31:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:qenApIod73mltP20+Lx6nlz2LdAWx0K7xCVYGO1XtohMlILaarQ
 sNiN6MB/ucBVs6BvJgzUvfDr2TFoyoGs50UgW52PAWTV0gZvxQ3P1KrVRSqf18KbfFmFsnY
 zu7YA67zt52iM47gU8PmupFDFDvdkmmAtcMHVg+rte1kwhmTRyPW4R7+VGqE5PGlNzKQ9lM
 EC+kZyyTwbp/g6K8kzebQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HqJeDwZFDb8=:Z/6AJU53m58hyvYGA+CHSO
 ZTc84xd9LGO2OO0yIce5q3BZTr1+h4CNkm9xkQ669ufMFywpHBjeGNh6KXcDxrQaopTuOZpCb
 aiNS/0FNOaV/fq294yM5n5c45SBSzntPJ/e85Nj+vvu+egJ+h9DjiCqPfWKB//wPxM+ysxddw
 Qm9ctDdfAHIY/vHA7ZUXEGWT9HDsI/+OvTmQFYrgQHhEMg8ENrPLrWJEcAO/5toTkqCD7mPLH
 HqScJb2gPfx0qkHmE57nPMQi1VHWEsBvIYs/ScmIontvS+ntjtUkLWG97+Q0sWeq/wLgRpDw9
 PBy5+I53yxAtTegXQPajOxANc7fcxZqv6pXsFJsUdj7sUdVKiQEdlJBQyG2tg3yetWZo6Bno4
 Uktk7uagDzqeV84YvajFklm7QWsbPXKTB0rYikO8VoZ71/pHJhBIAOJoOoVh4P0uPkSdVxToc
 eIsmY+vSAOPkbIEkGIiiy9de7L9osCaq6OlUmzosxLaEu0jKCm3P9u7dDJ+nk8MP7FgABXgrV
 LdZxRiZEzugU0J3Y+zCndKg0QDUCGrpCNbr8SCwN50QjBumdHX2Dwi0YbgJ3ix4S+kUcl89s2
 J+jO4VrYMWLo75GrH4+UDyeSiLcoUgmPy6qGMPYRGiPvhoI9u/fxRbTdGUDXcfQIfI0aB2nzG
 B6RTP8g5IRwXeO7xjFTAWBivAFehqwMefpn2id4d2235kMlZuahexfPS+8Cz3f9Z/fDLJDM4P
 4rxiKuzk1grjVfX3XLFdlj4A+xqwY0Z03Rhejq+reQv0Yrbpipn8Yoou5o2xmAzdaS8qPEEf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284624>

On 2016-01-22 18.01, Johannes Schindelin wrote:
> From: Beat Bolli <dev+git@drbeat.li>
> 
> When merging files in repos with core.eol = crlf, git merge-file inserts
> just a LF at the end of the merge markers. Files with mixed line endings
> cause trouble in Windows editors and e.g. contrib/git-jump, where an
> unmerged file in a run of "git jump merge" is reported as simply "binary
> file matches".
> 
> Fixing this improves merge-file's behavior under Windows.
> 
> The original version of this patch also modified ll_merge(), but that
> was incorrect: low-level merge operates on blobs, not on working files.
> Therefore, the data passed to the low-level merge, as well as its
> result, is expected to have LF-only line endings.
> 
> It is the duty of ll_merge()'s *caller* (in case of Git's `merge`
> command, the merge_content() function) to convert the merge result into
> the correct working file contents, and ll_merge() should not muck with
> line endings at all.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/merge-file.c  |  1 +
>  t/t6023-merge-file.sh | 14 ++++++++++++++
>  xdiff/xdiff.h         |  1 +
>  xdiff/xmerge.c        | 29 +++++++++++++++++++----------
>  4 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 5544705..9ce830a 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -81,6 +81,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
>  					argv[i]);
>  	}
>  
> +	xmp.crlf = eol_for_path(names[0], NULL, 0) == EOL_CRLF;
2 comments:
What happens when the original file already has CRLF ?
And why don't we feed any content into the function ?
When the source is already in CRLF, do we need to add any CR ?

Or is the content feed into the merge machine always normalized ?
And in this case you can skip this comment completely.
>  	xmp.ancestor = names[1];
>  	xmp.file1 = names[0];
>  	xmp.file2 = names[2];
> diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
> index 190ee90..a131749 100755
> --- a/t/t6023-merge-file.sh
> +++ b/t/t6023-merge-file.sh
> @@ -346,4 +346,18 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
>  	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
>  	 test_cmp expect.txt output.txt'
>  
> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
$(wc -l)  == 3 tends to be non-portable - either use "test .. -eq" or
use test_line_count()
> +'

> +
> +test_expect_success 'conflict markers heed gitattributes over core.eol=crlf' '
> +	git config core.eol crlf &&
> +	echo "*.txt eol=lf" >>.gitattributes &&
> +	test_must_fail git -c core.eol=crlf merge-file -p \
> +		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> +	test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 0
Same here
And If I remember that "\r" in sed is non-portable, Ramsay suggested a nice fix:
gmane/283262
"t6023 broken under Mac OS"
