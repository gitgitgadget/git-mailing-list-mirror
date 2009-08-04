From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Tue, 04 Aug 2009 15:22:40 -0700
Message-ID: <7vfxc7dxsf.fsf@alter.siamese.dyndns.org>
References: <1249241675-77329-1-git-send-email-sn_@gmx.net>
 <7vmy6g6rj1.fsf@alter.siamese.dyndns.org> <20090804092759.24120@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: j6t@kdbg.org, git@vger.kernel.org
To: "sn_" <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 00:23:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYSPV-0000Oh-OH
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 00:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbZHDWWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933483AbZHDWWs
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 18:22:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933480AbZHDWWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 18:22:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68C2120D37;
	Tue,  4 Aug 2009 18:22:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A839D20D36; Tue, 
 4 Aug 2009 18:22:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 573F383A-8145-11DE-893C-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124828>

"sn_" <sn_@gmx.net> writes:

>> The potentially uninitialized use your compiler is worried about is inside
>> if (cmd->pid < 0) after #ifdef/#else/#endif.
>> 
>>  (1) if not on MINGW32, we would have already assigned to failed_errno
>>      after fork() returns negative value to cmd->pid;
>> 
>>  (2) if on MINGW32, we would have assigned to failed_errno unconditionally
>>      after calling mingw_spawnvpe().
>> 
>> so its worry is unfounded.
>
> The worry is definatly unfounded, but I think it's still worth to apply
> the attached patch to get rid of the warning using the
> i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5490)
> compiler. I sended a corrected version of the patch to the ml.

Oh, there was no need for you to say "but..." and everything that followed.
I said "we should say ... instead" in my review comments, didn't I?  

We are obviously in agreement ;-)
