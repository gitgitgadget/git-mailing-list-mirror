From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 82/83] environment: add set_index_file()
Date: Tue, 03 May 2016 08:36:24 -0700
Message-ID: <xmqqh9efp30n.fsf@gitster.mtv.corp.google.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
	<1461505189-16234-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 17:36:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axcNL-0007Dd-S5
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933543AbcECPg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 11:36:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933212AbcECPg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 11:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 993F416CFB;
	Tue,  3 May 2016 11:36:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BmuorawBl7Bpy5W4jG4j+IlY8C0=; b=PSxV2S
	NN8XmGhdzqpFDLxH269Z5OCwbKIcSnwizKulMQj+N65s+Eq300AVcnjIl+8FH+rj
	Onhdh+oWBfaipbEfl+HSZBCfQs3BgQLSG2OrBYCOtKmhhyQ3OFg1PY7F3jWb+bqJ
	blLN8LSMw+xKw2L1sBBhuol1MDkF96JJS/zeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSg7TydgYbwgRI1R52lj1pDQMpnm1r1q
	bYP68M1Zy/+vpD2rl59wWLk7S5cqPJvpRCDaOGTaruvIuVf0uOcwC6/UF2qRLiPI
	d8UXewJcGzbBfOuiJs5pp8XCj/e1DeKSmv4YNseUqfTYPoavwB2hbPhxAnJY3StS
	Q9OvorEl3KA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 90BA016CFA;
	Tue,  3 May 2016 11:36:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB47016CF9;
	Tue,  3 May 2016 11:36:25 -0400 (EDT)
In-Reply-To: <1461505189-16234-3-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:39:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC061B16-1144-11E6-9506-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293402>

Christian Couder <christian.couder@gmail.com> writes:

> +void set_index_file(char *index_file)
> +{
> +	git_index_file = index_file;
> +}

What's the rationale for this change, and more importantly, the
ownership rule for the string?  When you call this function, does
the caller still own that piece of memory?  When you call this
twice, where does the old value go and who is responsible for
taking care of not leaking it?

Cannot guess any of the above with no proposed log message (that
comment applies most of your patches in this series).
