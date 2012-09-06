From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] notes get-ref: --expand expands the output notes
 ref.
Date: Wed, 05 Sep 2012 22:23:54 -0700
Message-ID: <7v4nnb67x1.fsf@alter.siamese.dyndns.org>
References: <cover.1346848834.git.wking@tremily.us>
 <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
 <CALKQrgem2KM07vA0LeVgD6HkM1yMDBSfThKUZ7aBaxpbcC49hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:24:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9UZR-0006yH-2a
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 07:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab2IFFX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 01:23:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2IFFX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 01:23:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4CB7435D;
	Thu,  6 Sep 2012 01:23:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+dBYZyOPL9ptUjs7UnZ98WS/O5c=; b=qfSGj3
	9Q3eTq5Jy8anEWMI+IQtmkXdfMzxio1MUgeOFtSIzVYBL63bxfgKJvTekEInES+r
	O39WC6kkl+RwxEGjpjQsPAm0vHOLSO+uqrnOigXRQNxD0aVlK7A0lWkGB+UTRmqX
	+KI8rkK/SzkJFe4pWHDKvobCTbe2fx4LgPBI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVAoB7TAb9aZ5Tp5/7QqSuArRjJfuoVz
	iGTLI9CrxM+GqDlh11eKlo3x+3Ce+IFnkjnA9iBpeElk6Z/tcWNYsZEtLfSvHUqa
	nBQKue6C7qe4cT4yXEcTcUrz8n9daqB9y9cKWCrpJXWxL4Ev7B1u59j3r1aAsxet
	zWCS1HzWsDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914CB435C;
	Thu,  6 Sep 2012 01:23:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA181435B; Thu,  6 Sep 2012
 01:23:55 -0400 (EDT)
In-Reply-To: <CALKQrgem2KM07vA0LeVgD6HkM1yMDBSfThKUZ7aBaxpbcC49hA@mail.gmail.com> (Johan
 Herland's message of "Wed, 5 Sep 2012 17:49:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DD72744-F7E3-11E1-A671-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204862>

Johan Herland <johan@herland.net> writes:

> On Wed, Sep 5, 2012 at 2:52 PM, W. Trevor King <wking@tremily.us> wrote:
>> From: "W. Trevor King" <wking@tremily.us>
>>
>> Useful for debugging refs that don't seem to be expanding correctly.
>>
>> Signed-off-by: W. Trevor King <wking@tremily.us>
>
> Acked-by: Johan Herland <johan@herland.net>

Really?  Would "git log --expand master" be useful?

I'd have to say that a DWIM that the user needs to diagnose with
such a "feature" is a total failure.  Can't we fix that root cause
instead?

That is, for a name, e.g. "refs/remotes/origin/notes/commit" (the
original example in [PATCH 0/2]) or "commit" (the usual):

 - If it is already a ref, just use that (e.g. use that stuff in the
   refs/remotes/ hierarchy); or

 - If it is not, prefix refs/notes/ to it.

or something?
