From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/17] Documentation: quoting trouble in "git rm" discussion
Date: Fri, 20 Aug 2010 05:21:53 -0500
Message-ID: <20100820102153.GB10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:23:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOlF-0007VG-Hu
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab0HTKXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:23:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65399 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0HTKXj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:23:39 -0400
Received: by iwn5 with SMTP id 5so676549iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dcPEFXUVbsMYBMGqI8fS73zV3WXcy6Lwu40PmRY9ghc=;
        b=koPB5B8yQ0+/ppOXxBf3wDG/mwHdRdSVcotN87uCZErWoKhu1Jg6JdjCir3Maa941Q
         qMWaeGzNhXTvt+W94dpV108Tm6hVWckWkeTlYvXj0HrEHHele5kRS5yN1ywoRVlMJOm0
         3QxFUqPKsmX1ruLtT1UObsOJuBxLGKPWE2x9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IhmiXpiZ4QhPIYH8wipj7AGmG5C/J1gfe47c7IbxBbTdYxVLe/GKAiynEB95AItRVn
         LvOUNseES6mff/HqhzdCtRZO27/hHn/Gsk67vk66Yphx5LYx/zpArk5nCVWDp8Ky+mao
         76zHiNVppIfoYW7Jz41Uh0MCK5UbFMT6ln19A=
Received: by 10.231.174.84 with SMTP id s20mr1464674ibz.94.1282299819320;
        Fri, 20 Aug 2010 03:23:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2492353ibk.3.2010.08.20.03.23.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:23:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153997>

The current output (with Asciidoc 8.5.2) seems a bit broken:

	given two directories =E2=80=98d` and d2, there is a difference
	between using git rm 'd*=E2=80=99 and =E2=80=98git rm 'd/\*\=E2=80=99`=
, as the
	former will also remove all of directory d2.

In other words, the markup parses as

	given two directories << d` and _d2_, there is a difference
	between using _git rm 'd* >>_ and << git rm 'd/\*\ >> `.

I suspect there is an asciidoc bug involved (why is ' a candidate
closing-quote mark when it is preceded by a backslash?) but with
all the meanings of ` and ' involved I do not want to track it
down.  Better to use unambiguous {asterisk} and {apostrophe}
entities.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/asciidoc.conf |    1 +
 Documentation/git-rm.txt    |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 87a90f2..6be8ba3 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -17,6 +17,7 @@ caret=3D&#94;
 startsb=3D&#91;
 endsb=3D&#93;
 tilde=3D&#126;
+apostrophe=3D&#39;
 backtick=3D&#96;
=20
 ifdef::backend-docbook[]
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index c21d19e..d146751 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -78,7 +78,8 @@ a file that you have not told git about does not remo=
ve that file.
=20
 File globbing matches across directory boundaries.  Thus, given
 two directories `d` and `d2`, there is a difference between
-using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
+using `git rm {apostrophe}d{asterisk}{apostrophe}` and
+`git rm {apostrophe}d/{asterisk}{apostrophe}`, as the former will
 also remove all of directory `d2`.
=20
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
--=20
1.7.2.2.536.g42dab.dirty
