From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 14:33:12 -0500
Message-ID: <20101018193311.GE6877@burratino>
References: <20101018163836.GI22376@kytes>
 <AANLkTik-OAZWBkKM1zNyeZpC6K4ZjvF8WfXOJrNkXayt@mail.gmail.com>
 <20101018165631.GA6718@burratino>
 <AANLkTimZU_q3KJYpq7zQU7o5H-M8=efDUDL9Zoy7LuZg@mail.gmail.com>
 <20101018172810.GA6877@burratino>
 <AANLkTinYpa61a=68ACSALtxuFnhGh5nGxmeD41J3e51i@mail.gmail.com>
 <20101018181336.GB6877@burratino>
 <AANLkTikHrCoZkJHN7Bnq4tgCTAHDfy7-92YOiV=s4VD8@mail.gmail.com>
 <20101018182530.GC6877@burratino>
 <AANLkTi=tT=AHWhHUw1tWT777ZPjvmTuMjDJ_orHYYN-x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 21:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7vVz-0000S7-9n
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 21:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab0JRTgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 15:36:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40453 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab0JRTgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 15:36:52 -0400
Received: by gyg13 with SMTP id 13so695784gyg.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MFDgLO2yuGfkkkbY2KLTS1du+1lCcp2tZxtTiAXsOQE=;
        b=NTcXyOPEhT4lqLREXkZ3jDx9dwyYB/vdqgMIDIBf/ck6C6wt2rHjwwu58sAP9jpwvF
         SMu1FMVi2/MHdRstOL7wR986IuNiSQvymPWkav/uDkkntlB1OrBENXo+qS8QzT9y+Yr1
         5uQEe5lpHyQAXzAaF2DJIgE65SIROl/PqqIcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uglV3aifJedjzUGXReJ/UhotFzuLl5DwzZJyxeLVcwvWy6Q+JuqJl+5InFeDttf1Ly
         92RsuMnnsFLxtU2ABvnOGE8rYLTfYQgwmI4FlkQ8ta6GTjsgioQAEoHeEuzabxans3/B
         0cY8qKf0VX8/+IpHg4x915bwB59GYTiUMxBVA=
Received: by 10.103.124.20 with SMTP id b20mr2614578mun.58.1287430609740;
        Mon, 18 Oct 2010 12:36:49 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a16sm3959704fak.19.2010.10.18.12.36.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 12:36:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=tT=AHWhHUw1tWT777ZPjvmTuMjDJ_orHYYN-x@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159285>

Sverre Rabbelier wrote:
> On Mon, Oct 18, 2010 at 13:25, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Good question. =C2=A0Ram, I think there was some discussion of this
>> recently in connection with svnrdump, right? =C2=A0IIRC the suggeste=
d
>> method was to use hooks or mine a commits@ mailing list. :(
>
> Hmmm, in that case perhaps we should instead just ignore changed
> history?

Yeah.  It's unpleasant to imagine that

	git clone svn://whatever
	... sneakily change svn repo ...
	... add some new revs on top ...
	cd whatever && git fetch origin

would produce an origin/trunk that does not match any clone of the
svn repo at all, but in practice it is not so different from coping
with any other upstream that is incurably willing to rewrite history.

Example: downstream tracking an unstable branch
-----------------------------------------------
Suppose I maintain a patchset in the long term, based, for whatever
reason, on git's "next" branch.  Occasionally there is a need to
merge from upstream.  What can one do?

Simple use of "git merge" produces history that is difficult to
follow.  Time flowing from left to right, "u" denotes upstream
commits:

  u --- u --- u [next-2005-01-03]
  |\           \
  | \           A --- o - o ----- B
   \ \                   /       /
    \ u --- u --- u --- u [next-2006-03-27]
     \                         /
      u --- u --- u --- u --- u [next-2009-11-27]

If a person wants to find what changed downstream between A and B,
a simple "git log A..B ^origin/next" will unfortunately include the
commits from next-2006-03-27 as well.

One option is to rebase whenever upstream does, but that is
dangerous because it prevents users from tracking changes in the
project long-term.

Another option is to use a "rebasing merge" [1].  The history can be
followed without too much trouble if you set up "git log" commands
appropriately.  Na=C3=AFve use of "git log" will list (and git will sto=
re)
multiple copies of every commit, though.

And lastly, one can say "screw upstream" and produce a long-term
"next" branch to build on. :)  Like this:

 1. git branch long-term-next next-2005-01-03

 2. When "next" is rebased to clean out cruft, advance long-term-next
    to the pre-rebase state.  Luckily such rebases leave a "before" in
    long-term-next and "after" in next with identical content.  Add a
    replace ref to make history easy to follow.

	git diff <after> <before>; # confirm that they really match
	git replace <after> <before>

 3. To advance long-term-next, rewrite commits from upstream.

	git checkout origin/next
	git filter-branch HEAD
	git diff origin/next; # should match
	git push . HEAD:long-term-next; # should be fast-forward

 4. Only merge long-term-next into downstream branches.
 5. Publish the latest replace ref so others can follow the history
    easily.

[1] http://thread.gmane.org/gmane.comp.version-control.msysgit/10264
