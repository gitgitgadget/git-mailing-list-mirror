Received: from pfhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0410190482
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392591; cv=none; b=bCmWlM+QLXttFx9cl/rwBip8909G/alnfOQJGJmzkNLR1k+zE520fIulMlTEwM4iX4kRIrWfjbEogsUBO6/GTgGBnbT0giOtxh8jHLK2lPV2v2576oTsVw0x2ktAeYUbUknFlBLVUALvZtG+FvQAcHLOilNIufqaAa416sADHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392591; c=relaxed/simple;
	bh=66mPhaqr+n8A0McYlCPGIZ1KwmUgW2jIaaHi9Ipnvd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cZEeFUBchtPBbYvIzkCKkfB3x3wc8Hl3uWjZV80t48Wu1zvohFO5h0AgRqCGqdlnageVVSjynaTALuGF1Ne1eYj/tqbREr7QweD3TR0qxzsbOO/+bmE/sSSASWk1WwvwAA50XrYMYnw/pdB1xFPydSRDxrwdVs7aelhg7i7OY0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=muL/MBeT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwC1jWWG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="muL/MBeT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwC1jWWG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E30741140253;
	Tue,  3 Sep 2024 15:43:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 15:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1725392586; x=1725478986; bh=EY
	6VCEH4WerIEAYvvTAVnTl1HlQmJFLlXsPyidswWR0=; b=muL/MBeTaM5Ank1mML
	HvdfQO1Jcd+M5vPPGRofJqlXrP8lX8QWRzKYbVdyi31QGLCcnt+5b3lPUzBksjmX
	b1WGaV4RLgs44UuIPCH2r+SUkLGUmYAq8ecE4DoqLmnNI6zfLfQQlq4qXs8fEi2Q
	OakdT5yxCfkXEnKZCrXSGdyyFO/bBA+v36XF09jF6UNp0bwT3+nGi54ym573BMAd
	bF3NpgRggmQjCIC8dSKG21yDtVaI8HQKlRnl575k6DpQB5IEjDPct0TLE7qn4VId
	2BkCraCXR00tlmAXoKQ7030nXdCJa2PHlM53AmOtDMLuq8I4MTca+gyR7dXxKr3b
	OrHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1725392586; x=1725478986; bh=EY6VCEH4WerIE
	AYvvTAVnTl1HlQmJFLlXsPyidswWR0=; b=nwC1jWWGi2ySkcnWnCH9qXU2ysLqb
	hBD9fQmXCNX8+LXn4GuA55cnpeDei0KZAlRsce+u9EJD6r/emfQecsOKTI8yCu4k
	+dNDNBNq1rzHYUMr2nUXYG6v6xe9/uFsmhYqTqGOHyJUNFk1GxF+EP3yoO4+6aQ9
	HVAvNMhBdkObK93+ybnmo/awjUwnkf5tMpeIJ3etvEA8vSIB/9AuCrRrv+1s5U+u
	p/7HwABA+PZWbpNKavFLPg5zTLdxk8vE9WLu5Vl9hADy4zkQqxvefo9OVv7b/3XQ
	c8I/pq5HEBt26d2uVfbvoeIAyAgZCfTqG8miotpKivdERTu4zfvsTV7Aw==
X-ME-Sender: <xms:ymbXZtgdd8U8lPUaQjCq5mktUXZwALQJuD4QX5n5bbSutHjrb9nzgg>
    <xme:ymbXZiDhnTPw0kubHT4uhI_Vw0LTBsJ3JrQIu0Rjyg9GlJ4qKPqOwyddcbO6qGHxZ
    rStDKIGhNLt5UZkgzc>
X-ME-Received: <xmr:ymbXZtHyWxPYU43oubjqi-c2IYXW_PGh2U20HDg48GTcypV0C3slskGxvHVuU8eZB_aNPqDl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepkggrtghkucghvghinh
    gsvghrghcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtffrrghtthgvrhhn
    pefhheduveefvdeiheejiedvveeihedtgeellefflefgffdttdfgfeelvddvlefhveenuc
    ffohhmrghinhepphihthhhohhnrdhorhhgpdhgihhthhhusgdrihhopdhgihhthhhusgdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    iirggtkhesohiflhhfohhlihhordhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiigrtghk
    sehofihlfhholhhiohdrohhrgh
X-ME-Proxy: <xmx:ymbXZiSV3TXj9hxp2NqcUFHgVUcRA113Haawy7_eUDqEzq3nZH1LuQ>
    <xmx:ymbXZqycyvRzyLtungf0rTW7I3GhnnWMZVXtDt-s0LcIIH4k8R7vSA>
    <xmx:ymbXZo7ZfVo6vy5MypJ6KoK5EK4ObmE_CPUFVlOQmOaDVoOa1B13Sw>
    <xmx:ymbXZvzGkL6OyKS1u32s5Pa6zAOgJtWg-off5R2vVdxO3IDR37Tb2A>
    <xmx:ymbXZu-ihl0a_yvtoxHCXbFBQyMW9pe0_HKceBVJLZmNXgFYz5kCoLQk>
Feedback-ID: i876146a2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 15:43:05 -0400 (EDT)
Received: by moxana.owlfolio.org (sSMTP sendmail emulation); Tue, 03 Sep 2024 15:43:05 -0400
From: Zack Weinberg <zack@owlfolio.org>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,
	Zack Weinberg <zack@owlfolio.org>
Subject: [filter-repo PATCH]: add --callbacks option to load many callbacks from one file
Date: Tue,  3 Sep 2024 15:42:44 -0400
Message-ID: <20240903194244.16709-1-zack@owlfolio.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If you are trying to do something complicated with filter-repo,
you might need to share state among several callbacks, which is
currently impossible (short of poking values into someone else’s
namespace) because each callback defined on the command line gets
its own globals dictionary.

Or, if you are trying to do something simple but long-winded, such as
replacing the entire contents of a file, you might want to define long
multi-line (byte) strings as global variables, to avoid having to deal
with the undocumented number of spaces inserted at the beginning of
each line by the callback parser.

To facilitate these kinds of uses, add a new command line option
`--callbacks`.  The argument to this option is a file, which should
define callback functions, using the same naming convention as is
described for individual command line callbacks, e.g.

    def name_callback(name):
        ...

to set the name callback.  Any Python callable is acceptable, e.g.

    class Callbacks:
        def name_callback(self, name):
            ...

    callbacks = Callbacks()
    name_callback = callbacks.name_callback

will also work.  People who know about the undocumented second argument
to some callbacks may define callbacks that take two arguments.

The callbacks file is loaded as an ordinary Python module; it does _not_
get any automatic globals, unlike individual command line callbacks.
However, `import git_format_repo` will work inside the callbacks file,
even if git_format_repo.py has not been made available in general.

Tests are added which lightly exercise the new feature, and I have
also used it myself for a real repo rewrite (of the “simple but
long-winded” variety).

----

Also document (briefly) the existing feature of supplying a file
name rather than an inline function body to --foo-callback options,
and the availability of an unspecified set of globals to individual
callbacks (with instruction to see the source code for details).

This patch introduces uses of the Python standard library modules
errno, importlib, and inspect.  All functionality used from these
modules was available in 3.6 or earlier.

This patch introduces several new translatable strings and changes
one existing translatable string.

----

Signed-off-by: Zack Weinberg <zack@owlfolio.org>
---
 Documentation/git-filter-repo.txt |  39 ++++++-
 git-filter-repo                   | 164 +++++++++++++++++++++++-------
 t/t9391-filter-repo-lib-usage.sh  |   2 +-
 t/t9392-python-callback.sh        |  57 ++++++++++-
 4 files changed, 219 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-filter-repo.txt b/Documentation/git-filter-repo.txt
index 85cd5b9..09128e4 100644
--- a/Documentation/git-filter-repo.txt
+++ b/Documentation/git-filter-repo.txt
@@ -1084,7 +1084,7 @@ For flexibility, filter-repo allows you to specify functions on the
 command line to further filter all changes.  Please note that there
 are some API compatibility caveats associated with these callbacks
 that you should be aware of before using them; see the "API BACKWARD
-COMPATIBILITY CAVEAT" comment near the top of git-filter-repo source
+COMPATIBILITY CAVEAT" comment near the top of the git-filter-repo source
 code.
 
 All callback functions are of the same general format.  For a command line
@@ -1102,10 +1102,39 @@ def foo_callback(foo):
 --------------------------------------------------
 
 Thus, you just need to make sure your _BODY_ modifies and returns
-_foo_ appropriately.  One important thing to note for all callbacks is
-that filter-repo uses bytestrings (see
-https://docs.python.org/3/library/stdtypes.html#bytes) everywhere
-instead of strings.
+_foo_ appropriately.  Alternatively, _BODY_ can be the name of a file,
+in which case the function body is read from that file.
+
+Callback functions defined this way have access to all the standard
+library modules imported by git-filter-repo itself, plus its public
+library API; see the `public_globals` variable, near the top of
+git-filter-repo, for the exact list.
+
+Callback functions can also be defined in a group:
+
+--------------------------------------------------
+--callbacks FILE
+--------------------------------------------------
+
+will load FILE as a Python module.  FILE should define functions
+(actually, any Python callable will do) for each of the callbacks you
+wish to use, with names like `foo_callback`, where `foo` corresponds
+to a `--foo-callback` command line option.  This can be useful if you
+need to share state among your callbacks, or do some preparation in
+advance of the first call.
+
+Callback functions defined this way are _not_ given access to any
+modules or globals that FILE doesn’t import for itself.  However,
+`import git_filter_repo` will work inside FILE, whether or not
+`git_filter_repo.py` has been installed (see `INSTALL.md` in the
+source tree for further explanation).
+
+There can be only one callback function of a particular type, however
+you define it.
+
+When writing callbacks, keep in mind that git-filter-repo uses
+bytestrings (see https://docs.python.org/3/library/stdtypes.html#bytes)
+everywhere, instead of strings.
 
 There are four callbacks that allow you to operate directly on raw
 objects that contain data that's easy to write in
diff --git a/git-filter-repo b/git-filter-repo
index 9cce52a..7334c2d 100755
--- a/git-filter-repo
+++ b/git-filter-repo
@@ -32,8 +32,10 @@ operations; however:
 
 import argparse
 import collections
+import errno
 import fnmatch
 import gettext
+import inspect
 import io
 import os
 import platform
@@ -53,10 +55,10 @@ __all__ = ["Blob", "Reset", "FileChange", "Commit", "Tag", "Progress",
 
 # The globals to make visible to callbacks. They will see all our imports for
 # free, as well as our public API.
-public_globals = ["__builtins__", "argparse", "collections", "fnmatch",
-                  "gettext", "io", "os", "platform", "re", "shutil",
-                  "subprocess", "sys", "time", "textwrap", "tzinfo",
-                  "timedelta", "datetime"] + __all__
+public_globals = ["__builtins__", "argparse", "collections", "errno",
+                  "fnmatch", "gettext", "inspect", "io", "os", "platform",
+                  "re", "shutil", "subprocess", "sys", "time", "textwrap",
+                  "tzinfo", "timedelta", "datetime"] + __all__
 
 deleted_hash = b'0'*40
 write_marks = True
@@ -1719,6 +1721,9 @@ class FilteringOptions(object):
       def foo_callback(foo):
         BODY
 
+    Alternatively, BODY can be a filename; then the contents of that file
+    will be used as the BODY in the callback function.
+
     Thus, to replace 'Jon' with 'John' in author/committer/tagger names:
       git filter-repo --name-callback 'return name.replace(b"Jon", b"John")'
 
@@ -1728,8 +1733,14 @@ class FilteringOptions(object):
     To remove all .DS_Store files:
       git filter-repo --filename-callback 'return None if os.path.basename(filename) == b".DS_Store" else filename'
 
-    Note that if BODY resolves to a filename, then the contents of that file
-    will be used as the BODY in the callback function.
+    You can also use the --callbacks option to define several callback
+    functions at once:
+
+      git filter-repo --callbacks my_callbacks.py
+
+    my_callbacks.py will be parsed as a Python module.  It should
+    define functions with names like 'foo_callback', corresponding to
+    the various --foo-callback options.
 
     For more detailed examples and explanations AND caveats, see
       https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html#CALLBACKS
@@ -1983,6 +1994,10 @@ EXAMPLES
         help=_("Python code body for processing reset objects; see "
                "CALLBACKS section below."))
 
+    callback.add_argument('--callbacks', metavar="FILE",
+        help=_("File defining callback functions, to be loaded as a "
+               "Python module; see CALLBACKS section below."))
+
     desc = _(
       "Specifying alternate source or target locations implies --partial,\n"
       "except that the normal default for --replace-refs is used.  However,\n"
@@ -2259,6 +2274,104 @@ EXAMPLES
       args.refs = ['--all']
     return args
 
+class Callbacks(object):
+  ''' A set of callback functions; handles fabricating such functions
+      from the command line arguments. '''
+
+  TYPES = [
+    'blob', 'commit', 'tag', 'reset', 'done',
+    'filename', 'message', 'name', 'email', 'refname'
+  ]
+
+  @staticmethod
+  def load_callbacks_module(fname):
+    ''' Load FNAME as a module object; returns that module object. '''
+    # Make "import git_filter_repo" work inside the file we're loading,
+    # whether or not git_filter_repo.py has been installed.
+    if 'git_filter_repo' not in sys.modules:
+      sys.modules['git_filter_repo'] = sys.modules[__name__]
+
+    # this recipe almost verbatim from
+    # https://docs.python.org/3.9/library/importlib.html#importing-a-source-file-directly
+    # (documented to work in 3.5 and later)
+    from importlib import util
+    spec = util.spec_from_file_location('git_filter_repo.callbacks', fname)
+    module = util.module_from_spec(spec)
+    sys.modules['git_filter_repo.callbacks'] = module
+    spec.loader.exec_module(module)
+
+    return module
+
+  @staticmethod
+  def parse_single_callback(cb_type, cb_name, fname_or_body):
+    try:
+      with open(fname_or_body, "rt") as fp:
+        body = fp.read()
+    except OSError as e:
+      # There is no dedicated OSError subclass for "name too long".
+      if e.errno in (errno.ENOENT, errno.ENAMETOOLONG):
+        body = fname_or_body
+      else:
+        raise
+
+    if 'return ' not in body and cb_type not in ('blob', 'commit',
+                                                 'tag', 'reset'):
+      raise SystemExit(
+        _("Error: --%s-callback should have a return statement") % cb_type
+      )
+
+    def_stmt = (
+      'def {name}({argname}, _do_not_use_this_var = None):\n'
+      .format(name=cb_name, argname=cb_type)
+      + '  '
+      + '\n  '.join(body.splitlines())
+    )
+    callback_globals = {g: globals()[g] for g in public_globals}
+    callback_locals = {}
+    exec(def_stmt, callback_globals, callback_locals)
+    return callback_locals[cb_name]
+
+  @staticmethod
+  def make_callback(cb_type, cb_name, mod, fname_or_body):
+    cb = None
+
+    if mod is not None:
+      cb = getattr(mod, cb_name, None)
+      if cb is not None:
+        if not callable(cb):
+          raise SystemExit(_("Error: %s is not callable") % cb_name)
+        # the second argument to blob, commit, tag, and reset filters is
+        # not documented as part of the command line callbacks API; allow
+        # people using --callbacks to define callbacks with only one argument
+        sig = inspect.signature(cb)
+        if len(sig.parameters) == 1:
+          real_cb = cb
+          def wrapper(obj, _unused = None):
+            return real_cb(obj)
+          cb = wrapper
+
+    if fname_or_body is not None:
+      if cb is not None:
+        raise SystemExit(_(
+          "Error: Cannot define %s_callback in --callbacks module and also"
+          " use --%s-callback"
+        ) % (cb_type, cb_type))
+      cb = Callbacks.parse_single_callback(cb_type, cb_name, fname_or_body)
+
+    return cb
+
+  def __init__(self, args):
+    if args.callbacks is None:
+      mod = None
+    else:
+      mod = Callbacks.load_callbacks_module(args.callbacks)
+
+    for cb_type in Callbacks.TYPES:
+      cb_name = cb_type + '_callback'
+      setattr(self, cb_type, Callbacks.make_callback(
+        cb_type, cb_name, mod, getattr(args, cb_name, None)
+      ))
+
 class RepoAnalyze(object):
 
   # First, several helper functions for analyze_commit()
@@ -2877,37 +2990,16 @@ class RepoFilter(object):
     self._full_hash_re = re.compile(br'(\b[0-9a-f]{40}\b)')
 
   def _handle_arg_callbacks(self):
-    def make_callback(argname, str):
-      callback_globals = {g: globals()[g] for g in public_globals}
-      callback_locals = {}
-      exec('def callback({}, _do_not_use_this_var = None):\n'.format(argname)+
-           '  '+'\n  '.join(str.splitlines()), callback_globals, callback_locals)
-      return callback_locals['callback']
-    def handle(type):
-      callback_field = '_{}_callback'.format(type)
-      code_string = getattr(self._args, type+'_callback')
-      if code_string:
-        if os.path.exists(code_string):
-          with open(code_string, 'r', encoding='utf-8') as f:
-            code_string = f.read()
-        if getattr(self, callback_field):
+    arg_callbacks = Callbacks(self._args)
+    for cb_type in Callbacks.TYPES:
+      callback_field = '_{}_callback'.format(cb_type)
+      arg_cb = getattr(arg_callbacks, cb_type)
+      if arg_cb is not None:
+        if getattr(self, callback_field) is not None:
           raise SystemExit(_("Error: Cannot pass a %s_callback to RepoFilter "
-                             "AND pass --%s-callback"
-                           % (type, type)))
-        if 'return ' not in code_string and \
-           type not in ('blob', 'commit', 'tag', 'reset'):
-          raise SystemExit(_("Error: --%s-callback should have a return statement")
-                           % type)
-        setattr(self, callback_field, make_callback(type, code_string))
-    handle('filename')
-    handle('message')
-    handle('name')
-    handle('email')
-    handle('refname')
-    handle('blob')
-    handle('commit')
-    handle('tag')
-    handle('reset')
+                             "AND define it on the command line"
+                             % cb_type))
+        setattr(self, callback_field, arg_cb)
 
   def _run_sanity_checks(self):
     self._sanity_checks_handled = True
diff --git a/t/t9391-filter-repo-lib-usage.sh b/t/t9391-filter-repo-lib-usage.sh
index 3a86961..daf1d57 100755
--- a/t/t9391-filter-repo-lib-usage.sh
+++ b/t/t9391-filter-repo-lib-usage.sh
@@ -157,7 +157,7 @@ test_expect_success 'erroneous.py' '
 		cd erroneous &&
 		test_must_fail $TEST_DIRECTORY/t9391/erroneous.py 2>../err &&
 
-		test_i18ngrep "Error: Cannot pass a tag_callback to RepoFilter AND pass --tag-callback" ../err
+		test_i18ngrep "Error: Cannot pass a tag_callback to RepoFilter AND define it" ../err
 	)
 '
 
diff --git a/t/t9392-python-callback.sh b/t/t9392-python-callback.sh
index cb36292..cafb9cf 100755
--- a/t/t9392-python-callback.sh
+++ b/t/t9392-python-callback.sh
@@ -181,7 +181,7 @@ test_expect_success 'callback has return statement sanity check' '
 	)
 '
 
-test_expect_success 'Callback read from a file' '
+test_expect_success 'callback read from a file' '
 	setup name-callback-from-file &&
 	(
 		cd name-callback-from-file &&
@@ -192,5 +192,60 @@ test_expect_success 'Callback read from a file' '
 	)
 '
 
+test_expect_success 'callback defined in a module' '
+	setup name-callback-from-module &&
+	(
+		cd name-callback-from-module &&
+		cat >> ../callbacks.py <<\EOF &&
+def name_callback(name):
+    return name.replace(b"N.", b"And")
+EOF
+		git filter-repo --callbacks ../callbacks.py &&
+		git log --format=%an >log-person-names &&
+		grep Copy.And.Paste log-person-names
+	)
+'
+
+test_expect_success 'friendly error when module callbacks are not callable' '
+	setup bad-callback-friendly-error &&
+	(
+		cd bad-callback-friendly-error &&
+		cat >> ../bad-callbacks.py <<\EOF &&
+name_callback = "not a callable"
+EOF
+		test_must_fail git filter-repo --callbacks ../bad-callbacks.py 2>../err &&
+		test_i18ngrep "Error: name_callback is not callable" ../err &&
+		rm ../err
+	)
+'
+
+test_expect_success 'module/cmdline callback collision' '
+	setup mod-cmdline-callback-collision &&
+	(
+		cd mod-cmdline-callback-collision &&
+		cat >> ../mccoll-callbacks.py <<\EOF &&
+def name_callback(name):
+    return name.replace(b"N.", b"And")
+EOF
+		cat >> ../mccoll-name-cb <<\EOF &&
+return name.replace(b"N.", b"And")
+EOF
+		test_must_fail git filter-repo --callbacks ../mccoll-callbacks.py --name-callback ../mccoll-name-cb 2>../err &&
+		test_i18ngrep "Error: Cannot define name_callback in --callbacks module and also use --name-callback" ../err &&
+		rm ../err
+	)
+'
+
+test_expect_success 'module callbacks can import git_filter_repo' '
+	setup mod-callbacks-can-import &&
+	(
+		cd mod-callbacks-can-import &&
+		cat >> ../import-test-callbacks.py <<\EOF &&
+import git_filter_repo
+EOF
+		git filter-repo --callbacks ../import-test-callbacks.py
+	)
+'
+
 
 test_done
-- 
2.44.2

