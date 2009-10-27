From: alan <alan@clueserver.org>
Subject: Re: Problems with git am
Date: Mon, 26 Oct 2009 18:43:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910261836570.15106@blackbox.fnordora.org>
References: <59976.134.134.139.70.1256602329.squirrel@clueserver.org>
 <7vvdi1bqv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 02:43:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2b5v-0006E8-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 02:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbZJ0BnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 21:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZJ0BnU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 21:43:20 -0400
Received: from clueserver.org ([65.102.45.174]:53556 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbZJ0BnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 21:43:19 -0400
Received: by clueserver.org (Postfix, from userid 500)
	id 4F9A0F5055A; Mon, 26 Oct 2009 18:43:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 4E50FF50521;
	Mon, 26 Oct 2009 18:43:24 -0700 (PDT)
X-X-Sender: alan@blackbox.fnordora.org
In-Reply-To: <7vvdi1bqv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131302>

On Mon, 26 Oct 2009, Junio C Hamano wrote:

> "Alan" <alan@clueserver.org> writes:
>
>> The header of the patch looks like:
>>
>> commit 62b266585bb5555d44a764c90d80f9c4bb8188c1
>> Author: Joe Example <joe@example.com>
>> Date:   Wed Sep 19 10:03:47 2009 -0600
>
> It shouldn't.
>
> The format "git am" understands is a mbox file and format-patch is the
> command to write commits out in that form.  It should begin with lines
> that look like:
>
>    From 610f99ec7d22b5750f12350f67c1341d6be8030f Mon Sep 17 00:00:00 2001
>    From: Junio C Hamano <gitster@pobox.com>
>    Date: Sun, 25 Oct 2009 18:41:09 -0700
>    Subject: [PATCH] Update draft release notes to 1.6.6
>
>    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>    ---
>    .... patch follows here ...
>
> I do not think it is particularly hard to add a new case arm in "am" to
> support "git log" output.  It is different from a mbox format in that it
>
> * begins each commit with "commit " marker;
> * has Author: and Date: header that is different from a mailbox;
> * lacks Subject: but makes it part of the message body; and
> * indents the message by 4 places.
>
> Nobody has bothered to do so, probably because nobody needed it.

[Insert long string of profanity cut and pasted from Linus' description of 
CVS and Subversion.]

> The easiest, safest and quickest for you right now (meaning, before
> waiting for anybody to help you by adding a new feature to "am") would be
> to see if it is possible for you to get the commits re-exported in an
> appropriate format.

I can get them reexported. I may have problems getting them to do that 
correctly on a regular basis...

I may have to write the am branch myself.

> I say the "safest" in the above because you _could_ massage what you have
> into a format that looks like a mbox with some Perl script, but it risks
> mismassaging.

Yeah.

The other question is what the proper behaviour when git-am in unable to 
process a patch.  Under git 1.6.0, it exits with a non-zero error code. 
Under the current git in the git repo it issues and error and exits with a 
non-error exit code.

What should the correct behaviour be in this case?

-- 
Truth is stranger than fiction because fiction has to make sense.
