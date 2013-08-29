From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/11] Use current output for "git repack"
Date: Thu, 29 Aug 2013 11:13:23 -0700
Message-ID: <xmqqzjs04b7g.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1431109393.34423.1377626210746.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:13:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6ip-0008TG-Dr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440Ab3H2SN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:13:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756152Ab3H2SNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:13:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482CB3D5D9;
	Thu, 29 Aug 2013 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NSP/vjXbDpToJyOxBsN9Tjbz8Yc=; b=ZyEIRT
	SK2RCHEWyc1KadjhiRxjXvYLx/zjptk0455APZ3S/gZBNTCZoPDsEPzcqV5t5XQU
	ioEs+sM4kHLEHcKMt9GGkhWG6uvPJu30YU4VF0p0ATGnanDOfdwVbl5WrrMZZvjv
	aKaRs4sf8OmTnNsgqdgtLEo2osLQuxQVHE1V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nqLRN9gjPfKSWo0syewZh5HeNpg1GTPS
	++vnhFGEZ98pPDeip5o9JFEdtpklQPv+xAwex5Uk2IjO9mRlEXtIIJGbXTHV0SIh
	oR8N/VzEgUl94dhV0PLHA/XnCziiWQALfrWrM7BANLbiarQ8kh5NxIrcCmQLbNgK
	ONEh5Da16Po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 352283D5D8;
	Thu, 29 Aug 2013 18:13:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7587B3D5D2;
	Thu, 29 Aug 2013 18:13:24 +0000 (UTC)
In-Reply-To: <1431109393.34423.1377626210746.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:56:50 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1F3089A-10D6-11E3-A61B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233303>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/user-manual.txt | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index bdefd9a..3f44ca0 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3203,17 +3203,15 @@ To put the loose objects into a pack, just run git repack:
>  
>  ------------------------------------------------
>  $ git repack
> -Generating pack...
> -Done counting 6020 objects.
> -Deltifying 6020 objects.
> - 100% (6020/6020) done
> -Writing 6020 objects.
> - 100% (6020/6020) done
> -Total 6020, written 6020 (delta 4070), reused 0 (delta 0)
> -Pack pack-3e54ad29d5b2e05838c75df582c65257b8d08e1c created.
> +Counting objects: 6020, done.
> +Delta compression using up to 4 threads.
> +Compressing objects: 100% (6020/6020), done.
> +Writing objects: 100% (6020/6020), done.
> +Total 6020 (delta 4070), reused 0 (delta 0)
>  ------------------------------------------------
>  
> -You can then run
> +This creates a single "pack file" in .git/objects/pack/ 
> +containing all currently unpacked objects.  You can then run
>  
>  ------------------------------------------------
>  $ git prune

Good; thanks.
