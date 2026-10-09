Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058D36A361
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791580579; cv=none; b=M6waZDQR3nrZmXeSFIC74Gu1UcSyP/iAQ8vruB3naeMQRcgVOeHPhdrx12GuGlK/uf3aBAG9TXEP7BxxoBnPEPwgzmBZfvIMLbiTiSp29mztd9GjZFsTTgkcfjnHE2+lbAiKy0dXhFLy3/NZhIts7bVdBvF5W1tL96J6AljHyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791580579; c=relaxed/simple;
	bh=RxHOy4oXAYzhbVlD2UdtnjYHxsAzzYwJPokVG23j6xM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBwC32PhvZkHcyCubnFBC4FEy4dPY2EfJqs4nwJRDoDsp/qyh02k4BB9pgEU2TsBWMZKEpWppg2a9wLtLCiFAnp0Xi9IMAvvdF3oSklFkxt5PotlyHINO7JipcsYQCmUFhUiD1KYVaEFM2bfyCX8XEZFLFgsbyxUULUFiD/c89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UzFyFlVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0ohiKXI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UzFyFlVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0ohiKXI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30CC07A00EF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 17:16:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 17:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791580574; x=1791666974; bh=mhpQrJEvue
	Bg7oW+FZvai9roXK7p24H4OElb+kI3SWA=; b=UzFyFlVg1+SlVNGzEMnttss2tt
	KIPanGSvoyVqw1MTsN6kKVy7l1vBZjHEftHW8aphXLBUHgrwgXtIGvHXsO47T/Sq
	B9m7zoI1urODsoFhbF0NrqorPiT06KO26Gn27mdgLLLa3hHTDKEbUd6hRM0TEMMH
	oDZ3VvSwTPCMiy+Bm5zaV34KP3afdAJzS3xuVOY+/lbRTMu8M4YM0rZayj7PPMS/
	NgVjuRrI1YRC1zt42WGjLOOjItkv1q73TczxS8XjupjZCYCcWnqHkiJlTQwnT+Vr
	TtMbYsDH7cXM1aDxGAS8GY6rjR5GlgVN0jM83RNIKE/TYtQ34SIwFskA5v7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791580574; x=1791666974; bh=mhpQrJEvueBg7oW+FZvai9roXK7p24H4OEl
	b+kI3SWA=; b=v0ohiKXIgicPRYrF9VXWPtdWd2dJ3TB8/R7ChcBgmrpc/9zoBzT
	Iphp0Dg7wbLE1coh3AcDs0c8XAk6ILvF8e4AJnydUXVjwL+rcIFBmRFqu0S8JHLA
	TT89phpbwBSAboRw+cWBRiwFTGxUUE1JNb4PfIOgTxYSvMQjF6bjo6ZQ8cKK7/27
	WGp+84qPXhahkA9vzjO/O+JrOXpseYPBi5rGP3zq0taV/JbqCZTj85x/oWrkovjY
	oEyUXOjmqw5G4/sRxcDP/LqlllV5QYzpn+9jRbc3H/yRrLGBzfRkgGHfS6rQxMFA
	Z4wT7iYjJ4tY+bnxv6P6CiO73UQPRzZLhcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791580574; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Lt814RzpwsD5VZ/54KqradGI4AClR+uSvBKvJVavjx8Bg0T
	C6pmOWqbh/ulqi2E/9LJ0EqPmurLYJ35v8cHvLukwTghh3+Nj02TF/1J6dPt+wcb
	9Gz7N0Q96kqRF2SXhx5vWzgHV+YpGRYfah9Bc5tLvlijgIQPVKfrPtbbsfOfHtTf
	cFW7FXrNr9cCdCnWRQzpsetrdepsFdruUEFS128Zlh74ijr3llEeR1sPElsQ3VkT
	ktrR2W7eNkSTxxXy98mYVNh6rNM6Xo1dhe0rpRqmEzDsczMSlclAIsqbwQZHh6kK
	exoBk5CxlbV74dAJH1yYx445avweI+PtY9dqplw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iprSV1o3EnAhMKQ/S6X5rSCTt0g7+zjTOm+1+XImYKo=:RxHOy4oXAYzhbVlD2UdtnjYHxsAzzYwJPokVG23j6xM=;
X-ME-Sender: <xms:nlnJashpFsu7fce-mJe5FGXbc9kKowGmkU96t054PleHMx05GoN80g>
    <xme:nlnJasB6I_MxlL_PNDKOCKn76tEF2HhyFmnrhQ9W-X3Se4sNwkgkyldcuxmow1DLE
    0TpgN0el-7-KRz_-VrBkUswYfAAlV7IvO_F0DlxO09W8S_K3mn9qXY>
X-ME-Received: <xmr:nlnJapHRTX1VogwSuAlv6SkH4l82FkxN7oDbwMikeGdXazzWahbTojZk32Svnv3tcI-OqqWGehowmFvZYj7PlBPcX3qatluHU_Rk>
X-ME-Proxy-Cause: dmFkZTGm6lft28kWzN/EVFXIGuRw7uBsTMvn3tyl0qLqtYWQbLaiqfosyzILjnjUmyA29f
    T4G8dBifYFNC/5IO1tX8k1hYVnCQuFiyWB83y/Q9cNuhPOrhJAPIOr36DTmkTRFDgletl9
    Z6VS+yunq6b5zDqsBARxe73SuKEjGlpJEwvs1EkcXUz0SdGIQkpRozdv++KTUMEyk1wbbg
    7nYRhm+WapntkRexvamF+XSvUQqqs/QW4FztK14QBCnT8Xrlx1NvPiJMrG+52s0KiTIY/W
    ejufsA/SGVSi/TaX1w2OrQRmUs1OJSbwToeYDa8PANTi2UehDFyIZ0dAyEePiCtfEZ9til
    bsCOK56WiU3ffUELFg4ZHGodZO5Y2dkZzzSggvCWo4O+3krYJaS/CO3mX+irdbFRm/rtqe
    aVeYvrmwXMfoiMHzVIJmE6jibyhgh5ekJiVZdOfMP2CLxH2/BsQDgCRB2rPjv1491eKPQ+
    djI1937r+hNSPvRrjnrC9yUqN71KRLHdI/n+vJAUSIzL+lZZDkGbc4/fczscZaoUm7NLiW
    56rWblAw54iVI3MPq2WKqB623fq7A0SHlweAcCLV7qTaLCiyBcsE0vnWTgO1wU8XAnmHtt
    eqi7ClniAeLCehTnWbyHkKu28GwjSFhr/ZYeH5JLyxtM6aoVm4AsCGmKUl3g
X-ME-Proxy: <xmx:nlnJasKONg3Slo47jliimMZgFBPxlxpgrv681iTc-TwzjpoLaAKEqQ>
    <xmx:nlnJallKlii_CFzWjcvMQBsjP2sOSZPnTdAITbgMmfBWumNgFvxP9A>
    <xmx:nlnJasTra1VEk_UT1xxw2K3YT5IwOzXkxAEnSh2q4U4s3iP3HT74tQ>
    <xmx:nlnJavKNYC2fB419XbLG-wy7TBShziEF11NNIDYM0CqQytGysX3ANw>
    <xmx:nlnJauelt0jfAn6CPyON97pBcZkK6ryzXKGvk2ofDwWNC0m3YI5HiOH6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 17:16:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Marc Becker <becm@gmx.de>
Subject: Re: [PATCH] wincred: fix line split of secret blob content
In-Reply-To: <pull.2251.git.1791553518774.gitgitgadget@gmail.com> (Marc Becker
	via GitGitGadget's message of "Fri, 09 Oct 2026 13:45:18 +0000")
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 14:16:12 -0700
Message-ID: <xmqq1p9ymv6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Marc Becker <becm@gmx.de>
>
> operate on immutable blob data (wcsncpy_s still had invalid target size)
> split on newline character to avoid bleed-over on multi-line content

This needs a bit more work to make it more readable than a bulleted
list of lowercase fragments.

When in doubt, keep in mind that the usual way to compose a log
message of this project is to:

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

 - It mentions wcsncpy_s having an invalid target size, but does not
   explain why it was invalid or the consequences. Is the issue that
   wcsncpy_s expects the buffer size in wide characters, but was
   being passed a size in bytes, which obviously cannot always
   agree?

 - It mentions "bleed-over on multi-line content", but does not
   describe the observable symptoms.  Is the issue that when the
   password is empty, the skipping by wcstok_s delimiter would cause
   the oauth_refresh_token line to be erroneously parsed as the
   password?

 - The final sentence should be an imperative command to the
   codebase, e.g., "Parse the blob in-place without copying and
   split lines manually using wmemchr()."

>
> Signed-off-by: Marc Becker <becm@gmx.de>
> ---
>     wincred: fix line split of secret blob content
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2251
>
>  .../wincred/git-credential-wincred.c          | 86 ++++++++++++-------
>  1 file changed, 55 insertions(+), 31 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index 22eb27ca31..584f457774 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -6,6 +6,7 @@
>  #include <stdio.h>
>  #include <io.h>
>  #include <fcntl.h>
> +#include <wchar.h>
>  #include <wincred.h>
>  
>  /* common helpers */
> @@ -148,51 +149,74 @@ static void get_credential(void)
>  {
>  	CREDENTIALW **creds;
>  	DWORD num_creds;
> -	int i;
> -	CREDENTIAL_ATTRIBUTEW *attr;
> -	WCHAR *secret;
> -	WCHAR *line;
> -	WCHAR *remaining_lines;
> -	WCHAR *part;
> -	WCHAR *remaining_parts;
>  
>  	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
>  		return;
>  
> -	/* search for the first credential that matches username */
> -	for (i = 0; i < num_creds; ++i)
> +	/* search for the first credential that matches target and username */
> +	for (int i = 0; i < num_creds; ++i) {
>  		if (match_cred(creds[i], 0)) {
> -			write_item("username", creds[i]->UserName,
> -				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
> -			if (creds[i]->CredentialBlobSize > 0) {
> -				secret = xmalloc(creds[i]->CredentialBlobSize + sizeof(WCHAR));
> -				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
> -				line = wcstok_s(secret, L"\r\n", &remaining_lines);
> -				write_item("password", line, line ? wcslen(line) : 0);
> -				while(line != NULL) {
> -					part = wcstok_s(line, L"=", &remaining_parts);
> -					if (!wcscmp(part, L"oauth_refresh_token")) {
> -						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
> -					}
> -					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
> -				}
> -				free(secret);

The original was already bad, but this makes it even worse to have
the code nested too deeply.  Would separating out the body of the
for loop into a separate helper function, or perhaps standard tricks
like this

	for (...) {
		if (!match_cred(...))
			continue;
		... rest of the loop dedented by one tab stop ...
	}

make it readable?

> +			LPCWSTR username = creds[i]->UserName;
> +			LPCWSTR blob = (LPCWSTR)creds[i]->CredentialBlob;
> +			LPCWSTR end;
> +			DWORD wlen;
> +
> +			write_item("username", username, username ? wcslen(username) : 0);
> +
> +			wlen = creds[i]->CredentialBlobSize / sizeof(WCHAR);
> +
> +			// check if content is single line

			/* our single line comment should look like this */

> +			if ((end = wmemchr(blob, '\n', wlen)) == NULL) {

I do not do Windows and I do not often deal with wchar_t, so I do
not know how much practitioners of code like this one cares, but
would it be better to make the fact clear that we are not dealing
with a regular 'char' by writing a wchar_t literal like this as
L'\n'?  This is not a correctness suggestion, but a readability one.
Having a function prototype would coerse the parameter types, so
you may end up passing L'\n' either way.

> +				write_item("password", blob, wlen);
>  			} else {
> -				write_item("password",
> -						(LPCWSTR)creds[i]->CredentialBlob,
> -						creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +				DWORD length = end++ - blob;

Here, "end" is of LPCWSTR type, aka "wchar_t *".  So is "blob".  The
difference would give us how many wide characters are in there.
That is not necessarily number of bytes starting at &blob[0].

> +				// correct remaining size and drop carriage return at line end
> +				wlen -= length + 1;
> +				if (length && blob[length - 1] == '\r') {

This CR is also side, right?

> +					--length;
> +				}
> +				write_item("password", blob, length);
> +
> +				// key/value content starting on next line
> +				blob = end;
> +				do {
> +					LPCWSTR value;
> +
> +					// find line end
> +					if ((end = wmemchr(blob, '\n', wlen)) == NULL) {
> +						length = wlen;
> +					} else {
> +						length = end++ - blob;
> +						// correct remaining size and drop carriage return at line end
> +						wlen -= length + 1;
> +						if (length && blob[length - 1] == '\r') {
> +							--length;
> +						}
> +					}
> +					// find key/value separator for extended credential info
> +					if ((value = wmemchr(blob, '=', length)) != NULL) {
> +						static const LPCWSTR refresh = L"oauth_refresh_token";
> +						DWORD klen = value - blob;

Value is also "wchar_t *", so klen counts the length in wchar_t,
which may be wider than a byte.  So is

> +						// write entries known to git credential protocol
> +						if (klen == wcslen(refresh) && memcmp(blob, refresh, klen) == 0) {

klen that counts number of wchar_t letters in refresh[] string.

So, is the memcmp() used to check if early part of blob[] match the
refresh[] as a whole correct, or is it only checking an early half
(or one fourth, depending on how much wider your wchar_t is compared
to char) of the string?

> +							write_item("oauth_refresh_token", value + 1, length - klen - 1);
> +						}
> +					}
> +				} while ((blob = end));
>  			}
>  			for (int j = 0; j < creds[i]->AttributeCount; j++) {
> -				attr = creds[i]->Attributes + j;
> +				CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
> +
>  				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
> -					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
> -					attr->ValueSize / sizeof(WCHAR));
> +					write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
>  					break;
>  				}
>  			}
>  			break;
>  		}
> -
> +	}
>  	CredFree(creds);
>  }
>  
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
