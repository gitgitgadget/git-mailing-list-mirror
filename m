From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 00/10] Re: [PATCH en/cascade-tests] tests: add missing &&
Date: Sun, 31 Oct 2010 02:26:40 -0500
Message-ID: <20101031072640.GA11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSMS-0003Ez-HF
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab0JaH05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:26:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48148 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0JaH04 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:26:56 -0400
Received: by ywc21 with SMTP id 21so298222ywc.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wUBR2m+wS+6dmstps0C0cRgxHqiOoe+qgsKqtkas+GM=;
        b=dGwaeBxLuif1bPuYMd9DG8Mq0moQK+MvU9ogpgeJCS8cSSu/drRAllbUIJs9NzvuCA
         LpuMWiZrku908DjaWOFVxCiwyHNBN8GkE0oDbi3YDlyxX4+01bFb28tdHSNUnmz85R3I
         yQhHDM9OHkHK1tmf18nVKHABtlXpJr9k5WZp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ve5/TwWheexfctPXvJ8zrAu4UEsAJwsc/5C/zkGjmuQHDiIRgHyhW0gLwdFzUVAn2G
         UZ5DguKioXt+VGFBIqg97+ekva4qJN02i8jpNP0yeSIUE10w81KswVcb9atbnOVkJndf
         I8qoJAxIVT3ShC9TxfOpBOQmsX1dPNQfQIsmI=
Received: by 10.151.47.10 with SMTP id z10mr8699085ybj.38.1288510015484;
        Sun, 31 Oct 2010 00:26:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p38sm1235514ybk.16.2010.10.31.00.26.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:26:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr5f73umz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160419>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -36,7 +36,7 @@ test_expect_success 'see what we expect' '
>>  	{
>>  		ln -s x y 2> /dev/null &&
>>  		test -h y 2> /dev/null ||
>> -		no_symlinks=1
>> +		no_symlinks=1 &&
>>  		rm -f y
>
> ... if you allowed such a simple assignment failure, no_symlinks=1 may
> fail, and we end up not running "rm -f y" to clean up, which might be
> somewhat undesirable ;-)

Thanks.  Will undo that bit in my local version.

Actually I don't see why the "rm -f y" is needed in the first place,
but that is a question for another day.

Here's another batch of patches in the same &&-adding vein.  I'm only
sending 10 to the list for now; I can mete the rest out at whatever
rate is useful to people.

Jonathan Nieder (27):
  tests: more missing &&
  test-lib: introduce test_line_count to measure files
  t6022 (renaming merge): chain test commands with &&
  t1502 (rev-parse --parseopt): test exit code from "-h"
  t1400 (update-ref): use test_must_fail
  t3301 (notes): use test_expect_code for clarity
  t3404 (rebase -i): unroll test_commit loops
  t3404 (rebase -i): move comment to description
  t3404 (rebase -i): introduce helper to check position of HEAD
  t4124 (apply --whitespace): use test_might_fail
  t5701 (clone -l): use test_must_fail
  ttt03, t6032: use test_might_fail
  t6032 (merge): give body of rename tests its own function
  t7001 (mv): introduce test_grep function and use it
  t7004 (tag): use test_must_fail
  t9146 (git svn): check exit status from svn in loop
  t9146 (git svn): use test_path_is_dir/missing helpers
  t8007 (textconv): use test_must_fail
  t7502 (commit): use test_must_fail
  t0005 (signals): hide test-sigchain invocation from &&-chaining
    checker
  t0020 (convert): improve error checking in loops
  t0020 (convert): use diff-index --exit-code
  t0020 (convert): remove "Huh?" noise
  t0040 (parse-options): use test_expect_code
  t7300 (clean): use test_cmp instead of test "$foo" = bar
  t1501 (rev-parse): use sane_unset
  t4022 (diff -B): simplify using test_grep

 t/README                      |    9 ++
 t/t0005-signals.sh            |   16 ++-
 t/t0020-crlf.sh               |  247 +++++++++---------------------------
 t/t0040-parse-options.sh      |   12 +-
 t/t1400-update-ref.sh         |   25 ++--
 t/t1501-worktree.sh           |    4 +-
 t/t1502-rev-parse-parseopt.sh |    2 +-
 t/t3301-notes.sh              |    8 +-
 t/t3404-rebase-interactive.sh |   88 ++++++-------
 t/t4022-diff-rewrite.sh       |    9 +-
 t/t4124-apply-ws-rule.sh      |   11 +-
 t/t5503-tagfollow.sh          |   10 +-
 t/t5701-clone-local.sh        |   22 +---
 t/t6022-merge-rename.sh       |  282 +++++++++++++---------------------------
 t/t6032-merge-large-rename.sh |   36 ++++--
 t/t7001-mv.sh                 |    8 +-
 t/t7004-tag.sh                |   36 +++---
 t/t7300-clean.sh              |   25 ++--
 t/t7502-commit.sh             |    4 +-
 t/t7700-repack.sh             |    6 +-
 t/t8007-cat-file-textconv.sh  |    2 +-
 t/t9146-git-svn-empty-dirs.sh |   64 ++++------
 t/test-lib.sh                 |   57 ++++++++
 23 files changed, 395 insertions(+), 588 deletions(-)

-- 
1.7.2.3.557.gab647.dirty
