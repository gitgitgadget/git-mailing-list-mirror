From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] test-bzr.sh, test-hg.sh: allow running from any dir
Date: Mon, 11 Nov 2013 10:31:19 -0800
Message-ID: <xmqqsiv2lrig.fsf@gitster.dls.corp.google.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-3-git-send-email-rhansen@bbn.com>
	<5280c108749d8_6841541e787e@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwGw-0005ad-SK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab3KKSbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:31:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181Ab3KKSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:31:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16146501A3;
	Mon, 11 Nov 2013 13:31:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ma6u+c2pBS+Wt+/spXSGkyrRSRE=; b=aZdxQn
	Ss1t2I0qZJVyhGNQPh+wYijHkpgcQ7rxrAdUC9PXX+Z8nDEkmiHQLyBMdosgQjET
	KgsbFpWVlCUZXr7MQ0vQlZAN2GCCSZkIVTUjEgSW+7ngHQqs5rSMivJqKro1t1Hq
	oV8j9M4ScXV7i3sXG8cPQn63iMY3UD49IW5r4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ntffjA8olOVKm2E1+BxDTsypgR0Uic1b
	ERCtlR+lT5htGClPF7zUQJReNe6tDibFVxFsgwId6eeDllnbnFEC4OqQYMi2RwpF
	95ByEQ4gz//nETCJv93W3+M9HNJUXLgRQJqRsHw79r3+VkNG4UJt3ACNxmEYy/da
	UgEDJE+zOio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0681D501A2;
	Mon, 11 Nov 2013 13:31:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BB61501A0;
	Mon, 11 Nov 2013 13:31:21 -0500 (EST)
In-Reply-To: <5280c108749d8_6841541e787e@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 11 Nov 2013 05:35:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 764E4990-4AFF-11E3-82AA-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237628>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Richard Hansen wrote:
>> cd to the t/ subdirectory so that the user doesn't already have to be
>> in the test directory to run these test scripts.
>> 
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  contrib/remote-helpers/test-bzr.sh | 1 +
>>  contrib/remote-helpers/test-hg.sh  | 1 +
>>  2 files changed, 2 insertions(+)
>> 
>> diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
>> index 5c50251..094062c 100755
>> --- a/contrib/remote-helpers/test-bzr.sh
>> +++ b/contrib/remote-helpers/test-bzr.sh
>> @@ -5,6 +5,7 @@
>>  
>>  test_description='Test remote-bzr'
>>  
>> +cd "${0%/*}"/../../t || exit 1
>
> I think this should do the trick:
>
>   test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$(realpath ${0%/*}/../../t)"
>   . "$TEST_DIRECTORY"/test-lib.sh

Can we do that without using realpath(1)? I do not think we use it
anywhere in the main part of the project.
