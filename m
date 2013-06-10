From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: make mingw_signal return the correct handler
Date: Mon, 10 Jun 2013 13:50:31 -0700
Message-ID: <7v8v2hg06g.fsf@alter.siamese.dyndns.org>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<51AEE1C3.9020507@viscovery.net>
	<20130605071206.GC14427@sigill.intra.peff.net>
	<51B02D81.3000700@viscovery.net>
	<20130606063754.GA20050@sigill.intra.peff.net>
	<CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
	<20130606064409.GA20334@sigill.intra.peff.net>
	<7vy5anyx1w.fsf@alter.siamese.dyndns.org>
	<20130606174032.GB32174@sigill.intra.peff.net>
	<CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
	<51B1B4DF.90705@viscovery.net>
	<CABPQNSYE=Mvrmc44dZmKnB14KLh4A=HxWo2-xgnJRyj1Q+BJLg@mail.gmail.com>
	<51B1CFD4.3030908@viscovery.net>
	<CABPQNSasTdkmpeGWb7_wZK2cQhiOyF7bX5ObcBg5kHm0KBGS5w@mail.gmail.com>
	<51B1DB2A.2060306@viscovery.net>
	<CABPQNSa1-dna_b+q-U6jgYy7p6zeiT7dAwu1Mw47QAezSNYKqA@mail.gmail.com>
	<51B568A1.9090409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 22:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um92z-0004af-V8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 22:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab3FJUue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 16:50:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab3FJUud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 16:50:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AF5726DFE;
	Mon, 10 Jun 2013 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=BU+OBv
	TDfaboB5O7ZJ+6rLQ3wA/ZFMsfaVDpw2luDB84XBTMc4kdPufw3F4heJ30QVleIl
	sPyRMQxjxfoy0i4ycB2fV9CIoW9XNiWTTAzDRRNMK4TgrbZve0uqGFfyjAUKYpfu
	ECUT12pzBxRnnF+uzGV9t2B6KTmmwAQ7C8a7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u0ZrOHZq5cGI52YN5q9NhCzZOxaBw3MW
	Qp6JMYAX281gDIaNYzKF1B3NS4P7uhDdnh2c4Se0vslc+joRJUjzAGVdjcThQJCZ
	+YZWVmZhdBg2B1pQnfceI4gswVMQ79604OApgy9+i5+cwtqC+C6/YsWDYLjbJo0l
	Z10yUqSdozU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 012C326DFC;
	Mon, 10 Jun 2013 20:50:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 766A226DFB;
	Mon, 10 Jun 2013 20:50:32 +0000 (UTC)
In-Reply-To: <51B568A1.9090409@viscovery.net> (Johannes Sixt's message of
	"Mon, 10 Jun 2013 07:48:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6460BB64-D20F-11E2-B019-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227377>

Thanks.
