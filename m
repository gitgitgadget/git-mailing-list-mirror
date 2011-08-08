From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 15:36:30 -0700
Message-ID: <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
 <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:36:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYR4-0002Z9-6t
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab1HHWgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:36:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab1HHWgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:36:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 776635E40;
	Mon,  8 Aug 2011 18:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwql4cXQK1BCpX9td/Flp0eiF1I=; b=mahlYK
	YoqRDMEUhSxX1ZQKvegGUmUxUu1G3SraIhkxOfzFHuxEi5XH2Mznx9TcHXVSRk9L
	JTKu2WuwK2h3hcWxBsQn9gOhE0x66AoEVxwS9hQd/xDEo1Ug3XS7fxCfKxYrefs3
	Fl4aiceQH8MEXKsKjYlfpUfuUufCxkuUwigwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYdx24lgKO9QPKpAtvOE1i5myqlBcmKu
	cCB4r1kvlaPwGXqoT/nNeqtP2+7jUx4jHquBLOd8alHaDVsFVrCPefp1cHGz2ttA
	0BHOvlFP9bGFhnrQwVHgbuLMND0fbu0QwZlca949ir2DpxjDYyJOUxOFT7IfXfvT
	BKMp2hKoNOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D96F5E3F;
	Mon,  8 Aug 2011 18:36:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB2805E3D; Mon,  8 Aug 2011
 18:36:31 -0400 (EDT)
In-Reply-To: <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 9 Aug 2011 00:30:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD4E733A-C20E-11E0-9754-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178997>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Aug 9, 2011 at 00:07, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>> Nobody needs the stuff you mentioned right now.
>>
>> Wrong.
>>
>> "diff ^C A B" is a bug, isn't it? And that is a bug in the current code.
>
> I think I missed something, can you point me to the relevant thread
> about this bug in diff? Maybe I can convince the people involved in
> fixing that to help out.

It is in this thread; <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
