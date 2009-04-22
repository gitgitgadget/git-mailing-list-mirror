From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Wed, 22 Apr 2009 18:35:45 -0400
Message-ID: <m3ab68mi3q.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
	<m3skk2szgv.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>
	<m3d4b5oj76.fsf@lugabout.jhcloos.org>
	<m34owgoj08.fsf@lugabout.jhcloos.org>
	<7vljps324a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwl7M-0008Fs-0b
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 00:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbZDVWjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 18:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZDVWi7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 18:38:59 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:4282 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZDVWi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 18:38:58 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 4F87D4028B; Wed, 22 Apr 2009 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240439938;
	bh=RUhBAMkqg4stnMQrF0688wdL+h2y8sQAdhKDZJbtNlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=Z6S5XEMlo7nZR7Dy6aPJwhAmPVK/4Yn335o/y3hsI2Up1pMN+JU3h/kq7VVlADEKZ
	 lXiC+j68l6E8crFdMqXKHHmBaGCdnkrYAl+/aHcr/ZkEs3IfXDp9yexuRCOo6Y9eVp
	 8nSP30otXx32y5My/W/0i/ttcS/Fs+h90hpBNAfE=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 833D88AD14; Wed, 22 Apr 2009 22:36:09 +0000 (UTC)
In-Reply-To: <7vljps324a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 Apr 2009 12:44:05 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090422:gitster@pobox.com::0xsZSS4SIqEzvJa3:00000000000000000000000000000000000000000004V8i6
X-Hashcash: 1:29:090422:nico@cam.org::Syal/dvEK/5S8E17:0000BdDcS
X-Hashcash: 1:29:090422:git@vger.kernel.org::cYL+L45oHLJAejUH:00000000000000000000000000000000000000000mKh5G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117276>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> If input_buffer[ret] _were_ the last octet read, [the] loop would
Junio> be discarding that octet when [it] call[s] more than one xread()
Junio> to fill the buffer.

That did sem more likely, but I thought I'd throw out the possibility.

I just tried instrumenting fill().

In the first call to fill() during a fetch, xread() returns 4096.  In
the second call to fill(), xread() returns 4095.  In all subsequent
calls to fill(), xread() returns 4096 again.

So, after the second call to xread(), consumed_bytes & 0xFFF == 0xFFF.

It always follows the pattern:

xread() read 0x1000 from fd 0 at 0x80a0900
ret = 0x1000
consumed_bytes = 0
input_len = 0x1000

xread() read 0xFFF from fd 0 at 0x80a0900
ret = 0xFFF
consumed_bytes = 0x1000
input_len = 0xFFF

xread() read 0x1000 from fd 0 at 0x80a0900
ret = 0x1000
consumed_bytes = 0x1FFF
input_len = 0x1000

with all subsequent calls reading 0x1000 and adding 0x1000 to
consumed_bytes, until the final chuck of tha pack is read.

Also, all calls to xread() where the status lines are being sent from
the remote server also return 0x1000 octets.  Only the second chunck of
a pack ever returns 0xFFF.

I've tested against a number of remote servers and the pattern holds for
a wide range of remote server versions.

The pattern also holds for clones over ssh.

Does anyone have an idea of why the second call to read(2), when
receiving a pack from a remote, always leaves the last octet of the
buffer free, whereas all other read(2)s fill it?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
