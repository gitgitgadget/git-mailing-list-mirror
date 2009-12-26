From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] FreeBSD iconv function signature is "old"
Date: Sat, 26 Dec 2009 01:09:08 -0800
Message-ID: <7vr5qi6r0r.fsf@alter.siamese.dyndns.org>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
 <7v7hxysie9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 10:10:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOSet-00066S-Bf
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 10:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbZLZJJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 04:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZLZJJQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 04:09:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbZLZJJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 04:09:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF30DAA6F6;
	Sat, 26 Dec 2009 04:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=YtEFpRzs++ws6y9bee4SddiG1RI=; b=CkhbWSKhzf5Mn5iqSGbvFUp
	q78uQbhToINd5iqxBJig7AOKNVmCC62M90YCQWXrDn9SVSYBymm/5yTKZojzOP97
	hXPotIxplcBLwYA6Pq6pxOhktjWiigHsazv9P1FdeBlq2l+67/T3f9PWhBDTutgP
	YRySxf9RMpNJuJsfH/pY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NtooAGRf3JXcHT5RF6nwiqNMaD8mKiwLVa5aDwLQ133jIUF30
	m9SEmzoqwU8x48QWIhi7FEyf++TWGTLoUpEsgELmog3FistnYQWRPaZFVD1uZ+AE
	/NgA7oM8yEQC9Kv19Ro7SdNgCuTw+2jiqRoI+fsPSMg6t2whIBzLId4Gy8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC637AA6F5;
	Sat, 26 Dec 2009 04:09:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 47B72AA6F4; Sat, 26 Dec 2009
 04:09:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 550D9A64-F1FE-11DE-97AA-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135687>

Junio C Hamano <gitster@pobox.com> writes:

> I noticed that my build on FreeBSD-7.2-RELEASE-i386 fails without
> OLD_ICONV=YesPlease.
>
> Is it just me and my installation (i.e. I might have failed to install
> saner iconv from the port that everybody uses), or is everybody who runs
> on FreeBSD using this option himself because our Makefile doesn't do that
> automatically for them?
>
> Just in case it is the latter, here is a proposed patch.

By the way, FreeBSD-8.0-RELEASE-i386 has the same issue.  I'll queue it to
'maint' unless anybody objects...

>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index bde27ed..9a25c08 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -777,6 +777,7 @@ ifeq ($(uname_O),Cygwin)
>  endif
>  ifeq ($(uname_S),FreeBSD)
>  	NEEDS_LIBICONV = YesPlease
> +	OLD_ICONV = YesPlease
>  	NO_MEMMEM = YesPlease
>  	BASIC_CFLAGS += -I/usr/local/include
>  	BASIC_LDFLAGS += -L/usr/local/lib
