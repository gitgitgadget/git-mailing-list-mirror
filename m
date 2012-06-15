From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-http-fetch: remove unused cmd_http_fetch
Date: Fri, 15 Jun 2012 11:09:53 -0700
Message-ID: <7vaa04bg5q.fsf@alter.siamese.dyndns.org>
References: <20120614202336.GA3755@w500.iskon.local>
 <20120615162136.GC4572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luka Perkov <lists@lukaperkov.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:10:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfay8-000247-SV
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757206Ab2FOSJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:09:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757034Ab2FOSJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:09:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69ED08C7A;
	Fri, 15 Jun 2012 14:09:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQjXkDQaExjOp6kV+qRhhColmJU=; b=ohbCyb
	2sx4fok7JfSzaqkKlyvUsqv5gjj2AHfmQ81Zl39MD76yd0BcyGqw/i66crQTyUgt
	Zlr9EHmoV6649O6EwUuyG3i+ImBtjNNcISHg0qcEWePVsYkXnze2A+qwoPZOo1ZN
	LicvnYmGilADDBNLSmAVVTO1yKpHRgBmj/QxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbP2pCO0mzBMEzbcDrTObzF1MQ+gVyBU
	/ZY0s4mwOV0z3tZjWGOxBYyp15MvIo4Ec1arPhkn8KydXwed/RyRckeHp+2gkgf3
	c8T9BI5pAeTzDZvLeVMdEOm9buRO06CdL4r51qBiAs72CT8BDpR4ZbuW5A3KlaUM
	uhjXxW2PCR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9858C79;
	Fri, 15 Jun 2012 14:09:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E46518C78; Fri, 15 Jun 2012
 14:09:54 -0400 (EDT)
In-Reply-To: <20120615162136.GC4572@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jun 2012 12:21:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F3D91E6-B715-11E1-A05F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200073>

Jeff King <peff@peff.net> writes:

> PS There seem to be some other similar declarations: at least
>    cmd_upload_tar and cmd_pickaxe.

Thanks.

$ sed -ne 's/^extern int \(cmd_[^(]*\)(.*/\1/p' builtin.h | sort >/var/tmp/1
$ nm -g git| sed -ne 's/^[0-9a-f]* T cmd_/cmd_/p' | sort > /var/tmp/2
$ comm -3 /var/tmp/[12]

finds only the two you mentioned, so how about doing it this way?

-- >8 --
From: Luka Perkov <lists@lukaperkov.net>
Date: Thu, 14 Jun 2012 22:23:37 +0200
Subject: [PATCH] builtin.h: remove unused cmd_<foo> declarations

These were left in builtin.h after they were converted into
stand-alone programs or removed after experiments finished.

Signed-off-by: Luka Perkov <lists@lukaperkov.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin.h b/builtin.h
index 20427d2..3e44816 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,7 +58,6 @@ extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
-extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
@@ -76,7 +75,6 @@ extern int cmd_mktree(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
-extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
@@ -104,7 +102,6 @@ extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
-extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
-- 
1.7.11.rc3.30.g3bdace2
