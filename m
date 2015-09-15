From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Mon, 14 Sep 2015 21:56:00 -0700
Message-ID: <xmqq1te0uvq7.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
	<20150913101727.GB26562@sigill.intra.peff.net>
	<CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
	<20150914043016.GA10167@sigill.intra.peff.net>
	<CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
	<20150914045953.GA11039@sigill.intra.peff.net>
	<CAH8yC8kaWi6F5iKhNQeJrG451hqS-3_crtA0c+xFner78E2CAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jeffrey Walton <noloader@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 06:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbiHr-0000o6-4k
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 06:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbIOE4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 00:56:05 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35989 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbIOE4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 00:56:04 -0400
Received: by padhk3 with SMTP id hk3so164523186pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nUedMR4B3LEWKueJBh7KPqAn8uOZo7QkcZRrEq+3IVg=;
        b=vnxt7Aa+7aFc5NY5Xh/OqOFb0o5GJYeA2Wf6k3voJX7tq7JEOvD//Q8HWm3QgOqK5T
         LhwubK9iODAkINu/rAo2WDKjawdLLVQ99dz0cK/tiF9lgdNbrqBVL3+Ff6QkJG/hJYFu
         rtF9TL1SeU9PiNXsaW3f49PW3BgDTMYrXl2J7Qexut9F2esIEFZWjPefd8CuToGsdxhB
         MCjVJfhgSwAdbIKAgLk3yuojY7zrCDMvlXCHuWosfz7CC2FJyVqdb6J4vxeY+zOhLW0K
         bFMhZ+InrvkIkAtlCqAoAE3wnzbM/PzR1wBWlSCgV+u5WELNMCyDF2+6khcSDwPhTdLn
         O/Mw==
X-Received: by 10.68.197.231 with SMTP id ix7mr43424799pbc.85.1442292962900;
        Mon, 14 Sep 2015 21:56:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id un2sm19337514pac.28.2015.09.14.21.56.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 21:56:02 -0700 (PDT)
In-Reply-To: <CAH8yC8kaWi6F5iKhNQeJrG451hqS-3_crtA0c+xFner78E2CAQ@mail.gmail.com>
	(Jeffrey Walton's message of "Mon, 14 Sep 2015 19:14:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277886>

Jeffrey Walton <noloader@gmail.com> writes:

>> Oh, indeed. ac179b4d9. Looks good to me.
>>
>> My follow-up question was going to be: is this something we should be
>> setting in config.mak.uname for appropriate versions of Darwin? It
>> wasn't clear to me from Eric's description if this is something that
>> particular versions need, or just something that people who want to
>> build Universal binaries would choose to use.
>>
> If you have something that needs testing, then please let me know. I'd
> be happy to test it for you.

In your copy of Git that is recent enough, please run this:

    $ git fetch git://git.kernel.org/pub/scm/git/git.git pu
    $ git checkout -b jw/make-arflags-customizable ac179b4d9

This gives you a rather old maintenance track of Git based on v2.0.5
plus a patch that makes $(ARFLAGS) customizable.

Presumably you are building a more recent versions of Git yourself.
I do not know which branch you are on, but you should be able to
merge this brancch to anything newer than v2.0.x maintenance track.
E.g.

    $ git checkout master
    $ git merge jw/make-arflags-customizable

should merge cleanly and would let you say things like:

    $ make AR=libtool ARFLAGS='-static -o'

with any other build customization you usually use on the command
line (or in config.mak, if you prefer).

What Jeff King was wondering was if those on platform like you have
would benefit if they have something like the attached patch on top
of the ac179b4d (Makefile: allow $(ARFLAGS) specified from the
command line, 2015-09-10) patch.  Pieces of information that is
needed to determine if that is a good idea are:

 * What exact condition we should use in the "ifeq" to identify the
   class of platforms that want this custom AR/ARFLAGS.

 * Ask if everybody who shares that particular platform would always
   want "libtool" and "-static -o" as their custom AR/ARFLAGS.  If
   the answer is "no", i.e. on the same platform, more than one
   compiler toolchain may be available to the users and not
   everybody may want to use "libtool" and "-static -o" lie you do,
   then the approach to auto-determine this settings does not help
   people, and we should not bother with shipping customized
   config.mak.uname (instead we'd just tell people to do whatever
   they want with AR and ARFLAGS from the command line).

 * If it is worth shipping customized config.mak.uname, determine
   what things, other than AR/ARFLAGS, would help the uses of the
   class of platforms we identified above in the new "ifeq" section
   (e.g. perhaps they may want CC=some-other-cc).

 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 943c439..247dfed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -46,6 +46,10 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 endif
+ifeq ($(uname_S),"whatever jeffrey uses")
+	AR = libtool
+	ARFLAGS = -static -o
+endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
 	NEEDS_SOCKET = YesPlease
