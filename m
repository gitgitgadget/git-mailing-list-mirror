From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pretty: support placeholders %C+ and %C-
Date: Thu, 20 Sep 2012 10:47:57 -0700
Message-ID: <7vehlwbn76.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <7vy5k4bpzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 19:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEkrE-0003KP-D0
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 19:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab2ITRsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Sep 2012 13:48:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753316Ab2ITRr7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Sep 2012 13:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CE26895B;
	Thu, 20 Sep 2012 13:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P3q74xf7bb6o
	8seLmOqoTGVtjqE=; b=rL6pB0w8QzFbiD4ikl3wi9se3L9qoGYDbAywTCKyAGoR
	Co49HrFUGETwg++fI2zs1NOblQ8boOOVxfLX6I8M4AlY7d4R+1clYMKnNJLpQSrb
	xrCb8gNcKIseNWGLc/MvTKPQj147jexygYTrzNWnrCqOCAbdT9jbilA/iYkeFZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aqvmku
	yErkamWXtACiHbtSLDVzms+lCDavOVoNcecsS1Q755P8ICR8tEYQKG2vxHyfThnH
	+3MVdvi8JXtH1yiUVyxualgn43UvPXhWJ+uVkfcnbmhHfbmJRJDVFS+yKiv8G80h
	eVKnyqRN/WS6w4wyaGwSaMiGx8Ysuv73/JrJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39098895A;
	Thu, 20 Sep 2012 13:47:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 935DE8959; Thu, 20 Sep 2012
 13:47:58 -0400 (EDT)
In-Reply-To: <7vy5k4bpzh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Sep 2012 09:47:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50B6AE36-034B-11E2-809D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206062>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> %C+ tells the next specifiers that color is preferred. %C- the
>> opposite. So far only %H, %h and %d support coloring.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/pretty-formats.txt |  2 ++
>>  pretty.c                         | 13 ++++++++++++-
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty=
-formats.txt
>> index e3d8a83..6e287d6 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -142,6 +142,8 @@ The placeholders are:
>>  - '%Cblue': switch color to blue
>>  - '%Creset': reset color
>>  - '%C(...)': color specification, as described in color.branch.* co=
nfig option
>> +- '%C+': enable coloring on the following placeholders if supported
>> +- '%C-': disable coloring on the following placeholders
>
> OK, so typically you replace some format placeholder "%?" in your
> format string with "%C+%?%C-", because you cannot get away with
> replacing it with "%C+%? and other things in the format you do not
> know if they support coloring%C-".
>
> If that is the case, does it really make sense to have %C-?
>
> It smells as if it makes more sense to make _all_ %? placeholder
> reset the effect of %C+ after they are done (even the ones that they
> themselves do not color their own output elements), so that you can
> mechanically replace "%?" with "%C+%?".
>
> I dunno.

Thinking about this a bit more, perhaps we would want a generic
mechanism to give parameters to various %? placeholders. This is not
limited to "I can do color but there is no mechanism for the user to
tell me that I should do color" %H, %h and %d may want to say.  An
obvious and immediate example is that %h might want to be told how
many hexdigits it should use.
