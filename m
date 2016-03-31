From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: git alias quoting help
Date: Thu, 31 Mar 2016 10:27:35 -0400
Message-ID: <CAH_OBie1Bc==wPByestESHz-K8ezC7f5A1D=t1SsP9=Sd-y-eg@mail.gmail.com>
References: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:28:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldZo-000597-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbcCaO15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:27:57 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36092 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607AbcCaO1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:27:55 -0400
Received: by mail-pf0-f181.google.com with SMTP id e128so49476682pfe.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=N13d00TSCTrUfa7iQKIgvQkrFyRSdInI0S54mDRTmJE=;
        b=TJ+bSG2g+8IZi/GvZeNDNHr6jGHLaoL0N7h2nbFgxU+3yeIKTN8Xm1KDI8+CKlUY9x
         OnK9grI4+M1HTWy6nz5jycSsRmgtkYmP2h1ZYnGfW9kG/ACn2hWx4cU541RKisZHqP2p
         ElibniO89pO91/cRkkxpn7e2ezawlGXjdyOHfrMLPs7QaxLGYIvUktecI3GZSNqkXk8P
         lOLV9hjmNjjinoTMzPER0KnmXmY+EEgFEAK3ZG5MOiIFXJBYrkABnGrERdfQBrdECFca
         RzatxdWcNdPuDz6PEk/3RGVySNnS+ag9uYNQu3D4xP4TEfYqiUZpWPgBVuksceqmrLr8
         M4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=N13d00TSCTrUfa7iQKIgvQkrFyRSdInI0S54mDRTmJE=;
        b=jtbBNrL+ONfhywMcsaecTurM9TO04i+RrgAAGgOWHutUEk7YwXdIgJ0FX0bwfCkpBL
         OSi443VDkKg20gbEbiUre/FHezMqYtriX5hHkUVfWfuRd2DbPmG4ECdD+9gVOSkYHEGd
         D41zlt/ulS8k95qhXJer/vL2+7+aaDjNEqqpmOhy56iBqtGRcWEg701FClx/8vLB7LmQ
         kYj1Fes7cHiEIHWNEyuXAMPntUY1wYv2UDomnjG/1mhEccgkE3zL1EvZpr3LB+6MWxv8
         MJTtX4Rexk1vbcxqIzhPbSa1Fo2ix05HWRDjPllUBpuu/+vbTwGBAk65RA8Xjifb5B18
         8cJQ==
X-Gm-Message-State: AD7BkJJYG9dOLLJ2Qx3eL50c9Nr+yA1VYA8PtGZFxgcWZ0jFpYXdbICU/0xqCuaYUdOC9kqmt5xLksZlsI4V8g==
X-Received: by 10.98.71.210 with SMTP id p79mr22456355pfi.4.1459434474687;
 Thu, 31 Mar 2016 07:27:54 -0700 (PDT)
Received: by 10.66.5.163 with HTTP; Thu, 31 Mar 2016 07:27:35 -0700 (PDT)
In-Reply-To: <CAH_OBievBBjzLwPZf3-qLn-SQyJG0UHhbdkvyZFfC8b-TsTUJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290389>

BTW, just trying to get filter-branch to interpret the bash script
string correctly now and it still isn't working:

git filter-branch -f --prune-empty --index-filter "\
  git ls-files -s | \
  sed \"s-\\t\\\"*-&${1}-\" | \
  GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
  git update-index --index-info && \
    mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE \
" HEAD

 I'm guessing bash is grabbing my actual bash shell is grabbing the
GIT_INDEX_FILE declaration for itself. If this is the case, I'm not
sure how to stop it - tried var\=\$var.new and that passes the '\='
which totally messes things up.

Rewrite ef54b77e59c7f4e18f00168ba88a8d2fee795802 (1/76)mv: cannot stat
`/<repo path>/.git-rewrite/t/../index.new': No such file or directory
index filter failed:   git ls-files -s |   sed
"s-\t\"*-&cookbooks/adjoin/-" |   GIT_INDEX_FILE=$GIT_INDEX_FILE.new
git update-index --index-info &&     mv $GIT_INDEX_FILE.new
$GIT_INDEX_FILE

On Wed, Mar 30, 2016 at 12:13 AM, shawn wilson <ag4ve.us@gmail.com> wrote:
> I've also tried to make this a plain bash script (w/o the function or
> if statements and am failing at the same place). The issue seems to be
> with the quoting in the filter-branch | ls-files bit. Also, the end
> goal here is to be able to move a directory from one repo and keep the
> history. While this works if I do it at the command line, it's just
> too many steps (is tedious). Also, if there's a way to do the same
> thing with multiple directories in one shot, (or make this work with
> something like: cookbooks/{a,b,c} # as a parameter) that'd be perfect.
>
>   reapdir = "!f() { \
>     if [ -d "$1" ] ; then \
>       git filter-branch --prune-empty --subdirectory-filter "$1" -- --all && \
>       git gc --aggressive && \
>       git prune && \
>       git filter-branch -f --prune-empty --index-filter '\
>         git ls-files -s \
>           | sed \"s-\\t-&$1-\" \
>           | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index
> --index-info && \
>             mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'; \
>     else \
>       echo "No directory $1"; \
>     fi; }; \
>   f"
