From: Dario Bertini <berdario@gmail.com>
Subject: Re: diff weirdness (bug?)
Date: Mon, 17 Feb 2014 00:31:15 +0100
Message-ID: <53014A43.6080505@gmail.com>
References: <52FE6C64.4060700@gmail.com> <xmqq8utdihqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 17 00:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFBBE-0008SK-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 17 Feb 2014 00:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbaBPXbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 18:31:21 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:45710 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbaBPXbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 18:31:20 -0500
Received: by mail-ee0-f54.google.com with SMTP id e53so6759808eek.27
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oCre7AIzz3qPseirPAw4rxPTNIcrMZiJ3AXs7QIBVy8=;
        b=xHxYjSBI8bl667h70WwCsY7CDZ/ccUwk4EgGcg2gMdSJejD2TEL4Zj+4812gVevqmb
         GxUjczs4zN0NpwkiB8AOvd4k626m5i5Tucm/ByMO0V0/lC+5Dbis2knnPTd2EL9TqzEJ
         eSlkvpoEIqvK59FW9QjB9Z2fbdHkJFglNecON7Jo85A+2wOEJfKGfqQwMyFzy5o7CZpz
         IDJs8tAQnli3O3r47sxiel0GNIfoOKhi/i+0+33FEQEtRAdw3PgUs2BKPunt1OxbVx8m
         g4eto2klyGIA7MiLnilTIFAkozy+iGUCXrRNPWYordZ34k2xyYc9ixnOjQ06jetmB5rd
         H6KA==
X-Received: by 10.14.9.134 with SMTP id 6mr5016981eet.70.1392593479337;
        Sun, 16 Feb 2014 15:31:19 -0800 (PST)
Received: from [192.168.1.34] (host105-68-dynamic.54-79-r.retail.telecomitalia.it. [79.54.68.105])
        by mx.google.com with ESMTPSA id s46sm50220786eeb.0.2014.02.16.15.31.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 15:31:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq8utdihqx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242244>

On 02/14/2014 09:03 PM, Junio C Hamano wrote:
> This is a combined diff, and yaml-related lines are added relative
> to your _other_ branch you are merging (notice these + are indented
> by one place).  Relative to what you had at the tip of your branch
> before you started this operation that ended up conflicted, the
> half-merged result removes if/else that sets DIST_MODULE_PATH and
> replaces it with a single line (their +/- are on the first column,
> signifying that these are differences relative to the first parent,
> i.e. your state before you started the operation).
> 
>> if we remove these 3 lines, we'll get this diff:
> 
> With that understanding, I think the output after removing these
> three lines is perfectlyh understandable and correct.  You are
> looking at the three lines that used to exist in the version you
> started from, that were missing from the other side.  If you remoe
> them, it will show as removal from _your_ version (notice these -
> that shows what _you_ did manually are on the first column, saying
> that that is relative to _your_ version).
> 

Thank you, I was completely unaware of combined diffs. Still: I can't
see how this would explain the empty diff when deleting 4 lines instead
of 3.

Also: in the diff output I get 2 hashes, but these are not the hashes of
the commits, but the contents of the files apparently. One should be
HEAD (but if I run sha1sum over the file the hash doesn't match), but
the other can't be the commit which I reverted: the diff is too small...
or at least this is what I understand

By the way, in the man of git diff there's the briefly mentioned '-m'
flag. If anyone else reading this mail in the archives is confused by
the combined diff output, just use "git diff -m HEAD"... I'll probably
add this in my git aliases


-- 
xmpp: berdario@gmail.com
bitmessage: BM-2cTYXfGiSTsnx3righ6aHcJSWe4MV17jDP
gpg fingerprint: 3F8D53518012716C4EEF7DF67B498306B3BF75A0 (used just
for signing commits)
