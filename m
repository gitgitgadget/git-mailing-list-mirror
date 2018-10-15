Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFFD1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeJOLPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 07:15:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38064 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOLPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 07:15:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so17991266wme.3
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8S8byHykTmOaM1Bx+4kF/vpvC5i4tghur6eeUM/wdpo=;
        b=jyDa4xC4xkn1IXltvKIvOYfkDre4EKYmkTivDAcAJ8nImMv/LdhdyRpYOPJHkIgs1u
         CzWjbQdvF+1fgX88DtX1rPQn6BA9OUxBuVpri5M5HENM55KUhM8h8x4RMlkTO1mO6q+Y
         a0iq2XLcZoSR7CwyWYX9A142PmpXiOfRXF4VF+eU8vEKQjoIsJuRLoZeAr2jG6+NDgr9
         ueMPDya0V8qXBvxQel7cI3GpYSOgwyd0wNTV3l5W2p2GOOkiwG11JKgyZdZAYBJxB5iR
         +5EcCizPNgExEFpX3FiQSa/NcA11W3vqb/xzWAOUZOyD/Qmd019UPIo/dCa1tZDf+rx5
         hcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8S8byHykTmOaM1Bx+4kF/vpvC5i4tghur6eeUM/wdpo=;
        b=eO2ZcySIbsmb3he08XEjtfBu75sn4FbOcXydSGMEPPB0+GCI7LmTIB2MS22wPTZqEE
         IAAdvd7LWKS9tEzMAUWk22u4xveqbytet/Lb0V13Pe5kIFnUJ3u+r5Q5FdcOd+9RkU+O
         F+ykVFc/Qko0JKdKay9d0cuAH7ZIcnQs91S4ef+04OZZG4bXy0SqFTQNUqUHQPIE3YT2
         zYZhxNKykCIEtDmIX2jhqxAalH3VoOAKZGDeJy74RHjxmrD/Ecn8dJh7ImXeeN7ANLM+
         zRCvtIIJ7e04si8ML5vKja5nSlsgJ0++XRGeB8Vv4LsnMGsTCVra7o+Xkm5STZ3RZF5c
         WPHQ==
X-Gm-Message-State: ABuFfojsctPOA1DzNYE8QNV20ytV4MJ+CKvwl4MudTeLJ+WgxVMArZGE
        b/+C5Y9Km/bR0qzrrYNOPOlN5JiSuFs=
X-Google-Smtp-Source: ACcGV62eUzngwkd5eWYjnF9jIwAh565V6Ok2/faWP6HyYmEu7PIV/lTE9tLeubyYTk5T7ryDqRO9jA==
X-Received: by 2002:a1c:b90c:: with SMTP id j12-v6mr12289420wmf.32.1539574300418;
        Sun, 14 Oct 2018 20:31:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 18-v6sm13581412wmw.26.2018.10.14.20.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 20:31:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gpg-interface.c: detect and reject multiple signatures on commits
References: <20181012210928.18033-1-mgorny@gentoo.org>
Date:   Mon, 15 Oct 2018 12:31:38 +0900
In-Reply-To: <20181012210928.18033-1-mgorny@gentoo.org> (=?utf-8?Q?=22Mich?=
 =?utf-8?Q?a=C5=82_G=C3=B3rny=22's?=
        message of "Fri, 12 Oct 2018 23:09:28 +0200")
Message-ID: <xmqqva636g2t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> GnuPG supports creating signatures consisting of multiple signature
> packets.  If such a signature is verified, it outputs all the status
> messages for each signature separately.  However, git currently does not
> account for such scenario and gets terribly confused over getting
> multiple *SIG statuses.
>
> For example, if a malicious party alters a signed commit and appends
> a new untrusted signature, git is going to ignore the original bad
> signature and report untrusted commit instead.  However, %GK and %GS
> format strings may still expand to the data corresponding
> to the original signature, potentially tricking the scripts into
> trusting the malicious commit.
>
> Given that the use of multiple signatures is quite rare, git does not
> support creating them without jumping through a few hoops, and finally
> supporting them properly would require extensive API improvement, it
> seems reasonable to just reject them at the moment.
>
> Signed-off-by: Michał Górny <mgorny@gentoo.org>
> ---
>  gpg-interface.c          | 94 +++++++++++++++++++++++++++-------------
>  t/t7510-signed-commit.sh | 26 +++++++++++
>  2 files changed, 91 insertions(+), 29 deletions(-)
>
> Changes in v3: reworked the whole loop to iterate over lines rather
> than scanning the whole buffer, as requested.  Now it also catches
> duplicate instances of the same status.
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index db17d65f8..480aab4ee 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -75,48 +75,84 @@ void signature_check_clear(struct signature_check *sigc)
>  	FREE_AND_NULL(sigc->key);
>  }
>  
> +/* An exclusive status -- only one of them can appear in output */
> +#define GPG_STATUS_EXCLUSIVE	(1<<0)
> +
>  static struct {
>  	char result;
>  	const char *check;
> +	unsigned int flags;
>  } sigcheck_gpg_status[] = {
> -	{ 'G', "\n[GNUPG:] GOODSIG " },
> -	{ 'B', "\n[GNUPG:] BADSIG " },
> -	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
> -	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
> -	{ 'E', "\n[GNUPG:] ERRSIG "},
> -	{ 'X', "\n[GNUPG:] EXPSIG "},
> -	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
> -	{ 'R', "\n[GNUPG:] REVKEYSIG "},
> +	{ 'G', "GOODSIG ", GPG_STATUS_EXCLUSIVE },
> +	{ 'B', "BADSIG ", GPG_STATUS_EXCLUSIVE },
> +	{ 'U', "TRUST_NEVER", 0 },
> +	{ 'U', "TRUST_UNDEFINED", 0 },
> +	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE },
> +	{ 'X', "EXPSIG ", GPG_STATUS_EXCLUSIVE },
> +	{ 'Y', "EXPKEYSIG ", GPG_STATUS_EXCLUSIVE },
> +	{ 'R', "REVKEYSIG ", GPG_STATUS_EXCLUSIVE },
>  };
>  
>  static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
> +	const char *line, *next;
>  	int i;
> -
> -	/* Iterate over all search strings */
> -	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> -		const char *found, *next;
> -
> -		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
> -			found = strstr(buf, sigcheck_gpg_status[i].check);
> -			if (!found)
> -				continue;
> -			found += strlen(sigcheck_gpg_status[i].check);
> -		}
> -		sigc->result = sigcheck_gpg_status[i].result;
> -		/* The trust messages are not followed by key/signer information */
> -		if (sigc->result != 'U') {
> -			next = strchrnul(found, ' ');
> -			sigc->key = xmemdupz(found, next - found);
> -			/* The ERRSIG message is not followed by signer information */
> -			if (*next && sigc-> result != 'E') {
> -				found = next + 1;
> -				next = strchrnul(found, '\n');
> -				sigc->signer = xmemdupz(found, next - found);
> +	int had_exclusive_status = 0;
> +
> +	/* Iterate over all lines */
> +	for (line = buf; *line; line = strchrnul(line+1, '\n')) {
> +		while (*line == '\n')
> +			line++;
> +		/* Skip lines that don't start with GNUPG status */
> +		if (strncmp(line, "[GNUPG:] ", 9))
> +			continue;
> +		line += 9;

You do not want to count to 9 yourself.  Instead

	if (!skip_prefix(line, "[GNUPG:] ", &line))
		continue;


> +		/* Iterate over all search strings */
> +		for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> +			if (!strncmp(line, sigcheck_gpg_status[i].check,
> +					strlen(sigcheck_gpg_status[i].check))) {
> +				line += strlen(sigcheck_gpg_status[i].check);

Likewise.

> +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE)
> +					had_exclusive_status++;

"has" is fine, but I think existing code elsewhere we use "seen" for
things like this.

> +				sigc->result = sigcheck_gpg_status[i].result;
> +				/* The trust messages are not followed by key/signer information */
> +				if (sigc->result != 'U') {
> +					next = strchrnul(line, ' ');
> +					free(sigc->key);
> +					sigc->key = xmemdupz(line, next - line);
> +					/* The ERRSIG message is not followed by signer information */
> +					if (*next && sigc->result != 'E') {
> +						line = next + 1;
> +						next = strchrnul(line, '\n');
> +						free(sigc->signer);
> +						sigc->signer = xmemdupz(line, next - line);
> +					}
> +				}
> +				break;
>  			}
>  		}
>  	}

So unless U/E, we expect to see a key, and unless E, we also expect
there is a signer; we keep the last value we see in the sequence in
sigc.  Because all of these that are not U are marked exclusive, if
we check if sigc->key already has value at the point you free the
sigc->key field above, we can see if there is a duplicate record
that are of "exclusive" type?  I am not suggesting to lose the
addition of "flags = GPG_STATUS_EXCLUSIVE|0" field, but trying to
see if I am getting the logic right.

For gpg_status that is !GPG_STATUS_EXCLUSIVE (i.e. "U"), we do not
do any replacement of already seen .key/.signer, and all the cases
that we do the replacement are GPG_STATUS_EXCLUSIVE, which we know
will become an error in the code below when we do see twice.  So it
is fine not to check if .key/.signer we see twice are the same or
different.  It is an error even if we see the same .key/.signer
twice---having two records is already wrong no matter whose key/sign
it is.

OK, so the whole thing makes sense to me.

Having said that, if we wanted to short-circuit, I think

                for (each line) {
                        for (each sigcheck_gpg_status[]) {
                                if (not the one on line)
                                        continue;
                                if (sigc->result != 'U') {
                                        if (sigc->key)
                                                goto found_dup;
                                        sigc->key = make a copy;
                                        if (*next && sigc->result != 'E') {
                                                if (sigc->signer)
                                                        goto found_dup;
                                                sigc->signer = make a copy;
                                        }
                                }
                                break;
                        }
                }
                return;

        found_dup:
                sigc->result = 'E';
                FREE_AND_NULL(sigc->signer);
                FREE_AND_NULL(sigc->key);
                return;
		
would also be fine.

> +
> +	/*
> +	 * GOODSIG, BADSIG etc. can occur only once for each signature.
> +	 * Therefore, if we had more than one then we're dealing with multiple
> +	 * signatures.  We don't support them currently, and they're rather
> +	 * hard to create, so something is likely fishy and we should reject
> +	 * them altogether.
> +	 */
> +	if (had_exclusive_status > 1) {
> +		sigc->result = 'E';
> +		/* Clear partial data to avoid confusion */
> +		if (sigc->signer)
> +			FREE_AND_NULL(sigc->signer);
> +		if (sigc->key)
> +			FREE_AND_NULL(sigc->key);

I think it is OK to use FREE_AND_NULL() unconditionally (just like
we can use free(x) on x==NULL).

> +	}
>  }

