From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge bus error
Date: Tue, 19 Aug 2008 17:00:42 -0700
Message-ID: <7vod3owo5x.fsf@gitster.siamese.dyndns.org>
References: <EA1ADBE3-C9A8-49DE-B135-62A46F2FD666@me.com>
 <20080819234905.GK24212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucas Carlson <lucas.carlson@me.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 02:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVb9B-0005cV-D0
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 02:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYHTAAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 20:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYHTAAx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 20:00:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbYHTAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 20:00:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AED2546F2;
	Tue, 19 Aug 2008 20:00:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8DC5F546F1; Tue, 19 Aug 2008 20:00:45 -0400 (EDT)
In-Reply-To: <20080819234905.GK24212@spearce.org> (Shawn O. Pearce's message
 of "Tue, 19 Aug 2008 16:49:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BF13602-6E4B-11DD-8431-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92941>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Lucas Carlson <lucas.carlson@me.com> wrote:
>> /usr/local/bin/git-merge: line 438: 19000 Bus error               git- 
>> merge-$strategy $common -- "$head_arg" "$@"
>>
>> I have tried every merge strategy there is. It ends up leaving a .git/ 
>> index.lock file. I used git 1.5.6 and tried upgrading to 1.6.0. The only 
>> thing 1.6.0 did was hide this bus error message but I assume it still bus 
>> errors because there is a .git/index.lock file still.
>>
>> Unfortunately the source code is proprietary so I can not let you try it 
>> on your own but let me know what I can run on my machine to help you guys 
>> track down this bus error.
>
> Build git with debugging symbols enabled and run git merge from
> 1.6.0 under gdb.  If it gets a bus error we'll at least get a stack
> trace in gdb and can see where we were when the corruption killed us.
> Its a start.

With index.lock still present, anything that calls hold_locked_index()
would die().  I am curious how it gets sigbus instead.
