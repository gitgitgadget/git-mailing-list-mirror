From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/13] remote.c: make match_refs() copy src ref before 
 assigning to peer_ref
Date: Mon, 23 Feb 2009 19:23:44 -0800
Message-ID: <7vzlgcmsan.fsf@gitster.siamese.dyndns.org>
References: <cover.1235368324.git.jaysoffian@gmail.com>
 <75e083170cea799499bf66792a1c3950b29d6021.1235368324.git.jaysoffian@gmail.com> <7vocwspqhc.fsf@gitster.siamese.dyndns.org> <76718490902231906n620aac40x5c0663fd420c7f39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 04:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbnvd-0002Xh-Hc
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 04:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbZBXDXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 22:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZBXDXy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 22:23:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZBXDXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 22:23:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49A839C5E0;
	Mon, 23 Feb 2009 22:23:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F37139C5DC; Mon,
 23 Feb 2009 22:23:46 -0500 (EST)
In-Reply-To: <76718490902231906n620aac40x5c0663fd420c7f39@mail.gmail.com>
 (Jay Soffian's message of "Mon, 23 Feb 2009 22:06:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8EA176E6-0222-11DE-AD7F-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111203>

Jay Soffian <jaysoffian@gmail.com> writes:

> This issue existed before, but the other callers of match_heads() only
> call it once before the process terminates, and don't bother to free
> what it returns. So those callers didn't notice. This topic introduces
> the first caller that calls match_heads() repeatedly, so it frees the
> returned ref list after it has copied out what it needs.
>
> The change is independent and can be moved anywhere in the series, or
> even introduced as a patch independent of the series itself.

Thanks for explanation.

If I am reading the above correctly, a sequence that does not have 10/13
before the patch that makes match_heads() called repeatedly would break
bisection, so it cannot be "can be moved anywhere".

And it sounds like keeping this as a separate patch would make more
sense.  Your proposed commit log message for the patch would contain the
first paragraph I quoted above, I'd think.
