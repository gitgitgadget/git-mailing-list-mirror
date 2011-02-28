From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe] fast-import 'ls', line-buffer changes
Date: Sun, 27 Feb 2011 22:15:45 -0800
Message-ID: <7vhbbolm5q.fsf@alter.siamese.dyndns.org>
References: <20101224080505.GA29681@burratino> <20110226114435.GB12231@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:16:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtwOs-00055O-SO
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab1B1GQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:16:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1B1GP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:15:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4F5F26D3;
	Mon, 28 Feb 2011 01:17:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jebXne5Ah6r7b5qMs8BfxH/PcIY=; b=Zvzmic
	y7H0Ngi2Cam2ejMGyR6xrF9yfWxZV2vTNCnZ7GX9jT6OEBbh0cw7YzeED8VPu2sq
	mFYLyyRdO7Lrm2WM14lQX63dUA4vKo2Ff8ErFg62j9VwwIqUYwyMHenaCmNUDU5I
	Osc/K0njEzc0i+C3q9+fjmHk9kzQub0jI8BtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tGBYrhllreJSt7slzLX60+cdpThEEDjS
	mGDD/IR805L+8uT1/zS+f8/UzRIWSiQmjNU35jcTmVmCW5xq0ezkrlKZADXCB50N
	B3VxMsh7d/qYipmDN0hLUguANupQBDuaAMCAKspMOCPwAWrnGOeCSp4twePRAEhH
	Tmz/TWVCtWo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64C5C26D2;
	Mon, 28 Feb 2011 01:17:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE15426CE; Mon, 28 Feb 2011
 01:17:04 -0500 (EST)
In-Reply-To: <20110226114435.GB12231@elie> (Jonathan Nieder's message of
 "Sat\, 26 Feb 2011 05\:44\:42 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60C6A19C-4302-11E0-9C00-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168066>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Junio,
>
> Please pull
>
>   git://repo.or.cz/git/jrn.git svn-fe
>
> to get the following changes on top of master + the old jn/svn-fe.
>
> These are patches from the threads $gmane/164146 and $gmane/167536,
> providing some plumbing to support incremental import in svn-fe.  They
> are probably far from perfect but they seem to work okay so far, and
> I'd be fine with putting any fixes on top of them.
>
> Thoughts, suggestions, etc welcome as always.

As I was not involved in the thread heavily, I'll just pull this into
'master', trusting that the responsible parties will be able to handle
potential fallouts to fast-import users, if any, promptly.

... Yikes.  I said the above and then my build for "master" breaks with

  fast-import.c: In function 'dereference':
  fast-import.c:2885: error: pointer of type 'void *' used in arithmetic
  fast-import.c:2890: error: pointer of type 'void *' used in arithmetic

forcing me to redo all three integration branches.  What an un-fun.

Not pulled.

 fast-import.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6c37b84..cfddb7a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2882,12 +2882,12 @@ static struct object_entry *dereference(struct object_entry *oe,
 	switch (oe->type) {
 	case OBJ_TAG:
 		if (size < 40 + strlen("object ") ||
-		    get_sha1_hex(buf + strlen("object "), sha1))
+		    get_sha1_hex((char *)buf + strlen("object "), sha1))
 			die("Invalid SHA1 in tag: %s", command_buf.buf);
 		break;
 	case OBJ_COMMIT:
 		if (size < 40 + strlen("tree ") ||
-		    get_sha1_hex(buf + strlen("tree "), sha1))
+		    get_sha1_hex((char *)buf + strlen("tree "), sha1))
 			die("Invalid SHA1 in commit: %s", command_buf.buf);
 	}
 
