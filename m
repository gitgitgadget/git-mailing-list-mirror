From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 11:57:35 -0800
Message-ID: <7v390carf4.fsf@alter.siamese.dyndns.org>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-4-git-send-email-hordp@cisco.com>
 <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com>
 <50A2DCD7.4050909@cisco.com> <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
 <50A3A040.7040304@cisco.com> <7vfw4caxkh.fsf@alter.siamese.dyndns.org>
 <50A3ED8A.9080604@cisco.com> <7v7gpoasf4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:57:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYj5x-0002aM-3t
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab2KNT5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:57:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932405Ab2KNT5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:57:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A43EE9A7D;
	Wed, 14 Nov 2012 14:57:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GMkRhmNavrJtahAfweTbZJL0Ki8=; b=r7m26s
	kiF4tpZFN1k61hC0r/KvGwXAa+DQmA5Phhw1lt8YLkr0lUt7I473z4vQV08Ppa/e
	LehTBDacki04iqzdcZBFoyps3ZJ8I+LB6DxENcYkQagsugTu/Sgmgzj9zLqokRdk
	cbHGkL42SNJfgxE6ayzHgwleZpvm/cc+ew/y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UPeJTPIkPbncGF94TlV1BFeNVfaIVQNx
	8hvkNUhrBB2Xdm9ge0u3XUmQ/Hr35xuGbIF65K2P6EACoBsCZGLRYCSCnm3zdpdC
	5DONy8gqLV4P65MZpuE+lkzdyp1VRNG43QDPXAteb2NQn80ur2bTtT1tcF3oag/P
	EHg6WfN00uQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 900F19A7C;
	Wed, 14 Nov 2012 14:57:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3A259A7A; Wed, 14 Nov 2012
 14:57:41 -0500 (EST)
In-Reply-To: <7v7gpoasf4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Nov 2012 11:35:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CAD9740-2E95-11E2-86F1-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209747>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <hordp@cisco.com> writes:
>
>>   # tokens and short-status
>>   $ git status --tree --short  
>>   ## changed-files
>>    M foo.txt
>
> Hrm, how will the existing readers of the output avoid getting
> confused by this overloading of "##", which has meant the current
> branch information?

That was a stupid question.

Existing readers do not know to give --tree to the command, so they
are perfectly OK.

It is however not OK for new readers that wants to read these
tree-wide state and also branch information.
