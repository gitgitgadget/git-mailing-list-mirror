From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Sun, 13 Jul 2014 10:10:27 -0700
Message-ID: <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
	<1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 19:10:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6NIP-0007fp-ET
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 19:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbaGMRKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 13:10:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbaGMRKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 13:10:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5BDAC26072;
	Sun, 13 Jul 2014 13:10:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BwF/Xi+rXPg9PI/SpU5YYgkxDxo=; b=c22TaM
	d44EaRbYCXAniDkoyWdedSqJKUcIpkFzEi5G/J3a5qUIJwbudXAVq/pv3Hx4qW5t
	1cEMute/JwjrmIadFpchtbkVLufuxhRnfzRsOMJpVMZZChXM95+YvWp1U8Wy+z2T
	o/oixKe5mSMhzYVXosv+M9ln/1mDv0+E9xawI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oTiNz9xKI2OGXXY30NeEbph3GUhDMyBu
	YnIPu81GFpXE0LERGIrulW7TGqGwQdKW5jKzs70Fx+PapZ1qU+OYrgvZYUKXpA6U
	MPPwMzjaqfYyYEk9o8y0YmrUNrI6Z2G2wS7Hcp+YIW7qJE3onmu+LpMDJMy5DWKC
	zKewl6z9lcI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E85F26070;
	Sun, 13 Jul 2014 13:10:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DCAB526068;
	Sun, 13 Jul 2014 13:10:11 -0400 (EDT)
In-Reply-To: <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 12 Jul 2014 23:29:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8CB4E7CC-0AB0-11E4-AA04-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253451>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Made parse_sort_string take a "var" parameter, and if given will only warn
>> about invalid parameter, instead of error.
>
> This seems unnecessarily ugly since it's hard-coding specialized
> knowledge of the callers' error-reporting requirements into what
> should be a generalized parsing function. If you instead make
> parse_sort_string() responsible only for attempting to parse the
> value, but leave error-reporting to the callers, then this ugliness
> goes away. See below.

Yup, you are absolutely right.  Thanks for catching my silly.
