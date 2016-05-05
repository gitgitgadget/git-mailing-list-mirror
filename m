From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 10/19] index-helper: use watchman to avoid refreshing index with lstat()
Date: Thu, 05 May 2016 15:47:27 -0700
Message-ID: <xmqqshxw86m8.fsf@gitster.mtv.corp.google.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
	<1462484831-13643-11-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 00:47:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayS3Y-0000ai-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 00:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062AbcEEWrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 18:47:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756265AbcEEWra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 18:47:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A67019AF4;
	Thu,  5 May 2016 18:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qSIl2wk4+Mil4N5KPqHhPIpNFyo=; b=OXXDaL
	8fU2S7i3nlgeJvM5WPcLyxkBm05peLLaOBEhZHcYnp+G0ApY+WcavuJDz3kOIYf6
	VQ9+hZIQnNFc5zX5sjY0f/8bdKnsTQc4o6MeNMUfnH114aZiiCuNPdbWfttzwSEF
	kV1K1OY8Lt2EzaFW2eRIhPysUhXDC5k61fhq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGY99Lzbw5t9O2FRfsWzlupqkDOsB+gd
	y3bZV2bol6snE/V5NANArTt5Ff9s7cCpfhlNq3dAjjYloHTbo/VHV9mct1CygmTy
	Hi3rFMY4zK8tXGztEyDQYVKywoN2iiLjp3NM/FUDR0cPQJL6yhZ7zXAInH4pNaV9
	8Qlzvyn47m0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92B7719AF3;
	Thu,  5 May 2016 18:47:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D77F19AF2;
	Thu,  5 May 2016 18:47:29 -0400 (EDT)
In-Reply-To: <1462484831-13643-11-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 5 May 2016 17:47:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 587E36F8-1313-11E6-9656-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293716>

David Turner <dturner@twopensource.com> writes:

> +extern void write_watchman_ext(struct strbuf *sb, struct index_state* istate);

Asterisk sticks to the variable, not to the type.

> +	if (c == sb.buf) {
> +		strbuf_setlen(&sb, 0);
> +	}

Unnecessary braces {}.
