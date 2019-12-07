Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63CC2D0C4
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652D124677
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDvF9Oya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLGRsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:48:05 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40167 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfLGRsA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:48:00 -0500
Received: by mail-wr1-f54.google.com with SMTP id c14so11305376wrn.7
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68Orkq5COgZJ1yjNGDITAA4+beKp29jHJfxjj5LbVlg=;
        b=SDvF9Oya7S9JVb2x3WhISMA+cJpS6aX0l+5uDlkP5FTlqgadaSm73ftYV6K9b0TKMl
         pLMFUuQT1oNY5aeoDab789SMLIzZLr/tWTL7s+8E3JKm79Iz+5o+oiKmlnfb1Ztu2c73
         oM1La16Rr30HI/9PKXIyy9VEylsN7C/RNrrDTgYWrWXfPYd0paQGP8I27tBLKKhNqMSN
         cG+Ayn0GCuNKUjnsaKKpyKjf3GA/sTmC3byHDHtBUjxDzEjgqr6STCLTAAT9l9Z651tU
         yXUnF0qmy0huJ/3WDBYe9wkvYux/6oGMeEJnwhud0Ny4H6WeJOn40T9eDvIptfkAE/ga
         NcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68Orkq5COgZJ1yjNGDITAA4+beKp29jHJfxjj5LbVlg=;
        b=Ob0ILzk9EaWeNInvR4RX0/rLRJN42f1fbhvcOowVq6iHQarBinI8DJ7X9hG1x66Yn1
         kGXf4Ts+W10neenAShoNM3GwhxYwBsJIgfoNUM88CUs/8IEtHEmXEW0WfwK4V/NKkl3j
         uLNopd3uWZ9tqCfRvDHxL364VTtDtIVvJ6+FODgyN/CeKHd2RBLG0teGOurIidvS8LMr
         v4qU7Yo3AVUsOupX5Rpdl2r8B8qUnv2t73zvocmd3GcNZxwh7aYb4aehOryEXvG1z//t
         9LJeKiCjhBgFBRNspIdmUdFywATw4KNfv0wPLgjzHYfWvnC79CKmI7HvKtyAliJHVEwf
         o/yQ==
X-Gm-Message-State: APjAAAW/OFzqN/PcHUhTjtuj8ji9Ht+FJcqDWBMCIF/UQwEpzJ+OQzHE
        aHSvpWv6E1SHDRMoJFLHLA7MJ8Yf
X-Google-Smtp-Source: APXvYqzD6Dt+xi6mUbTDOREq6inXhtL1ZvwjzfnQVceObHxow907J6ynfe9lBh+qe4lySPJRUZ9wsA==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr21095561wrr.158.1575740874774;
        Sat, 07 Dec 2019 09:47:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm18684019wrx.59.2019.12.07.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:54 -0800 (PST)
Message-Id: <e7bb92bcd635813dda187017378a81fd90eceede.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:41 +0000
Subject: [PATCH v5 13/15] git-p4: support Python 3 for basic P4 clone, sync,
 and submit (t9800)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

NOTE: Python 3 is still not properly supported for any use with the
git-p4 python code.

Warning - this is a very large atomic commit.  The commit text is also
very large.

Change the code such that, with the exception of P4 depot paths and
depot files, all text read by git-p4 is cast as a string as soon as
possible and converted back to bytes as late as possible, following
Python 2 to Python 3 conversion best practices.

Important: Do not cast the bytes that contain the p4 depot path or p4
depot file name.  These should be left as bytes until used.

These two values should not be converted because the encoding of these
values is unknown.  git-p4 supports a configuration value
git-p4.pathEncoding that is used by the encodeWithUTF8() to determine
what a UTF8 version of the path and filename should be. However, since
depot path and depot filename need to be sent to P4 in their original
encoding, they will be left as byte streams until they are actually
used:

  * When sent to P4, the bytes are literally passed to the p4 command
  * When displayed in text for the user, they should be passed through
    the path_as_string() function
  * When used by GIT they should be passed through the encodeWithUTF8()
    function

Change all the rest of system calls to cast output from system calls
(stdin) as_bytes() and input (stdout) as_string().  This retains
existing Python 2 support, and adds python 3 support for these
functions:

 * read_pipe_full(c)
 * read_pipe_lines(c)
 * p4_has_move_command() - used internally
 * gitConfig(key, typeSpecifier=None)
 * branch_exists(branch)
 * GitLFS.generatePointer(cloneDestination, contentFile)
 * P4Submit.applyCommit(id) - template must be read and written to the
       temporary file as_bytes() since it is created in memory as a
       string.
 * P4Sync.streamOneP4File(file, contents) - wrap calls to the depotFile
       in path_as_string() for display. The file contents must be
       retained as bytes, so update the RCS changes to be forced to
       bytes.
 * P4Sync.streamP4Files(marshalled)
 * P4Sync.importHeadRevision(revision) - encode the depotPaths for
       display separate from the text for processing.

Py23File usage -

Change the P4Sync.OpenStreams() function to cast the gitOutput,
gitStream, and gitError streams as Py23File() wrapper classes.
This facilitates taking strings in both python 2 and python 3 and
casting them to bytes in the wrapper class instead of having to modify
each method. Since the fast-import command also expects a raw byte
stream for file content, add a new stream handle - gitStreamBytes which
is an unwrapped verison of gitStream.

Literal text -
Depending on context, most literal text does not need casting to unicode
or bytes as the text is Python dependent - In Python 2, the string is
implied as 'str' and python 3 the string is implied as 'unicode'. Under
these conditions, they match the rest of the operating text, following
best practices.  However, when a literal string is used in functions
that are dealing with the raw input from and raw ouput to files streams,
literal bytes may be required. Additionally, functions that are dealing
with P4 depot paths or P4 depot file names are also dealing with bytes
and will require the same casting as bytes.  The following functions
cast text as byte strings:

 * wildcard_decode(path) - the path parameter is a P4 depot and is
       bytes. Cast all the literals to bytes.
 * wildcard_encode(path) - the path parameter is a P4 depot and is
       bytes. Cast all the literals to bytes.
 * P4Sync.streamP4FilesCb(marshalled) - the marshalled data is in bytes.
       Cast the literals as bytes. When using this data to manipulate
       self.stream_file, encode all the marshalled data except for the
       'depotFile' name.
 * P4Sync.streamP4Files(marshalled)

Special behavior:

 * p4_describep4_describe(change, shelved=False) - encoding is disabled
       for the depotFile(x) and path elements since these are depot path
       and depo filenames.
 * p4PathStartsWith(path, prefix) - Since P4 depot paths can contain
       non-UTF-8 encoded strings, change this method to compare paths
       while supporting the optional encoding.

        - First, perform a byte-to-byte check to see if the path and
              prefix are both identical text.  There is no need to
              perform encoding conversions if the text is identical.
        - If the byte check fails, pass both the path and prefix through
              encodeWithUTF8() to ensure both paths are using the same
              encoding. Then perform the test as originally written.

 * P4Submit.patchRCSKeywords(file, pattern) - the parameters of file and
       pattern are both strings. However this function changes the
       contents of the file itentified by name "file". Treat the content
       of this file as binary to ensure that python does not accidently
       change the original encoding. The regular expression is cast
       as_bytes() and run against the file as_bytes(). The P4 keywords
       are ASCII strings and cannot span lines so iterating over each
       line of the file is acceptable.
 * P4Sync.writeToGitStream(gitMode, relPath, contents) - Since
       'contents' is already bytes data, instead of using the
       self.gitStream, use the new self.gitStreamBytes - the unwrapped
       gitStream that does not cast as_bytes() the binary data.
 * P4Sync.commit(details, files, branch, parent = "", allow_empty=False)
       Changed the encoding for the commit message to the preferred
       format for fast-import. The number of bytes is sent in the data
       block instead of using the EOT marker.

 * Change the code for handling the user cache to use binary files.
       Cast text as_bytes() when writing to the cache and as_string()
       when reading from the cache.  This makes the reading and writing
       of the cache determinstic in it's encoding. Unlike file paths,
       P4 encodes the user names in UTF-8 encoding so no additional
       string encoding is required.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 285 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 203 insertions(+), 82 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e8f31339e4..9cf4e94e28 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -273,6 +273,8 @@ def read_pipe_full(c):
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
+    out = as_string(out)
+    err = as_string(err)
     return (p.returncode, out, err)
 
 def read_pipe(c, ignore_error=False):
@@ -299,10 +301,17 @@ def read_pipe_text(c):
         return out.rstrip()
 
 def p4_read_pipe(c, ignore_error=False):
+    """ Read output from the P4 command 'c'. Returns the output text on
+        success. On failure, terminates execution, unless
+        ignore_error is True, when it returns an empty string.
+    """
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error)
 
 def read_pipe_lines(c):
+    """ Returns a list of text from executing the command 'c'.
+        The program will die if the command fails to execute.
+    """
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
@@ -312,6 +321,11 @@ def read_pipe_lines(c):
     val = pipe.readlines()
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
+    # Unicode conversion from byte-string
+    # Iterate and fix in-place to avoid a second list in memory.
+    if isunicode:
+        for i in range(len(val)):
+            val[i] = as_string(val[i])
 
     return val
 
@@ -340,6 +354,8 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    out=as_string(out)
+    err=as_string(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -467,16 +483,20 @@ def p4_last_change():
     return int(results[0]['change'])
 
 def p4_describe(change, shelved=False):
-    """Make sure it returns a valid result by checking for
-       the presence of field "time".  Return a dict of the
-       results."""
+    """ Returns information about the requested P4 change list.
+
+        Data returned is not string encoded (returned as bytes)
+    """
+    # Make sure it returns a valid result by checking for
+    #   the presence of field "time".  Return a dict of the
+    #   results.
 
     cmd = ["describe", "-s"]
     if shelved:
         cmd += ["-S"]
     cmd += [str(change)]
 
-    ds = p4CmdList(cmd, skip_info=True)
+    ds = p4CmdList(cmd, skip_info=True, encode_cmd_output=False)
     if len(ds) != 1:
         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
 
@@ -486,12 +506,23 @@ def p4_describe(change, shelved=False):
         die("p4 describe -s %d exited with %d: %s" % (change, d["p4ExitCode"],
                                                       str(d)))
     if "code" in d:
-        if d["code"] == "error":
+        if d["code"] == b"error":
             die("p4 describe -s %d returned error code: %s" % (change, str(d)))
 
     if "time" not in d:
         die("p4 describe -s %d returned no \"time\": %s" % (change, str(d)))
 
+    # Do not convert 'depotFile(X)' or 'path' to be UTF-8 encoded, however
+    # cast as_string() the rest of the text.
+    keys=d.keys()
+    for key in keys:
+        if key.startswith('depotFile'):
+            d[key]=d[key]
+        elif key == 'path':
+            d[key]=d[key]
+        else:
+            d[key] = as_string(d[key])
+
     return d
 
 #
@@ -914,13 +945,15 @@ def gitDeleteRef(ref):
 _gitConfig = {}
 
 def gitConfig(key, typeSpecifier=None):
+    """ Return a configuration setting from GIT
+	"""
     if key not in _gitConfig:
         cmd = [ "git", "config" ]
         if typeSpecifier:
             cmd += [ typeSpecifier ]
         cmd += [ key ]
         s = read_pipe(cmd, ignore_error=True)
-        _gitConfig[key] = s.strip()
+        _gitConfig[key] = as_string(s).strip()
     return _gitConfig[key]
 
 def gitConfigBool(key):
@@ -994,6 +1027,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = as_string(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -1177,9 +1211,22 @@ def p4PathStartsWith(path, prefix):
     #
     # we may or may not have a problem. If you have core.ignorecase=true,
     # we treat DirA and dira as the same directory
+
+    # Since we have to deal with mixed encodings for p4 file
+    # paths, first perform a simple startswith check, this covers
+    # the case that the formats and path are identical.
+    if as_bytes(path).startswith(as_bytes(prefix)):
+        return True
+
+    # attempt to convert the prefix and path both to utf8
+    path_utf8 = encodeWithUTF8(path)
+    prefix_utf8 = encodeWithUTF8(prefix)
+
     if gitConfigBool("core.ignorecase"):
-        return path.lower().startswith(prefix.lower())
-    return path.startswith(prefix)
+        # Check if we match byte-per-byte.
+
+        return path_utf8.lower().startswith(prefix_utf8.lower())
+    return path_utf8.startswith(prefix_utf8)
 
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
@@ -1235,18 +1282,24 @@ def wildcard_decode(path):
     # Cannot have * in a filename in windows; untested as to
     # what p4 would do in such a case.
     if not platform.system() == "Windows":
-        path = path.replace("%2A", "*")
-    path = path.replace("%23", "#") \
-               .replace("%40", "@") \
-               .replace("%25", "%")
+        path = path.replace(b"%2A", b"*")
+    path = path.replace(b"%23", b"#") \
+               .replace(b"%40", b"@") \
+               .replace(b"%25", b"%")
     return path
 
 def wildcard_encode(path):
     # do % first to avoid double-encoding the %s introduced here
-    path = path.replace("%", "%25") \
-               .replace("*", "%2A") \
-               .replace("#", "%23") \
-               .replace("@", "%40")
+    if isinstance(path, unicode):
+        path = path.replace("%", "%25") \
+                   .replace("*", "%2A") \
+                   .replace("#", "%23") \
+                   .replace("@", "%40")
+    else:
+        path = path.replace(b"%", b"%25") \
+                   .replace(b"*", b"%2A") \
+                   .replace(b"#", b"%23") \
+                   .replace(b"@", b"%40")
     return path
 
 def wildcard_present(path):
@@ -1378,7 +1431,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = pointerProcess.stdout.read()
+        pointerFile = as_string(pointerProcess.stdout.read())
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
@@ -1485,6 +1538,8 @@ def getUserCacheFilename(self):
         return os.path.join(home, ".gitp4-usercache.txt")
 
     def getUserMapFromPerforceServer(self):
+        """ Creates the usercache from the data in P4.
+        """
         if self.userMapFromPerforceServer:
             return
         self.users = {}
@@ -1510,18 +1565,22 @@ def getUserMapFromPerforceServer(self):
         for (key, val) in list(self.users.items()):
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), "wb").write(s)
+        cache = io.open(self.getUserCacheFilename(), "wb")
+        cache.write(as_bytes(s))
+        cache.close()
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
+        """ Reads the P4 username to git email map
+        """
         self.users = {}
         self.userMapFromPerforceServer = False
         try:
-            cache = open(self.getUserCacheFilename(), "rb")
+            cache = io.open(self.getUserCacheFilename(), "rb")
             lines = cache.readlines()
             cache.close()
             for line in lines:
-                entry = line.strip().split("\t")
+                entry = as_string(line).strip().split("\t")
                 self.users[entry[0]] = entry[1]
         except IOError:
             self.getUserMapFromPerforceServer()
@@ -1721,21 +1780,27 @@ def prepareLogMessage(self, template, message, jobs):
         return result
 
     def patchRCSKeywords(self, file, pattern):
-        # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
+        """ Attempt to zap the RCS keywords in a p4
+            controlled file matching the given pattern
+        """
+        bSubLine = as_bytes(r'$\1$')
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
-            outFile = os.fdopen(handle, "w+")
-            inFile = open(file, "r")
-            regexp = re.compile(pattern, re.VERBOSE)
+            outFile = os.fdopen(handle, "w+b")
+            inFile = open(file, "rb")
+            regexp = re.compile(as_bytes(pattern), re.VERBOSE)
             for line in inFile.readlines():
-                line = regexp.sub(r'$\1$', line)
+                line = regexp.sub(bSubLine, line)
                 outFile.write(line)
             inFile.close()
             outFile.close()
+            outFile = None
             # Forcibly overwrite the original file
             os.unlink(file)
             shutil.move(outFileName, file)
         except:
+            if outFile != None:
+                outFile.close()
             # cleanup our temporary file
             os.unlink(outFileName)
             print("Failed to strip RCS keywords in %s" % file)
@@ -2139,7 +2204,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate)
+        tmpFile.write(as_bytes(submitTemplate))
         tmpFile.close()
 
         if self.prepare_p4_only:
@@ -2189,8 +2254,8 @@ def applyCommit(self, id):
                 message = tmpFile.read()
                 tmpFile.close()
                 if self.isWindows:
-                    message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                    message = message.replace(b"\r\n", b"\n")
+                submitTemplate = message[:message.index(as_bytes(separatorLine))]
 
                 if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
@@ -2833,8 +2898,11 @@ def stripRepoPath(self, path, prefixes):
         return path
 
     def splitFilesIntoBranches(self, commit):
-        """Look at each depotFile in the commit to figure out to what
-           branch it belongs."""
+        """ Look at each depotFile in the commit to figure out to what
+            branch it belongs.
+
+            Data in the commit will NOT be encoded
+        """
 
         if self.clientSpecDirs:
             files = self.extractFilesFromCommit(commit)
@@ -2875,16 +2943,22 @@ def splitFilesIntoBranches(self, commit):
         return branches
 
     def writeToGitStream(self, gitMode, relPath, contents):
-        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        """ Writes the bytes[] 'contents' to the git fast-import
+            with the given 'gitMode' and 'relPath' as the relative
+            path.
+        """
+        self.gitStream.write('M %s inline %s\n' % (gitMode, as_string(relPath)))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
         for d in contents:
-            self.gitStream.write(d)
+            self.gitStreamBytes.write(d)
         self.gitStream.write('\n')
 
-    # output one file from the P4 stream
-    # - helper for streamP4Files
-
     def streamOneP4File(self, file, contents):
+        """ output one file from the P4 stream to the git inbound stream.
+            helper for streamP4files.
+
+            contents should be a bytes (bytes)
+        """
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
@@ -2892,7 +2966,7 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size//1024//1024))
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_as_string(file['depotFile']), as_string(relPath), size//1024//1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -2910,7 +2984,7 @@ def streamOneP4File(self, file, contents):
                 # to nothing.  This causes p4 errors when checking out such
                 # a change, and errors here too.  Work around it by ignoring
                 # the bad symlink; hopefully a future change fixes it.
-                print("\nIgnoring empty symlink in %s" % file['depotFile'])
+                print("\nIgnoring empty symlink in %s" % path_as_string(file['depotFile']))
                 return
             elif data[-1] == '\n':
                 contents = [data[:-1]]
@@ -2950,16 +3024,16 @@ def streamOneP4File(self, file, contents):
             # Ideally, someday, this script can learn how to generate
             # appledouble files directly and import those to git, but
             # non-mac machines can never find a use for apple filetype.
-            print("\nIgnoring apple filetype file %s" % file['depotFile'])
+            print("\nIgnoring apple filetype file %s" % path_as_string(file['depotFile']))
             return
 
         # Note that we do not try to de-mangle keywords on utf16 files,
         # even though in theory somebody may want that.
-        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
+        pattern = as_bytes(p4_keywords_regexp_for_type(type_base, type_mods))
         if pattern:
             regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(contents)
-            text = regexp.sub(r'$\1$', text)
+            text = b''.join(contents)
+            text = regexp.sub(as_bytes(r'$\1$'), text)
             contents = [ text ]
 
         if self.largeFileSystem:
@@ -2978,15 +3052,19 @@ def streamOneP4Deletion(self, file):
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
 
-    # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
+        """ Callback function for recording P4 chunks of data for streaming
+            into GIT.
+
+            marshalled data is bytes[] from the caller
+        """
 
         # catch p4 errors and complain
         err = None
-        if "code" in marshalled:
-            if marshalled["code"] == "error":
-                if "data" in marshalled:
-                    err = marshalled["data"].rstrip()
+        if b"code" in marshalled:
+            if marshalled[b"code"] == b"error":
+                if b"data" in marshalled:
+                    err = marshalled[b"data"].rstrip()
 
         if not err and 'fileSize' in self.stream_file:
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
@@ -3008,11 +3086,11 @@ def streamP4FilesCb(self, marshalled):
             # ignore errors, but make sure it exits first
             self.importProcess.wait()
             if f:
-                die("Error from p4 print for %s: %s" % (f, err))
+                die("Error from p4 print for %s: %s" % (path_as_string(f), err))
             else:
                 die("Error from p4 print: %s" % err)
 
-        if 'depotFile' in marshalled and self.stream_have_file_info:
+        if b'depotFile' in marshalled and self.stream_have_file_info:
             # start of a new file - output the old one first
             self.streamOneP4File(self.stream_file, self.stream_contents)
             self.stream_file = {}
@@ -3022,13 +3100,16 @@ def streamP4FilesCb(self, marshalled):
         # pick up the new file information... for the
         # 'data' field we need to append to our array
         for k in list(marshalled.keys()):
-            if k == 'data':
+            if k == b'data':
                 if 'streamContentSize' not in self.stream_file:
                     self.stream_file['streamContentSize'] = 0
-                self.stream_file['streamContentSize'] += len(marshalled['data'])
-                self.stream_contents.append(marshalled['data'])
+                self.stream_file['streamContentSize'] += len(marshalled[b'data'])
+                self.stream_contents.append(marshalled[b'data'])
             else:
-                self.stream_file[k] = marshalled[k]
+                if k == b'depotFile':
+                    self.stream_file[as_string(k)] = marshalled[k]
+                else:
+                    self.stream_file[as_string(k)] = as_string(marshalled[k])
 
         if (verbose and
             'streamContentSize' in self.stream_file and
@@ -3037,13 +3118,14 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100.0*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size//1024//1024)))
+                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (path_as_string(self.stream_file['depotFile']), progress, int(size//1024//1024)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
 
-    # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
+        """ Stream directly from "p4 files" into "git fast-import"
+        """
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -3064,7 +3146,7 @@ def streamP4Files(self, files):
             self.stream_contents = []
             self.stream_have_file_info = False
 
-            # curry self argument
+            # Callback for P4 command to collect file content
             def streamP4FilesCbSelf(entry):
                 self.streamP4FilesCb(entry)
 
@@ -3073,9 +3155,9 @@ def streamP4FilesCbSelf(entry):
                 if 'shelved_cl' in f:
                     # Handle shelved CLs using the "p4 print file@=N" syntax to print
                     # the contents
-                    fileArg = '%s@=%d' % (f['path'], f['shelved_cl'])
+                    fileArg = b'%s@=%d' % (f['path'], as_bytes(f['shelved_cl']))
                 else:
-                    fileArg = '%s#%s' % (f['path'], f['rev'])
+                    fileArg = b'%s#%s' % (f['path'], as_bytes(f['rev']))
 
                 fileArgs.append(fileArg)
 
@@ -3095,7 +3177,7 @@ def make_email(self, userid):
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         """ Stream a p4 tag.
-        commit is either a git commit, or a fast-import mark, ":<p4commit>"
+            commit is either a git commit, or a fast-import mark, ":<p4commit>"
         """
 
         if verbose:
@@ -3167,7 +3249,22 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
                 .format(details['change']))
             return
 
+        # fast-import:
+        #'commit' SP <ref> LF
+	    #mark?
+	    #original-oid?
+	    #('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
+	    #'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	    #('encoding' SP <encoding>)?
+	    #data
+	    #('from' SP <commit-ish> LF)?
+	    #('merge' SP <commit-ish> LF)*
+	    #(filemodify | filedelete | filecopy | filerename | filedeleteall | notemodify)*
+	    #LF?
+
+        #'commit' - <ref> is the name of the branch to make the commit on
         self.gitStream.write("commit %s\n" % branch)
+        #'mark' SP :<idnum>
         self.gitStream.write("mark :%s\n" % details["change"])
         self.committedChanges.add(int(details["change"]))
         committer = ""
@@ -3177,19 +3274,29 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
 
         self.gitStream.write("committer %s\n" % committer)
 
-        self.gitStream.write("data <<EOT\n")
-        self.gitStream.write(details["desc"])
+        # Per https://git-scm.com/docs/git-fast-import
+        # The preferred method for creating the commit message is to supply the
+        # byte count in the data method and not to use a Delimited format.
+        # Collect all the text in the commit message into a single string and
+        # compute the byte count.
+        commitText = details["desc"]
         if len(jobs) > 0:
-            self.gitStream.write("\nJobs: %s" % (' '.join(jobs)))
-
+            commitText += "\nJobs: %s" % (' '.join(jobs))
         if not self.suppress_meta_comment:
-            self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
-                                (','.join(self.branchPrefixes), details["change"]))
-            if len(details['options']) > 0:
-                self.gitStream.write(": options = %s" % details['options'])
-            self.gitStream.write("]\n")
+            # coherce the path to the correct formatting in the branch prefixes as well.
+            dispPaths = []
+            for p in self.branchPrefixes:
+                dispPaths += [path_as_string(p)]
 
-        self.gitStream.write("EOT\n\n")
+            commitText += ("\n[git-p4: depot-paths = \"%s\": change = %s" %
+                                (','.join(dispPaths), details["change"]))
+            if len(details['options']) > 0:
+                commitText += (": options = %s" % details['options'])
+            commitText += "]"
+        commitText += "\n"
+        self.gitStream.write("data %s\n" % len(as_bytes(commitText)))
+        self.gitStream.write(commitText)
+        self.gitStream.write("\n")
 
         if len(parent) > 0:
             if self.verbose:
@@ -3596,30 +3703,35 @@ def sync_origin_only(self):
                 system("git fetch origin")
 
     def importHeadRevision(self, revision):
-        print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
-
+        # Re-encode depot text
+        dispPaths = []
+        utf8Paths = []
+        for p in self.depotPaths:
+            dispPaths += [path_as_string(p)]
+        print("Doing initial import of %s from revision %s into %s" % (' '.join(dispPaths), revision, self.branch))
         details = {}
         details["user"] = "git perforce import user"
-        details["desc"] = ("Initial import of %s from the state at revision %s\n"
-                           % (' '.join(self.depotPaths), revision))
+        details["desc"] = ("Initial import of %s from the state at revision %s\n" %
+                           (' '.join(dispPaths), revision))
         details["change"] = revision
         newestRevision = 0
+        del dispPaths
 
         fileCnt = 0
         fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
 
-        for info in p4CmdList(["files"] + fileArgs):
+        for info in p4CmdList(["files"] + fileArgs, encode_cmd_output=False):
 
-            if 'code' in info and info['code'] == 'error':
+            if 'code' in info and info['code'] == b'error':
                 sys.stderr.write("p4 returned an error: %s\n"
-                                 % info['data'])
-                if info['data'].find("must refer to client") >= 0:
+                                 % as_string(info['data']))
+                if info['data'].find(b"must refer to client") >= 0:
                     sys.stderr.write("This particular p4 error is misleading.\n")
                     sys.stderr.write("Perhaps the depot path was misspelled.\n");
                     sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
-                sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
+                sys.stderr.write("p4 exitcode: %s\n" % as_string(info['p4ExitCode']))
                 sys.exit(1)
 
 
@@ -3632,8 +3744,10 @@ def importHeadRevision(self, revision):
                 #fileCnt = fileCnt + 1
                 continue
 
+            # Save all the file information, howerver do not translate the depotFile name at
+            # this time. Leave that as bytes since the encoding may vary.
             for prop in ["depotFile", "rev", "action", "type" ]:
-                details["%s%s" % (prop, fileCnt)] = info[prop]
+                details["%s%s" % (prop, fileCnt)] = (info[prop] if prop == "depotFile" else as_string(info[prop]))
 
             fileCnt = fileCnt + 1
 
@@ -3653,13 +3767,18 @@ def importHeadRevision(self, revision):
             print(self.gitError.read())
 
     def openStreams(self):
+        """ Opens the fast import pipes.  Note that the git* streams are wrapped
+            to expect Unicode text.  To send a raw byte Array, use the importProcess
+            underlying port
+        """
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
                                               stderr=subprocess.PIPE);
-        self.gitOutput = self.importProcess.stdout
-        self.gitStream = self.importProcess.stdin
-        self.gitError = self.importProcess.stderr
+        self.gitOutput = Py23File(self.importProcess.stdout, verbose = self.verbose)
+        self.gitStream = Py23File(self.importProcess.stdin, verbose = self.verbose)
+        self.gitError = Py23File(self.importProcess.stderr, verbose = self.verbose)
+        self.gitStreamBytes = self.importProcess.stdin
 
     def closeStreams(self):
         self.gitStream.close()
@@ -4025,15 +4144,17 @@ def run(self, args):
             self.cloneDestination = depotPaths[-1]
             depotPaths = depotPaths[:-1]
 
+        dispPaths = []
         for p in depotPaths:
             if not p.startswith("//"):
                 sys.stderr.write('Depot paths must start with "//": %s\n' % p)
                 return False
+            dispPaths += [path_as_string(p)]
 
         if not self.cloneDestination:
             self.cloneDestination = self.defaultDestination(args)
 
-        print("Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination))
+        print("Importing from %s into %s" % (', '.join(dispPaths), path_as_string(self.cloneDestination)))
 
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
-- 
gitgitgadget

