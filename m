From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/19] count-objects: consider .bitmap without .pack/.idx pair garbage
Date: Wed, 30 Oct 2013 10:36:29 -0700
Message-ID: <xmqq61sed5k2.fsf@gitster.dls.corp.google.com>
References: <20131025060442.GQ23098@sigill.intra.peff.net>
	<1382782796-5495-1-git-send-email-pclouds@gmail.com>
	<20131030065922.GC11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, vicent@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZh9-0005l2-Rl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab3J3Rgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:36:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36491 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab3J3Rge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:36:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 814204DE35;
	Wed, 30 Oct 2013 13:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gowuEQUbTzBT6kpyt2xupA7TIkI=; b=f4SUmr
	/Siy6iIoXcfV6jGEKcPsW+rm9Tx1nTgOEBfaH1hQVCdmRXnFIoinopoPzwmA6WsY
	287qYAKdeGOkHrMSWxptwMpQLZLJ9wfYgbVKsdTaOVFhT43DlOxc77OnRPO4Kwbd
	CWXLocqPjf4WDgaiu7pW4f6bb3SH0SWL1gAtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJuecJsc5SsvV8eKFx7aNm2ONn/axuoT
	zVl++8o+34L13W3YVYMNa6/lwDXtli9SIqD14CTxm3GpHu7WRoeSsCba9nHcMm+d
	085PZItNgFgNGG9Kvq1K8xcDORcdyAVL4vEM9tRveqshlwLswROlckPacp0taVtB
	v7QrDHDRWkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D124DE34;
	Wed, 30 Oct 2013 13:36:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38484DE31;
	Wed, 30 Oct 2013 13:36:32 -0400 (EDT)
In-Reply-To: <20131030065922.GC11317@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 Oct 2013 02:59:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1347746-4189-11E3-BD6D-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237044>

Jeff King <peff@peff.net> writes:

> On Sat, Oct 26, 2013 at 05:19:56PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>>  Maybe squash this in some place, or leave it separate. I'm fine either way.
>
> Thanks, this makes sense.  I've left it as a separate commit.
>
> Your subject did not quite make sense to me, as the effect is to _not_
> report .bitmap files as garbage. I updated the commit message to this:
>
>     count-objects: recognize .bitmap in garbage-checking
>     
>     Count-objects will report any "garbage" files in the packs
>     directory, including files whose extensions it does not
>     know (case 1), and files whose matching ".pack" file is
>     missing (case 2).  Without having learned about ".bitmap"
>     files, the current code reports all such files as garbage
>     (case 1), even if their pack exists. Instead, they should be
>     treated as case 2.

Thanks; that reads well.
