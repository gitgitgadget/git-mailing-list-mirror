From: jari.aalto@cante.net
Subject: [PATCH v3] Documentation/config.txt: Order variables alphabetically
Date: Wed,  1 Dec 2010 17:25:54 +0200
Organization: Private
Message-ID: <31def5a4a6256e6fdef8a03372cda98460f61c47.1291217124.git.jari.aalto@cante.net>
References: <87eia1wo5v.fsf@picasso.cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoZM-0002KW-FV
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab0LAP0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:26:00 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:37416 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab0LAPZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:25:59 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 6CE85EBD6D
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:25:57 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A008422CE84; Wed, 01 Dec 2010 17:25:57 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3A077E51A3
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:25:54 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNoZ8-0003Jm-Bt; Wed, 01 Dec 2010 17:25:54 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <87eia1wo5v.fsf@picasso.cante.net>
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162531>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/config.txt | 1671 +++++++++++++++++++++++-----------------=
------
 1 files changed, 839 insertions(+), 832 deletions(-)



    On 2010-12-01 05:58, Jakub Narebski wrote:
    | Note that currently config variables are grouped by functionality: =
for
    | example core.eol and core.safecrlf, or core.compression and
    | core.loosecompression are close to each other.

    revised: Add "see also" for repective options as suggested by Jakub



diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6a6c0b5..7839fd7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -145,310 +145,248 @@ advice.*::
 		a local branch after the fact.  Default: true.
 --
=20
-core.fileMode::
-	If false, the executable bit differences between the index and
-	the working copy are ignored; useful on broken filesystems like FAT.
-	See linkgit:git-update-index[1].
+add.ignore-errors::
+	Tells 'git add' to continue adding files when some files cannot be
+	added due to indexing errors. Equivalent to the '--ignore-errors'
+	option of linkgit:git-add[1].
+
+alias.*::
+	Command aliases for the linkgit:git[1] command wrapper - e.g.
+	after defining "alias.last =3D cat-file commit HEAD", the invocation
+	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	confusion and troubles with script usage, aliases that
+	hide existing git commands are ignored. Arguments are split by
+	spaces, the usual shell quoting and escaping is supported.
+	quote pair and a backslash can be used to quote them.
 +
-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
-will probe and set core.fileMode false if appropriate when the
-repository is created.
+If the alias expansion is prefixed with an exclamation point,
+it will be treated as a shell command.  For example, defining
+"alias.new =3D !gitk --all --not ORIG_HEAD", the invocation
+"git new" is equivalent to running the shell command
+"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+executed from the top-level directory of a repository, which may
+not necessarily be the current directory.
=20
-core.ignoreCygwinFSTricks::
-	This option is only used by Cygwin implementation of Git. If false,
-	the Cygwin stat() and lstat() functions are used. This may be useful
-	if your repository consists of a few separate directories joined in
-	one hierarchy using Cygwin mount. If true, Git uses native Win32 API
-	whenever it is possible and falls back to Cygwin functions only to
-	handle symbol links. The native mode is more than twice faster than
-	normal Cygwin l/stat() functions. True by default, unless core.filemode
-	is true, in which case ignoreCygwinFSTricks is ignored as Cygwin's
-	POSIX emulation is required to support core.filemode.
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format
+	with parameter '--keep-cr'. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. Can be overridden
+	by giving '--no-keep-cr' from the command line.
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
=20
-core.ignorecase::
-	If true, this option enables various workarounds to enable
-	git to work better on filesystems that are not case sensitive,
-	like FAT. For example, if a directory listing finds
-	"makefile" when git expects "Makefile", git will assume
-	it is really the same file, and continue to remember it as
-	"Makefile".
-+
-The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
-will probe and set core.ignorecase true if appropriate when the reposito=
ry
-is created.
+apply.ignorewhitespace::
+	When set to 'change', tells 'git apply' to ignore changes in
+	whitespace, in the same way as the '--ignore-space-change'
+	option.
+	When set to one of: no, none, never, false tells 'git apply' to
+	respect all whitespace differences.
+	See linkgit:git-apply[1].
=20
-core.trustctime::
-	If false, the ctime differences between the index and the
-	working copy are ignored; useful when the inode change time
-	is regularly modified by something outside Git (file system
-	crawlers and some backup systems).
-	See linkgit:git-update-index[1]. True by default.
+apply.whitespace::
+	Tells 'git apply' how to handle whitespaces, in the same way
+	as the '--whitespace' option. See linkgit:git-apply[1].
=20
-core.quotepath::
-	The commands that output paths (e.g. 'ls-files',
-	'diff'), when not given the `-z` option, will quote
-	"unusual" characters in the pathname by enclosing the
-	pathname in a double-quote pair and with backslashes the
-	same way strings in C source code are quoted.  If this
-	variable is set to false, the bytes higher than 0x80 are
-	not quoted but output as verbatim.  Note that double
-	quote, backslash and control characters are always
-	quoted without `-z` regardless of the setting of this
-	variable.
+branch.<name>.merge::
+	Defines, together with branch.<name>.remote, the upstream branch
+	for the given branch. It tells 'git fetch'/'git pull' which
+	branch to merge and can also affect 'git push' (see push.default).
+	When in branch <name>, it tells 'git fetch' the default
+	refspec to be marked for merging in FETCH_HEAD. The value is
+	handled like the remote part of a refspec, and must match a
+	ref which is fetched from the remote given by
+	"branch.<name>.remote".
+	The merge information is used by 'git pull' (which at first calls
+	'git fetch') to lookup the default branch for merging. Without
+	this option, 'git pull' defaults to merge the first refspec fetched.
+	Specify multiple values to get an octopus merge.
+	If you wish to setup 'git pull' so that it merges into <name> from
+	another branch in the local repository, you can point
+	branch.<name>.merge to the desired branch, and use the special setting
+	`.` (a period) for branch.<name>.remote.
=20
-core.eol::
-	Sets the line ending type to use in the working directory for
-	files that have the `text` property set.  Alternatives are
-	'lf', 'crlf' and 'native', which uses the platform's native
-	line ending.  The default value is `native`.  See
-	linkgit:gitattributes[5] for more information on end-of-line
-	conversion.
+branch.<name>.mergeoptions::
+	Sets default options for merging into branch <name>. The syntax and
+	supported options are the same as those of linkgit:git-merge[1], but
+	option values containing whitespace characters are currently not
+	supported.
=20
-core.safecrlf::
-	If true, makes git check if converting `CRLF` is reversible when
-	end-of-line conversion is active.  Git will verify if a command
-	modifies a file in the work tree either directly or indirectly.
-	For example, committing a file followed by checking out the
-	same file should yield the original file in the work tree.  If
-	this is not the case for the current setting of
-	`core.autocrlf`, git will reject the file.  The variable can
-	be set to "warn", in which case git will only warn about an
-	irreversible conversion but continue the operation.
-+
-CRLF conversion bears a slight chance of corrupting data.
-When it is enabled, git will convert CRLF to LF during commit and LF to
-CRLF during checkout.  A file that contains a mixture of LF and
-CRLF before the commit cannot be recreated by git.  For text
-files this is the right thing to do: it corrects line endings
-such that we have only LF line endings in the repository.
-But for binary files that are accidentally classified as text the
-conversion can corrupt data.
-+
-If you recognize such corruption early you can easily fix it by
-setting the conversion type explicitly in .gitattributes.  Right
-after committing you still have the original file in your work
-tree and this file is not yet corrupted.  You can explicitly tell
-git that this file is binary and git will handle the file
-appropriately.
-+
-Unfortunately, the desired effect of cleaning up text files with
-mixed line endings and the undesired effect of corrupting binary
-files cannot be distinguished.  In both cases CRLFs are removed
-in an irreversible way.  For text files this is the right thing
-to do because CRLFs are line endings, while for binary files
-converting CRLFs corrupts data.
-+
-Note, this safety check does not mean that a checkout will generate a
-file identical to the original file for a different setting of
-`core.eol` and `core.autocrlf`, but only for the current one.  For
-example, a text file with `LF` would be accepted with `core.eol=3Dlf`
-and could later be checked out with `core.eol=3Dcrlf`, in which case the
-resulting file would contain `CRLF`, although the original file
-contained `LF`.  However, in both work trees the line endings would be
-consistent, that is either all `LF` or all `CRLF`, but never mixed.  A
-file with mixed line endings would be reported by the `core.safecrlf`
-mechanism.
+branch.<name>.rebase::
+	When true, rebase the branch <name> on top of the fetched branch,
+	instead of merging the default branch from the default remote when
+	"git pull" is run.
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand the implications (see linkgit:git-rebase[1]
+	for details).
=20
-core.autocrlf::
-	Setting this variable to "true" is almost the same as setting
-	the `text` attribute to "auto" on all files except that text
-	files are not guaranteed to be normalized: files that contain
-	`CRLF` in the repository will not be touched.  Use this
-	setting if you want to have `CRLF` line endings in your
-	working directory even though the repository does not have
-	normalized line endings.  This variable can be set to 'input',
-	in which case no output conversion is performed.
+branch.<name>.remote::
+	When in branch <name>, it tells 'git fetch' and 'git push' which
+	remote to fetch from/push to.  It defaults to `origin` if no remote is
+	configured. `origin` is also used if you are not on any branch.
=20
-core.symlinks::
-	If false, symbolic links are checked out as small plain files that
-	contain the link text. linkgit:git-update-index[1] and
-	linkgit:git-add[1] will not change the recorded type to regular
-	file. Useful on filesystems like FAT that do not support
-	symbolic links.
-+
-The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
-will probe and set core.symlinks false if appropriate when the repositor=
y
-is created.
+branch.autosetupmerge::
+	Tells 'git branch' and 'git checkout' to set up new branches
+	so that linkgit:git-pull[1] will appropriately merge from the
+	starting point branch. Note that even if this option is not set,
+	this behavior can be chosen per-branch using the `--track`
+	and `--no-track` options. The valid settings are: `false` -- no
+	automatic setup is done; `true` -- automatic setup is done when the
+	starting point is a remote-tracking branch; `always` --
+	automatic setup is done when the starting point is either a
+	local branch or remote-tracking
+	branch. This option defaults to true.
=20
-core.gitProxy::
-	A "proxy command" to execute (as 'command host port') instead
-	of establishing direct connection to the remote server when
-	using the git protocol for fetching. If the variable value is
-	in the "COMMAND for DOMAIN" format, the command is applied only
-	on hostnames ending with the specified domain string. This variable
-	may be set multiple times and is matched in the given order;
-	the first match wins.
-+
-Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
-(which always applies universally, without the special "for"
-handling).
-+
-The special string `none` can be used as the proxy command to
-specify that no proxy be used for a given domain pattern.
-This is useful for excluding servers inside a firewall from
-proxy use, while defaulting to a common proxy for external domains.
+branch.autosetuprebase::
+	When a new branch is created with 'git branch' or 'git checkout'
+	that tracks another branch, this variable tells git to set
+	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	When `never`, rebase is never automatically set to true.
+	When `local`, rebase is set to true for tracked branches of
+	other local branches.
+	When `remote`, rebase is set to true for tracked branches of
+	remote-tracking branches.
+	When `always`, rebase will be set to true for all tracking
+	branches.
+	See "branch.autosetupmerge" for details on how to set up a
+	branch to track another branch.
+	This option defaults to never.
=20
-core.ignoreStat::
-	If true, commands which modify both the working tree and the index
-	will mark the updated paths with the "assume unchanged" bit in the
-	index. These marked files are then assumed to stay unchanged in the
-	working copy, until you	mark them otherwise manually - Git will not
-	detect the file changes	by lstat() calls. This is useful on systems
-	where those are very slow, such as Microsoft Windows.
-	See linkgit:git-update-index[1].
-	False by default.
+browser.<tool>.cmd::
+	Specify the command to invoke the specified browser. The
+	specified command is evaluated in shell with the URLs passed
+	as arguments. (See linkgit:git-web--browse[1].)
=20
-core.preferSymlinkRefs::
-	Instead of the default "symref" format for HEAD
-	and other symbolic reference files, use symbolic links.
-	This is sometimes needed to work with old scripts that
-	expect HEAD to be a symbolic link.
+browser.<tool>.path::
+	Override the path for the given tool that may be used to
+	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
+	working repository in gitweb (see linkgit:git-instaweb[1]).
=20
-core.bare::
-	If true this repository is assumed to be 'bare' and has no
-	working directory associated with it.  If this is the case a
-	number of commands that require a working directory will be
-	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
-+
-This setting is automatically guessed by linkgit:git-clone[1] or
-linkgit:git-init[1] when the repository was created.  By default a
-repository that ends in "/.git" is assumed to be not bare (bare =3D
-false), while all other repositories are assumed to be bare (bare
-=3D true).
+clean.requireForce::
+	A boolean to make git-clean do nothing unless given -f
+	or -n.   Defaults to true.
=20
-core.worktree::
-	Set the path to the root of the work tree.
-	This can be overridden by the GIT_WORK_TREE environment
-	variable and the '--work-tree' command line option. It can be
-	an absolute path or a relative path to the .git directory,
-	either specified by --git-dir or GIT_DIR, or automatically
-	discovered.
-	If --git-dir or GIT_DIR are specified but none of
-	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the root of the
-	work tree.
+color.branch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
+	only when the output is to a terminal. Defaults to false.
+
+color.branch.<slot>::
+	Use customized color for branch coloration. `<slot>` is one of
+	`current` (the current branch), `local` (a local branch),
+	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
+	refs).
 +
-Note that this variable is honored even when set in a configuration
-file in a ".git" subdirectory of a directory, and its value differs
-from the latter directory (e.g. "/path/to/.git/config" has
-core.worktree set to "/different/path"), which is most likely a
-misconfiguration.  Running git commands in "/path/to" directory will
-still use "/different/path" as the root of the work tree and can cause
-great confusion to the users.
+The value for these configuration variables is a list of colors (at most
+two) and attributes (at most one), separated by spaces.   The colors
+accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
+`magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
+`blink` and `reverse`.  The first color given is the foreground; the
+second is the background.  The position of the attribute, if any,
+doesn't matter.
+
+color.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.  `<slot>` is one
+	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
+	branches, remote-tracking branches, tags, stash and HEAD, respectively.
+
+color.diff::
+	When set to `always`, always use colors in patch.
+	When false (or `never`), never.   When set to `true` or `auto`, use
+	colors only when the output is to the terminal. Defaults to false.
=20
-core.logAllRefUpdates::
-	Enable the reflog. Updates to a ref <ref> is logged to the file
-	"$GIT_DIR/logs/<ref>", by appending the new and old
-	SHA1, the date/time and the reason of the update, but
-	only when the file exists.  If this configuration
-	variable is set to true, missing "$GIT_DIR/logs/<ref>"
-	file is automatically created for branch heads.
+color.diff.<slot>::
+	Use customized color for diff colorization.  `<slot>` specifies
+	which part of the patch to use the specified color, and is one
+	of `plain` (context text), `meta` (metainformation), `frag`
+	(hunk header), 'func' (function in hunk header), `old` (removed lines),
+	`new` (added lines), `commit` (commit headers), or `whitespace`
+	(highlighting whitespace errors). The values of these variables may be
+	specified as in color.branch.<slot>.
+
+color.grep::
+	When set to `always`, always highlight matches.   When `false` (or
+	`never`), never.  When set to `true` or `auto`, use color only
+	when the output is written to the terminal.  Defaults to `false`.
+
+color.grep.<slot>::
+	Use customized color for grep colorization.  `<slot>` specifies which
+	part of the line to use the specified color, and is one of
 +
-This information can be used to determine what commit
-was the tip of a branch "2 days ago".
+--
+`context`;;
+	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
+`filename`;;
+	filename prefix (when not using `-h`)
+`function`;;
+	function name lines (when using `-p`)
+`linenumber`;;
+	line number prefix (when using `-n`)
+`match`;;
+	matching text
+`selected`;;
+	non-matching text in selected lines
+`separator`;;
+	separators between fields on a line (`:`, `-`, and `=3D`)
+	and between hunks (`--`)
+--
 +
-This value is true by default in a repository that has
-a working directory associated with it, and false by
-default in a bare repository.
-
-core.repositoryFormatVersion::
-	Internal variable identifying the repository format and layout
-	version.
+The values of these variables may be specified as in color.branch.<slot>=
.
=20
-core.sharedRepository::
-	When 'group' (or 'true'), the repository is made shareable between
-	several users in a group (making sure all the files and objects are
-	group-writable). When 'all' (or 'world' or 'everybody'), the
-	repository will be readable by all users, additionally to being
-	group-shareable. When 'umask' (or 'false'), git will use permissions
-	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
-	files in the repository will have this mode value. '0xxx' will override
-	user's umask value (whereas the other options will only override
-	requested parts of the user's umask value). Examples: '0660' will make
-	the repo read/write-able for the owner and group, but inaccessible to
-	others (equivalent to 'group' unless umask is e.g. '0022'). '0640' is a
-	repository that is group-readable but not group-writable.
-	See linkgit:git-init[1]. False by default.
+color.interactive::
+	When set to `always`, always use colors for interactive prompts
+	and displays (such as those used by "git-add --interactive").
+	When false (or `never`), never.   When set to `true` or `auto`, use
+	colors only when the output is to the terminal. Defaults to false.
=20
-core.warnAmbiguousRefs::
-	If true, git will warn you if the ref name you passed it is ambiguous
-	and might match multiple refs in the .git/refs/ tree. True by default.
+color.interactive.<slot>::
+	Use customized color for 'git add --interactive'
+	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
+	four distinct types of normal output from interactive
+	commands.  The values of these variables may be specified as
+	in color.branch.<slot>.
=20
-core.compression::
-	An integer -1..9, indicating a default compression level.
-	-1 is the zlib default. 0 means no compression,
-	and 1..9 are various speed/size tradeoffs, 9 being slowest.
-	If set, this provides a default to other compression variables,
-	such as 'core.loosecompression' and 'pack.compression'.
+color.pager::
+	A boolean to enable/disable colored output when the pager is in
+	use (default is true).
=20
-core.loosecompression::
-	An integer -1..9, indicating the compression level for objects that
-	are not in a pack file. -1 is the zlib default. 0 means no
-	compression, and 1..9 are various speed/size tradeoffs, 9 being
-	slowest.  If not set,  defaults to core.compression.  If that is
-	not set,  defaults to 1 (best speed).
+color.showbranch::
+	A boolean to enable/disable color in the output of
+	linkgit:git-show-branch[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
+	only when the output is to a terminal. Defaults to false.
=20
-core.packedGitWindowSize::
-	Number of bytes of a pack file to map into memory in a
-	single mapping operation.  Larger window sizes may allow
-	your system to process a smaller number of large pack files
-	more quickly.  Smaller window sizes will negatively affect
-	performance due to increased calls to the operating system's
-	memory manager, but may improve performance when accessing
-	a large number of large pack files.
-+
-Default is 1 MiB if NO_MMAP was set at compile time, otherwise 32
-MiB on 32 bit platforms and 1 GiB on 64 bit platforms.  This should
-be reasonable for all users/operating systems.  You probably do
-not need to adjust this value.
-+
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+color.status::
+	A boolean to enable/disable color in the output of
+	linkgit:git-status[1]. May be set to `always`,
+	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
+	only when the output is to a terminal. Defaults to false.
=20
-core.packedGitLimit::
-	Maximum number of bytes to map simultaneously into memory
-	from pack files.  If Git needs to access more than this many
-	bytes at once to complete an operation it will unmap existing
-	regions to reclaim virtual address space within the process.
-+
-Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
-This should be reasonable for all users/operating systems, except on
-the largest projects.  You probably do not need to adjust this value.
-+
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+color.status.<slot>::
+	Use customized color for status colorization. `<slot>` is
+	one of `header` (the header text of the status message),
+	`added` or `updated` (files which are added but not committed),
+	`changed` (files which are changed but not added in the index),
+	`untracked` (files which are not tracked by git), or
+	`nobranch` (the color the 'no branch' warning is shown in, defaulting
+	to red). The values of these variables may be specified as in
+	color.branch.<slot>.
=20
-core.deltaBaseCacheLimit::
-	Maximum number of bytes to reserve for caching base objects
-	that may be referenced by multiple deltified objects.  By storing the
-	entire decompressed base objects in a cache Git is able
-	to avoid unpacking and decompressing frequently used base
-	objects multiple times.
-+
-Default is 16 MiB on all platforms.  This should be reasonable
-for all users/operating systems, except on the largest projects.
-You probably do not need to adjust this value.
-+
-Common unit suffixes of 'k', 'm', or 'g' are supported.
+color.ui::
+	When set to `always`, always use colors in all git commands which
+	are capable of colored output. When false (or `never`), never. When
+	set to `true` or `auto`, use colors only when the output is to the
+	terminal. When more specific variables of color.* are set, they always
+	take precedence over this setting. Defaults to false.
=20
-core.bigFileThreshold::
-	Files larger than this size are stored deflated, without
-	attempting delta compression.  Storing large files without
-	delta compression avoids excessive memory usage, at the
-	slight expense of increased disk usage.
-+
-Default is 512 MiB on all platforms.  This should be reasonable
-for most projects as source code and other text files can still
-be delta compressed, but larger binary media files won't be.
-+
-Common unit suffixes of 'k', 'm', or 'g' are supported.
-+
-Currently only linkgit:git-fast-import[1] honors this setting.
+commit.status::
+	A boolean to enable/disable inclusion of status information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to true.
=20
-core.excludesfile::
-	In addition to '.gitignore' (per-directory) and
-	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  "{tilde}/" is expanded
-	to the value of `$HOME` and "{tilde}user/" to the specified user's
-	home directory.  See linkgit:gitignore[5].
+commit.template::
+	Specify a file to use as the template for new commit messages.
+	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to th=
e
+	specified user's home directory.
=20
 core.askpass::
 	Some commands (e.g. svn and http interfaces) that interactively
@@ -465,71 +403,48 @@ core.attributesfile::
 	(see linkgit:gitattributes[5]). Path expansions are made the same
 	way as for `core.excludesfile`.
=20
-core.editor::
-	Commands such as `commit` and `tag` that lets you edit
-	messages by launching an editor uses the value of this
-	variable when it is set, and the environment variable
-	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
-
-core.pager::
-	The command that git will use to paginate output.  Can
-	be overridden with the `GIT_PAGER` environment
-	variable.  Note that git sets the `LESS` environment
-	variable to `FRSX` if it is unset when it runs the
-	pager.  One can change these settings by setting the
-	`LESS` variable to some other value.  Alternately,
-	these settings can be overridden on a project or
-	global basis by setting the `core.pager` option.
-	Setting `core.pager` has no affect on the `LESS`
-	environment variable behaviour above, so if you want
-	to override git's default settings this way, you need
-	to be explicit.  For example, to disable the S option
-	in a backward compatible manner, set `core.pager`
-	to `less -+$LESS -FRX`.  This will be passed to the
-	shell by git, which will translate the final command to
-	`LESS=3DFRSX less -+FRSX -FRX`.
+core.autocrlf::
+	Setting this variable to "true" is almost the same as setting
+	the `text` attribute to "auto" on all files except that text
+	files are not guaranteed to be normalized: files that contain
+	`CRLF` in the repository will not be touched.  Use this
+	setting if you want to have `CRLF` line endings in your
+	working directory even though the repository does not have
+	normalized line endings.  This variable can be set to 'input',
+	in which case no output conversion is performed.
=20
-core.whitespace::
-	A comma separated list of common whitespace problems to
-	notice.  'git diff' will use `color.diff.whitespace` to
-	highlight them, and 'git apply --whitespace=3Derror' will
-	consider them as errors.  You can prefix `-` to disable
-	any of them (e.g. `-trailing-space`):
+core.bare::
+	If true this repository is assumed to be 'bare' and has no
+	working directory associated with it.  If this is the case a
+	number of commands that require a working directory will be
+	disabled, such as linkgit:git-add[1] or linkgit:git-merge[1].
 +
-* `blank-at-eol` treats trailing whitespaces at the end of the line
-  as an error (enabled by default).
-* `space-before-tab` treats a space character that appears immediately
-  before a tab character in the initial indent part of the line as an
-  error (enabled by default).
-* `indent-with-non-tab` treats a line that is indented with 8 or more
-  space characters as an error (not enabled by default).
-* `tab-in-indent` treats a tab character in the initial indent part of
-  the line as an error (not enabled by default).
-* `blank-at-eof` treats blank lines added at the end of file as an error
-  (enabled by default).
-* `trailing-space` is a short-hand to cover both `blank-at-eol` and
-  `blank-at-eof`.
-* `cr-at-eol` treats a carriage-return at the end of line as
-  part of the line terminator, i.e. with it, `trailing-space`
-  does not trigger if the character before such a carriage-return
-  is not a whitespace (not enabled by default).
+This setting is automatically guessed by linkgit:git-clone[1] or
+linkgit:git-init[1] when the repository was created.  By default a
+repository that ends in "/.git" is assumed to be not bare (bare =3D
+false), while all other repositories are assumed to be bare (bare
+=3D true).
=20
-core.fsyncobjectfiles::
-	This boolean will enable 'fsync()' when writing object files.
+core.bigFileThreshold::
+	Files larger than this size are stored deflated, without
+	attempting delta compression.  Storing large files without
+	delta compression avoids excessive memory usage, at the
+	slight expense of increased disk usage.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteback=
").
-
-core.preloadindex::
-	Enable parallel index preload for operations like 'git diff'
+Default is 512 MiB on all platforms.  This should be reasonable
+for most projects as source code and other text files can still
+be delta compressed, but larger binary media files won't be.
 +
-This can speed up operations like 'git diff' and 'git status' especially
-on filesystems like NFS that have weak caching semantics and thus
-relatively high IO latencies.  With this set to 'true', git will do the
-index comparison to the filesystem data in parallel, allowing
-overlapping IO's.
+Common unit suffixes of 'k', 'm', or 'g' are supported.
++
+Currently only linkgit:git-fast-import[1] honors this setting.
+
+core.compression::
+	An integer -1..9, indicating a default compression level.
+	-1 is the zlib default. 0 means no compression,
+	and 1..9 are various speed/size tradeoffs, 9 being slowest.
+	If set, this provides a default to other compression variables,
+	such as 'core.loosecompression' and 'pack.compression'.
=20
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
@@ -540,261 +455,347 @@ On some file system/operating system combinations=
, this is unreliable.
 Set this config setting to 'rename' there; However, This will remove the
 check that makes sure that existing object files will not get overwritte=
n.
=20
-core.notesRef::
-	When showing commit messages, also show notes which are stored in
-	the given ref.  The ref must be fully qualified.  If the given
-	ref does not exist, it is not an error but means that no
-	notes should be printed.
+core.deltaBaseCacheLimit::
+	Maximum number of bytes to reserve for caching base objects
+	that may be referenced by multiple deltified objects.  By storing the
+	entire decompressed base objects in a cache Git is able
+	to avoid unpacking and decompressing frequently used base
+	objects multiple times.
 +
-This setting defaults to "refs/notes/commits", and it can be overridden =
by
-the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
-
-core.sparseCheckout::
-	Enable "sparse checkout" feature. See section "Sparse checkout" in
-	linkgit:git-read-tree[1] for more information.
-
-add.ignore-errors::
-	Tells 'git add' to continue adding files when some files cannot be
-	added due to indexing errors. Equivalent to the '--ignore-errors'
-	option of linkgit:git-add[1].
-
-alias.*::
-	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining "alias.last =3D cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
-	confusion and troubles with script usage, aliases that
-	hide existing git commands are ignored. Arguments are split by
-	spaces, the usual shell quoting and escaping is supported.
-	quote pair and a backslash can be used to quote them.
+Default is 16 MiB on all platforms.  This should be reasonable
+for all users/operating systems, except on the largest projects.
+You probably do not need to adjust this value.
 +
-If the alias expansion is prefixed with an exclamation point,
-it will be treated as a shell command.  For example, defining
-"alias.new =3D !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
+Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
-	with parameter '--keep-cr'. In this case git-mailsplit will
-	not remove `\r` from lines ending with `\r\n`. Can be overridden
-	by giving '--no-keep-cr' from the command line.
-	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+core.editor::
+	Commands such as `commit` and `tag` that lets you edit
+	messages by launching an editor uses the value of this
+	variable when it is set, and the environment variable
+	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
=20
-apply.ignorewhitespace::
-	When set to 'change', tells 'git apply' to ignore changes in
-	whitespace, in the same way as the '--ignore-space-change'
-	option.
-	When set to one of: no, none, never, false tells 'git apply' to
-	respect all whitespace differences.
-	See linkgit:git-apply[1].
+core.eol::
+	Sets the line ending type to use in the working directory for
+	files that have the `text` property set.  Alternatives are
+	'lf', 'crlf' and 'native', which uses the platform's native
+	line ending.  The default value is `native`.  See also
+	`core.safecrlf' and linkgit:gitattributes[5] for more
+	information on end-of-line conversion.
=20
-apply.whitespace::
-	Tells 'git apply' how to handle whitespaces, in the same way
-	as the '--whitespace' option. See linkgit:git-apply[1].
+core.excludesfile::
+	In addition to '.gitignore' (per-directory) and
+	'.git/info/exclude', git looks into this file for patterns
+	of files which are not meant to be tracked.  "{tilde}/" is expanded
+	to the value of `$HOME` and "{tilde}user/" to the specified user's
+	home directory.   See linkgit:gitignore[5].
=20
-branch.autosetupmerge::
-	Tells 'git branch' and 'git checkout' to set up new branches
-	so that linkgit:git-pull[1] will appropriately merge from the
-	starting point branch. Note that even if this option is not set,
-	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options. The valid settings are: `false` -- no
-	automatic setup is done; `true` -- automatic setup is done when the
-	starting point is a remote-tracking branch; `always` --
-	automatic setup is done when the starting point is either a
-	local branch or remote-tracking
-	branch. This option defaults to true.
+core.fileMode::
+	If false, the executable bit differences between the index and
+	the working copy are ignored; useful on broken filesystems like FAT.
+	See linkgit:git-update-index[1].
++
+The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.fileMode false if appropriate when the
+repository is created.
=20
-branch.autosetuprebase::
-	When a new branch is created with 'git branch' or 'git checkout'
-	that tracks another branch, this variable tells git to set
-	up pull to rebase instead of merge (see "branch.<name>.rebase").
-	When `never`, rebase is never automatically set to true.
-	When `local`, rebase is set to true for tracked branches of
-	other local branches.
-	When `remote`, rebase is set to true for tracked branches of
-	remote-tracking branches.
-	When `always`, rebase will be set to true for all tracking
-	branches.
-	See "branch.autosetupmerge" for details on how to set up a
-	branch to track another branch.
-	This option defaults to never.
+ core.fsyncobjectfiles::
+	This boolean will enable 'fsync()' when writing object files.
++
+This is a total waste of time and effort on a filesystem that orders
+data writes properly, but can be useful for filesystems that do not use
+journalling (traditional UNIX filesystems) or that only journal metadata
+and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteback=
").
=20
-branch.<name>.remote::
-	When in branch <name>, it tells 'git fetch' and 'git push' which
-	remote to fetch from/push to.  It defaults to `origin` if no remote is
-	configured. `origin` is also used if you are not on any branch.
+core.gitProxy::
+	A "proxy command" to execute (as 'command host port') instead
+	of establishing direct connection to the remote server when
+	using the git protocol for fetching. If the variable value is
+	in the "COMMAND for DOMAIN" format, the command is applied only
+	on hostnames ending with the specified domain string. This variable
+	may be set multiple times and is matched in the given order;
+	the first match wins.
++
+Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
+(which always applies universally, without the special "for"
+handling).
++
+The special string `none` can be used as the proxy command to
+specify that no proxy be used for a given domain pattern.
+This is useful for excluding servers inside a firewall from
+proxy use, while defaulting to a common proxy for external domains.
=20
-branch.<name>.merge::
-	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull' which
-	branch to merge and can also affect 'git push' (see push.default).
-	When in branch <name>, it tells 'git fetch' the default
-	refspec to be marked for merging in FETCH_HEAD. The value is
-	handled like the remote part of a refspec, and must match a
-	ref which is fetched from the remote given by
-	"branch.<name>.remote".
-	The merge information is used by 'git pull' (which at first calls
-	'git fetch') to lookup the default branch for merging. Without
-	this option, 'git pull' defaults to merge the first refspec fetched.
-	Specify multiple values to get an octopus merge.
-	If you wish to setup 'git pull' so that it merges into <name> from
-	another branch in the local repository, you can point
-	branch.<name>.merge to the desired branch, and use the special setting
-	`.` (a period) for branch.<name>.remote.
+core.ignorecase::
+	If true, this option enables various workarounds to enable
+	git to work better on filesystems that are not case sensitive,
+	like FAT. For example, if a directory listing finds
+	"makefile" when git expects "Makefile", git will assume
+	it is really the same file, and continue to remember it as
+	"Makefile".
++
+The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.ignorecase true if appropriate when the reposito=
ry
+is created.
=20
-branch.<name>.mergeoptions::
-	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of linkgit:git-merge[1], but
-	option values containing whitespace characters are currently not
-	supported.
+core.ignoreCygwinFSTricks::
+	This option is only used by Cygwin implementation of Git. If false,
+	the Cygwin stat() and lstat() functions are used. This may be useful
+	if your repository consists of a few separate directories joined in
+	one hierarchy using Cygwin mount. If true, Git uses native Win32 API
+	whenever it is possible and falls back to Cygwin functions only to
+	handle symbol links. The native mode is more than twice faster than
+	normal Cygwin l/stat() functions. True by default, unless core.filemode
+	is true, in which case ignoreCygwinFSTricks is ignored as Cygwin's
+	POSIX emulation is required to support core.filemode.
=20
-branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote when
-	"git pull" is run.
-	*NOTE*: this is a possibly dangerous operation; do *not* use
-	it unless you understand the implications (see linkgit:git-rebase[1]
-	for details).
+core.ignoreStat::
+	If true, commands which modify both the working tree and the index
+	will mark the updated paths with the "assume unchanged" bit in the
+	index. These marked files are then assumed to stay unchanged in the
+	working copy, until you	mark them otherwise manually - Git will not
+	detect the file changes	by lstat() calls. This is useful on systems
+	where those are very slow, such as Microsoft Windows.
+	See linkgit:git-update-index[1].
+	False by default.
=20
-browser.<tool>.cmd::
-	Specify the command to invoke the specified browser. The
-	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web--browse[1].)
+core.logAllRefUpdates::
+	Enable the reflog. Updates to a ref <ref> is logged to the file
+	"$GIT_DIR/logs/<ref>", by appending the new and old
+	SHA1, the date/time and the reason of the update, but
+	only when the file exists.  If this configuration
+	variable is set to true, missing "$GIT_DIR/logs/<ref>"
+	file is automatically created for branch heads.
++
+This information can be used to determine what commit
+was the tip of a branch "2 days ago".
++
+This value is true by default in a repository that has
+a working directory associated with it, and false by
+default in a bare repository.
=20
-browser.<tool>.path::
-	Override the path for the given tool that may be used to
-	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
-	working repository in gitweb (see linkgit:git-instaweb[1]).
+core.loosecompression::
+	An integer -1..9, indicating the compression level for objects that
+	are not in a pack file. -1 is the zlib default. 0 means no
+	compression, and 1..9 are various speed/size tradeoffs, 9 being
+	slowest.  If not set,  defaults to core.compression.  If that is
+	not set,  defaults to 1 (best speed). See also `core.compression'.
=20
-clean.requireForce::
-	A boolean to make git-clean do nothing unless given -f
-	or -n.   Defaults to true.
+core.notesRef::
+	When showing commit messages, also show notes which are stored in
+	the given ref.  The ref must be fully qualified.  If the given
+	ref does not exist, it is not an error but means that no
+	notes should be printed.
++
+This setting defaults to "refs/notes/commits", and it can be overridden =
by
+the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
=20
-color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
-	only when the output is to a terminal. Defaults to false.
+core.packedGitLimit::
+	Maximum number of bytes to map simultaneously into memory
+	from pack files.  If Git needs to access more than this many
+	bytes at once to complete an operation it will unmap existing
+	regions to reclaim virtual address space within the process.
++
+Default is 256 MiB on 32 bit platforms and 8 GiB on 64 bit platforms.
+This should be reasonable for all users/operating systems, except on
+the largest projects.  You probably do not need to adjust this value.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-color.branch.<slot>::
-	Use customized color for branch coloration. `<slot>` is one of
-	`current` (the current branch), `local` (a local branch),
-	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
-	refs).
+core.packedGitWindowSize::
+	Number of bytes of a pack file to map into memory in a
+	single mapping operation.  Larger window sizes may allow
+	your system to process a smaller number of large pack files
+	more quickly.  Smaller window sizes will negatively affect
+	performance due to increased calls to the operating system's
+	memory manager, but may improve performance when accessing
+	a large number of large pack files.
 +
-The value for these configuration variables is a list of colors (at most
-two) and attributes (at most one), separated by spaces.  The colors
-accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
-`magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
-`blink` and `reverse`.  The first color given is the foreground; the
-second is the background.  The position of the attribute, if any,
-doesn't matter.
+Default is 1 MiB if NO_MMAP was set at compile time, otherwise 32
+MiB on 32 bit platforms and 1 GiB on 64 bit platforms.  This should
+be reasonable for all users/operating systems.  You probably do
+not need to adjust this value.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
=20
-color.diff::
-	When set to `always`, always use colors in patch.
-	When false (or `never`), never.  When set to `true` or `auto`, use
-	colors only when the output is to the terminal. Defaults to false.
+core.pager::
+	The command that git will use to paginate output.  Can
+	be overridden with the `GIT_PAGER` environment
+	variable.  Note that git sets the `LESS` environment
+	variable to `FRSX` if it is unset when it runs the
+	pager.  One can change these settings by setting the
+	`LESS` variable to some other value.  Alternately,
+	these settings can be overridden on a project or
+	global basis by setting the `core.pager` option.
+	Setting `core.pager` has no affect on the `LESS`
+	environment variable behaviour above, so if you want
+	to override git's default settings this way, you need
+	to be explicit.   For example, to disable the S option
+	in a backward compatible manner, set `core.pager`
+	to `less -+$LESS -FRX`.   This will be passed to the
+	shell by git, which will translate the final command to
+	`LESS=3DFRSX less -+FRSX -FRX`.
=20
-color.diff.<slot>::
-	Use customized color for diff colorization.  `<slot>` specifies
-	which part of the patch to use the specified color, and is one
-	of `plain` (context text), `meta` (metainformation), `frag`
-	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors). The values of these variables may be
-	specified as in color.branch.<slot>.
+core.preferSymlinkRefs::
+	Instead of the default "symref" format for HEAD
+	and other symbolic reference files, use symbolic links.
+	This is sometimes needed to work with old scripts that
+	expect HEAD to be a symbolic link.
=20
-color.decorate.<slot>::
-	Use customized color for 'git log --decorate' output.  `<slot>` is one
-	of `branch`, `remoteBranch`, `tag`, `stash` or `HEAD` for local
-	branches, remote-tracking branches, tags, stash and HEAD, respectively.
+core.preloadindex::
+	Enable parallel index preload for operations like 'git diff'
++
+This can speed up operations like 'git diff' and 'git status' especially
+on filesystems like NFS that have weak caching semantics and thus
+relatively high IO latencies.  With this set to 'true', git will do the
+index comparison to the filesystem data in parallel, allowing
+overlapping IO's.
=20
-color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
-	`never`), never.  When set to `true` or `auto`, use color only
-	when the output is written to the terminal.  Defaults to `false`.
+core.quotepath::
+	The commands that output paths (e.g. 'ls-files',
+	'diff'), when not given the `-z` option, will quote
+	"unusual" characters in the pathname by enclosing the
+	pathname in a double-quote pair and with backslashes the
+	same way strings in C source code are quoted.  If this
+	variable is set to false, the bytes higher than 0x80 are
+	not quoted but output as verbatim.  Note that double
+	quote, backslash and control characters are always
+	quoted without `-z` regardless of the setting of this
+	variable.
=20
-color.grep.<slot>::
-	Use customized color for grep colorization.  `<slot>` specifies which
-	part of the line to use the specified color, and is one of
+core.repositoryFormatVersion::
+	Internal variable identifying the repository format and layout
+	version.
+
+core.safecrlf::
+	If true, makes git check if converting `CRLF` is reversible when
+	end-of-line conversion is active.  See also option `core.eol'.
+	Git will verify if a command modifies a file in the work tree
+	either directly or indirectly.  For example, committing a file
+	followed by checking out the same file should yield the
+	original file in the work tree.  If this is not the case for
+	the current setting of `core.autocrlf`, git will reject the
+	file.  The variable can be set to "warn", in which case git
+	will only warn about an irreversible conversion but continue
+	the operation.
 +
---
-`context`;;
-	non-matching text in context lines (when using `-A`, `-B`, or `-C`)
-`filename`;;
-	filename prefix (when not using `-h`)
-`function`;;
-	function name lines (when using `-p`)
-`linenumber`;;
-	line number prefix (when using `-n`)
-`match`;;
-	matching text
-`selected`;;
-	non-matching text in selected lines
-`separator`;;
-	separators between fields on a line (`:`, `-`, and `=3D`)
-	and between hunks (`--`)
---
+CRLF conversion bears a slight chance of corrupting data.
+When it is enabled, git will convert CRLF to LF during commit and LF to
+CRLF during checkout.  A file that contains a mixture of LF and
+CRLF before the commit cannot be recreated by git.  For text
+files this is the right thing to do: it corrects line endings
+such that we have only LF line endings in the repository.
+But for binary files that are accidentally classified as text the
+conversion can corrupt data.
 +
-The values of these variables may be specified as in color.branch.<slot>=
.
-
-color.interactive::
-	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git-add --interactive").
-	When false (or `never`), never.  When set to `true` or `auto`, use
-	colors only when the output is to the terminal. Defaults to false.
-
-color.interactive.<slot>::
-	Use customized color for 'git add --interactive'
-	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
-	four distinct types of normal output from interactive
-	commands.  The values of these variables may be specified as
-	in color.branch.<slot>.
+If you recognize such corruption early you can easily fix it by
+setting the conversion type explicitly in .gitattributes.  Right
+after committing you still have the original file in your work
+tree and this file is not yet corrupted.  You can explicitly tell
+git that this file is binary and git will handle the file
+appropriately.
++
+Unfortunately, the desired effect of cleaning up text files with
+mixed line endings and the undesired effect of corrupting binary
+files cannot be distinguished.  In both cases CRLFs are removed
+in an irreversible way.   For text files this is the right thing
+to do because CRLFs are line endings, while for binary files
+converting CRLFs corrupts data.
++
+Note, this safety check does not mean that a checkout will generate a
+file identical to the original file for a different setting of
+`core.eol` and `core.autocrlf`, but only for the current one.  For
+example, a text file with `LF` would be accepted with `core.eol=3Dlf`
+and could later be checked out with `core.eol=3Dcrlf`, in which case the
+resulting file would contain `CRLF`, although the original file
+contained `LF`.   However, in both work trees the line endings would be
+consistent, that is either all `LF` or all `CRLF`, but never mixed.  A
+file with mixed line endings would be reported by the `core.safecrlf`
+mechanism.
=20
-color.pager::
-	A boolean to enable/disable colored output when the pager is in
-	use (default is true).
+core.sharedRepository::
+	When 'group' (or 'true'), the repository is made shareable between
+	several users in a group (making sure all the files and objects are
+	group-writable). When 'all' (or 'world' or 'everybody'), the
+	repository will be readable by all users, additionally to being
+	group-shareable. When 'umask' (or 'false'), git will use permissions
+	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
+	files in the repository will have this mode value. '0xxx' will override
+	user's umask value (whereas the other options will only override
+	requested parts of the user's umask value). Examples: '0660' will make
+	the repo read/write-able for the owner and group, but inaccessible to
+	others (equivalent to 'group' unless umask is e.g. '0022'). '0640' is a
+	repository that is group-readable but not group-writable.
+	See linkgit:git-init[1]. False by default.
=20
-color.showbranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
-	only when the output is to a terminal. Defaults to false.
+core.sparseCheckout::
+	Enable "sparse checkout" feature. See section "Sparse checkout" in
+	linkgit:git-read-tree[1] for more information.
=20
-color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are us=
ed
-	only when the output is to a terminal. Defaults to false.
+core.symlinks::
+	If false, symbolic links are checked out as small plain files that
+	contain the link text. linkgit:git-update-index[1] and
+	linkgit:git-add[1] will not change the recorded type to regular
+	file. Useful on filesystems like FAT that do not support
+	symbolic links.
++
+The default is true, except linkgit:git-clone[1] or linkgit:git-init[1]
+will probe and set core.symlinks false if appropriate when the repositor=
y
+is created.
=20
-color.status.<slot>::
-	Use customized color for status colorization. `<slot>` is
-	one of `header` (the header text of the status message),
-	`added` or `updated` (files which are added but not committed),
-	`changed` (files which are changed but not added in the index),
-	`untracked` (files which are not tracked by git), or
-	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
-	color.branch.<slot>.
+core.trustctime::
+	If false, the ctime differences between the index and the
+	working copy are ignored; useful when the inode change time
+	is regularly modified by something outside Git (file system
+	crawlers and some backup systems).
+	See linkgit:git-update-index[1]. True by default.
=20
-color.ui::
-	When set to `always`, always use colors in all git commands which
-	are capable of colored output. When false (or `never`), never. When
-	set to `true` or `auto`, use colors only when the output is to the
-	terminal. When more specific variables of color.* are set, they always
-	take precedence over this setting. Defaults to false.
+core.warnAmbiguousRefs::
+	If true, git will warn you if the ref name you passed it is ambiguous
+	and might match multiple refs in the .git/refs/ tree. True by default.
=20
-commit.status::
-	A boolean to enable/disable inclusion of status information in the
-	commit message template when using an editor to prepare the commit
-	message.  Defaults to true.
+core.whitespace::
+	A comma separated list of common whitespace problems to
+	notice.   'git diff' will use `color.diff.whitespace` to
+	highlight them, and 'git apply --whitespace=3Derror' will
+	consider them as errors.  You can prefix `-` to disable
+	any of them (e.g. `-trailing-space`):
++
+* `blank-at-eol` treats trailing whitespaces at the end of the line
+  as an error (enabled by default).
+* `space-before-tab` treats a space character that appears immediately
+  before a tab character in the initial indent part of the line as an
+  error (enabled by default).
+* `indent-with-non-tab` treats a line that is indented with 8 or more
+  space characters as an error (not enabled by default).
+* `tab-in-indent` treats a tab character in the initial indent part of
+  the line as an error (not enabled by default).
+* `blank-at-eof` treats blank lines added at the end of file as an error
+  (enabled by default).
+* `trailing-space` is a short-hand to cover both `blank-at-eol` and
+  `blank-at-eof`.
+* `cr-at-eol` treats a carriage-return at the end of line as
+  part of the line terminator, i.e. with it, `trailing-space`
+  does not trigger if the character before such a carriage-return
+  is not a whitespace (not enabled by default).
=20
-commit.template::
-	Specify a file to use as the template for new commit messages.
-	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to th=
e
-	specified user's home directory.
+core.worktree::
+	Set the path to the root of the work tree.
+	This can be overridden by the GIT_WORK_TREE environment
+	variable and the '--work-tree' command line option. It can be
+	an absolute path or a relative path to the .git directory,
+	either specified by --git-dir or GIT_DIR, or automatically
+	discovered.
+	If --git-dir or GIT_DIR are specified but none of
+	--work-tree, GIT_WORK_TREE and core.worktree is specified,
+	the current working directory is regarded as the root of the
+	work tree.
++
+Note that this variable is honored even when set in a configuration
+file in a ".git" subdirectory of a directory, and its value differs
+from the latter directory (e.g. "/path/to/.git/config" has
+core.worktree set to "/different/path"), which is most likely a
+misconfiguration.  Running git commands in "/path/to" directory will
+still use "/different/path" as the root of the work tree and can cause
+great confusion to the users.
=20
 diff.autorefreshindex::
 	When using 'git diff' to compare with work tree
@@ -815,6 +816,12 @@ diff.external::
 	you want to use an external diff program only on a subset of
 	your files, you	might want to use linkgit:gitattributes[5] instead.
=20
+diff.ignoreSubmodules::
+	Sets the default value of --ignore-submodules. Note that this
+	affects only 'git diff' Porcelain, and not lower level 'diff'
+	commands such as 'git diff-files'. 'git checkout' also honors
+	this setting when reporting uncommitted changes.
+
 diff.mnemonicprefix::
 	If set, 'git diff' uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
@@ -843,12 +850,6 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
=20
-diff.ignoreSubmodules::
-	Sets the default value of --ignore-submodules. Note that this
-	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout' also honors
-	this setting when reporting uncommitted changes.
-
 diff.suppressBlankEmpty::
 	A boolean to inhibit the standard behavior of printing a space
 	before each empty output line. Defaults to false.
@@ -859,10 +860,6 @@ diff.tool::
 	the same valid values as `merge.tool` minus "tortoisemerge"
 	and plus "kompare".
=20
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
 difftool.<tool>.cmd::
 	Specify the command to invoke the specified diff tool.
 	The specified command is evaluated in shell with the following
@@ -871,6 +868,10 @@ difftool.<tool>.cmd::
 	is set to the name of the temporary file containing the contents
 	of the diff post-image.
=20
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
=20
@@ -888,36 +889,32 @@ fetch.unpackLimit::
 	exceeds this limit then the received pack will be stored as
 	a pack, after adding any missing delta bases.  Storing the
 	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.  If not set, the value of
+	especially on slow filesystems.   If not set, the value of
 	`transfer.unpackLimit` is used instead.
=20
 format.attach::
 	Enable multipart/mixed attachments as the default for
-	'format-patch'.  The value can also be a double quoted string
+	'format-patch'.   The value can also be a double quoted string
 	which will enable attachments as the default and set the
 	value as the boundary.  See the --attach option in
 	linkgit:git-format-patch[1].
=20
+format.headers::
+	Additional email headers to include in a patch to be submitted
+	by mail.  See linkgit:git-format-patch[1]. See also
+	format.to and format.cc.
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
-	is more than one patch.  It can be enabled or disabled for all
+	is more than one patch.   It can be enabled or disabled for all
 	messages by setting it to "true" or "false".  See --numbered
 	option in linkgit:git-format-patch[1].
=20
-format.headers::
-	Additional email headers to include in a patch to be submitted
-	by mail.  See linkgit:git-format-patch[1].
-
-format.to::
-format.cc::
-	Additional recipients to include in a patch to be submitted
-	by mail.  See the --to and --cc options in
-	linkgit:git-format-patch[1].
-
-format.subjectprefix::
-	The default for format-patch is to output files with the '[PATCH]'
-	subject prefix. Use this variable to change that prefix.
+format.pretty::
+	The default pretty format for log/show/whatchanged command,
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
=20
 format.signature::
 	The default for format-patch is to output a signature containing
@@ -925,16 +922,22 @@ format.signature::
 	Set this variable to the empty string ("") to suppress
 	signature generation.
=20
+format.signoff::
+    A boolean value which lets you enable the `-s/--signoff` option of
+    format-patch by default. *Note:* Adding the Signed-off-by: line to a
+    patch should be a conscious act and means that you certify you have
+    the rights to submit this work under the same open source license.
+    Please see the 'SubmittingPatches' document for further discussion.
+
+format.subjectprefix::
+	The default for format-patch is to output files with the '[PATCH]'
+	subject prefix. Use this variable to change that prefix.
+
 format.suffix::
 	The default for format-patch is to output files with the suffix
 	`.patch`. Use this variable to change that suffix (make sure to
 	include the dot if you want it).
=20
-format.pretty::
-	The default pretty format for log/show/whatchanged command,
-	See linkgit:git-log[1], linkgit:git-show[1],
-	linkgit:git-whatchanged[1].
-
 format.thread::
 	The default threading style for 'git format-patch'.  Can be
 	a boolean value, or `shallow` or `deep`.  `shallow` threading
@@ -945,12 +948,11 @@ format.thread::
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
=20
-format.signoff::
-    A boolean value which lets you enable the `-s/--signoff` option of
-    format-patch by default. *Note:* Adding the Signed-off-by: line to a
-    patch should be a conscious act and means that you certify you have
-    the rights to submit this work under the same open source license.
-    Please see the 'SubmittingPatches' document for further discussion.
+format.to::
+format.cc::
+	Additional recipients to include in a patch to be submitted
+	by mail.  See the --to and --cc options in
+	linkgit:git-format-patch[1]. See also format.headers.
=20
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
@@ -967,7 +969,7 @@ gc.auto::
 gc.autopacklimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
-	--auto` consolidates them into one larger pack.  The
+	--auto` consolidates them into one larger pack.   The
 	default	value is 50.  Setting this to 0 disables it.
=20
 gc.packrefs::
@@ -987,7 +989,7 @@ gc.pruneexpire::
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
-	this time; defaults to 90 days.  With "<pattern>" (e.g.
+	this time; defaults to 90 days.   With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
=20
@@ -1002,35 +1004,12 @@ gc.<ref>.reflogexpireunreachable::
 gc.rerereresolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
-	The default is 60 days.  See linkgit:git-rerere[1].
+	The default is 60 days.   See linkgit:git-rerere[1].
=20
 gc.rerereunresolved::
 	Records of conflicted merge you have not resolved are
 	kept for this many days when 'git rerere gc' is run.
-	The default is 15 days.  See linkgit:git-rerere[1].
-
-gitcvs.commitmsgannotation::
-	Append this string to each commit message. Set to empty string
-	to disable this feature. Defaults to "via git-CVS emulator".
-
-gitcvs.enabled::
-	Whether the CVS server interface is enabled for this repository.
-	See linkgit:git-cvsserver[1].
-
-gitcvs.logfile::
-	Path to a log file where the CVS server interface well... logs
-	various stuff. See linkgit:git-cvsserver[1].
-
-gitcvs.usecrlfattr::
-	If true, the server will look up the end-of-line conversion
-	attributes for files to determine the '-k' modes to use. If
-	the attributes force git to treat a file as text,
-	the '-k' mode will be left blank so CVS clients will
-	treat it as text. If they suppress text conversion, the file
-	will be set with '-kb' mode, which suppresses any newline munging
-	the client might otherwise do. If the attributes do not allow
-	the file type to be determined, then 'gitcvs.allbinary' is
-	used. See linkgit:gitattributes[5].
+	The default is 15 days.   See linkgit:git-rerere[1].
=20
 gitcvs.allbinary::
 	This is used if 'gitcvs.usecrlfattr' does not resolve
@@ -1042,22 +1021,26 @@ gitcvs.allbinary::
 	then the contents of the file are examined to decide if
 	it is binary, similar to 'core.autocrlf'.
=20
-gitcvs.dbname::
-	Database used by git-cvsserver to cache revision information
-	derived from the git repository. The exact meaning depends on the
-	used database driver, for SQLite (which is the default driver) this
-	is a filename. Supports variable substitution (see
-	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`)=
.
-	Default: '%Ggitcvs.%m.sqlite'
+gitcvs.commitmsgannotation::
+	Append this string to each commit message. Set to empty string
+	to disable this feature. Defaults to "via git-CVS emulator".
=20
 gitcvs.dbdriver::
 	Used Perl DBI driver. You can specify any available driver
-        for this here, but it might not work. git-cvsserver is tested
+	for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
 	See linkgit:git-cvsserver[1].
=20
+gitcvs.dbname::
+	Database used by git-cvsserver to cache revision information
+	derived from the git repository. The exact meaning depends on the
+	used database driver, for SQLite (which is the default driver) this
+	is a filename. Supports variable substitution (see
+	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`)=
.
+	Default: '%Ggitcvs.%m.sqlite'
+
 gitcvs.dbuser, gitcvs.dbpass::
 	Database user and password. Only useful if setting 'gitcvs.dbdriver',
 	since SQLite has no concept of database users and/or passwords.
@@ -1071,16 +1054,46 @@ gitcvs.dbTableNamePrefix::
 	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
 	characters will be replaced with underscores.
=20
+gitcvs.enabled::
+	Whether the CVS server interface is enabled for this repository.
+	See linkgit:git-cvsserver[1].
+
+gitcvs.logfile::
+	Path to a log file where the CVS server interface well... logs
+	various stuff. See linkgit:git-cvsserver[1].
+
+gitcvs.usecrlfattr::
+	If true, the server will look up the end-of-line conversion
+	attributes for files to determine the '-k' modes to use. If
+	the attributes force git to treat a file as text,
+	the '-k' mode will be left blank so CVS clients will
+	treat it as text. If they suppress text conversion, the file
+	will be set with '-kb' mode, which suppresses any newline munging
+	the client might otherwise do. If the attributes do not allow
+	the file type to be determined, then 'gitcvs.allbinary' is
+	used. See linkgit:gitattributes[5].
+
 All gitcvs variables except for 'gitcvs.usecrlfattr' and
 'gitcvs.allbinary' can also be specified as
 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
=20
+gui.blamehistoryctx::
+	Specifies the radius of history context in days to show in
+	linkgit:gitk[1] for the selected commit, when the `Show History
+	Context` menu item is invoked from 'git gui blame'. If this
+	variable is set to zero, the whole history is shown.
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
=20
+gui.copyblamethreshold::
+	Specifies the threshold to use in 'git gui blame' original location
+	detection, measured in alphanumeric characters. See the
+	linkgit:git-blame[1] manual for more information on copy detection.
+
 gui.diffcontext::
 	Specifies how many context lines should be used in calls to diff
 	made by the linkgit:git-gui[1]. The default is "5".
@@ -1093,6 +1106,11 @@ gui.encoding::
 	If this option is not set, the tools default to the
 	locale encoding.
=20
+gui.fastcopyblame::
+	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
+	location detection. It makes blame significantly faster on huge
+	repositories at the expense of less thorough copy detection.
+
 gui.matchtrackingbranch::
 	Determines if new branches created with linkgit:git-gui[1] should
 	default to tracking remote branches with matching names or
@@ -1106,30 +1124,22 @@ gui.pruneduringfetch::
 	"true" if linkgit:git-gui[1] should prune remote-tracking branches when
 	performing a fetch. The default value is "false".
=20
-gui.trustmtime::
-	Determines if linkgit:git-gui[1] should trust the file modification
-	timestamp or not. By default the timestamps are not trusted.
-
 gui.spellingdictionary::
 	Specifies the dictionary used for spell checking commit messages in
 	the linkgit:git-gui[1]. When set to "none" spell checking is turned
 	off.
=20
-gui.fastcopyblame::
-	If true, 'git gui blame' uses `-C` instead of `-C -C` for original
-	location detection. It makes blame significantly faster on huge
-	repositories at the expense of less thorough copy detection.
-
-gui.copyblamethreshold::
-	Specifies the threshold to use in 'git gui blame' original location
-	detection, measured in alphanumeric characters. See the
-	linkgit:git-blame[1] manual for more information on copy detection.
+gui.trustmtime::
+	Determines if linkgit:git-gui[1] should trust the file modification
+	timestamp or not. By default the timestamps are not trusted.
=20
-gui.blamehistoryctx::
-	Specifies the radius of history context in days to show in
-	linkgit:gitk[1] for the selected commit, when the `Show History
-	Context` menu item is invoked from 'git gui blame'. If this
-	variable is set to zero, the whole history is shown.
+guitool.<name>.argprompt::
+	Request a string argument from the user, and pass it to the tool
+	through the 'ARGS' environment variable. Since requesting an
+	argument implies confirmation, the 'confirm' option has no effect
+	if this is enabled. If the option is set to 'true', 'yes', or '1',
+	the dialog uses a built-in generic prompt; otherwise the exact
+	value of the variable is used.
=20
 guitool.<name>.cmd::
 	Specifies the shell command line to execute when the corresponding item
@@ -1140,6 +1150,9 @@ guitool.<name>.cmd::
 	'FILENAME', and the name of the current branch as 'CUR_BRANCH' (if
 	the head is detached, 'CUR_BRANCH' is empty).
=20
+guitool.<name>.confirm::
+	Show a confirmation dialog before actually running the tool.
+
 guitool.<name>.needsfile::
 	Run the tool only if a diff is selected in the GUI. It guarantees
 	that 'FILENAME' is not empty.
@@ -1152,16 +1165,10 @@ guitool.<name>.norescan::
 	Don't rescan the working directory for changes after the tool
 	finishes execution.
=20
-guitool.<name>.confirm::
-	Show a confirmation dialog before actually running the tool.
-
-guitool.<name>.argprompt::
-	Request a string argument from the user, and pass it to the tool
-	through the 'ARGS' environment variable. Since requesting an
-	argument implies confirmation, the 'confirm' option has no effect
-	if this is enabled. If the option is set to 'true', 'yes', or '1',
-	the dialog uses a built-in generic prompt; otherwise the exact
-	value of the variable is used.
+guitool.<name>.prompt::
+	Specifies the general prompt string to display at the top of
+	the dialog, before subsections for 'argprompt' and 'revprompt'.
+	The default value includes the actual command.
=20
 guitool.<name>.revprompt::
 	Request a single valid revision from the user, and set the
@@ -1177,20 +1184,6 @@ guitool.<name>.title::
 	Specifies the title to use for the prompt dialog. The default
 	is the tool name.
=20
-guitool.<name>.prompt::
-	Specifies the general prompt string to display at the top of
-	the dialog, before subsections for 'argprompt' and 'revprompt'.
-	The default value includes the actual command.
-
-help.browser::
-	Specify the browser that will be used to display help in the
-	'web' format. See linkgit:git-help[1].
-
-help.format::
-	Override the default help format used by linkgit:git-help[1].
-	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
-	the default. 'web' and 'html' are the same.
-
 help.autocorrect::
 	Automatically correct and execute mistyped commands after
 	waiting for the given number of deciseconds (0.1 sec). If more
@@ -1200,41 +1193,20 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
=20
-http.proxy::
-	Override the HTTP proxy, normally configured using the 'http_proxy'
-	environment variable (see linkgit:curl[1]).  This can be overridden
-	on a per-remote basis; see remote.<name>.proxy
-
-http.sslVerify::
-	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
-	variable.
-
-http.sslCert::
-	File containing the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
-	variable.
-
-http.sslKey::
-	File containing the SSL private key when fetching or pushing
-	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
-	variable.
-
-http.sslCertPasswordProtected::
-	Enable git's password prompt for the SSL certificate.  Otherwise
-	OpenSSL will prompt the user, possibly many times, if the
-	certificate or private key is encrypted.  Can be overridden by the
-	'GIT_SSL_CERT_PASSWORD_PROTECTED' environment variable.
+help.browser::
+	Specify the browser that will be used to display help in the
+	'web' format. See linkgit:git-help[1].
=20
-http.sslCAInfo::
-	File containing the certificates to verify the peer with when
-	fetching or pushing over HTTPS. Can be overridden by the
-	'GIT_SSL_CAINFO' environment variable.
+help.format::
+	Override the default help format used by linkgit:git-help[1].
+	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
+	the default. 'web' and 'html' are the same.
=20
-http.sslCAPath::
-	Path containing files with the CA certificates to verify the peer
-	with when fetching or pushing over HTTPS. Can be overridden
-	by the 'GIT_SSL_CAPATH' environment variable.
+http.lowSpeedLimit, http.lowSpeedTime::
+	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
+	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
+	Can be overridden by the 'GIT_HTTP_LOW_SPEED_LIMIT' and
+	'GIT_HTTP_LOW_SPEED_TIME' environment variables.
=20
 http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
@@ -1246,6 +1218,12 @@ http.minSessions::
 	http_cleanup() is invoked. If USE_CURL_MULTI is not defined, this
 	value will be capped at 1. Defaults to 1.
=20
+http.noEPSV::
+	A boolean which disables using of EPSV ftp command by curl.
+	This can helpful with some "poor" ftp servers which don't
+	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
+	environment variable. Default is false (curl will use EPSV).
+
 http.postBuffer::
 	Maximum size in bytes of the buffer used by smart HTTP
 	transports when POSTing data to the remote system.
@@ -1254,20 +1232,44 @@ http.postBuffer::
 	massive pack file locally.  Default is 1 MiB, which is
 	sufficient for most requests.
=20
-http.lowSpeedLimit, http.lowSpeedTime::
-	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
-	for longer than 'http.lowSpeedTime' seconds, the transfer is aborted.
-	Can be overridden by the 'GIT_HTTP_LOW_SPEED_LIMIT' and
-	'GIT_HTTP_LOW_SPEED_TIME' environment variables.
+http.proxy::
+	Override the HTTP proxy, normally configured using the 'http_proxy'
+	environment variable (see linkgit:curl[1]).  This can be overridden
+	on a per-remote basis; see remote.<name>.proxy
=20
-http.noEPSV::
-	A boolean which disables using of EPSV ftp command by curl.
-	This can helpful with some "poor" ftp servers which don't
-	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
-	environment variable. Default is false (curl will use EPSV).
+http.sslCAInfo::
+	File containing the certificates to verify the peer with when
+	fetching or pushing over HTTPS. Can be overridden by the
+	'GIT_SSL_CAINFO' environment variable.
+
+http.sslCAPath::
+	Path containing files with the CA certificates to verify the peer
+	with when fetching or pushing over HTTPS. Can be overridden
+	by the 'GIT_SSL_CAPATH' environment variable.
+
+http.sslCert::
+	File containing the SSL certificate when fetching or pushing
+	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
+	variable.
+
+http.sslCertPasswordProtected::
+	Enable git's password prompt for the SSL certificate.  Otherwise
+	OpenSSL will prompt the user, possibly many times, if the
+	certificate or private key is encrypted.  Can be overridden by the
+	'GIT_SSL_CERT_PASSWORD_PROTECTED' environment variable.
+
+http.sslKey::
+	File containing the SSL private key when fetching or pushing
+	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
+	variable.
+
+http.sslVerify::
+	Whether to verify the SSL certificate when fetching or pushing
+	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
+	variable.
=20
 http.useragent::
-	The HTTP USER_AGENT string presented to an HTTP server.  The default
+	The HTTP USER_AGENT string presented to an HTTP server.   The default
 	value represents the version of the client git such as git/1.7.1.
 	This option allows you to override this value to a more common value
 	such as Mozilla/4.0.  This may be necessary, for instance, if
@@ -1350,10 +1352,6 @@ mailmap.file::
 	subdirectory, or somewhere outside of the repository itself.
 	See linkgit:git-shortlog[1] and linkgit:git-blame[1].
=20
-man.viewer::
-	Specify the programs that may be used to display help in the
-	'man' format. See linkgit:git-help[1].
-
 man.<tool>.cmd::
 	Specify the command to invoke the specified man viewer. The
 	specified command is evaluated in shell with the man page
@@ -1363,14 +1361,14 @@ man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
=20
-include::merge-config.txt[]
+man.viewer::
+	Specify the programs that may be used to display help in the
+	'man' format. See linkgit:git-help[1].
=20
-mergetool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
+include::merge-config.txt[]
=20
 mergetool.<tool>.cmd::
-	Specify the command to invoke the specified merge tool.  The
+	Specify the command to invoke the specified merge tool.   The
 	specified command is evaluated in shell with the following
 	variables available: 'BASE' is the name of a temporary file
 	containing the common base of the files to be merged, if available;
@@ -1380,6 +1378,10 @@ mergetool.<tool>.cmd::
 	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
=20
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
 mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
@@ -1451,20 +1453,6 @@ This setting can be overridden with the `GIT_NOTES=
_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
=20
-pack.window::
-	The size of the window used by linkgit:git-pack-objects[1] when no
-	window size is given on the command line. Defaults to 10.
-
-pack.depth::
-	The maximum delta depth used by linkgit:git-pack-objects[1] when no
-	maximum depth is given on the command line. Defaults to 50.
-
-pack.windowMemory::
-	The window memory size limit used by linkgit:git-pack-objects[1]
-	when no limit is given on the command line.  The value can be
-	suffixed with "k", "m", or "g".  Defaults to 0, meaning no
-	limit.
-
 pack.compression::
 	An integer -1..9, indicating the compression level for objects
 	in a pack file. -1 is the zlib default. 0 means no
@@ -1478,6 +1466,12 @@ Note that changing the compression level will not =
automatically recompress
 all existing objects. You can force recompression by passing the -F opti=
on
 to linkgit:git-repack[1].
=20
+pack.deltaCacheLimit::
+	The maximum size of a delta, that is cached in
+	linkgit:git-pack-objects[1]. This cache is used to speed up the
+	writing object phase by not having to recompute the final delta
+	result once the best match for all objects is found. Defaults to 1000.
+
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
 	linkgit:git-pack-objects[1] before writing them out to a pack.
@@ -1489,24 +1483,12 @@ pack.deltaCacheSize::
 	A value of 0 means no limit. The smallest size of 1 byte may be
 	used to virtually disable this cache. Defaults to 256 MiB.
=20
-pack.deltaCacheLimit::
-	The maximum size of a delta, that is cached in
-	linkgit:git-pack-objects[1]. This cache is used to speed up the
-	writing object phase by not having to recompute the final delta
-	result once the best match for all objects is found. Defaults to 1000.
-
-pack.threads::
-	Specifies the number of threads to spawn when searching for best
-	delta matches.  This requires that linkgit:git-pack-objects[1]
-	be compiled with pthreads otherwise this option is ignored with a
-	warning. This is meant to reduce packing time on multiprocessor
-	machines. The required amount of memory for the delta search window
-	is however multiplied by the number of threads.
-	Specifying 0 will cause git to auto-detect the number of CPU's
-	and set the number of threads accordingly.
+pack.depth::
+	The maximum delta depth used by linkgit:git-pack-objects[1] when no
+	maximum depth is given on the command line. Defaults to 50.
=20
 pack.indexVersion::
-	Specify the default pack index version.  Valid values are 1 for
+	Specify the default pack index version.   Valid values are 1 for
 	legacy pack index used by Git versions prior to 1.5.2, and 2 for
 	the new pack index with capabilities for packs larger than 4 GB
 	as well as proper protection against the repacking of corrupted
@@ -1531,6 +1513,26 @@ pack.packSizeLimit::
 	Common unit suffixes of 'k', 'm', or 'g' are
 	supported.
=20
+pack.threads::
+	Specifies the number of threads to spawn when searching for best
+	delta matches.  This requires that linkgit:git-pack-objects[1]
+	be compiled with pthreads otherwise this option is ignored with a
+	warning. This is meant to reduce packing time on multiprocessor
+	machines. The required amount of memory for the delta search window
+	is however multiplied by the number of threads.
+	Specifying 0 will cause git to auto-detect the number of CPU's
+	and set the number of threads accordingly.
+
+pack.window::
+	The size of the window used by linkgit:git-pack-objects[1] when no
+	window size is given on the command line. Defaults to 10.
+
+pack.windowMemory::
+	The window memory size limit used by linkgit:git-pack-objects[1]
+	when no limit is given on the command line.  The value can be
+	suffixed with "k", "m", or "g".   Defaults to 0, meaning no
+	limit.
+
 pager.<cmd>::
 	Allows turning on or off pagination of the output of a
 	particular git subcommand when writing to a tty.  If
@@ -1568,42 +1570,18 @@ push.default::
 * `tracking` - push the current branch to its upstream branch.
 * `current` - push the current branch to a branch of the same name.
=20
+rebase.autosquash::
+	If set to true enable '--autosquash' option by default.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
=20
-rebase.autosquash::
-	If set to true enable '--autosquash' option by default.
-
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
-	receiving data from git-push and updating refs.  You can stop
+	receiving data from git-push and updating refs.   You can stop
 	it by setting this variable to false.
=20
-receive.fsckObjects::
-	If it is set to true, git-receive-pack will check all received
-	objects. It will abort in the case of a malformed object or a
-	broken link. The result of an abort are only dangling objects.
-	Defaults to false.
-
-receive.unpackLimit::
-	If the number of objects received in a push is below this
-	limit then the objects will be unpacked into loose object
-	files. However if the number of received objects equals or
-	exceeds this limit then the received pack will be stored as
-	a pack, after adding any missing delta bases.  Storing the
-	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.  If not set, the value of
-	`transfer.unpackLimit` is used instead.
-
-receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
-	the ref. Use this to prevent such a ref deletion via a push.
-
-receive.denyDeleteCurrent::
-	If set to true, git-receive-pack will deny a ref update that
-	deletes the currently checked out branch of a non-bare repository.
-
 receive.denyCurrentBranch::
 	If set to true or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
@@ -1613,39 +1591,63 @@ receive.denyCurrentBranch::
 	proceed. If set to false or "ignore", allow such pushes with no
 	message. Defaults to "refuse".
=20
+receive.denyDeletes::
+	If set to true, git-receive-pack will deny a ref update that deletes
+	the ref. Use this to prevent such a ref deletion via a push.
+
+receive.denyDeleteCurrent::
+	If set to true, git-receive-pack will deny a ref update that
+	deletes the currently checked out branch of a non-bare repository.
+
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
 	not a fast-forward. Use this to prevent such an update via a push,
 	even if that push is forced. This configuration variable is
 	set when initializing a shared repository.
=20
+receive.fsckObjects::
+	If it is set to true, git-receive-pack will check all received
+	objects. It will abort in the case of a malformed object or a
+	broken link. The result of an abort are only dangling objects.
+	Defaults to false.
+
+receive.unpackLimit::
+	If the number of objects received in a push is below this
+	limit then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.   If not set, the value of
+	`transfer.unpackLimit` is used instead.
+
 receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
=20
-remote.<name>.url::
-	The URL of a remote repository.  See linkgit:git-fetch[1] or
-	linkgit:git-push[1].
+remote.<name>.fetch::
+	The default set of "refspec" for linkgit:git-fetch[1]. See
+	linkgit:git-fetch[1].
=20
-remote.<name>.pushurl::
-	The push URL of a remote repository.  See linkgit:git-push[1].
+remote.<name>.mirror::
+	If true, pushing to this remote will automatically behave
+	as if the `\--mirror` option was given on the command line.
=20
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
 	the proxy to use for that remote.  Set to the empty string to
 	disable proxying for that remote.
=20
-remote.<name>.fetch::
-	The default set of "refspec" for linkgit:git-fetch[1]. See
-	linkgit:git-fetch[1].
-
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
=20
-remote.<name>.mirror::
-	If true, pushing to this remote will automatically behave
-	as if the `\--mirror` option was given on the command line.
+remote.<name>.pushurl::
+	The push URL of a remote repository.  See linkgit:git-push[1].
+
+remote.<name>.receivepack::
+	The default program to execute on the remote side when pushing.   See
+	option \--receive-pack of linkgit:git-push[1].
=20
 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
@@ -1657,14 +1659,6 @@ remote.<name>.skipFetchAll::
 	using linkgit:git-fetch[1] or the `update` subcommand of
 	linkgit:git-remote[1].
=20
-remote.<name>.receivepack::
-	The default program to execute on the remote side when pushing.  See
-	option \--receive-pack of linkgit:git-push[1].
-
-remote.<name>.uploadpack::
-	The default program to execute on the remote side when fetching.  See
-	option \--upload-pack of linkgit:git-fetch-pack[1].
-
 remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>. Setting it to \--tags will fetch every
@@ -1673,6 +1667,14 @@ remote.<name>.tagopt::
 	override this setting. See options \--tags and \--no-tags of
 	linkgit:git-fetch[1].
=20
+remote.<name>.uploadpack::
+	The default program to execute on the remote side when fetching.  See
+	option \--upload-pack of linkgit:git-fetch-pack[1].
+
+remote.<name>.url::
+	The URL of a remote repository.   See linkgit:git-fetch[1] or
+	linkgit:git-push[1].
+
 remote.<name>.vcs::
 	Setting this to a value <vcs> will cause git to interact with
 	the remote with the git-remote-<vcs> helper.
@@ -1692,7 +1694,7 @@ repack.usedeltabaseoffset::
 rerere.autoupdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolution.  Defaults to false.
+	previously recorded resolution.   Defaults to false.
=20
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
@@ -1701,25 +1703,6 @@ rerere.enabled::
 	default enabled if you create `rr-cache` directory under
 	`$GIT_DIR`, but can be disabled by setting this option to false.
=20
-sendemail.identity::
-	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
-	the value of 'sendemail.identity'.
-
-sendemail.smtpencryption::
-	See linkgit:git-send-email[1] for description.  Note that this
-	setting is not subject to the 'identity' mechanism.
-
-sendemail.smtpssl::
-	Deprecated alias for 'sendemail.smtpencryption =3D ssl'.
-
-sendemail.<identity>.*::
-	Identity-specific versions of the 'sendemail.*' parameters
-	found below, taking precedence over those when the this
-	identity is selected, through command-line or
-	'sendemail.identity'.
-
 sendemail.aliasesfile::
 sendemail.aliasfiletype::
 sendemail.bcc::
@@ -1744,9 +1727,28 @@ sendemail.thread::
 sendemail.validate::
 	See linkgit:git-send-email[1] for description.
=20
+sendemail.identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of 'sendemail.identity'.
+
 sendemail.signedoffcc::
 	Deprecated alias for 'sendemail.signedoffbycc'.
=20
+sendemail.smtpencryption::
+	See linkgit:git-send-email[1] for description.  Note that this
+	setting is not subject to the 'identity' mechanism.
+
+sendemail.smtpssl::
+	Deprecated alias for 'sendemail.smtpencryption =3D ssl'.
+
+sendemail.<identity>.*::
+	Identity-specific versions of the 'sendemail.*' parameters
+	found below, taking precedence over those when the this
+	identity is selected, through command-line or
+	'sendemail.identity'.
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
@@ -1784,13 +1786,18 @@ status.submodulesummary::
 	--summary-limit option of linkgit:git-submodule[1]).
=20
 submodule.<name>.path::
-submodule.<name>.url::
+	The path within this project, URL.  The variable is initially populated
+	by 'git submodule init'; edit to override.
+
 submodule.<name>.update::
-	The path within this project, URL, and the updating strategy
-	for a submodule.  These variables are initially populated
-	by 'git submodule init'; edit them to override the
-	URL and other values found in the `.gitmodules` file.  See
-	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
+	Uupdating strategy for a submodule.  The variable is initially
+	populated by 'git submodule init'; edit to override values
+	found in the `.gitmodules` file.  See linkgit:git-submodule[1]
+	and linkgit:gitmodules[5] for details.
+
+submodule.<name>.url::
+	The project URL.  The variable is initially populated by 'git
+	submodule init'; edit to override.
=20
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
--=20
1.7.2.3
