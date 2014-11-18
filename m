From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 12:55:29 -0800
Message-ID: <xmqqioicut32.fsf@gitster.dls.corp.google.com>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	<CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
	<1416334360.27401.10.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpoR-000448-0s
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbaKRUzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:55:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932224AbaKRUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:55:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71B201F4BA;
	Tue, 18 Nov 2014 15:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nB7cZkg1x8RUWe4nYwhwP7Zbnn0=; b=vdG2Oo
	ZlC/dHuzrWOKgug13C1NJ5L3luOBHrMfb/Grn5Ytm8hwzosVCw6cf1Sb7amc1VEh
	8x5Bk54P7D5uJ/Zf0Q7fYGZP3It7h1PBYowXQiMR0QnXedTyPyXm5+FoqfnPMCAq
	umBFfBX9V2EG+k+KRaa5FeFRRCfHBaoYnFo8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gQzB3Np7VS9Csj/25Puk059edM1MqNaT
	rgpOeucN7001ceyjZTyF0wfbfdFVcsV3GSyZUomBNPdHw1S2z0bhsyn/Ym4xRr0G
	zc9GvuRz2FoE2WxVFMkYwwK724kPJk9Zq15kvxZgjH2zmpoROEE8m+/WIr/WFFM4
	JNQuWPn33xU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 697071F4B9;
	Tue, 18 Nov 2014 15:55:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 185E01F4B7;
	Tue, 18 Nov 2014 15:55:32 -0500 (EST)
In-Reply-To: <1416334360.27401.10.camel@leckie> (David Turner's message of
	"Tue, 18 Nov 2014 13:12:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C3F3076-6F65-11E4-BE55-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twopensource.com> writes:

> On Tue, 2014-11-18 at 17:48 +0700, Duy Nguyen wrote:
>> > My patches are not the world's most beautiful, but they do work.  I
>> > think some improvement might be possible by keeping info about tracked
>> > files in the index, and only storing the tree of ignored and untracked
>> > files separately.  But I have not thought this through fully.  In any
>> > case, making use of shared memory for the fs_cache (as some of your
>> > other patches do for the index) would definitely save time.
>> 
>> By the way, what happened to your sse optimization in refs.c? I see
>> it's reverted but I didn't follow closely to know why. 
>
> I don't know why either -- it works just fine.  There was a bug, but I
> fixed it.  Junio?

I vaguely recall that the reason why we dropped it was because it
was too much code churn in an area that was being worked on in
parallel, but you may need to go back to the list archive for
details.
