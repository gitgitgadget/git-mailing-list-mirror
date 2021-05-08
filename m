Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B52C43460
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57CF61432
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhEHGT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 02:19:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36039 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229713AbhEHGT1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 02:19:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 95F115C012F
        for <git@vger.kernel.org>; Sat,  8 May 2021 02:18:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 08 May 2021 02:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=from:to:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm3; bh=pWUapxD1rMkvFdD9bDr1sSkrT1dX7AqO1O/MOvo5lEE=; b=REe6F
        EX7yKhGs0AeJlO1nXbL0alC0BX3zZ6CTUfw/YtYLg7j+bADM1T7XIwDrzM+VolCz
        d3SYngktn7K9bXRW6YEqGvrx7VCze6UslrxOQul/IquXs76Voy1HdzupxpsN3tVb
        hsX5XNifCV+7jftwv7y3t6M1wtavp7bgsYB2L5ghfv8rZO5OVOZnXcTu+P7YqM3S
        sY/aIqfiYj9P+MTwymCnbHYD6f3cusx8VC3NvD3Tk+JuZcZ9z+2Gsgg8JHgp6+K1
        6mg8l8ZF87qrUzBfUn5xloUZE2OBpoas90x+q0CFaKlY1fS0Cf4aOv388zKeXfM4
        I3wJj9XSqDpnSL7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pWUapxD1rMkvFdD9bDr1sSkrT1dX7AqO1O/MOvo5lEE=; b=gV+VWTL9
        tX4/uf+HzRnaKyyz4zfCzqmMIxKmCrxUnSLxgJ5MO8vUZH/KVbP72wwq400U7PwX
        ZAK12zG5jmTiOc/PjmOPXgZ2uKYxFFprtnmU0bwE2OlmM48cghSvLfoDkqzoL2ru
        XHTWw0XmK2+e2ykITLyNdd/FR/f+7wWuQov+HKnqg6Nx9NYNAkHz+ijuvNSroNBc
        oL+rdgyu5wIqFXfgHivmk0U25D4D88bwHDpC0RrmO2MVUEx4u0BKJfYlJxT/fIpH
        GYuUfJq78jABLQay6dkeFeQLhEn0VKYJYB2lL7Yx5oK1FXqytgmfDt+/2y7avSBV
        3003Af0IXFSRWQ==
X-ME-Sender: <xms:Mi2WYPVW4-OAtGZtFxBT1zgUzLqLdILEuwA1oeSSNT-Lr3Ltu_orow>
    <xme:Mi2WYHlAvi8uiIfk7KEZmYrUW6y63YP6GuJrKROlwHHVMbyOIpnzk7SIX6fMFTawL
    ZVo8hbzTGfv6gys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrvhgv
    ucfjuhhsvggshicuoegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleelffffteevfeeutddvvddtfeehjeduudfggfefieevueet
    ffdvgfeuteefgeenucffohhmrghinhepohhpvghnphhgphdrihhspdhgihhthhhusgdrih
    honecukfhppeeikedrvddvgedrieekrdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrghmmhgvrhdroh
    hrgh
X-ME-Proxy: <xmx:Mi2WYLaB2pZThzeBJkOBpO7V7CkymfJqEs7NgnGzhCvQrHa2UL_KkA>
    <xmx:Mi2WYKUqPjjgt4l6rbthtZ-UK6oFjNgx07j7yUzWytNbPsinc4iEdg>
    <xmx:Mi2WYJkqKG-AsGp_12ya8PQ6Sh8SYvywIw3WpBOueR4OrrBIRmUOUg>
    <xmx:Mi2WYLm6fOAgWGHr892W_21qfnOm91YAj_oB3fmQqu61-GDWL88Gmg>
Received: from linuxprogrammer.org (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Sat,  8 May 2021 02:18:26 -0400 (EDT)
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Subject: [RFC PATCH v1 1/1] Modifies documentation for universal cryptographic signing
Date:   Fri,  7 May 2021 23:18:23 -0700
Message-Id: <c454bcc4c3c5de1a17c63461c6091689098c75b9.1620454449.git.dwh@linuxprogrammer.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1620454449.git.dwh@linuxprogrammer.org>
References: <cover.1620454449.git.dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>
---
 Documentation/config.txt                      |   2 +
 Documentation/config/commit.txt               |  23 +-
 Documentation/config/gpg.txt                  |  36 +--
 Documentation/config/push.txt                 |  18 +-
 Documentation/config/sign.txt                 |  72 ++++++
 Documentation/config/tag.txt                  |  27 +-
 Documentation/config/user.txt                 |  12 +-
 Documentation/git-am.txt                      |  43 +++-
 Documentation/git-cherry-pick.txt             |  43 +++-
 Documentation/git-commit-tree.txt             |  44 +++-
 Documentation/git-commit.txt                  |  43 +++-
 Documentation/git-fast-import.txt             |   2 +-
 Documentation/git-for-each-ref.txt            |   2 +-
 Documentation/git-mktag.txt                   |  32 ++-
 Documentation/git-rebase.txt                  |  44 +++-
 Documentation/git-revert.txt                  |  44 +++-
 Documentation/git-tag.txt                     | 102 +++++---
 Documentation/git-verify-commit.txt           |   8 +-
 Documentation/git-verify-tag.txt              |   8 +-
 Documentation/merge-options.txt               |  40 ++-
 Documentation/pretty-formats.txt              |   2 +-
 Documentation/pretty-options.txt              |   2 +-
 .../technical/hash-function-transition.txt    |  31 ++-
 .../technical/signature-format-v2.txt         | 232 ++++++++++++++++++
 Documentation/user-manual.txt                 |  40 +--
 25 files changed, 747 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/config/sign.txt
 create mode 100644 Documentation/technical/signature-format-v2.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a..71eb46117f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -446,6 +446,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sign.txt[]
+
 include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 2c95573930..9004a2f3cb 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -7,13 +7,24 @@ commit.cleanup::
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
 
-commit.gpgSign::
+commit.gpgSign (deprecated)::
+	Interpreted as an alias for 'commit.sign'. Use of this implies
+	'commit.signType = openpgp' and the config values for 
+	'sign.openpgp.*' are used if specified. If this is enabled and
+	'sign.openpgp.*' is not defined, backwards compatible defaults
+	are used that emulate the old behavior.
 
-	A boolean to specify whether all commits should be GPG signed.
-	Use of this option when doing operations such as rebase can
-	result in a large number of commits being signed. It may be
-	convenient to use an agent to avoid typing your GPG passphrase
-	several times.
+commit.sign::
+	A boolean to specify whether all commits should be cryptographically
+	signed. Use of this option when doing operations such as rebase can
+	result in a large number of commits being signed.
+
+commit.signType::
+	A string value to specify the type of signature to use whenever
+	'--sign' is used or 'commit.sign' is enabled. If this is not defined
+	the signature type defined by 'sign.default' is used. If neither
+	this nor 'sign.default' are defined backwards compatible defaults
+	for "openpgp" signatures are used.
 
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
index d94025cb36..40629cb105 100644
--- a/Documentation/config/gpg.txt
+++ b/Documentation/config/gpg.txt
@@ -1,32 +1,16 @@
-gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
-	making or verifying a PGP signature. The program must support the
-	same command-line interface as GPG, namely, to verify a detached
-	signature, "`gpg --verify $signature - <$file`" is run, and the
-	program is expected to signal a good signature by exiting with
-	code 0, and to generate an ASCII-armored detached signature, the
-	standard input of "`gpg -bsau $key`" is fed with the contents to be
-	signed, and the program is expected to send the result to its
-	standard output.
+gpg.program (deprecated)::
+	Interpreted as an alias for 'sign.openpgp.program'.
 
-gpg.format::
-	Specifies which key format to use when signing with `--gpg-sign`.
-	Default is "openpgp" and another possible value is "x509".
+gpg.format (deprecated)::
+	Interpreted as an alias for 'sign.default'. 
 
-gpg.<format>.program::
-	Use this to customize the program used for the signing format you
-	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
-	be used as a legacy synonym for `gpg.openpgp.program`. The default
-	value for `gpg.x509.program` is "gpgsm".
+gpg.<format>.program (deprecated)::
+	Interpreted as an alias for 'sign.<format>.program' for format
+	values of "openpgp" and "x509".
 
-gpg.minTrustLevel::
-	Specifies a minimum trust level for signature verification.  If
-	this option is unset, then signature verification for merge
-	operations require a key with at least `marginal` trust.  Other
-	operations that perform signature verification require a key
-	with at least `undefined` trust.  Setting this option overrides
-	the required trust-level for all operations.  Supported values,
-	in increasing order of significance:
+gpg.minTrustLevel (deprecated)::
+	Interpreted as an alias for 'sign.<format>.options.minTrustLevel' for
+	format values of "openpgp" and "x509".
 +
 * `undefined`
 * `never`
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 21b256e0a4..9a63bb273a 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -61,15 +61,27 @@ push.followTags::
 	may override this configuration at time of push by specifying
 	`--no-follow-tags`.
 
-push.gpgSign::
+push.gpgSign (deprecated)::
+	Interpreted as an alias for 'push.sign'. Use of this implies
+	'push.signType = openpgp' and the config values for
+	'sign.openpgp.*' are used if specified. If 'sign.openpgp.*' is not
+	defined, backwards compatible defaults are used.
+
+push.sign::
 	May be set to a boolean value, or the string 'if-asked'. A true
-	value causes all pushes to be GPG signed, as if `--signed` is
+	value causes all pushes to be signed, as if `--sign` is
 	passed to linkgit:git-push[1]. The string 'if-asked' causes
 	pushes to be signed if the server supports it, as if
-	`--signed=if-asked` is passed to 'git push'. A false value may
+	`--sign=if-asked` is passed to 'git push'. A false value may
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
+push.signType::
+	Specifies the type of signature to use whenever '--sign' or
+	'push.sign' is enabled. If not defined, 'sign.default' determines
+	the type of signature otherwise backwards compatible defaults are
+	used.
+
 push.pushOption::
 	When no `--push-option=<option>` argument is given from the
 	command line, `git push` behaves as if each <value> of
diff --git a/Documentation/config/sign.txt b/Documentation/config/sign.txt
new file mode 100644
index 0000000000..a852da8803
--- /dev/null
+++ b/Documentation/config/sign.txt
@@ -0,0 +1,72 @@
+sign.default::
+	A string specifying the default signature type to use when signing
+	and the signature type is not specified with the '--sign-type'
+	command line switch. This specifies that the values from 
+	'sign.<signType>.*' be used. If unspecified, the default is "openpgp"
+	for backwards compatibility. The value can be any string but there
+	must be a corresponding 'sign.<signType>.*' config block with at
+	least 'sign.<signType>.program' defined.
+
+sign.openpgp.program::
+	Defines the program to use when signing or verifying with OpenPGP.
+	The program must be found in the `$PATH` and if not defined, the
+	default is "`gpg`".
+
+sign.openpgp.sign::
+	Defines the program, found in the `$PATH` to use when signing with
+	OpenPGP. If specified, this overrides 'sign.openpgp.program' in
+	signing operations.
+
+sign.openpgp.verify::
+	Defines the program, found in the `$PATH` to use when verifying an
+	OpenPGP signature. If specified, this overrides 'sign.openpgp.program'
+	in verification operations.
+
+sign.openpgp.options.*::
+	Any number of options that are passed verbatim to the signing tool
+	with 'OPTION' commands during a cryptographic signing event. If
+	not defined, the default, backwards compatible options are:
+	'minTrustLevel = marginal', 'armored = true', and 'detached = true'
+	for full backwards compatibility. This emulates the old
+	"`gpg -bsau`" way of creating an OpenPGP cryptographic signature.
+
+sign.x509.program::
+	Defines the program to use when signing or verifying using X.509
+	certificates. The program must be found in the `$PATH` and if not
+	defined, the default is "`gpgsm`".
+
+sign.x509.sign::
+	Defines the program, found in the `$PATH` to use when
+	cryptographically signing with X.509 certificates. If specified, this
+	overrides 'sign.x509.program' in signing operations.
+
+sign.x509.verify::
+	Defines the program, found in the `$PATH` to use when verifying an
+	X.509 cryptographic signature. If specified, this overrides
+	'sign.x509.program' in verification operations.
+
+sign.x509.options.*::
+	Any number of options that are passed verbatim to the signing tool
+	with 'OPTION' commands during a cryptographic signing event. If
+	not defined, the default options are: 'minTrustLevel = marginal',
+	'armored = true', and 'detached = true' for full backwards
+	compatibility. This emulates the old "`gpgsm -bsau`" way of creating
+	an X.509 cryptographic signature.
+
+sign.<signType>.program::
+	Defines the program, found in the `$PATH` to use when signing or
+	verifying signatures with the matching signature type.
+
+sign.<signType>.sign::
+	Defines the program, found in the `$PATH` to use when signing using
+	the specified signature type. If specified, this overrides
+	'sign.<signType>.program' in signing operations.
+
+sign.<signType>.verify::
+	Defines the program, found in the `$PATH` to use when verifying
+	signatures of type signature type. If specified, this overrides
+	'sign.<signType>.program' in verification operations.
+
+sign.<signType>.options.*::
+	Any number of options that are passed verbatim to the signing tool
+	with 'OPTION' commands during a signing event.
diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
index 5062a057ff..eff3286e59 100644
--- a/Documentation/config/tag.txt
+++ b/Documentation/config/tag.txt
@@ -1,17 +1,24 @@
 tag.forceSignAnnotated::
-	A boolean to specify whether annotated tags created should be GPG signed.
-	If `--annotate` is specified on the command line, it takes
-	precedence over this option.
+	A boolean to specify whether annotated tags created should be
+	cryptographically signed. If `--annotate` is specified on the
+	command line, it takes precedence over this option.
 
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
 	value of this variable will be used as the default.
 
-tag.gpgSign::
-	A boolean to specify whether all tags should be GPG signed.
-	Use of this option when running in an automated script can
-	result in a large number of tags being signed. It is therefore
-	convenient to use an agent to avoid typing your gpg passphrase
-	several times. Note that this option doesn't affect tag signing
-	behavior enabled by "-u <keyid>" or "--local-user=<keyid>" options.
+tag.gpgSign (deprecated)::
+	Interpreted as an alias for 'tag.sign'.
+
+tag.sign::
+	A boolean to specify whether all tags should be cryptographically
+	signed. Use of this option when running in an automated script can
+	result in a large number of tags being signed. Note that this option
+	doesn't affect tag signing behavior enabled by "-u <keyid>" or
+	"--local-user=<keyid>" options.
+
+tag.sigType::
+	Specifies the type of signature to use whenever '--sign' is used or
+	'tag.sign' is enabled. If undefined, 'sign.default' determines the
+	type of signature to create.
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 59aec7c3ae..a00209cd76 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -30,9 +30,9 @@ user.useConfigOnly::
 	making new commits in a newly cloned repository.
 	Defaults to `false`.
 
-user.signingKey::
-	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
-	key you want it to automatically when creating a signed tag or
-	commit, you can override the default selection with this variable.
-	This option is passed unchanged to gpg's --local-user parameter,
-	so you may specify a key using any method that gpg supports.
+user.signingKey (deprecated)::
+	For backwards compatibility, if this is defined and if the signature
+	type is specified as 'openpgp' or 'x509' using either '--sign-type' or
+	'sign.default', then this is interpreted as an alias for
+	'sign.openpgp.options.identifier' or 'sign.x509.options.identifier'
+	respectively.
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index decd8ae122..be94598c59 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
+	 [--[no-]scissors] [--sign] [(--sign-type <signType>)]
+	 [(--sign-option <token>[=<value])...] [--patch-format=<format>]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -146,14 +147,38 @@ default.   You can use `--no-utf8` to override this.
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 --continue::
 -r::
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d750314b2..4c20e11aba 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
-		  [-S[<keyid>]] <commit>...
+		  [--sign] [(--sign-type <signType>)]
+		  [(--sign-option <token>[=<value>])...] <commit>...
 'git cherry-pick' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
@@ -107,14 +108,38 @@ effect to your index in a row.
 	Add a `Signed-off-by` trailer at the end of the commit message.
 	See the signoff option in linkgit:git-commit[1] for more information.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of options
+	may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 --ff::
 	If the current HEAD is the same as the parent of the
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 2e2c581098..c7911de70a 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -10,8 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git commit-tree' <tree> [(-p <parent>)...]
-'git commit-tree' [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]
-		  [(-F <file>)...] <tree>
+'git commit-tree' [(-p <parent>)...] [--sign]
+		  [(--sign-type <signType>)] [(--sign-option <token>[=<value])...]
+		  [(-m <message>)...] [(-F <file>)...] <tree>
 
 
 DESCRIPTION
@@ -59,13 +60,38 @@ OPTIONS
 	from the standard input. This can be given more than once and the
 	content of each file becomes its own paragraph.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand a `--gpg-sign` option given earlier on the command line.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 Commit Information
 ------------------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 340c5fbb48..69ae92c201 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
+	   [(--trailer <token>[(=|:)<value>])...] [--sign]
+	   [(--sign-type <signType>)] [(--sign-option <token>[=<value])...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -385,14 +386,38 @@ changes to tracked files.
 	commit message template when using an editor to prepare the
 	default commit message.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 39cfa05b28..5c8e302bd8 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -854,7 +854,7 @@ not interpreted by Git.  Currently they must be encoded in UTF-8,
 as fast-import does not permit other encodings to be specified.
 
 Signing annotated tags during import from within fast-import is not
-supported.  Trying to include your own PGP/GPG signature is not
+supported.  Trying to include your own cryptographic signature is not
 recommended, as the frontend does not (easily) have access to the
 complete set of bytes which normally goes into such a signature.
 If signing is required, create lightweight tags from within fast-import with
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ae2478de7..fcbfd23acf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -254,7 +254,7 @@ contents:body::
 	the "subject".
 
 contents:signature::
-	The optional GPG signature of the tag.
+	The optional cryptographic signature of the tag.
 
 contents:lines=N::
 	The first `N` lines of the message.
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 466a697519..19b8998195 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -48,18 +48,34 @@ OPTIONS
 Tag Format
 ----------
 A tag signature file, to be fed to this command's standard input,
-has a very simple fixed format: four lines of
+must have at least these four lines:
 
-  object <hash>
-  type <typename>
-  tag <tagname>
-  tagger <tagger>
+object <hash>
+type <typename>
+tag <tagname>
+tagger <tagger>
 
 followed by some 'optional' free-form message (some tags created
 by older Git may not have `tagger` line).  The message, when it
-exists, is separated by a blank line from the header.  The
-message part may contain a signature that Git itself doesn't
-care about, but that can be verified with gpg.
+exists, is separated by a blank line from the header.
+
+A cryptographically signed tag may be created by including a
+signature formatted using the version 2 format:
+
+object <hash>
+type <typename>
+tag <tagname>
+tagger <tagger>
+signtype openpgp
+sign -----BEGIN PGP SIGNATURE-----%0a
+ %0a
+ iHUEABYKAB0WIQTXto4BPKlfA2YYS5Pn3hDaTgk8fAUCX5C+ugAKCRDn3hDaTgk8%0a
+ fOk8AQCRGkdNGMXhJ95e5QIHk44rvfNsyibxY6ZvTXdLQJvt/gEAlFCeEM3SfaDL%0a
+ 8RQR368L0+caDlaZW51VZVP2UBXP6w0=%0a
+ =1Fby%0a
+ -----END PGP SIGNATURE-----%0a
+
+followed by an optional free-form message.
 
 GIT
 ---
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e..c9654dff6e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,8 +9,10 @@ SYNOPSIS
 --------
 [verse]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
-	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
+	 [--sign] [(--sign-type <signType>)] [(--sign-option <token>[=<value])...]
+	 [--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
+	 [--sign] [(--sign-type <signType>)] [(--sign-option <token>[=<value])...]
 	--root [<branch>]
 'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
 
@@ -379,14 +381,38 @@ See also INCOMPATIBLE OPTIONS below.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 -q::
 --quiet::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index bb92a4a451..5ea0ee9bd3 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,9 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m parent-number] [-s]
+	[--sign] [(--sign-type <signType>)] [(--sign-option <token>[=<value])...]
+	<commit>...
 'git revert' (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
@@ -88,14 +90,38 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
-	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space. `--no-gpg-sign` is useful to
-	countermand both `commit.gpgSign` configuration variable, and
-	earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 -s::
 --signoff::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c..764939ec93 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -3,13 +3,14 @@ git-tag(1)
 
 NAME
 ----
-git-tag - Create, list, delete or verify a tag object signed with GPG
+git-tag - Create, list, delete or verify a tag object
 
 
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
+'git tag' [-a] [--sign] [(--sign-type <signType>)] 
+  [(--sign-option <token>[=<value])...][-f] [-m <msg> | -F <file>] [-e]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
@@ -26,26 +27,23 @@ to delete, list or verify tags.
 
 Unless `-f` is given, the named tag must not yet exist.
 
-If one of `-a`, `-s`, or `-u <keyid>` is passed, the command
-creates a 'tag' object, and requires a tag message.  Unless
-`-m <msg>` or `-F <file>` is given, an editor is started for the user to type
-in the tag message.
+If one of `-a`, is passed, the command creates a 'tag' object, and
+requires a tag message.  Unless `-m <msg>` or `-F <file>` is given,
+an editor is started for the user to type in the tag message.
 
-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
-are absent, `-a` is implied.
+If `-m <msg>` or `-F <file>` is given and `-a` is absent, `-a` is
+implied.
 
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
 
-A GnuPG signed tag object will be created when `-s` or `-u
-<keyid>` is used.  When `-u <keyid>` is not used, the
-committer identity for the current user is used to find the
-GnuPG key for signing. 	The configuration variable `gpg.program`
-is used to specify custom GnuPG binary.
+A cryptographically signed object is created when `--sign` is used.
+The type of signature to create may be specified using `--sign-type`
+and options specified using `--sign-option`.
 
-Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
+Tag objects (created with `-a` or `--sign`) are called "annotated"
 tags; they contain a creation date, the tagger name and e-mail, a
-tagging message, and an optional GnuPG signature. Whereas a
+tagging message, and an optional cryptographic signature. Whereas a
 "lightweight" tag is simply a name for an object (usually a commit
 object).
 
@@ -61,20 +59,41 @@ OPTIONS
 --annotate::
 	Make an unsigned, annotated tag object
 
--s::
+-S::
 --sign::
-	Make a GPG-signed tag, using the default e-mail address's key.
-	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
-	configuration variable if it exists, or disabled otherwise.
-	See linkgit:git-config[1].
-
 --no-sign::
-	Override `tag.gpgSign` configuration variable that is
-	set to force each and every tag to be signed.
-
--u <keyid>::
---local-user=<keyid>::
-	Make a GPG-signed tag, using the given key.
+-s (deprecated)::
+	Cryptographically sign the tag. The `--no-sign` option is usefult to
+	countermand both 'commit.sign' configuration variable and earlier 
+	`--sign` command line switches.
+
+-u <keyid> (deprecated)::
+--local-user=<keyid> (deprecated)::
+	Both of these options are deprecated and should no longer be used.
+	The preferred way is to specify this as a configuration variable as
+	an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. 
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 -f::
 --force::
@@ -86,7 +105,7 @@ OPTIONS
 
 -v::
 --verify::
-	Verify the GPG signature of the given tag names.
+	Verify the cryptographic signature of the given tag names.
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
@@ -213,15 +232,24 @@ This option is only applicable when listing tags without annotation lines.
 
 CONFIGURATION
 -------------
-By default, 'git tag' in sign-with-default mode (-s) will use your
-committer identity (of the form `Your Name <your@email.address>`) to
-find a key.  If you want to use a different default key, you can specify
-it in the repository configuration as follows:
-
--------------------------------------
-[user]
-    signingKey = <gpg-keyid>
--------------------------------------
+By default, 'git tag' in sign-with-default mode (-S) determines the
+type of signature from the `sign.default` config option and/or the
+`--sign-type` command line option. The identifier for the signature
+is then determined by the `sign.<signType>.options.identifier` config
+option and/or the `--sign-option identifier=<keyid>` command line
+option.
+
+For backwards compatibility, if you are still using the deprecated
+`user.signingKey` config option and enable tag signing, the behavior
+is as if you also specified the following command line options:
+
+	--sign-type openpgp
+	--sign-option armored=true 
+	--sign-option detached=true
+	--sign-option identifier=<keyid>
+
+which emulates the original signing behavior of running
+`gpg -bsau <keyid>` to create the signature.
 
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
 used or implied. The default is to use a pager.
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 92097f6673..4b2e8ea909 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -3,7 +3,7 @@ git-verify-commit(1)
 
 NAME
 ----
-git-verify-commit - Check the GPG signature of commits
+git-verify-commit - Check the cryptographic signature of commits
 
 SYNOPSIS
 --------
@@ -12,13 +12,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Validates the GPG signature created by 'git commit -S'.
+Validates the cryptographic signature created by 'git commit -S'.
 
 OPTIONS
 -------
 --raw::
-	Print the raw gpg status output to standard error instead of the normal
-	human-readable output.
+	Print the raw signature verification status output to standard error 
+	instead of the normal human-readable output.
 
 -v::
 --verbose::
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0b8075dad9..939cf8dc3a 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -3,7 +3,7 @@ git-verify-tag(1)
 
 NAME
 ----
-git-verify-tag - Check the GPG signature of tags
+git-verify-tag - Check the cryptographic signature of tags
 
 SYNOPSIS
 --------
@@ -12,13 +12,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag'.
+Validates the cryptographic signature created by 'git tag'.
 
 OPTIONS
 -------
 --raw::
-	Print the raw gpg status output to standard error instead of the normal
-	human-readable output.
+	Print the raw signature verification status output to standard error
+	instead of the normal human-readable output.
 
 -v::
 --verbose::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396..ba521f90d3 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -59,14 +59,38 @@ could instead be resolved as a fast-forward.
 With `--ff-only`, resolve the merge as a fast-forward when possible.
 When not possible, refuse to merge and exit with a non-zero status.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign the resulting merge commit. The `keyid` argument is
-	optional and defaults to the committer identity; if specified,
-	it must be stuck to the option without a space. `--no-gpg-sign`
-	is useful to countermand both `commit.gpgSign` configuration variable,
-	and earlier `--gpg-sign`.
+-S::
+--sign::
+--no-sign::
+--gpg-sign[=<keyid>] (deprecated)::
+--no-gpg-sign (deprecated)::
+	Cryptographically sign commits. The `keyid` argument is deprecated
+	and the preferred way is to specify this as a configuration variable
+	as an option for the signing tool you use. For OpenPGP, you would
+	specify this using 'sign.openpgp.options.identifier = <keyid>'. If
+	you must pass the `keyid` on the command line, use
+	`--sign-option identifier=<keyid>`. For backwards compatibility, if
+	the signature type is 'openpgp' or 'x509' and the `keyid` is
+	specified, it is passed as if `--sign-option identifier=<keyid>` is
+	also specified. The `--no-sign` option is usefult to countermand both
+	'commit.sign' configuration variable and earlier `--sign` command line
+	switches.
+
+--sign-type <signType>::
+	Specifies the signature type to create when cryptographically signing
+	commits. There must be a corresponding configuration block
+	'sign.<signType>.*' with at least 'sign.<signType>.program' specified.
+	For backwards compatibility, 'openpgp' is assumed if the sign type
+	is not specified.
+
+--sign-option <token>[=<value>]::
+	Specify an option to pass to the cryptographic signing tool using the
+	OPTION command in cryptographic signing protocol. Any number of
+	options may be specified on the command line and they will override
+	any corresponding configuration variables with the same name. For
+	example, if the signature type is 'openpgp' and the configuration
+	variable 'sign.openpgp.options.identifier' is set then
+	`--sign-option identifier=<keyid>` will override it.
 
 --log[=<n>]::
 --no-log::
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index cd697f508c..229ddabbd7 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -235,7 +235,7 @@ The placeholders are:
 ifndef::git-rev-list[]
 '%N':: commit notes
 endif::git-rev-list[]
-'%GG':: raw verification message from GPG for a signed commit
+'%GG':: raw verification message for a cryptographically signed commit
 '%G?':: show "G" for a good (valid) signature,
 	"B" for a bad signature,
 	"U" for a good signature with unknown validity,
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 27ddaf84a1..45bd13bb25 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -93,4 +93,4 @@ endif::git-rev-list[]
 
 --show-signature::
 	Check the validity of a signed commit object by passing the signature
-	to `gpg --verify` and show the output.
+	to associated verification tool and show the output.
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 7c1630bf83..d9bd4082c3 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -409,17 +409,16 @@ send-pack.
 
 Signed Commits
 ~~~~~~~~~~~~~~
-We add a new field "gpgsig-sha256" to the commit object format to allow
-signing commits without relying on SHA-1. It is similar to the
-existing "gpgsig" field. Its signed payload is the SHA-256 content of the
-commit object with any "gpgsig" and "gpgsig-sha256" fields removed.
+We use the new signature format whenever signing commits without relying
+on SHA-1. The new format adds a 'signtype' field, zero or more 'signoption'
+fields, and one 'sign' field to commit objects. This allows for the 'gpgsig'
+field to coexist if needed.
 
 This means commits can be signed
 
 1. using SHA-1 only, as in existing signed commit objects
-2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
-   fields.
-3. using only SHA-256, by only using the gpgsig-sha256 field.
+2. using both SHA-1 and SHA-256, by using both gpgsig and the V2 format.
+3. using only SHA-256, by only using the V2 format.
 
 Old versions of "git verify-commit" can verify the gpgsig signature in
 cases (1) and (2) without modifications and view case (3) as an
@@ -427,17 +426,16 @@ ordinary unsigned commit.
 
 Signed Tags
 ~~~~~~~~~~~
-We add a new field "gpgsig-sha256" to the tag object format to allow
-signing tags without relying on SHA-1. Its signed payload is the
-SHA-256 content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
-SIGNATURE-----" delimited in-body signature removed.
+We use the new signature format whenever signing tags without relying
+on SHA-1. The new format adds a 'signtype' field, zero or more 'signoption'
+fields, and one 'sign' field to tag objects. This allows for the in-body
+SHA-1 signature to coexist if needed.
 
 This means tags can be signed
 
 1. using SHA-1 only, as in existing signed tag objects
-2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
-   signature.
-3. using only SHA-256, by only using the gpgsig-sha256 field.
+2. using both SHA-1 and SHA-256, by using both gpgsig and the V2 format.
+3. using only SHA-256, by only using the V2 format.
 
 Mergetag embedding
 ~~~~~~~~~~~~~~~~~~
@@ -631,8 +629,9 @@ Transition plan
 Some initial steps can be implemented independently of one another:
 
 - adding a hash function API (vtable)
-- teaching fsck to tolerate the gpgsig-sha256 field
-- excluding gpgsig-* from the fields copied by "git commit --amend"
+- teaching fsck to tolerate the 'signtype', 'signoption' and 'sign' tags
+- excluding 'signtype', 'signoption' and 'sign' from the fields copied
+  by "git commit --amend"
 - annotating tests that depend on SHA-1 values with a SHA1 test
   prerequisite
 - using "struct object_id", GIT_MAX_RAWSZ, and GIT_MAX_HEXSZ
diff --git a/Documentation/technical/signature-format-v2.txt b/Documentation/technical/signature-format-v2.txt
new file mode 100644
index 0000000000..8628402e29
--- /dev/null
+++ b/Documentation/technical/signature-format-v2.txt
@@ -0,0 +1,232 @@
+Git Signature Format, Version 2
+===============================
+
+Overview
+--------
+
+Git supports cryptographic signatures on objecs (e.g. tags, commits, mergetags)
+and transactions (e.g. pushes). The first version of these signatures were
+always created using gpg or gpgsm and resulted in OpenPGP signatures with known
+formats that made parsing signatures for verification simple using string
+matching. Version 2 of signature format is designed to work hand-in-hand with
+the new cryptographic signing/verification protocol and supports any possible
+signature format while still being easily parseable for verification purposes.
+
+Version 1 Format
+----------------
+
+The first verion of the protocol is documented in the signature-format.txt
+file. The relevant details from that document define the fields used to
+identify signatures in the meta data of objects and transations.
+
+Tags
+~~~~
+
+In tags, signatures are stored "in-body" immediately following the tag body.
+To parse a signature from a tag, Git string matches for `-----BEGIN PGP
+SIGNATURE-----` and `-----END PGP SIGNATURE-----` that mark the begining and
+ending of a signature. The only difference between gpg and gpgsm signatures is
+that gpgsm signatures use the strings `-----BEGIN SIGNED MESSAGE-----` and
+`-----END SIGNED MESSAGE-----` instead.
+
+The transition from SHA1 to SHA256 has complicated this somewhat by adding a
+new "gpgsig-sha256" field that stores the signature whenever the SHA256 digest
+algorithm is used. It is possible to have both the "in-body" signature created
+when SHA-1 digest is used as well as the signature stored as the value for the
+"gpgsig-sha256" field when SHA256 digest is used.
+
+Either way, the content that gets sent to the signing tool is the full object
+data, fields and body, without including the "gpgsig-sha256" field or any
+in-body signature data.
+
+Commits
+~~~~~~~
+
+In commits, signatures are stored in the field named "gpgsig" when SHA-1 digest
+is used and "gpgsig-sha256" when SHA256 digest is used. Parsing signatures in
+commits is also done with string matching of the BEGIN/END strings marking
+OpenPGP signatures even though they are stored as fields.
+
+Mergetags
+~~~~~~~~~
+
+In mergtags, the whole signed tag object is stored in the field named
+"mergetag" and the output of verifying the signature is appended to the body of
+the mergetag as comment lines starting with '#'.
+
+Version 2 Format
+----------------
+
+The goals of the version 2 format are as follows:
+
+- Backwards Compatible with version 1 without any intervention.
+- Eliminate signature-format-specific string matching for detecting/parsing
+  version 2 signatures.
+- Use fields for storing signatures in all objects and transactions.
+- Have a field that identifies the signature format.
+- Have fields that store options required by the verification tool.
+- Store signature data verbatim as created with the signing tool with escaped
+  newlines and carriage returns.
+
+Fields
+~~~~~~
+
+The version 2 format uses three new fields listed below:
+
+- signtype <signature format name>
+- signoption <token> [= <value>]
+- sign <multiline signature data>
+
+A complete signature must include exactly one `signtype` field, zero or more
+`signoption` fields and one `sign` field.
+
+The `signtype` field has a string value that identifies the type of signature
+that is stored in the object. This string is case-insensitive and is used to
+identify which configuration settings are to used when verifying the signature.
+The corresponding configuration settings are in the config file as:
+'sign.<signType>.options.*'. The 'sign' field stores the text-encoded signature
+from the signing tool with any newlines and carriage returns escaped as '%0a'
+and '%0d' respectively. Whitespace is significant in digital signatures and
+the protocol for sending/receiving data to/from signing and verification tools
+requires that newlines and carriage returns are escaped. By storing the escaped
+version in the 'sign' field, we avoid extra processing and error-prone
+escaping.
+
+The introduction of the 'signoption' field is necessary for Git to remain
+agnostic to the tools used for signing and verification of cryptographic
+signatures. Some signign tools do not produce cryptographic signatures that
+include all of the data needed to verify the signature. A good example of this
+is the minisign tool (https://jedisct1.github.io/minisign/) which requires the
+public key to be supplied to the verification operation. In that case, the
+signing operation would return to Git a 'signoption' field along with the
+'signtype' and 'sign' fields to be stored in the Git object. When Git verifies
+the signature, it will parse the 'signoption' fields and send them to the
+verification tool as OPTION commands. In this case it will send the public key
+along with the signature for verification. This design allows for arbitrary
+options to be stored in the Git object by the signing tool that will get passed
+to the verification tool later without Git knowing or understanding any details
+of a particular signing tool.
+
+The order in which OPTION commands are sent to the signing and verification
+tools is significant. OPTION commands that come later override OPTION commands
+that came earlier and had the same token name. Git always sends OPTION commands
+from the command line after the options from the config. In verification
+operations, Git sends the options from the signed object first, before the
+config and command line options. This ensures local control over option values.
+An example would be if the sign.openpgp.options.minTrustLevel config option is
+set to "marginal" and the command line `--sign-option minTrustLevel = full` is
+issued. Git would first send an OPTION command setting 
+`minTrustLevel = marginal` from the config and then override that by later
+sending an OPTION command setting `minTrustLevel = full` from the command line.
+
+The `sign` field is very similar to the old `gpgsig` field in commits. The data
+is can be multi-line with subsequent lines starting with spaces to mark them as
+additional data. The only difference is that the `sign` field stores signatures
+with newlines and carriage returns escaped because whitespace is significate in
+cryptographic signatures. Again, the idea is to keep Git completely agnostic to
+the details of any cryptographic signing/verification tool so the signature
+data must be escaped and stored verbatim in the object. This allows simple and
+exact transmission of the signature data to the verification tool in the
+future.
+
+Examples
+~~~~~~~~
+
+Below are the examples taken from the Version 1 signature-format.txt
+documentation and translated into objects that use the Version 2 format as an
+example.
+
+Signed Tag:
+
+----
+object 04b871796dc0420f8e7561a895b52484b701d51a
+type commit
+tag signedtag
+tagger C O Mitter <committer@example.com> 1465981006 +0000
+signtype openpgp
+sign -----BEGIN PGP SIGNATURE-----%0a
+ Version: GnuPG v1%0a
+ %0a
+ iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn%0a
+ rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh%0a
+ 8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods%0a
+ q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0%0a
+ rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x%0a
+ lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=%0a
+ =jpXa%0a
+ -----END PGP SIGNATURE-----%0a
+
+signed tag
+
+signed tag message body
+----
+
+
+Signed Commit:
+
+----
+tree eebfed94e75e7760540d1485c740902590a00332
+parent 04b871796dc0420f8e7561a895b52484b701d51a
+author A U Thor <author@example.com> 1465981137 +0000
+committer C O Mitter <committer@example.com> 1465981137 +0000
+signtype openpgp
+sign -----BEGIN PGP SIGNATURE-----%0a
+ Version: GnuPG v1%0a
+ %0a
+ iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/%0a
+ HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7%0a
+ DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA%0a
+ zn075rtEERDHr8nRYiDh8eVrefSO7D+bdQ7gv+7GsYMsd2auJWi1dHOSfTr9HIF4%0a
+ HJhWXT9d2f8W+diRYXGh4X0wYiGg6na/soXc+vdtDYBzIxanRqjg8jCAeo1eOTk1%0a
+ EdTwhcTZlI0x5pvJ3H0+4hA2jtldVtmPM4OTB0cTrEWBad7XV6YgiyuII73Ve3I=%0a
+ =jKHM%0a
+ -----END PGP SIGNATURE-----%0a
+
+signed commit
+
+signed commit message body
+----
+
+
+Signed Mergetag:
+
+----
+tree c7b1cff039a93f3600a1d18b82d26688668c7dea
+parent c33429be94b5f2d3ee9b0adad223f877f174b05d
+parent 04b871796dc0420f8e7561a895b52484b701d51a
+author A U Thor <author@example.com> 1465982009 +0000
+committer C O Mitter <committer@example.com> 1465982009 +0000
+mergetag object 04b871796dc0420f8e7561a895b52484b701d51a
+ type commit
+ tag signedtag
+ tagger C O Mitter <committer@example.com> 1465981006 +0000
+ signtype openpgp
+ sign  -----BEGIN PGP SIGNATURE-----%0a
+ Version: GnuPG v1%0a
+ %0a
+ iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn%0a
+ rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh%0a
+ 8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods%0a
+ q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0%0a
+ rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x%0a
+ lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=%0a
+ =jpXa%0a
+ -----END PGP SIGNATURE-----%0a
+
+ signed tag
+
+ signed tag message body
+
+Merge tag 'signedtag' into downstream
+
+signed tag
+
+signed tag message body
+
+# Signature made Wed Jun 15 08:56:46 2016 UTC using RSA key ID B7227189
+# Good signature from "Eris Discordia <discord@example.net>"
+# WARNING: This key is not certified with a trusted signature!
+#          There is no indication that the signature belongs to the owner.
+# Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
+----
+
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b8674..a5922d0364 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2930,7 +2930,7 @@ There are four different types of objects: "blob", "tree", "commit", and
 - A <<def_tag_object,"tag" object>> symbolically identifies and can be
   used to sign other objects. It contains the object name and type of
   another object, a symbolic name (of course!) and, optionally, a
-  signature.
+  cryptographic signature.
 
 The object types in some more detail:
 
@@ -3071,15 +3071,15 @@ parents of that commit, and all of those contents of the trees referred
 to by those commits.
 
 So to introduce some real trust in the system, the only thing you need
-to do is to digitally sign just 'one' special note, which includes the
-name of a top-level commit.  Your digital signature shows others
-that you trust that commit, and the immutability of the history of
-commits tells others that they can trust the whole history.
+to do is to cryptographically sign just 'one' special note, which
+includes the name of a top-level commit. Your cryptographic signature
+shows others that you trust that commit, and the immutability of the
+history of commits tells others that they can trust the whole history.
 
 In other words, you can easily validate a whole archive by just
 sending out a single email that tells the people the name (SHA-1 hash)
-of the top commit, and digitally sign that email using something
-like GPG/PGP.
+of the top commit, and cryptographically sign that email using
+something like GPG/PGP.
 
 To assist in this, Git also provides the tag object...
 
@@ -3087,8 +3087,8 @@ To assist in this, Git also provides the tag object...
 ==== Tag Object
 
 A tag object contains an object, object type, tag name, the name of the
-person ("tagger") who created the tag, and a message, which may contain
-a signature, as can be seen using linkgit:git-cat-file[1]:
+person ("tagger") who created the tag, an optional cryptographic
+signature, and a message as can be seen using linkgit:git-cat-file[1]:
 
 ------------------------------------------------
 $ git cat-file tag v1.5.0
@@ -3096,15 +3096,17 @@ object 437b1b20df4b356c9342dac8d38849f24ef44f27
 type commit
 tag v1.5.0
 tagger Junio C Hamano <junkio@cox.net> 1171411200 +0000
+signtype openpgp
+sign -----BEGIN PGP SIGNATURE-----%0a
+ Version: GnuPG v1.4.6 (GNU/Linux)%0a
+ %0a
+ iD8DBQBF0lGqwMbZpPMRm5oRAuRiAJ9ohBLd7s2kqjkKlq1qqC57SbnmzQCdG4ui%0a
+ nLE/L9aUXdWeTFPron96DLA=%0a
+ =2E+0%0a
+ -----END PGP SIGNATURE-----%0a
 
-GIT 1.5.0
------BEGIN PGP SIGNATURE-----
-Version: GnuPG v1.4.6 (GNU/Linux)
 
-iD8DBQBF0lGqwMbZpPMRm5oRAuRiAJ9ohBLd7s2kqjkKlq1qqC57SbnmzQCdG4ui
-nLE/L9aUXdWeTFPron96DLA=
-=2E+0
------END PGP SIGNATURE-----
+GIT 1.5.0
 ------------------------------------------------
 
 See the linkgit:git-tag[1] command to learn how to create and verify tag
@@ -3702,9 +3704,9 @@ A tree can be created with linkgit:git-write-tree[1] and its data can be
 accessed by linkgit:git-ls-tree[1].  Two trees can be compared with
 linkgit:git-diff-tree[1].
 
-A tag is created with linkgit:git-mktag[1], and the signature can be
-verified by linkgit:git-verify-tag[1], though it is normally simpler to
-use linkgit:git-tag[1] for both.
+A tag is created with linkgit:git-mktag[1], and the cryptographic
+signature can be verified by linkgit:git-verify-tag[1], though it is
+normally simpler to use linkgit:git-tag[1] for both.
 
 [[the-workflow]]
 === The Workflow
-- 
2.20.1

