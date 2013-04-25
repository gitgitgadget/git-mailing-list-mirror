From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 23:49:42 +0530
Message-ID: <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com> <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 20:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVQmT-000094-9E
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759226Ab3DYSUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 14:20:24 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:59483 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759218Ab3DYSUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 14:20:23 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so2870556iar.16
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QhpmGrSIYIRmmsEifrXKZpFG5jld1KfBdNsezC4SPV0=;
        b=W02KLyrirNeae1okN+N9i/8mUlDR3KXPLOGA6tuegfDguUbV+j8PeQwmpqKergmYkS
         7Hpw3+4RqqgrdnC9D8mESEFqJBaUie9YhKObIhq87j2U+qDWFtvHqs3E2klqo65j9P0d
         wq6UgJop+yrvWBrqZ8Ft73kEX1Y4jiJWgfjby2HKML0EMWtQVXZnQ+PjlYY4QWrqGXnd
         +FkPyGMQQtM3Ku7nRO7SHxz2qIJJ2gPzuq0OjIZLEYIq2wx+vL/eTYS/sKSWNxYuLBc6
         1WQapox1c2Ta0LHYgrBMevrWrEYKB823yYIIt4WpIxxTRwSG96cX2XMFJkMsWqyGEZS9
         /DLA==
X-Received: by 10.50.55.73 with SMTP id q9mr26634303igp.44.1366914023031; Thu,
 25 Apr 2013 11:20:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 11:19:42 -0700 (PDT)
In-Reply-To: <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222405>

Felipe Contreras wrote:
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index aa7bc97..82bf7c7 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -94,7 +94,7 @@ class Marks:
>          return self.last_mark
>
>      def is_marked(self, rev):
> -        return self.marks.has_key(rev)
> +        return rev in self.marks

Why?  Is the new form faster than the older one?

> @@ -224,7 +224,7 @@ def export_files(tree, files):
>              else:
>                  mode = '100644'
>
> -            # is the blog already exported?
> +            # is the blob already exported?

What is this?  Whitespace?

> @@ -521,7 +521,7 @@ def c_style_unescape(string):
>      return string
>
>  def parse_commit(parser):
> -    global marks, blob_marks, bmarks, parsed_refs
> +    global marks, blob_marks, parsed_refs

How is this trivial?  You just removed one argument.

> @@ -555,7 +555,7 @@ def parse_commit(parser):
>              mark = int(mark_ref[1:])
>              f = { 'mode' : m, 'data' : blob_marks[mark] }
>          elif parser.check('D'):
> -            t, path = line.split(' ')
> +            t, path = line.split(' ', 1)

How on earth is this trivial?  It changes the entire meaning!

> @@ -643,6 +643,7 @@ def do_export(parser):
>                  wt = repo.bzrdir.open_workingtree()
>                  wt.update()
>          print "ok %s" % ref
> +

Whitespace?

I'm outraged by this.  What kind of changes are you pushing to
remote-hg?  A "trivial cleanups" bundling miscellaneous changes, with
no commit message?  Why don't you just squash everything into one
"miscellaneous changes" patch?
