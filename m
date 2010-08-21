From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] clone: do not accept --depth on local clones
Date: Fri, 20 Aug 2010 17:27:19 -0700
Message-ID: <7vwrrk95eg.fsf@alter.siamese.dyndns.org>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, mikachu@gmail.com,
	computerdruid@gmail.com, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 02:27:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ombw7-0003NZ-Ai
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 02:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103Ab0HUA1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 20:27:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab0HUA1f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 20:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23BEECF2FC;
	Fri, 20 Aug 2010 20:27:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=iJ8YzySOj/PKx3/RHU9XVOc7F
	zE=; b=gMZiI/UYLjDN9krEWRounFXFrbrN9HOQKQjZc6dQWy1x/kMvXwAqXBlSv
	VFaM2p71zZ1/NRNU0ktC4oHzhUo3sPUkK5FNyC91+WyrTXL3NiYZ2T+pTJBP6eO1
	EWP8z655aOjpa8Bw7Bizptsn5HJK2CkZyC+J/NZwmad1UyC/BQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=PULA0kPNJ2kwXEwnWf1
	nti4RIyHBceaj7N2UXMriQnz4ZcQiOvYNyGcEvmLtI73d3rFVsPGjW05uYrvf5Ax
	elpeMkjri4MWQjeVPBehTQoYcGVszt2oXcrrHulX9d9OS4nLR13sB4cSgmaQXk6K
	l6WRA7GEJ/JHv5O1aD9KWH+8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1AD5CF2FA;
	Fri, 20 Aug 2010 20:27:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A80FACF2F6; Fri, 20 Aug
 2010 20:27:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0ABB7C8-ACBA-11DF-913F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154085>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> clone_local() function disregards --depth. Make it more apparent.
> Also hint users that file:// works with --depth.

Hmm---why?

The "--depth" option is an ugly hack that tries to conserve network
bandwidth and disk usage, which is not necessary if you are doing a loc=
al
hardlinking clone.  Without this patch we allowed people to clone with =
the
option without a downside (allowing it didn't result in broken reposito=
ry,
for example), but with it, what has long been allowed suddenly stops
working.  Is the breakage justifiable?
