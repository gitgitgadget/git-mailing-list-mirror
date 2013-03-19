From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7811 (grep-open): remove test_config() redefinition
Date: Tue, 19 Mar 2013 09:09:07 -0700
Message-ID: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org>
References: <1363689794-25974-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 17:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHz6d-0004Qu-G1
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 17:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab3CSQJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 12:09:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756865Ab3CSQJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 12:09:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C556DBAC0;
	Tue, 19 Mar 2013 12:09:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VigHe+mcj2zHEzhQwMe+DndHyzM=; b=o/Y8w2
	UrOx39jZmXJ3KLeS9ZtHkomPckbvKwMULmSaqwPkP6NAgIzsj+McpD4hclr8uiIB
	c38VqrE51fwqE81OhXaTtQTvmF+UXzlyfRng3AkD3TXFptWtuVfSYYxZG5caTa4l
	qxd0k/WRyGmdqAynWLoOOEZB6beDV+D2Q9ZLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RN5oNn+4cTwE+OvKbkCPh/+1bh51m8fz
	zq9wj7LFcxrIvT2H38b5+iYki0QHFq3rDQ6JEMWRHOhhHsRWvSTxE/aK/xUvT4hV
	brdmZ8oeR+xYbGG2/RgdSqgKmILFrdW1i0Y4gxswIZRphjCDvyW7XOduSudt/DFo
	y4Vw2fIE9QQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7D38BABF;
	Tue, 19 Mar 2013 12:09:14 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 144B3BAB9; Tue, 19 Mar 2013
 12:09:13 -0400 (EDT)
In-Reply-To: <1363689794-25974-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 19 Mar 2013 16:13:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57C79F9A-90AF-11E2-A690-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218534>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> test_config() is already a well-defined function in
> test-lib-functions.sh.  Don't duplicate it unnecessarily.

There are other instances of it in t7810 and t4018, with slightly
different styles.

t/t4018-diff-funcname.sh:test_config () {
t/t7810-grep.sh:test_config() {
t/t7811-grep-open.sh:test_config() {
t/test-lib-functions.sh:test_config () {

Incidentally, this is why a consistent coding style helps.  It
should be possible to catch all ofhtme with a single

	git grep 'test_config () {' t/

but the ones in t78xx wouldn't have been found.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Found this while randomly grep'ping around.
>
>  t/t7811-grep-open.sh | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
> index a895778..e1951a5 100755
> --- a/t/t7811-grep-open.sh
> +++ b/t/t7811-grep-open.sh
> @@ -125,11 +125,6 @@ test_expect_success 'modified file' '
>  	test_cmp empty out
>  '
>  
> -test_config() {
> -	git config "$1" "$2" &&
> -	test_when_finished "git config --unset $1"
> -}
> -
>  test_expect_success 'copes with color settings' '
>  	rm -f actual &&
>  	echo grep.h >expect &&
