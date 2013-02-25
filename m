From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Introduce new build variables
 INSTALL_MODE_EXECUTABLE and INSTALL_MODE_DATA.
Date: Sun, 24 Feb 2013 22:54:43 -0800
Message-ID: <7vliac2898.fsf@alter.siamese.dyndns.org>
References: <5109D230.2030101@iam.tj>
 <7vtxpxic5l.fsf@alter.siamese.dyndns.org> <510AA1E7.9070704@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: TJ <git@iam.tj>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 07:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9rxz-0003fy-O0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 07:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab3BYGyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 01:54:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909Ab3BYGyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 01:54:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6915398AC;
	Mon, 25 Feb 2013 01:54:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=bptIEMgmvnPlLsZVfI/XGMaKVvE=; b=L7mZOEn7rzUJMoVptDVc
	2Y6YyV1w5gTjGfTigQirvkMrye55jhyjUkRKj2DlX7FuJK7SLsjvEE5ocqhtEWK5
	ZNEL5HnJeJo8wF6qMROaoIVzR/+LJvv95AlaqBXqzd5V5CElgsdRf4StSzTPi+v5
	WpSPwismkOHnBRpw7hrYdDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ka+IsPQiR4mIBdT31PSkm/3z/8/aSmXpiQNmRJUTtoVymB
	7hJ91T2o3rAoR9dj2WQcf0gGdLZZnxSa5Qyq+cY4auLqu7yDezT7f/sATZlw5r+w
	erp77m716s9H5w7+8EG8cGwION1gZ8RQ3X6hAqqPl0G5BlYJeNSEha0nYitSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0632B98AA;
	Mon, 25 Feb 2013 01:54:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43965987C; Mon, 25 Feb 2013
 01:54:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E84AC2E-7F18-11E2-BE4C-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217041>

TJ <git@iam.tj> writes:

> On 31/01/13 15:51, Junio C Hamano wrote:
>> TJ <git@iam.tj> writes:
>> 
>>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man1dir)
>>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man5dir)
>>> +	$(INSTALL) -d -m $(INSTALL_MODE_EXECUTABLE) $(DESTDIR)$(man7dir)
>>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN1) $(DESTDIR)$(man1dir)
>>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN5) $(DESTDIR)$(man5dir)
>>> +	$(INSTALL) -m $(INSTALL_MODE_DATA) $(DOC_MAN7) $(DESTDIR)$(man7dir)
>> 
>> I'm tempted to suggest
>> 
>>     INSTALL_DIR = $(INSTALL) -d -m 755
>>     INSTALL_DATA = $(INSTALL) -m 644
>>     INSTALL_PROGRAM = $(INSTALL) -m 755
>> 
>> The number of lines the patch needs to touch will be the same, but
>> the resulting lines will not have many $(INSTALL_MODE_BLAH) shouting
>> at us.
>
> I did contemplate that but was concerned it might be seen as interfering unduly with
> the tool name/path settings, as opposed to their options.
>
>> Besides, you would want to differentiate the two kinds of 755 anyway
>> (I'd prefer INSTALL_PROGRAM to use -m 555 personally, for example).
>
> Yes, I think I lost that one in the mists of sed-land when making the changes :)
>
> I'll revise the patch based on received comments and post the revision tomorrow.

Did anything come out of this discussion?
