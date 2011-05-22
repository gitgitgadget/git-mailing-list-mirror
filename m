From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git difftool does does not respect current working directory
Date: Sat, 21 May 2011 23:30:58 -0700
Message-ID: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org> <20110520035856.GA13582@gmail.com>
 <20110520041045.GB13582@gmail.com> <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
 <20110520044851.GD13582@gmail.com> <4DD7874A.2050604@gmail.com>
 <20110522061446.GA49297@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 08:31:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO2C4-0006le-LT
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 08:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab1EVGbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 02:31:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1EVGbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 02:31:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CAB9300B;
	Sun, 22 May 2011 02:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9D1dYUhcdHJgYoPczqak0b2JQzA=; b=HKpHXs
	rqgCgx4GZYcBlIDEAp5FOL6K0c13fPHOj4Z32TLIyHEFZLRZChqEDvzWJZWsfRor
	fBNhZAZHqmlxjL57c73/P9FAWMDAGQ4aeXD2dnCy/B5YopSMzcdbmEkMM2lwVipj
	uCgM1Xghr9XN5c+bz7GgrCXyTMpWUtTncZSuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z8IoDm/9MzYu0pZ0N9IwQgDRXIlv0iXj
	Z3xHqB6GOjWJUXCmVLBP+ocahCZc6UttsJduQ187oOZpEiJSQCDPawUcOdP3wGxp
	O2OKNVSAJkhYpQBozej3Kkrwj6TnKrtyJPUNdRR6gayHIQ2+lXRO8KCRBlHwl8ML
	REgNUQiAAQ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B7F1300A;
	Sun, 22 May 2011 02:33:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 045663008; Sun, 22 May 2011
 02:33:07 -0400 (EDT)
In-Reply-To: <20110522061446.GA49297@gmail.com> (David Aguilar's message of
 "Sat, 21 May 2011 23:14:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E555260-843D-11E0-BBFA-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174182>

David Aguilar <davvid@gmail.com> writes:

> I think updating git-difftool--helper.sh to pass a chdir to vim
> might be just the thing to do.  git-difftool.perl can be
> updated to set $GIT_DIFFTOOL_PWD so that the helper can use it
> as -c 'cd $GIT_DIFFTOOL_PWD'.  I'll see if I can whip up a patch
> in a lil bit.

Hmm, would this benefit from sharing some concepts with 7cf16a1
(handle_alias: provide GIT_PREFIX to !alias, 2011-04-27)?

If it helps, we might want to uniformly give this information to all
external processes and programs, including hooks.
