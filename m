From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7600: test merge configuration override
Date: Fri, 22 Mar 2013 07:47:49 -0700
Message-ID: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <loom.20130321T212911-611@post.gmane.org>
 <cdc4f45e7520ce1fc48588c260214717@meuh.org>
 <1363946943-30269-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Nanasy <max.nanasy@gmail.com>, Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 15:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ3GX-00086A-W1
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 15:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933410Ab3CVOrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 10:47:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933169Ab3CVOrw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 10:47:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9863B4C7;
	Fri, 22 Mar 2013 10:47:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tWrkTguaanCnvF91H4R632vdJw0=; b=wUTADe
	lprkfq+wZBYmp7TenEXcS/TLIs8EVU0VdAe96vrRx+fkQmUtv4A+0ASgrK+QQRSE
	fyXR7+WB3r3xWT1Srh/WNKdO8fmwQH55P38jSPQXpa8xPM7/fSIYM6kMv74DQvzG
	AWGYHxCBKqiVgReb5g4/y5yP190GZRJ55sU5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVP2eCHWP+eDrq3D4afy2dEp/R9EsV2O
	hHSR0s30nBWGVHv6RLaZCCfBhCIJCOXDQalyQ6R7YMN9PU+rYPP5KwBWerYj4u0q
	u1fdqXfAjHiDCsOMXCqbmIybzMmruiwgxke4zTvGUGZbhJRhBuGMdxn95d81vOkV
	/t8fspNTmEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCD8AB4C6;
	Fri, 22 Mar 2013 10:47:51 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 437D1B4C4; Fri, 22 Mar 2013
 10:47:51 -0400 (EDT)
In-Reply-To: <1363946943-30269-1-git-send-email-ydroneaud@opteya.com> (Yann
 Droneaud's message of "Fri, 22 Mar 2013 11:09:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78A3BA1C-92FF-11E2-915A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218803>

Yann Droneaud <ydroneaud@opteya.com> writes:

> +test_expect_success 'merges with merge.ff=only and --no-ff-only' '
> +	git reset --hard c1 &&
> +	test_tick &&
> +	test_when_finished "git config --unset merge.ff" &&
> +	git config merge.ff only &&

I see this was copied from existing tests, but we should use
"test_config" these days.  It would be a good approach to first do a
preparatory patch to convert the existing ones to use "test_config"
and then to redo this patch using "test_config" on top of it.
