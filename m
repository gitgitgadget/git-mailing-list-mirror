From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/27] nd/shallow-deepen updates
Date: Mon, 13 Jun 2016 10:10:09 -0700
Message-ID: <xmqqr3c1c8we.fsf@gitster.mtv.corp.google.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
	<CAPig+cRfUjpku1Abf=GxrbFeS4txwr=yZsJ7EKo-aWmxYog6Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 19:10:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCVNT-0008EZ-AY
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 19:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657AbcFMRKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 13:10:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933027AbcFMRKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 13:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C28422D1D;
	Mon, 13 Jun 2016 13:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GD2oPiH9Ly6qe4MvZ/KPnhMUNSs=; b=gX7fnx
	Uh069Wem66fCaVty2vgRtIznNu6XOIvT8IhXOBsMkn0mF59d/Ev4wLPWMLdWySyU
	pXfm9BK+r1VGRoU2JlGHk1EXG3V6wNls78mE5LPmzHhjnRiDHWeyDwMbCEjB3A7y
	4rK5sIC0FatL0NSLoCDcvHLXv2hTKrBW7uum4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wVRR9JFmmOEs4DnYQvBdM20LwwdKmlSW
	P8tXMDfvpIIaYow13QQ70CaJcXp8pmcn9QMwOLV04N+C+k2zsI2ga6i9DeCMMLyA
	P0CeX7RTs2HVKjbTokjp9tm4EmC7lp48WPFqoe6LDezUUOnA+21oATJ9yj5hgxbo
	kWl/yau1c1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F7922D1C;
	Mon, 13 Jun 2016 13:10:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE79B22D1A;
	Mon, 13 Jun 2016 13:10:10 -0400 (EDT)
In-Reply-To: <CAPig+cRfUjpku1Abf=GxrbFeS4txwr=yZsJ7EKo-aWmxYog6Xw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 10 Jun 2016 19:42:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFA6041C-3189-11E6-A4BE-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297235>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I agree with Junio that moving the sigchain_pop() into the error
> handling code-path, if possible, would be a nice improvement.

Yeah, "if possible" is really what I was not sure about---is it safe
to do the _push() thing before start_command(), which presumably
would affect both the main and the forked processes?
