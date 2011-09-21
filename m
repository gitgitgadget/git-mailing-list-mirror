From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-p4 tests: refactor, split out common functions
Date: Tue, 20 Sep 2011 19:35:55 -0700
Message-ID: <7vboue4o6s.fsf@alter.siamese.dyndns.org>
References: <20110918012634.GA4578@arf.padd.com>
 <20110918012713.GA4619@arf.padd.com>
 <7v7h55cyis.fsf@alter.siamese.dyndns.org>
 <20110921012917.GA27256@arf.padd.com>
 <7vfwjq4o96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 04:36:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6CfL-00068q-5y
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 04:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1IUCf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 22:35:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50325 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab1IUCf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 22:35:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F1E26C09;
	Tue, 20 Sep 2011 22:35:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w1qU/F2RFzSfrDc5Hj7zxL6f38E=; b=ha8E6n
	8zeVPGJQeROqtHXgHaABvXWu/GDT2Tj91sLpgwankhQ6at7+QJ5PM5LELFTlkuKh
	9Uo4+GrEzinfBIcEFxAMHMAhV6wkDsn6Pe2882ScCIQryR3iyEqPaWeWneQPSZjq
	+7DP7SkjwUW9WltpVrH0CPWQIa/lQDZOUZFp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTK2bG2+qogyHBjRkTQCfYmge8Ht2xip
	vCPW1HqhqI+AfxIaXjZX+GxW7g/LvIAGhReTDHaYjdlPcC0/P+Cw2VBqaEfYOFMc
	bgtW6U9RoRf+OU2Df3ofIRUsbjf5Oq/oU+f9sNgzQSno8dkhjaHUnC4yTpKDm9Nk
	lYRtKZYg/68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 653856C07;
	Tue, 20 Sep 2011 22:35:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE6536C05; Tue, 20 Sep 2011
 22:35:56 -0400 (EDT)
In-Reply-To: <7vfwjq4o96.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 20 Sep 2011 19:34:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6F4EB29C-E3FA-11E0-9F07-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181812>

Junio C Hamano <gitster@pobox.com> writes:

> Yeah, something like
>
> 	: start
> 	p4d &
>         echo $! >$pidfile

Obviously I should have written:

	: stop
        pid=$(cat "$pidfile")
	while kill -0 $pid
	do
		kill $pid
		sleep 1
	done

Sorry for the noise.

>         : stop
> 	while kill -0 $pidfile
>         do
> 	        kill $pidfile
>                 sleep 1
> 	done
>
>> Finding an unused port is also a pain.
>
> I think the way t55xx series assign LIB_HTTPD_PORT is an acceptable
> compromise.
