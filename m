From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 8/8] git-remote-testpy: call print as a function
Date: Thu, 17 Jan 2013 19:48:49 -0800
Message-ID: <CAGdFq_hbstcUUUab42485oacdov4TS-f48e=spBSgi_jvBPCjw@mail.gmail.com>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
 <88502ee7b090454352b46d496741029817b27482.1358448207.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:50:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw2xk-0000Ex-7h
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 04:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab3ARDtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 22:49:32 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33315 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab3ARDta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 22:49:30 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so579276qca.17
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 19:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VHFh7TUACjMrfqpEbZi4ZhGdRVTAEFQSRmuw/i0DfaQ=;
        b=XjNh5GEr/izfH/iCXG878AOJUnhde/lmIPfuwFYTtPRP4h4rxPwrtW9TMi4IFOkt4c
         aR/5a37YEuM/n8URFmFreRyit5Sf0ptF6Q5i/+GXWXeCo0qA0qMTBP/7EISVPTJ06XWi
         D8N8n+BY2MGS76MP7D5dEcGeO6fV+sWg0DlaXXQwzu0naBQE/ehDJJpAaGwBXKHg2UXq
         40Qz/SiXhRcDruMkynsMl0IVfUxc9cWh0yum3PAj8BMrm/TY5lhO4r66Aenq3hK9KEeP
         MW6qCzHuW8eVOax+7XZ5oSRwbzFTd1RLSFVG1phLgxHFIn9xGvU6x4rrx+341oQPtyvE
         F8uA==
X-Received: by 10.224.105.137 with SMTP id t9mr8131323qao.32.1358480969509;
 Thu, 17 Jan 2013 19:49:29 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Thu, 17 Jan 2013 19:48:49 -0800 (PST)
In-Reply-To: <88502ee7b090454352b46d496741029817b27482.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213898>

Looks harmless enough.

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

On Thu, Jan 17, 2013 at 10:54 AM, John Keeping <john@keeping.me.uk> wrote:
> This is harmless in Python 2, which sees the parentheses as redundant
> grouping, but is required for Python 3.  Since this is the only change
> required to make this script just run under Python 3 without needing
> 2to3 it seems worthwhile.
>
> The case of an empty print must be handled specially because in that
> case Python 2 will interpret '()' as an empty tuple and print it as
> '()'; inserting an empty string fixes this.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git-remote-testpy.py | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/git-remote-testpy.py b/git-remote-testpy.py
> index bc5e3cf..ccdb2dc 100644
> --- a/git-remote-testpy.py
> +++ b/git-remote-testpy.py
> @@ -87,9 +87,9 @@ def do_capabilities(repo, args):
>      """Prints the supported capabilities.
>      """
>
> -    print "import"
> -    print "export"
> -    print "refspec refs/heads/*:%s*" % repo.prefix
> +    print("import")
> +    print("export")
> +    print("refspec refs/heads/*:%s*" % repo.prefix)
>
>      dirname = repo.get_base_path(repo.gitdir)
>
> @@ -98,11 +98,11 @@ def do_capabilities(repo, args):
>
>      path = os.path.join(dirname, 'git.marks')
>
> -    print "*export-marks %s" % path
> +    print("*export-marks %s" % path)
>      if os.path.exists(path):
> -        print "*import-marks %s" % path
> +        print("*import-marks %s" % path)
>
> -    print # end capabilities
> +    print('') # end capabilities
>
>
>  def do_list(repo, args):
> @@ -115,16 +115,16 @@ def do_list(repo, args):
>
>      for ref in repo.revs:
>          debug("? refs/heads/%s", ref)
> -        print "? refs/heads/%s" % ref
> +        print("? refs/heads/%s" % ref)
>
>      if repo.head:
>          debug("@refs/heads/%s HEAD" % repo.head)
> -        print "@refs/heads/%s HEAD" % repo.head
> +        print("@refs/heads/%s HEAD" % repo.head)
>      else:
>          debug("@refs/heads/master HEAD")
> -        print "@refs/heads/master HEAD"
> +        print("@refs/heads/master HEAD")
>
> -    print # end list
> +    print('') # end list
>
>
>  def update_local_repo(repo):
> @@ -164,7 +164,7 @@ def do_import(repo, args):
>          ref = line[7:].strip()
>          refs.append(ref)
>
> -    print "feature done"
> +    print("feature done")
>
>      if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
>          die('Told to fail')
> @@ -172,7 +172,7 @@ def do_import(repo, args):
>      repo = update_local_repo(repo)
>      repo.exporter.export_repo(repo.gitdir, refs)
>
> -    print "done"
> +    print("done")
>
>
>  def do_export(repo, args):
> @@ -192,8 +192,8 @@ def do_export(repo, args):
>          repo.non_local.push(repo.gitdir)
>
>      for ref in changed:
> -        print "ok %s" % ref
> -    print
> +        print("ok %s" % ref)
> +    print('')
>
>
>  COMMANDS = {
> --
> 1.8.1.1.260.g99b33f4.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,

Sverre Rabbelier
