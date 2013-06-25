From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/5] Reroll patches against v1.8.3.1
Date: Tue, 25 Jun 2013 12:28:02 -0700
Message-ID: <7vppva2dod.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<cover.1372149305.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 21:28:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrYuS-0001V2-Qt
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 21:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3FYT2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 15:28:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41960 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab3FYT2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 15:28:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB98A29F33;
	Tue, 25 Jun 2013 19:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aeCwvQ21dQ/7LLn8LzA8+XeI4C4=; b=ntUily7DljruDWJ6GrJO
	KJnttr+0hf3GXdH/v2lpum2rfrd9u5zkrFkw9/fibpuoQKU0nBUdahCunI1SbB14
	nDsGp4epOAICjD4QEFoRaNbrznfkjrd+pONflCSjOiyZd09hI9lHM4tlbhyLqkHj
	2PDhzahURXlu3UKVp74xpDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MjppVDQFH6cJh4zDeVrSigGvD2Fliy3Z2roiee6XF+Hi8g
	8QxXpMal13/tR63spnPCQuH7MQM3XfAqYDVhWnXvm9pUoA79DYY7SdWRRHcsxZpt
	b+eiuMJx2PJ01AvIUblLI0d6fr3pczVb7gh+h0tDZU0ui2g0KPw2NXZqYFjfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0ADB29F31;
	Tue, 25 Jun 2013 19:28:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32DDE29F2D;
	Tue, 25 Jun 2013 19:28:04 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B2BF440-DDCD-11E2-B578-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228985>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> 4. [PATCH v6 4/5] pretty: Add failing tests: --format output should honor logOutputEncoding
> 	iso8859-5 encoding reverted back to cp1251 encoding (as it was in v4 series)

Thanks for a reroll, but why this change?

The reason I asked you to avoid 8859-5 is because our test do not
use that encoding and I do not want to add new dependency to people
when they run test.  cp1251 shares exactly the same issue, doesn't
it?  So in that sense, this change does not make anything better.

That is why I asked you if the breakage you are trying to
demonstrate about non-ASCII non-UTF8 encoding was specific to
Cyrillic/Russian.  I do not recall seeing your answer, but what is
the right thing to do depend on it.

 - If the answer is yes, then we would need to add dependency either
   way, and 8859-5 is just as fine as cp1251.

 - If the breakage is not specific to Cyrillic, it should be
   reproducible using 8859-1 (latin-1), and our tests already depend
   on 8859-1, so we wouldn't be adding new dependencies on people.
