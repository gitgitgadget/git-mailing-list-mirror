From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: git-format-patch.txt rewordings and
	cleanups
Date: Tue, 24 Mar 2009 18:09:13 -0400
Message-ID: <20090324220913.GN19389@fieldses.org>
References: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEpZ-0001f8-SK
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbZCXWJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZCXWJP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:09:15 -0400
Received: from mail.fieldses.org ([141.211.133.115]:42689 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbZCXWJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:09:15 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LmEo5-0006NG-9S; Tue, 24 Mar 2009 18:09:13 -0400
Content-Disposition: inline
In-Reply-To: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114499>

On Mon, Mar 23, 2009 at 03:21:23AM -0700, Stephen Boyd wrote:
> Clarify --no-binary description using some words from the original
> commit 37c22a4b (add --no-binary, 2008-05-9). Cleanup --suffix and
> --thread descriptions. Add --thread style option to synopsis. Clarify
> renaming patches example.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> Is the synopsis getting too heavy? Maybe it should be changed to:
> 
>     git format-patch [<options>] [<common diff options>] [<revision range>]
> 
>  Documentation/git-format-patch.txt |   34 +++++++++++++++++-----------------
>  1 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index c2eb5fa..f31098b 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -9,9 +9,9 @@ git-format-patch - Prepare patches for e-mail submission
>  SYNOPSIS
>  --------
>  [verse]
> -'git format-patch' [-k] [-o <dir> | --stdout] [--thread]
> +'git format-patch' [-k] [-o <dir> | --stdout] [--thread[=<style>]]
>  		   [--attach[=<boundary>] | --inline[=<boundary>] |
> -		     [--no-attach]]
> +		    --no-attach]
>  		   [-s | --signoff] [<common diff options>]
>  		   [-n | --numbered | -N | --no-numbered]
>  		   [--start-number <n>] [--numbered-files]
> @@ -132,9 +132,9 @@ include::diff-options.txt[]
>  	the Message-Id header to reference.
>  +
>  The optional <style> argument can be either `shallow` or `deep`.
> -'Shallow' threading makes every mail a reply to the head of the
> +'shallow' threading makes every mail a reply to the head of the
>  series, where the head is chosen from the cover letter, the
> -`\--in-reply-to`, and the first patch mail, in this order.  'Deep'
> +`\--in-reply-to`, and the first patch mail, in this order.  'deep'
>  threading makes every mail a reply to the previous one.  If not
>  specified, defaults to the 'format.thread' configuration, or `shallow`
>  if that is not set.
> @@ -169,24 +169,24 @@ if that is not set.
>  --suffix=.<sfx>::
>  	Instead of using `.patch` as the suffix for generated
>  	filenames, use specified suffix.  A common alternative is
> -	`--suffix=.txt`.
> +	`--suffix=.txt`.  Leaving this empty will remove the `.patch`
> +	suffix.
>  +
> -Note that you would need to include the leading dot `.` if you
> -want a filename like `0001-description-of-my-change.patch`, and
> -the first letter does not have to be a dot.  Leaving it empty would
> -not add any suffix.
> +Note the first letter is not required to be a dot, you will need to
> +include the leading dot `.` if you want a filename like
> +`0001-description-of-my-change.patch`.

That's a comma-splice, trivially fixed by changing "dot, you" to "dot;
you".

Better?: "Note that the leading dot isn't actually required if you don't
want a dot between the patch name and the suffix."

(Though personally I'd strike the whole sentence, since a) probably
nobody cares, and b) the 1 in a million person that does actually want
to do this can figure it out easily enough on their own with a quick
test.)

--b.

>  
>  --no-binary::
> -	Don't output contents of changes in binary files, just take note
> -	that they differ.  Note that this disable the patch to be properly
> -	applied.  By default the contents of changes in those files are
> -	encoded in the patch.
> +	Do not output contents of changes in binary files, instead
> +	display a notice that those files changed.  Patches generated
> +	using this option cannot be applied properly, but they are
> +	still useful for code review.
>  
>  CONFIGURATION
>  -------------
>  You can specify extra mail header lines to be added to each message
> -in the repository configuration, new defaults for the subject prefix
> -and file suffix, control attachements, and number patches when outputting
> +in the repository configuration, defaults for the subject prefix
> +and file suffix, configure attachments, and number patches when outputting
>  more than one.
>  
>  ------------
> @@ -234,8 +234,8 @@ $ git format-patch -M -B origin
>  +
>  Additionally, it detects and handles renames and complete rewrites
>  intelligently to produce a renaming patch.  A renaming patch reduces
> -the amount of text output, and generally makes it easier to review it.
> -Note that the "patch" program does not understand renaming patches, so
> +the amount of text output, and generally makes it easier to review.
> +Note that non-git "patch" programs won't understand renaming patches, so
>  use it only when you know the recipient uses git to apply your patch.
>  
>  * Extract three topmost commits from the current branch and format them
> -- 
> 1.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
