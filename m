Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB481FF6D
	for <e@80x24.org>; Wed, 21 Dec 2016 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbcLUWbu (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 17:31:50 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35655 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753985AbcLUWbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 17:31:49 -0500
Received: by mail-pg0-f49.google.com with SMTP id i5so24835714pgh.2
        for <git@vger.kernel.org>; Wed, 21 Dec 2016 14:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netskope.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LPjAeVxOZ8CjzOWf1rWX0hm7XygURUAdIeNsOglrb5I=;
        b=gsLLBks1J0cpAW1bXNzvYsyD9VNKx1qlwAzIF0lGqkizbAUW7OsqfuNaAZjix7Ixqs
         dWsYVrL7K1eczZR1ryVi+rgB5b6VKr5ZzTiXp/hx8b+gWmpcW6OBWk6+6iKFWIOtfAKM
         QiIafB0X0dxEWLQs+dnW2WcSf1zawk6GjmZB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LPjAeVxOZ8CjzOWf1rWX0hm7XygURUAdIeNsOglrb5I=;
        b=H7lHQpsWJaVFt5d6wAqkFKBgqKfu+Wad94Oc5tVBISymD4Ff3sRRFwWZbpJ/Gs/4Ny
         0pbIicQT7VmewRI9mRnw3QGyKGwQluhI04mhgdGGvdhLx7PGsPEfRJy48PsZwROaZTxo
         o7Zp1T+hTbe+jSLlcJjLLF0cfER0JdYQv84XjMbO06H3kcr72b466xWLNYY2Lc/uGGYc
         lBdD7564ct8NQUTCZ5VMjXd4FBzXQTrGrwAU4Tw/SlPBNQC/103FJenjwwVmjKSTgOaO
         SUgfO48lYq3X1/cXWfX7fXByj/H3qvFW7l/4JbcJHR84CxBzYNJgcGm0z5mMxgjuWkRF
         cy8A==
X-Gm-Message-State: AIkVDXLpjfg88+YQU2VtwnqL1BAw65v6actN+YbcyrBqVRzmO951amQgsdrxFwcqPb3vlbpj
X-Received: by 10.99.161.2 with SMTP id b2mr11683239pgf.2.1482359508270;
        Wed, 21 Dec 2016 14:31:48 -0800 (PST)
Received: from [192.168.65.161] ([216.38.152.90])
        by smtp.gmail.com with ESMTPSA id c71sm49460322pga.22.2016.12.21.14.31.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Dec 2016 14:31:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bug report: Git pull hang occasionally
From:   Kai Zhang <kai@netskope.com>
In-Reply-To: <xmqqshphge7o.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 21 Dec 2016 14:31:44 -0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2F25D8A-5DD5-4C62-8F8D-941AFDD874DC@netskope.com>
References: <9B7DCFB3-73A4-40DE-8FC6-867C5016EF95@netskope.com> <xmqq8tr9huc0.fsf@gitster.mtv.corp.google.com> <xmqqshphge7o.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I will verify it. Thanks.
> On Dec 21, 2016, at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> And the unexpected discrepancy is reported by find_symref() as
>> fatal.  The server side dies, and somehow that fact is lost between
>> the upload-pack process and the client and somebody in the middle
>> (e.g. fastcgi interface or nginx webserver on the server side, or
>> the remote-curl helper on the client side) keeps the "git fetch"
>> process waiting.
>>=20
>> So there seem to be two issues. =20
>>=20
>> - Because of the unlocked read, find_symref() can observe an
>>   inconsistent state.  Perhaps it should be updated not to die but
>>   to retry, expecting that transient inconsistency will go away.
>>=20
>> - A fatal error in upload-pack is not reported back to the client
>>   to cause it exit is an obvious one, and even if we find a way to
>>   make this fatal error in find_symref() not to trigger, fatal
>>   errors in other places in the code can trigger the same symptom.
>=20
> I wonder if the latter is solved by recent patch 296b847c0d
> ("remote-curl: don't hang when a server dies before any output",
> 2016-11-18) on the client side.
>=20
> -- >8 --
> From: David Turner <dturner@twosigma.com>
> Date: Fri, 18 Nov 2016 15:30:49 -0500
> Subject: [PATCH] remote-curl: don't hang when a server dies before any =
output
>=20
> In the event that a HTTP server closes the connection after giving a
> 200 but before giving any packets, we don't want to hang forever
> waiting for a response that will never come.  Instead, we should die
> immediately.
>=20
> One case where this happens is when attempting to fetch a dangling
> object by its object name.  In this case, the server dies before
> sending any data.  Prior to this patch, fetch-pack would wait for
> data from the server, and remote-curl would wait for fetch-pack,
> causing a deadlock.
>=20
> Despite this patch, there is other possible malformed input that could
> cause the same deadlock (e.g. a half-finished pktline, or a pktline =
but
> no trailing flush).  There are a few possible solutions to this:
>=20
> 1. Allowing remote-curl to tell fetch-pack about the EOF (so that
> fetch-pack could know that no more data is coming until it says
> something else).  This is tricky because an out-of-band signal would
> be required, or the http response would have to be re-framed inside
> another layer of pkt-line or something.
>=20
> 2. Make remote-curl understand some of the protocol.  It turns out
> that in addition to understanding pkt-line, it would need to watch for
> ack/nak.  This is somewhat fragile, as information about the protocol
> would end up in two places.  Also, pkt-lines which are already at the
> length limit would need special handling.
>=20
> Both of these solutions would require a fair amount of work, whereas
> this hack is easy and solves at least some of the problem.
>=20
> Still to do: it would be good to give a better error message
> than "fatal: The remote end hung up unexpectedly".
>=20
> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> remote-curl.c               |  8 ++++++++
> t/t5551-http-fetch-smart.sh | 30 ++++++++++++++++++++++++++++++
> 2 files changed, 38 insertions(+)
>=20
> diff --git a/remote-curl.c b/remote-curl.c
> index f14c41f4c0..ee4423659f 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -400,6 +400,7 @@ struct rpc_state {
> 	size_t pos;
> 	int in;
> 	int out;
> +	int any_written;
> 	struct strbuf result;
> 	unsigned gzip_request : 1;
> 	unsigned initial_buffer : 1;
> @@ -456,6 +457,8 @@ static size_t rpc_in(char *ptr, size_t eltsize,
> {
> 	size_t size =3D eltsize * nmemb;
> 	struct rpc_state *rpc =3D buffer_;
> +	if (size)
> +		rpc->any_written =3D 1;
> 	write_or_die(rpc->in, ptr, size);
> 	return size;
> }
> @@ -659,6 +662,8 @@ static int post_rpc(struct rpc_state *rpc)
> 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
> 	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
>=20
> +
> +	rpc->any_written =3D 0;
> 	err =3D run_slot(slot, NULL);
> 	if (err =3D=3D HTTP_REAUTH && !large_request) {
> 		credential_fill(&http_auth);
> @@ -667,6 +672,9 @@ static int post_rpc(struct rpc_state *rpc)
> 	if (err !=3D HTTP_OK)
> 		err =3D -1;
>=20
> +	if (!rpc->any_written)
> +		err =3D -1;
> +
> 	curl_slist_free_all(headers);
> 	free(gzip_body);
> 	return err;
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 1ec5b2747a..43665ab4a8 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -276,6 +276,36 @@ test_expect_success 'large fetch-pack requests =
can be split across POSTs' '
> 	test_line_count =3D 2 posts
> '
>=20
> +test_expect_success 'test allowreachablesha1inwant' '
> +	test_when_finished "rm -rf test_reachable.git" &&
> +	server=3D"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	master_sha=3D$(git -C "$server" rev-parse refs/heads/master) &&
> +	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
> +
> +	git init --bare test_reachable.git &&
> +	git -C test_reachable.git remote add origin =
"$HTTPD_URL/smart/repo.git" &&
> +	git -C test_reachable.git fetch origin "$master_sha"
> +'
> +
> +test_expect_success 'test allowreachablesha1inwant with unreachable' =
'
> +	test_when_finished "rm -rf test_reachable.git; git reset --hard =
$(git rev-parse HEAD)" &&
> +
> +	#create unreachable sha
> +	echo content >file2 &&
> +	git add file2 &&
> +	git commit -m two &&
> +	git push public HEAD:refs/heads/doomed &&
> +	git push public :refs/heads/doomed &&
> +
> +	server=3D"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	master_sha=3D$(git -C "$server" rev-parse refs/heads/master) &&
> +	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
> +
> +	git init --bare test_reachable.git &&
> +	git -C test_reachable.git remote add origin =
"$HTTPD_URL/smart/repo.git" &&
> +	test_must_fail git -C test_reachable.git fetch origin "$(git =
rev-parse HEAD)"
> +'
> +
> test_expect_success EXPENSIVE 'http can handle enormous ref =
negotiation' '
> 	(
> 		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> --=20
> 2.11.0-442-g0c85c54a77
>=20

