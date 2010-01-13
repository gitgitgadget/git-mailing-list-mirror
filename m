From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: -L should show empty files
Date: Tue, 12 Jan 2010 22:56:10 -0800
Message-ID: <7vpr5esdbp.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
 <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org>
 <fabb9a1e1001121327s392f7311t2a7f11081ed70ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9b-00010g-J0
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952Ab0AMG42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754953Ab0AMG41
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab0AMG40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E91819002E;
	Wed, 13 Jan 2010 01:56:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=XwPxJoZcsCkpvLCoqpR5t9hLX+s=; b=GQsyJWU+7eJcBSguqn37Akv
	o0jolcqMnCK4G5iFv/QwIBUhW6qOzhZUUJLUFvi7CZHIoyt6oCxGHPaxQQZfhar7
	fv8SqtT4wFRyvIOXxR2J0kURmbCIDEE8BtNSktpfSspNVu782OcwDv98+wQyR3Pi
	QYCoLAneqmQmEqTNjQZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=D5vdFUX2tHxHDMr4npIqnO6s1sHLblnHrvd8Z0ZCg2OsFqKmm
	7OpivQ9tKN4T8hpLjOhmAGfHHpEc7oSAdUrBRsyrUjoNxsUZtPE0uvJBXCWcmW8q
	a+ALuuGqqYvtYxlwqitKa6k619rZVyJKTPcErklc8SgltHLpA2buQ5+CZ8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82AB490027;
	Wed, 13 Jan 2010 01:56:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C4439001E; Wed, 13 Jan
 2010 01:56:11 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C096EDEC-0010-11DF-9B93-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136780>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Tue, Jan 12, 2010 at 09:32, Junio C Hamano <gitster@pobox.com> wrote:
>> This optimization doesn't matter too much in practice (a tracked empty
>> file must be rare, or there is something wrong with your project);
>
> How about python projects, where there's an __init__.py file
> everywhere you turn your head? ;)

It's Ok as the price we pay for producing correct result is to open those
empty files, read them, and look for matches which we will never find ;-)
