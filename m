From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Documentation: move options of git-diff-tree to a separate file.
Date: Sun, 27 Apr 2008 16:29:55 +0900
Message-ID: <200804270730.m3R7UTTn011092@mi1.bluebottle.com>
References: <1209262661-14370-1-git-send-email-vmiklos@frugalware.org> <7vod7wkuue.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:31:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1M5-0000Dw-Rm
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYD0Had (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYD0Had
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:30:33 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:42682 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbYD0Hac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:30:32 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3R7UTTn011092
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:30:29 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=o6ET8LqGw0BMOSOsbIjYee1Kgd89UsJLGOC6dhknlHMeeEwcWjeEyU3mwpufanW7G
	hq1xKsBw/kw3XHoCuV7S0Xmo2f7gQECSCRZCoiWit5MmqS9w4G3Kc+B8TgfAtqt
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3R7UH96029757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Apr 2008 00:30:25 -0700
In-reply-to: <1209262661-14370-1-git-send-email-vmiklos@frugalware.org>
X-Trusted-Delivery: <db96c2cfa9148420bdf312d4deff66e7>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80428>

Quoting Miklos Vajna <vmiklos@frugalware.org>:

> On Sat, Apr 26, 2008 at 05:24:57PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Are you sure "git show" takes --stdin?
>>
>> Also for "show", listing --cc as one of the options does not make much
>> sense, as that is an unoverridable default.
>>
>> And no, making it overridable so that it can take -m to show
>> independent
>> diff against each parent of a merge commit do not make much sense in
>> the
>> context of "git show".
>
> Right, --stdin and --cc is not something I should move
> to diff-tree-options.txt. Updated patch below.

I do not know if the updated patch is correct either.

Did you try "git show" with the options you have in the new "tree-options" file, for example "git show --root HEAD", and checked to make sure they make sense?

I think "git show -s" makes sense as it is easier to type than "git log -1" but I do not think any other options you listed makes sense with "git show".

>
>  Documentation/diff-tree-options.txt |   43 ++++++++++++++++++++++++++++++
>  Documentation/git-diff-tree.txt     |   49 +++--------------------------------
>  2 files changed, 47 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/diff-tree-options.txt
>
> diff --git a/Documentation/diff-tree-options.txt b/Documentation/diff-tree-options.txt
> new file mode 100644
> index 0000000..3049ede
> --- /dev/null
> +++ b/Documentation/diff-tree-options.txt
> @@ -0,0 +1,43 @@
> +-r::
> +        recurse into sub-trees
> +
> +-t::
> +	show tree entry itself as well as subtrees.  Implies -r.
> +
> +--root::
> +	When '--root' is specified the initial commit will be showed as a big
> +	creation event. This is equivalent to a diff against the NULL tree.
> +
> +-m::
> +	By default, "--stdin" does not show
> +	differences for merge commits.  With this flag, it shows
> +	differences to that commit from all of its parents. See
> +	also '-c'.
> +
> +-s::
> +	By default, "--stdin" shows differences,
> +	either in machine-readable form (without '-p') or in patch
> +	form (with '-p').  This output can be suppressed.  It is
> +	only useful with '-v' flag.
> +
> +-v::
> +	This flag causes "--stdin" to also show
> +	the commit message before the differences.
> +
> +--no-commit-id::
> +	The output contains a line with the commit ID when
> +	applicable.  This flag suppressed the commit ID output.
> +
> +-c::
> +	This flag changes the way a merge commit is displayed
> +	(which means it is useful only when the command is given
> +	one <tree-ish>, or '--stdin').  It shows the differences
> +	from each of the parents to the merge result simultaneously
> +	instead of showing pairwise diff between a parent and the
> +	result one at a time (which is what the '-m' option does).
> +	Furthermore, it lists only files which were modified
> +	from all parents.
> +
> +--always::
> +	Show the commit itself and the commit log message even
> +	if the diff itself is empty.
> diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
> index 58d02c6..55345df 100644
> --- a/Documentation/git-diff-tree.txt
> +++ b/Documentation/git-diff-tree.txt
> @@ -36,16 +36,6 @@ include::diff-options.txt[]
>  	Note that this parameter does not provide any wildcard or regexp
>  	features.
>  
> --r::
> -        recurse into sub-trees
> -
> --t::
> -	show tree entry itself as well as subtrees.  Implies -r.
> -
> ---root::
> -	When '--root' is specified the initial commit will be showed as a big
> -	creation event. This is equivalent to a diff against the NULL tree.
> -
>  --stdin::
>  	When '--stdin' is specified, the command does not take
>  	<tree-ish> arguments from the command line.  Instead, it
> @@ -57,38 +47,6 @@ the commit with its parents.  The following flags further affects its
>  behavior.  This does not apply to the case where two <tree-ish>
>  separated with a single space are given.
>  
> --m::
> -	By default, "git-diff-tree --stdin" does not show
> -	differences for merge commits.  With this flag, it shows
> -	differences to that commit from all of its parents. See
> -	also '-c'.
> -
> --s::
> -	By default, "git-diff-tree --stdin" shows differences,
> -	either in machine-readable form (without '-p') or in patch
> -	form (with '-p').  This output can be suppressed.  It is
> -	only useful with '-v' flag.
> -
> --v::
> -	This flag causes "git-diff-tree --stdin" to also show
> -	the commit message before the differences.
> -
> -include::pretty-options.txt[]
> -
> ---no-commit-id::
> -	git-diff-tree outputs a line with the commit ID when
> -	applicable.  This flag suppressed the commit ID output.
> -
> --c::
> -	This flag changes the way a merge commit is displayed
> -	(which means it is useful only when the command is given
> -	one <tree-ish>, or '--stdin').  It shows the differences
> -	from each of the parents to the merge result simultaneously
> -	instead of showing pairwise diff between a parent and the
> -	result one at a time (which is what the '-m' option does).
> -	Furthermore, it lists only files which were modified
> -	from all parents.
> -
>  --cc::
>  	This flag changes the way a merge commit patch is displayed,
>  	in a similar way to the '-c' option. It implies the '-c'
> @@ -99,9 +57,10 @@ include::pretty-options.txt[]
>  	hunks disappear, the commit itself and the commit log
>  	message is not shown, just like in any other "empty diff" case.
>  
> ---always::
> -	Show the commit itself and the commit log message even
> -	if the diff itself is empty.
> +include::diff-tree-options.txt[]
> +
> +
> +include::pretty-options.txt[]
>  
>  
>  include::pretty-formats.txt[]
> -- 
> 1.5.5.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Free pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
