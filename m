From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Convert simple init_pathspec() cases to
 parse_pathspec()
Date: Wed, 12 Oct 2011 17:29:08 -0700
Message-ID: <7vbotl7mzv.fsf@alter.siamese.dyndns.org>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
 <1318373083-13840-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 02:29:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE9Ak-0005Hh-2H
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 02:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab1JMA3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 20:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751449Ab1JMA3M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 20:29:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD78E661C;
	Wed, 12 Oct 2011 20:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ySYnLJKg2AEF1DLwKlvOCPggbfQ=; b=YHBEwz
	hjiJ/ErnaNYU3KSsJVjv10orPGRasR+wPedAidZm1LQYG7tSAlMr4bdY4d6kEDpn
	TQyRkv5Hj4HbI38wTS7dOJ8zwuCPSMkV/Zz9W8vmwivbNoMIMjDBDTXbXhnWRUWB
	LXqUIzBjW5MJF+4YymXXez0mL9dqJDBfa5FDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rbvmf5UxFAv57gJ18PS5VnrJ1mMkcr5w
	Ut8YRrUKM6W2e+mfekj4h4e6VfAH4yCkkzm+/Sqf2Mg+1JtwfO14KTCQRXxK3EN6
	PdVFaDWnjgL6Y84a3ji2dS5ZOS0uGoGVNOvkDeUhmfAFAL6qUeX5xNl5GK5oyOlx
	S9Oyy0P52ko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D51C2661B;
	Wed, 12 Oct 2011 20:29:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C745661A; Wed, 12 Oct 2011
 20:29:10 -0400 (EDT)
In-Reply-To: <1318373083-13840-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 12 Oct
 2011 09:44:42 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E8C7A22-F532-11E0-817F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183431>

I gave a cursory look up to this one. I didn't read 4/6 very carefully
though.

I think teaching the users of "raw[]" field of "struct pathspec" to use
corresponding "items[]" element should come before this series (up to
5/6). After that, once parse_pathspec() API stabilizes, we should teach
users of get_pathspec() to get and pass around "struct pathspec" and when
we reach the point where we can get rid of use of "raw[]" field (the field
itself can stay to serve as a debugging aid if we choose to), everybody
that uses pathspec would be ready to start taking more magic pathspecs.

Having said that, I think the series itself is going in the right
direction.

Thanks for working on this.
