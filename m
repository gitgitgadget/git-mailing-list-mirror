From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: Add option to keep empty commits
Date: Thu, 10 Dec 2015 01:05:55 +0000
Message-ID: <CAE5ih79WXkJYxrr3PAkXc6Upa6nOiqTpQEBOuwxHEk6xWsO5pQ@mail.gmail.com>
References: <1449567382-63713-1-git-send-email-larsxschneider@gmail.com>
	<1449567382-63713-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 02:06:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6pgH-0002LN-PH
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 02:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbLJBF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 20:05:57 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:32791 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbLJBFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 20:05:55 -0500
Received: by mail-ig0-f178.google.com with SMTP id mv3so5611348igc.0
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 17:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M83sdl9fRB9B2PniXoQ2FUypsyOMESNJWlBy8jxWIAc=;
        b=Rzsbf1PQmdpW9B8rG/KwzaSNqCF5XzZQ+H3B/NMSjyAotdRcid5c+DmNxvdcl4GD2Y
         I0RiSaL42VwChkucSuztJ1WL7O3q9cTB1KnjS0LGz5pMcVKW6oWfdTSeULXIsdZ9pUyk
         kxGMVO+M6Qye3qnXvGnDbRT3j9jS+TUl2cKi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M83sdl9fRB9B2PniXoQ2FUypsyOMESNJWlBy8jxWIAc=;
        b=EeaXC+NaCakYbuwe5PxE7VFkxSIqk2UdafQgk0uze96iI2ex72cSEvf39oLuqx12d7
         W9KyY4JYugxPfVqW7G/Etzuw9ip2mACKdbbpEAjjct5KYMqqnd0A1Gtc8MSAnhA/irZw
         uDakXQtf4e5/7zIKE+APBlRoyP53GyF80w22+xqu31v+jL03pPwwzqk9vMUAGrNdXs6v
         pvEKSGw7aLZ3pPK4+QWXr2u8Y/xGEdVziskkN+mvmWhA7XrUzEzkt/ou1VdYH/97a5/D
         ZxSr7W9F7gnX76GFWTeDONwCQ7waLi5cR/Vmt9ohiN+SCuZKsUvHnS0z1+8NWtDsjmGH
         CeHg==
X-Gm-Message-State: ALoCoQneC0MG960hgJ/sSx42NFO6F3nK+NLDbfb6n803twKEqIIZGWEe8jMhdnE2W4m+pi3sy8FOYJC/+xUfzlKvcRyrwZQ6Jw==
X-Received: by 10.50.3.71 with SMTP id a7mr12304456iga.80.1449709555094; Wed,
 09 Dec 2015 17:05:55 -0800 (PST)
Received: by 10.79.94.194 with HTTP; Wed, 9 Dec 2015 17:05:55 -0800 (PST)
In-Reply-To: <1449567382-63713-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282207>

On 8 December 2015 at 09:36,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> A changelist that contains only excluded files due to a client spec was
> imported as an empty commit. Fix that issue by ignoring these commits.
> Add option "git-p4.keepEmptyCommits" to make the previous behavior
> available.

Looks good to me. I think we discussed this a while back and it all
seemed sensible then, apart from not being quite bold enough.

Ack.



>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> Helped-by: Pete Harlan
> ---
>  Documentation/git-p4.txt             |   4 ++
>  git-p4.py                            |  44 +++++++-----
>  t/t9826-git-p4-keep-empty-commits.sh | 134 +++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+), 17 deletions(-)
>  create mode 100755 t/t9826-git-p4-keep-empty-commits.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..b3e768e 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -510,6 +510,10 @@ git-p4.useClientSpec::
>         option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>         This variable is a boolean, not the name of a p4 client.
>
> +git-p4.keepEmptyCommits::
> +       A changelist that contains only excluded files will be imported
> +       as an empty commit if this boolean option is set to true.
> +
>  Submit variables
>  ~~~~~~~~~~~~~~~~
>  git-p4.detectRenames::
> diff --git a/git-p4.py b/git-p4.py
> index 0093fa3..62c26bc 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
>          filesToDelete = []
>
>          for f in files:
> -            # if using a client spec, only add the files that have
> -            # a path in the client
> -            if self.clientSpecDirs:
> -                if self.clientSpecDirs.map_in_client(f['path']) == "":
> -                    continue
> -
>              filesForCommit.append(f)
>              if f['action'] in self.delete_actions:
>                  filesToDelete.append(f)
> @@ -2361,25 +2355,41 @@ class P4Sync(Command, P4UserMap):
>          gitStream.write(description)
>          gitStream.write("\n")
>
> +    def inClientSpec(self, path):
> +        if not self.clientSpecDirs:
> +            return True
> +        inClientSpec = self.clientSpecDirs.map_in_client(path)
> +        if not inClientSpec and self.verbose:
> +            print('Ignoring file outside of client spec: {0}'.format(path))
> +        return inClientSpec
> +
> +    def hasBranchPrefix(self, path):
> +        if not self.branchPrefixes:
> +            return True
> +        hasPrefix = [p for p in self.branchPrefixes
> +                        if p4PathStartsWith(path, p)]
> +        if hasPrefix and self.verbose:
> +            print('Ignoring file outside of prefix: {0}'.format(path))
> +        return hasPrefix
> +
>      def commit(self, details, files, branch, parent = ""):
>          epoch = details["time"]
>          author = details["user"]
>
>          if self.verbose:
> -            print "commit into %s" % branch
> -
> -        # start with reading files; if that fails, we should not
> -        # create a commit.
> -        new_files = []
> -        for f in files:
> -            if [p for p in self.branchPrefixes if p4PathStartsWith(f['path'], p)]:
> -                new_files.append (f)
> -            else:
> -                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
> +            print('commit into {0}'.format(branch))
>
>          if self.clientSpecDirs:
>              self.clientSpecDirs.update_client_spec_path_cache(files)
>
> +        files = [f for f in files
> +            if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
> +
> +        if not files and not gitConfigBool('git-p4.keepEmptyCommits'):
> +            print('Ignoring revision {0} as it would produce an empty commit.'
> +                .format(details['change']))
> +            return
> +
>          self.gitStream.write("commit %s\n" % branch)
>  #        gitStream.write("mark :%s\n" % details["change"])
>          self.committedChanges.add(int(details["change"]))
> @@ -2403,7 +2413,7 @@ class P4Sync(Command, P4UserMap):
>                  print "parent %s" % parent
>              self.gitStream.write("from %s\n" % parent)
>
> -        self.streamP4Files(new_files)
> +        self.streamP4Files(files)
>          self.gitStream.write("\n")
>
>          change = int(details["change"])
> diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
> new file mode 100755
> index 0000000..be12960
> --- /dev/null
> +++ b/t/t9826-git-p4-keep-empty-commits.sh
> @@ -0,0 +1,134 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and keep empty commits'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +       start_p4d
> +'
> +
> +test_expect_success 'Create a repo' '
> +       client_view "//depot/... //client/..." &&
> +       (
> +               cd "$cli" &&
> +
> +               mkdir -p subdir &&
> +
> +               >subdir/file1.txt &&
> +               p4 add subdir/file1.txt &&
> +               p4 submit -d "Add file 1" &&
> +
> +               >file2.txt &&
> +               p4 add file2.txt &&
> +               p4 submit -d "Add file 2" &&
> +
> +               >subdir/file3.txt &&
> +               p4 add subdir/file3.txt &&
> +               p4 submit -d "Add file 3" &&
> +
> +               >file4.txt &&
> +               p4 add file4.txt &&
> +               p4 submit -d "Add file 4" &&
> +
> +               p4 delete subdir/file3.txt &&
> +               p4 submit -d "Remove file 3" &&
> +
> +               p4 delete file4.txt &&
> +               p4 submit -d "Remove file 4"
> +       )
> +'
> +
> +test_expect_success 'Clone repo root path with all history' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +               cat >expect <<-\EOF &&
> +Remove file 4
> +[git-p4: depot-paths = "//depot/": change = 6]
> +
> +Remove file 3
> +[git-p4: depot-paths = "//depot/": change = 5]
> +
> +Add file 4
> +[git-p4: depot-paths = "//depot/": change = 4]
> +
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 2
> +[git-p4: depot-paths = "//depot/": change = 2]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +               EOF
> +               git log --format=%B >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Clone repo subdir with all history but keep empty commits' '
> +       client_view "//depot/subdir/... //client/subdir/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config git-p4.keepEmptyCommits true &&
> +               git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +               cat >expect <<-\EOF &&
> +Remove file 4
> +[git-p4: depot-paths = "//depot/": change = 6]
> +
> +Remove file 3
> +[git-p4: depot-paths = "//depot/": change = 5]
> +
> +Add file 4
> +[git-p4: depot-paths = "//depot/": change = 4]
> +
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 2
> +[git-p4: depot-paths = "//depot/": change = 2]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +               EOF
> +               git log --format=%B >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'Clone repo subdir with all history' '
> +       client_view "//depot/subdir/... //client/subdir/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git p4 clone --use-client-spec --destination="$git" --verbose //depot@all &&
> +               cat >expect <<-\EOF &&
> +Remove file 3
> +[git-p4: depot-paths = "//depot/": change = 5]
> +
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +               EOF
> +               git log --format=%B >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
> +test_expect_success 'kill p4d' '
> +       kill_p4d
> +'
> +
> +test_done
> --
> 2.5.1
>
