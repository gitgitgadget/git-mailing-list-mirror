From: greened@obbligato.org
Subject: Re: [PATCH] subtree.sh: Use raw subject and body modifier "%B" instead of "%s%n%n%b"
Date: Mon, 20 Aug 2012 20:56:12 -0500
Message-ID: <87zk5pdn43.fsf@waller.obbligato.org>
References: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
	<1344561358-2953-2-git-send-email-techlivezheng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, apenwarr@gmail.com
To: Techlive Zheng <techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 03:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3di2-0006Zw-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 03:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab2HUB4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 21:56:37 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:38986 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754955Ab2HUB4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 21:56:25 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2012 21:56:25 EDT
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1T3dnU-0000iA-QQ; Mon, 20 Aug 2012 21:02:25 -0500
In-Reply-To: <1344561358-2953-2-git-send-email-techlivezheng@gmail.com>
	(Techlive Zheng's message of "Fri, 10 Aug 2012 09:15:58 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Techlive Zheng <techlivezheng@gmail.com> writes: > "%s%n%n%b"
    is not always equal to "%B". If the commit msg does not have > a body, this
    will append an extra new-line character to the msg title > which would cause
    the splited commit has a new sha1 hash. In most cases, > this does not matter,
    but for a project which did not merged using this > script initially, the
    'split' command would not genereate the same > commits as the orginal which
    may cause conflicts. > > Signed-off-by: Techlive Zheng <techlivezheng@gmail.com> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203915>

Techlive Zheng <techlivezheng@gmail.com> writes:

> "%s%n%n%b" is not always equal to "%B". If the commit msg does not have
> a body, this will append an extra new-line character to the msg title
> which would cause the splited commit has a new sha1 hash. In most cases,
> this does not matter, but for a project which did not merged using this
> script initially, the 'split' command would not genereate the same
> commits as the orginal which may cause conflicts.
>
> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 920c664..5598210 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -296,7 +296,7 @@ copy_commit()
>  	# We're going to set some environment vars here, so
>  	# do it in a subshell to get rid of them safely later
>  	debug copy_commit "{$1}" "{$2}" "{$3}"
> -	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
> +	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
>  	(
>  		read GIT_AUTHOR_NAME
>  		read GIT_AUTHOR_EMAIL

This looks good to me.  I assume this passes all the tests.  Can you add
a test for this bug so we don't regress?  Junio, I am good with this
patch as soon as we get a test for the problem.

Thanks!

                             -Dave
