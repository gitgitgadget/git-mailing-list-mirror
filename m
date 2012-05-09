From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/19] bash prompt: use bash builtins to find out current
 branch
Date: Wed, 09 May 2012 14:50:16 -0700
Message-ID: <7vaa1hqb1j.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-12-git-send-email-szeder@ira.uka.de>
 <7vzk9hqg0u.fsf@alter.siamese.dyndns.org> <20120509211143.GE6958@goldbirke>
 <7vehqtqc6d.fsf@alter.siamese.dyndns.org> <20120509214534.GF6958@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 23:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEm9-0003tO-9n
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab2EIVuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:50:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757909Ab2EIVuU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 17:50:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2467753;
	Wed,  9 May 2012 17:50:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RmrmsGE7gPsO
	yYAJuQeY7ylKiKU=; b=H97gHslKU1RZmqt2ZLLR3G8zyF6ziTyE3rWVc9W9JoiU
	0zHZKHs+CZ8cpCKp85iCpjt9XzefV9meHvFcWAadgxju/BCOrHNy1N6WGpKdgrU1
	5t2PJdYj5Vpvx+ay2LYtvVs+4ZrBkbStkJryx2MIKjn5nsdUaQc5F8G0FABMoVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KNC11J
	itZxCUo7HhBmMUj38JfTbVrNO3hDUM2krfapJHV9P6Ah3CD+YPEEof5pTw1Z2Shn
	sbZXsvTgX8rc48qfrU7jpY+ylZfr6L0y7I1IuQBhD/ZoRv755BTUJU+pfmrff+ST
	wJKjI1YnrSZhUb0dPwlCXEW8vhN5FBDndlglg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 454297752;
	Wed,  9 May 2012 17:50:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1B5E7751; Wed,  9 May 2012
 17:50:17 -0400 (EDT)
In-Reply-To: <20120509214534.GF6958@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Wed, 9 May 2012 23:45:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F76EF5A6-9A20-11E1-A08D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197520>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> 'readlink' is not a bash builtin, so it would need the same number of
> fork()s and exec() as 'symbolic-ref'.  Of course, the 'readlink'
> binary is much smaller than git and has less to do, so it might be a
> tiny bit faster, but for this rare corner case it really doesn't
> matter.

Correct, and by not using it you do not have to worry about systems
that does not install the binary.
