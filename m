From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Sun, 15 Jun 2008 15:48:46 -0700 (PDT)
Message-ID: <m37icqpb5f.fsf@localhost.localdomain>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:49:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K812m-0005cQ-Fd
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 00:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbYFOWsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYFOWsw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 18:48:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:55140 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYFOWsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 18:48:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2965961ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 15:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=nQQ6hrbh9Uw7G5xEs9sGdi5KDeYrpbDsVr/v/aZuvYE=;
        b=WJlKa9NKkYkDBPGiB/YF5jB2dhPOjpr9u3LJwly71nHebsAPjC2Jb620t15NkwhCQ8
         QW9Au1rUm1FM6LGDRY41PwGkr0/7QnjLCQZ1D8EgWyccXStl0IMEA4ljH3LEEZxPI/WW
         N0qGqAC0J9Elt+FehOZOdqwzC7vUnFqe/Knt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=SmRkx7Y/0JvqWiKJfUkGsZ/n0b9dkr6OvCk9txU5vRoJvTA8cdJrI0g6I4cBZ4BTz9
         EXUQqA0EtT8inA0ksIgir+0eVo+o6oUtFjG2keZoncSNzhk7FApDlXjwHGpvDJXaNZPW
         a8Hko8fzT2KiO5r5HxpSBqZvolPv6JgupROpQ=
Received: by 10.151.101.20 with SMTP id d20mr9520029ybm.104.1213570129721;
        Sun, 15 Jun 2008 15:48:49 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.105])
        by mx.google.com with ESMTPS id s35sm16764181qbs.13.2008.06.15.15.48.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 15:48:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5FMmjQ2014787;
	Mon, 16 Jun 2008 00:48:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5FMmiW5014784;
	Mon, 16 Jun 2008 00:48:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85149>

Lea Wiemann <lewiemann@gmail.com> writes:

I would perhaps choose "gitweb: standarize HTTP status codes"
as the subject, but the one you chosen is also good.

> Many error status codes simply default to 403 Forbidden, which is not
> correct in most cases.  This patch makes gitweb return semantically
> correct status codes.

I'm not sure if "403 Forbidden" is not correct error code in the
absence of further information.

I'd like to have reasoning when, and why, we use which responses (HTTP
status codes) in which situations.  Link to appropriate RFC you used
(and perhaps to some other information) wouldn't be out of the
question.  See also below.

> For convenience the die_error function now only takes the status code
> without reason as first parameter (e.g. 404 instead of "404 Not
> Found"), and it now defaults to 500 (Internal Server Error), even
> though the default is not used anywhere.

Well, gitweb sometimes used different wording (different explanation)
for the same error message / HTTP status code, for example it is
generic "403 Forbidden", but when trying to access page which is not
available due to some restrictions (like feature being disabled) it is
"403 Permission Denied".

> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> ---
> I recommend that you apply this patch beforehand:
> [PATCH] gitweb: remove git_blame and rename git_blame2 to git_blame
> http://article.gmane.org/gmane.comp.version-control.git/84036/raw

First, why?  

Second, I think it is not possible, as IIRC removal of git-annotate
based git_blame got already applied.

> In some cases I've simply trusted the existing message (so when the
> message said "not found", I would make it a 404 error without checking
> whether the message is accurate).  Also, in some cases an overly
> generic 500 Internal Server Error is returned, e.g. in several cases
> like this one ...
> 
>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
> -		or die_error(undef, "Open git-ls-tree failed");
> +		or die_error(500, "Open git-ls-tree failed");

Should we really use "500 Internal Server Error" here?  Usually this
would be not an error at all, but wrong parameters to git command,
i.e. it is _user_ who erred, not some error on _server_ side.  I would
use "500 Internal Server Error" if for example git binary could not be
found...

> ... I suspect that the error could be triggered by non-existent hashes
> as well, in which case the more specific 404 would be more appropriate
> -- however, the current implementation oftentimes doesn't allow for
> more fine-granulared checking, and I don't want to add actual code as
> long as we don't have tests.  So we'll go with catch-all 500 errors in
> the meantime; it's not a regression, at least.

...that is why I'd rather have "403 Forbidden" as catch-all error, as
it was done in gitweb.  But that also seems not very good idea.

It seems like this is a matter of taste.

> Jakub: Let's make this patch a prerequisite for the Mechanize tests so
> we can test for exact status codes rather than [45][0-9][0-9].

Could you please Cc me if you address me in email?  I am not
subscribed to git mailing list, I read it via GMane NNTP (Usenet news)
interface; and even if I had been subscribed it is better to Cc people
who might be interested (in the case of gitweb caching it would be
probably me, Petr Baudis, John Hawley, perhaps Luben Tuikov).

[...]
>  sub die_error {
> -	my $status = shift || "403 Forbidden";
> -	my $error = shift || "Malformed query, file missing or permission denied";
> +	my $status = shift || 500;
> +	my $error = shift || "Internal server error";

Errr, I think "Malformed query, file missing or permission denied" is
actually closer to truth, and better error message (it is displayed in
body of message)
  
> -	git_header_html($status);
> +	# Use a generic "Error" reason, e.g. "404 Error" instead of
> +	# "404 Not Found".  This is permissible by RFC 2616.
> +	git_header_html("$status Error");
>  	print <<EOF;

Even if it is _permissible_ by RFC 2616, I don't think it is
_recommended_ practice.  IIRC it is recommnded for some (all?) HTTP
error status codes to give more detailed explanation in the body of
message.

==================================================================

Proposed usage of HTTP server/client error status codes in gitweb:

1. Basic CGI parameter validation; this catches for example invalid
   action names and invalid order names, pathnames which doesn't look
   like good pathnames, hash* parameters which doesn't look like
   refnames, extra option parameters not on allowed list, page which
   is not a number, unknown action, etc.

   These should probably all return "400 Bad Request", or perhaps 
   "404 Not Found" as catch-all, not "403 Forbidden".

2. Gitweb cannot find requested resource; this includes requesting
   project which does not exists (and, for security reasons, also
   those excluded from gitweb by different means), tag does not exists
   etc.  I'm not sure if include there situations where for example
   filename is missing for a 'blob' view request.

   Here "404 Not Found" would be most valid.

3. Some required parameters are missing, for example action other than
   projects list (in any format) and no project provided, 

   I think that here "400 Bad Request" is probably best solution.

4. Project list is requested, but there are no projects (or no forks)
   to be displayed by gitweb.

   This is a strange situation indeed, and I'm not sure what proper
   HTTP code should be used.  I don't think that "404 Not Found" would
   be good solution...

5. When some feature is requested that is not enabled, but with
   different gitweb configuration would be available.  

   Authorization wouldn't change the response, so I guess best would
   be "403 Forbidden" or "403 Permission Denied".

6. Request is made for a wrong type of object, for example 'blame' on
   object which is not a blob.

   Here I guess "400 Bad Request" would be good solution (if not 404).

7. When the git command failed, and we don't know the reason...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
