From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 16:00:09 -0800
Message-ID: <7vhaoluos6.fsf@alter.siamese.dyndns.org>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:00:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TabGQ-0004Rv-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab2KTAAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:00:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab2KTAAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:00:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BA356E60;
	Mon, 19 Nov 2012 19:00:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vz/fGdQOmv8lqMnRSEOesJ4hdcI=; b=PODAlo
	wiTGyvQdRImpllr8C7rvVj6rC95s0d5dlH6AUSuZb2Yh+dOKNVyrb5P5zwK7bCyU
	P1UZd1Bzi4NrqSlncpknDASyI+Lw6SumwHdsOMEEaI3KNudo4s4jav9dEQPrISRw
	7OKnp3Bhb+wvOBXQwTV/fqzyfPTNUKQbdyTsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XVIgV9k6glgOpxpiqguncpLdSooJNwFa
	aplLMN4eEDsTRz22WEsFS62zsS4Tvkj2NTO5NSa0sBcnjjj2wggg+7qQUf3TtLte
	ee6Ul68qG7rpoi1yu3sPxH4RDmem5Br85Lluu/PJ/qpCYke4G0nVTQCbvi/2MCZS
	qhJh3+c8HxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0CA6E5F;
	Mon, 19 Nov 2012 19:00:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5967F6E5D; Mon, 19 Nov 2012
 19:00:11 -0500 (EST)
In-Reply-To: <20121119225838.GA23412@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Mon, 19 Nov 2012 23:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40DCF22A-32A5-11E2-A199-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210067>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> On Mon, Nov 19, 2012 at 11:27:45AM -0800, Junio C Hamano wrote:
>> Given that the problematic line
>> 
>> 	Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y
>> 
>> is not even a valid e-mail address, doesn't this new logic belong to
>> sanitize_address() conceptually?
>
> Yes, it's much better to do it in the sanitize_address().

Note that I did not check that all the addresses that are handled by
extract-valid-address came through sanitize-address function, so
unlike your original patch, this change alone may still pass some
garbage to Email::Valid->address().  I tend to think that is a
progress; we should make sure all the addresses are sanitized before
using them for sending messages out.
