From: Michael Blume <blume.mike@gmail.com>
Subject: Re: Test failure
Date: Sat, 8 Nov 2014 21:44:24 -0800
Message-ID: <CAO2U3Qhgg4KULYnK7LG1saHsad85Owz+082FX-ROTGoWWO6NAg@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 06:44:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnLJ0-0003Ro-1u
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 06:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbaKIFoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 00:44:46 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:55750 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbaKIFop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 00:44:45 -0500
Received: by mail-oi0-f49.google.com with SMTP id u20so4085548oif.36
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 21:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lim9JoU28Prfgxo72GoQb5TmXs3D8pC9PkbUUxeQ0Ds=;
        b=0JO7r4ynB9xlit8MFJkIJV1JOBDDsU4JGXXX0kWJXE5oGeSNAmbl/97lQg6c1wtyGt
         I3C4tUlXYSKfYK685P8XSXzp/YYpr/VET/fhKV+eF8x+CMXBwkmgykQy6K59byn6YY8+
         11aECACln9ekyeLVc2oBXQU0rprMVkPzk4XAu6xF83LONVb/GwlZ0tLHZXs3ZGUKFJ9t
         yQvQtjeytM34Qi+j94AvytVY4yN5CcEjsnvAwhdXAFp1LcuXtsqeC0BTCj6w4bMteMwK
         FXuKcKl/Vb8rEZ+noikhZlkIg3Of/QGuvgyVrZ0VKxGWKEu9lmIxLOI7N8V4wsNEM72J
         AyZw==
X-Received: by 10.182.71.77 with SMTP id s13mr19426377obu.43.1415511884543;
 Sat, 08 Nov 2014 21:44:44 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Sat, 8 Nov 2014 21:44:24 -0800 (PST)
In-Reply-To: <20141109014354.GA23883@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ ./t1410-reflog.sh -v -i
Initialized empty Git repository in
/Users/michael.blume/workspace/git/t/trash
directory.t1410-reflog/.git/
expecting success:
mkdir -p A/B &&
echo rat >C &&
echo ox >A/D &&
echo tiger >A/B/E &&
git add . &&

test_tick && git commit -m rabbit &&
H=`git rev-parse --verify HEAD` &&
A=`git rev-parse --verify HEAD:A` &&
B=`git rev-parse --verify HEAD:A/B` &&
C=`git rev-parse --verify HEAD:C` &&
D=`git rev-parse --verify HEAD:A/D` &&
E=`git rev-parse --verify HEAD:A/B/E` &&
check_fsck &&

test_chmod +x C &&
git add C &&
test_tick && git commit -m dragon &&
L=`git rev-parse --verify HEAD` &&
check_fsck &&

rm -f C A/B/E &&
echo snake >F &&
echo horse >A/G &&
git add F A/G &&
test_tick && git commit -a -m sheep &&
F=`git rev-parse --verify HEAD:F` &&
G=`git rev-parse --verify HEAD:A/G` &&
I=`git rev-parse --verify HEAD:A` &&
J=`git rev-parse --verify HEAD` &&
check_fsck &&

rm -f A/G &&
test_tick && git commit -a -m monkey &&
K=`git rev-parse --verify HEAD` &&
check_fsck &&

check_have A B C D E F G H I J K L &&

git prune &&

check_have A B C D E F G H I J K L &&

check_fsck &&

test_line_count = 4 .git/logs/refs/heads/master

[master (root-commit) 07fcc4f] rabbit
 Author: A U Thor <author@example.com>
 3 files changed, 3 insertions(+)
 create mode 100644 A/B/E
 create mode 100644 A/D
 create mode 100644 C
Checking object directories: 100% (256/256), done.
[master 7d1a0b8] dragon
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 C
Checking object directories: 100% (256/256), done.
[master 15ab5f0] sheep
 Author: A U Thor <author@example.com>
 4 files changed, 2 insertions(+), 2 deletions(-)
 delete mode 100644 A/B/E
 create mode 100644 A/G
 delete mode 100755 C
 create mode 100644 F
Checking object directories: 100% (256/256), done.
[master 3ac530f] monkey
 Author: A U Thor <author@example.com>
 1 file changed, 1 deletion(-)
 delete mode 100644 A/G
Checking object directories: 100% (256/256), done.
tree
tree
blob
blob
blob
blob
blob
commit
tree
commit
commit
commit
tree
tree
blob
blob
blob
blob
blob
commit
tree
commit
commit
commit
Checking object directories: 100% (256/256), done.
ok 1 - setup

expecting success:
test_tick && git reset --hard HEAD~2 &&
test -f C &&
test -f A/B/E &&
! test -f F &&
! test -f A/G &&

check_have A B C D E F G H I J K L &&

git prune &&

check_have A B C D E F G H I J K L &&

test_line_count = 5 .git/logs/refs/heads/master

HEAD is now at 7d1a0b8 dragon
tree
tree
blob
blob
blob
blob
blob
commit
tree
commit
commit
commit
tree
tree
blob
blob
blob
blob
blob
commit
tree
commit
commit
commit
ok 2 - rewind

expecting success:

corrupt $F &&
check_fsck "missing blob $F"


Checking object directories: 100% (256/256), done.
missing blob 9ae84adb2704cbd49549e52169b4043871e13432
ok 3 - corrupt and check

expecting success:

git reflog expire --dry-run \
--expire=$(($test_tick - 10000)) \
--expire-unreachable=$(($test_tick - 10000)) \
--stale-fix \
--all &&

test_line_count = 5 .git/logs/refs/heads/master &&

check_fsck "missing blob $F"

would prune commit: sheep
would prune commit: monkey
would prune reset: moving to HEAD~2
would prune commit: sheep
would prune commit: monkey
would prune reset: moving to HEAD~2
Checking object directories: 100% (256/256), done.
missing blob 9ae84adb2704cbd49549e52169b4043871e13432
ok 4 - reflog expire --dry-run should not touch reflog

expecting success:

git reflog expire --verbose \
--expire=$(($test_tick - 10000)) \
--expire-unreachable=$(($test_tick - 10000)) \
--stale-fix \
--all &&

test_line_count = 2 .git/logs/refs/heads/master &&

check_fsck "dangling commit $K"

Marking reachable objects...
keep commit (initial): rabbit
keep commit: dragon
prune commit: sheep
prune commit: monkey
prune reset: moving to HEAD~2
keep commit (initial): rabbit
keep commit: dragon
prune commit: sheep
prune commit: monkey
prune reset: moving to HEAD~2
Checking object directories: 100% (256/256), done.
dangling commit 3ac530f2f6c3a45206a6b2d455baf89d1c8f672d
ok 5 - reflog expire

expecting success:

git prune &&
check_fsck &&

check_have A B C D E H L &&
check_dont_have F G I J K


Checking object directories: 100% (256/256), done.
tree
tree
blob
blob
blob
commit
commit
fatal: git cat-file 9ae84adb2704cbd49549e52169b4043871e13432: bad file
fatal: git cat-file 41ca11d3340423c1922fe4110d2327bda0891b45: bad file
fatal: git cat-file 1fe0f573dce6e694ce16e98a936c65db295d1948: bad file
fatal: git cat-file 15ab5f0ad4d9117a7cdcbea9673ec0fff6ca8e55: bad file
fatal: git cat-file 3ac530f2f6c3a45206a6b2d455baf89d1c8f672d: bad file
ok 6 - prune and fsck

expecting success:

recover $F &&
check_fsck "dangling blob $F"


Checking object directories: 100% (256/256), done.
dangling blob 9ae84adb2704cbd49549e52169b4043871e13432
ok 7 - recover and check

expecting success:
echo 1 > C &&
test_tick &&
git commit -m rat C &&

echo 2 > C &&
test_tick &&
git commit -m ox C &&

echo 3 > C &&
test_tick &&
git commit -m tiger C &&

HEAD_entry_count=$(git reflog | wc -l) &&
master_entry_count=$(git reflog show master | wc -l) &&

test $HEAD_entry_count = 5 &&
test $master_entry_count = 5 &&


git reflog delete master@{1} &&
git reflog show master > output &&
test $(($master_entry_count - 1)) = $(wc -l < output) &&
test $HEAD_entry_count = $(git reflog | wc -l) &&
! grep ox < output &&

master_entry_count=$(wc -l < output) &&

git reflog delete HEAD@{1} &&
test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
test $master_entry_count = $(git reflog show master | wc -l) &&

HEAD_entry_count=$(git reflog | wc -l) &&

git reflog delete master@{07.04.2005.15:15:00.-0700} &&
git reflog show master > output &&
test $(($master_entry_count - 1)) = $(wc -l < output) &&
! grep dragon < output


[master b60a214] rat
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[master 9908ef9] ox
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[master b93561f] tiger
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
ok 8 - delete

expecting success:

test_tick && git reset --hard HEAD~2 &&
test_line_count = 4 .git/logs/refs/heads/master

HEAD is now at b60a214 rat
ok 9 - rewind2

expecting success:

git reflog expire --verbose \
--expire=never \
--expire-unreachable=never \
--all &&
test_line_count = 4 .git/logs/refs/heads/master

keep commit (initial): rabbit
keep commit: dragon
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
keep commit (initial): rabbit
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
ok 10 - --expire=never

expecting success:

git config gc.reflogexpire never &&
git config gc.reflogexpireunreachable never &&
git reflog expire --verbose --all &&
test_line_count = 4 .git/logs/refs/heads/master

keep commit (initial): rabbit
keep commit: dragon
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
keep commit (initial): rabbit
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
ok 11 - gc.reflogexpire=never

expecting success:

git config gc.reflogexpire false &&
git config gc.reflogexpireunreachable false &&
git reflog expire --verbose --all &&
test_line_count = 4 .git/logs/refs/heads/master &&

git config --unset gc.reflogexpire &&
git config --unset gc.reflogexpireunreachable


keep commit (initial): rabbit
keep commit: dragon
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
keep commit (initial): rabbit
keep commit: rat
keep commit: tiger
keep reset: moving to HEAD~2
ok 12 - gc.reflogexpire=false

expecting success:
test $(git reflog master | wc -l) = 4 &&
git branch foo &&
git pack-refs --all &&
git checkout foo &&
test $(git reflog master | wc -l) = 4

Switched to branch 'foo'
ok 13 - checkout should not delete log for packed ref

expecting success:
test_when_finished "git branch -d a || git branch -d a/b" &&

git branch a/b master &&
echo "a/b@{0} branch: Created from master" >expect &&
git log -g --format="%gd %gs" a/b >actual &&
test_cmp expect actual &&
git branch -d a/b &&

# now logs/refs/heads/a is a stale directory, but
# we should move it out of the way to create "a" reflog
git branch a master &&
echo "a@{0} branch: Created from master" >expect &&
git log -g --format="%gd %gs" a >actual &&
test_cmp expect actual

fatal: ambiguous argument 'a/b': both revision and filename
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
not ok 14 - stale dirs do not cause d/f conflicts (reflogs on)
#
# test_when_finished "git branch -d a || git branch -d a/b" &&
#
# git branch a/b master &&
# echo "a/b@{0} branch: Created from master" >expect &&
# git log -g --format="%gd %gs" a/b >actual &&
# test_cmp expect actual &&
# git branch -d a/b &&
#
# # now logs/refs/heads/a is a stale directory, but
# # we should move it out of the way to create "a" reflog
# git branch a master &&
# echo "a@{0} branch: Created from master" >expect &&
# git log -g --format="%gd %gs" a >actual &&
# test_cmp expect actual
#

On Sat, Nov 8, 2014 at 5:43 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 08, 2014 at 11:28:32AM -0800, Michael Blume wrote:
>
>> When I build and run tests I get
>>
>> [11:17][michael.blume@tcc-michael-4:~/workspace/git/t(master)]$
>> ./t1410-reflog.sh
>
> What does "./t1410-reflog.sh -v -i" report?
>
>> A quick search seems to indicate the test is pretty new?
>> http://www.mail-archive.com/git@vger.kernel.org/msg60495.html
>
> Yes, it is new. In these cases there's often some silly little
> platform incompatibility in the test script, but I don't see one. So
> maybe the incompatibility is in the code itself; I'm wondering if
> OS X returns something besides EISDIR when trying to open a directory.
>
> Unfortunately I don't have an OS X install handy to test on.
>
> -Peff
