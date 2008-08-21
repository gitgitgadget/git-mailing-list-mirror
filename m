From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Thu, 21 Aug 2008 01:41:47 -0700
Message-ID: <7viqtukbec.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trans <transfire@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5l2-0000AA-Fw
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYHUIl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYHUIl6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:41:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbYHUIl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:41:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BFD9459423;
	Thu, 21 Aug 2008 04:41:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07E0159422; Thu, 21 Aug 2008 04:41:48 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808181628420.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Aug 2008 17:31:21 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00D74960-6F5D-11DD-A486-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93120>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 18 Aug 2008, Junio C Hamano wrote:
> ...
>>     If we had a configuration for "index-free" people, that changes the
>>     semantics of "git add" to register object name of an empty blob when a
>>     new path is added, makes "git add" for existing blobs a no-op, but
>>     keeps "git commit -a" and "git commit <paths>" to operate as they
>>     currently do, then people with such configuration could:
>> 
>> 	$ >new-file
>>         $ git add new-file
>>         $ edit old-file
>>         $ edit new-file
>>         $ git diff
>> 
>>     to always see what's the difference from the HEAD is with "git diff",
>>     and any of these three:
>> 
>> 	$ git commit -a
>>         $ git commit old-file
>>         $ git commit old-file new-file
>> 
>>     would work as expected by them.  We still need to support the three
>>     diff variants for normal git people, but people who do not use index
>>     do not have to know the two variants ("git diff" vs "git diff HEAD");
>>     such a change could be argued as a "UI improvement" [*1*].
>
> I think that having the possibility of adding an empty blob (or maybe a 
> magical "nothing currently here but git-ls-files includes it") would be 
> preferrable to a no-index mode.

I am not sure if you are really saying something different from what I am
saying.  We'll see after this three patch series.  The first one is an
unrelated bugfix (but the bug won't trigger with existing callers -- only
triggered with the added codepath).
