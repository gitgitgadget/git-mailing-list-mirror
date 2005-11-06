From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: git binary directory?
Date: Sun, 6 Nov 2005 14:13:59 +0100
Message-ID: <20051106131359.GA9055@puritan.petwork>
References: <436D2269.6090605@slamail.org> <436D276F.7010302@slamail.org> <EC1099E0-0854-4361-9B61-E7728264985A@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Nov 06 14:15:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYkLZ-000713-Cm
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 14:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVKFNOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 08:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKFNOF
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 08:14:05 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:22144 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750804AbVKFNOE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 08:14:04 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep02.bredband.com with ESMTP
          id <20051106131401.DXQI16437.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Sun, 6 Nov 2005 14:14:01 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id 34B2FADFE2; Sun,  6 Nov 2005 14:14:00 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <EC1099E0-0854-4361-9B61-E7728264985A@hawaga.org.uk>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11212>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Ben Clifford wrote:

> On 6 Nov 2005, at 08:43, Yaacov Akiba Slama wrote:

> > In addition custom tab completion can be quite easily added to bash
> > and zsh.

> Anyone done this already for git? I've been slowly adding bits to
> Paolo Giarrusso's bash/stg tab completion code to provide some
> completion for cogito, but haven't got round to git yet.

Here’s something I’m planning on sending to the Zsh list.  It’s still
incomplete, and I don’t know all the commands well enough yet to write
the more generic completion parts (like completing repositories,
branches, commit ids, remotes, and such).  Perhaps someone can help out
with that?  All comments welcome.

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=_git
Content-Transfer-Encoding: quoted-printable

#compdef git-apply git-checkout-index git-commit-tree git-hash-object git-i=
nit-db git-merge-index git-mktag git-pack-objects git-prune-packed git-read=
-tree git-unpack-objects git-update-index git-write-tree git-cat-file git-d=
iff-index git-diff-files git-diff-stages git-diff-tree git-fsck-objects git=
-ls-files git-ls-tree git-merge-base git-rev-list git-show-index git-tar-tr=
ee git-unpack-file git-var git-verify-pack git-clone-pack git-fetch-pack gi=
t-http-fetch git-local-fetch git-peek-remote git-receive-pack git-send-pack=
 git-ssh-fetch git-ssh-upload git-update-server-info git-upload-pack git-ad=
d git-applymbox git-bisect git-branch git-checkout git-cherry-pick git-clon=
e git-commit git-diff git-fetch git-format-patch git-grep git-log git-ls-re=
mote git-merge git-octopus git-pull git-push git-rebase git-rename git-repa=
ck git-reset git-resolve git-revert git-shortlog git-show-branch git-status=
 git-verify-tag git-whatchanged git-applypatch git-archimport git-convert-o=
bjects git-cvsimport git-merge-one-file git-prune git-relink git-sh-setup g=
it-tag git-cherry git-count-objects git-daemon git-get-tar-commit-id git-ma=
ilinfo git-mailsplit git-patch-id git-parse-remote git-request-pull git-rev=
-parse git-send-email git-stripspace

# TODO: most commands need a valid git repository to run, so add a check fo=
r it
# so that we can make our handling a little bit cleaner (need to deal with
# GIT_DIR=3D... stuff as pre-command modifier)

# TODO: tree-ish should probably be using __git_comimit_ids2

local ret=3D1

_call_function ret _$words[1]

# TODO: perhaps only allow *.patch for files
_git-apply () {
  _arguments \
    '*--exclude=3D-[skip files matching specified pattern]:file pattern' \
    '*--no-merge[do not use merge behavior]' \
    '*--stat[output diffstat for the input]' \
    '*--summary[output summary of git-diff extended headers]' \
    '*--check[check if patches are applicable]' \
    '*--index[make sure that the patch is applicable to the index]' \
    '*--show-files[show summary of files that are affected by the patches]'=
 \
    '*--apply[apply patches that would otherwise not be applied]' \
    '*:file:_files' && ret=3D0
}

_git-checkout-index () {
  _arguments -S \
    '(-u --index)'{-u,--index}'[update stat information in index]' \
    '(-q --quiet)'{-q,--quiet}'[do not complain about existing files or mis=
sing files]' \
    '(-f --force)'{-f,--force}'[force overwrite of existing files]' \
    '(-a --all)'{-a,--all}'[check out all files in the index]' \
    '(-n --no-create)'{-n,--no-create}'[do not checkout new files]' \
    '*--prefix=3D-[prefix to use when creating files]:directory:_directorie=
s' \
    '*:file:_files' && ret=3D0
}

_git-commit-tree () {
  if (( CURRENT =3D=3D 2 )); then
    _guard "[[:xdigit:]]#" "tree object" && ret=3D0
  else
    local context state line
    typeset -A opt_args

    _arguments \
    '*-p: :_guard "[[\:xdigit\:]]#" "commit object that should act as a par=
ent to the tree"' \
    '*: :->nothing'

    ret=3D0
  fi
}

_git-hash-object () {
  _arguments \
    '-t[the type of object to create]:object type:((blob\:"a blob of data"
                                                    commit\:"a tree with pa=
rent commits"
                                                    tag\:"a symbolic name f=
or another object"
                                                    tree\:"a recursive tree=
 of blobs"))' \
    '-w[write the object to the object database]' \
    '*:file:_files' && ret=3D0
}

_git-init-db () {
  _arguments \
    '--template=3D-[directory to use as a template for the object database]=
:directory:_directories' && ret=3D0
}

_git-merge-index () {
  if (( CURRENT > 2 )) && [[ $words[CURRENT-1] !=3D -[oq] ]]; then
    _arguments -S \
      '-a[run merge against all files in the index that need merging]' \
      '*:file:_files' && ret=3D0
  else
    typeset -a arguments

    (( CURRENT =3D=3D 2 )) && arguments+=3D'-o[skip failed merges]'
    (( CURRENT =3D=3D 2 || CURRENT =3D=3D 3 )) && arguments+=3D'(-o)-q[do n=
ot complain about failed merges]'
    (( 2 <=3D CURRENT && CURRENT <=3D 4 )) && arguments+=3D'*:merge program=
:_files -g "*(*)"'

    _arguments $arguments && ret=3D0
  fi
}

_git-mktag () {
  _message 'no arguments allowed; only accepts tags on standard input'
}

_git-pack-objects () {
  _arguments \
    '--incremental[ignore objects that have already been packed]' \
    '--window=3D-[number of objects to use per delta compression]' \
    '--depth=3D-[maximum delta depth]' \
    '(:)--stdout[write the pack to standard output]' \
    ':base-name:_files' && ret=3D0
}

_git-prune-packed () {
  _arguments \
    '-n[only list the objects that would be removed]' && ret=3D0
}

# TODO: --trivial and --reset (undocumented)
_git-read-tree () {
  if (( CURRENT =3D=3D 2 )); then
    _arguments \
      ': :_guard "[[\:xdigit\:]]#" "tree-ish to be read into the index"' &&=
 ret=3D0
  elif [[ $words[2] =3D=3D -m ]]; then
    _arguments \
      '-u[update the work tree after successful merge]' \
      '-i[update only the index; ignore changes in work tree]' \
      '2: :_guard "[[\:xdigit\:]]#" "first tree-ish to be read/merged"' \
      '3: :_guard "[[\:xdigit\:]]#" "second tree-ish to be read/merged"' \
      '4: :_guard "[[\:xdigit\:]]#" "third tree-ish to be read/merged"' && =
ret=3D0
  else
    _message 'no more arguments'
  fi
}

_git-unpack-objects () {
  _arguments \
    '-n[only list the objects that would be unpacked]' \
    '-q[run quietly]' && ret=3D0
}

_git-update-index () {
  _arguments -S \
    '-q[run quietly]' \
    '--add[add files not already in the index]' \
    '--remove[remove files that are in the index but are missing from the w=
ork tree]' \
    '--refresh[refresh the index]' \
    '--ignore-missing[ignore missing files when refreshing the index]' \
    '--cacheinfo[insert information directly into the cache]: :_guard "[0-7=
]#" "octal file mode": :_guard "[[\:xdigit\:]]#" "object id":file:_files' \
    '--info-only[only insert files object-IDs into index]' \
    '--force-remove[remove files from both work tree and the index]' \
    '--replace[replace files already in the index if necessary]' \
    '--stdin[read list of paths from standard input]' \
    '-z[paths are separated with NUL instead of LF for --stdin]' \
    '*:file:_files' && ret=3D0
}

_git-write-tree () {
  _arguments \
    '--missing-ok[ignore objects in the index that are missing in the objec=
t database]' && ret=3D0
}

_git-cat-file () {
  if (( CURRENT =3D=3D 2 )); then
    _arguments \
      '-t[show the type of the given object]' \
      '-s[show the size of the given object]' \
      '*: :_values "object type" blob commit tag tree' && ret=3D0
  elif (( CURRENT =3D=3D 3 )); then
    _guard "[[:xdigit:]]#" "object id" && ret=3D0
  else
    _message 'no more arguments'
  fi
}

typeset -ga diff_args

# TODO: -s and --diff-filter are undocumented
diff_args=3D(
  '-p[generate diff in patch format]'
  '-u[synonym for -p]'
  '-z[use NUL termination on output]'
  '-l-[number of rename/copy targets to run]: :_guard "[[\:digit\:]]#" numb=
er'
  '--name-only[show only names of changed files]'
  '--name-status[show only names and status of changed files]'
  '-R[do a reverse diff]'
  '-S-[look for differences that contain the given string]:string'
  '-s[do not produce any output]'
  '-O-[output patch in the order of glob-pattern lines in given file]:file:=
_files'
  '--diff-filter=3D-[filter to apply to diff]'
  '--pickaxe-all[when -S finds a change, show all changes in that changeset=
]'
  '-B-[break complete rewrite changes into pairs of given size]: :_guard "[=
[\:digit\:]]#" size'
  '-M-[detect renames with given score]: :_guard "[[\:digit\:]]#" size'
  '-C-[detect copies as well as renames with given score]: :_guard "[[\:dig=
it\:]]#" size'
  '--find-copies-harder[try harder to find copies]'
)

typeset -g pretty_arg=3D
pretty_arg=3D'--pretty=3D-[pretty print commit messages]::pretty print:((ra=
w\:"the raw commits"
                                                                     medium=
\:"most parts of the messages"
                                                                     short\=
:"few headers and only subject of messages"
                                                                     full\:=
"all parts of the commit messages"
                                                                     onelin=
e\:"commit-ids and subject of messages"))'

_git-diff-index () {
  _arguments -S \
    $diff_args \
    '-r[recurse into subdirectories]' \
    '-m[flag non-checked-out files as up-to-date]' \
    '--cached[do not consider the work tree at all]' \
    ': :_guard "[[\:xdigit\:]]#" "tree-ish"' \
    '*:file:_files' && ret=3D0
}

_git-diff-files () {
  _arguments \
    $diff_args \
    '-q[do not complain about nonexisting files]' \
    '*:file:_files' && ret=3D0
}

_git-diff-stages () {
  _arguments \
    $diff_args \
    ': :_guard "[[\:digit\:]]#" "stage 1 number"' \
    ': :_guard "[[\:digit\:]]#" "stage 2 number"' \
    '*:file:_files' && ret=3D0
}

_git-diff-tree () {
  _arguments -S \
    $diff_args \
    $pretty_arg \
    '-r[recurse into subdirectories]' \
    '-t[show tree entry itself as well as subtrees (implies -r)]' \
    '-m[show merge commits]' \
    '-v[show verbose headers]' \
    '--stdin[read commit and tree information from standard input]' \
    '--root[show diff against the empty tree]' \
    ': :_guard "[[\:xdigit\:]]#" "tree-ish"' \
    ':: :_guard "[[\:xdigit\:]]#" "tree-ish"' \
    '*:file:_files' && ret=3D0
}

_git-fsck-objects () {
  _arguments -S \
    '--cache[consider objects recorded in the index as head nodes for reach=
ability traces]' \
    '--full[check all object directories]'
    '--root[show root nodes]' \
    '--standalone[check only the current object directory]' \
    '--strict[do strict checking]' \
    '--tags[show tags]' \
    '--unreachable[show objects that are unreferenced in the object databas=
e]' \
    '*: :_guard "[[\:xdigit\:]]#" "object id"' && ret=3D0
}

# TODO: need to handle names with whitespace
# TODO: do we actually need _wanted?
__git_files () {
  local expl

  # TODO: deal with GIT_DIR
  if [[ $_git_file_cache_pwd !=3D $PWD ]]; then
    _git_file_cache=3D("${(@f)$(git-ls-files 2>/dev/null)}")
    _git_file_cache_pwd=3D$PWD
  fi

  _wanted files expl 'index file' _multi_parts / _git_file_cache
}

__git_tree_files () {
  local expl
  typeset -a tree_file_cache

  tree_file_cache=3D("${(@f)$(git-ls-tree -r $1 | awk '{print $4}')}")

  _wanted files expl 'tree file' _multi_parts / tree_file_cache
}

# TODO: am I using _wanted correctly?  Need to learn _wanted and _describe
__git_commit_ids () {
  local commits

  commits=3D("${(@f)$(git-rev-list HEAD 2>/dev/null)}")
  if (( $? =3D=3D 0 )); then
    _wanted commits expl 'commit ids' compadd - $commits
  else
    _message 'not a git repository'
  fi
}

__git_commit_ids2 () {
  compset -P '\\\^'
  __git_commit_ids
}

__git_heads () {
  local expl heads

  heads=3D("${(@f)$(ls "$(git-rev-parse 2>/dev/null)/refs/heads" 2>/dev/nul=
l)}")
  if (( $? =3D=3D 0 )); then
    _wanted heads expl 'heads' compadd - HEAD $heads
  else
    _message 'not a git repository'
  fi
}

_git-ls-files () {
  _arguments -S \
  '(-c --cached)'{-c,--cached}'[show cached files in the output]' \
  '(-d --deleted)'{-d,--deleted}'[show deleted files in the output]' \
  '(-i --ignored)'{-i,--ignored}'[show ignored files in the output]' \
  '(-k --killed)'{-k,--killed}'[show killed files in the output]' \
  '(-m --modified)'{-m,--modified}'[show modified files in the output]' \
  '(-o --others)'{-o,--others}'[show other files in the output]' \
  '(-s --stage)'{-s,--stage}'[show stage files in the output]' \
  '-t[identify each files status]' \
  '(-u --unmerged)'{-u,--unmerged}'[show unmerged files in the output]' \
  '*'{-x,--exclude=3D-}'[skip files matching given pattern]:file pattern' \
  '*'{-X,--exclude-from=3D-}'[skip files matching patterns in given file]:f=
ile:_files' \
  '*--exclude-per-directory=3D-[skip directories matching patterns in given=
 file]:file:_files' \
  '-z[use NUL termination on output]' \
  '*:index file:__git_files' && ret=3D0
}

_git-ls-tree () {
  local tree

  for word in $words[2,-1]; do
    if [[ $word !=3D -* ]]; then
      tree=3D$word
      break
    fi
  done

  _arguments \
  '-d[do not show children of given tree]' \
  '-r[recurse into subdirectories]' \
  '-z[use NUL termination on output]' \
  ': :_guard "[[\:xdigit\:]]#" "tree-ish"' \
  '*:tree file:{[[ -n $tree ]] && __git_tree_files $tree}' && ret=3D0
}

_git-merge-base () {
  _arguments \
  '(-a --all)'{-a,--all}'[show all common ancestors]' \
  ':commit id 1:__git_commit_ids' \
  ':commit id 2:__git_commit_ids' && ret=3D0
}

# TODO: --show-breaks only valid if --merge-order specified
# TODO --all undocumented
_git-rev-list () {
  _arguments \
  $pretty_arg \
  '--all[show all commits]' \
  '--bisect[show only the middlemost commit object]' \
  '--objects[show object ids of objects referenced by the listed commits]' \
  '--max-age[maximum age of commits to output]: :_guard "[[\:digit\:]]#" nu=
mber' \
  '--max-count[maximum number of commits to output]: :_guard "[[\:digit\:]]=
#" timestamp' \
  '--merge-order[decompose into minimal and maximal epochs]' \
  '--min-age[minimum age of commits to output]: :_guard "[[\:digit\:]]#" ti=
mestamp' \
  '--objects[show all objects]' \
  '--parents[show parent commits]' \
  '--show-breaks[show commit prefixes]' \
  '--unpacked[show only unpacked commits]' \
  '--header[show commit headers]' \
  '*:commit id:__git_commit_ids2' && ret=3D0
}

_git-show-index () {
  _message 'no arguments allowed; accepts index file on standard input'
}

_git-tar-tree () {
  _arguments \
    ': :_guard "[[\:xdigit\:]]#" "tree-ish"' \
    ':base-name:_files' && ret=3D0
}

_git-unpack-file () {
  _arguments \
    ': :_guard "[[\:xdigit\:]]#" "blob id"' && ret=3D0
}

_git-var () {
  _arguments \
    - variables \
      '-l[show logical variables]' \
      ':variable' && ret=3D0
}

_git-verify-pack () {
  _arguments -S \
    '-v[show objects contained in pack]' \
    '*:index file:_files -g "*.idx"' && ret=3D0
}
=20
# FIXME: these should be imported from _ssh
# TODO: this should take -/ to only get directories
_remote_files () {
  # There should be coloring based on all the different ls -F classifiers.
  local expl rempat remfiles remdispf remdispd args suf ret=3D1

  if zstyle -T ":completion:${curcontext}:files" remote-access; then
    zparseopts -D -E -a args p: 1 2 4 6 F:
    if [[ -z $QIPREFIX ]]
    then rempat=3D"${PREFIX%%[^./][^/]#}\*"
    else rempat=3D"${(q)PREFIX%%[^./][^/]#}\*"
    fi
    remfiles=3D(${(M)${(f)"$(_call_program files ssh $args -a -x ${IPREFIX%=
:} ls -d1FL "$rempat" 2>/dev/null)"}%%[^/]#(|/)})
    compset -P '*/'
    compset -S '/*' || suf=3D'remote file'

#    remdispf=3D(${remfiles:#*/})
    remdispd=3D(${(M)remfiles:#*/})

    _tags files
    while _tags; do
      while _next_label files expl ${suf:-remote directory}; do
#        [[ -n $suf ]] && compadd "$@" "$expl[@]" -d remdispf \
#	    ${(q)remdispf%[*=3D@|]} && ret=3D0=20
	compadd ${suf:+-S/} "$@" "$expl[@]" -d remdispd \
	    ${(q)remdispd%/} && ret=3D0
      done
      (( ret )) || return 0
    done
    return ret
  else
    _message -e remote-files 'remote file'
  fi
}

typeset -g exec_arg=3D
exec_arg=3D'--exec=3D-[specify path to git-upload-pack on remote side]:remo=
te path'

__git-remote-repository () {
  local service

  service=3D _ssh

  if compset -P '*:'; then
    _remote_files && ret=3D0
  else
    _alternative \
      'directories::_directories' \
      'hosts:host:_ssh_hosts -S:' && ret=3D0
  fi
}

__git-any-repositories () {
  _alternative \
    'files::_files' \
    'remote repositories::__git-remote-repository' && ret=3D0
}

__git_ref_spec () {
}=20

# TODO: how about curcontext? (-C)
__git-clone_or_fetch-pack () {
  _arguments \
    $exec_arg \
    '-q[run quietly]' \
    ':remote repository:__git-remote-repository' \
    '*:head:__git_heads' && ret=3D0
}

_git-clone-pack () {
  __git-clone_or_fetch-pack
}

_git-fetch-pack () {
  __git-clone_or_fetch-pack
}

typeset -ga fetch_args

fetch_args=3D(
  '-a[fetch all objects]'
  '-c[fetch commit objects]'
  '--recover[recover from a failed fetch]'
  '-t[fetch trees associated with commit objects]'
  '-v[show what is downloaded]'
  '-w[write out the given commit-id to the given file]:new file'
)

__git-http_or_ssh-fetch () {
  _arguments \
    $fetch_args \
    ':commit id:__git_commit_ids' \
    ':URL:_urls' && ret=3D0
}

# TODO: __git_commit_ids appropriate here?
_git-http-fetch () {
  __git-http_or_ssh-fetch
}

_git-local-fetch () {
  _arguments \
    $fetch_args \
    '-l[hard-link objects]' \
    '-n[do not copy objects]' \
    '-s[sym-link objects]' \
    ':commit id:__git_commit_ids' \
    ':directory:_directories' && ret=3D0
}

_git-peek-remote () {
  _arguments \
    $exec_arg \
    ':remote repository:__git-remote-repository' && ret=3D0
}

_git-receive-pack () {
  _arguments \
    ':directory:_directories' && ret=3D0
}

_git-send-pack () {
  _arguments \
    $exec_arg \
    '--all[update all refs that exist locally]' \
    '--force[update remote orphaned refs]' \
    ':remote repository:__git-remote-repository' \
    '*:remote refs' && ret=3D0
}

_git-ssh-fetch () {
  __git-http_or_ssh-fetch
}

_git-ssh-upload () {
  __git-http_or_ssh-fetch
}

_git-update-server-info () {
  _arguments \
    '(-f --force)'{-f,--force}'[update the info files from scratch]'
}

_git-upload-pack () {
  _arguments \
    ':directory:_directories' && ret=3D0
}

_git-add () {
  _arguments \
    '-n[do not actually add files; only show which ones would be added]' \
    '-v[show files as they are added]' \
    '*:file:_files' && ret=3D0
}

__git_signoff_file () {
  _alternative \
    'signoffs:signoff:(yes true me please)' \
    'files::_files' && ret=3D0
}

# TODO: for -c: add support for .dotest/ prefix
_git-applymbox () {
  _arguments \
    '-k[do not modify Subject: header]' \
    '-q[apply patches interactively]' \
    '-u[encode commit information in UTF-8]' \
    '(1)-c[restart command after fixing an unclean patch]:patch:_files' \
    ':mbox file:_files' \
    '::signoff file:__git_signoff_file' && ret=3D0
}

_git-bisect () {
  local bisect_cmds

  bisect_cmds=3D(
    bad:"mark current or given revision as bad"
    good:"mark current or given revision as good"
    log:"show the log of the current bisection"
    next:"find next bisection to test and check it out"
    replay:"replay a bisection log"
    reset:"finish bisection search and return to the given branch (or maste=
r)"
    start:"reset bisection state and start a new bisection"
    visualize:"show the remaining revisions in gitk"
  )

  if (( CURRENT =3D=3D 2 )); then
    _describe -t command "git-bisect commands" bisect_cmds && ret=3D0
  else
    case $words[2] in
      (bad)
        _arguments \
          '2:revision:__git_commit_ids' && ret=3D0
        ;;
      (good)
        _arguments \
          '*:revision:__git_commit_ids' && ret=3D0
        ;;
      (replay)
        _arguments \
          '2:file:_files' && ret=3D0
        ;;
      (reset)
        _arguments \
          '2:branch:__git_heads' && ret=3D0
        ;;
      (*)
        _message 'no arguments allowed' && ret=3D0
        ;;
    esac
  fi
}

_git-branch () {
  _arguments \
    ':branch-name'
    ':base branch:__git_heads' && ret=3D0
}

# TODO: here, branch can be any object ID that resolves to a commit.  How d=
o we
# deal with that? _alternative on __git_heads, __git_tags, and __git_commit=
_ids?
# git-rev-parse?
_git-checkout () {
  _arguments \
    '-f[force a complete re-read]' \
    '-b[create a new branch based at given branch]:branch-name' \
    ':branch:__git_heads' && ret=3D0
}

_git-cherry-pick () {
  _arguments \
    '(-n --no-commit)'{-n,--no-commit}'[do not make the actually commit]' \
    '(-r --replay)'{-r,--replay}'[use the original commit message intact]' \
    ':commit id:__git_commit_ids' && ret=3D0
}

# TODO: should support rsync completion here as well
_git-clone () {
  _arguments \
    '(-l --local)'{-l,--local}'[perform a local cloning of a repository]' \
    '(-s --shared)'{-s,--shared}'[share the objects with the source reposit=
ory]' \
    '(-q --quiet)'{-q,--quiet}'[operate quietly]' \
    '-n[do not checkout HEAD after clone is complete]' \
    '(-u --upload-pack)'{-u,--uploadpack}'[specify path to git-upload-pack =
on remote side]:remote path' \
    ':repository:__git-any-repositories' \
    ':directory:_directories' && ret=3D0
}

_git-commit () {
  _arguments -S \
    '(-a --all)'{-a,--all}'[update all paths in the index file]' \
    '(-s --signoff)'{-s,--signoff}'[add Signed-off-by line at the end of th=
e commit message]' \
    '(-v --verify)'{-v,--verify}'[look for suspicious lines the commit intr=
oduces]' \
    '(-n --no-verify)'{-n,--no-verify}'[do not look for suspicious lines th=
e commit introduces]' \
    '(-e --edit)'{-e,--edit}'[edit the commit message before committing]' \
    '*:file:_files' \
    - '(message)' \=20
      '(-c -C --reedit-message --reuse-message)'{-c,--reedit-message=3D}'[u=
se existing commit object and edit log message]::commit id:__git_commit_ids=
' \
      '(-c -C --reedit-message --reuse-message)'{-c,--reuse-message=3D}'[us=
e existing commit object with same log message]::commit id:__git_commit_ids=
' \
      '(-F --file)'{-F,--file=3D}'[read commit message from given file]:fil=
e:_files' \
      '(-m --message)'{-m,--message=3D}'[use the given message as the commi=
t message]:message' && ret=3D0
}

_git-diff () {
  _arguments \
    $diff_args \
    '::commit id 1:__git_commit_ids2' \
    '::commit id 2:__git_commit_ids2' \
    '*:file:_files' && ret=3D0
}

# TODO: --tags undocumented
_git-fetch () {
  _arguments \
    '(-a --append)'{-a,--append}'[append fetched refs instead of overwritin=
g]' \
    '(-f --force)'{-f,--force}'[allow refs that are not ancestors to be upd=
ated]' \
    '(-t --tags)'{-t,--tags}'[use tags]' \
    '(-u --update-head-ok)'{-u,--update-head-ok}'[allow updates of current =
branch head]' \
    ':repository:__git-any-repositories' \
    '*:refspec:__git_ref_spec' && ret=3D0
}

_git-format-patch () {
  _arguments \
    '(-a --author)'{-a,--author}'[output From: header for your own commits =
as well]' \
    '--date[output Date: header for your own commits as well]' \
    '-o[store resulting files in given directory]:directory:_directories' \
    '-k[do not strip/add \[PATCH\] from the first line of the commit messag=
e]' \
    '--mbox[use true mbox formatted output]' \
    '-n[name output in \[PATCH n/m\] format]' \
    ':their commit id:__git_commit_ids2' \
    '::my commit id:__git_commit_ids2' && ret=3D0
}


# TODO: repository needs fixing
# TODO: reference needs fixing
# TODO: references can be extracted with this command: $(ls-remote ./.)
# TODO: tags can be extracted with this command: $(ls-remote --tags ./.)
_git-ls-remote () {
  _arguments \
    '--heads[show only refs under refs/heads]' \
    '--tags[show only refs under refs/tags]' \
    ':repository:__git-any-repositories' \
    '*:reference' && ret=3D0
}

# TODO: document merge strategies
# TODO: <head> argument right?
# TODO: <remote> argument right?
_git-merge () {
  _arguments \
    '(-n --no-summary)'{-n,--no-summary}'[do not show diffstat at end of me=
rge]' \
    {-s,--strategy}'[use given merge strategy]:strategy:(octopus recursive =
resolve stupid)' \
    ':merge message' \
    ':head:__git_commit_ids2' \
    ':remote:__git_commit_ids2' && ret=3D0
}

_git-mv () {
  _arguments \
    '-f[force renaming/moving even if targets exist]' \
    '-k[skip move/renames that would lead to errors]' \
    '-n[only show what would happen]' \
    '*:file:_files' && ret=3D0
}

_git-octupus () {
  _message 'no arguments allowed' && ret=3D0
}

_git-rebase () {
  _arguments \
    ':upstream branch:__git_commit_ids2' \
    '::working branch:__git_commit_ids2' && ret=3D0
}

_git-rename () {
  _arguments \
    ':source index file:__git_files' \
    ':destination file:_files' && ret=3D0
}

# TODO: -l option (--local)
_git-repack () {
  _arguments \
    '-a[pack all objects into a single pack]' \
    '-d[remove redundant packs after packing]' \
    '-n[do not update server information]' && ret=3D0
}

_git-reset () {
  _arguments \
    - (levels) \
      '--mixed[like --soft but report what has not been updated (default)]'=
 \
      '--soft[do not touch the index file nor the working tree]' \
      '--hard[match the working tree and index to the given tree]' \
      ':commit-ish:__git_commit_ids2' && ret=3D0
}

_git-resolve () {
  _arguments \
    ':current commit:__git_commit_ids2' \
    ':merged commit:__git_commit_ids2' \
    ':commit message'
}

_git-revert () {
  _arguments \
    '(-n --no-commit)'{-n,--no-commit}'[do not commit the reversion]'
      ':commit:__git_commit_ids2' && ret=3D0
}

_git-shortlog () {
  _message 'no arguments allowed' && ret=3D0
}

# TODO: reference ($GIT_DIR/refs)
_git-show-branch () {
  _arguments \
    '--all[show all refs under $GIT_DIR/refs]' \
    '--heads[show all refs under $GIT_DIR/refs/heads]' \
    '--independent[show only the reference that can not be reached from any=
 of the other]' \
    '--list[do not display any commit ancestry]' \
    '--merge-base[act like "git-merge-base -a" but with two heads]' \
    '--more=3D-[go given number of commit beyond common ancestor (no ancest=
ry if negative)]:number' \
    '--no-name[do not show naming strings for each commit]' \
    '--sha1-name[name commits with unique prefix of object names]' \
    '--tags[show all refs under $GIT_DIR/refs/tags]' \
    '*:reference' && ret=3D0
}

_git-status () {
  _message 'no arguments allowed' && ret=3D0
}

# TODO: tag
_git-verify-tag () {
  _arguments \
    ':tag'
}

# ---





_git-applypatch () {
  _arguments \
    ':message file:_files' \
    ':patch file:_files' \
    ':info file:_files' \
    '::signoff file:_files' && ret=3D0
}

_git-convert-objects () {
  _arguments \
    ': :_guard "[[:xdigit:]]#" "object id"' && ret=3D0
}




# TODO: right to use __git_commit_ids2?  Should be branches
_git-cherry () {
  _arguments \
    '-v[be verbose]' \
    ':upstream:__git_commit_ids2' \
    '::head:__git_commit_ids2' && ret=3D0
}

_git-count-objects () {
  _message 'no arguments allowed' && ret=3D0
}

# TODO: do better than _directory?
_git-daemon () {
  _arguments -S \
    '--export-all[allow pulling from all repositories without verification]=
' \
    '(--port)--inetd[run server as an inetd service]' \
    '--init-timeout=3D-[specify timeout between connection and request]' \
    '--port=3D-[specify port to listen to]' \
    '--syslog[log to syslog instead of stderr]' \
    '--timeout=3D-[specify timeout for sub-requests]' \
    '--verbose[log details about incoming connections and requested files]'=
 \
    '*:repository:_directory' && ret=3D0
}

_git-get-tar-commit-id () {
  _message 'no arguments allowed; accepts tar-file on standard input' && re=
t=3D0
}

_git-mailinfo () {
  _arguments \
    '-k[do not strip/add \[PATCH\] from the first line of the commit messag=
e]' \
    '-u[encode commit information in UTF-8]' \
    ':message file:_files' \
    ':patch file:_files' && ret=3D0
}

_git-mailsplit () {
  _arguments \
    '-d-[specify number of leading zeros]: :_guard "[[\:digit\:]]#" "precis=
ion' \
    ':mbox file/directory:_files' \
    '::directory:_directories' && ret=3D0
}

_git-patch-id () {
  _message 'no arguments allowed; accepts patch on standard input' && ret=
=3D0
}



_git-request-pull () {
  _arguments \
    ':start commit:__git_commit_ids2' \
    ':url:_urls' \
    ':end commit:__git_commit_ids2'
}



_git-send-email () {
  _arguments \
    '--compose[use $EDITOR to edit an introductory message for the patch se=
ries]' \
    '--from[specify the sender of the emails]' \
    '--in-reply-to[specify the contents of the first In-Reply-To header]' \
    '--smtp-server[specify the outgoing smtp server]:smtp server:_hosts' \
    '--subject[specify the initial subject of the email thread]' \
    '--to[specify the primary recipient of the emails]' \
    - (chain) \
      '--chain-reply-to[each email will be sent as a reply to the previous =
one sent]' \
      '--no-chain-reply-to[all emails after the first will be sent as repli=
es to the first one]' && ret=3D0
}

# TODO: still undocumented
_git-symref () {
}

_git-stripspace () {
  _message 'no arguments allowed; accepts input file on standard input' && =
ret=3D0
}

--DocE+STaALJfprDB--
