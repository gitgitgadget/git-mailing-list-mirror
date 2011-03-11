From: Junio C Hamano <gitster@pobox.com>
Subject: [Buglet] "git show <random-40-hexdigit>" gives an unclear error
 message
Date: Fri, 11 Mar 2011 10:28:08 -0800
Message-ID: <7vzkp1y0jr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 19:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py74a-0000us-2S
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 19:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1CKS2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 13:28:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab1CKS2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 13:28:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 319434D55;
	Fri, 11 Mar 2011 13:29:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	5MAiyIJRZmCwOWqYRITxJj/QXQ=; b=gskt9QWiyp3BwdKMGvTX5jdbArVgMlf3w
	IQnDLk3ueydaCc99PsRoUllSERMr+sQjLe5R0wQftTicf7Bn9ua7Syehv49BeNnD
	3Pvh5phHs3T+BlO8IwqowH8qsKm3bMWXjbdTXkPU9ak0/hZP1I29bvd364WsLQtu
	9KcufGcpkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=v9L
	ehGZYLRlgvIGInuB5norOsSwup3zqQbRtasY2ZK5p6DVTNbZma52ofH0Ha6SZJDF
	EY3IWJMYqwbgPm5+QPLPfm5RQEW/NfruNRS9M55+WqpLZigFZgSDyI4uqepO/76c
	HbZ71DwORwGnop1Eaz9L/PefcrgU+cXX60wUOvb0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17E454D53;
	Fri, 11 Mar 2011 13:29:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BED94D52; Fri, 11 Mar 2011
 13:29:40 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87EAF43A-4C0D-11E0-9EFE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168920>

Here is one who wants to tackle potentially a low-hanging fruit.

  $ git cat-file -p 4cd96ce446ab653325a0e47fad73e94c99c57dd2
  error: unable to find 4cd96ce446ab653325a0e47fad73e94c99c57dd2
  fatal: Not a valid object name 4cd96ce446ab653325a0e47fad73e94c99c57dd2

This looks sensible and understandable, even though you could argue that
we don't have to say the same thing twice.  In the same repository:

  $ git show 4cd96ce446ab653325a0e47fad73e94c99c57dd3
  fatal: bad object 4cd96ce446ab653325a0e47fad73e94c99c57dd3

This is bad, as it sounds as if we found the named object but it is
corrupt.
