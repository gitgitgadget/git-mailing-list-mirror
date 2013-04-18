From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 10:28:17 -0700
Message-ID: <7va9ov7npq.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsdJ-0000Tx-B5
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967416Ab3DRR2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:28:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967375Ab3DRR2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:28:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBCCD17383;
	Thu, 18 Apr 2013 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Uvr4EIX5nY6ue6I71GH4TQH8iyo=; b=CNUerCXPiupL0tiYDNL8
	IchawDLp61UmnGOqmJ2P3lbzqiJ8xT/+LXKM8badgr+WXB0E5BOG8pxU8Ya+zoDi
	PQ7MpJM1nAkjKhKQ0FrLHUGO09YAovjgsWbDPM71vMthzBOT+fNp5QIwmyxS0CZK
	a7EZGtcL6ZRyXHWpAZiYt8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=P+2GnPHjXZSeHEMYXghLl4rlMvqLEQAXHDBsQFd95USbaa
	bRPK8Ye8iShly3qiEZbfOf8fTEVwv1X5j1VV8MlZdulj3p1Pur+zJaQ3BB24QbAm
	6nOyI3ahU5L2o0wYCvUFnjNGuuRUEd4YnCZA2Br6oJLZNCzVnU1Aug7cwPTD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3B0B17382;
	Thu, 18 Apr 2013 17:28:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1811A17380;
	Thu, 18 Apr 2013 17:28:19 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C6C010C-A84D-11E2-9C0F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221673>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This has never worked, since it's inception the code simply skips all
> the refs, essentially telling fast-export to do nothing.

Good description.

>
> Let's at least tell the user what's going on.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/gitremote-helpers.txt | 4 ++--
>  t/t5801-remote-helpers.sh           | 6 +++---
>  transport-helper.c                  | 5 +++--
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index ba7240c..4d26e37 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -162,8 +162,8 @@ Miscellaneous capabilities
>  	For remote helpers that implement 'import' or 'export', this capability
>  	allows the refs to be constrained to a private namespace, instead of
>  	writing to refs/heads or refs/remotes directly.
> -	It is recommended that all importers providing the 'import' or 'export'
> -	capabilities use this.
> +	It is recommended that all importers providing the 'import'
> +	capability use this. It's mandatory for 'export'.

As [1/6] said "*:*" does not work and has never worked, and
especially on the push side the patch below makes it clear it was a
glorified no-op, it may be better to say a bit more than "use
this. It's mandatory".  It is not like any value makes sense, right?

Perhaps the documentation will be further updated in a later step in
the series to clarify it.  Let's read on til the end of the series...

> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index cd1873c..3eeb309 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -111,13 +111,13 @@ test_expect_success 'pulling without refspecs' '
>  	compare_refs local2 HEAD server HEAD
>  '
>  
> -test_expect_failure 'pushing without refspecs' '
> +test_expect_success 'pushing without refspecs' '
>  	test_when_finished "(cd local2 && git reset --hard origin)" &&
>  	(cd local2 &&
>  	echo content >>file &&
>  	git commit -a -m ten &&
> -	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
> -	compare_refs local2 HEAD server HEAD
> +	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2> ../error) &&
> +	grep "remote-helper doesn.t support push; refspec needed" error
>  '

I somehow like this change that turns a _failure into a _success by
expecting test_must_fail, especially because it is clear why the
tested "push" should fail when you look at the rest of the patch ;-)

Fun.

> diff --git a/transport-helper.c b/transport-helper.c
> index cea787c..4d98567 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
>  	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
>  	struct strbuf buf = STRBUF_INIT;
>  
> +	if (!data->refspecs)
> +		die("remote-helper doesn't support push; refspec needed");
> +
>  	helper = get_helper(transport);
>  
>  	write_constant(helper->in, "export\n");
> @@ -795,8 +798,6 @@ static int push_refs_with_export(struct transport *transport,
>  		char *private;
>  		unsigned char sha1[20];
>  
> -		if (!data->refspecs)
> -			continue;
>  		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
>  		if (private && !get_sha1(private, sha1)) {
>  			strbuf_addf(&buf, "^%s", private);
