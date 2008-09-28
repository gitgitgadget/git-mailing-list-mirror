From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Document the textconv filter.
Date: Sun, 28 Sep 2008 14:29:52 +0200
Message-ID: <vpq7i8wzc5b.fsf@bauges.imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
	<1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
	<1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
	<200809281307.21409.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 28 14:39:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjvYl-0001bp-ER
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYI1McP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 08:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYI1McP
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 08:32:15 -0400
Received: from imag.imag.fr ([129.88.30.1]:43346 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbYI1McO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 08:32:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8SCTrkQ008152
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 14:29:54 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjvPM-0007GA-Ij; Sun, 28 Sep 2008 14:29:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjvPM-0001Sx-GL; Sun, 28 Sep 2008 14:29:52 +0200
In-Reply-To: <200809281307.21409.johannes.sixt@telecom.at> (Johannes Sixt's message of "Sun\, 28 Sep 2008 13\:07\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 14:29:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96962>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Sonntag, 28. September 2008, Matthieu Moy wrote:
>> +Converting files to text before a diff
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The attribute `textconv` affects 'git diff' in a way similar to the
>> +`diff` attribute, but with `textconv`, the user provides only a way to
>> +convert the file into text, and git takes care of doing the diff as
>> +usual (i.e. other options of 'git diff' such as '--color' remain
>> +available).
>> +
>> +The value of `textconv` must be a string, which is the textconv
>> +driver.
>
> Wouldn't it be much more useful to have git parse stdout of the custom diff 
> tool in order to colorize it?

That would do it for --color, but not --color-words for example. The
problem with the GIT_EXTERNAL_DIFF is that the diff tool has to
re-implement everything that "git diff" already do.

Take my opendocument diff script :

http://www-verimag.imag.fr/~moy/opendocument/git-oodiff

That's 77 lines of code as a wrapper to odt2txt and diff. With the
"textconv" attribute, it's one line in .gitattributes, and two in
~/.gitconfig.

> Of course, this would mean that external diff tools are more
> complicated and their stdout has to conform mostly to the git diff
> syntax. But:
>
>> +To tell git to use the `exif` filter for jpeg images, use:
>> +
>> +----------------------------------------------------------------
>> +*.jpg   textconv=exif
>> +----------------------------------------------------------------
>
> In this very example it would be possible that the external diff driver shows 
> the differences in the image in a window and also produces EXIF information 
> on stdout.

Yes, but that's really a specific example. Having git colorize the
diff would be a little extra, but that wouldn't reduce the effort to
write the external diff tool itself, and doesn't give you _all_ of
git-diff, just --color.

-- 
Matthieu
