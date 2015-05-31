From: Christian Couder <christian.couder@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Mon, 1 Jun 2015 01:53:45 +0200
Message-ID: <CAP8UFD0_RCOHUF6BgczgS5kWAFc0QKdw4cUy_bpB2jhd+kYWdw@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com>
	<CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
	<CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
	<CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
	<CAP8UFD1rKmKgKqCsffCLyOCny3JEACxgmBN_eqOj_=3zBW-MZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 01:53:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzD3B-00072O-MO
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 01:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758542AbbEaXxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 19:53:48 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37764 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbEaXxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 19:53:47 -0400
Received: by wifw1 with SMTP id w1so84841466wif.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P+GDGKJF6WSKLmE8gYMd/dfoe6HiJ4P6aFIdAr0CowM=;
        b=HTYZZvFgwo9SYZPgVDOOd9Tp950qMNaraf79TK4zz0EgaaFKKdHIkPuH536n1ASGFg
         /29zBeeCS8+VEtivkph8kWAa6dwQJ8VXJv4FHMSviG93F4I6TAYI/fPAprHeYluGBKou
         3EwuSjaJZsUyloHGjUmVRkkVBilUhCpSehnsmws+GeIuRxig9Yj3hhrKC1Ydf9gZdoqs
         +phNYEVgd+2c59zyxz5qKwVE30BBLRj7qjYv1wDdBwv2ZuLjFJx2vyZiz5EnXY7C3/Ck
         5TjAPYVddfknALGuqb2bdhddDAFYLpGQ+unBcgxXCHpfpZSrfzGkTpiFGamtzR03zQyX
         LHVQ==
X-Received: by 10.194.95.132 with SMTP id dk4mr36580528wjb.88.1433116425948;
 Sun, 31 May 2015 16:53:45 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 16:53:45 -0700 (PDT)
In-Reply-To: <CAP8UFD1rKmKgKqCsffCLyOCny3JEACxgmBN_eqOj_=3zBW-MZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270368>

On Mon, Jun 1, 2015 at 1:14 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, May 31, 2015 at 10:45 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
>> Oh, you can also clone the gnu-pw-mgr and likely get the same result:
>
> Yeah, after cloning from http://git.savannah.gnu.org/r/gnu-pw-mgr.git
> I get the following backtrace:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00000000004b26b1 in clear_commit_marks_1 (plist=0x7fffffffbf78,
> commit=0x84e8d0, mark=139) at commit.c:528
> 528                     while ((parents = parents->next))
> (gdb) bt
> #0  0x00000000004b26b1 in clear_commit_marks_1 (plist=0x7fffffffbf78,
> commit=0x84e8d0, mark=139) at commit.c:528
> #1  0x00000000004b2743 in clear_commit_marks_many (nr=-1,
> commit=0x7fffffffbfa0, mark=139) at commit.c:544
> #2  0x00000000004b2771 in clear_commit_marks (commit=0x84e8d0,
> mark=139) at commit.c:549
> #3  0x00000000004537cc in get_patch_ids (rev=0x7fffffffd190,
> ids=0x7fffffffc910) at builtin/log.c:832
> #4  0x0000000000455580 in cmd_format_patch (argc=1,
> argv=0x7fffffffdc20, prefix=0x0) at builtin/log.c:1425
> #5  0x0000000000405807 in run_builtin (p=0x80cac8 <commands+840>,
> argc=5, argv=0x7fffffffdc20) at git.c:350
> #6  0x0000000000405a15 in handle_builtin (argc=5, argv=0x7fffffffdc20)
> at git.c:532
> #7  0x0000000000405b31 in run_argv (argcp=0x7fffffffdafc,
> argv=0x7fffffffdb10) at git.c:578
> #8  0x0000000000405d29 in main (argc=5, av=0x7fffffffdc18) at git.c:686
>
> (Please don't top post if you reply to this email as it is frown upon
> on this list.)

When running the command that gives the above segfault:

$ git format-patch -o patches --ignore-if-in-upstream
14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d

It is interesting to note that the last sha1 refers to a tag:

$ git cat-file tag 2de9eef391259dfc8748dbaf76a5d55427f37b0d
object 524ccbdbe319068ab18a3950119b9e9a5d135783
type commit
tag v1.4
tagger Bruce Korb <bkorb@gnu.org> 1428847577 -0700

Release 1.4

* sort-pw-cfg: a sort/merge program for combining and organizing
  configurations.

* --delete: a new option to remove any entries for a password id

It works when the tag is replaced by the commit it points to, and the
segfault happens because the we try to access the "parents" field of
the tag object as if it was a commit.
