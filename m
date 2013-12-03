From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] teach replace objects to
 sha1_object_info_extended()
Date: Tue, 03 Dec 2013 21:42:09 +0100 (CET)
Message-ID: <20131203.214209.1698497614731424957.chriscool@tuxfamily.org>
References: <20131202145225.GA12457@sigill.intra.peff.net>
	<20131202150634.GA20416@sigill.intra.peff.net>
	<xmqqtxeqq0qs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org, joey@kitenet.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 03 21:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnwnk-0000Nb-3z
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab3LCUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:42:32 -0500
Received: from [194.158.98.45] ([194.158.98.45]:33793 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754964Ab3LCUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:42:31 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 1DA2B64;
	Tue,  3 Dec 2013 21:42:09 +0100 (CET)
In-Reply-To: <xmqqtxeqq0qs.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238737>

From: Junio C Hamano <gitster@pobox.com>
>
> Jeff King <peff@peff.net> writes:
> 
>> On Mon, Dec 02, 2013 at 09:52:25AM -0500, Jeff King wrote:
>>
>>> I find it a little funny that we reuse the READ_SHA1_FILE_REPLACE flag
>>> directly in lookup_replace_object. That means that it is now a
>>> meaningful flag for sha1_object_info_extended, even though the name does
>>> not say so. It also means that the two may have to coordinate further
>>> flags (since a portion of their flag namespace is shared by
>>> lookup_replace_object). I don't foresee adding a lot of new flags,
>>> though, so it probably isn't a huge deal.
>>> 
>>> I also would have expected sha1_object_info_extended to simply receive
>>> the new flag via the struct object_info. Again, probably not a big deal,
>>> because there aren't many callsites that needed updating. But if we were
>>> not sharing flags with read_sha1_file, I think doing it as a flag in the
>>> struct would be nicer.
>>
>> Curious what this would look like, I wrote the patch. If you drop your
>> patches 2 and 3, then your final patch (actually fixing the problem)
>> would look like the one below:
>>
>> We may be getting into bikeshed territory, and I don't feel
>> super-strongly about it, so I won't say anything more. Now we've seen
>> both alternatives, and you or Junio can pick. :)

Thanks for doing that.

I still prefer a flag used by sha1_object_info_extended(),
read_sha1_file_extended() and lookup_replace_object_extended().
I think it is more coherent this way.

> FWIW, I shared that "a little funny" feeling ;-)

Yeah, it's true that I should have renamed the flag.
READ_SHA1_FILE_REPLACE is too much related to the read_sha1_file*()
functions.

As it is related to lookup_replace_object*() functions, what
about LOOKUP_REPLACE_OBJECT?

Thanks,
Christian.
