From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] incorrect search result returned when using git log with a
 future date parameter
Date: Wed, 30 Jan 2013 11:57:57 -0800
Message-ID: <7vsj5ijvei.fsf@alter.siamese.dyndns.org>
References: <51090466.9070105@casparzhang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gris Ge <fge@redhat.com>
To: Caspar Zhang <caspar@casparzhang.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dnm-0007Ql-GO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899Ab3A3T6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:58:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792Ab3A3T6D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:58:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A62C0A3;
	Wed, 30 Jan 2013 14:58:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SR03M7hUEAvlhodGGfAdBGLlQJI=; b=TJWfGw
	CghsKvNCIFJst1HriGbLyvkX2TkE6FaHz8bKdXpOMOxAPcVe3Pvj1PKh5vwV65cd
	5UYTlyevY78G17hN6m85DU3ZY9V8slIHURZa8AHBE/F1flHmn3UEEqgtYpy/1p6l
	YKbjY7vzheo4aG3M9LK2iNwJg8xAFVOzW2ybM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NTcJrkFI+NUdgLVBlRxcC9L6hEA+xc3Q
	dGJCuZyHbva3wsz7bWHmSZjGRuGB++qkMkDbjq9EaQrmIIK2JzIR8X8uzZE5DqKp
	8Cc/Y4Cyyn5wQTsjJW7/YZb1U69709+lyuaXj14bRbLiMDwvrValI8kF08QBfwsV
	7inte3HB8ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B99C0A1;
	Wed, 30 Jan 2013 14:58:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FBEAC09E; Wed, 30 Jan 2013
 14:57:59 -0500 (EST)
In-Reply-To: <51090466.9070105@casparzhang.com> (Caspar Zhang's message of
 "Wed, 30 Jan 2013 19:30:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59463D76-6B17-11E2-97F2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215064>

Caspar Zhang <caspar@casparzhang.com> writes:

> .... A date parsing function should parse _all dates with
> correctly format_, despite if it's an old date, or the date in the
> future.

When it is fed 2013-02-12, it is ambiguous and "approxidate" can and
should use whatever heuristics (including rejection of future) to
guess what the user wanted, but 2013-02-13 cannot be interpreted in
any other way, so we should parse it as such.

Patches welcome, as long as the fix does not make things worse for
cases other than you observed.

Thanks.
