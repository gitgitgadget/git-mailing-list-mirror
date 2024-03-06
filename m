Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FB7F7EF
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724728; cv=none; b=I92//YVFG3hDvHCTOlX63XnF0B0j2JT9KwfmsirZxygTAIWyomIeYmmF714ZjDoM8Rzr/rYOhgzd1/521Skr4x5Np56BsRCKPTS1VdsJYL4fsvakxdIG27moL2vOH/N9OkNvAVpSHD6L2IUfCU2r9uyZ1VRwZdlKWs0Nmg7LOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724728; c=relaxed/simple;
	bh=E6SAwy5b9BdK8x75A5x71LQkkWb06GpwGLi8Dd+jHZw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg94DMSp3cNPzq0CsJom7rUAEkZdnw4Zs4jgvzDa7vW1iuM2XOiWwsKi4SqQgwX4ZH68CaFOvXvW2oFBKtoKPPpPNpbLLJlx6JWw/yf1tqy0ZG0JGQ1ssg2b2ve6C1jpnqfb2SdCMK/ANFqXRh+Rh68YfwhU80vazUmdtQPEsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jzsJHkqb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2R6Cd7H; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jzsJHkqb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2R6Cd7H"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C1414138013B
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:32:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Mar 2024 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724725; x=1709811125; bh=aDn9jp0ydO
	nITE61NItouuP4rIFJ0/kXfSafXSAV8Xg=; b=jzsJHkqbMiHZWIq29Gv+ebk79u
	ZCViboQibIeRxbaZhchCANn7ln3CakAMbtm+RvyO0qvlfMLm6EWlK+wsYABvz5pc
	fUtmGwgr/CWlTvsYs3rhb42oca6O6qaypLvZAz0nWpubXoEP/ScdMGcmuK0PcyQK
	Jdo6cVkqej3YNQMAt3c/zQvxGrBO/wV0za+RLWrEoQyj6pKAe0QoJVTg6ShlGKc/
	jfQpwZWqrfwsHlvgAFWyQ8uparyAcnW+kp4sKlhIpQHxOW01aqvZGQjMd6BFO6Gz
	r0O8Z46FZamF4tWuvg5zAytP86KiuZ8TOCFc8O/yNcVqKhsuygiYkTehVNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724725; x=1709811125; bh=aDn9jp0ydOnITE61NItouuP4rIFJ
	0/kXfSafXSAV8Xg=; b=R2R6Cd7HX8RjKbR+o66RfHE772bLTzSDgWQUGSlxTG14
	OCmROZnyzdA5Uw0ELg6MMNWmVm6gWes0OTzhVWigD28rCnOPbcExLGr2Rq9F7zpj
	ClIDqboe5e0ui509e3DCVU3Iq6IZryQBzW3a76eggjvaiF2CgYnTGp+WEOtsUev4
	sV6Hz2Z28TdcMI9T0VbWfx3gmBiMtV9Z2bGbBZ0KjkJh4jH/GWj2Wgy6PTVydikr
	j2MJesE50SCobHKQlM7pWquJxbYymM45PZ4f6hUPX7ThU1KbMnk+QfgG/sWpJoI0
	LGNk9TladvbLe8gCT6n+iJTTsJCjsPK+caQcOkOkbg==
X-ME-Sender: <xms:NVToZUWIQX-BdDRAnU0M83syt20vTQWg0FvUT3qTUT0FwcrY6W1wXQ>
    <xme:NVToZYkf58wYei7VlhZPGJwE5Hj7v5NG-mLEjwaXnEl0ybVgKYGWqcrnySZ8S_abC
    S8ElgGq13rYxfPiLg>
X-ME-Received: <xmr:NVToZYbbabyM5N08RtKym9eYg1RZqDj4Hs71asC_CRdwEYZJCxeSNflt_Ga7kZ3gfnbWz7vF0C29KOpwXjJhYnfgxTb7o-O-pUpMbJq7MZckUAqCiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeduvdfgkeefheeggffhvddvhfefhfeutdevtd
    ejudfhudejffeiheelffelhfefveenucffohhmrghinhepughifhhfrdhnvgifpdhkvghr
    nhgvlhdrohhrghdpvgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NVToZTVIuCx8_-UgixasZdynrAEfY5I8DgIW1UsZOTSopPiJrCdi4A>
    <xmx:NVToZekgdl7L3B8ud84nOi-rt7bj-tICAxeQouOE-Mx9JaAfjulK3Q>
    <xmx:NVToZYf1jz_WJ1WHuFubxE17cScZY7AVrUi6RDi_-J6Xn_PL5LS0oA>
    <xmx:NVToZStFmq422Cs0Tac1kh9_wcNWPhu_zwpiRigDBwNZgXvvAuWDsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:32:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85c6a48c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:35 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:32:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/8] Documentation/git-config: update to new-style syntax
Message-ID: <5ff2bf4a2286431a3b3048e0ea04d6551006d0d7.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XYXUBkRmd/5Bbudu"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--XYXUBkRmd/5Bbudu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update our documentation of git-config(1) to stop mentioning the old
syntax while starting to mention the new syntax. Remove the help
mismatch in t0450 so that we start to ensure that the manpage and
builtin synopsis match.

Note that there will still be lots of mentions of the old style syntax
of git-config(1) throughout our documentation. This documentation will
be updated over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 204 ++++++++++++++++++-----------------
 builtin/config.c             |  46 +++++---
 t/t0450/txt-help-mismatches  |   1 -
 3 files changed, 137 insertions(+), 114 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index dff39093b5..edf67c85f7 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,21 +9,22 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--show-ori=
gin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
-'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
-'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --replace-a=
ll <name> <value> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<v=
alue-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [-z|--null] --get-urlmatch =
<name> <URL>
-'git config' [<file-option>] [--fixed-value] --unset <name> [<value-patter=
n>]
-'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
-'git config' [<file-option>] --rename-section <old-name> <new-name>
-'git config' [<file-option>] --remove-section <name>
-'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [-=
-name-only] -l | --list
-'git config' [<file-option>] --get-color <name> [<default>]
-'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
-'git config' [<file-option>] -e | --edit
+'git config list' [<file-option>] [--show-origin] [--show-scope] [-z|--nul=
l] [--name-only]
+'git config get' [<file-option>] [--type=3D<type>] [--show-origin] [--show=
-scope] [-z|--null] [--fixed-value] <name> [<value-pattern>]
+'git config get-all' [<file-option>] [--type=3D<type>] [--show-origin] [--=
show-scope] [-z|--null] [--fixed-value] <name> [<value-pattern>]
+'git config get-color' [<file-option>] <name> [<default>]
+'git config get-colorbool' [<file-option>] <name> [<stdout-is-tty>]
+'git config get-regexp' [<file-option>] [--type=3D<type>] [--show-origin] =
[--show-scope] [-z|--null] [--fixed-value] [--name-only] <name-regex> [<val=
ue-pattern>]
+'git config get-urlmatch' [<file-option>] [--type=3D<type>] [-z|--null] <n=
ame> <URL>
+'git config add' [<file-option>] [--type=3D<type>] <name> <value>
+'git config set' [<file-option>] [--type=3D<type>] <name> <value>
+'git config set-all' [<file-option>] [--type=3D<type>] [--fixed-value] <na=
me> <value> [<value-pattern>]
+'git config unset' [<file-option>] [--fixed-value] <name> [<value-pattern>]
+'git config unset-all' [<file-option>] [--fixed-value] <name> [<value-patt=
ern>]
+'git config replace-all' [<file-option>] [--type=3D<type>] [--fixed-value]=
 <name> <value> [<value-pattern>]
+'git config rename-section' [<file-option>] <old-name> <new-name>
+'git config remove-section' [<file-option>] <name>
+'git config edit' [<file-option>]
=20
 DESCRIPTION
 -----------
@@ -74,35 +75,50 @@ On success, the command returns the exit code 0.
 A list of all available configuration variables can be obtained using the
 `git help --config` command.
=20
-[[OPTIONS]]
-OPTIONS
--------
-
---replace-all::
-	Default behavior is to replace at most one line. This replaces
-	all lines matching the key (and optionally the `value-pattern`).
+COMMANDS
+--------
=20
---add::
-	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the `value-pattern`
-	in `--replace-all`.
+list::
+	List all variables set in config file, along with their values.
=20
---get::
+get <name> [<value-pattern>]::
 	Get the value for a given key (optionally filtered by a regex
 	matching the value). Returns error code 1 if the key was not
 	found and the last value if multiple key values were found.
=20
---get-all::
+get-all <name> [<value-pattern>]::
 	Like get, but returns all values for a multi-valued key.
=20
---get-regexp::
-	Like --get-all, but interprets the name as a regular expression and
+get-color <name> [<default>]::
+
+	Find the color configured for `name` (e.g. `color.diff.new`) and
+	output it as the ANSI color escape sequence to the standard
+	output.  The optional `default` parameter is used instead, if
+	there is no color configured for `name`.
++
+`--type=3Dcolor [--default=3D<default>]` is preferred over `get-color`
+(but note that `get-color` will omit the trailing newline printed by
+`--type=3Dcolor`).
+
+get-colorbool <name> [<stdout-is-tty>]::
+
+	Find the color setting for `<name>` (e.g. `color.diff`) and output
+	"true" or "false".  `<stdout-is-tty>` should be either "true" or
+	"false", and is taken into account when configuration says
+	"auto".  If `<stdout-is-tty>` is missing, then checks the standard
+	output of the command itself, and exits with status 0 if color
+	is to be used, or exits with status 1 otherwise.
+	When the color setting for `name` is undefined, the command uses
+	`color.ui` as fallback.
+
+get-regex <name-regex> [<value-pattern>]::
+	Like `get-all`, but interprets the name as a regular expression and
 	writes out the key names.  Regular expression matching is currently
 	case-sensitive and done against a canonicalized version of the key
 	in which section and variable names are lowercased, but subsection
 	names are not.
=20
---get-urlmatch <name> <URL>::
+get-urlmatch <name> <URL>::
 	When given a two-part <name> as <section>.<key>, the value for
 	<section>.<URL>.<key> whose <URL> part matches the best to the
 	given URL is returned (if no such key exists, the value for
@@ -110,6 +126,43 @@ OPTIONS
 	<section> as name, do so for all the keys in the section and
 	list them.  Returns error code 1 if no value is found.
=20
+add <name> <value>::
+	Adds a new line to the option without altering any existing
+	values.  This is the same as providing '^$' as the `value-pattern`
+	in `--replace-all`.
+
+set <name> <value>::
+	Set the config key to the given value. Adds a new key to the
+	configuration in case it does not yet exist. This subcommand fails when
+	the key has multiple values.
+
+set-all <name> <value> [<value-pattern>]::
+	Set all config keys to the given value.
+
+unset <name> [<value-pattern>]::
+	Remove the line matching the key from config file.
+
+unset-all <name> [<value-pattern>]::
+	Remove all lines matching the key from config file.
+
+replace-all <name> <value> [<value-pattern>]::
+	Default behavior is to replace at most one line. This replaces
+	all lines matching the key (and optionally the `value-pattern`).
+
+remove-section <name>::
+	Remove the given section from the configuration file.
+
+rename-section <old-name> <new-name>::
+	Rename the given section to a new name.
+
+edit::
+	Opens an editor to modify the specified config file; either
+	`--system`, `--global`, or repository (default).
+
+[[OPTIONS]]
+OPTIONS
+-------
+
 --global::
 	For writing options: write to global `~/.gitconfig` file
 	rather than the repository `.git/config`, write to
@@ -166,22 +219,6 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
=20
---remove-section::
-	Remove the given section from the configuration file.
-
---rename-section::
-	Rename the given section to a new name.
-
---unset::
-	Remove the line matching the key from config file.
-
---unset-all::
-	Remove all lines matching the key from config file.
-
--l::
---list::
-	List all variables set in config file, along with their values.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -236,8 +273,8 @@ Valid `<type>`'s include:
 	contain line breaks.
=20
 --name-only::
-	Output only the names of config variables for `--list` or
-	`--get-regexp`.
+	Output only the names of config variables for `list` or
+	`get-regexp`.
=20
 --show-origin::
 	Augment the output of all queried config options with the
@@ -250,33 +287,6 @@ Valid `<type>`'s include:
 	all queried config options with the scope of that value
 	(worktree, local, global, system, command).
=20
---get-colorbool <name> [<stdout-is-tty>]::
-
-	Find the color setting for `<name>` (e.g. `color.diff`) and output
-	"true" or "false".  `<stdout-is-tty>` should be either "true" or
-	"false", and is taken into account when configuration says
-	"auto".  If `<stdout-is-tty>` is missing, then checks the standard
-	output of the command itself, and exits with status 0 if color
-	is to be used, or exits with status 1 otherwise.
-	When the color setting for `name` is undefined, the command uses
-	`color.ui` as fallback.
-
---get-color <name> [<default>]::
-
-	Find the color configured for `name` (e.g. `color.diff.new`) and
-	output it as the ANSI color escape sequence to the standard
-	output.  The optional `default` parameter is used instead, if
-	there is no color configured for `name`.
-+
-`--type=3Dcolor [--default=3D<default>]` is preferred over `--get-color`
-(but note that `--get-color` will omit the trailing newline printed by
-`--type=3Dcolor`).
-
--e::
---edit::
-	Opens an editor to modify the specified config file; either
-	`--system`, `--global`, or repository (default).
-
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to `off` when a specific file is given (e.g.,
@@ -284,13 +294,13 @@ Valid `<type>`'s include:
 	config files.
=20
 --default <value>::
-  When using `--get`, and the requested variable is not found, behave as if
+  When using `get`, and the requested variable is not found, behave as if
   <value> were the value assigned to the that variable.
=20
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
-using `--list` or any of the `--get-*` which may return multiple results.
+using `list` or any of the `get-*` subcommands which may return multiple r=
esults.
 The default is to use a pager.
=20
 [[FILES]]
@@ -333,8 +343,8 @@ precedence over values read earlier.  When multiple val=
ues are taken then all
 values of a key from all files will be used.
=20
 By default, options are only written to the repository specific
-configuration file. Note that this also affects options like `--replace-al=
l`
-and `--unset`. *'git config' will only ever change one file at a time*.
+configuration file. Note that this also affects subcommands like `replace-=
all`
+and `unset`. *'git config' will only ever change one file at a time*.
=20
 You can limit which configuration sources are read from or written to by
 specifying the path of a file with the `--file` option, or by specifying a
@@ -469,7 +479,7 @@ Given a .git/config like this:
 you can set the filemode to true with
=20
 ------------
-% git config core.filemode true
+% git config set core.filemode true
 ------------
=20
 The hypothetical proxy command entries actually have a postfix to discern
@@ -477,7 +487,7 @@ what URL they apply to. Here is how to change the entry=
 for kernel.org
 to "ssh".
=20
 ------------
-% git config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
+% git config set core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
 ------------
=20
 This makes sure that only the key/value pair for kernel.org is replaced.
@@ -485,7 +495,7 @@ This makes sure that only the key/value pair for kernel=
=2Eorg is replaced.
 To delete the entry for renames, do
=20
 ------------
-% git config --unset diff.renames
+% git config unset diff.renames
 ------------
=20
 If you want to delete an entry for a multivar (like core.gitproxy above),
@@ -494,51 +504,51 @@ you have to provide a regex matching the value of exa=
ctly one line.
 To query the value for a given key, do
=20
 ------------
-% git config --get core.filemode
+% git config get core.filemode
 ------------
=20
 or
=20
 ------------
-% git config core.filemode
+% git config get core.filemode
 ------------
=20
 or, to query a multivar:
=20
 ------------
-% git config --get core.gitproxy "for kernel.org$"
+% git config get core.gitproxy "for kernel.org$"
 ------------
=20
 If you want to know all the values for a multivar, do:
=20
 ------------
-% git config --get-all core.gitproxy
+% git config get-all core.gitproxy
 ------------
=20
 If you like to live dangerously, you can replace *all* core.gitproxy by a
 new one with
=20
 ------------
-% git config --replace-all core.gitproxy ssh
+% git config replace-all core.gitproxy ssh
 ------------
=20
 However, if you really only want to replace the line for the default proxy,
 i.e. the one without a "for ..." postfix, do something like this:
=20
 ------------
-% git config core.gitproxy ssh '! for '
+% git config get core.gitproxy ssh '! for '
 ------------
=20
 To actually match only values with an exclamation mark, you have to
=20
 ------------
-% git config section.key value '[!]'
+% git config get section.key value '[!]'
 ------------
=20
 To add a new proxy, without altering any of the existing ones, use
=20
 ------------
-% git config --add core.gitproxy '"proxy-command" for example.com'
+% git config add core.gitproxy '"proxy-command" for example.com'
 ------------
=20
 An example to use customized color from the configuration in your
@@ -546,8 +556,8 @@ script:
=20
 ------------
 #!/bin/sh
-WS=3D$(git config --get-color color.diff.whitespace "blue reverse")
-RESET=3D$(git config --get-color "" "reset")
+WS=3D$(git config get-color color.diff.whitespace "blue reverse")
+RESET=3D$(git config get-color "" "reset")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
=20
@@ -555,11 +565,11 @@ For URLs in `https://weak.example.com`, `http.sslVeri=
fy` is set to
 false, while it is set to `true` for all others:
=20
 ------------
-% git config --type=3Dbool --get-urlmatch http.sslverify https://good.exam=
ple.com
+% git config get-urlmatch --type=3Dbool http.sslverify https://good.exampl=
e.com
 true
-% git config --type=3Dbool --get-urlmatch http.sslverify https://weak.exam=
ple.com
+% git config get-urlmatch --type=3Dbool http.sslverify https://weak.exampl=
e.com
 false
-% git config --get-urlmatch http https://weak.example.com
+% git config get-urlmatch http https://weak.example.com
 http.cookieFile /tmp/cookie.txt
 http.sslverify false
 ------------
@@ -578,7 +588,7 @@ looks like
     key =3D value1
 --------
=20
-and running `git config section.Subsection.key value2` will result in
+and running `git config add section.Subsection.key value2` will result in
=20
 --------
   [section.subsection]
diff --git a/builtin/config.c b/builtin/config.c
index 10fa933931..61a9ad3eaa 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -16,7 +16,22 @@
 #include "worktree.h"
=20
 static const char *const builtin_config_usage[] =3D {
-	N_("git config [<options>]"),
+	N_("git config list [<file-option>] [--show-origin] [--show-scope] [-z|--=
null] [--name-only]"),
+	N_("git config get [<file-option>] [--type=3D<type>] [--show-origin] [--s=
how-scope] [-z|--null] [--fixed-value] <name> [<value-pattern>]"),
+	N_("git config get-all [<file-option>] [--type=3D<type>] [--show-origin] =
[--show-scope] [-z|--null] [--fixed-value] <name> [<value-pattern>]"),
+	N_("git config get-color [<file-option>] <name> [<default>]"),
+	N_("git config get-colorbool [<file-option>] <name> [<stdout-is-tty>]"),
+	N_("git config get-regexp [<file-option>] [--type=3D<type>] [--show-origi=
n] [--show-scope] [-z|--null] [--fixed-value] [--name-only] <name-regex> [<=
value-pattern>]"),
+	N_("git config get-urlmatch [<file-option>] [--type=3D<type>] [-z|--null]=
 <name> <URL>"),
+	N_("git config add [<file-option>] [--type=3D<type>] <name> <value>"),
+	N_("git config set [<file-option>] [--type=3D<type>] <name> <value>"),
+	N_("git config set-all [<file-option>] [--type=3D<type>] [--fixed-value] =
<name> <value> [<value-pattern>]"),
+	N_("git config unset [<file-option>] [--fixed-value] <name> [<value-patte=
rn>]"),
+	N_("git config unset-all [<file-option>] [--fixed-value] <name> [<value-p=
attern>]"),
+	N_("git config replace-all [<file-option>] [--type=3D<type>] [--fixed-val=
ue] <name> <value> [<value-pattern>]"),
+	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
+	N_("git config remove-section [<file-option>] <name>"),
+	N_("git config edit [<file-option>]"),
 	NULL
 };
=20
@@ -887,21 +902,20 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
-	OPT_GROUP(N_("Action")),
-	OPT_CMDMODE(0, "get", &action, N_("get value: name [value-pattern]"), ACT=
ION_GET),
-	OPT_CMDMODE(0, "get-all", &action, N_("get all values: key [value-pattern=
]"), ACTION_GET_ALL),
-	OPT_CMDMODE(0, "get-regexp", &action, N_("get values for regexp: name-reg=
ex [value-pattern]"), ACTION_GET_REGEXP),
-	OPT_CMDMODE(0, "get-urlmatch", &action, N_("get value specific for the UR=
L: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_CMDMODE(0, "replace-all", &action, N_("replace all matching variables=
: name value [value-pattern]"), ACTION_REPLACE_ALL),
-	OPT_CMDMODE(0, "add", &action, N_("add a new variable: name value"), ACTI=
ON_ADD),
-	OPT_CMDMODE(0, "unset", &action, N_("remove a variable: name [value-patte=
rn]"), ACTION_UNSET),
-	OPT_CMDMODE(0, "unset-all", &action, N_("remove all matches: name [value-=
pattern]"), ACTION_UNSET_ALL),
-	OPT_CMDMODE(0, "rename-section", &action, N_("rename section: old-name ne=
w-name"), ACTION_RENAME_SECTION),
-	OPT_CMDMODE(0, "remove-section", &action, N_("remove a section: name"), A=
CTION_REMOVE_SECTION),
-	OPT_CMDMODE('l', "list", &action, N_("list all"), ACTION_LIST),
-	OPT_CMDMODE('e', "edit", &action, N_("open an editor"), ACTION_EDIT),
-	OPT_CMDMODE(0, "get-color", &action, N_("find the color configured: slot =
[default]"), ACTION_GET_COLOR),
-	OPT_CMDMODE(0, "get-colorbool", &action, N_("find the color setting: slot=
 [stdout-is-tty]"), ACTION_GET_COLORBOOL),
+	OPT_CMDMODE_F(0, "get", &action, N_("get value: name [value-pattern]"), A=
CTION_GET, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "get-all", &action, N_("get all values: key [value-patte=
rn]"), ACTION_GET_ALL, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "get-regexp", &action, N_("get values for regexp: name-r=
egex [value-pattern]"), ACTION_GET_REGEXP, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "get-urlmatch", &action, N_("get value specific for the =
URL: section[.var] URL"), ACTION_GET_URLMATCH, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "replace-all", &action, N_("replace all matching variabl=
es: name value [value-pattern]"), ACTION_REPLACE_ALL, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "add", &action, N_("add a new variable: name value"), AC=
TION_ADD, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "unset", &action, N_("remove a variable: name [value-pat=
tern]"), ACTION_UNSET, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "unset-all", &action, N_("remove all matches: name [valu=
e-pattern]"), ACTION_UNSET_ALL, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "rename-section", &action, N_("rename section: old-name =
new-name"), ACTION_RENAME_SECTION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "remove-section", &action, N_("remove a section: name"),=
 ACTION_REMOVE_SECTION, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F('l', "list", &action, N_("list all"), ACTION_LIST, PARSE_OP=
T_HIDDEN),
+	OPT_CMDMODE_F('e', "edit", &action, N_("open an editor"), ACTION_EDIT, PA=
RSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "get-color", &action, N_("find the color configured: slo=
t [default]"), ACTION_GET_COLOR, PARSE_OPT_HIDDEN),
+	OPT_CMDMODE_F(0, "get-colorbool", &action, N_("find the color setting: sl=
ot [stdout-is-tty]"), ACTION_GET_COLORBOOL, PARSE_OPT_HIDDEN),
 	OPT_GROUP(N_("Type")),
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index a0777acd66..28003f18c9 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -10,7 +10,6 @@ checkout
 checkout-index
 clone
 column
-config
 credential
 credential-cache
 credential-store
--=20
2.44.0


--XYXUBkRmd/5Bbudu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVDIACgkQVbJhu7ck
PpSrYQ/+P0Jmp+ipwMj3Ds8Joms81PR4TN3o77Dn+8Sq5SV5tkDhswD1EinP6d/F
wN/Ztv5puI5hyLgwrLIrEiYxWaUSv7apasFS8xPru9l5D3CPGUwwitEHWXnLpyCZ
Ud/c7TC4cHKNyIhzDmBDTGSx5ciIP62jtyL2sbRUEtBZ52v6s3RypOHRc3xsXXog
skpYLIBU0YeAIq25a/ugdsM7+i2dBhoEPO0e7MlKsZ7+6on8IaXmGjLpzPjhChVf
rVFLsVTcD23GmNVt6/425OAvEx0/a7SwdkWu3kI5Ojs7h9z8pWUGdiuOZ7EWp2ib
F4OfRgmOTI7JM+jPPcTeL0Fgn2savIczGXtGhB6pZCEIu09GUzHgVNLKofeCptSC
wiez3/mLWuHQaG4hVde3poSrp6rQgPiDo59drBYtBxxG0aI+A6eoS7lD3Aay57jf
7+phNTfmVMAoLq7o2TO91UVVatjnpswX/oSY4S+B7CcaGL4c8apdgSeDWIKv83Yu
BaDqAoIzxa8lJvQ2zr5n2thXL/91j0QDgo569SYV/bipfpgFJxdD8m7oRzyhyGsj
oLitFQXEaZ7KGFIkbYwU6iGvRZ5cbrP+7aRZ+1/u6AS0njpTlegzmT3qpqZFgDOh
TxS35MYrBQYICk6880VVdbzvHsaGEK4UWz1yXaY4BmaD2TFonHY=
=QKma
-----END PGP SIGNATURE-----

--XYXUBkRmd/5Bbudu--
