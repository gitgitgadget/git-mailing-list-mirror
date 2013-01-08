From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Tue, 08 Jan 2013 15:42:06 -0800
Message-ID: <7vmwwjb5td.fsf@alter.siamese.dyndns.org>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin> <20130108141650.GA18637@lanh>
 <50EC543D.5090100@web.de> <7v4nirfu1p.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=h04QAeb0D-PWvT=0n_+QfW27NuUg3KEFUN3C4MOJVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:42:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsiol-0006iY-71
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 00:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173Ab3AHXmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 18:42:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756937Ab3AHXmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 18:42:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F61B006;
	Tue,  8 Jan 2013 18:42:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lDQbmebvk50SR6cQFqxWGepHxKw=; b=hresGE
	LknioaP6T+MVg29cnp//NqR2SfaWwKCX39B2YA9Q8TzPVxkXbFcHnUROkDZgD1Fk
	3XHRhZF4qYREaYs2DPHpduIs7LgywEymGF6yEArodUiz2Rf2rHiMp5Qgfg8/gqSH
	hbxS54agIoKJ7CwyMhy8R9GW+VtEmT/uoXKg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+OBmW+zG/ur8WEXLaWeCdvIkyYP039Q
	wvm5wzC2fLbP4+5XP/NJ5oAnn9lZUkjU5u8GajLxsUditH1UC9nLo/7WhTWjYbKv
	I4hQ0Q5UPnrjysmMPWAQiofIMnxCWW57tBRCBqyjR/ct71DR+nKWzzUgyFX1bjDq
	ESYCLiAkFmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C517B005;
	Tue,  8 Jan 2013 18:42:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BE81B004; Tue,  8 Jan 2013
 18:42:08 -0500 (EST)
In-Reply-To: <CACsJy8B=h04QAeb0D-PWvT=0n_+QfW27NuUg3KEFUN3C4MOJVQ@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 9 Jan 2013 06:34:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03DC496A-59ED-11E2-AA4F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213017>

Duy Nguyen <pclouds@gmail.com> writes:

>> After all, Jonathan's suggestion to forbid it was because the
>> combination does not make sense and does not have practical uses,
>> and forbidding it would make the command easier to explain than
>> leaving it accepted from the command line.  If you choose to go in
>> the opposite direction and make "clone --bare --separate-git-dir" do
>> something useful, it should be explained very well in the
>> documentation part of the patch why such a combination is a good
>> idea, and in what situation the behaviour is useful and the user may
>> want to consider using it, I think.
>
> It is more like postponing the usefulness evaluation of the
> combination until later (maybe someone will come up with an actual use
> case). As of now, --separate-git-dir --bare is a valid combination.
> Jens' patch fixes one case but leave the other case broken, which is
> why I think it should be in one patch. It's rather ducking head in the
> sand than actually declaring that the combination is useful.

When a user comes and asks how "git clone --bare --separate-git-dir"
is meant to be used, you are saying that your answer will be "Eh, it
does something random that I cannot explain, and I cannot even
suggest a good use case for it, but somebody may find it useful."?

If we get rid of it, we do not have to explain what such a useless
combination would/should do, no?
