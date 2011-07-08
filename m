From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test overlapping ignore patterns
Date: Fri, 08 Jul 2011 11:01:23 -0700
Message-ID: <7vk4bsfy8c.fsf@alter.siamese.dyndns.org>
References: <21043430.post@talk.nabble.com>
 <alpine.LFD.2.00.0812161450010.14014@localhost.localdomain>
 <7viqpjra57.fsf@gitster.siamese.dyndns.org>
 <1229620278-25152-1-git-send-email-git@drmicha.warpmail.net>
 <1310062372893-6559395.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 20:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfFMo-0005nh-Rv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab1GHSB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 14:01:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1GHSBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 14:01:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B6166EA1;
	Fri,  8 Jul 2011 14:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C4bUkWXIhfLOT5HCyPpoMM+/H7k=; b=e/cAFE
	vADNies9KIspe7WXqjyEsedZsxtS1oqa/EkAT0j207xUShZYjgj1e36kZowLAafB
	s3DoNWNGLGm5pO/TfOM7Nwqnue4/f0C1vpurvtZAKpgfIru5Hg3sLL0+fjXCdWQ9
	WUw98XYLqDGffo63Ac5pgAzakOrGB2ClF+CG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=whm/O5NrhPYUdN+2+PrDMFSx2tX8Nyd8
	bPGmHZAK1gCWW0vdG0xqBz5t2fmMjg1umiy8SBahIojNvW2rrL1JLlmN39Cmo8GL
	d7C1Ag35hUnJSO76y1A36SBASuOzqb4bg0rMZG3GvMz8R3En1jzlS+micu4MsHtz
	yms3mCzraLo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64E516EA0;
	Fri,  8 Jul 2011 14:01:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC72E6E9D; Fri,  8 Jul 2011
 14:01:24 -0400 (EDT)
In-Reply-To: <1310062372893-6559395.post@n2.nabble.com> (Stephen Haberman's
 message of "Thu, 7 Jul 2011 11:12:52 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B783B8E-A98C-11E0-8167-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176802>

Stephen Haberman <stephen@exigencecorp.com> writes:

> +test_expect_success 'negated exclude matches can override previous ones 2'
> '
> +
> + git ls-files --others --exclude="*" --exclude="!*.1" >output &&
> + grep "^one/two/a.1" output
> +'

Does this has anything to do with "negated overrides"?

Doesn't the first "*" tells us to not to look at the contents of one/
directory at all, so we that we do not have to waste time descending into
it?  We wouldn't even know what pathnames are underneath it, so "!*.1"
would not have any effect inside one/ at all, I think.
