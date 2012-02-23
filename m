From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] t5704: match tests to modern style
Date: Thu, 23 Feb 2012 15:36:34 -0800
Message-ID: <7vzkc915rx.fsf@alter.siamese.dyndns.org>
References: <cover.1329988335.git.trast@student.ethz.ch>
 <c6579adc648119fbd1c54e2a1a9a0de86e0e8b57.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 24 00:36:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0iDM-0008T0-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 00:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab2BWXgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 18:36:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521Ab2BWXgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 18:36:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E53C6CAC;
	Thu, 23 Feb 2012 18:36:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=brR35ssjOj4rAvE2II9FWEFMoD0=; b=wHW6+t
	C84Oz2JmqqhZhPdUq9ZXuO9p/M5G5Wjt8JVxR2ejsuL5nNfVWzGN7nOvWKjTvKx5
	ej69Fn1AlHVCDBFuUxyQkbWFFtD4ecLhXJBMibeRWxiFm3VHdKWeNmh823MsYxv5
	yV4wa+i23dipQwP32HOac9Mf1LrQqPCR2s5Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHnPjQG1VyzjG9LABX4wmxpVC+RspBw9
	3QfOPwSuN7nTRWPB/0/ktOJ9T8xFL+VJ6Ar0qsZwOTRtrzayGs92k/ikr5T2stXA
	RWRkRkiiSek2wvr9ZDrJFiIoxwcoSLoTnwCFX7/Sq4uP0wskjzGYOl8Rn7x0tXV8
	1ArlH0sZEXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 259366CAB;
	Thu, 23 Feb 2012 18:36:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74B336CA9; Thu, 23 Feb 2012
 18:36:36 -0500 (EST)
In-Reply-To: <c6579adc648119fbd1c54e2a1a9a0de86e0e8b57.1329988335.git.trast@student.ethz.ch> (Thomas Rast's message of "Thu, 23 Feb 2012 10:42:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A02033A-5E77-11E1-8E3B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191404>

Thomas Rast <trast@student.ethz.ch> writes:

> Fix all of them.  There's a catch to the last point: test_commit
> creates a tag.  We still change it to test_commit, and explicitly
> delete the tags, so as to highlight that the test relies on not having
> them.

I do not have an objection to the use of these three test_commits, and I
do not have an objection to delete the extra three tags they create so
that the set of refs in the repository matches what the later test
expects, either.

But I found the explanation a bit iffy.

>  test_expect_success 'setup' '
> +	test_commit initial &&
>  	test_tick &&
>  	git tag -m tag tag &&
> +	test_commit second &&
> +	test_commit third &&
> +	git tag -d initial &&
> +	git tag -d second &&
> +	git tag -d third
>  '
>  
>  test_expect_success 'tags can be excluded by rev-list options' '
>  	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
>  	git ls-remote bundle > output &&
>  	! grep tag output
>  '

If you do not delete 'third' tag, which matches the tip of the current
branch, the resulting bundle created with "create --all" would end up
containing that tag, and you will see it in the ls-remote output.

But the funny thing is that you can leave initial and second in the
repository and the resulting bundle still passes the test.  'initial',
'second' and 'tag' are excluded.  Exclusion of 'tag' tag (sheesh, it makes
this conversation more confusing than necessary) is what this test checks,
and the date range given to the rev-list ensures that initial and second
are not included.

But the tip of the current branch and the lightweight 'third' tag both
point at the same commit object, and that, together with the fact that we
ask for '--all', is the reason why it is included in the result, making
the test fail.

So perhaps a better fix may be to do something like the attached on top,
and rewrite everything after "Fix all of them".

	... Fix all of them.

        Also rename the manually created tag 'tag' that points at a commit
        that is older than the --since threshold a later test uses, to a
        more descriptive 'ancienttag', and update the check that reads
        from the resulting bundle with ls-remote to look for 'ancienttag'.
        The purpose of this test is to make sure that the tag that
        predates the date range is not in the resulting bundle, but
        because these test_commit also will create tags, one of which
        (namely, 'third') points at a commit that is newer than that
        threshold, ls-remote will list it in its output. Looking for 'tag'
        will match refs/tags/third, making the test incorrectly fail.

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a51c8b0..3c436e7 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -6,18 +6,15 @@ test_description='some bundle related tests'
 test_expect_success 'setup' '
 	test_commit initial &&
 	test_tick &&
-	git tag -m tag tag &&
+	git tag -m tag antienttag &&
 	test_commit second &&
-	test_commit third &&
-	git tag -d initial &&
-	git tag -d second &&
-	git tag -d third
+	test_commit third
 '
 
 test_expect_success 'tags can be excluded by rev-list options' '
 	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
 	git ls-remote bundle > output &&
-	! grep tag output
+	! grep antienttag output
 '
 
 test_expect_success 'die if bundle file cannot be created' '
