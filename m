From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: RE: recovering from "unordered stage entries in index" error
Date: Sat, 23 May 2015 17:36:32 -0400
Message-ID: <D377A9280DB18546A2471214D5CBB0E90875A547E6@exchdb01>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
 <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
 <xmqqwq01kh8r.fsf@gitster.dls.corp.google.com>
 <CACsJy8Bdx5tto0w1q7rZ1ORx8RmHZCEKPyBqYs37k=YvbO3kzA@mail.gmail.com>
 <D377A9280DB18546A2471214D5CBB0E9087568F47B@exchdb01>
 <CACsJy8As8-b6kWHDnmAwAftyPG6X-BmoQdToQywzn9D4dtg2Fg@mail.gmail.com>,<805ACAFCB18CC2408F45D98ABEC64B650A06EC538B@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 23:39:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwH8u-0005n2-GV
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 23:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbbEWVj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 17:39:28 -0400
Received: from mail3.carnegielearning.com ([204.80.87.3]:21654 "EHLO
	mail3.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079AbbEWVj1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 17:39:27 -0400
X-ASG-Debug-ID: 1432417165-07bc7c14083ee2cc0001-QuoKaX
Received: from webmail.carnegielearning.com ([10.1.10.4]) by mail3.carnegielearning.com with ESMTP id NR739xIV7OdmuurN (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Sat, 23 May 2015 17:39:25 -0400 (EDT)
X-Barracuda-Envelope-From: mmchenry@carnegielearning.com
X-Barracuda-RBL-Trusted-Forwarder: 10.1.10.4
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Sat, 23 May 2015 17:39:25 -0400
Thread-Topic: recovering from "unordered stage entries in index" error
X-ASG-Orig-Subj: RE: recovering from "unordered stage entries in index" error
Thread-Index: AdCU/S7vnqWDYWJfQL6Iki+SOZ43BAAAgcIAAChU5IQ=
In-Reply-To: <805ACAFCB18CC2408F45D98ABEC64B650A06EC538B@exchdb01>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
X-Barracuda-Connect: UNKNOWN[10.1.10.4]
X-Barracuda-Start-Time: 1432417165
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: https://10.1.10.16:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at carnegielearning.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0100
X-Barracuda-Spam-Score: 0.01
X-Barracuda-Spam-Status: No, SCORE=0.01 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.19219
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269818>


Per Junio's email, with core.quotepath=false, there are no differences with sorting in either ls-files or the tree named in the GIT_TRACE_2 output:

$ git config --local core.quotepath false

$ git ls-tree --name-only -r 74332b7d653cde7ba3b999cc7b0adcfd9d924440 > ls-tree
$ LANG=C LC_ALL=C sort ls-tree > ls-tree-sorted-lc-all
$ diff -s ls-tree ls-tree-sorted-lc-all 
Files ls-tree and ls-tree-sorted-lc-all are identical

$ git ls-files > ls-files
$ LANG=C LC_ALL=C sort ls-files > ls-files-sorted-lc-all
$ diff -s ls-files ls-files-sorted-lc-all 
Files ls-files and ls-files-sorted-lc-all are identical


________________________________________
From: McHenry, Matt
Sent: Friday, May 22, 2015 10:47 PM
To: Duy Nguyen
Cc: Junio C Hamano; git@vger.kernel.org
Subject: RE: recovering from "unordered stage entries in index" error

> So maybe you can do "GIT_TRACE=2 git svn fetch" and post the output.
> I'd expect to see something like "git read-tree <sha1>" before "fatal:
> unorder...". You can then use git ls-tree <sha1> to examine this tree,
> try to sort the file list with "LANG=C sort" and compare with the
> original list.

        There is no read-tree in the output (below).  The sha1 that is mentioned, 74332b7, is the one for the current trunk:

$ git svn log -1 --show-commit --oneline trunk
r231655 | 74332b7 | CLT: changed skill from not compound to compound.

        So not surprisingly, I guess, I get basically the same results as with the ls-files commands earlier: files with Unicode chars are quoted and sort at the front:

$ git ls-tree --name-only -r 74332b7d653cde7ba3b999cc7b0adcfd9d924440 > ls-tree
$ LANG=C LC_ALL=C sort ls-tree > ls-tree-sorted-lc-all
$ grep -n Ninja__Beta ls-tree*
ls-tree:36974:"curriculum/Fluency/Hurix work/source from May 2014/For_Anesh/06 Deliverables/Phase 2/FT3 \342\200\223 Ninja/FT3 \342\200\223 Ninja__Beta.zip"
ls-tree-sorted-lc-all:89:"curriculum/Fluency/Hurix work/source from May 2014/For_Anesh/06 Deliverables/Phase 2/FT3 \342\200\223 Ninja/FT3 \342\200\223 Ninja__Beta.zip"

        (Just sorting with LANG=C but without LC_ALL=C produced a ton of other differences, mostly around numeric vs. lexical ordering as far as I could tell.)

        I tried this same thing with my test repo, and it exhibits the same quoted-filename-sorts-to-the-top behaviour, but does not exhibit the git svn fetch write-tree error.


$ GIT_TRACE=2 git svn fetch
22:21:16.683918 git.c:557               trace: exec: 'git-svn' 'fetch'
22:21:16.683945 run-command.c:351       trace: run_command: 'git-svn' 'fetch'
02:21:16.918593 git.c:348               trace: built-in: git 'rev-parse' '--git-dir'
02:21:16.920218 git.c:348               trace: built-in: git 'rev-parse' '--show-cdup'
02:21:16.921997 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
02:21:16.923609 git.c:348               trace: built-in: git 'config' '--int' '--get' 'svn.repack'
02:21:16.925164 git.c:348               trace: built-in: git 'config' '--get' 'svn.repackflags'
02:21:16.926706 git.c:348               trace: built-in: git 'config' '--get' 'svn.revision'
02:21:16.928847 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
02:21:16.930410 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
02:21:16.931963 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.localtime'
02:21:16.933538 git.c:348               trace: built-in: git 'config' '--get' 'svn.includepaths'
02:21:16.935107 git.c:348               trace: built-in: git 'config' '--get' 'svn.username'
02:21:16.936675 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
02:21:16.940413 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
02:21:16.942064 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
02:21:16.943696 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
02:21:16.945344 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
02:21:16.947607 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.parent'
02:21:16.950737 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.addauthorfrom'
02:21:16.952532 git.c:348               trace: built-in: git 'config' '--get' 'svn.authorsprog'
02:21:16.954133 git.c:348               trace: built-in: git 'config' '--get' 'svn.ignorepaths'
02:21:16.955704 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
02:21:16.957287 git.c:348               trace: built-in: git 'config' '--get' 'svn.configdir'
02:21:16.958930 git.c:348               trace: built-in: git 'config' '--get' 'svn.authorsfile'
02:21:16.962142 git.c:348               trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
02:21:16.963913 git.c:348               trace: built-in: git 'config' '--get' 'svn.ignorerefs'
02:21:16.966130 git.c:348               trace: built-in: git 'rev-parse' '--symbolic' '--all'
02:21:16.970537 git.c:348               trace: built-in: git 'config' '-l'
02:21:16.972410 git.c:348               trace: built-in: git 'config' '-l'
02:21:16.974187 git.c:348               trace: built-in: git 'config' '--bool' 'svn.useSvmProps'
02:21:16.976074 git.c:348               trace: built-in: git 'config' '-l'
02:21:17.136056 git.c:348               trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.branches-maxRev'
02:21:17.137928 git.c:348               trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.tags-maxRev'
02:21:17.140124 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
02:21:17.142192 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.pushurl'
02:21:17.144203 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
02:21:17.149689 git.c:348               trace: built-in: git 'rev-list' '--pretty=raw' '--reverse' '74332b7d653cde7ba3b999cc7b0adcfd9d924440..refs/remotes/trunk' '--'
02:21:17.152412 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteRoot'
02:21:17.154482 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.rewriteUUID'
02:21:17.160391 git.c:348               trace: built-in: git 'cat-file' '--batch'
02:21:17.582641 git.c:348               trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '231655'
02:21:17.585237 git.c:348               trace: built-in: git 'config' 'svn-remote.svn.tags-maxRev' '231655'
02:21:17.590152 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.usesvmprops'
02:21:17.592063 git.c:348               trace: built-in: git 'config' '--get' 'svn-remote.svn.nometadata'
02:21:17.593997 git.c:348               trace: built-in: git 'cat-file' 'commit' '74332b7d653cde7ba3b999cc7b0adcfd9d924440'
02:21:17.596529 git.c:348               trace: built-in: git 'write-tree'
fatal: unordered stage entries in index
write-tree: command returned error: 128
