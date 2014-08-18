From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5534 broken when gpg not installed
Date: Mon, 18 Aug 2014 09:55:41 -0700
Message-ID: <xmqqa971ybxu.fsf@gitster.dls.corp.google.com>
References: <53EFCAD1.8040808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 18:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJQDv-0003lo-LL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 18:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaHRQzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 12:55:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63034 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbaHRQzx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 12:55:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D10BF30471;
	Mon, 18 Aug 2014 12:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uJc7eRTj7ScJ
	zJi8H24ogV1cNi4=; b=RXl9nG0lSOLXesYewEiER+bNUrsBRz/v6whkKo5PqzhH
	B8+F8bR/wf16B3eM8qTBRFM2uDAjZttmOoxSRFyvD8FAz+Pk7dx2MIaoONCBbuPY
	72pZiE/ux3CNhlWOs0DD01qnfKgmzgEVwT7ULGeLoUQhe81PBCEF4IJwf2h4yR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j8itVv
	pGkeHmeTDq+2J38nYoAVdmtAuuScVvrJdciYiHgU+YBorM/46oiweB9TzrKRH8V9
	Wds/xBH+ZyJdKQCG4+YePZYkDUDNdNKiQmWlzZciESPexLNwfK8S+wDAkPAF+wH3
	2P25NYvwaB4S7hYTTdPFz9UiVIG/1BWdUjTg8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C487830470;
	Mon, 18 Aug 2014 12:55:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 16BA13045D;
	Mon, 18 Aug 2014 12:55:43 -0400 (EDT)
In-Reply-To: <53EFCAD1.8040808@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 16 Aug 2014 23:19:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7DB9B20C-26F8-11E4-A97B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255399>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> (I couldn't find a post for this patch)

Thanks.  This is from a topic near the tip of 'pu' I have been
toying with on and off but not yet ready to be sent to the list.

> The following is needed for systems without gpg to make t5534 pass:
>
>
>
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 3acc864..ee5aaff 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -45,7 +45,7 @@ test_expect_success 'unsigned push does not send pu=
sh certificate' '
>         ! test -s dst/push-cert
>  '
> =20
> -test_expect_success 'signed push sends push certificate' '
> +test_expect_success GPG 'signed push sends push certificate' '
>         prepare_dst &&
>         mkdir -p dst/.git/hooks &&
>         write_script dst/.git/hooks/post-receive <<-\EOF &&
