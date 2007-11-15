From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Discussion] cherry-picking a merge
Date: Thu, 15 Nov 2007 09:40:22 -0800
Message-ID: <7vy7cz4dbt.fsf@gitster.siamese.dyndns.org>
References: <7v3av86iqa.fsf@gitster.siamese.dyndns.org>
	<20071115081648.GK14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:41:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsiiS-0005CK-4F
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759529AbXKORkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758376AbXKORkt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:40:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38640 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758343AbXKORks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:40:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0944E2FB;
	Thu, 15 Nov 2007 12:41:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B25195FBF;
	Thu, 15 Nov 2007 12:41:01 -0500 (EST)
In-Reply-To: <20071115081648.GK14735@spearce.org> (Shawn O. Pearce's message
	of "Thu, 15 Nov 2007 03:16:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65144>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> When you think about it, as long as the topological relationship
>> between A and B is very similar to that of C and B (iow,
>> "merge-base A B" and "merge-base C B" are the same), the effect
>> should be the same as a real merge between B and C, shouldn't it?
>> 
>>   ---o---o---C---A---M
>>       \       \     /
>>        o---o---\---B
>>                 \   \
>>                  `---X
>> 
>> I am wondering if it makes sense to record the result of
>> "cherry-pick -m" as a real merge between the current HEAD and
>> all the other parents of the cherry-picked merge except the one
>> that is named with the <parent-number>.
>
> Yes.

Actually, this turns to be a trick question ;-)

If there was an accidental clean merge between A and B, and a
part of the duplicated same changes in the accidental clean
merge sits between C and A, replaying the difference from A to M
on top of C would not yield the same result as merging B into C.
