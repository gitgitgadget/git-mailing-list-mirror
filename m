From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sat, 07 Jul 2007 19:08:25 +0900
Message-ID: <200707071011.l67AB9rg005792@mi0.bluebottle.com>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:11:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I77Fy-0003Wt-Ma
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 12:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXGGKLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 06:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbXGGKLL
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 06:11:11 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:35711 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbXGGKLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 06:11:10 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l67AB9rg005792
	for <git@vger.kernel.org>; Sat, 7 Jul 2007 03:11:09 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=Pd9Y3+3fbRIGxaL8hf76VNFBwJQ5NXoPTQhDtCslrtQ4SY/HljsTcamABqZrEXITq
	OwZXxT9bEaEFQY36GEF3Kd8YHeN8KOMV5kUOpRm/5v+kceHnZ7vTcm3tcYdfy1g
Received: from nanako3.mail.bluebottle.com (siraly-gw2.selyeuni.sk.133.111.195.in-addr.arpa [195.111.133.92] (may be forged))
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id l67AAwvt023894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jul 2007 03:11:03 -0700
In-Reply-To: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
X-Trusted-Delivery: <7c26ee486c54846dd57bda67c736292b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51809>

Quoting Junio C Hamano <gitster@pobox.com>:

> Yeah, I'd be lying if I said that this did not cross my mind
> when I saw existing diff.*.command handling.
>
> About the comment from Johannes regarding hunk_header vs
> funcname, I would actually prefer hunk_header, since that is
> what this is about ("funcname" and "find_func" were misnomer
> from the beginning), but I'd rename hunk_header to funcname for
> the sake of consistency and minimizing the diff.

I would love to see "diff=tex" attribute to work on my manuscripts, but I
do not write C and do not understand the long length of backslashes very
well.  I guessed in the source file a backslash needs to be doubled, and
what I want to match is "\section{", "\subsection{", and "\subsubsection{"
at the beginning of lines, and attempted to do it like the patch at the
end.

It does not work well, however.  It shows only part of lines.

	@@ -8,7 +8,8 @@ \section{
	@@ -224,7 +225,7 @@ sub
	@@ -240,7 +241,7 @@ subsub

I have no idea what am I doing wrong (truthfully, I do not know what I am
doing, period).


diff --git a/diff.c b/diff.c
index 04e7e91..57f91b0 100644
--- a/diff.c
+++ b/diff.c
@@ -1226,6 +1226,8 @@ static const char *diff_hunk_header_regexp(struct diff_filespec *one)
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*$\\)";
+	if (!strcmp(ident, "tex"))
+		return "^\\\\\\(sub\\)*section{";
 
 	return NULL;
 }


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
