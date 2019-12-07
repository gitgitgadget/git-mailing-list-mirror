Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695F5C3F68F
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355424673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo72Pkmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLGRrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:53 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37807 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfLGRrw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:52 -0500
Received: by mail-wr1-f51.google.com with SMTP id w15so11369571wru.4
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RNKLUq3nsh0eJnKYesrrJnbUHWOyE18YVnaenGGrt18=;
        b=Bo72Pkmqvq+P+xNwG+jyq0jnaGMTnAW+kSxkPugu8UN9/7J1yuvjhZcp1GG3EfsGxw
         23zN+Y8WcjMLDycRwR6triIE9k4qsUJudQQxIQdwO5ZwoWSlXb1Y15oWFtBdTJkfyCl1
         baoHWvlCpIo0czoUZYX7BlOTRE30i4izKS7VULEfo9nouho2/T0bD0Xr9FIxK4AqClUZ
         DQ0e9yGBVZ+LzJDhdTpNrV2ZbkvRN00Y/iv02JtXl45I1ax0JH3r2lIm5XeFTh2RBLPy
         5YB2BqQvQyWHE3hF9umeM/VExzL7WaHODVE21vZdzjnYvsacVWRK3YW5n6YThGAaeXBc
         jUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RNKLUq3nsh0eJnKYesrrJnbUHWOyE18YVnaenGGrt18=;
        b=Ne9QItHa9JiO3yZWCPpIrqI3/jPZ6t+a9vwEF9IO3pnfxUXeyizl3wGr+b1YyHyCJH
         kQKkQznKTrRJIc9QZq7xKwSWit/WNfetuFNjo5eWstcOSaf2U1IgnSolAEs8OiQF/mlH
         sXT9wuB3eLrGSXbxkIY8wy/RRBXt+ml1YseZcxInWZTfRtd05Kl0ltw21e8AxfbVGH0T
         63PYYn0Lf8CacaScGE14AbToUZnmtqEshW3bumPWep0pwvvJOXinA+UjPlXxaZ4oVMPo
         NWQiDmEJbFb+gGdL5rILQBVp8AY7h9huLQdJAx9hwHL6OAKx1ju1IlUe1UEgKzAq/Tpb
         wRlQ==
X-Gm-Message-State: APjAAAW8a1M73xLUJXToREtV4+022twGR/6j/1nJCQJ0ve9wzYZDzvii
        kfN6ewsl5U4/W1dltDeB77oTu9Kc
X-Google-Smtp-Source: APXvYqyMlaS1L5qvuvXJVDL9jZLDoCGGpw38KfIz0iik8+cxm9yrlF3E1k2SjR+pshsTRgFeBjcUdw==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr22365711wru.119.1575740865366;
        Sat, 07 Dec 2019 09:47:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6sm21565869wrx.72.2019.12.07.09.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:44 -0800 (PST)
Message-Id: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:28 +0000
Subject: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings in python3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Issue: The current git-p4.py script does not work with python3.

I have attempted to use the P4 integration built into GIT and I was unable
to get the program to run because I have Python 3.8 installed on my
computer. I was able to get the program to run when I downgraded my python
to version 2.7. However, python 2 is reaching its end of life.

Submission: I am submitting a patch for the git-p4.py script that partially 
supports python 3.8. This code was able to pass the basic tests (t9800) when
run against Python3. This provides basic functionality. 

In an attempt to pass the t9822 P4 path-encoding test, a new parameter for
git P4 Clone was introduced. 

--encoding Format-identifier

This will create the GIT repository following the current functionality;
however, before importing the files from P4, it will set the
git-p4.pathEncoding option so any files or paths that are encoded with
non-ASCII/non-UTF-8 formats will import correctly.

Technical details: The script was updated by futurize (
https://python-future.org/futurize.html) to support Py2/Py3 syntax. The few
references to classes in future were reworked so that future would not be
required. The existing code test for Unicode support was extended to
normalize the classes “unicode” and “bytes” to across platforms:

 * ‘unicode’ is an alias for ‘str’ in Py3 and is the unicode class in Py2.
 * ‘bytes’ is bytes in Py3 and an alias for ‘str’ in Py2.

New coercion methods were written for both Python2 and Python3:

 * as_string(text) – In Python3, this encodes a bytes object as a UTF-8
   encoded Unicode string. 
 * as_bytes(text) – In Python3, this decodes a Unicode string to an array of
   bytes.

In Python2, these functions do not change the data since a ‘str’ object
function in both roles as strings and byte arrays. This reduces the
potential impact on backward compatibility with Python 2.

 * to_unicode(text) – ensures that the supplied data is encoded as a UTF-8
   string. This function will encode data in both Python2 and Python3. * 
      path_as_string(path) – This function is an extension function that
      honors the option “git-p4.pathEncoding” to convert a set of bytes or
      characters to UTF-8. If the str/bytes cannot decode as ASCII, it will
      use the encodeWithUTF8() method to convert the custom encoded bytes to
      Unicode in UTF-8.
   
   

Generally speaking, information in the script is converted to Unicode as
early as possible and converted back to a byte array just before passing to
external programs or files. The exception to this rule is P4 Repository file
paths.

Paths are not converted but left as “bytes” so the original file path
encoding can be preserved. This formatting is required for commands that
interact with the P4 file path. When the file path is used by GIT, it is
converted with encodeWithUTF8().

Signed-off-by: Ben Keene seraphire@gmail.com [seraphire@gmail.com]

Ben Keene (13):
  git-p4: select P4 binary by operating-system
  git-p4: change the expansion test from basestring to list
  git-p4: promote encodeWithUTF8() to a global function
  git-p4: remove p4_write_pipe() and write_pipe() return values
  git-p4: add new support function gitConfigSet()
  git-p4: add casting helper functions for python 3 conversion
  git-p4: python 3 syntax changes
  git-p4: fix assumed path separators to be more Windows friendly
  git-p4: add Py23File() - helper class for stream writing
  git-p4: p4CmdList - support Unicode encoding
  git-p4: support Python 3 for basic P4 clone, sync, and submit (t9800)
  git-p4: added --encoding parameter to p4 clone
  git-p4: Add depot manipulation functions

Jeff King (2):
  t/gitweb-lib.sh: drop confusing quotes
  t/gitweb-lib.sh: set $REQUEST_URI

 Documentation/git-p4.txt        |   5 +
 git-p4.py                       | 768 +++++++++++++++++++++++++-------
 t/t9822-git-p4-path-encoding.sh | 101 +++++
 3 files changed, 706 insertions(+), 168 deletions(-)


base-commit: 083378cc35c4dbcc607e4cdd24a5fca440163d17
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-463%2Fseraphire%2Fseraphire%2Fp4-python3-unicode-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-463/seraphire/seraphire/p4-python3-unicode-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/463

Range-diff vs v4:

  -:  ---------- >  1:  bb7f8f0a0a t/gitweb-lib.sh: drop confusing quotes
  -:  ---------- >  2:  a7a4c5a2aa t/gitweb-lib.sh: set $REQUEST_URI
  1:  4012426993 !  3:  e425ccc10f git-p4: select p4 binary by operating-system
     @@ -1,19 +1,18 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: select p4 binary by operating-system
     -
     -    Depending on the version of GIT and Python installed, the perforce program (p4) may not resolve on Windows without the program extension.
     -
     -    Check the operating system (platform.system) and if it is reporting that it is Windows, use the full filename of "p4.exe" instead of "p4"
     +    git-p4: select P4 binary by operating-system
      
          The original code unconditionally used "p4" as the binary filename.
      
     -    This change is Python2 and Python3 compatible.
     +    Depending on the version of Git and Python installed, the perforce
     +    program (p4) may not resolve on Windows without the program extension.
     +
     +    Check the operating system (platform.system) and if it is reporting that
     +    it is Windows, use the full filename of "p4.exe" instead of "p4"
      
     -    Thanks to: Junio C Hamano <gitster@pobox.com> and  Denton Liu <liu.denton@gmail.com> for patiently explaining proper format for my submissions.
     +    This change is Python 2 and Python 3 compatible.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 9a3a5c4e6d29dbef670072a9605c7a82b3729434)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -23,9 +22,8 @@
           can be done more easily.
           """
      -    real_cmd = ["p4"]
     -+    # Look for the P4 binary
      +    if (platform.system() == "Windows"):
     -+        real_cmd = ["p4.exe"]    
     ++        real_cmd = ["p4.exe"]
      +    else:
      +        real_cmd = ["p4"]
       
  2:  0ef2f56b04 !  4:  7170aface2 git-p4: change the expansion test from basestring to list
     @@ -2,14 +2,20 @@
      
          git-p4: change the expansion test from basestring to list
      
     -    Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
     +    Python 3 handles strings differently than Python 2.7.  Since Python 2
     +    is reaching it's end of life, a series of changes are being submitted to
     +    enable python 3.5 and following support. The current code fails basic
     +    tests under python 3.5.
      
     -    Change references to basestring in the isinstance tests to use list instead. This prepares the code to remove all references to basestring.
     +    The original code used 'basestring' in a test to determine if a list or
     +    literal string was passed into 9 different functions.  This is used to
     +    determine if the shell should be invoked when calling subprocess
     +    methods.
      
     -    The original code used basestring in a test to determine if a list or literal string was passed into 9 different functions.  This is used to determine if the shell should be evoked when calling subprocess methods.
     +    Change references to 'basestring' in the isinstance tests to use 'list'
     +    instead. This prepares the code to remove all references to basestring.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 5b1b1c145479b5d5fd242122737a3134890409e6)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
  5:  1bf7b073b0 !  5:  11d7703e41 git-p4: Add new functions in preparation of usage
     @@ -1,55 +1,53 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Add new functions in preparation of usage
     +    git-p4: promote encodeWithUTF8() to a global function
      
     -    This changelist is an intermediate submission for migrating the P4 support from Python2 to Python3. The code needs access to the encodeWithUTF8() for support of non-UTF8 filenames in the clone class as well as the sync class.
     +    This changelist is an intermediate submission for migrating the P4
     +    support from Python 2 to Python 3. The code needs access to the
     +    encodeWithUTF8() for support of non-UTF8 filenames in the clone class as
     +    well as the sync class.
      
     -    Move the function encodeWithUTF8() from the P4Sync class to a stand-alone function.  This will allow other classes to use this function without instanciating the P4Sync class. Change the self.verbose reference to an optional method parameter. Update the existing references to this function to pass the self.verbose since it is no longer available on "self" since the function is no longer contained on the P4Sync class.
     -
     -    Modify the functions write_pipe() and p4_write_pipe() to remove the return value.  The return value for both functions is the number of bytes, but the meaning is lost under python3 since the count does not match the number of characters that may have been encoded.  Additionally, the return value was never used, so this is removed to avoid future ambiguity.
     -
     -    Add a new method gitConfigSet(). This method will set a value in the git configuration cache list.
     +    Move the function encodeWithUTF8() from the P4Sync class to a
     +    stand-alone function.  This will allow other classes to use this
     +    function without instanciating the P4Sync class. Change the self.verbose
     +    reference to an optional method parameter. Update the existing
     +    references to this function to pass the self.verbose since it is no
     +    longer available on "self" since the function is no longer contained on
     +    the P4Sync class.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit affe888f432bb6833df78962e8671fccdf76c47a)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
       +++ b/git-p4.py
      @@
     -         sys.exit(1)
     - 
     - def write_pipe(c, stdin):
     -+    """ Executes the command 'c', passing 'stdin' on the standard input
     -+    """
     -     if verbose:
     -         sys.stderr.write('Writing pipe: %s\n' % str(c))
     + import ctypes
     + import errno
       
     +-# support basestring in python3
     ++# support basestring in Python 3
     + try:
     +     unicode = unicode
     + except NameError:
      @@
     -     if p.wait():
     -         die('Command failed: %s' % str(c))
     - 
     --    return val
     - 
     - def p4_write_pipe(c, stdin):
     -+    """ Runs a P4 command 'c', passing 'stdin' data to P4
     -+    """
     -     real_cmd = p4_build_cmd(c)
     --    return write_pipe(real_cmd, stdin)
     -+    write_pipe(real_cmd, stdin)
     - 
     - def read_pipe_full(c):
     -     """ Read output from  command. Returns a tuple
     + try:
     +     from subprocess import CalledProcessError
     + except ImportError:
     +-    # from python2.7:subprocess.py
     ++    # from Python 2.7:subprocess.py
     +     # Exception classes used by this module.
     +     class CalledProcessError(Exception):
     +         """This exception is raised when a process run by check_call() returns
      @@
           # otherwise False.
           return mode[-3:] == "755"
       
     -+def encodeWithUTF8(path, verbose = False):
     ++def encodeWithUTF8(path, verbose=False):
      +    """ Ensure that the path is encoded as a UTF-8 string
      +
      +        Returns bytes(P3)/str(P2)
      +    """
     -+   
     ++
      +    if isunicode:
      +        try:
      +            if isinstance(path, unicode):
     @@ -64,7 +62,7 @@
      +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
      +            if verbose:
      +                print('\nNOTE:Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, to_unicode(path)))
     -+    else:    
     ++    else:
      +        try:
      +            path.decode('ascii')
      +        except:
     @@ -79,18 +77,6 @@
       class P4Exception(Exception):
           """ Base class for exceptions from the p4 client """
           def __init__(self, exit_code):
     -@@
     -             _gitConfig[key] = []
     -     return _gitConfig[key]
     - 
     -+def gitConfigSet(key, value):
     -+    """ Set the git configuration key 'key' to 'value' for this session
     -+    """
     -+    _gitConfig[key] = value
     -+
     - def p4BranchesInGit(branchesAreInRemotes=True):
     -     """Find all the branches whose names start with "p4/", looking
     -        in remotes or heads as specified by the argument.  Return
      @@
                   self.gitStream.write(d)
               self.gitStream.write('\n')
  9:  4fc49313f0 !  6:  e28fe095b4 git-p4: Add usability enhancements
     @@ -1,75 +1,44 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Add usability enhancements
     +    git-p4: remove p4_write_pipe() and write_pipe() return values
      
     -    Issue: when prompting the user with raw_input, the tests are not forgiving of user input.  For example, on the first query asks for a yes/no response. If the user enters the full word "yes" or "no" the test will fail. Additionally, offer the suggestion of setting git-p4.attemptRCSCleanup when applying a commit fails because of RCS keywords. Both of these changes are usability enhancement suggestions.
     +    The git-p4 functions write_pipe() and p4_write_pipe() originally
     +    return the number of bytes returned from the system call. However,
     +    this is a misleading value when this function is run by Python 3.
      
     -    Change the code prompting the user for input to sanitize the user input before checking the response by asking the response as a lower case string, trimming leading/trailing spaces, and returning the first character.
     -
     -    Change the applyCommit() method that when applying a commit fails becasue of the P4 RCS Keywords, the user should consider setting git-p4.attemptRCSCleanup.
     +    Modify the functions write_pipe() and p4_write_pipe() to remove the
     +    return value.  The return value for both functions is the number of
     +    bytes, but the meaning is lost under python3 since the count does not
     +    match the number of characters that may have been encoded.
     +    Additionally, the return value was never used, so this is removed to
     +    avoid future ambiguity.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 1fab571664f5b6ad4ef321199f52615a32a9f8c7)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
       +++ b/git-p4.py
      @@
     -             return True
     +         sys.exit(1)
       
     -         while True:
     --            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
     -+            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ").lower() \
     -+                .strip()[0]
     -             if response == 'y':
     -                 return True
     -             if response == 'n':
     -@@
     -                     # disable the read-only bit on windows.
     -                     if self.isWindows and file not in editedFiles:
     -                         os.chmod(file, stat.S_IWRITE)
     --                    self.patchRCSKeywords(file, kwfiles[file])
     --                    fixed_rcs_keywords = True
     -+                    
     -+                    try:
     -+                        self.patchRCSKeywords(file, kwfiles[file])
     -+                        fixed_rcs_keywords = True
     -+                    except:
     -+                        # We are throwing an exception, undo all open edits
     -+                        for f in editedFiles:
     -+                            p4_revert(f)
     -+                        raise
     -+            else:
     -+                # They do not have attemptRCSCleanup set, this might be the fail point
     -+                # Check to see if the file has RCS keywords and suggest setting the property.
     -+                for file in editedFiles | filesToDelete:
     -+                    if p4_keywords_regexp_for_file(file) != None:
     -+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
     -+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
     -+                        break
     + def write_pipe(c, stdin):
     ++    """ Executes the command 'c', passing 'stdin' on the standard input
     ++    """
     +     if verbose:
     +         sys.stderr.write('Writing pipe: %s\n' % str(c))
       
     -             if fixed_rcs_keywords:
     -                 print("Retrying the patch with RCS keywords cleaned up")
     -@@
     -                         if self.conflict_behavior == "ask":
     -                             print("What do you want to do?")
     -                             response = raw_input("[s]kip this commit but apply"
     --                                                 " the rest, or [q]uit? ")
     -+                                                 " the rest, or [q]uit? ").lower().strip()[0]
     -                             if not response:
     -                                 continue
     -                         elif self.conflict_behavior == "skip":
      @@
     -                                    description = cmd.description,
     -                                    formatter = HelpFormatter())
     +     if p.wait():
     +         die('Command failed: %s' % str(c))
     + 
     +-    return val
     + 
     + def p4_write_pipe(c, stdin):
     ++    """ Runs a P4 command 'c', passing 'stdin' data to P4
     ++    """
     +     real_cmd = p4_build_cmd(c)
     +-    return write_pipe(real_cmd, stdin)
     ++    write_pipe(real_cmd, stdin)
       
     --    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     -+    try:
     -+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     -+    except:
     -+        parser.print_help()
     -+        raise
     -+
     -     global verbose
     -     verbose = cmd.verbose
     -     if cmd.needsGit:
     + def read_pipe_full(c):
     +     """ Read output from  command. Returns a tuple
  -:  ---------- >  7:  bc7009541b git-p4: add new support function gitConfigSet()
  3:  f0e658b984 !  8:  1e677781d2 git-p4: add new helper functions for python3 conversion
     @@ -1,31 +1,54 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: add new helper functions for python3 conversion
     +    git-p4: add casting helper functions for python 3 conversion
      
     -    Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
     +    Python 3 handles strings differently than Python 2.7.  Since Python 2
     +    is reaching it's end of life, a series of changes are being submitted to
     +    enable python 3.5 and following support. The current code fails basic
     +    tests under python 3.5.
      
     -    Change the existing unicode test add new support functions for python2-python3 support.
     +    Change the existing unicode test add new support functions for
     +    Python 2 - Python 3 support.
      
          Define the following variables:
     -    - isunicode - a boolean variable that states if the version of python natively supports unicode (true) or not (false). This is true for Python3 and false for Python2.
     -    - unicode - a type alias for the datatype that holds a unicode string.  It is assigned to a str under python 3 and the unicode type for Python2.
     -    - bytes - a type alias for an array of bytes.  It is assigned the native bytes type for Python3 and str for Python2.
     +    - isunicode - a boolean variable that states if the version of python
     +                  natively supports unicode (true) or not (false). This is
     +                  true for Python 3 and false for Python 2.
     +    - unicode   - a type alias for the datatype that holds a unicode string.
     +                  It is assigned to a str under Python 3 and the unicode
     +                  type for Python 2.
     +    - bytes     - a type alias for an array of bytes.  It is assigned the
     +                  native bytes type for Python 3 and str for Python 2.
      
          Add the following new functions:
      
     -    - as_string(text) - A new function that will convert a byte array to a unicode (UTF-8) string under python 3.  Under python 2, this returns the string unchanged.
     -    - as_bytes(text) - A new function that will convert a unicode string to a byte array under python 3.  Under python 2, this returns the string unchanged.
     -    - to_unicode(text) - Converts a text string as Unicode(UTF-8) on both Python2 and Python3.
     +    - as_string(text)  - A new function that will convert a byte array to a
     +                         unicode (UTF-8) string under Python 3.  Under
     +                         Python 2, this returns the string unchanged.
     +    - as_bytes(text)   - A new function that will convert a unicode string
     +                         to a byte array under Python 3.  Under Python 2,
     +                         this returns the string unchanged.
     +    - to_unicode(text) - Converts a text string as Unicode(UTF-8) on both
     +                         Python 2 and Python 3.
      
          Add a new function alias raw_input:
     -    If raw_input does not exist (it was renamed to input in python 3) alias input as raw_input.
     +    If raw_input does not exist (it was renamed to input in Python 3) alias
     +    input as raw_input.
      
     -    The AS_STRING and AS_BYTES functions allow for modifying the code with a minimal amount of impact on Python2 support.  When a string is expected, the as_string() will be used to convert "cast" the incoming "bytes" to a string type. Conversely as_bytes() will be used to convert a "string" to a "byte array" type. Since Python2 overloads the datatype 'str' to serve both purposes, the Python2 versions of these function do not change the data, since the str functions as both a byte array and a string.
     +    The as_string() and as_bytes() functions allow for modifying the code
     +    with a minimal amount of impact on Python 2 support. When a string is
     +    expected, the as_string() will be used to "cast" the incoming "bytes"
     +    to a string type.
      
     -    basestring is removed since its only references are found in tests that were changed in the previous change list.
     +    Conversely as_bytes() will be used to cast a "string" to a "byte array"
     +    type. Since Python 2 overloads the datatype 'str' to serve both purposes,
     +    the Python 2 versions of these function do not change the data. This
     +    reduces the regression impact of these code changes.
     +
     +    'basestring' is removed since its only references are found in tests
     +    that were changed in modified in previous commits.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 7921aeb3136b07643c1a503c2d9d8b5ada620356)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -36,7 +59,7 @@
           # 'unicode' is undefined, must be Python 3
      -    str = str
      +    #
     -+    # For Python3 which is natively unicode, we will use 
     ++    # For Python 3 which is natively unicode, we will use
      +    # unicode for internal information but all P4 Data
      +    # will remain in bytes
      +    isunicode = True
     @@ -45,8 +68,9 @@
      -    basestring = (str,bytes)
      +
      +    def as_string(text):
     -+        """Return a byte array as a unicode string"""
     -+        if text == None:
     ++        """ Return a byte array as a unicode string
     ++        """
     ++        if text is None:
      +            return None
      +        if isinstance(text, bytes):
      +            return unicode(text, "utf-8")
     @@ -54,8 +78,9 @@
      +            return text
      +
      +    def as_bytes(text):
     -+        """Return a Unicode string as a byte array"""
     -+        if text == None:
     ++        """ Return a Unicode string as a byte array
     ++        """
     ++        if text is None:
      +            return None
      +        if isinstance(text, bytes):
      +            return text
     @@ -63,15 +88,17 @@
      +            return bytes(text, "utf-8")
      +
      +    def to_unicode(text):
     -+        """Return a byte array as a unicode string"""
     -+        return as_string(text)    
     ++        """ Return a byte array as a unicode string
     ++        """
     ++        return as_string(text)
      +
      +    def path_as_string(path):
     -+        """ Converts a path to the UTF8 encoded string """
     ++        """ Converts a path to the UTF8 encoded string
     ++        """
      +        if isinstance(path, unicode):
      +            return path
      +        return encodeWithUTF8(path).decode('utf-8')
     -+    
     ++
       else:
           # 'unicode' exists, must be Python 2
      -    str = str
     @@ -79,7 +106,7 @@
      +    # We will treat the data as:
      +    #   str   -> str
      +    #   bytes -> str
     -+    # So for Python2 these functions are no-ops
     ++    # So for Python 2 these functions are no-ops
      +    # and will leave the data in the ambiguious
      +    # string/bytes state
      +    isunicode = False
     @@ -88,23 +115,25 @@
      -    basestring = basestring
      +
      +    def as_string(text):
     -+        """ Return text unaltered (for Python3 support) """
     ++        """ Return text unaltered (for Python 3 support)
     ++        """
      +        return text
      +
      +    def as_bytes(text):
     -+        """ Return text unaltered (for Python3 support) """
     ++        """ Return text unaltered (for Python 3 support)
     ++        """
      +        return text
      +
      +    def to_unicode(text):
     -+        """Return a string as a unicode string"""
     ++        """ Return a string as a unicode string
     ++        """
      +        return text.decode('utf-8')
     -+    
     ++
      +    def path_as_string(path):
     -+        """ Converts a path to the UTF8 encoded bytes """
     ++        """ Converts a path to the UTF8 encoded bytes
     ++        """
      +        return encodeWithUTF8(path)
      +
     -+
     -+ 
      +# Check for raw_input support
      +try:
      +    raw_input
     @@ -113,3 +142,21 @@
       
       try:
           from subprocess import CalledProcessError
     +@@
     +             if data[:space] == depotPath:
     +                 output = entry
     +                 break
     +-    if output == None:
     ++    if output is None:
     +         return ""
     +     if output["code"] == "error":
     +         return ""
     +@@
     +     global verbose
     +     verbose = cmd.verbose
     +     if cmd.needsGit:
     +-        if cmd.gitdir == None:
     ++        if cmd.gitdir is None:
     +             cmd.gitdir = os.path.abspath(".git")
     +             if not isValidGitDir(cmd.gitdir):
     +                 # "rev-parse --git-dir" without arguments will try $PWD/.git
  4:  3c41db3e91 !  9:  a221eb8bb6 git-p4: python3 syntax changes
     @@ -1,23 +1,33 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: python3 syntax changes
     +    git-p4: python 3 syntax changes
      
     -    Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.
     +    Python 3 handles strings differently than Python 2.7.  Since Python 2
     +    is reaching it's end of life, a series of changes are being submitted to
     +    enable python 3.5 and following support. The current code fails basic
     +    tests under python 3.5.
      
     -    There are a number of translations suggested by modernize/futureize that should be taken to fix numerous non-string specific issues.
     +    There are a number of translations suggested by modernize/futureize that
     +    should be taken to fix numerous non-string specific issues.
      
     -    Change references to the X.next() iterator to the function next(X) which is compatible with both Python2 and Python3.
     +    Change references to the X.next() iterator to the function next(X) which
     +    is compatible with both Python2 and Python3.
      
     -    Change references to X.keys() to list(X.keys()) to return a list that can be iterated in both Python2 and Python3.
     +    Change references to X.keys() to list(X.keys()) to return a list that
     +    can be iterated in both Python2 and Python3.
      
     -    Add the literal text (object) to the end of class definitions to be consistent with Python3 class definition.
     +    Add the literal text (object) to the end of class definitions to be
     +    consistent with Python3 class definition.
      
     -    Change integer divison to use "//" instead of "/"  Under Both python2 and python3 // will return a floor()ed result which matches existing functionality.
     +    Change integer divison to use "//" instead of "/"  Under Both Python 2
     +    and Python 3 // will return a floor()ed result which matches existing
     +    functionality.
      
     -    Change the format string for displaying decimal values from %d to %4.1f% when displaying a progress.  This avoids displaying long repeating decimals in user displayed text.
     +    Change the format string for displaying decimal values from %d to %4.1f%
     +    when displaying a progress.  This avoids displaying long repeating
     +    decimals in user displayed text.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit bde6b83296aa9b3e7a584c5ce2b571c7287d8f9f)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -30,7 +40,7 @@
      +import codecs
      +import io
       
     - # support basestring in python3
     + # support basestring in Python 3
       try:
      @@
       
  6:  8f5752c127 ! 10:  b962cce8cd git-p4: Fix assumed path separators to be more Windows friendly
     @@ -1,19 +1,30 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Fix assumed path separators to be more Windows friendly
     +    git-p4: fix assumed path separators to be more Windows friendly
      
     -    When a computer is configured to use Git for windows and Python for windows, and not a Unix subsystem like cygwin or WSL, the directory separator changes and causes git-p4 to fail to properly determine paths.
     +    When a computer is configured to use Git for windows and Python for
     +    windows, and not a Unix subsystem like cygwin or WSL, the directory
     +    separator changes and causes git-p4 to fail to properly determine paths.
      
          Fix 3 path separator errors:
      
     -    1. getUserCacheFilename should not use string concatenation. Change this code to use os.path.join to build an OS tolerant path.
     -    2. defaultDestiantion used the OS.path.split to split depot paths.  This is incorrect on windows. Change the code to split on a forward slash(/) instead since depot paths use this character regardless  of the operating system.
     -    3. The call to isvalidGitDir() in the main code also used a literal forward slash. Change the cose to use os.path.join to correctly format the path for the operating system.
     +    1. getUserCacheFilename() - should not use string concatenation. Change
     +       this code to use os.path.join to build an OS tolerant path.
      
     -    These three changes allow the suggested windows configuration to properly locate files while retaining the existing behavior on non-windows operating systems.
     +    2. defaultDestiantion used the OS.path.split to split depot paths.  This
     +       is incorrect on windows. Change the code to split on a forward
     +       slash(/) instead since depot paths use this character regardless  of
     +       the operating system.
     +
     +    3. The call to isValidGitDir() in the main code also used a literal
     +       forward slash. Change the code to use os.path.join to correctly
     +       format the path for the operating system.
     +
     +    These three changes allow the suggested windows configuration to
     +    properly locate files while retaining the existing behavior on
     +    non-windows operating systems.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit a5b45c12c3861638a933b05a1ffee0c83978dcb2)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -22,8 +33,8 @@
                   return True
       
           def getUserCacheFilename(self):
     -+        """ Returns the filename of the username cache 
     -+	    """
     ++        """ Returns the filename of the username cache
     ++        """
               home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
      -        return home + "/.gitp4-usercache.txt"
      +        return os.path.join(home, ".gitp4-usercache.txt")
     @@ -34,7 +45,7 @@
               self.cloneBare = False
       
           def defaultDestination(self, args):
     -+        """ Returns the last path component as the default git 
     ++        """ Returns the last path component as the default git
      +            repository directory name
      +        """
               ## TODO: use common prefix of args?
  7:  10dc059444 ! 11:  d22ada1614 git-p4: Add a helper class for stream writing
     @@ -1,25 +1,43 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Add a helper class for stream writing
     +    git-p4: add Py23File() - helper class for stream writing
      
     -    This is a transtional commit that does not change current behvior.  It adds a new class Py23File.
     +    This is a preparatory commit that does not change current behavior.
     +    It adds a new class Py23File.
      
     -    Following the Python recommendation of keeping text as unicode internally and only converting to and from bytes on input and output, this class provides an interface for the methods used for reading and writing files and file like streams.
     +    Following the Python recommendation of keeping text as unicode
     +    internally and only converting to and from bytes on input and output,
     +    this class provides an interface for the methods used for reading and
     +    writing files and file like streams.
      
     -    Create a class that wraps the input and output functions used by the git-p4.py code for reading and writing to standard file handles.
     +    A new class was implemented to avoid requiring additional dependencies.
      
     -    The methods of this class should take a Unicode string for writing and return unicode strings in reads.  This class should be a drop-in for existing file like streams
     +    Create a class that wraps the input and output functions used by the
     +    git-p4.py code for reading and writing to standard file handles.
      
     -    The following methods should be coded for supporting existing read/write calls:
     -    * write - this should write a Unicode string to the underlying stream
     -    * read - this should read from the underlying stream and cast the bytes as a unicode string
     -    * readline - this should read one line of text from the underlying stream and cast it as a unicode string
     -    * readline - this should read a number of lines, optionally hinted, and cast each line as a unicode string
     +    The methods of this class should take a Unicode string for writing and
     +    return unicode strings in reads.  This class should be a drop-in for
     +    existing file like streams
      
     -    The expression "cast as a unicode string" is used because the code should use the AS_BYTES() and AS_UNICODE() functions instead of cohercing the data to actual unicode strings or bytes.  This allows python 2 code to continue to use the internal "str" data type instead of converting the data back and forth to actual unicode strings. This retains current python2 support while python3 support may be incomplete.
     +    The following methods should be coded for supporting existing read/write
     +    calls:
     +      * write - this should write a Unicode string to the underlying stream
     +      * read  - this should read from the underlying stream and cast the
     +                bytes as a unicode string
     +      * readline - this should read one line of text from the underlying
     +                stream and cast it as a unicode string
     +      * readline - this should read a number of lines, optionally hinted,
     +                and cast each line as a unicode string
     +
     +    The expression "cast as a unicode string" is used because the code
     +    should use the as_bytes() and as_string() functions instead of
     +    cohercing the data to actual unicode strings or bytes.  This allows
     +    Python 2 code to continue to use the internal "str" data type instead
     +    of converting the data back and forth to actual unicode strings. This
     +    retains current Python 2 support while Python 3 support may be
     +    incomplete.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 12919111fbaa3e4c0c4c2fdd4f79744cc683d860)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -29,13 +47,13 @@
               return True
       
      +class Py23File():
     -+    """ Python2/3 Unicode File Wrapper 
     ++    """ Python2/3 Unicode File Wrapper
      +    """
     -+    
     ++
      +    stream_handle = None
      +    verbose       = False
      +    debug_handle  = None
     -+   
     ++
      +    def __init__(self, stream_handle, verbose = False):
      +        """ Create a Python3 compliant Unicode to Byte String
      +            Windows compatible wrapper
     @@ -47,7 +65,7 @@
      +        self.verbose       = verbose
      +
      +    def write(self, utf8string):
     -+        """ Writes the utf8 encoded string to the underlying 
     ++        """ Writes the utf8 encoded string to the underlying
      +            file stream
      +        """
      +        self.stream_handle.write(as_bytes(utf8string))
     @@ -56,7 +74,7 @@
      +            sys.stderr.flush()
      +
      +    def read(self, size = None):
     -+        """ Reads int charcters from the underlying stream 
     ++        """ Reads int charcters from the underlying stream
      +            and converts it to utf8.
      +
      +            Be aware, the size value is for reading the underlying
     @@ -69,7 +87,7 @@
      +            return as_string(self.stream_handle.read(size))
      +
      +    def readline(self):
     -+        """ Reads a line from the underlying byte stream 
     ++        """ Reads a line from the underlying byte stream
      +            and converts it to utf8
      +        """
      +        return as_string(self.stream_handle.readline())
     @@ -77,8 +95,8 @@
      +    def readlines(self, sizeHint = None):
      +        """ Returns a list containing lines from the file converted to unicode.
      +
     -+            sizehint - Optional. If the optional sizehint argument is 
     -+            present, instead of reading up to EOF, whole lines totalling 
     ++            sizehint - Optional. If the optional sizehint argument is
     ++            present, instead of reading up to EOF, whole lines totalling
      +            approximately sizehint bytes are read.
      +        """
      +        lines = self.stream_handle.readlines(sizeHint)
  8:  e1a424a955 ! 12:  e97ac0af8a git-p4: p4CmdList  - support Unicode encoding
     @@ -1,19 +1,55 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: p4CmdList  - support Unicode encoding
     +    git-p4: p4CmdList - support Unicode encoding
      
     -    The p4CmdList is a commonly used function in the git-p4 code. It is used to execute a command in P4 and return the results of the call in a list.
     +    The p4CmdList is a commonly used function in the git-p4 code. It is used
     +    to execute a command in P4 and return the results of the call in a list.
      
     -    Change this code to take a new optional parameter, encode_data that will optionally convert the data AS_STRING() that isto be returned by the function.
     +    The problem is that p4CmdList takes bytes as the parameter data and
     +    returns bytes in the return list.
      
     -    Change the code so that the key will always be encoded AS_STRING()
     +    Add a new optional parameter to the signature, encode_cmd_output, that
     +    determines if the dictionary values returned in the function output are
     +    treated as bytes or as strings.
      
     -    Data that is passed for standard input (stdin) should be AS_BYTES() to ensure unicode text that is supplied will be written out as bytes.
     +    Change the code to conditionally pass the output data through the
     +    as_string() function when encode_cmd_output is true. Otherwise the
     +    function should return the data as bytes.
      
     -    Additionally, change literal text prior to conversion to be literal bytes.
     +    Change the code so that regardless of the setting of encode_cmd_output,
     +    the dictionary keys in the return value will always be encoded with
     +    as_string().
     +
     +    as_string(bytes) is a method defined in this project that treats the
     +    byte data as a string. The word "string" is used because the meaning
     +    varies depending on the version of Python:
     +
     +      - Python 2: The "bytes" are returned as "str", functionally a No-op.
     +      - Python 3: The "bytes" are returned as a Unicode string.
     +
     +    The p4CmdList function returns a list of dictionaries that contain
     +    the result of p4 command. If the callback (cb) is defined, the
     +    standard output of the p4 command is redirected.
     +
     +    Data that is passed to the standard input of the P4 process should be
     +    as_bytes() to avoid conversion unicode encoding errors.
     +
     +    as_bytes(text) is a method defined in this project that treats the text
     +    data as a string that should be converted to a byte array (bytes). The
     +    behavior of this function depends on the version of python:
     +
     +      - Python 2: The "text" is returned as "str", functionally a No-op.
     +      - Python 3: The "text" is treated as a UTF-8 encoded Unicode string
     +            and is decoded to bytes.
     +
     +    Additionally, change literal text prior to conversion to be literal
     +    bytes for the code that is evaluating the standard output from the
     +    p4 call.
     +
     +    Add encode_cmd_output to the p4Cmd since this is a helper function that
     +    wraps the behavior of p4CmdList.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 88306ac269186cbd0f6dc6cfd366b50b28ee4886)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -23,7 +59,7 @@
       
       def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
      -        errors_as_exceptions=False):
     -+        errors_as_exceptions=False, encode_data=True):
     ++        errors_as_exceptions=False, encode_cmd_output=True):
      +    """ Executes a P4 command:  'cmd' optionally passing 'stdin' to the command's
      +        standard input via a temporary file with 'stdin_mode' mode.
      +
     @@ -37,7 +73,7 @@
      +        If 'errors_as_exceptions' is set to true (the default is false) the error
      +        code returned from the execution will generate an exception.
      +
     -+        If 'encode_data' is set to true (the default) the data that is returned 
     ++        If 'encode_cmd_output' is set to true (the default) the data that is returned
      +        by this function will be passed through the "as_string" function.
      +    """
       
     @@ -65,8 +101,38 @@
      -                result.append(entry)
      +                out = {}
      +                for key, value in entry.items():
     -+                    out[as_string(key)] = (as_string(value) if encode_data else value)
     ++                    out[as_string(key)] = (as_string(value) if encode_cmd_output else value)
      +                result.append(out)
           except EOFError:
               pass
           exitCode = p4.wait()
     +@@
     + 
     +     return result
     + 
     +-def p4Cmd(cmd):
     +-    list = p4CmdList(cmd)
     ++def p4Cmd(cmd, encode_cmd_output=True):
     ++    """Executes a P4 command and returns the results in a dictionary"""
     ++    list = p4CmdList(cmd, encode_cmd_output=encode_cmd_output)
     +     result = {}
     +     for entry in list:
     +         result.update(entry)
     +@@
     +     """Look at the p4 client spec, create a View() object that contains
     +        all the mappings, and return it."""
     + 
     +-    specList = p4CmdList("client -o")
     ++    specList = p4CmdList("client -o", encode_cmd_output=False)
     +     if len(specList) != 1:
     +         die('Output from "client -o" is %d lines, expecting 1' %
     +             len(specList))
     +@@
     +         if len(fileArgs) == 0:
     +             return  # All files in cache
     + 
     +-        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
     ++        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_cmd_output=False)
     +         for res in where_result:
     +             if "code" in res and res["code"] == "error":
     +                 # assume error is "... file(s) not in client view"
 10:  04a0aedbaa ! 13:  e7bb92bcd6 git-p4: Support python3 for basic P4 clone, sync, and submit
     @@ -1,54 +1,130 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Support python3 for basic P4 clone, sync, and submit
     +    git-p4: support Python 3 for basic P4 clone, sync, and submit (t9800)
      
     -    Issue: Python 3 is still not properly supported for any use with the git-p4 python code.
     -    Warning - this is a very large atomic commit.  The commit text is also very large.
     +    NOTE: Python 3 is still not properly supported for any use with the
     +    git-p4 python code.
      
     -    Change the code such that, with the exception of P4 depot paths and depot files, all text read by git-p4 is cast as a string as soon as possible and converted back to bytes as late as possible, following Python2 to Python3 conversion best practices.
     +    Warning - this is a very large atomic commit.  The commit text is also
     +    very large.
      
     -    Important: Do not cast the bytes that contain the p4 depot path or p4 depot file name.  These should be left as bytes until used.
     +    Change the code such that, with the exception of P4 depot paths and
     +    depot files, all text read by git-p4 is cast as a string as soon as
     +    possible and converted back to bytes as late as possible, following
     +    Python 2 to Python 3 conversion best practices.
      
     -    These two values should not be converted because the encoding of these values is unknown.  git-p4 supports a configuration value git-p4.pathEncoding that is used by the encodeWithUTF8()  to determine what a UTF8 version of the path and filename should be.  However, since depot path and depot filename need to be sent to P4 in their original encoding, they will be left as byte streams until they are actually used:
     +    Important: Do not cast the bytes that contain the p4 depot path or p4
     +    depot file name.  These should be left as bytes until used.
      
     -    * When sent to P4, the bytes are literally passed to the p4 command
     -    * When displayed in text for the user, they should be passed through the path_as_string() function
     -    * When used by GIT they should be passed through the encodeWithUTF8() function
     +    These two values should not be converted because the encoding of these
     +    values is unknown.  git-p4 supports a configuration value
     +    git-p4.pathEncoding that is used by the encodeWithUTF8() to determine
     +    what a UTF8 version of the path and filename should be. However, since
     +    depot path and depot filename need to be sent to P4 in their original
     +    encoding, they will be left as byte streams until they are actually
     +    used:
      
     -    Change all the rest of system calls to cast output (stdin) as_bytes() and input (stdout) as_string().  This retains existing Python 2 support, and adds python 3 support for these functions:
     -    * read_pipe_full
     -    * read_pipe_lines
     -    * p4_has_move_command (used internally)
     -    * gitConfig
     -    * branch_exists
     -    * GitLFS.generatePointer
     -    * applyCommit - template must be read and written to the temporary file as_bytes() since it is created in memory as a string.
     -    * streamOneP4File(file, contents) - wrap calls to the depotFile in path_as_string() for display. The file contents must be retained as bytes, so update the RCS changes to be forced to bytes.
     -    * streamP4Files
     -    * importHeadRevision(revision) - encode the depotPaths for display separate from the text for processing.
     +      * When sent to P4, the bytes are literally passed to the p4 command
     +      * When displayed in text for the user, they should be passed through
     +        the path_as_string() function
     +      * When used by GIT they should be passed through the encodeWithUTF8()
     +        function
     +
     +    Change all the rest of system calls to cast output from system calls
     +    (stdin) as_bytes() and input (stdout) as_string().  This retains
     +    existing Python 2 support, and adds python 3 support for these
     +    functions:
     +
     +     * read_pipe_full(c)
     +     * read_pipe_lines(c)
     +     * p4_has_move_command() - used internally
     +     * gitConfig(key, typeSpecifier=None)
     +     * branch_exists(branch)
     +     * GitLFS.generatePointer(cloneDestination, contentFile)
     +     * P4Submit.applyCommit(id) - template must be read and written to the
     +           temporary file as_bytes() since it is created in memory as a
     +           string.
     +     * P4Sync.streamOneP4File(file, contents) - wrap calls to the depotFile
     +           in path_as_string() for display. The file contents must be
     +           retained as bytes, so update the RCS changes to be forced to
     +           bytes.
     +     * P4Sync.streamP4Files(marshalled)
     +     * P4Sync.importHeadRevision(revision) - encode the depotPaths for
     +           display separate from the text for processing.
      
          Py23File usage -
     -    Change the P4Sync.OpenStreams() function to cast the gitOutput, gitStream, and gitError streams as Py23File() wrapper classes.  This facilitates taking strings in both python 2 and python 3 and casting them to bytes in the wrapper class instead of having to modify each method. Since the fast-import command also expects a raw byte stream for file content, add a new stream handle - gitStreamBytes which is an unwrapped verison of gitStream.
     +
     +    Change the P4Sync.OpenStreams() function to cast the gitOutput,
     +    gitStream, and gitError streams as Py23File() wrapper classes.
     +    This facilitates taking strings in both python 2 and python 3 and
     +    casting them to bytes in the wrapper class instead of having to modify
     +    each method. Since the fast-import command also expects a raw byte
     +    stream for file content, add a new stream handle - gitStreamBytes which
     +    is an unwrapped verison of gitStream.
      
          Literal text -
     -    Depending on context, most literal text does not need casting to unicode or bytes as the text is Python dependent - In python 2, the string is implied as 'str' and python 3 the string is implied as 'unicode'. Under these conditions, they match the rest of the operating text, following best practices.  However, when a literal string is used in functions that are dealing with the raw input from and raw ouput to files streams, literal bytes may be required. Additionally, functions that are dealing with P4 depot paths or P4 depot file names are also dealing with bytes and will require the same casting as bytes.  The following functions cast text as byte strings:
     -    * wildcard_decode(path) - the path parameter is a P4 depot and is bytes. Cast all the literals to bytes.
     -    * wildcard_encode(path) - the path parameter is a P4 depot and is bytes. Cast all the literals to bytes.
     -    * streamP4FilesCb(marshalled) - the marshalled data is in bytes. Cast the literals as bytes. When using this data to manipulate self.stream_file, encode all the marshalled data except for the 'depotFile' name.
     -    * streamP4Files
     +    Depending on context, most literal text does not need casting to unicode
     +    or bytes as the text is Python dependent - In Python 2, the string is
     +    implied as 'str' and python 3 the string is implied as 'unicode'. Under
     +    these conditions, they match the rest of the operating text, following
     +    best practices.  However, when a literal string is used in functions
     +    that are dealing with the raw input from and raw ouput to files streams,
     +    literal bytes may be required. Additionally, functions that are dealing
     +    with P4 depot paths or P4 depot file names are also dealing with bytes
     +    and will require the same casting as bytes.  The following functions
     +    cast text as byte strings:
     +
     +     * wildcard_decode(path) - the path parameter is a P4 depot and is
     +           bytes. Cast all the literals to bytes.
     +     * wildcard_encode(path) - the path parameter is a P4 depot and is
     +           bytes. Cast all the literals to bytes.
     +     * P4Sync.streamP4FilesCb(marshalled) - the marshalled data is in bytes.
     +           Cast the literals as bytes. When using this data to manipulate
     +           self.stream_file, encode all the marshalled data except for the
     +           'depotFile' name.
     +     * P4Sync.streamP4Files(marshalled)
      
          Special behavior:
     -    * p4_describe - encoding is disabled for the depotFile(x) and path elements since these are depot path and depo filenames.
     -    * p4PathStartsWith(path, prefix) - Since P4 depot paths can contain non-UTF-8 encoded strings, change this method to compare paths while supporting the optional encoding.
     -       - First, perform a byte-to-byte check to see if the path and prefix are both identical text.  There is no need to perform encoding conversions if the text is identical.
     -       - If the byte check fails, pass both the path and prefix through encodeWithUTF8() to ensure both paths are using the same encoding. Then perform the test as originally written.
     -    * patchRCSKeywords(file, pattern) - the parameters of file and pattern are both strings. However this function changes the contents of the file itentified by name "file". Treat the content of this file as binary to ensure that python does not accidently change the original encoding. The regular expression is cast as_bytes() and run against the file as_bytes(). The P4 keywords are ASCII strings and cannot span lines so iterating over each line of the file is acceptable.
     -    * writeToGitStream(gitMode, relPath, contents) - Since 'contents' is already bytes data, instead of using the self.gitStream, use the new self.gitStreamBytes - the unwrapped gitStream that does not cast as_bytes() the binary data.
     -    * commit(details, files, branch, parent = "", allow_empty=False) - Changed the encoding for the commit message to the preferred format for fast-import. The number of bytes is sent in the data block instead of using the EOT marker.
     -    * Change the code for handling the user cache to use binary files. Cast text as_bytes() when writing to the cache and as_string() when reading from the cache.  This makes the reading and writing of the cache determinstic in it's encoding. Unlike file paths, P4 encodes the user names in UTF-8 encoding so no additional string encoding is required.
     +
     +     * p4_describep4_describe(change, shelved=False) - encoding is disabled
     +           for the depotFile(x) and path elements since these are depot path
     +           and depo filenames.
     +     * p4PathStartsWith(path, prefix) - Since P4 depot paths can contain
     +           non-UTF-8 encoded strings, change this method to compare paths
     +           while supporting the optional encoding.
     +
     +            - First, perform a byte-to-byte check to see if the path and
     +                  prefix are both identical text.  There is no need to
     +                  perform encoding conversions if the text is identical.
     +            - If the byte check fails, pass both the path and prefix through
     +                  encodeWithUTF8() to ensure both paths are using the same
     +                  encoding. Then perform the test as originally written.
     +
     +     * P4Submit.patchRCSKeywords(file, pattern) - the parameters of file and
     +           pattern are both strings. However this function changes the
     +           contents of the file itentified by name "file". Treat the content
     +           of this file as binary to ensure that python does not accidently
     +           change the original encoding. The regular expression is cast
     +           as_bytes() and run against the file as_bytes(). The P4 keywords
     +           are ASCII strings and cannot span lines so iterating over each
     +           line of the file is acceptable.
     +     * P4Sync.writeToGitStream(gitMode, relPath, contents) - Since
     +           'contents' is already bytes data, instead of using the
     +           self.gitStream, use the new self.gitStreamBytes - the unwrapped
     +           gitStream that does not cast as_bytes() the binary data.
     +     * P4Sync.commit(details, files, branch, parent = "", allow_empty=False)
     +           Changed the encoding for the commit message to the preferred
     +           format for fast-import. The number of bytes is sent in the data
     +           block instead of using the EOT marker.
     +
     +     * Change the code for handling the user cache to use binary files.
     +           Cast text as_bytes() when writing to the cache and as_string()
     +           when reading from the cache.  This makes the reading and writing
     +           of the cache determinstic in it's encoding. Unlike file paths,
     +           P4 encodes the user names in UTF-8 encoding so no additional
     +           string encoding is required.
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit 65ff0c74ebe62a200b4385ecfd4aa618ce091f48)
      
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
     @@ -122,7 +198,7 @@
           cmd += [str(change)]
       
      -    ds = p4CmdList(cmd, skip_info=True)
     -+    ds = p4CmdList(cmd, skip_info=True, encode_data=False)
     ++    ds = p4CmdList(cmd, skip_info=True, encode_cmd_output=False)
           if len(ds) != 1:
               die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
       
     @@ -137,29 +213,20 @@
           if "time" not in d:
               die("p4 describe -s %d returned no \"time\": %s" % (change, str(d)))
       
     -+    # Do not convert 'depotFile(X)' or 'path' to be UTF-8 encoded, however 
     -+    # cast as_string() the rest of the text. 
     ++    # Do not convert 'depotFile(X)' or 'path' to be UTF-8 encoded, however
     ++    # cast as_string() the rest of the text.
      +    keys=d.keys()
      +    for key in keys:
      +        if key.startswith('depotFile'):
     -+            d[key]=d[key] 
     ++            d[key]=d[key]
      +        elif key == 'path':
     -+            d[key]=d[key] 
     ++            d[key]=d[key]
      +        else:
      +            d[key] = as_string(d[key])
      +
           return d
       
       #
     -@@
     -     return result
     - 
     - def p4Cmd(cmd):
     -+    """ Executes a P4 command and returns the results in a dictionary
     -+    """
     -     list = p4CmdList(cmd)
     -     result = {}
     -     for entry in list:
      @@
       _gitConfig = {}
       
     @@ -189,13 +256,13 @@
           #
           # we may or may not have a problem. If you have core.ignorecase=true,
           # we treat DirA and dira as the same directory
     -+    
     ++
      +    # Since we have to deal with mixed encodings for p4 file
      +    # paths, first perform a simple startswith check, this covers
      +    # the case that the formats and path are identical.
      +    if as_bytes(path).startswith(as_bytes(prefix)):
      +        return True
     -+    
     ++
      +    # attempt to convert the prefix and path both to utf8
      +    path_utf8 = encodeWithUTF8(path)
      +    prefix_utf8 = encodeWithUTF8(prefix)
     @@ -203,8 +270,8 @@
           if gitConfigBool("core.ignorecase"):
      -        return path.lower().startswith(prefix.lower())
      -    return path.startswith(prefix)
     -+        # Check if we match byte-per-byte.  
     -+        
     ++        # Check if we match byte-per-byte.
     ++
      +        return path_utf8.lower().startswith(prefix_utf8.lower())
      +    return path_utf8.startswith(prefix_utf8)
       
     @@ -272,7 +339,7 @@
               self.userMapFromPerforceServer = True
       
           def loadUserMapFromCache(self):
     -+        """ Reads the P4 username to git email map 
     ++        """ Reads the P4 username to git email map
      +        """
               self.users = {}
               self.userMapFromPerforceServer = False
     @@ -292,7 +359,7 @@
       
           def patchRCSKeywords(self, file, pattern):
      -        # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
     -+        """ Attempt to zap the RCS keywords in a p4 
     ++        """ Attempt to zap the RCS keywords in a p4
      +            controlled file matching the given pattern
      +        """
      +        bSubLine = as_bytes(r'$\1$')
     @@ -377,7 +444,7 @@
      +        """ output one file from the P4 stream to the git inbound stream.
      +            helper for streamP4files.
      +
     -+            contents should be a bytes (bytes) 
     ++            contents should be a bytes (bytes)
      +        """
               relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
               relPath = encodeWithUTF8(relPath, self.verbose)
     @@ -427,7 +494,7 @@
       
      -    # handle another chunk of streaming data
           def streamP4FilesCb(self, marshalled):
     -+        """ Callback function for recording P4 chunks of data for streaming 
     ++        """ Callback function for recording P4 chunks of data for streaming
      +            into GIT.
      +
      +            marshalled data is bytes[] from the caller
     @@ -493,7 +560,7 @@
       
      -    # Stream directly from "p4 files" into "git fast-import"
           def streamP4Files(self, files):
     -+        """ Stream directly from "p4 files" into "git fast-import" 
     ++        """ Stream directly from "p4 files" into "git fast-import"
      +        """
               filesForCommit = []
               filesToRead = []
     @@ -544,7 +611,7 @@
      +	    #('merge' SP <commit-ish> LF)*
      +	    #(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
      +	    #LF?
     -+        
     ++
      +        #'commit' - <ref> is the name of the branch to make the commit on
               self.gitStream.write("commit %s\n" % branch)
      +        #'mark' SP :<idnum>
     @@ -558,9 +625,9 @@
      -        self.gitStream.write("data <<EOT\n")
      -        self.gitStream.write(details["desc"])
      +        # Per https://git-scm.com/docs/git-fast-import
     -+        # The preferred method for creating the commit message is to supply the 
     -+        # byte count in the data method and not to use a Delimited format. 
     -+        # Collect all the text in the commit message into a single string and 
     ++        # The preferred method for creating the commit message is to supply the
     ++        # byte count in the data method and not to use a Delimited format.
     ++        # Collect all the text in the commit message into a single string and
      +        # compute the byte count.
      +        commitText = details["desc"]
               if len(jobs) > 0:
     @@ -584,7 +651,7 @@
      +            if len(details['options']) > 0:
      +                commitText += (": options = %s" % details['options'])
      +            commitText += "]"
     -+        commitText += "\n" 
     ++        commitText += "\n"
      +        self.gitStream.write("data %s\n" % len(as_bytes(commitText)))
      +        self.gitStream.write(commitText)
      +        self.gitStream.write("\n")
     @@ -617,7 +684,7 @@
               fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
       
      -        for info in p4CmdList(["files"] + fileArgs):
     -+        for info in p4CmdList(["files"] + fileArgs, encode_data = False):
     ++        for info in p4CmdList(["files"] + fileArgs, encode_cmd_output=False):
       
      -            if 'code' in info and info['code'] == 'error':
      +            if 'code' in info and info['code'] == b'error':
     @@ -640,7 +707,7 @@
                       #fileCnt = fileCnt + 1
                       continue
       
     -+            # Save all the file information, howerver do not translate the depotFile name at 
     ++            # Save all the file information, howerver do not translate the depotFile name at
      +            # this time. Leave that as bytes since the encoding may vary.
                   for prop in ["depotFile", "rev", "action", "type" ]:
      -                details["%s%s" % (prop, fileCnt)] = info[prop]
 11:  883ef45ca5 ! 14:  25ad3e23a3 git-p4: Added --encoding parameter to p4 clone
     @@ -1,19 +1,24 @@
      Author: Ben Keene <seraphire@gmail.com>
      
     -    git-p4: Added --encoding parameter to p4 clone
     +    git-p4: added --encoding parameter to p4 clone
      
     -    The test t9822 did not have any tests that had encoded a directory name in ISO8859-1.
     +    The test t9822 did not have any tests that had encoded a directory name
     +    in ISO8859-1.
      
     -    Additionally, to make it easier for the user to clone new repositories with a non-UTF-8 encoded path in P4, add a new parameter to p4clone "--encoding" that sets the
     +    Additionally, to make it easier for the user to clone new repositories
     +    with a non-UTF-8 encoded path in P4, add a new parameter to p4clone
     +    "--encoding" that sets the
      
     -    Add new tests that use ISO8859-1 encoded text in both the directory and file names.  git-p4.pathEncoding.
     +    Add new tests that use ISO8859-1 encoded text in both the directory and
     +    file names.  git-p4.pathEncoding.
      
     -    Update the View class in the git-p4 code to properly cast text as_string() except for depot path and filenames.
     +    Update the View class in the git-p4 code to properly cast text
     +    as_string() except for depot path and filenames.
      
     -    Update the documentation to include the new command line parameter for p4clone
     +    Update the documentation to include the new command line parameter for
     +    p4clone
      
          Signed-off-by: Ben Keene <seraphire@gmail.com>
     -    (cherry picked from commit e26f6309d60c6c1615320d4a9071935e23efe6fb)
      
       diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
       --- a/Documentation/git-p4.txt
     @@ -23,8 +28,8 @@
       	Perform a bare clone.  See linkgit:git-clone[1].
       
      +--encoding <encoding>::
     -+    Optionally sets the git-p4.pathEncoding configuration value in 
     -+	the newly created Git repository before files are synchronized 
     ++    Optionally sets the git-p4.pathEncoding configuration value in
     ++	the newly created Git repository before files are synchronized
      +	from P4. See git-p4.pathEncoding for more information.
      +
       Submit options
     @@ -34,15 +39,6 @@
       diff --git a/git-p4.py b/git-p4.py
       --- a/git-p4.py
       +++ b/git-p4.py
     -@@
     -     """Look at the p4 client spec, create a View() object that contains
     -        all the mappings, and return it."""
     - 
     --    specList = p4CmdList("client -o")
     -+    specList = p4CmdList("client -o", encode_data=False)
     -     if len(specList) != 1:
     -         die('Output from "client -o" is %d lines, expecting 1' %
     -             len(specList))
      @@
           entry = specList[0]
       
     @@ -130,11 +126,8 @@
       
           def update_client_spec_path_cache(self, files):
      @@
     -         if len(fileArgs) == 0:
     -             return  # All files in cache
       
     --        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
     -+        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_data=False)
     +         where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_cmd_output=False)
               for res in where_result:
      -            if "code" in res and res["code"] == "error":
      +            if "code" in res and res["code"] == b"error":
     @@ -155,7 +148,7 @@
      +        self.setPathEncoding = None
       
           def defaultDestination(self, args):
     -         """ Returns the last path component as the default git 
     +         """ Returns the last path component as the default git
      @@
       
               depotPaths = args
     @@ -246,7 +239,7 @@
      +		DIR_ISO8859="$(printf "$DIR_ISO8859_ESCAPED")" &&
      +		ISO8859="$(printf "$ISO8859_ESCAPED")" &&
      +		cd "$cli" &&
     -+		mkdir "$DIR_ISO8859" && 
     ++		mkdir "$DIR_ISO8859" &&
      +		cd "$DIR_ISO8859" &&
      +		echo content123 >"$ISO8859" &&
      +		p4 add "$ISO8859" &&
  -:  ---------- > 15:  445dbc59f0 git-p4: Add depot manipulation functions

-- 
gitgitgadget
