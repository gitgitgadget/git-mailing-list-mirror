From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method
 support
Date: Fri, 12 Feb 2010 13:44:48 -0800
Message-ID: <7vljeyp1rj.fsf@alter.siamese.dyndns.org>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3K8-0004De-Ux
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab0BLVpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:45:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0BLVpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:45:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EF659744A;
	Fri, 12 Feb 2010 16:45:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pkhBmczKAu6eiUotkS8j2HIhtTk=; b=FKfTTGLL/FHbk9D92euj7mu
	+gF6FeTirdnbQgkag1N+izYWfRacxE73t/pIJX0c9xUSht7AxMGNUls3wXkuX8Nu
	p4iT5haop5mm8Tp9oVGCWWzoqKvxtZe9ib+CdE8auvJxSWlc0Udn5uC5As5ZYomp
	GTCayi8dGJfhS4NCfHAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SWyDXb1DFPnaKxtcoaaDOiIt/PxX7u6xJTnG4HHYgWH2jvPTW
	z6xFqyfO4NyfJ4yIEKdMz8kQYt2kTAVo3m18NJzC38h/k4r5diXnCegTFjz9bkhi
	63/4GWFxfSaGS5tySK7Wky8dzdAmibxI5GlaN/8UJ/PAFrLT7ZJ//w4LvY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCB7197438;
	Fri, 12 Feb 2010 16:44:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 232149742C; Fri, 12 Feb
 2010 16:44:49 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DDBA41C2-181F-11DF-8FD8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139750>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

> This patch makes git-imap-send CRAM-MD5 authenticate method ready.
> In theory, CRAM-MD5 authenticate method doesn't depend on SSL.
> But for easiness of maintainance, this patch uses base64 and md5 stuffs of OpenSSL.
> So if you want to use CRAM-MD5 authenticate method,
> you have to build git-imap-send with OpenSSL library.
>
> ---
> v3: Erik noticed that there were some garbage lines in this patch.
> I removed these. And 2/2 wasn't changed, I'm sending 1/2 only.
>
> v4: Based on Junio's indication, I cleaned up some points of imap-send.c .
>
> Cc: Erik Faye-Lund <kusmabite@googlemail.com>
> Cc: Jakub Narebski <jnareb@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> ---

I actually meant that the comment regarding the history of patch
iterations should go after the three-dash.  Most notably, we want your
S-o-b in the commit log.  That is:

----------------------------------------------------------------
	Subject: well thought out summary of what the patch is about

	Problem description, and rationale to justify the particular
        solution you chose.

        Signed-off-by: Your Name <your@address.example.com>
	---

	 Comments that may help the reviewers while the patch is
         going through the review cycle, but would not be useful
         after this particular version is applied and the commit
         is shown in "git log" output

	 diffstat

         diff --git ... patch text ...
----------------------------------------------------------------

> +
> +	/* challenge must be shorter than challenge_64
> +	 * because we are decoding base64*/

Just a style thing but

	/*
         * We prefer to write our multi-line
         * comments like this.
         */

> +	challenge = xcalloc(strlen(challenge_64) + 1, sizeof(char));

Why not xmalloc()?  Does EVP_DecodeBlock() want a zero-filled buffer?

> +	EVP_DecodeBlock((unsigned char *)challenge, (unsigned char *)challenge_64, strlen(challenge_64));

Does EVP_DecodeBlock diagnose an error in the input and return an error
code?  How are you supposed to protect yourself from the server giving you
a corrupt challenge that does not decode properly?

By the way, this is probably easier to the eye if you split it into two
lines:

	EVP_DecodeBlock((unsigned char *)challenge,
			(unsigned char *)challenge_64, strlen(challenge_64));

> +	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
> +	HMAC_Update(&hmac, (unsigned char *)challenge, strlen(challenge));
> +	HMAC_Final(&hmac, hash, NULL);

Is there any clean-up necessary after you are done with hmac?  EVP_md5()
returns a pointer to EVP_MD but how and when is that resource released?

By the way, HMAC_Init() seems to be deprecated and kept only for 0.9.6b
compatibility.

    http://www.openssl.org/docs/crypto/hmac.html

> +	hex[32] = 0;
> +	for (i = 0; i < 16; i++) {
> +		hex[2 * i] = hexchar((hash[i] >> 4) & 0xf);
> +		hex[2 * i + 1] = hexchar(hash[i] & 0xf);
> +	}
> +
> +	/* length: "<user> <digest in hex>" */
> +	resp_len = strlen(user) + 1 + strlen(hex) + 1;
> +	response = xcalloc(resp_len, sizeof(char));
> +	snprintf(response, resp_len, "%s %s", user, hex);
> +
> +	response_64 = xcalloc(ENCODED_SIZE(resp_len), sizeof(char));

Why not xmalloc()?  Does EVP_EncodeBlock() want a zero-filled buffer?

> +	EVP_EncodeBlock((unsigned char *)response_64, (unsigned char *)response, strlen(response));

I wouldn't worry too much about error response from this function as I
would for EVP_DecodeBlock() I mentioned earlier.

By the way, I made a couple of small fix-ups to your [2/2] (I think they
were just style and unnecessary use of xcalloc()) and queued.

Thanks.
