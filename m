From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] diff --ignore-case
Date: Mon, 20 Feb 2012 00:52:16 -0800
Message-ID: <7v8vjxnayn.fsf@alter.siamese.dyndns.org>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
 <4F420749.9010206@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOyv-000482-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2BTIwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:52:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2BTIwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:52:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D10B4220;
	Mon, 20 Feb 2012 03:52:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XVLHKI0kJUn8MFmg7BfWbY3PlUs=; b=rwZ27K
	Y5gj0eWuNtmrgayrUa+OWSgQtNHVeFWpL9qk6DfrCZUj4EmuWzG9w25GHhKq6893
	OcsMYBjXdS8cZ5ThPy4EdSNlVSZhZIVV0yWM9AXEOCkp38gG9dKcdYzCwtwcKVdL
	76BdzcAZHIrOR9MSUc4CKTPSIV8LAPo99kEOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qn3m9UAQxL1Ybn+uKbrNLgLPXSx5znwL
	LKc5+eHhENHOmek1SdMKknlEIu3IcqjaA4uIHSuRAO8ojew3NLj/RaSY2GQdOlkD
	5SSs40J0LShgVpxOw/MCiQkFwkc6pRMLgvaWI8b8O+Dbfqdnx1lLesdqDXzrdyCl
	YxA4qoWJ3Tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 848F6421F;
	Mon, 20 Feb 2012 03:52:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B838421E; Mon, 20 Feb 2012
 03:52:17 -0500 (EST)
In-Reply-To: <4F420749.9010206@kdbg.org> (Johannes Sixt's message of "Mon, 20
 Feb 2012 09:41:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 318099E4-5BA0-11E1-9338-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191057>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 20.02.2012 03:16, schrieb Junio C Hamano:
>> This teaches our "diff" machinery to optionally consider lines that are
>> different only in upper/lower-cases to be equivalent.
>
> When would I want to use --ignore-case?

I wouldn't myself; it was just I saw somebody asked if -G can be used to
do case insensitive and then I realized we do not even support such in the
diff machinery to begin with, but now this opens a way to do so by copying
the xdl options when the pickaxe-grep codepath runs a subdiff.

You can update the hash and recmatch to be locale-aware, which would be an
internal update to xdiff/ directory that is independent of the rest of the
series, and/or the change to plug the machinery to -G.
