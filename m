From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a --stat or --numstat like option that'll allow me to have my cake and eat it too?
Date: Tue, 08 Mar 2016 09:40:46 -0800
Message-ID: <xmqqoaaolvfl.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 18:40:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adLcs-0001HV-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 18:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbcCHRku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2016 12:40:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55178 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750701AbcCHRkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 12:40:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8893F4ABB5;
	Tue,  8 Mar 2016 12:40:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VO461LjuWQJQ
	PhGJ9+4DhoVSRU8=; b=wDr8sOu2WJ/Ilffr+f0UiY1GTv208HyzOwcYXlMtj76j
	OhbNC33fZo4Ts6jOSxfqPgNQBEV2EeOdV/6meG6JayCN3seCyxkq/Ibk6RRGEifk
	JC2UDlwPjVp1g72on/tw2AxHonZEsNEN4aW2JL0lTB3Gyj+1t7a4vfAMQODBNDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cVm2Gb
	5nuDykygJDQXb6VKa9Ggnj6LupqdSBmj7Bink1NBnT6a9f/KRFz6wRz6h9eLgFU4
	HU8rL+TPsK2kojFEryBFEW5ZLkC06rLAXLWo1rnkVYq89gP/vzZIUbSt/FMKjK+l
	vzvjFw2z3S7f8Vb+3nl/kmruXxr6L3JVsAV5E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80EE34ABB4;
	Tue,  8 Mar 2016 12:40:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 042A64ABB0;
	Tue,  8 Mar 2016 12:40:47 -0500 (EST)
In-Reply-To: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 8 Mar
 2016 16:08:21
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E49F4588-E554-11E5-A234-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288442>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What I really want is something for git-log more like
> git-for-each-ref, so I could emit the following info for each file
> being modified delimited by some binary marker:
>
>     - file name before
>     - file name after
>     - is rename?
>     - is binary?
>     - size in bytes before
>     - size it bytes after
>     - removed lines
>     - added lines
>
> I think no combination of git-log options or any built-in machinery
> comes close to giving me all of that without having to do multiple
> passes with some combination of git-log and git-show, but I'd love to
> be proven wrong.

I do not think such a thing exists.  From the look of the above
list, if I were implementing it, I'd think it would be the easiest
if it is built as a new output format of "diff" that sits next to
existing --stat, --patch, and --numstat formats, i.e. you would be
writing a new aevars_stat_consume() callback function and calling
xdi_diff_outf() like everybody else.  A possible output format may
look as if we are showing "log --patch" output with a bit more
extended diff header lines (e.g. in addition to "rename from", etc.,
you would have "bytes before" and other new types of headers), but
without the actual patch text.
