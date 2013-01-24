From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] t7102 (reset): refactoring: don't hardcode SHA-1
 in expected outputs
Date: Thu, 24 Jan 2013 12:30:52 -0800
Message-ID: <7vy5fi9vcz.fsf@alter.siamese.dyndns.org>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
 <63637506fa940f6dd5fc050c7fccfa5ef41993dd.1359018188.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 21:32:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyTTZ-0005t8-AW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 21:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab3AXUcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 15:32:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756656Ab3AXUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 15:30:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14379B241;
	Thu, 24 Jan 2013 15:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7UVJbQUUV8rfVf5idSJYZPbTvyY=; b=AsEqUf
	eYz4naBCZ6+k35RGClZ37lStWN2RWIhM39/tqUEvqhD1bTIRI+ajPn3389nlS0Pk
	hEkRa7WNn1vBd7bwBorGqUJ/ymRJOR1HyaWmVMhcOpq4dB7/RNESMx/xpFMXOqKA
	Srh3PVKqENn8F+Q4+aKq7ompJV/7k66uWG5m4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erRiLtCE6v1+XhNMs/fI5ErxHD5xKyNI
	6vq5EZu0bzPusgm8KZrAME/OMopwzNHwoVpTShrrKMODtKidIwCa7moOOGrH911b
	V5ZKhG0AJFBT2/rSmbSlAlqpXvUXWO35pVd9hleoT2Xgbc+W9dB4lC6CW06wqMrr
	ua20qPcTFzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0709AB240;
	Thu, 24 Jan 2013 15:30:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41045B23F; Thu, 24 Jan 2013
 15:30:54 -0500 (EST)
In-Reply-To: <63637506fa940f6dd5fc050c7fccfa5ef41993dd.1359018188.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's message of "Thu, 24 Jan 2013 13:10:26 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F382E18A-6664-11E2-BFAD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214453>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> The expected SHA-1 digests are always available in variables.  Use
> them instead of hardcoding.
>
> Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
> ---

Looks good (" refactoring:" in the title may not want to be there,
though).

Thanks.

>  t/t7102-reset.sh | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index b096dc8..cf492f4 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -28,7 +28,8 @@ test_expect_success 'creating initial files and commits' '
>  
>  	echo "1st line 2nd file" >secondfile &&
>  	echo "2nd line 2nd file" >>secondfile &&
> -	git commit -a -m "modify 2nd file"
> +	git commit -a -m "modify 2nd file" &&
> +	head5=$(git rev-parse --verify HEAD)
>  '
>  # git log --pretty=oneline # to see those SHA1 involved
>  
> @@ -56,7 +57,7 @@ test_expect_success 'giving a non existing revision should fail' '
>  	test_must_fail git reset --mixed aaaaaa &&
>  	test_must_fail git reset --soft aaaaaa &&
>  	test_must_fail git reset --hard aaaaaa &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  test_expect_success 'reset --soft with unmerged index should fail' '
> @@ -74,7 +75,7 @@ test_expect_success \
>  	test_must_fail git reset --hard -- first &&
>  	test_must_fail git reset --soft HEAD^ -- first &&
>  	test_must_fail git reset --hard HEAD^ -- first &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  test_expect_success 'giving unrecognized options should fail' '
> @@ -86,7 +87,7 @@ test_expect_success 'giving unrecognized options should fail' '
>  	test_must_fail git reset --soft -o &&
>  	test_must_fail git reset --hard --other &&
>  	test_must_fail git reset --hard -o &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  test_expect_success \
> @@ -110,7 +111,7 @@ test_expect_success \
>  
>  	git checkout master &&
>  	git branch -D branch1 branch2 &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  test_expect_success \
> @@ -133,27 +134,27 @@ test_expect_success \
>  
>  	git checkout master &&
>  	git branch -D branch3 branch4 &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  test_expect_success \
>  	'resetting to HEAD with no changes should succeed and do nothing' '
>  	git reset --hard &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset --hard HEAD &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset --soft &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset --soft HEAD &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset --mixed &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset --mixed HEAD &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +		check_changes $head5 &&
>  	git reset HEAD &&
> -		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +		check_changes $head5
>  '
>  
>  >.diff_expect
> @@ -176,7 +177,7 @@ test_expect_success '--soft reset only should show changes in diff --cached' '
>  	git reset --soft HEAD^ &&
>  	check_changes d1a4bc3abce4829628ae2dcb0d60ef3d1a78b1c4 &&
>  	test "$(git rev-parse ORIG_HEAD)" = \
> -			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +			$head5
>  '
>  
>  >.diff_expect
> @@ -193,7 +194,7 @@ test_expect_success \
>  	git commit -a -C ORIG_HEAD &&
>  	check_changes 3d3b7be011a58ca0c179ae45d94e6c83c0b0cd0d &&
>  	test "$(git rev-parse ORIG_HEAD)" = \
> -			3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +			$head5
>  '
>  
>  >.diff_expect
> @@ -303,7 +304,7 @@ test_expect_success 'redoing the last two commits should succeed' '
>  	echo "1st line 2nd file" >secondfile &&
>  	echo "2nd line 2nd file" >>secondfile &&
>  	git commit -a -m "modify 2nd file" &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  >.diff_expect
> @@ -341,15 +342,15 @@ EOF
>  test_expect_success \
>  	'--hard reset to ORIG_HEAD should clear a fast-forward merge' '
>  	git reset --hard HEAD^ &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +	check_changes $head5 &&
>  
>  	git pull . branch1 &&
>  	git reset --hard ORIG_HEAD &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
> +	check_changes $head5 &&
>  
>  	git checkout master &&
>  	git branch -D branch1 branch2 &&
> -	check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
> +	check_changes $head5
>  '
>  
>  cat > expect << EOF
