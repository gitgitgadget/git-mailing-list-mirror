From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] pretty: note that %cd respects the --date= option
Date: Thu, 21 Aug 2014 13:07:12 -0700
Message-ID: <xmqqr409r4i7.fsf@gitster.dls.corp.google.com>
References: <53F4941E.2060201@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKYdt-0000gj-3S
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 22:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbaHUUHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 16:07:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59451 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753660AbaHUUHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 16:07:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0640344F1;
	Thu, 21 Aug 2014 16:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19AbqkmVcb48q+PLyMIxT/nr3/g=; b=Ty6TKN
	AJDU9bOUi/HrmkxVKPNpiKHWWLOL/MSrBdlrxbmkg0ndF/XI0AHIET5iIs6vIqi/
	3GRMQYThLW7ysB3KorBkswVriswNH6BpBYiG+sAL9Nye3u3S4dOy0Izh21atQdAx
	eRwaPapGmtPRs3UBv5ETbCah+ig+n3a+CabDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBmL+kxgsUvTC4N5NFRn8LZtAJ0CMl60
	tpxyOrMHgYdtfCbGMD1UYBeDIR/4rnlyB759oWxzeCVeazfxut84bSoT8hITD3G3
	hjXGTB8CTZuaYygkKEtQpJn7q23oO9188NXtH5J8EWvWVy9sF3i1QVEwW0AA+FG/
	GevTZgVglYg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E67CE344F0;
	Thu, 21 Aug 2014 16:07:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A2E03344E5;
	Thu, 21 Aug 2014 16:07:14 -0400 (EDT)
In-Reply-To: <53F4941E.2060201@virtuell-zuhause.de> (Thomas Braun's message of
	"Wed, 20 Aug 2014 14:27:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE7A5990-296E-11E4-A11F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255637>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>
> Today I found out that both %cd and %ad pretty print format
> specifications honour the --date option as shown in:
>
> $ git log --abbrev=8 --date=short --pretty="%h (%s, %cd)" -n1
> 5bdb1c4e (Merge pull request #245 from
> kblees/kb/master/fix-libsvn-address-conflict, 2014-08-16)
> $ git log --abbrev=8 --date=short --pretty="%h (%s, %ad)" -n1
> 5bdb1c4e (Merge pull request #245 from
> kblees/kb/master/fix-libsvn-address-conflict, 2014-08-16)
>
> But the documentation did not mention that.
>
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt
> b/Documentation/pretty-formats.txt
> index 85d6353..eac7909 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -122,7 +122,7 @@ The placeholders are:
>  - '%ce': committer email
>  - '%cE': committer email (respecting .mailmap, see
>    linkgit:git-shortlog[1] or linkgit:git-blame[1])
> -- '%cd': committer date
> +- '%cd': committer date (format respects --date= option)

Funny that we already have the same text for %ad.  Thanks.

>  - '%cD': committer date, RFC2822 style
>  - '%cr': committer date, relative
>  - '%ct': committer date, UNIX timestamp
