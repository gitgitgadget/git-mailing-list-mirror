Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD383C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0CE2464E
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oavm0psd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLBTC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:02:29 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:38027 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfLBTC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:02:29 -0500
Received: by mail-wm1-f42.google.com with SMTP id p17so630905wmi.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZePt0PiuK0knuULLd7kGIgPsvkkbb8BeHsR5CHM1+7g=;
        b=oavm0psde9W5Vv8RxNwo+n+VbIt75mHCckHQk5k0h1gWGB48UNYAfyAsjzgU48spyA
         G5ATIPJNQpzTAUgBKeeFfrAGf3ye3x94ZW1L9SNJbC1SGxTYFIHym6FqFwaSrgQURYJ9
         5qunuXTMrpWyVot/hosTHeYtvifUbsOejaZYSnuGTBygnnNEaqmjvNmoU9DpjYzHRJyp
         i0CZ4O+7hfP5NgVtNwII3Axau132WdP18ZAA6wnKdORV6GfgX/Wwc8q4ANUUxKm4b2NN
         7xbD7BZLGCgTkHswo9cbGOcXd6UAtwXCJSzA1SkJV9FRhunjMUeZPfRNHwIIfbRLW0t4
         hhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZePt0PiuK0knuULLd7kGIgPsvkkbb8BeHsR5CHM1+7g=;
        b=KlIICxd7j0+isLkadCgxr3kBs7wQQrAk4y/evT2dRcdyyZ6qDw3cxeAyRTMuAaO73w
         dV41z1oH0v2z3evJtyllgam91XK2N1+OCNja/v7yQgKvMHxYqe8eSMVlfjFy9sxczFou
         LZMdxmd9YHDTdufSldUvUj7iS0Pno09Fe6zjC+fOM0TpWBvbqmMGQ/sSnImH4eXV58h0
         xKJEJKxSo48pcW3OWM3um7JhZvQMuBwoor93noDrUB5APf5CXaahQHr0HlfdOyWnVurd
         ttQgaFA1XqmOp+UHGfABk/0zyhca7CfXXuWcmm95JwNnmvJWmrQnwCXLXCMT62hM0/FR
         OyWQ==
X-Gm-Message-State: APjAAAU0++eBe/o6k4mFAgadA1un2N4NMSFIAHVIsN2qMOAOUxL6MMwy
        VmF0VIyZp8+0u9wXgvluU8PQzVRh
X-Google-Smtp-Source: APXvYqzGpCtZENKSloy9zuK2TYpkRbUGHIGK3UauOR4Wv+GMGwX3v5u3sFa+bUgo4BG3/Nm5lWUPKQ==
X-Received: by 2002:a05:600c:204c:: with SMTP id p12mr15661206wmg.61.1575313339208;
        Mon, 02 Dec 2019 11:02:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm373909wre.68.2019.12.02.11.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 11:02:18 -0800 (PST)
Message-Id: <02b3843e9f21105a945335d0b1d78251ddcc8cee.1575313336.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
References: <pull.463.v2.git.1573828756.gitgitgadget@gmail.com>
        <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 19:02:16 +0000
Subject: [PATCH v3 1/1] Python3 support for t9800 tests. Basic P4/Python3
 support
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

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 825 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 628 insertions(+), 197 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..6f82184fe5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,22 +26,87 @@
 import zlib
 import ctypes
 import errno
+import os.path
+import codecs
+import io
 
 # support basestring in python3
 try:
     unicode = unicode
 except NameError:
     # 'unicode' is undefined, must be Python 3
-    str = str
+    #
+    # For Python3 which is natively unicode, we will use 
+    # unicode for internal information but all P4 Data
+    # will remain in bytes
+    isunicode = True
     unicode = str
     bytes = bytes
-    basestring = (str,bytes)
+
+    def as_string(text):
+        """Return a byte array as a unicode string"""
+        if text == None:
+            return None
+        if isinstance(text, bytes):
+            return unicode(text, "utf-8")
+        else:
+            return text
+
+    def as_bytes(text):
+        """Return a Unicode string as a byte array"""
+        if text == None:
+            return None
+        if isinstance(text, bytes):
+            return text
+        else:
+            return bytes(text, "utf-8")
+
+    def to_unicode(text):
+        """Return a byte array as a unicode string"""
+        return as_string(text)    
+
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded string """
+        if isinstance(path, unicode):
+            return path
+        return encodeWithUTF8(path).decode('utf-8')
+    
 else:
     # 'unicode' exists, must be Python 2
-    str = str
+    #
+    # We will treat the data as:
+    #   str   -> str
+    #   bytes -> str
+    # So for Python2 these functions are no-ops
+    # and will leave the data in the ambiguious
+    # string/bytes state
+    isunicode = False
     unicode = unicode
     bytes = str
-    basestring = basestring
+
+    def as_string(text):
+        """ Return text unaltered (for Python3 support) """
+        return text
+
+    def as_bytes(text):
+        """ Return text unaltered (for Python3 support) """
+        return text
+
+    def to_unicode(text):
+        """Return a string as a unicode string"""
+        return text.decode('utf-8')
+    
+    def path_as_string(path):
+        """ Converts a path to the UTF8 encoded bytes """
+        return encodeWithUTF8(path)
+
+
+ 
+# Check for raw_input support
+try:
+    raw_input
+except NameError:
+    raw_input = input
 
 try:
     from subprocess import CalledProcessError
@@ -75,7 +140,11 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = ["p4"]
+    # Look for the P4 binary
+    if (platform.system() == "Windows"):
+        real_cmd = ["p4.exe"]    
+    else:
+        real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
@@ -105,7 +174,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
     else:
         real_cmd += cmd
@@ -168,10 +237,11 @@ def die(msg):
         sys.exit(1)
 
 def write_pipe(c, stdin):
+    """Executes the command 'c', passing 'stdin' on the standard input"""
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
     pipe = p.stdin
     val = pipe.write(stdin)
@@ -179,11 +249,11 @@ def write_pipe(c, stdin):
     if p.wait():
         die('Command failed: %s' % str(c))
 
-    return val
 
 def p4_write_pipe(c, stdin):
+    """ Runs a P4 command 'c', passing 'stdin' data to P4"""
     real_cmd = p4_build_cmd(c)
-    return write_pipe(real_cmd, stdin)
+    write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c):
     """ Read output from  command. Returns a tuple
@@ -193,9 +263,11 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
+    out = as_string(out)
+    err = as_string(err)
     return (p.returncode, out, err)
 
 def read_pipe(c, ignore_error=False):
@@ -222,19 +294,31 @@ def read_pipe_text(c):
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
 
-    expand = isinstance(c, basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
     val = pipe.readlines()
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
+    # Unicode conversion from byte-string
+    # Iterate and fix in-place to avoid a second list in memory.
+    if isunicode:
+        for i in range(len(val)):
+            val[i] = as_string(val[i])
 
     return val
 
@@ -263,6 +347,8 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    out=as_string(out)
+    err=as_string(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -272,7 +358,7 @@ def p4_has_move_command():
     return True
 
 def system(cmd, ignore_error=False):
-    expand = isinstance(cmd,basestring)
+    expand = not isinstance(cmd, list)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
@@ -282,9 +368,10 @@ def system(cmd, ignore_error=False):
     return retcode
 
 def p4_system(cmd):
-    """Specifically invoke p4 as the system command. """
+    """ Specifically invoke p4 as the system command. 
+    """
     real_cmd = p4_build_cmd(cmd)
-    expand = isinstance(real_cmd, basestring)
+    expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
@@ -390,16 +477,20 @@ def p4_last_change():
     return int(results[0]['change'])
 
 def p4_describe(change, shelved=False):
-    """Make sure it returns a valid result by checking for
-       the presence of field "time".  Return a dict of the
-       results."""
+    """ Returns information about the requested P4 change list.
+
+        Data returns is not string encoded (returned as bytes)
+    """
+    # Make sure it returns a valid result by checking for
+    #   the presence of field "time".  Return a dict of the
+    #   results.
 
     cmd = ["describe", "-s"]
     if shelved:
         cmd += ["-S"]
     cmd += [str(change)]
 
-    ds = p4CmdList(cmd, skip_info=True)
+    ds = p4CmdList(cmd, skip_info=True, encode_data=False)
     if len(ds) != 1:
         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
 
@@ -409,21 +500,31 @@ def p4_describe(change, shelved=False):
         die("p4 describe -s %d exited with %d: %s" % (change, d["p4ExitCode"],
                                                       str(d)))
     if "code" in d:
-        if d["code"] == "error":
+        if d["code"] == b"error":
             die("p4 describe -s %d returned error code: %s" % (change, str(d)))
 
     if "time" not in d:
         die("p4 describe -s %d returned no \"time\": %s" % (change, str(d)))
 
+    # Convert depotFile(X) to be UTF-8 encoded, as this is what GIT
+    # requires. This will also allow us to encode the rest of the text
+    # at the same time to simplify textual processing later.
+    keys=d.keys()
+    for key in keys:
+        if key.startswith('depotFile'):
+            d[key]=d[key] #DepotPath(d[key])
+        elif key == 'path':
+            d[key]=d[key] #DepotPath(d[key])
+        else:
+            d[key] = as_string(d[key])
+
     return d
 
-#
-# Canonicalize the p4 type and return a tuple of the
-# base type, plus any modifiers.  See "p4 help filetypes"
-# for a list and explanation.
-#
 def split_p4_type(p4type):
-
+    """ Canonicalize the p4 type and return a tuple of the
+        base type, plus any modifiers.  See "p4 help filetypes"
+        for a list and explanation.
+    """
     p4_filetypes_historical = {
         "ctempobj": "binary+Sw",
         "ctext": "text+C",
@@ -452,18 +553,16 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
-#
-# return the raw p4 type of a file (text, text+ko, etc)
-#
 def p4_type(f):
+    """ return the raw p4 type of a file (text, text+ko, etc)
+    """
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
-#
-# Given a type base and modifier, return a regexp matching
-# the keywords that can be expanded in the file
-#
 def p4_keywords_regexp_for_type(base, type_mods):
+    """ Given a type base and modifier, return a regexp matching
+        the keywords that can be expanded in the file
+    """
     if base in ("text", "unicode", "binary"):
         kwords = None
         if "ko" in type_mods:
@@ -482,12 +581,11 @@ def p4_keywords_regexp_for_type(base, type_mods):
     else:
         return None
 
-#
-# Given a file, return a regexp matching the possible
-# RCS keywords that will be expanded, or None for files
-# with kw expansion turned off.
-#
 def p4_keywords_regexp_for_file(file):
+    """ Given a file, return a regexp matching the possible
+        RCS keywords that will be expanded, or None for files
+        with kw expansion turned off.
+    """
     if not os.path.exists(file):
         return None
     else:
@@ -522,7 +620,7 @@ def getP4OpenedType(file):
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
-    if isinstance(depotPaths,basestring):
+    if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
 
     for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
@@ -531,8 +629,8 @@ def getP4Labels(depotPaths):
 
     return labels
 
-# Return the set of all git tags
 def getGitTags():
+    """Return the set of all git tags"""
     gitTags = set()
     for line in read_pipe_lines(["git", "tag"]):
         tag = line.strip()
@@ -565,7 +663,7 @@ def parseDiffTreeEntry(entry):
 
     If the pattern is not matched, None is returned."""
 
-    match = diffTreePattern().next().match(entry)
+    match = next(diffTreePattern()).match(entry)
     if match:
         return {
             'src_mode': match.group(1),
@@ -584,6 +682,38 @@ def isModeExec(mode):
     # otherwise False.
     return mode[-3:] == "755"
 
+def encodeWithUTF8(path, verbose = False):
+    """ Ensure that the path is encoded as a UTF-8 string
+
+        Returns bytes(P3)/str(P2)
+    """
+   
+    if isunicode:
+        try:
+            if isinstance(path, unicode):
+                # It is already unicode, cast it as a bytes
+                # that is encoded as utf-8.
+                return path.encode('utf-8', 'strict')
+            path.decode('ascii', 'strict')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if verbose:
+                print('\nNOTE:Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, to_unicode(path)))
+    else:    
+        try:
+            path.decode('ascii')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if verbose:
+                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
+    return path
+
 class P4Exception(Exception):
     """ Base class for exceptions from the p4 client """
     def __init__(self, exit_code):
@@ -607,9 +737,25 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
-        errors_as_exceptions=False):
+        errors_as_exceptions=False, encode_data=True):
+    """ Executes a P4 command:  'cmd' optionally passing 'stdin' to the command's
+        standard input via a temporary file with 'stdin_mode' mode.
+
+        Output from the command is optionally passed to the callback function 'cb'.
+        If 'cb' is None, the response from the command is parsed into a list
+        of resulting dictionaries. (For each block read from the process pipe.)
+
+        If 'skip_info' is true, information in a block read that has a code type of
+        'info' will be skipped.
 
-    if isinstance(cmd,basestring):
+        If 'errors_as_exceptions' is set to true (the default is false) the error
+        code returned from the execution will generate an exception.
+
+        If 'encode_data' is set to true (the default) the data that is returned 
+        by this function will be passed through the "as_string" function.
+    """
+
+    if not isinstance(cmd, list):
         cmd = "-G " + cmd
         expand = True
     else:
@@ -626,11 +772,11 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        if isinstance(stdin,basestring):
+        if not isinstance(stdin, list):
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write(as_bytes(i) + b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -644,12 +790,15 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         while True:
             entry = marshal.load(p4.stdout)
             if skip_info:
-                if 'code' in entry and entry['code'] == 'info':
+                if b'code' in entry and entry[b'code'] == b'info':
                     continue
             if cb is not None:
                 cb(entry)
             else:
-                result.append(entry)
+                out = {}
+                for key, value in entry.items():
+                    out[as_string(key)] = (as_string(value) if encode_data else value)
+                result.append(out)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -677,6 +826,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     return result
 
 def p4Cmd(cmd):
+    """ Executes a P4 command an returns the results in a dictionary"""
     list = p4CmdList(cmd)
     result = {}
     for entry in list:
@@ -772,6 +922,7 @@ def extractSettingsGitLog(log):
     return values
 
 def gitBranchExists(branch):
+    """Checks to see if a given branch exists in the git repo"""
     proc = subprocess.Popen(["git", "rev-parse", branch],
                             stderr=subprocess.PIPE, stdout=subprocess.PIPE);
     return proc.wait() == 0;
@@ -785,20 +936,22 @@ def gitDeleteRef(ref):
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
-    """Return a bool, using git config --bool.  It is True only if the
-       variable is set to true, and False if set to false or not present
-       in the config."""
-
+    """ Return a bool, using git config --bool.  It is True only if the
+        variable is set to true, and False if set to false or not present
+        in the config.
+    """
     if key not in _gitConfig:
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
@@ -822,6 +975,11 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+def gitConfigSet(key, value):
+    """ Set the git configuration key 'key' to 'value' for this session
+    """
+    _gitConfig[key] = value
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -860,6 +1018,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = as_string(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -869,7 +1028,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
-    for branch in branches.keys():
+    for branch in list(branches.keys()):
         tip = branches[branch]
         log = extractLogMessageFromGitCommit(tip)
         settings = extractSettingsGitLog(log)
@@ -940,7 +1099,8 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
             system("git update-ref %s %s" % (remoteHead, originHead))
 
 def originP4BranchesExist():
-        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+    """Checks if origin/p4/master exists"""
+    return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
 
 def p4ParseNumericChangeRange(parts):
@@ -1035,7 +1195,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = sorted(changes)
     return changes
 
-def p4PathStartsWith(path, prefix):
+def p4PathStartsWith(path, prefix, verbose = False):
     # This method tries to remedy a potential mixed-case issue:
     #
     # If UserA adds  //depot/DirA/file1
@@ -1043,9 +1203,22 @@ def p4PathStartsWith(path, prefix):
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
@@ -1063,7 +1236,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [ k for k in list(entry.keys()) if k.startswith("View") ]
 
     # hold this new View
     view = View(client_name)
@@ -1101,18 +1274,24 @@ def wildcard_decode(path):
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
@@ -1244,7 +1423,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = pointerProcess.stdout.read()
+        pointerFile = as_string(pointerProcess.stdout.read())
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
@@ -1305,7 +1484,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
-class Command:
+class Command(object):
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
 
@@ -1320,7 +1499,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
-class P4UserMap:
+class P4UserMap(object):
     def __init__(self):
         self.userMapFromPerforceServer = False
         self.myP4UserId = None
@@ -1345,10 +1524,14 @@ def p4UserIsMe(self, p4User):
             return True
 
     def getUserCacheFilename(self):
+        """ Returns the filename of the username cache """
         home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
-        return home + "/.gitp4-usercache.txt"
+        return os.path.join(home, ".gitp4-usercache.txt")
 
     def getUserMapFromPerforceServer(self):
+        """ Creates the usercache from the data in P4.
+        """
+        
         if self.userMapFromPerforceServer:
             return
         self.users = {}
@@ -1371,21 +1554,24 @@ def getUserMapFromPerforceServer(self):
                 self.emails[email] = user
 
         s = ''
-        for (key, val) in self.users.items():
+        for (key, val) in list(self.users.items()):
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), "wb").write(s)
+        cache = io.open(self.getUserCacheFilename(), "wb")
+        cache.write(as_bytes(s))
+        cache.close()
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
+        """ Reads the P4 username to git email map """
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
@@ -1585,21 +1771,27 @@ def prepareLogMessage(self, template, message, jobs):
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
@@ -1722,14 +1914,14 @@ def prepareSubmitTemplate(self, changelist=None):
                 break
         if not change_entry:
             die('Failed to decode output of p4 change -o')
-        for key, value in change_entry.iteritems():
+        for key, value in list(change_entry.items()):
             if key.startswith('File'):
                 if 'depot-paths' in settings:
                     if not [p for p in settings['depot-paths']
-                            if p4PathStartsWith(value, p)]:
+                            if p4PathStartsWith(value, p, self.verbose)]:
                         continue
                 else:
-                    if not p4PathStartsWith(value, self.depotPath):
+                    if not p4PathStartsWith(value, self.depotPath, self.verbose):
                         continue
                 files_list.append(value)
                 continue
@@ -1779,7 +1971,8 @@ def edit_template(self, template_file):
             return True
 
         while True:
-            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ").lower() \
+                .strip()[0]
             if response == 'y':
                 return True
             if response == 'n':
@@ -1817,8 +2010,8 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
     def applyCommit(self, id):
         """Apply one commit, return True if it succeeded."""
 
-        print("Applying", read_pipe(["git", "show", "-s",
-                                     "--format=format:%h %s", id]))
+        print(("Applying", read_pipe(["git", "show", "-s",
+                                     "--format=format:%h %s", id])))
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
@@ -1939,8 +2132,23 @@ def applyCommit(self, id):
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
                         os.chmod(file, stat.S_IWRITE)
-                    self.patchRCSKeywords(file, kwfiles[file])
-                    fixed_rcs_keywords = True
+                    
+                    try:
+                        self.patchRCSKeywords(file, kwfiles[file])
+                        fixed_rcs_keywords = True
+                    except:
+                        # We are throwing an exception, undo all open edits
+                        for f in editedFiles:
+                            p4_revert(f)
+                        raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) != None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
@@ -1966,7 +2174,7 @@ def applyCommit(self, id):
             p4_delete(f)
 
         # Set/clear executable bits
-        for f in filesToChangeExecBit.keys():
+        for f in list(filesToChangeExecBit.keys()):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
@@ -2003,7 +2211,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate)
+        tmpFile.write(as_bytes(submitTemplate))
         tmpFile.close()
 
         if self.prepare_p4_only:
@@ -2053,8 +2261,8 @@ def applyCommit(self, id):
                 message = tmpFile.read()
                 tmpFile.close()
                 if self.isWindows:
-                    message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                    message = message.replace(b"\r\n", b"\n")
+                submitTemplate = message[:message.index(as_bytes(separatorLine))]
 
                 if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
@@ -2164,6 +2372,50 @@ def exportGitTags(self, gitTags):
                 if verbose:
                     print("created p4 label for tag %s" % name)
 
+    def run_hook(self, hook_name, args = []):
+        """ Runs a hook if it is found.
+
+            Returns NONE if the hook does not exist
+            Returns TRUE if the exit code is 0, FALSE for a non-zero exit code.
+        """
+        hook_file = self.find_hook(hook_name)
+        if hook_file == None:
+            if self.verbose:
+                print("Skipping hook: %s" % hook_name)
+            return None
+
+        if self.verbose:
+            print("hooks_path = %s " % hooks_path)
+            print("hook_file = %s " % hook_file)
+
+        # Run the hook
+        # TODO - allow non-list format
+        cmd = [hook_file] + args
+        return subprocess.call(cmd) == 0
+
+    def find_hook(self, hook_name):
+        """ Locates the hook file for the given operating system.
+        """
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) <= 0:
+            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
+
+        # Look in the obvious place
+        hook_file = os.path.join(hooks_path, hook_name)
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK):
+            return hook_file
+
+        # if we are windows, we will also allow them to have the hooks have extensions
+        if (platform.system() == "Windows"):
+            for ext in ['.exe', '.bat', 'ps1']:
+                if os.path.isfile(hook_file + ext) and os.access(hook_file + ext, os.X_OK):
+                    return hook_file + ext
+
+        # We didn't find the file
+        return None
+
+
+
     def run(self, args):
         if len(args) == 0:
             self.master = currentGitBranch()
@@ -2219,7 +2471,7 @@ def run(self, args):
             self.clientSpecDirs = getClientSpec()
 
         # Check for the existence of P4 branches
-        branchesDetected = (len(p4BranchesInGit().keys()) > 1)
+        branchesDetected = (len(list(p4BranchesInGit().keys())) > 1)
 
         if self.useClientSpec and not branchesDetected:
             # all files are relative to the client spec
@@ -2314,12 +2566,8 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
-        hooks_path = gitConfig("core.hooksPath")
-        if len(hooks_path) <= 0:
-            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
-
-        hook_file = os.path.join(hooks_path, "p4-pre-submit")
-        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+        rtn = self.run_hook("p4-pre-submit")
+        if rtn == False:
             sys.exit(1)
 
         #
@@ -2332,8 +2580,8 @@ def run(self, args):
         last = len(commits) - 1
         for i, commit in enumerate(commits):
             if self.dry_run:
-                print(" ", read_pipe(["git", "show", "-s",
-                                      "--format=format:%h %s", commit]))
+                print((" ", read_pipe(["git", "show", "-s",
+                                      "--format=format:%h %s", commit])))
                 ok = True
             else:
                 ok = self.applyCommit(commit)
@@ -2351,7 +2599,7 @@ def run(self, args):
                         if self.conflict_behavior == "ask":
                             print("What do you want to do?")
                             response = raw_input("[s]kip this commit but apply"
-                                                 " the rest, or [q]uit? ")
+                                                 " the rest, or [q]uit? ").lower().strip()[0]
                             if not response:
                                 continue
                         elif self.conflict_behavior == "skip":
@@ -2403,8 +2651,8 @@ def run(self, args):
                         star = "*"
                     else:
                         star = " "
-                    print(star, read_pipe(["git", "show", "-s",
-                                           "--format=format:%h %s",  c]))
+                    print((star, read_pipe(["git", "show", "-s",
+                                           "--format=format:%h %s",  c])))
                 print("You will have to do 'git p4 sync' and rebase.")
 
         if gitConfigBool("git-p4.exportLabels"):
@@ -2533,6 +2781,7 @@ def cloneExcludeCallback(option, opt_str, value, parser):
     # ("-//depot/A/..." becomes "/depot/A/..." after option parsing)
     parser.values.cloneExclude += ["/" + re.sub(r"\.\.\.$", "", value)]
 
+
 class P4Sync(Command, P4UserMap):
 
     def __init__(self):
@@ -2610,7 +2859,7 @@ def __init__(self):
         self.knownBranches = {}
         self.initialParents = {}
 
-        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
+        self.tz = "%+03d%02d" % (- time.timezone // 3600, ((- time.timezone % 3600) // 60))
         self.labels = {}
 
     # Force a checkpoint in fast-import and wait for it to finish
@@ -2624,17 +2873,23 @@ def checkpoint(self):
     def isPathWanted(self, path):
         for p in self.cloneExclude:
             if p.endswith("/"):
-                if p4PathStartsWith(path, p):
+                if p4PathStartsWith(path, p, self.verbose):
                     return False
             # "-//depot/file1" without a trailing "/" should only exclude "file1", but not "file111" or "file1_dir/file2"
             elif path.lower() == p.lower():
                 return False
         for p in self.depotPaths:
-            if p4PathStartsWith(path, p):
+            if p4PathStartsWith(path, p, self.verbose):
                 return True
         return False
 
     def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+        """ Generates the list of files to be added in this git commit.
+
+            commit     = Unicode[] - data read from the P4 commit
+            shelved    = Bool      - Is the P4 commit flagged as being shelved.
+            shelved_cl = Unicode   - Numeric string with the changelist number.
+        """
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -2676,7 +2931,7 @@ def stripRepoPath(self, path, prefixes):
             path = self.clientSpecDirs.map_in_client(path)
             if self.detectBranches:
                 for b in self.knownBranches:
-                    if p4PathStartsWith(path, b + "/"):
+                    if p4PathStartsWith(path, b + "/", self.verbose):
                         path = path[len(b)+1:]
 
         elif self.keepRepoPath:
@@ -2684,12 +2939,12 @@ def stripRepoPath(self, path, prefixes):
             # //depot/; just look at first prefix as they all should
             # be in the same depot.
             depot = re.sub("^(//[^/]+/).*", r'\1', prefixes[0])
-            if p4PathStartsWith(path, depot):
+            if p4PathStartsWith(path, depot, self.verbose):
                 path = path[len(depot):]
 
         else:
             for p in prefixes:
-                if p4PathStartsWith(path, p):
+                if p4PathStartsWith(path, p, self.verbose):
                     path = path[len(p):]
                     break
 
@@ -2697,8 +2952,11 @@ def stripRepoPath(self, path, prefixes):
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
@@ -2727,10 +2985,10 @@ def splitFilesIntoBranches(self, commit):
             else:
                 relPath = self.stripRepoPath(path, self.depotPaths)
 
-            for branch in self.knownBranches.keys():
+            for branch in list(self.knownBranches.keys()):
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
-                if p4PathStartsWith(relPath, branch + "/"):
+                if p4PathStartsWith(relPath, branch + "/", self.verbose):
                     if branch not in branches:
                         branches[branch] = []
                     branches[branch].append(file)
@@ -2739,36 +2997,34 @@ def splitFilesIntoBranches(self, commit):
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
 
-    def encodeWithUTF8(self, path):
-        try:
-            path.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
-        return path
-
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
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            #if isunicode:
+            #    sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_as_string(file['depotFile']), to_unicode(relPath), size//1024//1024))
+            #else:
+            #    sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_as_string(file['depotFile']), relPath, size//1024//1024))
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (path_as_string(file['depotFile']), as_string(relPath), size//1024//1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -2786,7 +3042,7 @@ def streamOneP4File(self, file, contents):
                 # to nothing.  This causes p4 errors when checking out such
                 # a change, and errors here too.  Work around it by ignoring
                 # the bad symlink; hopefully a future change fixes it.
-                print("\nIgnoring empty symlink in %s" % file['depotFile'])
+                print("\nIgnoring empty symlink in %s" % path_as_string(file['depotFile']))
                 return
             elif data[-1] == '\n':
                 contents = [data[:-1]]
@@ -2826,16 +3082,16 @@ def streamOneP4File(self, file, contents):
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
@@ -2845,7 +3101,7 @@ def streamOneP4File(self, file, contents):
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = encodeWithUTF8(relPath, self.verbose)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
@@ -2854,21 +3110,25 @@ def streamOneP4Deletion(self, file):
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
             if required_bytes > 0:
                 err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
+                    os.getcwd(), required_bytes//1024//1024
                 )
 
         if err:
@@ -2884,11 +3144,11 @@ def streamP4FilesCb(self, marshalled):
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
@@ -2897,14 +3157,17 @@ def streamP4FilesCb(self, marshalled):
 
         # pick up the new file information... for the
         # 'data' field we need to append to our array
-        for k in marshalled.keys():
-            if k == 'data':
+        for k in list(marshalled.keys()):
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
@@ -2912,14 +3175,15 @@ def streamP4FilesCb(self, marshalled):
             'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
-                progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                progress = 100.0*self.stream_file['streamContentSize']/size
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
@@ -2940,7 +3204,7 @@ def streamP4Files(self, files):
             self.stream_contents = []
             self.stream_have_file_info = False
 
-            # curry self argument
+            # Callback for P4 command to collect file content
             def streamP4FilesCbSelf(entry):
                 self.streamP4FilesCb(entry)
 
@@ -2949,9 +3213,9 @@ def streamP4FilesCbSelf(entry):
                 if 'shelved_cl' in f:
                     # Handle shelved CLs using the "p4 print file@=N" syntax to print
                     # the contents
-                    fileArg = '%s@=%d' % (f['path'], f['shelved_cl'])
+                    fileArg = b'%s@=%d' % (f['path'], as_bytes(f['shelved_cl']))
                 else:
-                    fileArg = '%s#%s' % (f['path'], f['rev'])
+                    fileArg = b'%s#%s' % (f['path'], as_bytes(f['rev']))
 
                 fileArgs.append(fileArg)
 
@@ -2971,7 +3235,7 @@ def make_email(self, userid):
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         """ Stream a p4 tag.
-        commit is either a git commit, or a fast-import mark, ":<p4commit>"
+            commit is either a git commit, or a fast-import mark, ":<p4commit>"
         """
 
         if verbose:
@@ -2994,7 +3258,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print(("labelDetails=",labelDetails))
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3016,7 +3280,7 @@ def hasBranchPrefix(self, path):
         if not self.branchPrefixes:
             return True
         hasPrefix = [p for p in self.branchPrefixes
-                        if p4PathStartsWith(path, p)]
+                        if p4PathStartsWith(path, p, self.verbose)]
         if not hasPrefix and self.verbose:
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
@@ -3043,7 +3307,22 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
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
@@ -3053,19 +3332,29 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
 
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
@@ -3133,7 +3422,7 @@ def getLabels(self):
             self.labels[newestChange] = [output, revisions]
 
         if self.verbose:
-            print("Label changes: %s" % self.labels.keys())
+            print("Label changes: %s" % list(self.labels.keys()))
 
     # Import p4 labels as git tags. A direct mapping does not
     # exist, so assume that if all the files are at the same revision
@@ -3234,7 +3523,7 @@ def getBranchMapping(self):
                 source = paths[0]
                 destination = paths[1]
                 ## HACK
-                if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
+                if p4PathStartsWith(source, self.depotPaths[0], self.verbose) and p4PathStartsWith(destination, self.depotPaths[0], self.verbose):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
 
@@ -3276,7 +3565,7 @@ def getBranchMapping(self):
 
     def getBranchMappingFromGitBranches(self):
         branches = p4BranchesInGit(self.importIntoRemotes)
-        for branch in branches.keys():
+        for branch in list(branches.keys()):
             if branch == "master":
                 branch = "main"
             else:
@@ -3388,14 +3677,14 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%4.1f%%)" % (change, cnt * 100 / len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
             try:
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
-                    for branch in branches.keys():
+                    for branch in list(branches.keys()):
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [ branchPrefix ]
@@ -3464,6 +3753,7 @@ def importChanges(self, changes, origin_revision=0):
                 sys.exit(1)
 
     def sync_origin_only(self):
+        """ Ensures that the origin has been synchronized if one is set """
         if self.syncWithOrigin:
             self.hasOrigin = originP4BranchesExist()
             if self.hasOrigin:
@@ -3472,30 +3762,35 @@ def sync_origin_only(self):
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
+        for info in p4CmdList(["files"] + fileArgs, encode_data = False):
 
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
 
 
@@ -3508,8 +3803,10 @@ def importHeadRevision(self, revision):
                 #fileCnt = fileCnt + 1
                 continue
 
+            # Save all the file information, howerver do not translate the depotFile name at 
+            # this time. Leave that as bytes since the encoding may vary.
             for prop in ["depotFile", "rev", "action", "type" ]:
-                details["%s%s" % (prop, fileCnt)] = info[prop]
+                details["%s%s" % (prop, fileCnt)] = (info[prop] if prop == "depotFile" else as_string(info[prop]))
 
             fileCnt = fileCnt + 1
 
@@ -3529,13 +3826,18 @@ def importHeadRevision(self, revision):
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
@@ -3584,13 +3886,13 @@ def run(self, args):
                 if short in branches:
                     self.p4BranchesInGit = [ short ]
             else:
-                self.p4BranchesInGit = branches.keys()
+                self.p4BranchesInGit = list(branches.keys())
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
                     print("Importing from/into multiple branches")
                 self.detectBranches = True
-                for branch in branches.keys():
+                for branch in list(branches.keys()):
                     self.initialParents[self.refPrefix + branch] = \
                         branches[branch]
 
@@ -3870,19 +4172,25 @@ def __init__(self):
                                  help="where to leave result of the clone"),
             optparse.make_option("--bare", dest="cloneBare",
                                  action="store_true", default=False),
+            optparse.make_option("--encoding", dest="setPathEncoding",
+                                 action="store", default=None,
+                                 help="Sets the path encoding for this depot")
         ]
         self.cloneDestination = None
         self.needsGit = False
         self.cloneBare = False
+        self.setPathEncoding = None
 
     def defaultDestination(self, args):
+        """Returns the last path component as the default git 
+        repository directory name"""
         ## TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
         depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
-        return os.path.split(depotDir)[1]
+        return depotDir.split('/')[-1]
 
     def run(self, args):
         if len(args) < 1:
@@ -3894,19 +4202,29 @@ def run(self, args):
 
         depotPaths = args
 
+        # If we have an encoding provided, ignore what may already exist
+        # in the registry. This will ensure we show the displayed values
+        # using the correct encoding.
+        if self.setPathEncoding:
+            gitConfigSet("git-p4.pathEncoding", self.setPathEncoding)
+
+        # If more than 1 path element is supplied, the last element
+        # is the clone destination.
         if not self.cloneDestination and len(depotPaths) > 1:
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
@@ -3919,6 +4237,13 @@ def run(self, args):
         if retcode:
             raise CalledProcessError(retcode, init_cmd)
 
+        # Set the encoding if it was provided command line
+        if self.setPathEncoding:
+            init_cmd= ["git", "config", "git-p4.pathEncoding", self.setPathEncoding]
+            retcode = subprocess.call(init_cmd)
+            if retcode:
+                raise CalledProcessError(retcode, init_cmd)
+
         if not P4Sync.run(self, depotPaths):
             return False
 
@@ -3974,7 +4299,7 @@ def findLastP4Revision(self, starting_point):
             to find the P4 commit we are based on, and the depot-paths.
         """
 
-        for parent in (range(65535)):
+        for parent in (list(range(65535))):
             log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
             if 'change' in settings:
@@ -4080,6 +4405,107 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+class Py23File():
+    """ Python2/3 Unicode File Wrapper 
+    """
+    
+    stream_handle = None
+    verbose       = False
+    debug_handle  = None
+   
+    def __init__(self, stream_handle, verbose = False,
+                 debug_handle = None):
+        """ Create a Python3 compliant Unicode to Byte String
+            Windows compatible wrapper
+
+            stream_handle = the underlying file-like handle
+            verbose       = Boolean if content should be echoed
+            debug_handle  = A file-like handle data is duplicately written to
+        """
+        self.stream_handle = stream_handle
+        self.verbose       = verbose
+        self.debug_handle  = debug_handle
+
+    def write(self, utf8string):
+        """ Writes the utf8 encoded string to the underlying 
+            file stream
+        """
+        self.stream_handle.write(as_bytes(utf8string))
+        if self.verbose:
+            sys.stderr.write("Stream Output: %s" % utf8string)
+            sys.stderr.flush()
+        if self.debug_handle:
+            self.debug_handle.write(as_bytes(utf8string))
+
+    def read(self, size = None):
+        """ Reads int charcters from the underlying stream 
+            and converts it to utf8.
+
+            Be aware, the size value is for reading the underlying
+            bytes so the value may be incorrect. Usage of the size
+            value is discouraged.
+        """
+        if size == None:
+            return as_string(self.stream_handle.read())
+        else:
+            return as_string(self.stream_handle.read(size))
+
+    def readline(self):
+        """ Reads a line from the underlying byte stream 
+            and converts it to utf8
+        """
+        return as_string(self.stream_handle.readline())
+
+    def readlines(self, sizeHint = None):
+        """ Returns a list containing lines from the file converted to unicode.
+
+            sizehint - Optional. If the optional sizehint argument is 
+            present, instead of reading up to EOF, whole lines totalling 
+            approximately sizehint bytes are read.
+        """
+        lines = self.stream_handle.readlines(sizeHint)
+        for i in range(0, len(lines)):
+            lines[i] = as_string(lines[i])
+        return lines
+
+    def close(self):
+        """ Closes the underlying byte stream """
+        self.stream_handle.close()
+
+    def flush(self):
+        """ Flushes the underlying byte stream """
+        self.stream_handle.flush()
+
+class DepotPath():
+    """ Describes a DepotPath or File
+    """
+
+    raw_path = None
+    utf8_path = None
+    bytes_path = None
+
+    def __init__(self, path):
+        """ Creates a new DepotPath with the path encoded
+            with by the P4 repository
+        """
+        raw_path = path
+
+    def raw():
+        """ Returns the path as it was originally found
+            in the P4 repository
+        """
+        return raw_path
+
+    def startswith(self, prefix, start = None, end = None):
+        """ Return True if string starts with the prefix, otherwise 
+            return False. prefix can also be a tuple of prefixes to 
+            look for. With optional start, test string beginning at 
+            that position. With optional end, stop comparing 
+            string at that position.
+        """
+        return raw_path.startswith(prefix, start, end)
+
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
@@ -4113,7 +4539,7 @@ def printUsage(commands):
 
 def main():
     if len(sys.argv[1:]) == 0:
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     cmdName = sys.argv[1]
@@ -4123,7 +4549,7 @@ def main():
     except KeyError:
         print("unknown command %s" % cmdName)
         print("")
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     options = cmd.options
@@ -4140,7 +4566,12 @@ def main():
                                    description = cmd.description,
                                    formatter = HelpFormatter())
 
-    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    try:
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    except:
+        parser.print_help()
+        raise
+
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
@@ -4155,8 +4586,8 @@ def main():
                         chdir(cdup);
 
         if not isValidGitDir(cmd.gitdir):
-            if isValidGitDir(cmd.gitdir + "/.git"):
-                cmd.gitdir += "/.git"
+            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
+                cmd.gitdir = os.path.join(cmd.gitdir, ".git")
             else:
                 die("fatal: cannot locate git repository at %s" % cmd.gitdir)
 
-- 
gitgitgadget
