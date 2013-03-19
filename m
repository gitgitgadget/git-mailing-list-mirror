From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 39/45] parse_pathspec: make sure the prefix part is
 wildcard-free
Date: Tue, 19 Mar 2013 11:34:41 -0700
Message-ID: <7vli9ji6gu.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-40-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 19:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI1NQ-0001ww-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 19:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab3CSSeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 14:34:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab3CSSen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 14:34:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F05BC9E5;
	Tue, 19 Mar 2013 14:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f9/Dg0I26HJ/ECd1HaG7rewEjYk=; b=YLtDsf
	TueIYWwo+Zh+ZoweDPiO78IlfpbSrYXKK9wKg1JmU+mO/BAU8pXRFxg870ayBMr/
	3VCLmCBls2a1WivR8FYUxL2vzT9smiKj2s3I/cP9T6VuH1QB9ZW/qH8arIe+XLRR
	z9P9UTWA/M8JBjgqQsLEgtMVpIJ0uxHBFlcOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZIscv7y8/9oZxwVe3ekF1LISBafM/QWs
	ZOAp3gxyI1cf5kHs77E8Je8bU80/4EGtYrPGm74RQh1V2LjNVFZjHMML2Su5KPSF
	NBlB1XzWEi/Q1mZsf5/FD9s6UsW3U6FZvO41vggAYqHw5V333gILZ9mr3ddx/Fl7
	2bQakACC5SU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E07C9E4;
	Tue, 19 Mar 2013 14:34:43 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84A6CC9E2; Tue, 19 Mar 2013
 14:34:42 -0400 (EDT)
In-Reply-To: <1363327620-29017-40-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Mar
 2013 13:06:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA58E3B8-90C3-11E2-9329-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218547>

This seems to break t7300-clean.sh #8
