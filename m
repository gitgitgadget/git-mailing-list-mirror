From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently  processed
Date: Tue, 18 Jun 2013 09:32:19 -0700
Message-ID: <7v61xb752k.fsf@alter.siamese.dyndns.org>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<7vy5a8d1my.fsf@alter.siamese.dyndns.org>
	<2dc2004fbf61d625515c2b6f62cc104e@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoypX-0007rr-Ug
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933464Ab3FRQcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 12:32:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933158Ab3FRQcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 12:32:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E556292D1;
	Tue, 18 Jun 2013 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/en+2ZeGHIYE
	g44So9l0QpAl1Fo=; b=I1Y8rC3LJxTq+xQ9tq2Xcs2Y2aqeG1sF0cen/Pdwv8xu
	wWeMPQIpXcRzqkmOTyX9+y2b0NY+noJ368YYRJXn4ttAKgBmf4bRe7aSjXdokLnF
	P1eycmVC0rxq0mzBpCK6w87GtmiVpRB1BPnpmS+LcrlntQh3qDqRF4OFgBXFHH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IuGGgW
	N9zdvXRG9B3XwQPQrSiA8/sgOrIx1lnHcTpN5uSts+03UfpdmMD48kJ8+wnB30pt
	G3uAhMXDwIf/nW3rw8eKdqONWkXeJRzX+hwBRLWtrb7MaCzjbmb8UyvhwAXclZ4d
	U5Uxi0L8GpHK0aNZ/s6aU7RNMXtI5s2W3qZNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91549292D0;
	Tue, 18 Jun 2013 16:32:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B6C0292CE;
	Tue, 18 Jun 2013 16:32:20 +0000 (UTC)
In-Reply-To: <2dc2004fbf61d625515c2b6f62cc104e@ensibm.imag.fr> ("Mathieu
	=?utf-8?Q?Li=C3=A9nard--Mayor=22's?= message of "Tue, 18 Jun 2013 12:12:22
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6110D68-D834-11E2-8071-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228265>

Mathieu Li=C3=A9nard--Mayor <mathieu.lienard--mayor@ensimag.fr> writes:

> Le 2013-06-17 20:37, Junio C Hamano a =C3=A9crit=C2=A0:
> ...
>> Extend wt_status_state structure to hold the necessary info, query
>> the state from the filesystem in that function, and display the info
>> (but not collect info) in show_rebase_in_progress(), to keep the
>> clean division of labor between these two places.
>
> Do you mean that we should include the stopped_SHA in wt_status_state=
 ?

That would be a good first step.  In the longer term, we would want
other external interfaces that read from wt-status-state, pick bits
necessary and summarize them for particular use cases.  You can for
example easily imagine the prompt support that collects different
pieces of breadcrumbs from .git/ can instead ask wt-status-state for
necessary pieces information.

Separating the logic to collect state information and the code to
show the result of collection is necessary for that kind of usage.
