From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 3/4] t7507-commit-verbose: improve test coverage by testing number of diffs
Date: Thu, 31 Mar 2016 11:23:45 -0700
Message-ID: <xmqqa8leo6a6.fsf@gitster.mtv.corp.google.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341ef-eed17644-85ee-4d1d-8051-b5d56bd9ae52-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhG7-0001V3-R8
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248AbcCaSXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:23:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757203AbcCaSXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:23:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7CDB52B96;
	Thu, 31 Mar 2016 14:23:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEAAN2xxVsCOCSrRQQkQDB/Ow3Q=; b=i5gYYj
	B6UUyQYVJJ/R+6nCLjFVfIoJYyYMYFgsBDMwkgESPQwGbKXlHNWXFGv7yYSYZw0O
	v6pzyVdPQYaujADgRQACH5ki9aQMeOJuJRO6cVjd4OzgrAsuM1ARG7UPdXoyyC4L
	sXPNL+DTcCA/JqooDJaP4h2mjFlO2i29s4sKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xH50uo9pfJi7zGnDIMuoFNTb5lJD2Vcj
	P5TMSqRTfq1OGi0PdjkCUXOwGEFvpopt+5GqD+j2XaWHIox3/xZp1SAiagUUXeX0
	nvIa2FkwaBIBfRQtSpeAC+hIECA31Jw/ciMVh5f530FUyRGaCedwGoqdcK4ND0vY
	TYij8JJ1xGQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EE7252B95;
	Thu, 31 Mar 2016 14:23:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 159F352B94;
	Thu, 31 Mar 2016 14:23:47 -0400 (EDT)
In-Reply-To: <01020153cd2341ef-eed17644-85ee-4d1d-8051-b5d56bd9ae52-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 31 Mar 2016 14:45:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B55E1788-F76D-11E5-BD9C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290440>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Make the fake "editor" store output of grep in a file so that we can
> see how many diffs were contained in the message and use them in
> individual tests where ever it is required. Also use write_script()
> to create the fake "editor".
>
> A subsequent commit will introduce scenarios where it is important to be
> able to exactly determine how many diffs were present.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>
> Previous version of this patch:
>  - [v10]: $gmane/288820
>
> Changes this version wrt previous one:
> I decided to include no of diffs in every test and rewrote the commit
> message so as to sell this idea. This was given as an option to me by
> Eric and the other option being to drop unnecessary testing of lines
> where it isn't required. Also this patch uses a suggestion given by Eric
> to make the "editor" look more clean as compared to the editor in my
> previous version.
> ---

OK, by always exiting 0 from the editor, you do not interfere with
the "git commit" that invoked it, and you inspect the editor's
finding after "git commit" returns.  The approach taken by this
patch looks a lot more sensible than the previous one.

You'd need the three-dash right before "Previous version of..."
line, though.

>  t/t7507-commit-verbose.sh | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..0f28a86 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -3,11 +3,10 @@
>  test_description='verbose commit template'
>  . ./test-lib.sh
>  
> -cat >check-for-diff <<EOF
> -#!$SHELL_PATH
> -exec grep '^diff --git' "\$1"
> +write_script "check-for-diff" <<\EOF &&
> +grep '^diff --git' "$1" >out
> +exit 0
>  EOF
> -chmod +x check-for-diff
>  test_set_editor "$PWD/check-for-diff"
>  
>  cat >message <<'EOF'
> @@ -23,7 +22,8 @@ test_expect_success 'setup' '
>  '
>  
>  test_expect_success 'initial commit shows verbose diff' '
> -	git commit --amend -v
> +	git commit --amend -v &&
> +	test_line_count = 1 out
>  '
>  
>  test_expect_success 'second commit' '
> @@ -39,13 +39,15 @@ check_message() {
>  
>  test_expect_success 'verbose diff is stripped out' '
>  	git commit --amend -v &&
> -	check_message message
> +	check_message message &&
> +	test_line_count = 1 out
>  '
>  
>  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
>  	git config diff.mnemonicprefix true &&
>  	git commit --amend -v &&
> -	check_message message
> +	check_message message &&
> +	test_line_count = 1 out
>  '
>  
>  cat >diff <<'EOF'
>
> --
> https://github.com/git/git/pull/218
