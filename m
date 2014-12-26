From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/7] push.c: add an --atomic argument
Date: Fri, 26 Dec 2014 08:17:12 +0100
Message-ID: <549D0B78.402@alum.mit.edu>
References: <1419017941-7090-1-git-send-email-sbeller@google.com> <1419017941-7090-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Fri Dec 26 08:17:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4P9W-0007Cs-4A
	for gcvg-git-2@plane.gmane.org; Fri, 26 Dec 2014 08:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbaLZHRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2014 02:17:33 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47893 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbaLZHRc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2014 02:17:32 -0500
X-AuditID: 1207440d-f79976d000005643-55-549d0b805f82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DD.F2.22083.08B0D945; Fri, 26 Dec 2014 02:17:20 -0500 (EST)
Received: from [192.168.1.150] ([82.113.106.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBQ7HDEk020811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 26 Dec 2014 02:17:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1419017941-7090-7-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqNvAPTfEoOe2rEXXlW4mi4beK8wW
	b28uYbTo7fvEavFvQo3F5s3tLBZn3jQyOrB77Jx1l91jwaZSj4uXlD0WP/Dy+LxJLoA1itsm
	KbGkLDgzPU/fLoE74/mCV2wFa7UrVv98ztrA+EWpi5GTQ0LARKL3zBomCFtM4sK99WwgtpDA
	ZUaJea84uxi5gOyNTBItazeygiR4BdQlDhx+yg5iswioSvyZPhesgU1AV2JRTzPYIFGBIIkr
	LZuZIeoFJU7OfMICMkhEoJNR4s3HHWDNzAJ2El37l4ANFRawlGjZ8ocRYnO5xMklX8GGcgo4
	Sew885wZol5PYsf1X6wQtrxE89bZzBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuka6eVmluilppRuYoSEPO8Oxv/rZA4xCnAwKvHwJqybEyLEmlhWXJl7iFGSg0lJ
	lHfaS6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5Jd4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5C
	AumJJanZqakFqUUwWRkODiUJ3mSuuSFCgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ
	8aBYjS8GRitIigdorwVIO29xQWIuUBSi9RSjopQ471NOoIQASCKjNA9uLCyRvWIUB/pSmNcb
	pJ0HmAThul8BDWYCGvzt0myQwSWJCCmpBsZZvh3BDJ/nr95c/Oj5zg0tngytskdjQndNtin6
	M+O2l+xlB+ntU2s5J74q8A4vPDR7XXfNT9fNc6VVjlTVRKnw3xN3Che2qfdjvioa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261826>

On 12/19/2014 08:39 PM, Stefan Beller wrote:
> Add a command line argument to the git push command to request atomic
> pushes.
> 
> [...]
> 
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 21b3f29..da63bdf 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
>  SYNOPSIS
>  --------
>  [verse]
> -'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
> +'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
>  	   [-u | --set-upstream] [--signed]
>  	   [--force-with-lease[=<refname>[:<expect>]]]
> @@ -136,6 +136,11 @@ already exists on the remote side.
>  	logged.  See linkgit:git-receive-pack[1] for the details
>  	on the receiving end.
>  
> +--atomic::
> +	Use an atomic transaction on the remote side if available.
> +	Either all refs are updated, or on error, no refs are updated.
> +	If the server does not support atomic pushes the push will fail.
> +
> [...]

I'd like to discuss the big picture around this feature. I don't think
that any of these questions are blockers, with the possible exception of
the question of whether "--atomic" should fall back to non-atomic if the
server doesn't support atomic pushes.


1. Should "--atomic" someday become the default?

You seem to imply that "--atomic" might become the default sometime in
the future. (I realize that this patch series does not propose to change
the default but let's talk about it anyway.) In the real world, the most
common reason for an "--atomic" push to fail would be that somebody else
has pushed to a branch since our last update, resulting in a non-ff
error. Would I find out about such an error before or after I have
transferred my objects to the server?

If I only find out at the end of the transfer, then it could be a pretty
frustrating experience pushing a lot of references to a server over a
slow connection. After waiting for a long transfer to complete the user
would find out that the push was rejected and everything has to be done
again from scratch. In such cases non-"--atomic" behavior might be
attractive: any references that can be updated should be updated, so
that not *all* of the objects have to be pushed again.

Even *if* "--atomic" becomes the default, we would certainly want to
support a "--no-atomic" (or "--non-atomic"?) option to get the old
behavior. It might be a good idea to add that option now, so that
forward-looking script writers can start explicitly choosing "--atomic"
vs. "--no-atomic".


2. Is this an option that users will want to specify via the command line?

For scripts that want to insist on "atomic" updates, it is no problem to
specify "--atomic" on the command line.

But supposing that "--atomic" is a good default for some people, it
would be awkward for them to have to specify it on every "git push"
invocation. It therefore might be nice to have a configuration setting
to choose whether "--atomic" is the default.

Also (see above) it might be useful to set "--atomic" only for
particular servers (for example, only for those to which you have a fast
connection). This suggests that the "atomic/non-atomic" configuration
should be settable on a per-remote basis.


3. What should happen if the server doesn't support atomic pushes?

It seems to me that there are four reasonable behaviors WRT atomic
pushes. I'll give them tentative names for the purposes of this discussion:

"force" -- Insist on an atomic push, and fail if the server does not
support atomic pushes

"true" -- Use atomic push if supported by the server. If not, emit a
warning and fall back to non-atomic.

"auto" -- Use atomic push if supported by the server. If not, silently
fall back to non-atomic.

"false" -- Push non-atomically regardless of whether the server supports
atomic pushes.

To make it practical to set "atomic" as a universal default, we will
have to be able to deal with servers that don't (yet) support atomic
pushes. Therefore, we would want to use either "true" or "auto" (as
opposed to "force") as the default.

Even in such a case, it would be nice for the user to be able to
suppress any warnings for servers that don't support atomic updates. So
if "true" becomes the default, then we might want to support "auto" as well.

(One could argue that once "atomic" becomes the default, then anybody
who has to deal with an old server should just set "non-atomic" as the
default for that server. But even aside from the inconvenience to the
user, this is not a good alternative. A user who made that change
wouldn't benefit from atomic pushes once the server is upgraded to
support them.)

The command-line "--atomic" option is proposed to request "force"
behavior. On the one hand that makes sense; the user has explicitly
requested an atomic push, so the command should fail if it is not
possible. But on the other hand, if a particular server doesn't (yet)
support atomic pushes, what recourse does the user have but to run the
push again non-atomically? So it might be more expedient for the
"--atomic" option to be equivalent to "true" instead of "force". I don't
have a strong opinion on this either way.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
