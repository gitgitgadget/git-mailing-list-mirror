From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Makefile: extract perl-related rules to make them
 available from other dirs
Date: Thu, 07 Feb 2013 11:16:00 -0800
Message-ID: <7v62247x5b.fsf@alter.siamese.dyndns.org>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:16:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WxS-0001sq-NK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab3BGTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:16:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758806Ab3BGTQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:16:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7CBFC7EC;
	Thu,  7 Feb 2013 14:16:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dScSWi675iYOO8zaH1LoMv9C+oY=; b=BlYMz9
	/kx7tok/JPAykxbXhnmB4z9w5JnD4vghBYi9bTPcMdQY19A473sCgn17YH0zDXPM
	ihz6MmFnnfVKJZEb0rt9OVDrNyFvy71KeyCQDNl2hgSVuvJnC0+K5DthVSrlsaLO
	4vxra+O5kMbs8SAYcBLD0DYZOYHR13ktZz7SE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7/rbX0dkXbjmZMxTkPxPLMMxIK2tLj4
	xVMrU78z6IcU/rPGppgyiAlpapbmSEmvXmVzIzhn2a3HJXgFaJPSLg77PPnkjIdq
	GbEC8TZu3y5llJ77gaiE6y9Ce4JXasdqmzvnQYFvboLXCFlpSVDsIT2gofWM0kao
	N0w0/uQdnbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD66BC7E9;
	Thu,  7 Feb 2013 14:16:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 451F1C7E8; Thu,  7 Feb 2013
 14:16:02 -0500 (EST)
In-Reply-To: <1360174292-14793-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed, 6 Feb 2013 19:11:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFEC8CDE-715A-11E2-814D-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215713>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The final goal is to make it easy to write Git commands in perl in the
> contrib/ directory. It is currently possible to do so, but without the
> benefits of Git's Makefile: adapt first line with $(PERL_PATH),
> hardcode the path to Git.pm, ...
>
> We make the perl-related part of the Makefile available from directories
> other than the toplevel so that:
>
> * Developers can include it, to avoid code duplication
>
> * Users can get a consistent behavior of "make install"
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

The goal may be worthy, but the split does not look quite right.

What business do contrib/ scripts have knowing how gitweb and
git-instaweb are built and what they depend on, for example?
