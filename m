Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F430C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiDMG1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiDMG0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 02:26:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967374BFFC
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 23:24:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r13so1076612wrr.9
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MxkSSU8BasrBcFD28Ey+sBQFASIRKB7qQyMTAyhgMEI=;
        b=INrsmig7WisP6+PTdmlh7eL5la1JsNKwIU9iacIZTQEmsQ8Y9umi7plQ+GJVdAFJhy
         9/AFW2wEW0CgDECpttFiSesQNJMaxhzwYNaDYMqR2+3QY2+14hvZPj5B0YAUYGzNfb3e
         qNKsV58T/RZD8mha/QB16iBcPc2ZPqIMM6GzJfbzIOStC7jNXNpHrUFrGj2xcp6vaKGd
         wt7/RAr82o4r83MGR3r/HPtM0JTvWfLNOlFk+G2Vn7Bcr6ehldwvOoJvG5I0Q3JTkbxI
         iiZEIkrYSfJQz95a7+Zv8h9MntsZKRwsEHJr6/XTqC3UIvLxf3I8H1CwIQN8SRmNI9X6
         VEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MxkSSU8BasrBcFD28Ey+sBQFASIRKB7qQyMTAyhgMEI=;
        b=eZ33vY0rey7dVdE1dmhbsSwRTppqiJI8QkAgEKo9xfbkXNBHCsjPx4tZts93xvFaJi
         z8n2Z25UbJ7cEdsJe/AB/IlgNZ4bTPL6g/BX5Te4XKs0p5B4Fq7XB76awDauR/ywQjtw
         dy7y/ayPUrp/Gtmqf6iHH1NxnW78JwkFyTMkT331FAuAeWaqwqBIgtVj4srazr9iNEim
         MQtiR7NxFs7epgRRiBOHPhB8AHgrOWxHNZS8/6QXTnms0aNEhE2CKk5y4iOrJPJnsWQx
         mz30SCQrJA5JI52qXj0Zrt0WEx6qQzfKZ+GQCUTxy7GW4Gk/sEjdz7CcPorE489UGXeE
         KnHQ==
X-Gm-Message-State: AOAM533oq5K2we311c78p+7dckf6JFyc/kWWpQvhZHWa/asLzeDsXWUH
        153Gh7nLKW5GvT5XjYYDlQo0czU6D20=
X-Google-Smtp-Source: ABdhPJywxDo/KFGLGCrNFwcPOe/egs7EBepaDuJ1MagT1gL03IFErfbcV75o97IuYVS7TLj5b2uF9w==
X-Received: by 2002:a05:6000:1a85:b0:205:a234:d0a5 with SMTP id f5-20020a0560001a8500b00205a234d0a5mr32040351wry.126.1649831071193;
        Tue, 12 Apr 2022 23:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm1570881wmp.44.2022.04.12.23.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:24:30 -0700 (PDT)
Message-Id: <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com>
In-Reply-To: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 06:24:29 +0000
Subject: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

git-p4 is designed to run correctly under python2.7 and python3, but
its functional behavior wrt importing user-entered text differs across
these environments:

Under python2, git-p4 "naively" writes the Perforce bytestream into git
metadata (and does not set an "encoding" header on the commits); this
means that any non-utf-8 byte sequences end up creating invalidly-encoded
commit metadata in git.

Under python3, git-p4 attempts to decode the Perforce bytestream as utf-8
data, and fails badly (with an unhelpful error) when non-utf-8 data is
encountered.

Perforce clients (especially p4v) encourage user entry of changelist
descriptions (and user full names) in OS-local encoding, and store the
resulting bytestream to the server unmodified - such that different
clients can end up creating mutually-unintelligible messages. The most
common inconsistency, in many Perforce environments, is likely to be utf-8
(typical in linux) vs cp-1252 (typical in windows).

Make the changelist-description- and user-fullname-handling code
python-runtime-agnostic, introducing three "strategies" selectable via
config:
- 'legacy', behaving as previously under python2,
- 'strict', behaving as previously under python3, and
- 'fallback', favoring utf-8 but supporting a secondary encoding when
utf-8 decoding fails, and finally replacing remaining unmappable bytes.

Keep the python2 default behavior as-is ('legacy' strategy), but switch
the python3 default strategy to 'fallback' with fallback encoding
'cp1252'.

Also include tests exercising these encoding strategies, documentation for
the new config, and improve the user-facing error messages when decoding
does fail.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: Git p4 encoding strategy
    
    OPEN QUESTIONS:
    
     * Does it make sense to make "fallback" the default decoding strategy
       in python3? This is definitely a change in behavior, but I believe
       for the better; failing with "we defaulted to strict, but you can run
       again with this other option if you want it to work" seems unkind,
       only making sense if we thought fallback to cp1252 would be wrong in
       a substantial proportion of cases...
     * Is it OK to duplicate the bulk of the testing code across
       t9835-git-p4-metadata-encoding-python2.sh and
       t9836-git-p4-metadata-encoding-python3.sh?
     * Is it OK to explicitly call "git-p4.py" in tests, rather than the
       build output "git-p4", in order to be able to select the python
       runtime on a per-test basis? Is there a better approach?
     * Is the naming of the strategies appropriate? Should the default
       python2 strategy be called something less opinionated, like
       "passthrough"?
    
    Changes wrt v1:
    
     * Added "and replace any remaining unmappable bytes" behavior to the
       "fallback" strategy; common reasonable encodings like cp1252 still
       contain unmapped codepoints, and if those are found, there is really
       nothing that can be done about it other than ignoring the crazy
       bytes; this approach is consistent with the longstanding
       path-encoding-handling strategy.
     * Simplified error-handling accordingly
     * Cleaned up tests & commit messages slightly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1206%2FTaoK%2Fgit-p4-encoding-strategy-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1206/TaoK/git-p4-encoding-strategy-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1206

Range-diff vs v1:

 1:  9d33aa125b0 ! 1:  6d227ad57ea [RFC] git-p4: improve encoding handling to support inconsistent encodings
     @@ Commit message
          Under python2, git-p4 "naively" writes the Perforce bytestream into git
          metadata (and does not set an "encoding" header on the commits); this
          means that any non-utf-8 byte sequences end up creating invalidly-encoded
     -    data in git.
     +    commit metadata in git.
      
          Under python3, git-p4 attempts to decode the Perforce bytestream as utf-8
          data, and fails badly (with an unhelpful error) when non-utf-8 data is
          encountered.
      
     -    Perforce clients (esp. p4v) encourage user entry of changelist
     +    Perforce clients (especially p4v) encourage user entry of changelist
          descriptions (and user full names) in OS-local encoding, and store the
          resulting bytestream to the server unmodified - such that different
          clients can end up creating mutually-unintelligible messages. The most
     @@ Commit message
          - 'legacy', behaving as previously under python2,
          - 'strict', behaving as previously under python3, and
          - 'fallback', favoring utf-8 but supporting a secondary encoding when
     -    utf-8 decoding fails.
     +    utf-8 decoding fails, and finally replacing remaining unmappable bytes.
      
          Keep the python2 default behavior as-is ('legacy' strategy), but switch
          the python3 default strategy to 'fallback' with fallback encoding
     @@ Documentation/git-p4.txt: git-p4.pathEncoding::
      +	encoded as utf-8, and fails to import when this is not true.
      +	'fallback' attempts to interpret the data as utf-8, and otherwise
      +	falls back to using a secondary encoding - by default the common
     -+	windows encoding 'cp-1252'.
     ++	windows encoding 'cp-1252' - with any remaining unparseable bytes
     ++	replaced with a placeholder character.
      +	Under python2 the default strategy is 'legacy' for historical
      +	reasons, and under python3 the default is 'fallback'.
      +	When 'strict' is selected and decoding fails, the error message will
     @@ git-p4.py: else:
           def encode_text_stream(s):
               return s.encode('utf_8') if isinstance(s, unicode) else s
       
     ++
      +class MetadataDecodingException(Exception):
     -+    def __init__(self, input_string, fallback_encoding, fallback_error):
     ++    def __init__(self, input_string):
      +        self.input_string = input_string
     -+        self.fallback_encoding = fallback_encoding
     -+        self.fallback_error = fallback_error
      +
      +    def __str__(self):
     -+        error_message = """Decoding returned data failed!
     ++        return """Decoding perforce metadata failed!
      +The failing string was:
      +---
      +{}
     -+---""".format(self.input_string)
     -+
     -+        if not self.fallback_error:
     -+            error_message += """
     ++---
      +Consider setting the git-p4.metadataDecodingStrategy config option to
      +'fallback', to allow metadata to be decoded using a fallback encoding,
     -+defaulting to cp1252."""
     -+        else:
     -+            error_message += """
     -+The conversion failed while using the fallback encoding '{}';
     -+consider using a more forgiving one. Conversion error text:
     -+{}
     -+""".format(self.fallback_encoding, self.fallback_error)
     ++defaulting to cp1252.""".format(self.input_string)
      +
     -+        return error_message
      +
      +def metadata_stream_to_writable_bytes(s):
      +    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or defaultMetadataDecodingStrategy
     @@ git-p4.py: else:
      +        s.decode('utf_8')
      +        return s
      +    except UnicodeDecodeError:
     -+        fallback_error = None
      +        if encodingStrategy == 'fallback' and fallbackEncoding:
     -+            try:
     -+                return s.decode(fallbackEncoding).encode('utf_8')
     -+            except Exception as e:
     -+                fallback_error = e
     -+        raise MetadataDecodingException(s, fallbackEncoding, fallback_error)
     ++            return s.decode(fallbackEncoding, errors='replace').encode('utf_8')
     ++        raise MetadataDecodingException(s)
      +
       def decode_path(path):
           """Decode a given string (bytes or otherwise) using configured path encoding options
     @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
      +## SECTION REPEATED IN t9836 ##
      +###############################
      +
     -+# HORRIBLE HACK TO ENSURE PYTHON VERSION!
     -+# Weirdnesses:
     -+#  - Looking for python2 and python3 in a very specific path (/usr/bin/)
     -+#  - Code is inelegant
     -+#  - Code is duplicated (like most of this test script)
     -+#  - Test calls "git-p4.py" rather than "git-p4", because the latter references a specific path
     ++# Please note: this test calls "git-p4.py" rather than "git-p4", because the
     ++# latter references a specific path so we can't easily force it to run under
     ++# the python version we need to.
      +
      +python_major_version=$(python -V 2>&1 | cut -c  8)
     -+python_target_exists=$(/usr/bin/python$python_target_version -V 2>&1)
     -+if ! test "$python_major_version" = "$python_target_version" && test "$python_target_exists"
     ++python_target_binary=$(which python$python_target_version)
     ++if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
      +then
      +	mkdir temp_python
      +	PATH="$(pwd)/temp_python:$PATH" && export PATH
     -+	ln -s /usr/bin/python$python_target_version temp_python/python
     ++	ln -s $python_target_binary temp_python/python
      +fi
      +
      +python_major_version=$(python -V 2>&1 | cut -c  8)
     @@ t/t9835-git-p4-metadata-encoding-python2.sh (new)
      +	test_when_finished cleanup_git &&
      +	test_when_finished remove_user_cache &&
      +	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
     -+	grep "Decoding returned data failed!" err
     ++	grep "Decoding perforce metadata failed!" err
      +'
      +
      +test_expect_success 'check utf-8 contents with legacy strategy' '
     @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
      +## SECTION REPEATED IN t9835 ##
      +###############################
      +
     -+# HORRIBLE HACK TO ENSURE PYTHON VERSION!
     -+# Weirdnesses:
     -+#  - Looking for python2 and python3 in a very specific path (/usr/bin/)
     -+#  - Code is inelegant
     -+#  - Code is duplicated (like most of this test script)
     -+#  - Test calls "git-p4.py" rather than "git-p4", because the latter references a specific path
     ++# Please note: this test calls "git-p4.py" rather than "git-p4", because the
     ++# latter references a specific path so we can't easily force it to run under
     ++# the python version we need to.
      +
      +python_major_version=$(python -V 2>&1 | cut -c  8)
     -+python_target_exists=$(/usr/bin/python$python_target_version -V 2>&1)
     -+if ! test "$python_major_version" = "$python_target_version" && test "$python_target_exists"
     ++python_target_binary=$(which python$python_target_version)
     ++if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
      +then
      +	mkdir temp_python
      +	PATH="$(pwd)/temp_python:$PATH" && export PATH
     -+	ln -s /usr/bin/python$python_target_version temp_python/python
     ++	ln -s $python_target_binary temp_python/python
      +fi
      +
      +python_major_version=$(python -V 2>&1 | cut -c  8)
     @@ t/t9836-git-p4-metadata-encoding-python3.sh (new)
      +	test_when_finished cleanup_git &&
      +	test_when_finished remove_user_cache &&
      +	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
     -+	grep "Decoding returned data failed!" err
     ++	grep "Decoding perforce metadata failed!" err
      +'
      +
      +test_expect_success 'check utf-8 contents with legacy strategy' '


 Documentation/git-p4.txt                    |  37 +++-
 git-p4.py                                   |  89 ++++++++--
 t/lib-git-p4.sh                             |   3 +-
 t/t9835-git-p4-metadata-encoding-python2.sh | 182 +++++++++++++++++++
 t/t9836-git-p4-metadata-encoding-python3.sh | 183 ++++++++++++++++++++
 5 files changed, 476 insertions(+), 18 deletions(-)
 create mode 100755 t/t9835-git-p4-metadata-encoding-python2.sh
 create mode 100755 t/t9836-git-p4-metadata-encoding-python3.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e21fcd8f712..e21bc6a5e37 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -636,7 +636,42 @@ git-p4.pathEncoding::
 	Git expects paths encoded as UTF-8. Use this config to tell git-p4
 	what encoding Perforce had used for the paths. This encoding is used
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
-	often uses "cp1252" to encode path names.
+	often uses "cp1252" to encode path names. If this option is passed
+	into a p4 clone request, it is persisted in the resulting new git
+	repo.
+
+git-p4.metadataDecodingStrategy::
+	Perforce keeps the encoding of a changelist descriptions and user
+	full names as stored by the client on a given OS. The p4v client
+	uses the OS-local encosing, and so different users can end up storing
+	different changelist descriptions or user full names in different
+	encodings, in the same depot.
+	Git tolerates inconsistent/incorrect encodings in commit messages
+	and author names, but expects them to be specified in utf-8.
+	git-p4 can use three different decoding strategies in handling the
+	encoding uncertainty in Perforce: 'legacy' simply passes the original
+	bytes through from Perforce to git, creating usable but
+	incorrectly-encoded data when the Perforce data is encoded as
+	anything other than utf-8. 'strict' expects the Perforce data to be
+	encoded as utf-8, and fails to import when this is not true.
+	'fallback' attempts to interpret the data as utf-8, and otherwise
+	falls back to using a secondary encoding - by default the common
+	windows encoding 'cp-1252' - with any remaining unparseable bytes
+	replaced with a placeholder character.
+	Under python2 the default strategy is 'legacy' for historical
+	reasons, and under python3 the default is 'fallback'.
+	When 'strict' is selected and decoding fails, the error message will
+	propose changing this config parameter as a workaround. If this
+	option is passed into a p4 clone request, it is persisted into the
+	resulting new git repo.
+
+git-p4.metadataFallbackEncoding::
+	Specify the fallback encoding to use when decoding Perforce author
+	names and changelists descriptions using the 'fallback' strategy
+	(see git-p4.metadataDecodingStrategy). The fallback encoding will
+	only be used when decoding as utf-8 fails. This option defaults to
+	cp1252, a common windows encoding. If this option is passed into a
+	p4 clone request, it is persisted into the resulting new git repo.
 
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
diff --git a/git-p4.py b/git-p4.py
index a9b1f904410..c5e74aaa515 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -54,6 +54,9 @@ defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 # The block size is reduced automatically if required
 defaultBlockSize = 1<<20
 
+defaultMetadataDecodingStrategy = 'legacy' if sys.version_info.major == 2 else 'fallback'
+defaultFallbackMetadataEncoding = 'cp1252'
+
 p4_access_checked = False
 
 re_ko_keywords = re.compile(br'\$(Id|Header)(:[^$\n]+)?\$')
@@ -203,6 +206,37 @@ else:
     def encode_text_stream(s):
         return s.encode('utf_8') if isinstance(s, unicode) else s
 
+
+class MetadataDecodingException(Exception):
+    def __init__(self, input_string):
+        self.input_string = input_string
+
+    def __str__(self):
+        return """Decoding perforce metadata failed!
+The failing string was:
+---
+{}
+---
+Consider setting the git-p4.metadataDecodingStrategy config option to
+'fallback', to allow metadata to be decoded using a fallback encoding,
+defaulting to cp1252.""".format(self.input_string)
+
+
+def metadata_stream_to_writable_bytes(s):
+    encodingStrategy = gitConfig('git-p4.metadataDecodingStrategy') or defaultMetadataDecodingStrategy
+    fallbackEncoding = gitConfig('git-p4.metadataFallbackEncoding') or defaultFallbackMetadataEncoding
+    if not isinstance(s, bytes):
+        return s.encode('utf_8')
+    if encodingStrategy == 'legacy':
+        return s
+    try:
+        s.decode('utf_8')
+        return s
+    except UnicodeDecodeError:
+        if encodingStrategy == 'fallback' and fallbackEncoding:
+            return s.decode(fallbackEncoding, errors='replace').encode('utf_8')
+        raise MetadataDecodingException(s)
+
 def decode_path(path):
     """Decode a given string (bytes or otherwise) using configured path encoding options
     """
@@ -702,11 +736,12 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if bytes is not str:
                 # Decode unmarshalled dict to use str keys and values, except for:
                 #   - `data` which may contain arbitrary binary data
-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text
+                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
+                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -716,6 +751,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
+            if 'desc' in entry:
+                entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
+            if 'FullName' in entry:
+                entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
             if cb is not None:
                 cb(entry)
             else:
@@ -1435,7 +1474,13 @@ class P4UserMap:
         for output in p4CmdList(["users"]):
             if "User" not in output:
                 continue
-            self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
+            # "FullName" is bytes. "Email" on the other hand might be bytes
+            # or unicode string depending on whether we are running under
+            # python2 or python3. To support
+            # git-p4.metadataDecodingStrategy=legacy, self.users dict values
+            # are always bytes, ready to be written to git.
+            emailbytes = metadata_stream_to_writable_bytes(output["Email"])
+            self.users[output["User"]] = output["FullName"] + b" <" + emailbytes + b">"
             self.emails[output["Email"]] = output["User"]
 
         mapUserConfigRegex = re.compile(r"^\s*(\S+)\s*=\s*(.+)\s*<(\S+)>\s*$", re.VERBOSE)
@@ -1445,26 +1490,28 @@ class P4UserMap:
                 user = mapUser[0][0]
                 fullname = mapUser[0][1]
                 email = mapUser[0][2]
-                self.users[user] = fullname + " <" + email + ">"
+                fulluser = fullname + " <" + email + ">"
+                self.users[user] = metadata_stream_to_writable_bytes(fulluser)
                 self.emails[email] = user
 
-        s = ''
+        s = b''
         for (key, val) in self.users.items():
-            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
+            keybytes = metadata_stream_to_writable_bytes(key)
+            s += b"%s\t%s\n" % (keybytes.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), 'w').write(s)
+        open(self.getUserCacheFilename(), 'wb').write(s)
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
         self.users = {}
         self.userMapFromPerforceServer = False
         try:
-            cache = open(self.getUserCacheFilename(), 'r')
+            cache = open(self.getUserCacheFilename(), 'rb')
             lines = cache.readlines()
             cache.close()
             for line in lines:
-                entry = line.strip().split("\t")
-                self.users[entry[0]] = entry[1]
+                entry = line.strip().split(b"\t")
+                self.users[entry[0].decode('utf_8')] = entry[1]
         except IOError:
             self.getUserMapFromPerforceServer()
 
@@ -3020,7 +3067,8 @@ class P4Sync(Command, P4UserMap):
         if userid in self.users:
             return self.users[userid]
         else:
-            return "%s <a@b>" % userid
+            userid_bytes = metadata_stream_to_writable_bytes(userid)
+            return b"%s <a@b>" % userid_bytes
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         """ Stream a p4 tag.
@@ -3043,9 +3091,10 @@ class P4Sync(Command, P4UserMap):
             email = self.make_email(owner)
         else:
             email = self.make_email(self.p4UserId())
-        tagger = "%s %s %s" % (email, epoch, self.tz)
 
-        gitStream.write("tagger %s\n" % tagger)
+        gitStream.write("tagger ")
+        gitStream.write(email)
+        gitStream.write(" %s %s\n" % (epoch, self.tz))
 
         print("labelDetails=",labelDetails)
         if 'Description' in labelDetails:
@@ -3138,12 +3187,12 @@ class P4Sync(Command, P4UserMap):
         self.gitStream.write("commit %s\n" % branch)
         self.gitStream.write("mark :%s\n" % details["change"])
         self.committedChanges.add(int(details["change"]))
-        committer = ""
         if author not in self.users:
             self.getUserMapFromPerforceServer()
-        committer = "%s %s %s" % (self.make_email(author), epoch, self.tz)
 
-        self.gitStream.write("committer %s\n" % committer)
+        self.gitStream.write("committer ")
+        self.gitStream.write(self.make_email(author))
+        self.gitStream.write(" %s %s\n" % (epoch, self.tz))
 
         self.gitStream.write("data <<EOT\n")
         self.gitStream.write(details["desc"])
@@ -4055,6 +4104,14 @@ class P4Clone(P4Sync):
         if self.useClientSpec_from_options:
             system(["git", "config", "--bool", "git-p4.useclientspec", "true"])
 
+        # persist any git-p4 encoding-handling config options passed in for clone:
+        if gitConfig('git-p4.metadataDecodingStrategy'):
+            system(["git", "config", "git-p4.metadataDecodingStrategy", gitConfig('git-p4.metadataDecodingStrategy')])
+        if gitConfig('git-p4.metadataFallbackEncoding'):
+            system(["git", "config", "git-p4.metadataFallbackEncoding", gitConfig('git-p4.metadataFallbackEncoding')])
+        if gitConfig('git-p4.pathEncoding'):
+            system(["git", "config", "git-p4.pathEncoding", gitConfig('git-p4.pathEncoding')])
+
         return True
 
 class P4Unshelve(Command):
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 5aff2abe8b5..2a5b8738ea3 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -142,10 +142,11 @@ start_p4d () {
 
 p4_add_user () {
 	name=$1 &&
+	fullname="${2:-Dr. $1}"
 	p4 user -f -i <<-EOF
 	User: $name
 	Email: $name@example.com
-	FullName: Dr. $name
+	FullName: $fullname
 	EOF
 }
 
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
new file mode 100755
index 00000000000..724eaee9cf4
--- /dev/null
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -0,0 +1,182 @@
+#!/bin/sh
+
+test_description='git p4 metadata encoding
+
+This test checks that the import process handles inconsistent text
+encoding in p4 metadata (author names, commit messages, etc) without
+failing, and produces maximally sane output in git.'
+
+. ./lib-git-p4.sh
+
+python_target_version='2'
+
+###############################
+## SECTION REPEATED IN t9836 ##
+###############################
+
+# Please note: this test calls "git-p4.py" rather than "git-p4", because the
+# latter references a specific path so we can't easily force it to run under
+# the python version we need to.
+
+python_major_version=$(python -V 2>&1 | cut -c  8)
+python_target_binary=$(which python$python_target_version)
+if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
+then
+	mkdir temp_python
+	PATH="$(pwd)/temp_python:$PATH" && export PATH
+	ln -s $python_target_binary temp_python/python
+fi
+
+python_major_version=$(python -V 2>&1 | cut -c  8)
+if ! test "$python_major_version" = "$python_target_version"
+then
+	skip_all="skipping python$python_target_version-specific git p4 tests; python$python_target_version not available"
+	test_done
+fi
+
+remove_user_cache () {
+	rm "$HOME/.gitp4-usercache.txt" || true
+}
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+
+		p4_add_user "utf8_author" "ǣuthor" &&
+		P4USER=utf8_author &&
+		touch file1 &&
+		p4 add file1 &&
+		p4 submit -d "first CL has some utf-8 tǣxt" &&
+
+		p4_add_user "latin1_author" "$(echo æuthor |
+			iconv -f utf8 -t latin1)" &&
+		P4USER=latin1_author &&
+		touch file2 &&
+		p4 add file2 &&
+		p4 submit -d "$(echo second CL has some latin-1 tæxt |
+			iconv -f utf8 -t latin1)" &&
+
+		p4_add_user "cp1252_author" "$(echo æuthœr |
+			iconv -f utf8 -t cp1252)" &&
+		P4USER=cp1252_author &&
+		touch file3 &&
+		p4 add file3 &&
+		p4 submit -d "$(echo third CL has sœme cp-1252 tæxt |
+		  iconv -f utf8 -t cp1252)"
+	)
+'
+
+test_expect_success 'clone non-utf8 repo with strict encoding' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
+	grep "Decoding perforce metadata failed!" err
+'
+
+test_expect_success 'check utf-8 contents with legacy strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=legacy p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some utf-8 tǣxt" actual &&
+		grep "ǣuthor" actual
+	)
+'
+
+test_expect_success 'check latin-1 contents corrupted in git with legacy strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=legacy p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
+		grep "$badly_encoded_in_git" actual &&
+		bad_author_in_git="$(echo æuthor | iconv -f utf8 -t latin1)" &&
+		grep "$bad_author_in_git" actual
+	)
+'
+
+test_expect_success 'check utf-8 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some utf-8 tǣxt" actual &&
+		grep "ǣuthor" actual
+	)
+'
+
+test_expect_success 'check latin-1 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some latin-1 tæxt" actual &&
+		grep "æuthor" actual
+	)
+'
+
+test_expect_success 'check cp-1252 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "sœme cp-1252 tæxt" actual &&
+		grep "æuthœr" actual
+	)
+'
+
+test_expect_success 'check cp-1252 contents on later sync after clone with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$cli" &&
+		P4USER=cp1252_author &&
+		touch file4 &&
+		p4 add file4 &&
+		p4 submit -d "$(echo fourth CL has sœme more cp-1252 tæxt |
+			iconv -f utf8 -t cp1252)"
+	) &&
+	(
+		cd "$git" &&
+
+		git p4.py sync --branch=master &&
+
+		git log p4/master >actual &&
+		cat actual &&
+		grep "sœme more cp-1252 tæxt" actual &&
+		grep "æuthœr" actual
+	)
+'
+
+############################
+## / END REPEATED SECTION ##
+############################
+
+test_expect_success 'legacy (latin-1 contents corrupted in git) is the default with python2' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=legacy p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
+		grep "$badly_encoded_in_git" actual
+	)
+'
+
+test_done
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
new file mode 100755
index 00000000000..6c8e8cce5f1
--- /dev/null
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -0,0 +1,183 @@
+#!/bin/sh
+
+test_description='git p4 metadata encoding
+
+This test checks that the import process handles inconsistent text
+encoding in p4 metadata (author names, commit messages, etc) without
+failing, and produces maximally sane output in git.'
+
+. ./lib-git-p4.sh
+
+python_target_version='3'
+
+###############################
+## SECTION REPEATED IN t9835 ##
+###############################
+
+# Please note: this test calls "git-p4.py" rather than "git-p4", because the
+# latter references a specific path so we can't easily force it to run under
+# the python version we need to.
+
+python_major_version=$(python -V 2>&1 | cut -c  8)
+python_target_binary=$(which python$python_target_version)
+if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
+then
+	mkdir temp_python
+	PATH="$(pwd)/temp_python:$PATH" && export PATH
+	ln -s $python_target_binary temp_python/python
+fi
+
+python_major_version=$(python -V 2>&1 | cut -c  8)
+if ! test "$python_major_version" = "$python_target_version"
+then
+	skip_all="skipping python$python_target_version-specific git p4 tests; python$python_target_version not available"
+	test_done
+fi
+
+remove_user_cache () {
+	rm "$HOME/.gitp4-usercache.txt" || true
+}
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+
+		p4_add_user "utf8_author" "ǣuthor" &&
+		P4USER=utf8_author &&
+		touch file1 &&
+		p4 add file1 &&
+		p4 submit -d "first CL has some utf-8 tǣxt" &&
+
+		p4_add_user "latin1_author" "$(echo æuthor |
+			iconv -f utf8 -t latin1)" &&
+		P4USER=latin1_author &&
+		touch file2 &&
+		p4 add file2 &&
+		p4 submit -d "$(echo second CL has some latin-1 tæxt |
+			iconv -f utf8 -t latin1)" &&
+
+		p4_add_user "cp1252_author" "$(echo æuthœr |
+			iconv -f utf8 -t cp1252)" &&
+		P4USER=cp1252_author &&
+		touch file3 &&
+		p4 add file3 &&
+		p4 submit -d "$(echo third CL has sœme cp-1252 tæxt |
+		  iconv -f utf8 -t cp1252)"
+	)
+'
+
+test_expect_success 'clone non-utf8 repo with strict encoding' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	test_must_fail git -c git-p4.metadataDecodingStrategy=strict p4.py clone --dest="$git" //depot@all 2>err &&
+	grep "Decoding perforce metadata failed!" err
+'
+
+test_expect_success 'check utf-8 contents with legacy strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=legacy p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some utf-8 tǣxt" actual &&
+		grep "ǣuthor" actual
+	)
+'
+
+test_expect_success 'check latin-1 contents corrupted in git with legacy strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=legacy p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		badly_encoded_in_git=$(echo "some latin-1 tæxt" | iconv -f utf8 -t latin1) &&
+		grep "$badly_encoded_in_git" actual &&
+		bad_author_in_git="$(echo æuthor | iconv -f utf8 -t latin1)" &&
+		grep "$bad_author_in_git" actual
+	)
+'
+
+test_expect_success 'check utf-8 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some utf-8 tǣxt" actual &&
+		grep "ǣuthor" actual
+	)
+'
+
+test_expect_success 'check latin-1 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "some latin-1 tæxt" actual &&
+		grep "æuthor" actual
+	)
+'
+
+test_expect_success 'check cp-1252 contents with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "sœme cp-1252 tæxt" actual &&
+		grep "æuthœr" actual
+	)
+'
+
+test_expect_success 'check cp-1252 contents on later sync after clone with fallback strategy' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git -c git-p4.metadataDecodingStrategy=fallback p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$cli" &&
+		P4USER=cp1252_author &&
+		touch file4 &&
+		p4 add file4 &&
+		p4 submit -d "$(echo fourth CL has sœme more cp-1252 tæxt |
+			iconv -f utf8 -t cp1252)"
+	) &&
+	(
+		cd "$git" &&
+
+		git p4.py sync --branch=master &&
+
+		git log p4/master >actual &&
+		cat actual &&
+		grep "sœme more cp-1252 tæxt" actual &&
+		grep "æuthœr" actual
+	)
+'
+
+############################
+## / END REPEATED SECTION ##
+############################
+
+
+test_expect_success 'fallback (both utf-8 and cp-1252 contents handled) is the default with python3' '
+	test_when_finished cleanup_git &&
+	test_when_finished remove_user_cache &&
+	git p4.py clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		git log >actual &&
+		grep "sœme cp-1252 tæxt" actual &&
+		grep "æuthœr" actual
+	)
+'
+
+test_done

base-commit: 11cfe552610386954886543f5de87dcc49ad5735
-- 
gitgitgadget
