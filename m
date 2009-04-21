From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Tue, 21 Apr 2009 13:11:52 -0400
Message-ID: <m3skk2szgv.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJZv-00012D-9K
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZDUROe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZDUROe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:14:34 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:3811 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZDUROd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:14:33 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 50D1C4025B; Tue, 21 Apr 2009 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240334072;
	bh=r42NAm0/2YWUTTEZY5M0YSgQZ9x8z8+jUrh7mL+CCK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=xC8cALh3NGjUwq03YthxSvvdEcXkoW6IwLdra+t6wk2bx0C0s/PO1hxAuSTW1zGOa
	 R+qIyb8OFk19zyZv9tqALzd17YC1fPd+wmVYOfWndbfGa5RWhWgofX9VsKaJmjbH0i
	 qXEf51ZpI9aMMxqCpBYMnIwXMMt7SaWJJzJmA8lU=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 054C28B010; Tue, 21 Apr 2009 17:12:20 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.00.0904210054190.6741@xanadu.home> (Nicolas Pitre's
	message of "Tue, 21 Apr 2009 00:56:10 -0400 (EDT)")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090421:nico@cam.org::Au5kcpUeSKJkyydN:000093LBV
X-Hashcash: 1:29:090421:git@vger.kernel.org::kcUb3Wunac1VzRDj:00000000000000000000000000000000000000000Z5BKx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117138>

>>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:

Nicolas> On Sun, 19 Apr 2009, James Cloos wrote:
>> When progress.c:throughput_string() is called, the variable total
>> invariably has its twelve least significant bits set.  Ie, it is
>> always the case that:
>> 
>> total & 0xFFF == 0xFFF

Nicolas> Could you please explain ow you come to that conclusion?

Empirical evidence.

Even since the current progress was added, it has always shown nn.99 KiB
in that range.  I added an extra snprintf(3) to show total in hex and it
always ends in FFF.

I presume the progress function is getting called just before total hits
a page boundry.  In any case, the empirical evidence is clear.  And only
even seeing .99 is annoying.  Hense the proposed patch.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
