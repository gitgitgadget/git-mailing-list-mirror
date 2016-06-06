From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff.h: extend "flags" field to 64 bits because we're out of bits
Date: Mon, 06 Jun 2016 12:45:28 -0700
Message-ID: <xmqqfusqw17r.fsf@gitster.mtv.corp.google.com>
References: <20160606111643.7122-1-pclouds@gmail.com>
	<20160606111643.7122-2-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomas.braun@virtuell-zuhause.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:45:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA0Sw-0006iI-4T
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 21:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcFFTpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 15:45:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750789AbcFFTpc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 15:45:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 27D8E22AFA;
	Mon,  6 Jun 2016 15:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dn2kCD6z4Thl
	FI2pgjsEwO88ABY=; b=uJIKBPgSpmgniEVgT8K+PIvYjFYaddxMEmG1fAUbjhlB
	/larkmhFRfVRVWG4xGrIZ1SgeWRTDCz4YUMmykNFPCbyyQjfGE0HZ3cNAnNQAbMj
	jJOA1oyJHic3lxL4m5H6sG2nHY1dfyWehk6QCZGABigS9OFgzxBIhedIoHYUSsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NKFJ/j
	evXEjKybOrAWymvRe5Xjo4q/UN+MdLXHymrx+21U7EzGsW0A+Ql3jT8UgCWOoWVs
	41zRN3Jm4LHzUvHHqcjZ6aviIPKlSLyI4p1redYmwLRg1gwdWNCYOIlfUfjLKBHO
	m2IStFBcpNymH6FQWIK/ibAUKXLznoiBkEUlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20BD622AF9;
	Mon,  6 Jun 2016 15:45:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C60C22AF8;
	Mon,  6 Jun 2016 15:45:30 -0400 (EDT)
In-Reply-To: <20160606111643.7122-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
	Duy"'s message of "Mon, 6 Jun 2016 18:16:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39C9DCBA-2C1F-11E6-9B4A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296558>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Current flags field is 32-bits, all used except one bit and we need o=
ne
> more bit is needed for to toggle i-t-a behavior. The 9th bit could be
> reused for this, but we could just extend it to 64 bits now to give r=
oom
> for more future flags.

Isn't it a better option to add new things as separate words (or a
separate bit:1 field)?  Is this 32nd thing envisioned to be added
going to be used everywhere like the existing flag bits, or can it
be handled like "use_color", "break_opt", "show_rename_progress"?
