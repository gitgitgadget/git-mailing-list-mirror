From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 4/4] git-p4: add support for large file systems
Date: Thu, 03 Sep 2015 21:03:51 +0100
Message-ID: <55E8A7A7.9010401@diamand.org>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-5-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 22:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXajr-0005Ol-C3
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbbICUDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 16:03:54 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36300 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbbICUDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:03:49 -0400
Received: by wibz8 with SMTP id z8so110378849wib.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=qzr7WAnW+GL2nZE4u/LPwavGPsA8RRWc8nIYGbWa5Vk=;
        b=EYL8n9+SoNWCKs3l4+J+JEYwMqT714NT7FvXKiAELf29i/bxuYK/pKJCavfpddc90j
         KB2SBYvUNr5qqtkVzsv4lhfgGgHo3thDqK+bbOj7Di8muDbPkBqRwMR+ERqRHyPwhrZK
         NWLM6g7vUWIfyjbS+5EaycDaDJinbTpBBAjQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qzr7WAnW+GL2nZE4u/LPwavGPsA8RRWc8nIYGbWa5Vk=;
        b=C1oA+f1EFuKU2QXoVfyjGFPd2J8KsvHoJqfuHUuZkqn5/1uYpkzHn/sQa8QHyUYFNf
         9TDXH/3Hm/hNQqs4mXw7GXwAmNW4ge041wcJmiFAPxtriKQGChVVCrnXyiFg6oGvMsbH
         1badBmPrLQijmVDTgxnGeDzpUCxTFYsbKcwfxERL+MLmR0ogWhrTj+OsqbS8HGrSfK4/
         KViSp2tcMkFIvECNkrBpaE8VjCKhJKC6FcXIFfXmUupLcOlwPfNzY8SfBL6+G6zuHEbY
         YXvDkyeF/X9F8xWZ/Wf10qbQuFnLJDxtgqh/Uj4thwKEjLOEUfDiLFURzYAc+42LWbNu
         wvdQ==
X-Gm-Message-State: ALoCoQlpEcqJ6NWfZfWreWnJ88YJ5bdanVQc8zvkbnnnehzXjDjIIc6rNoZFEsP6xRabL9xt8j2s
X-Received: by 10.194.5.103 with SMTP id r7mr52317210wjr.47.1441310628417;
        Thu, 03 Sep 2015 13:03:48 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id op6sm173453wic.12.2015.09.03.13.03.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Sep 2015 13:03:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1441298148-63885-5-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277249>

On 03/09/15 17:35, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Perforce repositories can contain large (binary) files. Migrating these
> repositories to Git generates very large local clones. External storage
> systems such as LFS [1] or git-annex [2] try to address this problem.
>
> Add a generic mechanism to detect large files based on extension,
> uncompressed size, and/or compressed size. Add LFS as example
> implementation.

Can you split this into "add mechanism for large file support" and then 
"add LFS implementation".

It will make it easier to review if nothing else.

Some other comments inline.

Thanks!
Luke

>
> [1] https://git-lfs.github.com/
> [2] http://www.git-annex.org/
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   Documentation/git-p4.txt |  21 ++++
>   git-p4.py                | 126 +++++++++++++++++++++--
>   t/t9823-git-p4-lfs.sh    | 263 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 401 insertions(+), 9 deletions(-)
>   create mode 100755 t/t9823-git-p4-lfs.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..eac5bad 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -510,6 +510,27 @@ git-p4.useClientSpec::
>   	option '--use-client-spec'.  See the "CLIENT SPEC" section above.
>   	This variable is a boolean, not the name of a p4 client.
>
> +git-p4.largeFileSystem::
> +	Specify the system that is used used for large (binary) files. Only
> +	"LFS" [1] is supported right now. Download and install the Git LFS
> +	command line extension to use this option.
> +	[1] https://git-lfs.github.com/
> +
> +git-p4.largeFileExtensions::
> +	All files matching a file extension in the list will be processed
> +	by the large file system. Do not prefix the extensions with '.'.
> +
> +git-p4.largeFileThreshold::
> +	All files with an uncompressed size exceeding the threshold will be
> +	processed by the large file system. By default the threshold is
> +	defined in bytes. Add the suffix k, m, or g to change the unit.
> +
> +git-p4.largeFileCompressedThreshold::
> +	All files with an compressed size exceeding the threshold will be

s/an compressed/a compressed/

> +	processed by the large file system. This option might significantly
> +	slow down your clone/sync process. By default the threshold is
> +	defined in bytes. Add the suffix k, m, or g to change the unit.
> +
>   Submit variables
>   ~~~~~~~~~~~~~~~~
>   git-p4.detectRenames::
> diff --git a/git-p4.py b/git-p4.py
> index 4d78e1c..cde75a5 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -22,6 +22,8 @@ import platform
>   import re
>   import shutil
>   import stat
> +import zipfile
> +import zlib
>
>   try:
>       from subprocess import CalledProcessError
> @@ -922,6 +924,51 @@ def wildcard_present(path):
>       m = re.search("[*#@%]", path)
>       return m is not None
>
> +def largeFileSystem():
> +    try:
> +        return getattr(sys.modules[__name__], gitConfig('git-p4.largeFileSystem'))
> +    except AttributeError as e:
> +        die('Large file system not supported: %s' % gitConfig('git-p4.largeFileSystem'))
> +
> +class LFS:

Docstrings?


> +    @staticmethod
> +    def description():
> +        return 'LFS (see https://git-lfs.github.com/)'
> +
> +    @staticmethod
> +    def attributeFilter():
> +        return 'lfs'
> +
> +    @staticmethod
> +    def generatePointer(cloneDestination, relPath, contents):
> +        # Write P4 content to temp file
> +        p4ContentTempFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)

delete=False, doesn't that mean that if anything goes wrong, we leave 
large files lying around? Perhaps that doesn't matter, I don't know.

> +        for d in contents:
> +            p4ContentTempFile.write(d)
> +        p4ContentTempFile.flush()

These seems like behaviour that could live in the base class or the main 
git-p4 code. It doesn't look LFS-specific.

> +
> +        # Generate LFS pointer file based on P4 content
> +        lfsProcess = subprocess.Popen(
> +            ['git', 'lfs', 'pointer', '--file=' + p4ContentTempFile.name],
> +            stdout=subprocess.PIPE
> +        )
> +        lfsPointerFile = lfsProcess.stdout.read()
> +        if lfsProcess.wait():
> +            os.remove(p4ContentTempFile.name)
> +            die('git-lfs command failed. Did you install the extension?')
> +        contents = [i+'\n' for i in lfsPointerFile.split('\n')[2:][:-1]]
> +
> +        # Write P4 content to LFS
> +        oid = contents[1].split(' ')[1].split(':')[1][:-1]
> +        oidPath = os.path.join(cloneDestination, '.git', 'lfs', 'objects', oid[:2], oid[2:4])
> +        if not os.path.isdir(oidPath):
> +            os.makedirs(oidPath)
> +        shutil.move(p4ContentTempFile.name, os.path.join(oidPath, oid))

This also does not look LFS-specific.

> +
> +        # LFS Spec states that pointer files should not have the executable bit set.
> +        gitMode = '100644'
> +        return (gitMode, contents)
> +
>   class Command:
>       def __init__(self):
>           self.usage = "usage: %prog [options]"
> @@ -2038,6 +2085,7 @@ class P4Sync(Command, P4UserMap):
>           self.clientSpecDirs = None
>           self.tempBranches = []
>           self.tempBranchLocation = "git-p4-tmp"
> +        self.largeFiles = []
>
>           if gitConfig("git-p4.syncFromOrigin") == "false":
>               self.syncWithOrigin = False
> @@ -2158,6 +2206,59 @@ class P4Sync(Command, P4UserMap):
>
>           return branches
>
> +    def writeToGitStream(self, gitMode, relPath, contents):
> +        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
> +        self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
> +        for d in contents:
> +            self.gitStream.write(d)
> +        self.gitStream.write('\n')
> +
> +    def writeGitAttributesToStream(self):
> +        self.writeToGitStream(
> +            '100644',
> +            '.gitattributes',
> +            [
> +                '\n',
> +                '#\n',
> +                '# %s\n' % largeFileSystem().description(),
> +                '#\n',
> +            ] +
> +            ['*.' + f.replace(' ', '[:space:]') + ' filter=%s -text\n' % largeFileSystem().attributeFilter()
> +                for f in gitConfigList("git-p4.largeFileExtensions")
> +            ] +
> +            ['/' + f.replace(' ', '[:space:]') + ' filter=%s -text\n' % largeFileSystem().attributeFilter()
> +                for f in self.largeFiles if not self.hasLargeFileExtension(f)
> +            ]
> +        )
> +
> +    def hasLargeFileExtension(self, relPath):
> +        return reduce(
> +            lambda a, b: a or b,
> +            [relPath.endswith('.' + e) for e in gitConfigList('git-p4.largeFileExtensions')],
> +            False
> +        )
> +
> +    def exceedsLargeFileThreshold(self, relPath, contents):
> +        if gitConfigInt('git-p4.largeFileThreshold'):
> +            contentsSize = sum(len(d) for d in contents)
> +            if contentsSize > gitConfigInt('git-p4.largeFileThreshold'):
> +                return True
> +        if gitConfigInt('git-p4.largeFileCompressedThreshold'):
> +            contentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> +            for d in contents:
> +                contentFile.write(d)
> +            contentFile.flush()
> +            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
> +            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
> +            zf.write(contentFile.name, compress_type=zipfile.ZIP_DEFLATED)
> +            zf.close()
> +            compressedContentsSize = zf.infolist()[0].compress_size
> +            os.remove(contentFile.name)
> +            os.remove(compressedContentFile.name)
> +            if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
> +                return True
> +        return False
> +
>       # output one file from the P4 stream
>       # - helper for streamP4Files
>
> @@ -2226,17 +2327,20 @@ class P4Sync(Command, P4UserMap):
>               text = regexp.sub(r'$\1$', text)
>               contents = [ text ]
>
> -        self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
> +        if relPath == '.gitattributes':
> +            die('.gitattributes already exists in P4.')
>
> -        # total length...
> -        length = 0
> -        for d in contents:
> -            length = length + len(d)
> +        if (gitConfig('git-p4.largeFileSystem') and
> +            (   self.exceedsLargeFileThreshold(relPath, contents) or
> +                self.hasLargeFileExtension(relPath)
> +            )):
> +            (git_mode, contents) = largeFileSystem().generatePointer(self.cloneDestination, relPath, contents)
> +            self.largeFiles.append(relPath)
> +            self.writeGitAttributesToStream()
> +            if verbose:
> +                sys.stderr.write("%s added to large file system\n" % relPath)
>
> -        self.gitStream.write("data %d\n" % length)
> -        for d in contents:
> -            self.gitStream.write(d)
> -        self.gitStream.write("\n")
> +        self.writeToGitStream(git_mode, relPath, contents)
>
>       def streamOneP4Deletion(self, file):
>           relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
> @@ -2244,6 +2348,10 @@ class P4Sync(Command, P4UserMap):
>               sys.stderr.write("delete %s\n" % relPath)
>           self.gitStream.write("D %s\n" % relPath)
>
> +        if relPath in self.largeFiles:
> +            self.largeFiles.remove(relPath)
> +            self.writeGitAttributesToStream()
> +
>       # handle another chunk of streaming data
>       def streamP4FilesCb(self, marshalled):
>
> diff --git a/t/t9823-git-p4-lfs.sh b/t/t9823-git-p4-lfs.sh
> new file mode 100755
> index 0000000..a7587bf
> --- /dev/null
> +++ b/t/t9823-git-p4-lfs.sh
> @@ -0,0 +1,263 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories and store files in LFS'
> +
> +git lfs help >/dev/null 2>&1 || {
> +	skip_all='skipping git p4 LFS tests; no git lfs'
> +	test_done
> +}
> +
> +. ./lib-git-p4.sh
> +
> +test_file_in_lfs() {
> +	FILE=$1
> +	SIZE=$2
> +	EXPECTED_CONTENT=$3
> +	test_path_is_file $FILE &&
> +	test_line_count = 3 $FILE &&
> +	cat $FILE | grep "size $SIZE" &&
> +	HASH=$(cat $FILE | grep "oid sha256:" | sed -e 's/oid sha256://g') &&
> +	LFS_FILE=".git/lfs/objects/${HASH:0:2}/${HASH:2:2}/$HASH"
> +	test_path_is_file $LFS_FILE &&
> +	echo $EXPECTED_CONTENT >expect
> +	test_cmp expect $LFS_FILE
> +}
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create repo with binary files' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		echo "txt 7b" >file1.txt &&
> +		p4 add file1.txt &&
> +		echo "bin 13 bytes" >file2.dat &&
> +		p4 add file2.dat &&
> +		p4 submit -d "Add text and binary file" &&
> +
> +		mkdir "path with spaces" &&
> +		echo "bin 13 bytes" >"path with spaces/file3.bin" &&
> +		p4 add "path with spaces/file3.bin" &&
> +		p4 submit -d "Add another binary file with same content and spaces in path" &&
> +
> +		echo "bin 14 bytesx" >file4.bin &&
> +		p4 add file4.bin &&
> +		p4 submit -d "Add another binary file with different content"
> +	)
> +'
> +
> +test_expect_success 'Store files in LFS based on size (>12 bytes)' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileThreshold 12 &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +
> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
> +		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &&
> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		test_line_count = 2 actual &&
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		/file2.dat filter=lfs -text
> +		/path[:space:]with[:space:]spaces/file3.bin filter=lfs -text
> +		/file4.bin filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Store files in LFS based on size (>13 bytes)' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileThreshold 13 &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +
> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		test_line_count = 1 actual &&
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		/file4.bin filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Store files in LFS based on extension (dat)' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileExtensions dat &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +
> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		test_line_count = 1 actual &&
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		*.dat filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Store files in LFS based on size (>13 bytes) and extension (dat)' '
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileExtensions dat &&
> +		git config git-p4.largeFileThreshold 13 &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +
> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
> +		test_file_in_lfs file4.bin 14 "bin 14 bytesx" &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		test_line_count = 2 actual &&
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		*.dat filter=lfs -text
> +		/file4.bin filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Remove file from repo and store files in LFS based on size (>12 bytes)' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +		p4 delete file4.bin &&
> +		p4 submit -d "Remove file"
> +	) &&
> +
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileThreshold 12 &&
> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
> +
> +		test_file_in_lfs file2.dat 13 "bin 13 bytes" &&
> +		test_file_in_lfs "path with spaces/file3.bin" 13 "bin 13 bytes" &&
> +		! test_path_is_file file4.bin &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		# 3 is correct here as some commits in the tree still reference the deleted file
> +		test_line_count = 3 actual
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		/file2.dat filter=lfs -text
> +		/path[:space:]with[:space:]spaces/file3.bin filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Add big files to repo and store files in LFS based on compressed size (>19 bytes)' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +		echo "bin 24 bytesxxxxxxxxxxx" >file5.bin &&
> +		p4 add file5.bin &&
> +		p4 submit -d "Add another binary file with different content" &&
> +
> +		echo "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz" >file6.bin &&
> +		p4 add file6.bin &&
> +		p4 submit -d "Add another binary file with different content"
> +	) &&
> +
> +	client_view "//depot/... //client/..." &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git init . &&
> +		git config git-p4.largeFileSystem LFS &&
> +		git config git-p4.largeFileCompressedThreshold 19 &&
> +		# We only import HEAD here ("@all" is missing!)
> +		git p4 clone --use-client-spec --destination="$git" //depot &&
> +
> +		test_file_in_lfs file6.bin 13 "bin 34 bytesxxxxxxxxxxxzzzzzzzzzz" &&
> +
> +		find ".git/lfs/objects" -type f >actual &&
> +		test_line_count = 1 actual
> +
> +		cat >expect <<-\EOF &&
> +
> +		#
> +		# LFS (see https://git-lfs.github.com/)
> +		#
> +		/file6.bin filter=lfs -text
> +		EOF
> +		test_path_is_file .gitattributes &&
> +		test_cmp expect .gitattributes
> +	)
> +'
> +
> +test_expect_success 'Clone repo with existing .gitattributes file' '
> +	client_view "//depot/... //client/..." &&
> +	(
> +		cd "$cli" &&
> +
> +		echo "*.txt text" >.gitattributes &&
> +		p4 add .gitattributes &&
> +		p4 submit -d "Add .gitattributes"
> +	) &&
> +
> +	test_must_fail git p4 clone --use-client-spec --destination="$git" //depot 2>errs &&
> +	grep ".gitattributes already exists in P4." errs
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
>
