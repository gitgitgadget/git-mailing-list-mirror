From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: Only count lines in show_shortstats
Date: Fri, 15 Jun 2012 12:38:24 -0700
Message-ID: <7vr4tg9xhr.fsf@alter.siamese.dyndns.org>
References: <20120615190248.GA28377@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	mj@ucw.cz
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 21:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfcLo-000870-9e
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 21:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab2FOTi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 15:38:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459Ab2FOTi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 15:38:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1F59C99;
	Fri, 15 Jun 2012 15:38:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=osNOjSRfYJ8cz90LRPKODNK02v4=; b=n6kfes
	75jQz/xtB4DQopmaEBFQ7cUdqaQ0NmH5qoA1SI1TnMvbHPZFksjL8Jw7m5IUxEYQ
	DC0eCP2/ocJBgf/hH2te/SbA8eHuK2auBYefXs10+ysD4hGZO+gTklOotS3qCRvJ
	lmKtUiJRBElKAajeVF+CFmlsCYUL7hRBKYAEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWyFrWhpK/aUa2rz/qGP8Sw0EnGEVSU5
	Ww49rec5i0I/NtAMlQ/ujph8ULWaTmvoNuu3HG/xWrxRgOFJ63Hru5qgAXIF9/nv
	JFRCxcQPFvLzXVRuTRVxbeWxLDiRiTTcRP2gR4pRy4kSmfb4ladp52FeVbQNfZbv
	lijxBoYlaPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D519F9C98;
	Fri, 15 Jun 2012 15:38:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 505B69C97; Fri, 15 Jun 2012
 15:38:26 -0400 (EDT)
In-Reply-To: <20120615190248.GA28377@akuma> (Alexander Strasser's message of
 "Fri, 15 Jun 2012 21:02:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD141B4E-B721-11E1-AE21-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200086>

Alexander Strasser <eclipse7@gmx.net> writes:

> Do not mix byte and line counts. Binary files have byte counts;
> skip them when accumulating line insertions/deletions.
>
> The regression was introduced in e18872b.
>
> Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
> ---

Administrivia.

Please do not use Mail-Followup-To: header to deflect direct
response to you away to other people.  When I want to reply to you
and Cc: others, I do not want to see other people's name on To:
field---I have to move them manually to the Cc: line in my editor.
When somebody else wants to reply to you, I do not want to see my
name on its To: line, as such a message that is addressed to you may
not be of immediate interest for me.

>
>  Zbigniew, Junio:
>    I hope I did submit the patch correctly this time.
>
>    This is a reroll with the following differences to v1:
>
>    * I changed the additional test for t4012 to adhere to modern
>      style on request by Zbigniew. I had the impression this might
>      be in conflict with Junio's comment
>      "Style fixes should be done later after dust from more important
>       changes (e.g. a bugfix) settles."
>      But maybe that was directed at modernizing the remaining of
>      parts of that test file.

Yes, that "maybe" is correct.

>    * I deleted the 2-space indent in the commit message paragraphs

OK.

>    * I omitted the parenthesis in the subject message

OK.

>  diff.c                 | 2 +-
>  t/t4012-diff-binary.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index 77edd50..1a594df 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1700,7 +1700,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
>  			continue;
>  		if (!data->files[i]->is_renamed && (added + deleted == 0)) {
>  			total_files--;
> -		} else {
> +		} else if (!data->files[i]->is_binary) { /* don't count bytes */
>  			adds += added;
>  			dels += deleted;
>  		}
> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 8b4e80d..7d03c1d 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -36,6 +36,12 @@ test_expect_success '"apply --stat" output for binary file change' '
>  	test_i18ncmp expected current
>  '
>  
> +test_expect_success 'diff --shortstat output for binary file change' '
> +	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
> +	git diff --shortstat >current &&
> +	test_i18ncmp expected current
> +'
> +

It would also have been interesting if we can see the result for a
diff that involves _only_ binary files, no?

>  test_expect_success 'apply --numstat notices binary file change' '
>  	git diff >diff &&
>  	git apply --numstat <diff >current &&

Thanks.
