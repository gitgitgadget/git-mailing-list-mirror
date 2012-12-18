From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: do people compile with NO_FNMATCH on OpenBSD 5.2?
Date: Tue, 18 Dec 2012 12:51:35 -0800
Message-ID: <7vzk1bdqy0.fsf@alter.siamese.dyndns.org>
References: <7va9tbf7vd.fsf@alter.siamese.dyndns.org>
 <rmisj732jop.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arnout Engelen <arnouten@bzzt.net>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl48q-00005S-9B
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 21:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab2LRUvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 15:51:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab2LRUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 15:51:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1699251;
	Tue, 18 Dec 2012 15:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yAWO+Fvluk0PMp68z7l5jTP66gk=; b=ksDq7e
	YxNyIT7eWpsVJa26LyTlO6fQcu1wTfhBUzp9js7W88ZawfNYxD3BF8IrXzxGaa2C
	fdkqNDHifnuniZ8cJRDb3okJ6praHc5z0DsmUD7bqE5C459LCaZDEfjr7BJ9Gk3+
	9l3ZsUS7awr4WUKMOKK3e2e6yBPVVA9kcc0/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TTfydUKsuAglKK1PQy9sT5aBbhwZMqls
	BUTSXHWp8yak95o0D5+92tLmiSv2iFklA1MnFRu5RHjdpKD2hbmIFDYHTLQWN34f
	xQcNqaoAPHlj1DKpujN+VjVJaXgdNrdqPdn0xgbODOAvZSBLqOCMEhYhpV0nUQr3
	dbZJ5ScQm54=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C59E0924F;
	Tue, 18 Dec 2012 15:51:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 128409247; Tue, 18 Dec 2012
 15:51:36 -0500 (EST)
In-Reply-To: <rmisj732jop.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Tue, 18 Dec 2012 15:23:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6FFCF48-4954-11E2-8D43-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211785>

Greg Troxel <gdt@ir.bbn.com> writes:

>   *** t0070-fundamental.sh ***
>   ok 1 - character classes (isspace, isalpha etc.)
>   not ok - 2 mktemp to nonexistent directory prints filename
>   #
>   #               test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err &&
>   #               grep "doesnotexist/test" err
>   #
>   ok 3 - mktemp to unwritable directory prints filename
>   ok 4 - check for a bug in the regex routines
>   # failed 1 among 4 test(s)
>   1..4
>
> Running this by hand, I get:
>
> gdt 51 /usr/pkgsrc/devel/scmgit-base/work/git-1.8.0.1/t > ../test-mktemp foo/barXXXXXX > MKTEMP.stdout 2> MKTEMP.stderr; ls -l MKTEMP*
> -rw-r--r--  1 gdt  wheel  121 Dec 18 15:14 MKTEMP.stderr
> -rw-r--r--  1 gdt  wheel    0 Dec 18 15:14 MKTEMP.stdout
> gdt 52 /usr/pkgsrc/devel/scmgit-base/work/git-1.8.0.1/t > cat MKTEMP.stderr 
> fatal: Unable to create temporary file '/usr/pkgsrc/devel/scmgit-base/work/git-1.8.0.1/t/foo': No such file or directory
>
> It seems ENOENT is correct for the directory not existing.  I think the
> test is complaining that the failed call to mkstemp modified the
> argument. 
>
> Looking at:
>  
>   http://pubs.opengroup.org/onlinepubs/9699919799/functions/mkstemp.html
>
> I can't see that it requires anything in particular for the in/out
> paramater when there is an error.

True.  Perhaps something like this.

-- >8 --
Subject: xmkstemp(): avoid showing truncated template more carefully

Some implementations of xmkstemp() leaves the given in/out buffer
truncated when they return with failure.

6cf6bb3 (Improve error messages when temporary file creation fails,
2010-12-18) attempted to show the real filename we tried to create
(but failed), and if that is not available due to such truncation,
to show the original template that was given by the caller.

But it failed to take into account that the given template could
have "directory/" in front, in which case the truncation point may
not be template[0] but somewhere else.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/wrapper.c w/wrapper.c
index 68739aa..a066e2e 100644
--- c/wrapper.c
+++ w/wrapper.c
@@ -229,7 +229,7 @@ int xmkstemp(char *template)
 		int saved_errno = errno;
 		const char *nonrelative_template;
 
-		if (!template[0])
+		if (strlen(template) != strlen(origtemplate))
 			template = origtemplate;
 
 		nonrelative_template = absolute_path(template);
