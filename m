From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 15:27:35 -0800
Message-ID: <xmqq8uhz6za0.fsf@gitster.dls.corp.google.com>
References: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
	<xmqqd27b6zd3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: dturner@twopensource.com, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:27:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3CO6-0000mn-4k
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 00:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbaLVX1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 18:27:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753552AbaLVX1h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 18:27:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C81132986D;
	Mon, 22 Dec 2014 18:27:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Sup6B3Qj1t5OpxO7Ojc16bj3Ic=; b=QMyhUV
	NkP2p7w+zGJ9xsVaTl0XYbDGhNQz7ilLuIWPo3IEl39IW4p/PE4lsQsYm5LeTCG3
	EcKCiudQlLpMkhlQZ3UZ6alDo4JdUHnVzs5KH6BNkIyjLGcheVDK1OlOMnXmIQ2u
	268NbGqDgPQ/PK+dSEFdZuK52Xe9J0IGHAoNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FB4XNb5WCuvFzcqpgc8dxGJ/vw8i1Tjs
	O28dE3fCVUkpUQ/JCjDVnHSlF2Jj2AP5S5HgNpSoP6cWdKOXi4S9dJRsLwYuIrh9
	1wX685PL2gkAD3MfVtkKFSDzQ9F18VYuBekql8090TbqQEvtIvFyKq1tW0jndjZh
	6dxZVeGPz+0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7772986C;
	Mon, 22 Dec 2014 18:27:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4511F2986B;
	Mon, 22 Dec 2014 18:27:36 -0500 (EST)
In-Reply-To: <xmqqd27b6zd3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 22 Dec 2014 15:25:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CBA9302-8A32-11E4-89EF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261700>

Junio C Hamano <gitster@pobox.com> writes:

> From: Ben Walton <bdwalton@gmail.com>
>
> The awk statements previously used in this test weren't compatible
> with the native versions of awk on Solaris:
>
>     echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
>     awk: syntax error near line 1
>     awk: bailing out near line 1
>
>     echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
>     0
>
> And with GNU awk for comparison:
>
>     echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
>     1
>
> Work it around by using $1 != "" to state more explicitly that we
> are skipping empty lines.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Then let's queue this, perhaps?

heh, not like that without updating the subject, perhaps like this:

Subject: t0090: tweak awk statement for Solaris /usr/xpg4/bin/awk

Sorry for the noise.



>  t/t0090-cache-tree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 067f4c6..601d02d 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
>  	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
>  	# We want to count only foo because it's the only direct child
>  	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
> -	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 {++c} END {print c}') &&
> +	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
>  	entries=$(git ls-files|wc -l) &&
>  	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
>  	for subtree in $subtrees
