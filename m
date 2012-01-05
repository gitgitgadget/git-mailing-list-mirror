From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not fetch tags on new shallow clones
Date: Wed, 04 Jan 2012 21:57:19 -0800
Message-ID: <7vfwfuofnk.fsf@alter.siamese.dyndns.org>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
 <7vwr97nho7.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvL2ebziPw=0q-e=G3WFEvEKtFR2xMFMiquSyrHJDradA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 05 06:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RigKa-0007QS-1Y
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 06:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab2AEF5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 00:57:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab2AEF5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 00:57:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7825D78DD;
	Thu,  5 Jan 2012 00:57:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7FVR5mVRd2ks
	fnTuOWCfRtwYpNw=; b=uG/zJyx+LKFg/QmPMXiqp7HQNkeuzYw02lBI6sw7/xtm
	lNViOCs/rz/mNOn4BRfB6xlrqLYUizrhGhqSN0vNa2JgwLRv+uf0vfJvsu2nUD5f
	jeKjmudP9bH6gwLpwXCih6ga+NP4nrst4i9gPR3RFqzADK5g9BX39LIOxynVE14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X8HF3d
	FCH8Ytsp0cS7XJMhZ6qs4oGDc3fq7ru2WKumO1W1ucS/vUK8XIZLp2qIfoWpxUVL
	zAPUdhhjU8Y5w6Db7ygKNF00jyxA6uCbUktrnhCb8MXOkI3P0qpcJ+86y+tm/ERZ
	lktOaPdA+CYEbIQglxvu/Heu2tkby68MgWSeg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EBC178DC;
	Thu,  5 Jan 2012 00:57:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0221D78DB; Thu,  5 Jan 2012
 00:57:20 -0500 (EST)
In-Reply-To: <CAJo=hJvL2ebziPw=0q-e=G3WFEvEKtFR2xMFMiquSyrHJDradA@mail.gmail.com> (Shawn
 Pearce's message of "Wed, 4 Jan 2012 19:05:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21BD306A-3762-11E1-B4BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187965>

Shawn Pearce <spearce@spearce.org> writes:

> 2012/1/4 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>>  We should also fetch tags that reference to downloaded objects.
>>
>> I do not think this has much merit.
>
> I disagree. ...

No, you don't.  Because...

> ... Its useful because cloning a branch immediately after it
> has been tagged for a release should have `git describe` provide back
> the name of the release from the tag (assuming of course no new
> commits were made since the tag).

=2E.. this is a natural extension of ...

>> It also is my understanding that the shallow hack is almost always u=
sed
>> with a depth of one, not a range, like "git archive | tar xf -", so =
if
>> anything, I would say a single-branch cloning has much higher priori=
ty
>> than following tags.
>
> I think I agree with you on priority of work effort. ...

=2E.. this thing, once you have a "single ref only" stuff working.  Aft=
er
Linus announces that he released 3.2, you would do the poor emulation o=
f
"git archive | tar xf -" with something like:

    git clone --single=3Dv3.2 --shallow $there linux-3.2

and your "git describe" should fall out as a natural consequence out of
everything else, without the usual "tag following" semantics, no?
