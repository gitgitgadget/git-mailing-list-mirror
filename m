Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2898AC433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiDAPzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiDAPRu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:17:50 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB82D554BB
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:01:20 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDb-009TW3-FC; Fri, 01 Apr 2022 15:25:38 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 01/22] git-p4: add blank lines between functions and class definitions
Date:   Fri,  1 Apr 2022 15:24:43 +0100
Message-Id: <20220401142504.58995-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the PEP8 style guidelines, top-level functions and class definitions
should be separated by two blank lines. Methods should be surrounded by
a single blank line.

This guideline is described here in the "Blank Lines" section:
https://www.python.org/dev/peps/pep-0008/#blank-lines

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index a9b1f90441..265182b088 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -59,6 +59,7 @@
 re_ko_keywords = re.compile(br'\$(Id|Header)(:[^$\n]+)?\$')
 re_k_keywords = re.compile(br'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')
 
+
 def format_size_human_readable(num):
     """ Returns a number of units (typically bytes) formatted as a human-readable
         string.
@@ -71,6 +72,7 @@ def format_size_human_readable(num):
             return "{:3.1f} {}B".format(num, unit)
     return "{:.1f} YiB".format(num)
 
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -118,6 +120,7 @@ def p4_build_cmd(cmd):
 
     return real_cmd
 
+
 def git_dir(path):
     """ Return TRUE if the given path is a git directory (/path/to/dir/.git).
         This won't automatically add ".git" to a directory.
@@ -128,6 +131,7 @@ def git_dir(path):
     else:
         return d
 
+
 def chdir(path, is_client_path=False):
     """Do chdir to the given path, and set the PWD environment
        variable for use by P4.  It does not look at getcwd() output.
@@ -150,6 +154,7 @@ def chdir(path, is_client_path=False):
         path = os.getcwd()
     os.environ['PWD'] = path
 
+
 def calcDiskFree():
     """Return free space in bytes on the disk of the given dirname."""
     if platform.system() == 'Windows':
@@ -160,6 +165,7 @@ def calcDiskFree():
         st = os.statvfs(os.getcwd())
         return st.f_bavail * st.f_frsize
 
+
 def die(msg):
     """ Terminate execution. Make sure that any running child processes have been wait()ed for before
         calling this.
@@ -170,6 +176,7 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+
 def prompt(prompt_text):
     """ Prompt the user to choose one of the choices
 
@@ -188,21 +195,25 @@ def prompt(prompt_text):
         if response in choices:
             return response
 
+
 # We need different encoding/decoding strategies for text data being passed
 # around in pipes depending on python version
 if bytes is not str:
     # For python3, always encode and decode as appropriate
     def decode_text_stream(s):
         return s.decode() if isinstance(s, bytes) else s
+
     def encode_text_stream(s):
         return s.encode() if isinstance(s, str) else s
 else:
     # For python2.7, pass read strings as-is, but also allow writing unicode
     def decode_text_stream(s):
         return s
+
     def encode_text_stream(s):
         return s.encode('utf_8') if isinstance(s, unicode) else s
 
+
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
@@ -218,6 +229,7 @@ def decode_path(path):
                 print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
         return path
 
+
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
     args = ['git', 'hook', 'run', '--ignore-missing', cmd]
@@ -227,6 +239,7 @@ def run_git_hook(cmd, param=[]):
             args.append(p)
     return subprocess.call(args) == 0
 
+
 def write_pipe(c, stdin, *k, **kw):
     if verbose:
         sys.stderr.write('Writing pipe: {}\n'.format(' '.join(c)))
@@ -240,12 +253,14 @@ def write_pipe(c, stdin, *k, **kw):
 
     return val
 
+
 def p4_write_pipe(c, stdin, *k, **kw):
     real_cmd = p4_build_cmd(c)
     if bytes is not str and isinstance(stdin, str):
         stdin = encode_text_stream(stdin)
     return write_pipe(real_cmd, stdin, *k, **kw)
 
+
 def read_pipe_full(c, *k, **kw):
     """ Read output from  command. Returns a tuple
         of the return status, stdout text and stderr
@@ -259,6 +274,7 @@ def read_pipe_full(c, *k, **kw):
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
+
 def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
@@ -276,6 +292,7 @@ def read_pipe(c, ignore_error=False, raw=False, *k, **kw):
         out = decode_text_stream(out)
     return out
 
+
 def read_pipe_text(c, *k, **kw):
     """ Read output from a command with trailing whitespace stripped.
         On error, returns None.
@@ -286,10 +303,12 @@ def read_pipe_text(c, *k, **kw):
     else:
         return decode_text_stream(out).rstrip()
 
+
 def p4_read_pipe(c, ignore_error=False, raw=False, *k, **kw):
     real_cmd = p4_build_cmd(c)
     return read_pipe(real_cmd, ignore_error, raw=raw, *k, **kw)
 
+
 def read_pipe_lines(c, raw=False, *k, **kw):
     if verbose:
         sys.stderr.write('Reading pipe: {}\n'.format(' '.join(c)))
@@ -303,11 +322,13 @@ def read_pipe_lines(c, raw=False, *k, **kw):
         die('Command failed: {}'.format(' '.join(c)))
     return lines
 
+
 def p4_read_pipe_lines(c, *k, **kw):
     """Specifically invoke p4 on the command supplied. """
     real_cmd = p4_build_cmd(c)
     return read_pipe_lines(real_cmd, *k, **kw)
 
+
 def p4_has_command(cmd):
     """Ask p4 for help on this command.  If it returns an error, the
        command does not exist in this version of p4."""
@@ -317,6 +338,7 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+
 def p4_has_move_command():
     """See if the move command exists, that it supports -k, and that
        it has not been administratively disabled.  The arguments
@@ -337,6 +359,7 @@ def p4_has_move_command():
     # assume it failed because @... was invalid changelist
     return True
 
+
 def system(cmd, ignore_error=False, *k, **kw):
     if verbose:
         sys.stderr.write("executing {}\n".format(
@@ -347,6 +370,7 @@ def system(cmd, ignore_error=False, *k, **kw):
 
     return retcode
 
+
 def p4_system(cmd, *k, **kw):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
@@ -354,9 +378,11 @@ def p4_system(cmd, *k, **kw):
     if retcode:
         raise subprocess.CalledProcessError(retcode, real_cmd)
 
+
 def die_bad_access(s):
     die("failure accessing depot: {0}".format(s.rstrip()))
 
+
 def p4_check_access(min_expiration=1):
     """ Check if we can access Perforce - account still logged in
     """
@@ -402,7 +428,10 @@ def p4_check_access(min_expiration=1):
     else:
         die_bad_access("unknown error code {0}".format(code))
 
+
 _p4_version_string = None
+
+
 def p4_version_string():
     """Read the version string, showing just the last line, which
        hopefully is the interesting version bit.
@@ -418,12 +447,15 @@ def p4_version_string():
         _p4_version_string = a[-1].rstrip()
     return _p4_version_string
 
+
 def p4_integrate(src, dest):
     p4_system(["integrate", "-Dt", wildcard_encode(src), wildcard_encode(dest)])
 
+
 def p4_sync(f, *options):
     p4_system(["sync"] + list(options) + [wildcard_encode(f)])
 
+
 def p4_add(f):
     # forcibly add file names with wildcards
     if wildcard_present(f):
@@ -431,29 +463,37 @@ def p4_add(f):
     else:
         p4_system(["add", f])
 
+
 def p4_delete(f):
     p4_system(["delete", wildcard_encode(f)])
 
+
 def p4_edit(f, *options):
     p4_system(["edit"] + list(options) + [wildcard_encode(f)])
 
+
 def p4_revert(f):
     p4_system(["revert", wildcard_encode(f)])
 
+
 def p4_reopen(type, f):
     p4_system(["reopen", "-t", type, wildcard_encode(f)])
 
+
 def p4_reopen_in_change(changelist, files):
     cmd = ["reopen", "-c", str(changelist)] + files
     p4_system(cmd)
 
+
 def p4_move(src, dest):
     p4_system(["move", "-k", wildcard_encode(src), wildcard_encode(dest)])
 
+
 def p4_last_change():
     results = p4CmdList(["changes", "-m", "1"], skip_info=True)
     return int(results[0]['change'])
 
+
 def p4_describe(change, shelved=False):
     """Make sure it returns a valid result by checking for
        the presence of field "time".  Return a dict of the
@@ -482,6 +522,7 @@ def p4_describe(change, shelved=False):
 
     return d
 
+
 #
 # Canonicalize the p4 type and return a tuple of the
 # base type, plus any modifiers.  See "p4 help filetypes"
@@ -517,6 +558,7 @@ def split_p4_type(p4type):
         mods = s[1]
     return (base, mods)
 
+
 #
 # return the raw p4 type of a file (text, text+ko, etc)
 #
@@ -524,6 +566,7 @@ def p4_type(f):
     results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
+
 #
 # Given a type base and modifier, return a regexp matching
 # the keywords that can be expanded in the file
@@ -539,6 +582,7 @@ def p4_keywords_regexp_for_type(base, type_mods):
     else:
         return None
 
+
 #
 # Given a file, return a regexp matching the possible
 # RCS keywords that will be expanded, or None for files
@@ -551,6 +595,7 @@ def p4_keywords_regexp_for_file(file):
         (type_base, type_mods) = split_p4_type(p4_type(file))
         return p4_keywords_regexp_for_type(type_base, type_mods)
 
+
 def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
     # the execute bit setting in the passed in mode.
@@ -566,6 +611,7 @@ def setP4ExecBit(file, mode):
 
     p4_reopen(p4Type, file)
 
+
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
@@ -576,6 +622,7 @@ def getP4OpenedType(file):
     else:
         die("Could not determine file type for %s (result: '%s')" % (file, result))
 
+
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
@@ -588,6 +635,7 @@ def getP4Labels(depotPaths):
 
     return labels
 
+
 # Return the set of all git tags
 def getGitTags():
     gitTags = set()
@@ -596,8 +644,10 @@ def getGitTags():
         gitTags.add(tag)
     return gitTags
 
+
 _diff_tree_pattern = None
 
+
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
 
@@ -635,41 +685,52 @@ def parseDiffTreeEntry(entry):
         }
     return None
 
+
 def isModeExec(mode):
     # Returns True if the given git mode represents an executable file,
     # otherwise False.
     return mode[-3:] == "755"
 
+
 class P4Exception(Exception):
     """ Base class for exceptions from the p4 client """
+
     def __init__(self, exit_code):
         self.p4ExitCode = exit_code
 
+
 class P4ServerException(P4Exception):
     """ Base class for exceptions where we get some kind of marshalled up result from the server """
+
     def __init__(self, exit_code, p4_result):
         super(P4ServerException, self).__init__(exit_code)
         self.p4_result = p4_result
         self.code = p4_result[0]['code']
         self.data = p4_result[0]['data']
 
+
 class P4RequestSizeException(P4ServerException):
     """ One of the maxresults or maxscanrows errors """
+
     def __init__(self, exit_code, p4_result, limit):
         super(P4RequestSizeException, self).__init__(exit_code, p4_result)
         self.limit = limit
 
+
 class P4CommandException(P4Exception):
     """ Something went wrong calling p4 which means we have to give up """
+
     def __init__(self, msg):
         self.msg = msg
 
     def __str__(self):
         return self.msg
 
+
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False, *k, **kw):
 
@@ -746,6 +807,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
+
 def p4Cmd(cmd, *k, **kw):
     list = p4CmdList(cmd, *k, **kw)
     result = {}
@@ -753,6 +815,7 @@ def p4Cmd(cmd, *k, **kw):
         result.update(entry)
     return result;
 
+
 def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
@@ -789,20 +852,25 @@ def p4Where(depotPath):
         clientPath = clientPath[:-3]
     return clientPath
 
+
 def currentGitBranch():
     return read_pipe_text(["git", "symbolic-ref", "--short", "-q", "HEAD"])
 
+
 def isValidGitDir(path):
     return git_dir(path) != None
 
+
 def parseRevision(ref):
     return read_pipe(["git", "rev-parse", ref]).strip()
 
+
 def branchExists(ref):
     rev = read_pipe(["git", "rev-parse", "-q", "--verify", ref],
                      ignore_error=True)
     return len(rev) > 0
 
+
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
@@ -817,6 +885,7 @@ def extractLogMessageFromGitCommit(commit):
        logMessage += log
     return logMessage
 
+
 def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
@@ -842,19 +911,24 @@ def extractSettingsGitLog(log):
         values['depot-paths'] = paths.split(',')
     return values
 
+
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
                             stderr=subprocess.PIPE, stdout=subprocess.PIPE);
     return proc.wait() == 0;
 
+
 def gitUpdateRef(ref, newvalue):
     subprocess.check_call(["git", "update-ref", ref, newvalue])
 
+
 def gitDeleteRef(ref):
     subprocess.check_call(["git", "update-ref", "-d", ref])
 
+
 _gitConfig = {}
 
+
 def gitConfig(key, typeSpecifier=None):
     if key not in _gitConfig:
         cmd = [ "git", "config" ]
@@ -865,6 +939,7 @@ def gitConfig(key, typeSpecifier=None):
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
 
+
 def gitConfigBool(key):
     """Return a bool, using git config --bool.  It is True only if the
        variable is set to true, and False if set to false or not present
@@ -874,6 +949,7 @@ def gitConfigBool(key):
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
+
 def gitConfigInt(key):
     if key not in _gitConfig:
         cmd = [ "git", "config", "--int", key ]
@@ -885,6 +961,7 @@ def gitConfigInt(key):
             _gitConfig[key] = None
     return _gitConfig[key]
 
+
 def gitConfigList(key):
     if key not in _gitConfig:
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
@@ -893,6 +970,7 @@ def gitConfigList(key):
             _gitConfig[key] = []
     return _gitConfig[key]
 
+
 def p4BranchesInGit(branchesAreInRemotes=True):
     """Find all the branches whose names start with "p4/", looking
        in remotes or heads as specified by the argument.  Return
@@ -925,6 +1003,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 
     return branches
 
+
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
@@ -937,6 +1016,7 @@ def branch_exists(branch):
     # expect exactly one line of output: the branch name
     return out.rstrip() == branch
 
+
 def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
@@ -964,6 +1044,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
     return ["", settings]
 
+
 def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
@@ -1011,6 +1092,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         if update:
             system(["git", "update-ref", remoteHead, originHead])
 
+
 def originP4BranchesExist():
         return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
@@ -1024,12 +1106,14 @@ def p4ParseNumericChangeRange(parts):
 
     return (changeStart, changeEnd)
 
+
 def chooseBlockSize(blockSize):
     if blockSize:
         return blockSize
     else:
         return defaultBlockSize
 
+
 def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     assert depotPaths
 
@@ -1107,6 +1191,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = sorted(changes)
     return changes
 
+
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
     #
@@ -1119,6 +1204,7 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
+
 def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
@@ -1149,6 +1235,7 @@ def getClientSpec():
 
     return view
 
+
 def getClientRoot():
     """Grab the client directory."""
 
@@ -1162,6 +1249,7 @@ def getClientRoot():
 
     return entry["Root"]
 
+
 #
 # P4 wildcards are not allowed in filenames.  P4 complains
 # if you simply add them, but you can force it with "-f", in
@@ -1179,6 +1267,7 @@ def wildcard_decode(path):
                .replace("%25", "%")
     return path
 
+
 def wildcard_encode(path):
     # do % first to avoid double-encoding the %s introduced here
     path = path.replace("%", "%25") \
@@ -1187,10 +1276,12 @@ def wildcard_encode(path):
                .replace("@", "%40")
     return path
 
+
 def wildcard_present(path):
     m = re.search("[*#@%]", path)
     return m is not None
 
+
 class LargeFileSystem(object):
     """Base class for large file system support."""
 
@@ -1272,6 +1363,7 @@ def processContent(self, git_mode, relPath, contents):
                     sys.stderr.write("%s moved to large file system (%s)\n" % (relPath, localLargeFile))
         return (git_mode, contents)
 
+
 class MockLFS(LargeFileSystem):
     """Mock large file system for testing."""
 
@@ -1295,6 +1387,7 @@ def pushFile(self, localLargeFile):
             os.makedirs(remotePath)
         shutil.copyfile(localLargeFile, os.path.join(remotePath, os.path.basename(localLargeFile)))
 
+
 class GitLFS(LargeFileSystem):
     """Git LFS as backend for the git-p4 large file system.
        See https://git-lfs.github.com/ for details."""
@@ -1383,6 +1476,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
+
 class Command:
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
@@ -1398,6 +1492,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
+
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
@@ -1468,6 +1563,7 @@ def loadUserMapFromCache(self):
         except IOError:
             self.getUserMapFromPerforceServer()
 
+
 class P4Submit(Command, P4UserMap):
 
     conflict_behavior_choices = ("ask", "skip", "quit")
@@ -2473,6 +2569,7 @@ def run(self, args):
 
         return True
 
+
 class View(object):
     """Represent a p4 view ("p4 help views"), and map files in a
        repo according to the view."""
@@ -2580,11 +2677,13 @@ def map_in_client(self, depot_path):
         die( "Error: %s is not found in client spec path" % depot_path )
         return ""
 
+
 def cloneExcludeCallback(option, opt_str, value, parser):
     # prepend "/" because the first "/" was consumed as part of the option itself.
     # ("-//depot/A/..." becomes "/depot/A/..." after option parsing)
     parser.values.cloneExclude += ["/" + re.sub(r"\.\.\.$", "", value)]
 
+
 class P4Sync(Command, P4UserMap):
 
     def __init__(self):
@@ -3942,6 +4041,7 @@ def run(self, args):
 
         return True
 
+
 class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
@@ -3979,6 +4079,7 @@ def rebase(self):
             "HEAD", "--"])
         return True
 
+
 class P4Clone(P4Sync):
     def __init__(self):
         P4Sync.__init__(self)
@@ -4057,6 +4158,7 @@ def run(self, args):
 
         return True
 
+
 class P4Unshelve(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4172,6 +4274,7 @@ def run(self, args):
 
         return True
 
+
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
@@ -4197,6 +4300,7 @@ def run(self, args):
             print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
+
 class HelpFormatter(optparse.IndentedHelpFormatter):
     def __init__(self):
         optparse.IndentedHelpFormatter.__init__(self)
@@ -4207,6 +4311,7 @@ def format_description(self, description):
         else:
             return ""
 
+
 def printUsage(commands):
     print("usage: %s <command> [options]" % sys.argv[0])
     print("")
@@ -4215,6 +4320,7 @@ def printUsage(commands):
     print("Try %s <command> --help for command specific help." % sys.argv[0])
     print("")
 
+
 commands = {
     "submit" : P4Submit,
     "commit" : P4Submit,
@@ -4225,6 +4331,7 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
+
 def main():
     if len(sys.argv[1:]) == 0:
         printUsage(commands.keys())
-- 
2.35.GIT

