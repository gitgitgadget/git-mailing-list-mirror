From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is the default refspec for fetch?
Date: Sun, 09 Nov 2014 09:23:58 -0800
Message-ID: <xmqq7fz4e18x.fsf@gitster.dls.corp.google.com>
References: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
	<20141108105221.GA20750@peff.net> <545E2A2D.2040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:24:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWDg-0008Sa-JU
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbaKIRYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 12:24:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751793AbaKIRYB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 12:24:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBFAB1A9DF;
	Sun,  9 Nov 2014 12:23:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d0APDCzcS6Wa
	8MXK2suqSCAmMCA=; b=rEQVxPYAN4JEwFE1sNtCBA7G2AOKkbtLPuSdRiu46U0L
	2Gv26U/ZlHlReWxIqq62G2kOW/CjwhQot7Eb0TpMb67gZZmR40ahvfNnbOggO2WQ
	k4OYyyOfb7wLAfDLtNrTC2HeXqbRB3ApE3xYYFF8SsOd+QJ7DrRIG5mL4Uemisk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l3vsQI
	pyPBfTJCtNqC80ouyqu3HgXtzg/v2Id4X5YVNwOf+sZm/zhri63NTuOl++MCruVs
	2r66XXxw9gJBeNUei1fnsAWjgOhRbhGn/YYGRtOZc1Lf/WyTzDF+1TfGrsALz57f
	ungR+kGoqUAp7hx1dCkffi2Z5VVGMRfNpuZeE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2C061A9DE;
	Sun,  9 Nov 2014 12:23:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54CFC1A9DC;
	Sun,  9 Nov 2014 12:23:59 -0500 (EST)
In-Reply-To: <545E2A2D.2040205@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Sat,
	08 Nov 2014 15:35:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 310EEC6E-6835-11E4-9CD8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 2014-11-08 11:52, Jeff King pisze:
>> On Fri, Nov 07, 2014 at 04:31:08PM +0100, Christian Halstrick wrote:
>>
>>> In a repo where no remote.<name>.fetch config parameter is set what
>>> should a "git fetch" do? My experiments let me think it's
>>> "HEAD:FETCH_HEAD". Right?
>>
>> Basically, yes. We always write FETCH_HEAD, regardless of the refspe=
c.
>> We choose "HEAD" if no other refspec was provided. So it is really m=
ore
>> like
>>
>>    git fetch $remote HEAD
>>
>> This is what makes one-off bare-url pulls work, like:
>>
>>    git pull git://...
>>
>> It runs fetch under the hood, which writes into FETCH_HEAD, and then=
 we
>> merge that.
>
> Actually FETCH_HEAD consists of multiple lines, one per ref...
> but only top ref is merged.

Incorrect in that "only top" is misinformation, and irrelevant in
the context of discussing the "what is fetched in a one-off fetch".
