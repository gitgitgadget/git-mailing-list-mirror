From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: path/to/some/file: needs update
Date: Mon, 6 Dec 2010 13:06:27 -0600
Message-ID: <idjc9t$6hv$1@dough.gmane.org>
References: <AANLkTinsUZCUJamUHWN=H7tyL5nKACmEcyvG6hpsTDtv@mail.gmail.com> <vpqk4jq3cpc.fsf@bauges.imag.fr> <AANLkTinFHFzjLNb5PpoH8WG_3gHpo4LaZaUOYX-=PFYN@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 20:08:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPgPw-0005NE-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 20:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0LFTIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 14:08:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:48038 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab0LFTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 14:07:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PPgPl-0005IV-Jv
	for git@vger.kernel.org; Mon, 06 Dec 2010 20:07:57 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 20:07:57 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 20:07:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163014>

>"Patrick Doyle" <wpdster@gmail.com> wrote in message 
>news:AANLkTinFHFzjLNb5PpoH8WG_3gHpo4LaZaUOYX->=PFYN@mail.gmail.com...
>On Fri, Dec 3, 2010 at 1:58 PM, Matthieu Moy
><Matthieu.Moy@grenoble-inp.fr> wrote:
>> Patrick Doyle <wpdster@gmail.com> writes:
>>
>>> path/to/some/file: needs update.
>>>
>>> Then things got worse... one of the messages said:
>>>
>>> error: Entry 'path/to/some/binaryfile' not uptodate. Cannot merge
>>
>> Which commands triggered these messages? Which version of Git?
>>
>> AFAICT, these messages never appear anymore in normal (porcelain) use
>> in recent Gits.
>Ahhh... that's something.
>
>I just checked.  The box they  were using is an RHEL 5 box that has
>1.5.5.6 installed on it.  Perhaps it's time to upgrade their git.
>I'll go see what repo I need to add to RHEL to get a more recent git.
>
>Thanks.
>
>--wpd

Hi, Patrick,

There isn't an RHEL or EPEL rpm for a current version of git.  What you'll 
need to do is build git yourself using the tarball download from git.  The 
make file provided by git has worked great for me.  Here are my instructions 
on how I did it.  They are written for a linux newbie (me) and I've used 
them for several git installs/upgrades and my linux-illiterate coworker has 
successfully used them too (with me looking over his shoulder).  Because 
I've used it for several installs, some different git version numbers are in 
the detailed notes.  I've left them there for precision.  However, in my 
experience the steps were the same for these differnt git versions, so you 
can pretend they are for whatever git version you end up chosing to install. 
We have dozens of git repos in production being used for productional 
development, and several servers with git installed, so hopefully these 
instructions should work for you too:

"How to install git on Red Hat, RHEL"
NOTE:  This only includes what is needed to get command line git, gitk, and 
git gui working.  It does NOT include the extra stuff needed to get gitweb, 
or git documentation (manpages, html, etc) working.

GIT INSTALL, PART 1.  INSTALL GIT.
Compile Git manually because Red Hat's Git version is obsolete.

1.  Choose a git version.
1.1  Review the git release notes: 
http://www.kernel.org/pub/software/scm/git/docs/  The last minor revision of 
major release is the usually the safest because many bugfixes have been 
made.  A version that has a corresponding git manual release number is also 
preferable.  Usually the last revision of a major release also has a 
corresponding git manual release - this is ideal.
2.  Download git sourcecode.
2.1  Use the git0 login for the source download:   (note:  'git0' is 
whatever login you have allocated as the 'git admin' signon.)
[git0]$ cd /home/git0
2.2  Create a specific folder for the git source:
[git0]$ mkdir git-source
[git0]$ cd /home/git0/git-source
2.3  Review the git source tar files located on: 
http://www.kernel.org/pub/software/scm/git/  and locate the tar for your 
chosen version.
2.4  Copy and paste the url into the wget command, and then copy and paste 
(append) the tar filename to the end of the wget command:
[git0]$ wget http://kernel.org/pub/software/scm/git/git-1.6.3.4.tar.gz 
where 1.6.3.4 is your chosen git version.
2.5  Untar the git sourcecode:
[git0]$ tar xzf git-1.6.3.4.tar.gz  (where 1.6.3.4 is whatever git version 
you chose to install.)
[git0]$ cd git-1.6.3.4  (the tar command created this directory for you.)
[git0]$ ls -la  (verify the contents.)
3.  Research Git Dependencies.  Validate prerequisite packages and install 
if necessary.
3.1  Read INSTALL file of git source release to obtain the current list of 
prerequisite packages.  The development version of these packages is 
required or preferred in order to perform a compile of git.  Development 
packages have the same name but are suffixed with "-devel", e.g.  zlib-devel 
instead of zlib.  The regular non-devel version of the package IS STILL 
REQUIRED, e.g. zlib-devel AND zlib.
3.1.1  [git0]$ cat /home/git0/git-source/git-1.6.3.4/INSTALL
4.  Resolve Git Dependencies.
Validate prerequisite packages and install if necessary.  The following is 
the dependency list from the git-1.6.3.4 INSTALL file:
REMINDER:
READ YOUR INSTALL FILE FROM GIT.  DO NOT RELY SOLELY ON THIS IN-HOUSE 
DOCUMENT.
4.1  "zlib", the compression library. Git won't build without it.
4.1.1  [neal]$ yum list zlib
4.1.2  [neal]$ yum list zlib-devel
4.2  "openssl".  Unless you specify otherwise, you'll get the SHA1 library 
from here.  If you don't have openssl, you can use one of the SHA1 libraries 
that come with git (git includes the one from Mozilla, and has its own 
PowerPC and ARM optimized ones too - see the Makefile).
4.2.1  [neal]$ yum list openssl
4.2.2  [neal]$ yum list openssl-devel
4.3  libcurl library; git-http-fetch and git-fetch use them.  You might also 
want the "curl" executable for debugging purposes. If you do not use http 
transfer, you are probably OK if you do not have them.
NOTE: I installed security updates, 'yum update --security' to remediate 
out-of-date curl packages.
NOTE:  to get yum security plugin:
$ yum install yum-security.  (allows security updates only.)
4.3.1  [neal]$ yum list curl  (Red Hat calls it curl instead of libcurl.)
4.3.2  [neal]$ yum list curl-devel  (Red Hat calls it curl-devel instead of 
libcurl-devel.)
4.4  expat library; git-http-push uses it for remote lock management over 
DAV.  Similar to "curl" above, this is optional.
4.4.1  [neal]$ yum list expat
4.4.2  [neal]$ yum list expat-devel
4.5  "wish", the Tcl/Tk windowing shell is used in gitk to show the history 
graphically, and in git-gui.
4.5.1  [neal]$ yum list tcl
4.5.2  [neal]$ yum list tcl-devel
4.5.3  [neal]$ yum list tk
4.5.4  [neal]$ yum list tk-devel
4.5.5  [neal]$ yum list xdg-utils  (development version "-devel" is not 
needed for xdg-utils.)
4.6  "ssh" is used to push and pull over the net.
4.6.1  There is no package to validate.  In Red Hat this is part of the OS.
4.7  "perl" and POSIX-compliant shells are needed to use most of the 
bare-bones Porcelainish scripts.
4.7.1  [neal]$ yum list perl  (Perl is a programming language.  There is no 
"-devel" version required.)
5.  Compile Git.
5.1  Perform the Git installation process from the 
/home/git0/git-source/git-1.6.3.4 directory:
[neal]$ cd /home/git0/git-source/git-1.6.3.4
5.2  READ THE "Makefile" LOCATED IN THE /home/git0/git-source/git-1.6.3.4 
DIRECTORY.  Review the compiler options and instructions in the comments at 
the beginning of the file.  DO NOT RELY SOLELY ON THIS RSSS IN-HOUSE 
DOCUMENT.
5.3  [neal]$ make prefix=/usr all  The compiler options defaults should be 
ok.  Review the Makefile instructions to review the options.
5.4  Review output for errors.  Copy and paste the results into a file for 
later reference.
5.4  SAMPLE of GOOD OUTPUT for 1.7.1 install:
[git0@rsssDev git-1.7.1]$ make prefix=/usr all
GIT_VERSION = 1.7.1
    * new build flags or prefix
    CC fast-import.o
    CC abspath.o
    CC advice.o
    CC alias.o
    CC alloc.o
    CC archive.o
    CC archive-tar.o
    CC archive-zip.o
    CC attr.o
    CC base85.o
    CC bisect.o
    CC blob.o
    CC branch.o
    CC bundle.o
    CC cache-tree.o
    CC color.o
    CC combine-diff.o
    CC commit.o
    CC config.o
    CC connect.o
    CC convert.o
    CC copy.o
    CC csum-file.o
    CC ctype.o
    CC date.o
    CC decorate.o
    CC diffcore-break.o
    CC diffcore-delta.o
    CC diffcore-order.o
    CC diffcore-pickaxe.o
    CC diffcore-rename.o
    CC diff-delta.o
    CC diff-lib.o
    CC diff-no-index.o
    CC diff.o
    CC dir.o
    CC editor.o
    CC entry.o
    CC environment.o
    CC exec_cmd.o
    CC fsck.o
    CC graph.o
    CC grep.o
    CC hash.o
    CC help.o
    CC hex.o
    CC ident.o
    CC levenshtein.o
    CC list-objects.o
    CC ll-merge.o
    CC lockfile.o
    CC log-tree.o
    CC mailmap.o
    CC match-trees.o
    CC merge-file.o
    CC merge-recursive.o
    CC name-hash.o
    CC notes.o
    CC object.o
    CC pack-check.o
    CC pack-refs.o
    CC pack-revindex.o
    CC pack-write.o
    CC pager.o
    CC parse-options.o
    CC patch-delta.o
    CC patch-ids.o
    CC path.o
    CC pkt-line.o
    CC preload-index.o
    CC pretty.o
    CC progress.o
    CC quote.o
    CC reachable.o
    CC read-cache.o
    CC reflog-walk.o
    CC refs.o
    CC remote.o
    CC replace_object.o
    CC rerere.o
    CC resolve-undo.o
    CC revision.o
    CC run-command.o
    CC server-info.o
    CC setup.o
    CC sha1-lookup.o
    CC sha1_file.o
    CC sha1_name.o
    CC shallow.o
    CC sideband.o
    CC sigchain.o
    CC strbuf.o
    CC string-list.o
    CC submodule.o
    CC symlinks.o
    CC tag.o
    CC trace.o
    CC transport.o
    CC transport-helper.o
    CC tree-diff.o
    CC tree.o
    CC tree-walk.o
    CC unpack-trees.o
    CC usage.o
    CC userdiff.o
    CC utf8.o
    CC walker.o
    CC wrapper.o
    CC write_or_die.o
    CC ws.o
    CC wt-status.o
    CC xdiff-interface.o
    CC thread-utils.o
    CC compat/strlcpy.o
    AR libgit.a
    CC xdiff/xdiffi.o
    CC xdiff/xprepare.o
    CC xdiff/xutils.o
    CC xdiff/xemit.o
    CC xdiff/xmerge.o
    CC xdiff/xpatience.o
    AR xdiff/lib.a
    LINK git-fast-import
    CC imap-send.o
    LINK git-imap-send
    CC shell.o
    LINK git-shell
    CC show-index.o
    LINK git-show-index
    CC upload-pack.o
    LINK git-upload-pack
    CC http-backend.o
    LINK git-http-backend
    CC http.o
    CC http-walker.o
    CC http-fetch.o
    LINK git-http-fetch
    CC http-push.o
    LINK git-http-push
    CC daemon.o
    LINK git-daemon
    CC remote-curl.o
    LINK git-remote-http
    LN/CP git-remote-https
    LN/CP git-remote-ftp
    LN/CP git-remote-ftps
    GEN git-am
    GEN git-bisect
    GEN git-difftool--helper
    GEN git-filter-branch
    GEN git-lost-found
    GEN git-merge-octopus
    GEN git-merge-one-file
    GEN git-merge-resolve
    GEN git-mergetool
    GEN git-pull
    GEN git-quiltimport
    GEN git-rebase--interactive
    GEN git-rebase
    GEN git-repack
    GEN git-request-pull
    GEN git-stash
    GEN git-submodule
    GEN git-web--browse
    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/usr'
Writing perl.mak for Git
    GEN git-add--interactive
    GEN git-difftool
    GEN git-archimport
    GEN git-cvsexportcommit
    GEN git-cvsimport
    GEN git-cvsserver
    GEN git-relink
    GEN git-send-email
    GEN git-svn
    SUBDIR gitweb
    SUBDIR ../
make[2]: `GIT-VERSION-FILE' is up to date.
    GEN gitweb.cgi
    GEN git-instaweb
    GEN git-mergetool--lib
    GEN git-parse-remote
    GEN git-sh-setup
    GEN common-cmds.h
    CC git.o
    CC builtin/add.o
    CC builtin/annotate.o
    CC builtin/apply.o
    CC builtin/archive.o
    CC builtin/bisect--helper.o
    CC builtin/blame.o
    CC builtin/branch.o
    CC builtin/bundle.o
    CC builtin/cat-file.o
    CC builtin/check-attr.o
    CC builtin/check-ref-format.o
    CC builtin/checkout-index.o
    CC builtin/checkout.o
    CC builtin/clean.o
    CC builtin/clone.o
    CC builtin/commit-tree.o
    CC builtin/commit.o
    CC builtin/config.o
    CC builtin/count-objects.o
    CC builtin/describe.o
    CC builtin/diff-files.o
    CC builtin/diff-index.o
    CC builtin/diff-tree.o
    CC builtin/diff.o
    CC builtin/fast-export.o
    CC builtin/fetch-pack.o
    CC builtin/fetch.o
    CC builtin/fmt-merge-msg.o
    CC builtin/for-each-ref.o
    CC builtin/fsck.o
    CC builtin/gc.o
    CC builtin/grep.o
    CC builtin/hash-object.o
    CC builtin/help.o
    CC builtin/index-pack.o
    CC builtin/init-db.o
    CC builtin/log.o
    CC builtin/ls-files.o
    CC builtin/ls-remote.o
    CC builtin/ls-tree.o
    CC builtin/mailinfo.o
    CC builtin/mailsplit.o
    CC builtin/merge.o
    CC builtin/merge-base.o
    CC builtin/merge-file.o
    CC builtin/merge-index.o
    CC builtin/merge-ours.o
    CC builtin/merge-recursive.o
    CC builtin/merge-tree.o
    CC builtin/mktag.o
    CC builtin/mktree.o
    CC builtin/mv.o
    CC builtin/name-rev.o
    CC builtin/notes.o
    CC builtin/pack-objects.o
    CC builtin/pack-redundant.o
    CC builtin/pack-refs.o
    CC builtin/patch-id.o
    CC builtin/prune-packed.o
    CC builtin/prune.o
    CC builtin/push.o
    CC builtin/read-tree.o
    CC builtin/receive-pack.o
    CC builtin/reflog.o
    CC builtin/remote.o
    CC builtin/replace.o
    CC builtin/rerere.o
    CC builtin/reset.o
    CC builtin/rev-list.o
    CC builtin/rev-parse.o
    CC builtin/revert.o
    CC builtin/rm.o
    CC builtin/send-pack.o
    CC builtin/shortlog.o
    CC builtin/show-branch.o
    CC builtin/show-ref.o
    CC builtin/stripspace.o
    CC builtin/symbolic-ref.o
    CC builtin/tag.o
    CC builtin/tar-tree.o
    CC builtin/unpack-file.o
    CC builtin/unpack-objects.o
    CC builtin/update-index.o
    CC builtin/update-ref.o
    CC builtin/update-server-info.o
    CC builtin/upload-archive.o
    CC builtin/var.o
    CC builtin/verify-pack.o
    CC builtin/verify-tag.o
    CC builtin/write-tree.o
    LINK git
    BUILTIN git-add
    BUILTIN git-annotate
    BUILTIN git-apply
    BUILTIN git-archive
    BUILTIN git-bisect--helper
    BUILTIN git-blame
    BUILTIN git-branch
    BUILTIN git-bundle
    BUILTIN git-cat-file
    BUILTIN git-check-attr
    BUILTIN git-check-ref-format
    BUILTIN git-checkout-index
    BUILTIN git-checkout
    BUILTIN git-clean
    BUILTIN git-clone
    BUILTIN git-commit-tree
    BUILTIN git-commit
    BUILTIN git-config
    BUILTIN git-count-objects
    BUILTIN git-describe
    BUILTIN git-diff-files
    BUILTIN git-diff-index
    BUILTIN git-diff-tree
    BUILTIN git-diff
    BUILTIN git-fast-export
    BUILTIN git-fetch-pack
    BUILTIN git-fetch
    BUILTIN git-fmt-merge-msg
    BUILTIN git-for-each-ref
    BUILTIN git-fsck
    BUILTIN git-gc
    BUILTIN git-grep
    BUILTIN git-hash-object
    BUILTIN git-help
    BUILTIN git-index-pack
    BUILTIN git-init-db
    BUILTIN git-log
    BUILTIN git-ls-files
    BUILTIN git-ls-remote
    BUILTIN git-ls-tree
    BUILTIN git-mailinfo
    BUILTIN git-mailsplit
    BUILTIN git-merge
    BUILTIN git-merge-base
    BUILTIN git-merge-file
    BUILTIN git-merge-index
    BUILTIN git-merge-ours
    BUILTIN git-merge-recursive
    BUILTIN git-merge-tree
    BUILTIN git-mktag
    BUILTIN git-mktree
    BUILTIN git-mv
    BUILTIN git-name-rev
    BUILTIN git-notes
    BUILTIN git-pack-objects
    BUILTIN git-pack-redundant
    BUILTIN git-pack-refs
    BUILTIN git-patch-id
    BUILTIN git-prune-packed
    BUILTIN git-prune
    BUILTIN git-push
    BUILTIN git-read-tree
    BUILTIN git-receive-pack
    BUILTIN git-reflog
    BUILTIN git-remote
    BUILTIN git-replace
    BUILTIN git-rerere
    BUILTIN git-reset
    BUILTIN git-rev-list
    BUILTIN git-rev-parse
    BUILTIN git-revert
    BUILTIN git-rm
    BUILTIN git-send-pack
    BUILTIN git-shortlog
    BUILTIN git-show-branch
    BUILTIN git-show-ref
    BUILTIN git-stripspace
    BUILTIN git-symbolic-ref
    BUILTIN git-tag
    BUILTIN git-tar-tree
    BUILTIN git-unpack-file
    BUILTIN git-unpack-objects
    BUILTIN git-update-index
    BUILTIN git-update-ref
    BUILTIN git-update-server-info
    BUILTIN git-upload-archive
    BUILTIN git-var
    BUILTIN git-verify-pack
    BUILTIN git-verify-tag
    BUILTIN git-write-tree
    BUILTIN git-cherry
    BUILTIN git-cherry-pick
    BUILTIN git-format-patch
    BUILTIN git-fsck-objects
    BUILTIN git-get-tar-commit-id
    BUILTIN git-init
    BUILTIN git-merge-subtree
    BUILTIN git-peek-remote
    BUILTIN git-repo-config
    BUILTIN git-show
    BUILTIN git-stage
    BUILTIN git-status
    BUILTIN git-whatchanged
    SUBDIR git-gui
GITGUI_VERSION = 0.12.0.64.g89d6
    * new locations or Tcl/Tk interpreter
    GEN git-gui
    INDEX lib/
    MSGFMT    po/de.msg 520 translated.
    MSGFMT    po/el.msg 381 translated, 4 fuzzy, 6 untranslated.
    MSGFMT    po/fr.msg 520 translated.
    MSGFMT    po/hu.msg 514 translated.
    MSGFMT    po/it.msg 519 translated, 1 untranslated.
    MSGFMT    po/ja.msg 520 translated.
    MSGFMT    po/nb.msg 474 translated, 39 untranslated.
    MSGFMT    po/ru.msg 513 translated, 2 untranslated.
    MSGFMT    po/sv.msg 520 translated.
    MSGFMT po/zh_cn.msg 366 translated, 7 fuzzy, 17 untranslated.
    SUBDIR gitk-git
    GEN gitk-wish
Generating catalog po/de.msg
msgfmt --statistics --tcl po/de.po -l de -d po/
289 translated messages.
Generating catalog po/es.msg
msgfmt --statistics --tcl po/es.po -l es -d po/
200 translated messages, 7 untranslated messages.
Generating catalog po/fr.msg
msgfmt --statistics --tcl po/fr.po -l fr -d po/
276 translated messages, 4 fuzzy translations.
Generating catalog po/hu.msg
msgfmt --statistics --tcl po/hu.po -l hu -d po/
288 translated messages.
Generating catalog po/it.msg
msgfmt --statistics --tcl po/it.po -l it -d po/
283 translated messages, 6 untranslated messages.
Generating catalog po/ja.msg
msgfmt --statistics --tcl po/ja.po -l ja -d po/
284 translated messages.
Generating catalog po/ru.msg
msgfmt --statistics --tcl po/ru.po -l ru -d po/
245 translated messages.
Generating catalog po/sv.msg
msgfmt --statistics --tcl po/sv.po -l sv -d po/
289 translated messages.
    SUBDIR perl
cp Git.pm blib/lib/Git.pm
Manifying blib/man3/Git.3pm
    SUBDIR git_remote_helpers
    SUBDIR templates
    CC test-chmtime.o
    LINK test-chmtime
    CC test-ctype.o
    LINK test-ctype
    CC test-date.o
    LINK test-date
    CC test-delta.o
    LINK test-delta
    CC test-dump-cache-tree.o
    LINK test-dump-cache-tree
    CC test-genrandom.o
    LINK test-genrandom
    CC test-match-trees.o
    LINK test-match-trees
    CC test-parse-options.o
    LINK test-parse-options
    CC test-path-utils.o
    LINK test-path-utils
    CC test-run-command.o
    LINK test-run-command
    CC test-sha1.o
    LINK test-sha1
    CC test-sigchain.o
    LINK test-sigchain
    CC test-index-version.o
    LINK test-index-version
    GEN bin-wrappers/git
    GEN bin-wrappers/git-upload-pack
    GEN bin-wrappers/git-receive-pack
    GEN bin-wrappers/git-upload-archive
    GEN bin-wrappers/git-shell
    GEN bin-wrappers/git-cvsserver
    GEN bin-wrappers/test-chmtime
    GEN bin-wrappers/test-ctype
    GEN bin-wrappers/test-date
    GEN bin-wrappers/test-delta
    GEN bin-wrappers/test-dump-cache-tree
    GEN bin-wrappers/test-genrandom
    GEN bin-wrappers/test-match-trees
    GEN bin-wrappers/test-parse-options
    GEN bin-wrappers/test-path-utils
    GEN bin-wrappers/test-run-command
    GEN bin-wrappers/test-sha1
    GEN bin-wrappers/test-sigchain
    GEN bin-wrappers/test-index-version
6.  Install Git.
6.1  Login as root.
6.2  [root]# cd /home/git0/git-source/git-1.6.3.4
6.3  [root]# make prefix=/usr install
6.3 SAMPLE of GOOD OUTPUT for 1.7.1 install:
[root]# make prefix=/usr install
    SUBDIR git-gui
    SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR git_remote_helpers
    SUBDIR templates
install -d -m 755 '/usr/bin'
install -d -m 755 '/usr/libexec/git-core'
install   git-fast-import git-imap-send git-shell git-show-index 
git-upload-pack
 git-http-backend git-http-fetch git-http-push git-daemon git-remote-http 
git-re
mote-https git-remote-ftp git-remote-ftps git-am git-bisect 
git-difftool--helper
 git-filter-branch git-lost-found git-merge-octopus git-merge-one-file 
git-merge
-resolve git-mergetool git-pull git-quiltimport git-rebase--interactive 
git-reba
se git-repack git-request-pull git-stash git-submodule git-web--browse 
git-add--
interactive git-difftool git-archimport git-cvsexportcommit git-cvsimport 
git-cv
sserver git-relink git-send-email git-svn  git-instaweb 
'/usr/libexec/git-core'
install -m 644  git-mergetool--lib git-parse-remote git-sh-setup 
'/usr/libexec/g
it-core'
install git git-upload-pack git-receive-pack git-upload-archive git-shell 
git-cv
sserver '/usr/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/home/git0/git-source/git-1.7.1/templates'
install -d -m 755 '/usr/share/git-core/templates'
(cd blt && tar cf - .) | \
        (cd '/usr/share/git-core/templates' && umask 022 && tar xof -)
make[1]: Leaving directory `/home/git0/git-source/git-1.7.1/templates'
make -C perl prefix='/usr' DESTDIR='' install
make[1]: Entering directory `/home/git0/git-source/git-1.7.1/perl'
make[2]: Entering directory `/home/git0/git-source/git-1.7.1/perl'
Installing /usr/lib/perl5/site_perl/5.8.8/Git.pm
Installing /usr/share/man/man3/Git.3pm
Writing 
/usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/Git/.pac
klist
Appending installation info to 
/usr/lib64/perl5/5.8.8/x86_64-linux-thread-multi/
perllocal.pod
make[2]: Leaving directory `/home/git0/git-source/git-1.7.1/perl'
make[1]: Leaving directory `/home/git0/git-source/git-1.7.1/perl'
make -C git_remote_helpers prefix='/usr' DESTDIR='' install
make[1]: Entering directory 
`/home/git0/git-source/git-1.7.1/git_remote_helpers'

/usr/bin/python setup.py install --prefix /usr
running install
running build
running build_py
running install_lib
copying build/lib/git_remote_helpers/git/git.py -> 
/usr/lib/python2.4/site-packa
ges/git_remote_helpers/git
copying build/lib/git_remote_helpers/git/__init__.py -> 
/usr/lib/python2.4/site-
packages/git_remote_helpers/git
copying build/lib/git_remote_helpers/util.py -> 
/usr/lib/python2.4/site-packages
/git_remote_helpers
copying build/lib/git_remote_helpers/__init__.py -> 
/usr/lib/python2.4/site-pack
ages/git_remote_helpers
byte-compiling 
/usr/lib/python2.4/site-packages/git_remote_helpers/git/git.py to
 git.pyc
byte-compiling 
/usr/lib/python2.4/site-packages/git_remote_helpers/git/__init__.
py to __init__.pyc
byte-compiling /usr/lib/python2.4/site-packages/git_remote_helpers/util.py 
to ut
il.pyc
byte-compiling 
/usr/lib/python2.4/site-packages/git_remote_helpers/__init__.py t
o __init__.pyc
make[1]: Leaving directory 
`/home/git0/git-source/git-1.7.1/git_remote_helpers'
make -C gitk-git install
make[1]: Entering directory `/home/git0/git-source/git-1.7.1/gitk-git'
install -m 755 gitk-wish '/usr/bin'/gitk
install -d -m 755 '/usr/share/gitk/lib/msgs'
install -m 644 po/de.msg '/usr/share/gitk/lib/msgs' &&  install -m 644 
po/es.msg
 '/usr/share/gitk/lib/msgs' &&  install -m 644 po/fr.msg 
'/usr/share/gitk/lib/ms
gs' &&  install -m 644 po/hu.msg '/usr/share/gitk/lib/msgs' &&  install -m 
644 p
o/it.msg '/usr/share/gitk/lib/msgs' &&  install -m 644 po/ja.msg 
'/usr/share/git
k/lib/msgs' &&  install -m 644 po/ru.msg '/usr/share/gitk/lib/msgs' && 
install
-m 644 po/sv.msg '/usr/share/gitk/lib/msgs' && true
make[1]: Leaving directory `/home/git0/git-source/git-1.7.1/gitk-git'
make -C git-gui gitexecdir='/usr/libexec/git-core' install
make[1]: Entering directory `/home/git0/git-source/git-1.7.1/git-gui'
  DEST /usr/libexec/git-core
    INSTALL 755 git-gui
    INSTALL 755 git-gui--askpass
    LINK        git-citool -> git-gui
  DEST /usr/share/git-gui/lib
    INSTALL 644 tclIndex
    INSTALL 644 about.tcl
    INSTALL 644 blame.tcl
    INSTALL 644 branch.tcl
    INSTALL 644 branch_checkout.tcl
    INSTALL 644 branch_create.tcl
    INSTALL 644 branch_delete.tcl
    INSTALL 644 branch_rename.tcl
    INSTALL 644 browser.tcl
    INSTALL 644 checkout_op.tcl
    INSTALL 644 choose_font.tcl
    INSTALL 644 choose_repository.tcl
    INSTALL 644 choose_rev.tcl
    INSTALL 644 class.tcl
    INSTALL 644 commit.tcl
    INSTALL 644 console.tcl
    INSTALL 644 database.tcl
    INSTALL 644 date.tcl
    INSTALL 644 diff.tcl
    INSTALL 644 encoding.tcl
    INSTALL 644 error.tcl
    INSTALL 644 index.tcl
    INSTALL 644 logo.tcl
    INSTALL 644 merge.tcl
    INSTALL 644 mergetool.tcl
    INSTALL 644 option.tcl
    INSTALL 644 remote.tcl
    INSTALL 644 remote_add.tcl
    INSTALL 644 remote_branch_delete.tcl
    INSTALL 644 search.tcl
    INSTALL 644 shortcut.tcl
    INSTALL 644 spellcheck.tcl
    INSTALL 644 sshkey.tcl
    INSTALL 644 status_bar.tcl
    INSTALL 644 themed.tcl
    INSTALL 644 tools.tcl
    INSTALL 644 tools_dlg.tcl
    INSTALL 644 transport.tcl
    INSTALL 644 win32.tcl
    INSTALL 644 git-gui.ico
    INSTALL 644 win32_shortcut.js
  DEST /usr/share/git-gui/lib/msgs
    INSTALL 644 de.msg
    INSTALL 644 el.msg
    INSTALL 644 fr.msg
    INSTALL 644 hu.msg
    INSTALL 644 it.msg
    INSTALL 644 ja.msg
    INSTALL 644 nb.msg
    INSTALL 644 ru.msg
    INSTALL 644 sv.msg
    INSTALL 644 zh_cn.msg
make[1]: Leaving directory `/home/git0/git-source/git-1.7.1/git-gui'
bindir=$(cd '/usr/bin' && pwd) && \
        execdir=$(cd '/usr/libexec/git-core' && pwd) && \
        { test "$bindir/" = "$execdir/" || \
                { rm -f "$execdir/git" && \
                test -z "" && \
                ln "$bindir/git" "$execdir/git" 2>/dev/null || \
                cp "$bindir/git" "$execdir/git"; } ; } && \
        { for p in  git-add git-annotate git-apply git-archive 
git-bisect--helpe
r git-blame git-branch git-bundle git-cat-file git-check-attr 
git-check-ref-form
at git-checkout-index git-checkout git-clean git-clone git-commit-tree 
git-commi
t git-config git-count-objects git-describe git-diff-files git-diff-index 
git-di
ff-tree git-diff git-fast-export git-fetch-pack git-fetch git-fmt-merge-msg 
git-
for-each-ref git-fsck git-gc git-grep git-hash-object git-help 
git-index-pack gi
t-init-db git-log git-ls-files git-ls-remote git-ls-tree git-mailinfo 
git-mailsp
lit git-merge git-merge-base git-merge-file git-merge-index git-merge-ours 
git-m
erge-recursive git-merge-tree git-mktag git-mktree git-mv git-name-rev 
git-notes
 git-pack-objects git-pack-redundant git-pack-refs git-patch-id 
git-prune-packed
 git-prune git-push git-read-tree git-receive-pack git-reflog git-remote 
git-rep
lace git-rerere git-reset git-rev-list git-rev-parse git-revert git-rm 
git-send-
pack git-shortlog git-show-branch git-show-ref git-stripspace 
git-symbolic-ref g
it-tag git-tar-tree git-unpack-file git-unpack-objects git-update-index 
git-upda
te-ref git-update-server-info git-upload-archive git-var git-verify-pack 
git-ver
ify-tag git-write-tree git-cherry git-cherry-pick git-format-patch 
git-fsck-obje
cts git-get-tar-commit-id git-init git-merge-subtree git-peek-remote 
git-repo-co
nfig git-show git-stage git-status git-whatchanged; do \
                rm -f "$execdir/$p" && \
                ln "$execdir/git" "$execdir/$p" 2>/dev/null || \
                ln -s "git" "$execdir/$p" 2>/dev/null || \
                cp "$execdir/git" "$execdir/$p" || exit; \
          done; } && \
        { for p in git-remote-https git-remote-ftp git-remote-ftps; do \
                rm -f "$execdir/$p" && \
                ln "$execdir/git-remote-http" "$execdir/$p" 2>/dev/null || \
                ln -s "git-remote-http" "$execdir/$p" 2>/dev/null || \
                cp "$execdir/git-remote-http" "$execdir/$p" || exit; \
          done; } && \
        ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
[root]#
7.  Validate Git.
7.1  See what version of git is installed.
[neal]$ git --version
7.2  See where git is installed.
[neal]$ git --exec-path
7.3  VNC to gui desktop.
Open Terminal.
[neal]$ gitk  validate that gitk executes and displays.
[neal]$ git gui  validate that git gui executes and displays.
Note:  Only after you have a local repository working tree can you can 
validate xdg-utils as follows:
<Repository> -> <Browse Master's Files>  validate's xdg-utils.


GIT INSTALL.  PART 2.  INSTALL GIT RELATED TOOLS.
1.  Install KDiff3.  Merge tool.
1.1  [root]# yum list kdiff3  (See if its already installed.)
1.2  [root]# yum install kdiff3  (Install it if it is not already 
installed.)
1.3  [root]# yum list kdiff3  (Verify that it is installed.)
1.3  SAMPLE OUTPUT:
kdiff3.x86_64                      0.9.92-14.el5 
installed


Like I said, this is what has worked for me.  Hope this helps!

(If anyone has any *PROVEN* improvements and/or additions to my procedures 
then by all means let me know...)


v/r,
Neal 
