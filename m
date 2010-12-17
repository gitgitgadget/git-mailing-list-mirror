From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: do not attempt to track HEAD implicitly
Date: Thu, 16 Dec 2010 21:55:27 -0800
Message-ID: <7vsjxxj640.fsf@alter.siamese.dyndns.org>
References: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch> <AANLkTi=PPx-pLEeR4gLw0KzV_=ZnuqqH_CGc6L7RzU7M@mail.gmail.com> <201012151626.35366.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 17 06:59:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTTLf-0003PF-7z
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 06:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab0LQFzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 00:55:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab0LQFzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 00:55:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB98038B7;
	Fri, 17 Dec 2010 00:56:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MldO+4uHpD9ToB6kv/rvt8EOucs=; b=HeYc/B
	x8EHA3MwS+6Bjyn0YuazyVfm8Si8rhUTRSShMKtwlFmQr8C3WvrHW4cZC2jlPPSp
	uCLcIsdkC/JjXzlKKxaNrUk1PzALj1oU/YEwfR1cMIniJzEXAjubAjpf2XP8HMRq
	xkAlvd7F1mK8hH88I/QwRpSd1avHj5WS1rOjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BoHLScgUFe6WSbNLUyJdBZRmvrcTslV/
	Zry3qwqRlhPqc+XHVkxMyS2+j3EttfaCwAYCMUOPfGbQ7DRcY3e5CGuM0aXacQtW
	ICO2m0RZwRF+5zkYFzUkNONcioFfHbLQQTdkNVUGDA7aincdSZvImYs+sMfIc35M
	UHm/74y2xqY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B30938B6;
	Fri, 17 Dec 2010 00:56:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D4FA38B1; Fri, 17 Dec 2010
 00:55:57 -0500 (EST)
In-Reply-To: <201012151626.35366.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 15 Dec 2010 16\:26\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 539E1F16-09A2-11E0-9844-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163864>

Thomas Rast <trast@student.ethz.ch> writes:

> Martin von Zweigbergk wrote:
>> On Tue, Dec 14, 2010 at 1:38 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> > Silently drop the HEAD candidate in the implicit (i.e. without -t
>> > flag) case, so that the branch starts out without an upstream.
>> 
>> Thanks. This has been on my todo list for a while.
>> 
>> Should it only check for HEAD? How about ORIG_HEAD and FETCH_HEAD?
>> Simply anything outside of refs/ maybe? Would that make sense?

I was tempted to say "limit to refs/heads/ and refs/remotes/" but perhaps
people have custom namespaces defined in refs/ hierarchy and for some of
them the tracking may make sense.  How about ignoring the implicit track
if the ref does not begin with refs/ to cover the obvious ones like HEAD,
FETCH_HEAD, etc.?
