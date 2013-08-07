From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Build in git-repack
Date: Wed, 07 Aug 2013 08:48:39 -0700
Message-ID: <7v38qlec2w.fsf@alter.siamese.dyndns.org>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com>
	<1375884049-14961-1-git-send-email-stefanbeller@googlemail.com>
	<1375884049-14961-2-git-send-email-stefanbeller@googlemail.com>
	<vpqzjsth8wt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>, pclouds@gmail.com,
	iveqy@iveqy.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 07 17:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V75yl-0002ds-Mv
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 17:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab3HGPsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Aug 2013 11:48:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab3HGPsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Aug 2013 11:48:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CD99369FF;
	Wed,  7 Aug 2013 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HEUwR6GogNx2
	WAyK1pbqQNQnNDI=; b=FStuSuhIDsTmsvoOO7+1Z0EV97x6MPWsgvFzSzZhOTAo
	RGKn31htRty/ZmeJdcBPWqam/HB8BU4wZUAXfJCt98A/J7N0WUQXbubjYixsJB3A
	Wo7o7exZJEvFwYL/oJgooTb+MxxC7TuOO+7TA65rQanUi40/GK0lMJzvx+fOlfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KcZ8dG
	jIAtxsqVVlrZo6qro9u58mo9HFLyTvEM+I0ux9GftAdS46gY2/YcEJgta2Cr5HCb
	0R9ueLjZ0Kbbm/+uWzwWdsQmC8RBXUGWtS5iOKxaQdQoJkooQqLh650O14aLg5RZ
	XtSCfp2HyQQ6AjomAMa8q8A6GuqxVWUBnamGs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C702369F6;
	Wed,  7 Aug 2013 15:48:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12E7D369ED;
	Wed,  7 Aug 2013 15:48:41 +0000 (UTC)
In-Reply-To: <vpqzjsth8wt.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	07 Aug 2013 16:28:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5B24F9E-FF78-11E2-8D00-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231831>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> [ It's cool you're working on this, I'd really like a git-repack in C=
=2E
>   That would fix this
>   http://thread.gmane.org/gmane.comp.version-control.git/226458 ]
>
> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> pack-objects learns a few more options to take over what's been done
>> by git-repack.sh. cmd_repack() becomes a wrapper around
>> cmd_pack_objects().
>
> I think the patch would read easier if these were split into two
> patches: one doing the real stuff in pack-objects, and then getting r=
id
> of git-repack.sh to replace it with a trivial built-in.
>
> Actually, I'm wondering why pack-objects requires so much changes.
> git-repack.sh was already a relatively small wrapper around
> pack-objects, and did not need the new options you add, so why are th=
ey
> needed? In particular adding the new --update-info option that just d=
oes
>
>> +	if (repack_flags & REPACK_UPDATE_INFO)
>> +		update_server_info(0);
>
> seems overkill to me: why don't you just let cmd_repack call
> update_server_info(0)?

My feeling exactly.  I would rather see a patch that does not touch
pack-objects at all, and use run_command() interface to spawn it.
Once we do have to pack, the necessary processing cycle will dwarf
the fork/exec latency anyway, no?
