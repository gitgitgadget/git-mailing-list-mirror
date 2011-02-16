From: Junio C Hamano <gitster@pobox.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 10:47:33 -0800
Message-ID: <7vtyg3ke9m.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net>
 <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:48:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpmQ5-0003XQ-JJ
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab1BPSrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 13:47:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab1BPSrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 13:47:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2519B4F18;
	Wed, 16 Feb 2011 13:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yz8L3CnOANbwHPkU8reZTVdY074=; b=rO0U9A
	yV/hf+nNQaRfZ0pt4lJitmOvJOgrX2M5Lfj6VcELXoBqxqwZg+0bf+sBX6U4CMGW
	rpI4Bm0YGM/24JYDKub+S9Jwp8jyvZ6Tihvwi/nSKOpC0X7UiINBm0mqIw4il8Wp
	Nhhiu2LzKpYqtwf1GMzn6/Uvv/+l3f2Vm4fO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=berHXyD2lJMz3Stnaln2oc15XwIPFCTB
	iXUjrabZyHmezSPEmc/0P5VCVtPqWAKx7K/m6RfbgNHGU0BlbmDpzBpEF5nT5/sr
	fyN6MffbyxsbCEIEIvsAm4I3ap47SDEnsYF8NZnXXLQUwsciRlbXXOBGK8oEn7p8
	6UQcw/LSMe8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C911E4F16;
	Wed, 16 Feb 2011 13:48:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82D5B4F12; Wed, 16 Feb 2011
 13:48:43 -0500 (EST)
In-Reply-To: <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 16 Feb 2011 09\:52\:23 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6528A1DA-39FD-11E0-A186-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166984>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Feb 16, 2011 at 08:51, Jeff King <peff@peff.net> wrote:
>> I can just as easily run "git add -u", or "git add -p" on top of some
>> changes and then realize afterwards that I actually wanted the previous
>> index state.
>
> I disagree, those are all index manipulation tools, `git commit -a` is not.

"git commmit" is not an index-manipulation tool.  Giving "-a" or pathspec
to the command however is.

Having said that, exactly because "commit" _feels_ more like a
point-of-no-return than a mistaken second "add" to the end user (even
though it is not technically different), I think it is Ok to add a
configuration that makes the command bail out when "-a" is given and there
are changes to the index.  I don't think it is sane to trigger the same
safety when a pathspec is given, though.
