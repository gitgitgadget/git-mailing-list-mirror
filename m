From: Hannu Koivisto <azure@iki.fi>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Tue, 27 Jan 2009 15:58:21 +0200
Message-ID: <83ocxsetqa.fsf@kalahari.s2.org>
References: <20090121210348.GD9088@mit.edu>
	<1232578668-2203-1-git-send-email-charles@hashpling.org>
	<7v1vuuvt11.fsf@gitster.siamese.dyndns.org>
	<83skn6doxm.fsf@kalahari.s2.org>
	<20090126163114.GD32604@hashpling.org>
	<7v7i4h4v19.fsf@gitster.siamese.dyndns.org>
	<7vskn53em1.fsf@gitster.siamese.dyndns.org>
	<7vocxt3bsc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 14:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRoTp-00079T-HQ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 14:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbZA0N62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 08:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZA0N62
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 08:58:28 -0500
Received: from s2.org ([195.197.64.39]:60764 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbZA0N62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 08:58:28 -0500
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LRoSL-0006AZ-KR; Tue, 27 Jan 2009 15:58:21 +0200
In-Reply-To: <7vocxt3bsc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 26 Jan 2009 15:09:07 -0800")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107346>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps something along this line to teach
>>
>>     $ git merge-file --attribute-path=frotz.c file1 orig_file file2
>>
>> to merge what happened since orig_file to file2 into file1, and deposit
>> the result after converting it appropriately for path "frotz.c" obeying
>> core.autocrlf and gitattribute rules.
>>
>> I see rerere.c::merge() has the exact same issue, but its breakage is half
>> hidden by its use of fopen(path, "w").  It should explicitly use
>> convert_to_working_tree() like this patch does, and write the results out
>> in binary mode.
>
> Second try.  I forgot how convert_* worked X-<.

Argh, it seems I have wasted your time.  That patch may do
something useful but in this case with _or without_ it all the
files seem to be correct in the filesystem before I save the merge
result in emerge.  I.e. it seems that for some reason Emacs detects
the coding system of the result file incorrectly.  I'll investigate
that at some point especially if ediff suffers from the same
problem.

-- 
Hannu
