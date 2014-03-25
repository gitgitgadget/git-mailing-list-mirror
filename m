From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] log: add --show-linear-break to help see non-linear history
Date: Tue, 25 Mar 2014 15:30:43 -0700
Message-ID: <xmqqr45pkj1o.fsf@gitster.dls.corp.google.com>
References: <1395294254-941-1-git-send-email-pclouds@gmail.com>
	<1395753807-23228-1-git-send-email-pclouds@gmail.com>
	<1395753807-23228-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 23:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSZrx-00064X-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 23:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaCYWat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 18:30:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189AbaCYWas convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 18:30:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DFA877F7E;
	Tue, 25 Mar 2014 18:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OWZC5nhhJQf1
	Xylrc2G3IkQjVj0=; b=i0UVaG7EHQVOTxe9ToVe40mbUntu13XiP6oGSHN8GDSO
	Vsry4W3cOlEiF76JzJU744zaQ5XllfRYaYOqiNGsimz868rC83N2OoTFECql8vBR
	MIre4jG/0Tufi83LzY1y8/FNgddBy9RE41Ci3PeSvWmIZpVYj7CwwPv1WcuMM3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CYntUU
	IZdx6rQ6hFpO0NBNPlfYQyWExRQhRe1BCh2u4FgxiW3AAKUc7jznj+u4X+81ewbX
	yU/GriLOGmjHdpy88rjTVc310qAto1LxXGJRViRuRHfjvX/2HELDZ0qZrd9Pvu4D
	bM1Yv5hkXBOLvuDpEb8x3rs7E4VuAdjLeo5NU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B49977F7B;
	Tue, 25 Mar 2014 18:30:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA13577F78;
	Tue, 25 Mar 2014 18:30:46 -0400 (EDT)
In-Reply-To: <1395753807-23228-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 25
 Mar 2014 20:23:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C18A36C-B46D-11E3-B76F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245157>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Option explanation is in rev-list-options.txt. The interaction with -=
z
> is left undecided.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Mar 21, 2014 at 2:15 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>  >>  * Get rid of saved_linear, use another flag in struct object ins=
tead
>  >
>  > I cannot offhand say if I like this change or not.  A flag bit is =
a
>  > scarce and limited resource; commit slabs felt more suited for
>  > implementation of corner case eye-candies.
>
>  I leave it in bit 26. We can move it out when we run low on flag bit=
s.
>
>  >>  * Fix not showing the break bar after a root commit if the dag g=
raph
>  >>    has multiple roots
>  >
>  > I definitely do not like the way a commit-list data structure is
>  > abused to hold a phoney element that points at a NULL with its ite=
m
>  > pointer.  Allocate a single bit in revs that says "I haven't done
>  > anything yet" if you want to catch the "first-ness" without breaki=
ng
>  > what commit_list_insert() and friends are expecting to see---they
>  > never expect to see a NULL asked to be on the list, AFAIK.
>
>  Fixed.
>
>  >>  * Make it work with --graph (although I don't really see the poi=
nt of
>  >>    using both at the same time)
>  >
>  > I do not see the point, either.  I vaguely recall that the previou=
s
>  > iteration refused the combination at the option parser level, whic=
h
>  > I think would be the right thing to do.
>
>  Fixed.

All changes look good to me.

Especially on the last one because the new "printf()" calls do not
even attempt to call into the graph API to tell it that it created
a gutter above or give it a chance to draw all vertical lines to
connect the graph part.

Will replace and advance them to "Will merge to 'next'" state.

Thanks.
