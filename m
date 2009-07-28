From: Josh ben Jore <jbenjore@whitepages.com>
Subject: Fw: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Tue, 28 Jul 2009 15:23:00 -0700
Message-ID: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVv4Z-0007SS-VN
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 00:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbZG1WW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 18:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZG1WW4
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 18:22:56 -0400
Received: from mail0.w3data.com ([38.112.225.178]:13005 "EHLO
	hub.corp.w3data.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754521AbZG1WWz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 18:22:55 -0400
Received: from post.corp.w3data.com ([172.18.0.206]) by hub ([172.25.0.29])
 with mapi; Tue, 28 Jul 2009 15:23:01 -0700
Thread-Topic: Fw: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Thread-Index: AcoP0fc8wRvvOodwQIK8HY8frNNfdg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124288>

Hello there,
With apologies, I am resending the previous message after taking care to strip gdb's dump of the object->sha1 pointers and replace them with the contents of gdb's "x/4 $thing->object->sha1". I heard from one of you that gmail showed only random crud. It looked ok to me. Sorry for the annoyance.

The original message follows. I hope this one goes through ok.

...

Hello there,
Im trying to merge some branches together but all git versions from v1.6.0.4..origin/master which is
currently df73af5f667a479764d2b2195cb0cb60b0b89e3d evince this problem. In the hopes of diagnosing
this, I have run git under gdb and captured both a stack trace and dumped the structures being passed at each
level. Ive also included the output from GIT_MERGE_VERBOSITY=5

jbenjore <at> jbenjore0:~/segdev$ GIT_MERGE_VERBOSITY=5 git merge origin/master
Merging:
a7b6206 Merge branch 'bsa_02' of ssh://git.dev.pages/opt/git/repos/dev into bsa_02
virtual origin/master
found 3 common ancestor(s):
8c39e98 25243: Update parents to point to dev
1e994c1 24902: Update the sample das responses that are hashes at the top level to be arrays since we use
DAS::lookup_multi in our search base now
e4a886b Adding legacy click log processing scripts
  Merging:
  8c39e98 25243: Update parents to point to dev
  1e994c1 24902: Update the sample das responses that are hashes at the top level to be arrays since we use
DAS::lookup_multi in our search base now
  found 1 common ancestor(s):
  051594a Merge branch 'rel_090617' of git+ssh://bmaldonado <at> git.dev.pages:22/opt/git/repos/dev
into rel_090617
  Skipped config/conf/target/dev/host/dshanks0/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev-mchui/parent (merged same as existing)
  Skipped config/conf/target/dev/common/directory.ini.erb (merged same as existing)
  Skipped config/conf/target/dev/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/etc/apache2/ports.conf.erb (merged same as existing)
  Skipped config/conf/target/dev/host/asargent0/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/asargent0/common/test.yml (merged same as existing)
  Skipped config/conf/target/dev/host/jhall0/wpn_rails/appserver.yml (merged same as existing)
  Skipped config/conf/target/dev/host/jhoover0/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-aaron/common/directory.ini (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-aaron/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-aaron/common/test.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-coomer2/common/directory.ini (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-jason/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-jkh/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-seabass/common/directory.ini (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-seabass/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-tyler/common/directory.ini (merged same as existing)
  Skipped config/conf/target/dev/host/kvm-tyler/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/sebastianb0/common/services.yml (merged same as existing)
  Skipped config/conf/target/dev/host/sebastianb0/wpn_rails/appserver.yml (merged same as existing)
  CONFLICT (rename/add): Rename
config/conf/target/dev-ubuntu/wpn_rails/appserver.yml->config/conf/target/dev/wpn_rails/appserver.yml
in Temporary merge branch 1. config/conf/target/dev/wpn_rails/appse2
  Adding as config/conf/target/dev/wpn_rails/appserver.yml~Temporary merge branch 2 instead
  Skipped config/conf/target/dev/wpn_rails/appserver.yml (merged same as existing)
  Skipped config/conf/target/dev/wpn_rails/cache.yml (merged same as existing)
  Skipped config/conf/target/dev/wpn_rails/customer_support.yml (merged same as existing)
  Skipped config/conf/target/dev/wpn_rails/debug.yml (merged same as existing)
  Skipped config/conf/target/dev/wpn_rails/omniture.yml (merged same as existing)
  Skipped config/conf/target/dev/zxtm/rules.yml (merged same as existing)
  Skipped config/conf/target/dev/host/msquires1/common/credentials.ini (merged same as existing)
  Skipped config/conf/target/dev/host/msquires1/common/directory.ini (merged same as existing)
  Skipped config/conf/target/dev/host/msquires1/toolserver/toolserver.ini (merged same as existing)
  Skipped config/dynconf/target/dev/dynamic_config.yml (merged same as existing)
  Skipped config/dynconf/target/dev/mobile_useragents.yml (merged same as existing)
  Removing zxtm/traffic_scripts/web/beta_test.ts.erb
  There are unmerged index entries:
  2 config/conf/target/dev/wpn_rails/appserver.yml
  3 config/conf/target/dev/wpn_rails/appserver.yml
  Merging:
  virtual merged tree
  e4a886b Adding legacy click log processing scripts
  found 1 common ancestor(s):
  09fb055 Merge commit 'rel_090630_prod_02'
Segmentation fault

Backtrace without variables:

#0  parse_tree (item=0x0) at tree.c:255
#1  0x00000000004766ec in init_tree_desc_from_tree (desc=0x7fffe99a01a8, tree=0x0) at merge-recursive.c:161
#2  0x0000000000477c37 in merge_trees (o=0x7fffe99a04a0, head=0x0, merge=0x7a81c0,
common=0x7ac158, result=0x7fffe99a03f8) at merge-recursive.c:186
#3  0x0000000000479207 in merge_recursive (o=0x7fffe99a04a0, h1=0x18555c0, h2=0x795fc8, ca=0x0,
result=0x7fffe99a0460) at merge-recursive.c:1291
#4  0x00000000004791ac in merge_recursive (o=0x7fffe99a04a0, h1=0x796058, h2=0x795f80,
ca=0x9e7b20, result=0x7fffe99a0538) at merge-recursive.c:1277
#5  0x0000000000432efc in try_merge_strategy (strategy=<value optimized out>, common=0x7d5ac0,
head_arg=0x4b2eca "HEAD") at builtin-merge.c:565
#6  0x00000000004341cd in cmd_merge (argc=<value optimized out>, argv=0x7fffe99a2050,
prefix=<value optimized out>) at builtin-merge.c:1114
#7  0x00000000004049a3 in handle_internal_command (argc=2, argv=0x7fffe99a2050) at git.c:246
#8  0x0000000000404b8e in main (argc=2, argv=0x7fffe99a2050) at git.c:438


Backtrace with variables:
#0  parse_tree (item=0x0) at tree.c:255

#1  0x00000000004766ec in init_tree_desc_from_tree (desc=0x7fffe99a01a8, tree=0x0) at merge-recursive.c:161
desc = {buffer = 0xf0000, entry = {sha1 = 0x7a0138 "\005", path = 0xfff0ffff <Address 0xfff0ffff out of
bounds>, mode = 4566669}, size = 8195856}

#2  0x0000000000477c37 in merge_trees (o=0x7fffe99a04a0, head=0x0, merge=0x7a81c0,
common=0x7ac158, result=0x7fffe99a03f8) at merge-recursive.c:186
merge = {object = {parsed = 0, used = 0, type = 2, flags = 0, sha1 =
{0xee53bfdc      0x01365a0a      0x0c481bb8      0x36629e07}, buffer = 0x0, size = 0}
common = {object = {parsed = 1, used = 0, type = 2, flags = 0, sha1 =
{0xc9539f40      0x82243895      0x02e944ac      0x73ed2a75}}, buffer = 0x1d11d90, size = 1663}
*result = 0

#3  0x0000000000479207 in merge_recursive (o=0x7fffe99a04a0, h1=0x18555c0, h2=0x795fc8, ca=0x0,
result=0x7fffe99a0460) at merge-recursive.c:1291
o = {branch1 = 0x4c8db6 "Temporary merge branch 1", branch2 = 0x4c8dcf "Temporary merge branch 2",
subtree_merge = 0, buffer_output = 1, verbosity = 2, diff_rename_limit = -1, 
  merge_rename_limit = -1, call_depth = 1, obuf = {alloc = 0, len = 0, buf = 0x7360e0 ""},
current_file_set = {items = 0x19d0f90, nr = 14750, alloc = 14752, strdup_strings = 1}, 
  current_directory_set = {items = 0x19c8180, nr = 2256, alloc = 2272, strdup_strings = 1}}
h1 = {object = {parsed = 1, used = 0, type = 0, flags = 0, sha1 = '\0' <repeats 19 times>}, util = 0x4c8e01,
indegree = 0, date = 0, parents = 0x9e2290, tree = 0x0, buffer = 0x0}
h2 = {object = {parsed = 1, used = 0, type = 1, flags = 0, sha1 =
{0xb386a8e4      0xa839c34b      0xe1b5acde      0xb64bda52}},
util = 0x0, indegree = 0, date = 1248282000, parents = 0x794e30, tree = 0x7a81c0, 
  buffer = 0x7b3160 "tree dcbf53ee0a5a3601b81b480c079e62369679bbdf\nparent
5046433c0b601f5a24f1149d44ad7b7b7f5fc9f8\nauthor Michael Bradshaw <mbradshaw <at> W3M166.(none)>
1248282000 -0700\ncommitter Michae}

#4  0x00000000004791ac in merge_recursive (o=0x7fffe99a04a0, h1=0x796058, h2=0x795f80,
ca=0x9e7b20, result=0x7fffe99a0538) at merge-recursive.c:1277
o = {branch1 = 0x4c8db6 "Temporary merge branch 1", branch2 = 0x4c8dcf "Temporary merge branch 2",
subtree_merge = 0, buffer_output = 1, verbosity = 2, diff_rename_limit = -1, 
  merge_rename_limit = -1, call_depth = 1, obuf = {alloc = 0, len = 0, buf = 0x7360e0 ""},
current_file_set = {items = 0x19d0f90, nr = 14750, alloc = 14752, strdup_strings = 1}, 
  current_directory_set = {items = 0x19c8180, nr = 2256, alloc = 2272, strdup_strings = 1}}
h1 = {object = {parsed = 1, used = 0, type = 1, flags = 0, sha1 = {0x6520b6a7      0x3ef5afe8      0xe4086f4a      0x90a87a8e}}, util = 0x0, indegree = 0, date =
1248795280, parents = 0x7949b0, tree = 0x7a7fb8, 
  buffer = 0x794c80 "tree 57fee64850eec3f8a57ffe76878f5e76cdd26ed3\nparent
9320f2c497012a8c3529eada30b9e697757b7556\nparent
bfcc7b0ef71c259251c76a5809ccce5970278539\nauthor Josh ben Jore <jbenjore <at> whit}
h2 = {object = {parsed = 1, used = 0, type = 1, flags = 0, sha1 =
{0xf9fe8cc6      0xe64e40bf      0x08e55e41      0x305e1a47}}, util = 0x7fffe99a28c0,
indegree = 0, date = 1248308671, parents = 0x77b6c0, tree = 0x7a7f90, 
  buffer = 0x794160 "tree 4b46fa508134e277a219193e705f2f06a903c380\nparent
e4a886b34bc339a8deacb5e152da4bb6d77cacff\nparent
23a435ff7710bce43c1918cfd2c6fb2655ea043c\nauthor Michael Bradshaw <mbradshaw@}
ca = {item = 0x79bf20, next = 0x9e3190}
*result = (struct commit *) 0xff0a000000000000
**result = 

#5  0x0000000000432efc in try_merge_strategy (strategy=<value optimized out>, common=0x7d5ac0,
head_arg=0x4b2eca "HEAD") at builtin-merge.c:565
common = {item = 0x795fc8, next = 0x89df40}


#6  0x00000000004341cd in cmd_merge (argc=<value optimized out>, argv=0x7fffe99a2050,
prefix=<value optimized out>) at builtin-merge.c:1114
argv[0] = "origin/master"
argv[1] = 0
argv[2] = 0

#7  0x00000000004049a3 in handle_internal_command (argc=2, argv=0x7fffe99a2050) at git.c:246
argv[0] = "origin/master"
argv[1] = 0
argv[2] = 0

#8  0x0000000000404b8e in main (argc=2, argv=0x7fffe99a2050) at git.c:438
argv[0] = "origin/master"
argv[1] = 0
argv[2] = 0


Regards,
Josh
