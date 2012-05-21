From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/13] move git_default_* variables to ident.c
Date: Sun, 20 May 2012 21:07:42 -0700
Message-ID: <7vsjeu89dd.fsf@alter.siamese.dyndns.org>
References: <20120518230528.GA30510@sigill.intra.peff.net>
 <20120518231113.GE30031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 21 06:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWJuy-0005Ro-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 06:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab2EUEHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 00:07:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab2EUEHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 00:07:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 539CA93A0;
	Mon, 21 May 2012 00:07:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MpdI75NdfzorWKOhr+xDCJYc0Mk=; b=IFQYdb
	LPfm4Ggp4EES//6OPeu4jRHbRQjD+X9ABIADQE1kUP/knD+DlLCoRg7GQUBflubk
	lDGRvTL8Skk1GvlpFGPcFACCAS3i9wdNgCNP/7CS77wOy2Jw8Z0Ni7CAPxhcIbav
	EHDx+5LjImOZsTJhMKhHslYWUuD0I+EBLzMlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nLqcEH+dR4ewmF84XVROWPGcEK2UiJYc
	F7fbtcR8EhArD6TNy06gyQObdJGbzF+AFfxTEKsW2VpLCuatbtnfF7auKIafseWy
	Sw4XRY0U/aQEFcYC3HFPrSkDojJewT/fX4wqC/TBf1zRMafwirGnAcvF33ZXVBHA
	z43QUIeh8h8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AAB9939F;
	Mon, 21 May 2012 00:07:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2E3F939E; Mon, 21 May 2012
 00:07:43 -0400 (EDT)
In-Reply-To: <20120518231113.GE30031@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 18 May 2012 19:11:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 840C4EF0-A2FA-11E1-9A83-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198081>

Jeff King <peff@peff.net> writes:

> diff --git a/cache.h b/cache.h
> index 86224c8..f63b71f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1142,9 +1142,6 @@ struct config_include_data {
>  #define CONFIG_INCLUDE_INIT { 0 }
>  extern int git_config_include(const char *name, const char *value, void *data);
>  
> -#define MAX_GITNAME (1000)
> -extern char git_default_email[MAX_GITNAME];
> -extern char git_default_name[MAX_GITNAME];
>  #define IDENT_NAME_GIVEN 01
>  #define IDENT_MAIL_GIVEN 02
>  #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)

During this step, builtin/fmt-merge-msg.c ceases to compile, even though
in the end it is fixed...
