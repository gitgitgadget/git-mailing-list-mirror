From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv12 06/10] receive-pack.c: negotiate atomic push support
Date: Thu, 08 Jan 2015 15:51:23 -0800
Message-ID: <xmqq7fwwesqs.fsf@gitster.dls.corp.google.com>
References: <1420687404-13997-1-git-send-email-sbeller@google.com>
	<1420687404-13997-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
	mhagger@alum.mit.edu, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 00:52:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Mrn-0008Ht-Rn
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 00:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbAHXv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 18:51:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbbAHXv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 18:51:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE1812E121;
	Thu,  8 Jan 2015 18:51:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HeMAF/IFPPPLgnV9dpByk95DznM=; b=l2BJ3S
	Eo8J6YUuATf5VyQ+fDZR0P4/YZrhbk7jFWSHYQERdQfzLnR4/vqIotwA8WYthFV7
	fEtuqo+QNhBkEwJgLl2DY/blGXLVUFT/SpDHGox5+J74Z7YsW5TltFhJbstlJwhB
	blU1wUgC0hTa6ZDLfc91ifnIlRo/yONbMTP0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNoWofYTfQRHSsQ5iAzHVprlOxRlBXOV
	7LT4+Tf2Bm1NOTaIUM/8tCZLJrSYvSCalGz9nl1FC7CVjlugCok1+ydSkBpUZNg/
	x4rxDELc/Hi0Sy182DE1ld8kYkLNqicK31yk7nZ8RITi0kT1RrflwxDVmhJSBjfh
	QtryQOd7SlI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A31172E120;
	Thu,  8 Jan 2015 18:51:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1210C2E11D;
	Thu,  8 Jan 2015 18:51:25 -0500 (EST)
In-Reply-To: <1420687404-13997-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 7 Jan 2015 19:23:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 416AA7B6-9791-11E4-B08E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262226>

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds the atomic protocol option to allow
> receive-pack to inform the client that it has
> atomic push capability.
>
> This commit makes the functionality introduced
> in the previous commits go live for the serving
> side. The changes in documentation reflect the
> protocol capabilities of the server.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     v10, v11, v12:
>     * no changes
>     
>     v9:
>      This was once part of "[PATCH 1/7] receive-pack.c:
>      add protocol support to negotiate atomic-push"
>      but now it only touches the receive-pack.c part
>      and doesn't bother with the send-pack part any more.
>      That is done in a later patch, when send-pack actually
>      learns all the things it needs to know about the
>      atomic push option.
>     
>      We can configure the remote if it wants to advertise
>      atomicity!
>     
>     All previous notes were lost due to my glorious
>     capability to operate git rebase.

The list archive remembers if you really care ;-)

I ran out of time and concentration for today to read it through at
this step; among things I saw, nothing looked wrong so far, and at
this step everything looks ready to be tested almost.

Looking good.

>
>  Documentation/technical/protocol-capabilities.txt | 13 +++++++++++--
>  builtin/receive-pack.c                            | 11 +++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
> index 6d5424c..4f8a7bf 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -18,8 +18,9 @@ was sent.  Server MUST NOT ignore capabilities that client requested
>  and server advertised.  As a consequence of these rules, server MUST
>  NOT advertise capabilities it does not understand.
>  
> -The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
> -are sent and recognized by the receive-pack (push to server) process.
> +The 'atomic', 'report-status', 'delete-refs', 'quiet', and 'push-cert'
> +capabilities are sent and recognized by the receive-pack (push to server)
> +process.
>  
>  The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
>  by both upload-pack and receive-pack protocols.  The 'agent' capability
> @@ -244,6 +245,14 @@ respond with the 'quiet' capability to suppress server-side progress
>  reporting if the local progress reporting is also being suppressed
>  (e.g., via `push -q`, or if stderr does not go to a tty).
>  
> +atomic
> +------
> +
> +If the server sends the 'atomic' capability it is capable of accepting
> +atomic pushes. If the pushing client requests this capability, the server
> +will update the refs in one atomic transaction. Either all refs are
> +updated or none.
> +
>  allow-tip-sha1-in-want
>  ----------------------
>  
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 362d33f..4c069c5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -37,6 +37,7 @@ static int receive_fsck_objects = -1;
>  static int transfer_fsck_objects = -1;
>  static int receive_unpack_limit = -1;
>  static int transfer_unpack_limit = -1;
> +static int advertise_atomic_push = 1;
>  static int unpack_limit = 100;
>  static int report_status;
>  static int use_sideband;
> @@ -159,6 +160,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (strcmp(var, "receive.advertiseatomic") == 0) {
> +		advertise_atomic_push = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	return git_default_config(var, value, cb);
>  }
>  
> @@ -174,6 +180,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  
>  		strbuf_addstr(&cap,
>  			      "report-status delete-refs side-band-64k quiet");
> +		if (advertise_atomic_push)
> +			strbuf_addstr(&cap, " atomic");
>  		if (prefer_ofs_delta)
>  			strbuf_addstr(&cap, " ofs-delta");
>  		if (push_cert_nonce)
> @@ -1263,6 +1271,9 @@ static struct command *read_head_info(struct sha1_array *shallow)
>  				use_sideband = LARGE_PACKET_MAX;
>  			if (parse_feature_request(feature_list, "quiet"))
>  				quiet = 1;
> +			if (advertise_atomic_push
> +			    && parse_feature_request(feature_list, "atomic"))
> +				use_atomic = 1;
>  		}
>  
>  		if (!strcmp(line, "push-cert")) {
