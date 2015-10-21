From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Wed, 21 Oct 2015 07:32:55 +0100
Message-ID: <56273197.3010505@diamand.org>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 08:33:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZomxW-0001HU-1p
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 08:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbbJUGdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 02:33:03 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33453 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbJUGdB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 02:33:01 -0400
Received: by wijp11 with SMTP id p11so78914829wij.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 23:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ZcJ/sDWI3faQoeQXU46tsdTBDWd/CXJMgRyPIvL6wOQ=;
        b=SR4+QjG90lNJRJrR5P5kwY9U5E2jTFY8ejsAHT88J9SRggaX+TW0f+eAn50WNAfW0d
         tpIAgCGRspM/14XPI0KM5j4Nn7nOCBCi9DrdkYT+G6qwatvOAEaiJh8ysYSBWibbyVc/
         qVc0Ncg/u7DRZeZ+cEo3eX5OIjupB+qKiRGmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZcJ/sDWI3faQoeQXU46tsdTBDWd/CXJMgRyPIvL6wOQ=;
        b=RBpWdNPJWBcJ7NdgKmC9clc9FOaOKbHNjo/PWNMbqq4xQsUdAijQncUDhdsaZRPnem
         rXTvGGDRT7vFdv5blBX9QjKot7Eu2kr0nFo0l3rlrX7FfEsX5PdS3o3GK0XUwyIW4qdJ
         5duyytHq7eELNvaMgeFDOgqIj0D17QCT0dNc0Q/B+6ugWLg+chl2gIhGva5+vTjfQ06H
         +2hxIsuvrRo4fljASsYmLYzv8YL23+bf86AXbyDsI46CLKflcsQ9ii0IJdSJmXB2jKN1
         vLJ1E/IdGMyZ8y+YGZvKITlZyMcRoGLEXTGM0RqxS9Jrv74C6Kh6QIISaDxbOIVtF9um
         doxw==
X-Gm-Message-State: ALoCoQmRPs1sTf5y9uZ4QXghkm/TzL0k8QdNNHIvJnbIKtHOVSORBExeXZc2lNVqc4esMhyQ99TE
X-Received: by 10.194.77.79 with SMTP id q15mr9952551wjw.102.1445409180100;
        Tue, 20 Oct 2015 23:33:00 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id q1sm8188775wje.39.2015.10.20.23.32.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2015 23:32:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279971>

On 19/10/15 19:43, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> A changelist that contains only excluded files (e.g. via client spec or
> branch prefix) will be imported as empty commit. Add option
> "git-p4.ignoreEmptyCommits" to ignore these commits.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   Documentation/git-p4.txt               |   5 ++
>   git-p4.py                              |  41 ++++++++-----
>   t/t9826-git-p4-ignore-empty-commits.sh | 103 +++++++++++++++++++++++++++++++++
>   3 files changed, 133 insertions(+), 16 deletions(-)
>   create mode 100755 t/t9826-git-p4-ignore-empty-commits.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..f096a6a 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -510,6 +510,11 @@ git-p4.useClientSpec::
>   	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>   	This variable is a boolean, not the name of a p4 client.
>
> +git-p4.ignoreEmptyCommits::
> +	A changelist that contains only excluded files will be imported
> +	as empty commit. To ignore these commits set this boolean option
> +	to 'true'.

s/as empty/as an empty/

Possibly putting 'true' in quotes could be confusing.

> +
>   Submit variables
>   ~~~~~~~~~~~~~~~~
>   git-p4.detectRenames::
> diff --git a/git-p4.py b/git-p4.py
> index 0093fa3..6c50c74 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
>           filesToDelete = []
>
>           for f in files:
> -            # if using a client spec, only add the files that have
> -            # a path in the client
> -            if self.clientSpecDirs:
> -                if self.clientSpecDirs.map_in_client(f['path']) == "":
> -                    continue
> -
>               filesForCommit.append(f)
>               if f['action'] in self.delete_actions:
>                   filesToDelete.append(f)
> @@ -2368,18 +2362,33 @@ class P4Sync(Command, P4UserMap):
>           if self.verbose:
>               print "commit into %s" % branch
>
> -        # start with reading files; if that fails, we should not
> -        # create a commit.
> -        new_files = []
> -        for f in files:
> -            if [p for p in self.branchPrefixes if p4PathStartsWith(f['path'], p)]:
> -                new_files.append (f)
> -            else:
> -                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
> -
>           if self.clientSpecDirs:
>               self.clientSpecDirs.update_client_spec_path_cache(files)
>
> +        def inClientSpec(path):

This seems to be adding a new function in the middle of an existing 
function. Is that right?

> +            if not self.clientSpecDirs:
> +                return True
> +            inClientSpec = self.clientSpecDirs.map_in_client(path)
> +            if not inClientSpec and self.verbose:
> +                print '\n  Ignoring file outside of client spec' % path
> +            return inClientSpec

Any particular reason for putting a \n at the start of the message?

Also, could you use python3 style print stmnts, print("whatever") ?



> +
> +        def hasBranchPrefix(path):
> +            if not self.branchPrefixes:
> +                return True
> +            hasPrefix = [p for p in self.branchPrefixes
> +                            if p4PathStartsWith(path, p)]
> +            if hasPrefix and self.verbose:
> +                print '\n  Ignoring file outside of prefix: %s' % path
> +            return hasPrefix
> +
> +        files = [f for f in files
> +            if inClientSpec(f['path']) and hasBranchPrefix(f['path'])]
> +
> +        if not files and gitConfigBool('git-p4.ignoreEmptyCommits'):
> +            print '\n  Ignoring change %s as it would produce an empty commit.'
> +            return

As with Junio's comment elsewhere, I worry about deletion here.


> +
>           self.gitStream.write("commit %s\n" % branch)
>   #        gitStream.write("mark :%s\n" % details["change"])
>           self.committedChanges.add(int(details["change"]))
> @@ -2403,7 +2412,7 @@ class P4Sync(Command, P4UserMap):
>                   print "parent %s" % parent
>               self.gitStream.write("from %s\n" % parent)
>
> -        self.streamP4Files(new_files)
> +        self.streamP4Files(files)
>           self.gitStream.write("\n")
>
>           change = int(details["change"])
> diff --git a/t/t9826-git-p4-ignore-empty-commits.sh b/t/t9826-git-p4-ignore-empty-commits.sh
> new file mode 100755
> index 0000000..5ddccde
> --- /dev/null
> +++ b/t/t9826-git-p4-ignore-empty-commits.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and ignore empty commits'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		mkdir -p subdir &&
> +
> +		>subdir/file1.txt &&
> +		p4 add subdir/file1.txt &&
> +		p4 submit -d "Add file 1" &&
> +
> +		>file2.txt &&
> +		p4 add file2.txt &&
> +		p4 submit -d "Add file 2" &&
> +
> +		>subdir/file3.txt &&
> +		p4 add subdir/file3.txt &&
> +		p4 submit -d "Add file 3"
> +	)
> +'
> +
> +test_expect_success 'Clone repo root path with all history' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 2
> +[git-p4: depot-paths = "//depot/": change = 2]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]

Could you not just test for existence of these files?

If the format of the magic comments that git-p4 ever changes, this will 
break.

(There's a patch out there that gets git-p4 to use git notes, so it's 
not as far-fetched as it sounds).


> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone repo subdir with all history' '
> +	client_view "//depot/subdir/... //client/subdir/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 2
> +[git-p4: depot-paths = "//depot/": change = 2]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF
> +		git log --format=%B >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'Clone repo subdir with all history but ignore empty commits' '
> +	client_view "//depot/subdir/... //client/subdir/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.ignoreEmptyCommits true &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +		cat >expect <<-\EOF &&
> +Add file 3
> +[git-p4: depot-paths = "//depot/": change = 3]
> +
> +Add file 1
> +[git-p4: depot-paths = "//depot/": change = 1]
> +
> +		EOF
> +		git log --format=%B >actual &&


A deletion test would make me feel more comfortable!

Thanks!
Luke
