From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] cache-tree: fix writing cache-tree when CE_REMOVE
 is present
Date: Sat, 15 Dec 2012 23:20:36 -0800
Message-ID: <7vk3siqx8b.fsf@alter.siamese.dyndns.org>
References: <1355631328-26678-1-git-send-email-pclouds@gmail.com>
 <1355631328-26678-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 08:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk8Wz-0006fw-UB
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 08:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab2LPHUk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2012 02:20:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab2LPHUj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2012 02:20:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A57476EEE;
	Sun, 16 Dec 2012 02:20:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W3BhdY/NbxAK
	e+X26zgHPu7Hx+0=; b=RIkNIROrjuJLajH93iky8u6BG8UZ1kanPsXpUrBrwO9q
	7TlaSke73lPxU4dlhqPbwUl8oYzdmxLnIazpLvsN2AKhS+AJ0j7nPnCCoc+Cc1sT
	gbfuMxuVeFyr+GWWRX05sDpH67g12f/m96S1TPi65JR4wls4yfskcKhkAVrq764=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JdSDzv
	hl0+MXMQHH+4BKUR4LjJRWrT1HSHvXQCdmVyca7A+qRsXiEFpltyrOfiFJmU2e67
	+DG/gUqecBey5H//xprKx3Zq3IqPZO/wHYsolbG5O3L2mXHxk3YqdJH/ShNfYALa
	blnKz4VonEGVj7yH+lCY++0zEhTcsHlC0mrzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91FC46EEB;
	Sun, 16 Dec 2012 02:20:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10F696EE5; Sun, 16 Dec 2012
 02:20:37 -0500 (EST)
In-Reply-To: <1355631328-26678-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 16 Dec
 2012 11:15:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17252586-4751-11E2-82EC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211582>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> entry_count is used in update_one() for two purposes:
>
> 1. to skip through the number of processed entries in in-memory index
> 2. to record the number of entries this cache-tree covers on disk
>
> Unfortunately when CE_REMOVE is present these numbers are not the sam=
e
> because CE_REMOVE entries are automatically removed before writing to
> disk but entry_count is not adjusted and still counts CE_REMOVE
> entries.

Nicely explained.  I wonder if we can also add a piece of test to
the patch 4/4 to demonstrate the issue with CE_REMOVE entries,
though.

Thanks.
