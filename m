From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 15:46:03 -0700
Message-ID: <7vhb5rv7x0.fsf@alter.siamese.dyndns.org>
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
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 00:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqYay-00068C-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 00:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1HHWqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 18:46:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab1HHWqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 18:46:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 091D65FBF;
	Mon,  8 Aug 2011 18:46:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ogudnQJcwAnk8tGUIrqsa5kxM4g=; b=K1ljxp
	lA6LAQP0U9kcZoKFPzilgHr7gRF2Ch3CWJkwbHH2kMAo9XiVunxTOweTDzNgYue7
	UY2cw8xQFQ5jZMV6qvXijD19MVN286a7QW2KO2oWHkbb51XqJ9IuorR2eyKJn8Kq
	EQ6J9FNcF39fcZdLTQPBagN+qpmo8SKt+viNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tNN01JfmLlkhBgN4sG+mKfWa7ZMg4PGL
	IsIVdPVerFXU+L6hjPfE4snRnJMrUpfJ6yy+UTnwrEd9m3QOgdfwWC73AdOaLoC5
	Jj2ujqNi9pghMkHywO5D3PO0I8uQ4F+pU5CSIdGWZIMSgv+pzSzAQxu/zJroSjMZ
	9NrfwrY0cvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7F25FBE;
	Mon,  8 Aug 2011 18:46:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 662215FBB; Mon,  8 Aug 2011
 18:46:05 -0400 (EDT)
In-Reply-To: <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 9 Aug 2011 00:38:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33233358-C210-11E0-B63C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178999>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Aug 9, 2011 at 00:36, Junio C Hamano <gitster@pobox.com> wrote:
>> It is in this thread; <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
>
> Then I don't understand why you're mentioning it in reference to a
> problem someone is actually having?

What?

Why isn't it a real problem when I have it in the currently released code,
and why is it a real problem if you have it with your wip series that uses
the current code?  Both are real problems that somebody is actually
having.
