From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Wed, 25 Feb 2015 10:04:50 -0800
Message-ID: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
	<CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
	<CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
	<CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:04:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQgKQ-0005Po-H7
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 19:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbBYSEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 13:04:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751479AbbBYSEx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 13:04:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 796593A831;
	Wed, 25 Feb 2015 13:04:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3CDxoKBE5su5lBOTfyiU4Rxs8AU=; b=CUtrnB
	N+5jMZHZ4UMyQJiHaIuQy0ncWgsaX7j+hPg+ESOxFcFUHfHOjGWA3KM9OlvJMtmB
	1opCowYUcBuKkk5EMtN2ucvjWxFFqX20US/7pi5t46saPxee3IOX8VT/BajAadzM
	Htr9ZA5I3tubhc5Hos0FnO/KZiglWglEMq86U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yz4j8VGy/tPRdtMWdCdrBMvg1LvuM2Nq
	VphN7cKHNqn3hirdWarb7YDlipnF6RSyYIyXMSZ0OQuanQpwruCdIks/4gQjcFYO
	RB/hj4roOWXLJhu0vMUKYfYdgSvc22rHSWA4UpIaM6azIN9BIBu8Mpcdhfhz9aSZ
	mUXnCCybtXI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 707BB3A830;
	Wed, 25 Feb 2015 13:04:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9F9A3A82F;
	Wed, 25 Feb 2015 13:04:51 -0500 (EST)
In-Reply-To: <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 25 Feb 2015 19:44:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB8AC820-BD18-11E4-8764-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264397>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 25, 2015 at 6:37 AM, Stefan Beller <sbeller@google.com> wrote:
>> I can understand, that we maybe want to just provide one generic
>> "version 2" of the protocol which is an allrounder not doing bad in
>> all of these aspects, but I can see usecases of having the desire to
>> replace the wire protocol by your own implementation. To do so
>> we could try to offer an API which makes implementing a new
>> protocol somewhat easy. The current state of affairs is not providing
>> this flexibility.
>
> I think we are quite flexible after initial ref advertisement.

Yes, that is exactly where my "I am not convinced" comes from.

> After
> that point the client tells the server its capabilities and the server
> does the same for the client. Only shared features can be used. So if
> you want to add a new micro protocol for mobile, just add "mobile"
> capability to both client and server. A new implementation can support
> no capabililities and it should work fine with C Git (less efficient
> though, of course). And we have freedom to mix capabilities any way we
> want (it's harder to do when you have to follow v2, v2.1, v2.2...)
