From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] fetch --prune: prune only based on explicit refspecs
Date: Mon, 28 Oct 2013 08:08:14 -0700
Message-ID: <xmqqmwlth1r5.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-12-git-send-email-mhagger@alum.mit.edu>
	<xmqqiowmml0y.fsf@gitster.dls.corp.google.com>
	<526B65E8.1070900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 28 16:08:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaoQw-0006bz-Tt
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 16:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab3J1PIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 11:08:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756700Ab3J1PIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 11:08:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1B514E6C0;
	Mon, 28 Oct 2013 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RcWktna1cFzuWQwxcf4VA6X8+Yg=; b=R9Ov0n
	Bf0247xr+NAu+0rB+MMlH9ndyzmpQRBdaNtzdratGBd/YbXp5dXqzo3AAfr6rJ7Q
	psdCoSkcUiMbqMRycZAE68xdN5rDu7b66UMMv1kV+O7IKmywR0skRy0bhewwliGl
	TVWEmILPzqhA5W8H2Yi6jjFoB6G8/CVocgDvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OH2T69VOqkXDC8i/C0INS4MPzS+3oVPv
	cNwaCoW5MQaXIhnNKq2Ml0TWiBffTul8+Od4FS6v+hvM6fP0OFhgjqkaLTMYqcN6
	dlTdyLjgGHcbW7alPCswlzTKEl9f20eIzFz0lFHOwoRgszGfX17AMqN06DmcdSqu
	gh7IdJHhoBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91DAC4E6BF;
	Mon, 28 Oct 2013 15:08:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D423E4E6BD;
	Mon, 28 Oct 2013 15:08:31 +0000 (UTC)
In-Reply-To: <526B65E8.1070900@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 26 Oct 2013 08:49:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF036FE8-3FE2-11E3-984D-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236832>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/24/2013 11:11 PM, Junio C Hamano wrote:
> ...
>> We should just lose "It is similar to using" from 10/15 and start
>> over, perhaps?  Add the first paragraph of the below in 10/15 and
>> add the rest in 11/15, or something.
>> 
>> 	--tags::
>> 		Request that all tags be fetched from the remote
>> 		under the same name (i.e. `refs/tags/X` is created in
>> 		our repository by copying their `refs/tags/X`), in
>> 		addition to whatever is fetched by the same `git
>> 		fetch` command without this option on the command
>> 		line.
>> 	+
>>         When `refs/tags/*` hierarchy from the remote is copied only
>>         because this option was given, they are not subject to be
>> 	pruned when `--prune` option (or configuration variables
>> 	like `fetch.prune` or `remote.<name>.prune`) is in effect.
>> 
>> That would make it clear that they are subject to pruning when --mirror
>> or an explicit refspec refs/tags/*:refs/tags/* is given, as tags are
>> not fetched "only because of --tags" in such cases.
>
> I see your point.  What do you think about the following version, which
> is a bit more compact and refers the reader to --prune for the full story:
>
> -t::
> --tags::
> 	Fetch all tags from the remote (i.e., fetch remote tags
> 	`refs/tags/*` into local tags with the same name), in addition
> 	to whatever else would otherwise be fetched.  Using this
> 	option does not subject tags to pruning, even if --prune is
> 	used (though tags may be pruned anyway if they are also the
> 	destination of an explicit refspec; see '--prune').

I like the first sentence of yours better. The second sentence feels
somewhat iffy, though. --tags refs/tags/*:refs/tags/* will allow
tags to be pruned, so s/option does not/option alone does not/ needs
to be done to be precise, at least.

Thanks.
