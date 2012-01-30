From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 11:09:47 -0800
Message-ID: <7vliopatxg.fsf@alter.siamese.dyndns.org>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-5-git-send-email-felipec@infradead.org>
 <20120130175324.GH10618@burratino>
 <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
 <20120130182547.GA22549@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrwby-0001gG-DB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab2A3TJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:09:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab2A3TJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:09:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105467279;
	Mon, 30 Jan 2012 14:09:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l6kG+5hQcd+pIUUHsO3nerAEtHA=; b=c8JSYJ
	sx9G1LAEZ/1HTM1lhwfP8Jyjy/rRzESpbzRqRJUh8F1eTcuEL9yxOHvxhXYuy4hB
	GNvctl3+peNsQpsX4KHgjpFYXubnh2Gg7zk6WnNCKhqdSoDKOSqvQ9axFjXIheWz
	GIjpqXt1rb4DVve26//UOJeBaoecpvkJAVnOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dPJv2mS1Kwz1S7XUxxGrYD9OscniZm5m
	9iwLQOjXzqETRR2Zzs6EY5Meu9ye7BJOZ99oVazHbKOEuMaIzB78T1jARVR2nwbv
	MERSOTFFWfcqfvuS1zmXlz9R345WqKm4aRlXsy89Qk28jAqRF7uiwFC+pLqEuqxQ
	8YlsCDL5GBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0710A7278;
	Mon, 30 Jan 2012 14:09:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F5287277; Mon, 30 Jan 2012
 14:09:48 -0500 (EST)
In-Reply-To: <20120130182547.GA22549@burratino> (Jonathan Nieder's message of
 "Mon, 30 Jan 2012 12:25:47 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA9E6512-4B75-11E1-9937-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189401>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Felipe Contreras wrote:
>
>> The commands might fail, that's why '2> /dev/null' was used before,
>> and ':' is used right now.
>
> Wait, what?
>
> : is a no-op command.  It does not redirect stderr automatically or
> do any other magical thing.

s/no-op/true/ ;-)

> ..., so I suppose consistency is the only reason to
> prefer one over another.

Yes. And the script may probably use [[ very heavily.

Early return after || i.e.

	A || return
        B

simply looks ugly and misleading, especially when the remainder B is just
a single line.  But I stopped caring about the styles in this particular
script long time ago, so...
