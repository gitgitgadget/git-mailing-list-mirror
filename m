From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: enable SO_KEEPALIVE for all sockets
Date: Wed, 25 May 2016 15:44:31 -0700
Message-ID: <xmqq37p5zrjk.fsf@gitster.mtv.corp.google.com>
References: <20160525031505.5720-1-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hXc-0001cN-I2
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbcEYWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:44:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbcEYWof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:44:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 453591E19A;
	Wed, 25 May 2016 18:44:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CNt1H5glx9aNgHJp/jUhlFjOrgY=; b=v+s/CsVQy45KbK8c9//M
	zHH2nlIWeCLYaKD0TqbM1/+40Iuopc0RatlGU6KRIjqvk+0fe2uoKzcsW9ghzo0r
	xJJif8CchnEgF+M7tXBaqh5/Y4Y/AO5uasRKF55rw3xArWRwabjNfCVabPWho5TA
	jQmo1ApZyE/JTil78IKYjxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ScZjYzrvYLf7FjM5pwSq0l1o5WFz+WesWrLY65z83CWj3z
	rbrGgorOFZQe3ZM/ocf/4Wcj1gARNM+F5hEQKrTt6Isf2Jp0faXxhHjFtrm/lsLv
	LNaF2DHX0Hvh30kOFofrsNljIonw2GsmBZVovnoP4l/8d0zr5rLPMJC9sGrwk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CFFD1E199;
	Wed, 25 May 2016 18:44:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B516D1E198;
	Wed, 25 May 2016 18:44:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4037E44C-22CA-11E6-8B62-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295604>

Eric Wong <e@80x24.org> writes:

> While --init-timeout and --timeout options exist and I've never
> run git-daemon without them, some users may forget to set them
> and encounter hung daemon processes when connections fail.
> Enable socket-level timeouts so the kernel can send keepalive
> probes as necessary to detect failed connections.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---

This makes sense as a follow-up to e47a8583 (enable SO_KEEPALIVE for
connected TCP sockets, 2011-12-06), I think.
