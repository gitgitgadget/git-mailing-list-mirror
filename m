From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Massive testsuite failure on !(Linux || Solaris 8+)
Date: Sun, 25 Apr 2010 03:40:45 -0500 (CDT)
Message-ID: <20100316100917.GA27121@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 10:41:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xOu-0007wn-0h
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab0DYIkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:40:49 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:51416 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0DYIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:40:47 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id BA1465CCD
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 09:01:48 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com BA1465CCD
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 057369A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:40:46 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id C17F157C; Sun, 25 Apr 2010 03:40:45 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145732>

These test failures are from git-1.7.0.2 after having applied the most
recent series of patches I posted -- git does not even compile on the
affected hosts without these patches, so I can't test at all without
them.  With the same patches applied, Linux and Solaris 8 through 10
on sparc and ix86 pass the entire suite, so I don't think I have
broken something with the patches themselves.

I'm experiencing around 70% test failures on Solaris 2.6 and 7, HP-UX
10.20 through 11.31 on both ia64 and hppa, AIX 5.1.0.0 through 6.1,
Tru64 Unix 5.1, and to a much lesser (maybe 35% test failures) extent
on mips IRIX 6.5.

I have full logs on all hosts, up until t9300 test 120, which hangs (I
left it overnight to be sure since some of these machines are quite
old and slow) the testsuite until SIGINT.  The logs are, obviously,
huge so I won't post them here, just an excerpt of the typical
failures from the beginning and end of the testlogs on hppa HP-UX
11.31 (a very recent release):

gmake aggregate-results-and-cleanup
gmake[2]: Entering directory `/opt/build/git-1.7.0.2/t'
*** t0000-basic.sh ***
*   ok 1: .git/objects should be empty after git init in an empty
repo.
*   ok 2: .git/objects should have 3 subdirectories.
*   ok 3: success is reported like this
*   still broken 4: pretend we have a known breakage
*   FIXED 5: pretend we have fixed a known breakage
*   ok 6: test runs if prerequisite is satisfied
* skip 7: unmet prerequisite causes test to be skipped
*   ok 8: git update-index without --add should fail adding.
*   ok 9: git update-index with --add should succeed.
*   ok 10: writing tree out with git write-tree
*   ok 11: validate object ID of a known tree.
*   ok 12: git update-index without --remove should fail removing.
*   ok 13: git update-index with --remove should be able to remove.
*   ok 14: git write-tree should be able to write an empty tree.
*   ok 15: validate object ID of a known tree.
*   ok 16: adding various types of objects with git update-index
--add.
*   ok 17: showing stage with git ls-files --stage
* FAIL 18: validate git ls-files output for a known tree.
        test_cmp expected current
*   ok 19: writing tree out with git write-tree.
*   ok 20: validate object ID for a known tree.
*   ok 21: showing tree with git ls-tree
* FAIL 22: git ls-tree output for a known tree.
        test_cmp expected current
*   ok 23: showing tree with git ls-tree -r
* FAIL 24: git ls-tree -r output for a known tree.
        test_cmp expected current
*   ok 25: showing tree with git ls-tree -r -t
* FAIL 26: git ls-tree -r output for a known tree.
        test_cmp expected current
*   ok 27: writing partial tree out with git write-tree --prefix.
*   ok 28: validate object ID for a known tree.
*   ok 29: writing partial tree out with git write-tree --prefix.
*   ok 30: validate object ID for a known tree.
*   ok 31: put invalid objects into the index.
*   ok 32: writing this tree without --missing-ok.
*   ok 33: writing this tree with --missing-ok.
*   ok 34: git read-tree followed by write-tree should be idempotent.
* FAIL 35: validate git diff-files output for a know cache/work tree
state.
        git diff-files >current && test_cmp current expected >/dev/null
*   ok 36: git update-index --refresh should succeed.
*   ok 37: no diff after checkout and git update-index --refresh.
*   ok 38: git commit-tree records the correct tree in a commit.
*   ok 39: git commit-tree records the correct parent in a commit.
*   ok 40: git commit-tree omits duplicated parent in a commit.
*   ok 41: update-index D/F conflict
*   ok 42: absolute path works as expected
*   ok 43: very long name in the index handled sanely
* fixed 1 known breakage(s)
* still have 1 known breakage(s)
* failed 5 among remaining 42 test(s)
gmake[2]: *** [t0000-basic.sh] Error 1
*** t0001-init.sh ***
*   ok 1: plain
*   ok 2: plain with GIT_WORK_TREE
*   ok 3: plain bare
*   ok 4: plain bare with GIT_WORK_TREE
*   ok 5: GIT_DIR bare
*   ok 6: init --bare
*   ok 7: GIT_DIR non-bare
*   ok 8: GIT_DIR & GIT_WORK_TREE (1)
*   ok 9: GIT_DIR & GIT_WORK_TREE (2)
* FAIL 10: reinit
        
        
                (
                        unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
        
                        mkdir again &&
                        cd again &&
                        git init >out1 2>err1 &&
                        git init >out2 2>err2
                ) &&
                grep "Initialized empty" again/out1 &&
                grep "Reinitialized existing" again/out2 &&
                >again/empty &&
                test_cmp again/empty again/err1 &&
                test_cmp again/empty again/err2
        
* FAIL 11: init with --template
        
                mkdir template-source &&
                echo content >template-source/file &&
                (
                        mkdir template-custom &&
                        cd template-custom &&
                        git init --template=../template-source
                ) &&
                test_cmp template-source/file template-custom/.git/file
        
*   ok 12: init with --template (blank)
*   ok 13: init --bare/--shared overrides system/global config
*   ok 14: init honors global core.sharedRepository
*   ok 15: init rejects insanely long --template
*   ok 16: init creates a new directory
*   ok 17: init creates a new bare directory
*   ok 18: init recreates a directory
*   ok 19: init recreates a new bare directory
*   ok 20: init creates a new deep directory
*   ok 21: init creates a new deep directory (umask vs. shared)
*   ok 22: init notices EEXIST (1)
*   ok 23: init notices EEXIST (2)
*   ok 24: init notices EPERM
* failed 2 among 24 test(s)
gmake[2]: *** [t0001-init.sh] Error 1

Things deteriorate quickly from here on in, until the testsuite
hangs up pending a SIGINT here:

*** t9300-fast-import.sh ***
*   ok 1: A: create pack from stdin
*   ok 2: A: verify pack
* FAIL 3: A: verify commit
        git cat-file commit master | sed 1d >actual &&
                test_cmp expect actual
* FAIL 4: A: verify tree
        git cat-file -p master^{tree} | sed "s/ [0-9a-f]*       / /" >actual &&
                 test_cmp expect actual
* FAIL 5: A: verify file2
        git cat-file blob master:file2 >actual && test_cmp expect actual
* FAIL 6: A: verify file3
        git cat-file blob master:file3 >actual && test_cmp expect actual
* FAIL 7: A: verify file4
        git cat-file blob master:file4 >actual && test_cmp expect actual
* FAIL 8: A: verify tag/series-A
        
                git cat-file tag tags/series-A >actual &&
                test_cmp expect actual
        
* FAIL 9: A: verify marks output
        test_cmp expect marks.out
* FAIL 10: A: verify marks import
        git fast-import \
                        --import-marks=marks.out \
                        --export-marks=marks.new \
                        </dev/null &&
                test_cmp expect marks.new
*   ok 11: A: verify marks import does not crash
*   ok 12: A: verify pack
* FAIL 13: A: verify diff
        compare_diff_raw expect actual &&
                 test `git rev-parse --verify master:file2` \
                    = `git rev-parse --verify verify--import-marks:copy-of-file2`
*   ok 14: B: fail on invalid blob sha1
*   ok 15: B: fail on invalid branch name ".badbranchname"
*   ok 16: B: fail on invalid branch name "bad[branch]name"
*   ok 17: B: accept branch name "TEMP_TAG"
*   ok 18: C: incremental import create pack from stdin
*   ok 19: C: verify pack
*   ok 20: C: validate reuse existing blob
* FAIL 21: C: verify commit
        git cat-file commit branch | sed 1d >actual &&
                 test_cmp expect actual
* FAIL 22: C: validate rename result
        compare_diff_raw expect actual
*   ok 23: D: inline data in commit
*   ok 24: D: verify pack
* FAIL 25: D: validate new files added
        compare_diff_raw expect actual
* FAIL 26: D: verify file5
        git cat-file blob branch:newdir/interesting >actual &&
                 test_cmp expect actual
* FAIL 27: D: verify file6
        git cat-file blob branch:newdir/exec.sh >actual &&
                 test_cmp expect actual
*   ok 28: E: rfc2822 date, --date-format=raw
*   ok 29: E: rfc2822 date, --date-format=rfc2822
*   ok 30: E: verify pack
* FAIL 31: E: verify commit
        git cat-file commit branch | sed 1,2d >actual &&
                test_cmp expect actual
* FAIL 32: F: non-fast-forward update skips
        if git fast-import <input
                 then
                        echo BAD gfi did not fail
                        return 1
                 else
                        if test $old_branch = `git rev-parse --verify branch^0`
                        then
                                : branch unaffected and failure returned
                                return 0
                        else
                                echo BAD gfi changed branch $old_branch
                                return 1
                        fi
                 fi
                
*   ok 33: F: verify pack
* FAIL 34: F: verify other commit
        git cat-file commit other >actual &&
                test_cmp expect actual
*   ok 35: G: non-fast-forward update forced
*   ok 36: G: verify pack
*   ok 37: G: branch changed, but logged
*   ok 38: H: deletall, add 1
*   ok 39: H: verify pack
* FAIL 40: H: validate old files removed, new files added
        compare_diff_raw expect actual
* FAIL 41: H: verify file
        git cat-file blob H:h/e/l/lo >actual &&
                 test_cmp expect actual
*   ok 42: I: export-pack-edges
* FAIL 43: I: verify edge list
        sed -e s/pack-.*pack/pack-.pack/ edges.list >actual &&
                 test_cmp expect actual
*   ok 44: J: reset existing branch creates empty commit
*   ok 45: J: branch has 1 commit, empty tree
*   ok 46: K: reinit branch with from
*   ok 47: K: verify K^1 = branch^1
* FAIL 48: L: verify internal tree sorting
        git fast-import <input &&
                 git diff-tree --abbrev --raw L^ L >output &&
                 test_cmp expect output
* FAIL 49: M: rename file in same subdirectory
        git fast-import <input &&
                 git diff-tree -M -r M1^ M1 >actual &&
                 compare_diff_raw expect actual
* FAIL 50: M: rename file to new subdirectory
        git fast-import <input &&
                 git diff-tree -M -r M2^ M2 >actual &&
                 compare_diff_raw expect actual
* FAIL 51: M: rename subdirectory to new subdirectory
        git fast-import <input &&
                 git diff-tree -M -r M3^ M3 >actual &&
                 compare_diff_raw expect actual
* FAIL 52: N: copy file in same subdirectory
        git fast-import <input &&
                 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
                 compare_diff_raw expect actual
* FAIL 53: N: copy then modify subdirectory
        git fast-import <input &&
                 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
                 compare_diff_raw expect actual
*   ok 54: N: copy dirty subdirectory
*   ok 55: O: comments are all skipped
*   ok 56: O: blank lines not necessary after data commands
*   ok 57: O: repack before next test
* FAIL 58: O: blank lines not necessary after other commands
        git fast-import <input &&
                 test 8 = `find .git/objects/pack -type f | wc -l` &&
                 test `git rev-parse refs/tags/O3-2nd` = `git rev-parse O3^` &&
                 git log --reverse --pretty=oneline O3 | sed s/^.*z// >actual &&
                 test_cmp expect actual
* FAIL 59: O: progress outputs as requested by input
        git fast-import <input >actual &&
                 grep "progress " <input >expect &&
                 test_cmp expect actual
*   ok 60: P: supermodule & submodule mix
*   ok 61: P: verbatim SHA gitlinks
*   ok 62: P: fail on inline gitlink
*   ok 63: P: fail on blob mark in gitlink
*   ok 64: Q: commit notes
*   ok 65: Q: verify pack
* FAIL 66: Q: verify first commit
        git cat-file commit notes-test~2 | sed 1d >actual &&
                test_cmp expect actual
* FAIL 67: Q: verify second commit
        git cat-file commit notes-test^ | sed 1d >actual &&
                test_cmp expect actual
* FAIL 68: Q: verify third commit
        git cat-file commit notes-test | sed 1d >actual &&
                test_cmp expect actual
* FAIL 69: Q: verify first notes commit
        git cat-file commit refs/notes/foobar~2 | sed 1d >actual &&
                test_cmp expect actual
* FAIL 70: Q: verify first notes tree
        git cat-file -p refs/notes/foobar~2^{tree} | sed "s/ [0-9a-f]*  / /" >actual &&
                 test_cmp expect actual
* FAIL 71: Q: verify first note for first commit
        git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual
* FAIL 72: Q: verify first note for second commit
        git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual
* FAIL 73: Q: verify first note for third commit
        git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual
* FAIL 74: Q: verify second notes commit
        git cat-file commit refs/notes/foobar^ | sed 1d >actual &&
                test_cmp expect actual
* FAIL 75: Q: verify second notes tree
        git cat-file -p refs/notes/foobar^^{tree} | sed "s/ [0-9a-f]*   / /" >actual &&
                 test_cmp expect actual
* FAIL 76: Q: verify second note for first commit
        git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual
* FAIL 77: Q: verify first note for second commit
        git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual
* FAIL 78: Q: verify first note for third commit
        git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual
* FAIL 79: Q: verify third notes commit
        git cat-file commit refs/notes/foobar2 | sed 1d >actual &&
                test_cmp expect actual
* FAIL 80: Q: verify third notes tree
        git cat-file -p refs/notes/foobar2^{tree} | sed "s/ [0-9a-f]*   / /" >actual &&
                 test_cmp expect actual
* FAIL 81: Q: verify third note for first commit
        git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual
* FAIL 82: Q: verify fourth notes commit
        git cat-file commit refs/notes/foobar | sed 1d >actual &&
                test_cmp expect actual
* FAIL 83: Q: verify fourth notes tree
        git cat-file -p refs/notes/foobar^{tree} | sed "s/ [0-9a-f]*    / /" >actual &&
                 test_cmp expect actual
* FAIL 84: Q: verify second note for second commit
        git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual
*   ok 85: R: abort on unsupported feature
*   ok 86: R: supported feature is accepted
*   ok 87: R: abort on receiving feature after data command
*   ok 88: R: only one import-marks feature allowed per stream
*   ok 89: R: export-marks feature results in a marks file being created
*   ok 90: R: export-marks options can be overriden by commandline options
* FAIL 91: R: import to output marks works without any content
        cat input | git fast-import &&
            test_cmp marks.out marks.new
* FAIL 92: R: import marks prefers commandline marks file over the stream
        cat input | git fast-import --import-marks=marks.out &&
            test_cmp marks.out marks.new
* FAIL 93: R: multiple --import-marks= should be honoured
        
            head -n2 marks.out > one.marks &&
            tail -n +3 marks.out > two.marks &&
            git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
            test_cmp marks.out combined.marks
        
* FAIL 94: R: feature relative-marks should be honoured
        
            mkdir -p .git/info/fast-import/ &&
            cp marks.new .git/info/fast-import/relative.in &&
            git fast-import <input &&
            test_cmp marks.new .git/info/fast-import/relative.out
        
* FAIL 95: R: feature no-relative-marks should be honoured
        
            git fast-import <input &&
            test_cmp marks.new non-relative.out
        
* FAIL 96: R: quiet option results in no stats being output
        
            cat input | git fast-import 2> output &&
            test_cmp empty output
        
*   ok 97: R: die on unknown option
*   ok 98: R: unknown commandline options are rejected
*   ok 99: R: ignore non-git options
*   ok 100: R: blob bigger than threshold
*   ok 101: R: verify created pack
* FAIL 102: R: verify written objects
        git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
                 test_cmp expect actual &&
                 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
                 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
                 test $a = $b
FATAL: Unexpected exit with SIGINT
gmake[2]: *** [t9300-fast-import.sh] Error 130
gmake[1]: *** [all] Interrupt
gmake: *** [test] Interrupt

Hope that helps,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
