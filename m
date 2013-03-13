From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 10:40:55 -0700
Message-ID: <7vppz32o60.fsf@alter.siamese.dyndns.org>
References: <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org> <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
 <20130313170821.GK2317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:41:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpg5-0005iF-KQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab3CMRk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:40:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270Ab3CMRk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:40:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF154AE28;
	Wed, 13 Mar 2013 13:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AgdRymPGrsOCbsDvFgZ/kiB/T58=; b=MyqiQc
	KAMoPNh0M2848eBM/pE7y79nTbqht6vhnCTYi0dv1muUAUpqJRHi0kdJhXTUtbwi
	8fvIsXm4+CzOLvFDPXNwbfpfjzyYHxDAz03MQJ5FThC0oaH31ipP17Gl0rQqvpik
	2OIiVTWE/BJ7M2j4BcK2icHmCzaJArnDtmYVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unuoRGl2tPFUfhqAF8zUPdEuGa6ODHcw
	JTw6TQqCahhqriXhR4cpKtOL4BRTdKysasKRZ3zwvxsQ4O8HpTlijBw7AGpFIWKu
	XwvpgergBPCyGCndep5sqPYH23pUNfxve8XrSF82fFijQYOW6R6cyWeT/0MTtLiR
	4Irm86XAdjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE18AE27;
	Wed, 13 Mar 2013 13:40:57 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BE52AE24; Wed, 13 Mar 2013
 13:40:56 -0400 (EDT)
In-Reply-To: <20130313170821.GK2317@serenity.lan> (John Keeping's message of
 "Wed, 13 Mar 2013 17:08:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 295336F0-8C05-11E2-B132-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218073>

John Keeping <john@keeping.me.uk> writes:

> git-hash-object(1) implies that it will apply the clean filter and EOL
> conversion when it's given a path to a file in the working tree (as it
> is here).  Is that not the case?

Applying clean to smudged contents _ought to_ recover clean version,
but is that "ought to" something you would want to rely on?
