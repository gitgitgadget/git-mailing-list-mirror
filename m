From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 07:57:20 -0700
Message-ID: <7v4nqletrj.fsf@alter.siamese.dyndns.org>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpqy5ny22z5.fsf@bauges.imag.fr>
 <20120608160341.Horde.IGByfXwdC4BP0gY9a0fV0PA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 16:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0cx-0006DD-Q7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603Ab2FHO5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 10:57:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab2FHO5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 10:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EAE684E4;
	Fri,  8 Jun 2012 10:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aLNhoDGRmSkW
	7pO2Y4AZ827oSNM=; b=Q918yhImP7nD30ir//ankss55CN6Jh0ChiNZfI+YgxIf
	OKdjis4HOHOFtTJ2CUwj/WQsmRDu6ZPrQYS9u/4dOhmMI1qGNPnERv48Yn0JuKTK
	6wZxtKugC8Eykb4U2gnYhqvgcNGvDoDIBJEZYkgIqwTxz2UGXB2EcCc606ldC9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MWk2y/
	hVPZOv4qFdOcalBNX/rkExZNnaFEYQ8OXZiulefZZBDuOjJv2XO70VghzcwTHXf9
	gtiaNUr/v6Li9q5JyVlsSS8h97/zYm4GOeW+LPoycluiLnLuLyyxSlBakJQE6VRU
	mEGgdP6fWeEq6n42np5HhZL5DT6gXo7txTH+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 664B784E3;
	Fri,  8 Jun 2012 10:57:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE49A84E2; Fri,  8 Jun 2012
 10:57:21 -0400 (EDT)
In-Reply-To: <20120608160341.Horde.IGByfXwdC4BP0gY9a0fV0PA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 16:03:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 402EA4BA-B17A-11E1-9625-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199500>

konglu@minatec.inpg.fr writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:
>
>>>  test -s "$todo" || echo noop >> "$todo"
>>>  test -n "$autosquash" && rearrange_squash "$todo"
>>> +warn_published "$todo"
>>
>> That should be configurable.
>
> Do you mean that it should be controlled by a key config (maybe a new
> advice.*) in the config file ? Or through an option ?

Probably "[rebase] checkremoterefs" in .git/config; advice.*
variables default to true by convention, and it is not suitable for
a misleading "feature" like this one.
