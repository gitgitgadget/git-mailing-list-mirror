From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 18:57:16 -0700
Message-ID: <7v1uuq51c3.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
 <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
 <CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
 <7vsjn73q6j.fsf@alter.siamese.dyndns.org>
 <CAG+J_DxXcvF3tBPkf7ZEtiXvEK80zYJvP1rNx-PagM8TV-1KSA@mail.gmail.com>
 <7v62k253ad.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz++SG28a=DhZ+Doz1np21jMavYpc0hKfe1rgq-dHZLPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 04:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBdGb-00027e-1R
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 04:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1JFB5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 21:57:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab1JFB5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 21:57:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DFDD5DDA;
	Wed,  5 Oct 2011 21:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BfedplAysv4J
	LbQpwRl5llwMn6M=; b=wP0+XwK2iyw6GjII3cUX/imrZQ9VrqfwS8yF0p3CPLSk
	hVnALDsoxemFvxZ7X2uPOWfuFtkOarTMBcWxvIUQUuBLWII9W8czn2IEQ7K7JvK3
	M7N0KQvETHeLK4n3c6cQ0sGWK9z/QTvjVYRd9Jx9+eK8PbFIp5h9Q2GJHvfGW+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aLaH6O
	YiiZtYgdZ4bOBrf0GIGC08C/PiN2pA0+Rzg0ovaEjso6c2SDK1svoQHo9UkKjqC6
	wNIbw1x9HVxgcsasYd6T19jyBYWBZINI7IGbRl8QqhNkfrYkl/T9T/Bwp0PuLgxw
	+MMxL2qROdD1Z6DfB61LxRm8wdlbOD+14eevo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B365DD9;
	Wed,  5 Oct 2011 21:57:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA4985DD7; Wed,  5 Oct 2011
 21:57:17 -0400 (EDT)
In-Reply-To: <CAG+J_Dz++SG28a=DhZ+Doz1np21jMavYpc0hKfe1rgq-dHZLPA@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 21:38:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85430010-EFBE-11E0-8F3D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182916>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>>> So you're envisioning this?
>>>
>>> =C2=A0 $ git commit foo.c
>>> =C2=A0 Warning, master is also checked out in workdir2
>>
>> No. I would rather think it needs to be forced.
>
> Now they do what? Either commit --force or create a new branch?
> Wouldn't it have been better to create the new branch before they
> started editing?

If they are going to commit, and if they knew that they are going to
commit, yes.

But why do you want to forbid people from just checking things out if t=
hey
are not interested in committing? That is where I think you are going
backwards.

> I guess it depends what you mostly use your workdirs for. For me, it'=
s
> to have different branches checked out, not to have the same branch
> checked out in multiple locations.

Then you wouldn't have any problem if commit refused to make commit on =
the
branch that is checked out elsewhere, no?

I am not saying we should never have an option to _warn_ checking out t=
he
same branch in multiple places. I am saying it is wrong to forbid doing=
 so
by default.
