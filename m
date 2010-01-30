From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Fri, 29 Jan 2010 19:41:14 -0800
Message-ID: <7vockc45ut.fsf@alter.siamese.dyndns.org>
References: <20100129012350.GD20488@spearce.org>
 <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com>
 <20100129183705.GB22101@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 04:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb4GD-0003HG-LI
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0A3Dl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756192Ab0A3Dl3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:41:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab0A3Dl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:41:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC947957E8;
	Fri, 29 Jan 2010 22:41:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Doy9E485I+XjuxYAWMoYfhAZ0XY=; b=kJRGZ/
	BoeognP1ff7coLhmy/xLGygFBQtMQXL9wBenVw8iLRymZOodmqeVYRVN+avlPJJR
	wFxwErqRENl8JWeZo1MJzH/zOTHSTbgK54d7YunB7eCiz/Zx+YBGba+YTUpdhvA2
	YcJvavNC1ONLakVmeA0pAF0/DqdNiid6Q0910=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aGOCmcU+GvxmumQtUtCPauQRUIHjdhkU
	Fn3qIf3Bb95EbgHjpsbFwXjxUIUvRvUYHdVhU50hpGL5YM8jM1oH/wtp+ZnbATw8
	xi20QCPeUh6CdMcPUIMJumxmdCun0pEzcDs8KyDIt8jHSEm5bgDe/u6WI4vR+VNt
	IAydlu/Cv/U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A53F957E7;
	Fri, 29 Jan 2010 22:41:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7978C957E5; Fri, 29 Jan
 2010 22:41:16 -0500 (EST)
In-Reply-To: <20100129183705.GB22101@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 29 Jan 2010 10\:37\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55A30C0C-0D51-11DF-A560-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138436>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Fri, Jan 29, 2010 at 02:23, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > index 60d0aa2..8114f93 100644
>> 
>> Looks like you based it off an old version of fast-import, at least
>> not on what is in master atm, since that has my fast-import series.
>> Rebasing shouldn't be too hard, you'll just have to move the option
>> parsing to the appropriate function.
>
> I was intentionally slating this for maint, to fix a bug a user
> reported when handling large streams.

I personally see that as adding a new feature (especially with new option
and config).

> But yea... I guess I also owe Junio a rebased form for master so
> he has less merge conflicts to resolve.

Thanks.
