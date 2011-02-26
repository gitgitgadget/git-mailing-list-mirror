From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Sat, 26 Feb 2011 02:23:38 -0800
Message-ID: <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:24:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHJj-0005RP-M9
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1BZKX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:23:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1BZKX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:23:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE7782BFB;
	Sat, 26 Feb 2011 05:25:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B5ORwA4vAaBEFY37HL+TJlhLmkg=; b=Itks4O
	2WZQTlmLpM7JIN/2FNyY07LzbI+LsNJ+MPZH6ibyXKtjjcJIE6aLb0wiE4Kxjc6R
	YAcJXvbVTOtcUMQOMQ4gWH2g7Y6tSMeFr+xkPx2X+UTjkk6xcT/aWzpyZ40GkKG5
	N6G/dUE7VsUTubrjz+Odjh+F6xjAgyfisA3hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lvEg1B7dFxpn/k4xKRaZjPiU3XimhRnw
	NBhlcXJO8KFZ/Vz/jZAMIwvxquBfWLE0SRAVCXsIZ66J1ORA5J4+oXvbfkFoYCw8
	5x5wvYeJKJx+n+HKPSPVDeLDsuAPGiNLeRTp8y9urj5E/un6EHJvI0+vCH0YW4gy
	+tWj6a0oiDo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F3DD2BFA;
	Sat, 26 Feb 2011 05:25:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39F7F2BF8; Sat, 26 Feb 2011
 05:24:57 -0500 (EST)
In-Reply-To: <20110226100310.GA21724@do> (Nguyen Thai Ngoc Duy's message of
 "Sat\, 26 Feb 2011 17\:03\:10 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE2035AA-4192-11E0-89F0-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167969>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK here come the missing bits on top of the previous patch. Looks good?

Thanks.

> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index 5b1d70d..574eb3b 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -118,7 +118,7 @@ GIT index format
>  === Tree cache
>  
>    Tree cache extension contains pre-computes hashes for all trees that
> -  can be derived from the index
> +  can be derived from the index.
>  
>    - Extension tag { 'T', 'R', 'E', 'E' }
>  
> @@ -137,8 +137,20 @@ GIT index format
>  
>  === Resolve undo
>  
> -  TODO
> +  Resolve undo extension records staged entries before they are
> +  resolved and removed from index. It can be used to recreate conflicts
> +  after the conflict is incorrectly resolved.

I lack energy to come up with a succinct description right now, so here is
an undistilled version of what I would want to see the reader of the above
paragraph understand:

    A set of entries for a path at higher stages (i.e. the ones that
    represent a merge conflict at the path) used to be removed from the
    index and replaced with the result of the resolution when the conflict
    is resolved (e.g. with "git add path").  This extension saves these
    higher stage entries away so that "checkout -m" and other operations
    can recreate the conflicted state, in case you botched a conflict
    resolution and want to redo it from scratch.

The description of the data contents looked fine, except that "A number of
entries" felt a bit unclear (it would make the reader wonder if we record
how many we have at that location as an integer, which is not the case).

>    - Extension tag { 'R', 'E', 'U', 'C' }
>  
>    - 32-bit size
> +
> +  - A number of entries
> +
> +    NUL-terminated entry name
> +
> +    Entry mode of the entry in three stages, in increasing order from
> +    1 to 3, in NUL-terminated ASCII octal number.
> +
> +    160 bit SHA-1 of the entry in three stages, in increasing
> +    order from 1 to 3. A stage with zero mode will be skipped.
