From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] reset: rename update_refs to reset_refs
Date: Thu, 29 Aug 2013 10:17:57 -0700
Message-ID: <xmqqy57k5sca.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<e2d48324726825844c209e4ca544b5c20ffeb11b.1377784597.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 19:18:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF5rC-0003WM-R1
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 19:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab3H2RSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 13:18:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab3H2RSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 13:18:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6CF13D527;
	Thu, 29 Aug 2013 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aOjcTtU9Hfgd18aAUBxw6xSkVT0=; b=X+Jle9
	KVbGhznVN0Bb7LtrHGU1LFR+KzOiNFd/4PJL99pJQHxUuzHQ8DKAiuoZmJvy70Yj
	3cD4tgJsachYAfs9SFcsQ4xjxgl9N2ivK4NjAUIADpuSWBeWTF4bgtn8TQvSqFBa
	cDkvCdNdmHhymsXb6lfN+osIa0YrUoWcsAZ3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HugUoPKEVyuoRh2Q8vhP+p1SXwbpGjLf
	hOPRGIboaJKVuTFWcxhLtcCIUXRvx0to65ml9ck+qZBj/U+I0pUHfCphErhaj6Ub
	smF8N4VhYYP0TPxSmPmbfJHwxMVfjgz5wr5Cp4KdXWXVqa53RFd6jRtDJpL2/tru
	9m8JXq/YpRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA4B83D526;
	Thu, 29 Aug 2013 17:17:59 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D8C43D523;
	Thu, 29 Aug 2013 17:17:59 +0000 (UTC)
In-Reply-To: <e2d48324726825844c209e4ca544b5c20ffeb11b.1377784597.git.brad.king@kitware.com>
	(Brad King's message of "Thu, 29 Aug 2013 10:11:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3E7D26A-10CE-11E3-91BF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233288>

Brad King <brad.king@kitware.com> writes:

> Get it out of the way for a future refs.h function.

Readers do not know if "update_refs()" is a good name for that
future refs.h function at this point, so "evict squatter" is not a
very good justification by itself.  I do agree that this static
function is resetting a ref, not doing an arbitrary update, and the
new name is a better match than the old one for what it does, though.

> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  builtin/reset.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index afa6e02..789ee48 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -219,7 +219,7 @@ static const char **parse_args(const char **argv, const char *prefix, const char
>  	return argv[0] ? get_pathspec(prefix, argv) : NULL;
>  }
>  
> -static int update_refs(const char *rev, const unsigned char *sha1)
> +static int reset_refs(const char *rev, const unsigned char *sha1)
>  {
>  	int update_ref_status;
>  	struct strbuf msg = STRBUF_INIT;
> @@ -350,7 +350,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (!pathspec && !unborn) {
>  		/* Any resets without paths update HEAD to the head being
>  		 * switched to, saving the previous head in ORIG_HEAD before. */
> -		update_ref_status = update_refs(rev, sha1);
> +		update_ref_status = reset_refs(rev, sha1);
>  
>  		if (reset_type == HARD && !update_ref_status && !quiet)
>  			print_new_head_line(lookup_commit_reference(sha1));
