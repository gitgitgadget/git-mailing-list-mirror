Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881C1D55C
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YGU1WAcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703059475; x=1703664275; i=l.s.r@web.de;
	bh=efQ0C/6ORnDO4baJfKkes0nQ2El+mK8zH49hzXYNsms=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YGU1WAczggSYFLQZ1ukYXvfg4EmoCnOL77u8XlhmriZD2QCTFL3KOCKJSpnc/Lmh
	 AnIUkEYq9cQz4PD/1xXwt3zvfc737JT2fuHCNgmeYG1DKUKowWX1HVT4cOWcWiIMf
	 e3938Jpb/0BKlVrP7ZQJFqwznOtgHV7Sy5NsINjsiYOfsVTn+0/2CQJScsOWDgd5n
	 T3/5HTx5Ubx0rgeJBb7kE1US8a8xIbv8n8QHUfjbXGn2dhwub3O6tEw54S5Eb6eDX
	 1CDNFQgUYCQQVLqA3BzjRNGF+h2MuCam8ILZx8eZISwXwBuLR+snrW/ayCoBGPP8a
	 oPtXnOP8BB3kZxI+wQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N14pS-1r8ccz3HFS-012fCb; Wed, 20
 Dec 2023 09:04:35 +0100
Message-ID: <47089803-c45b-4f33-b542-146c313f0902@web.de>
Date: Wed, 20 Dec 2023 09:04:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase: use strvec_pushf() for format-patch revisions
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
 <xmqqmsu6ce0u.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqmsu6ce0u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tVIVqGiIq2+hqDYswxrLGPEfZ+KFjw26nWJJF8r7BLY3MaZkGhJ
 9fym4FQytbCoJpNcYq5apq+OWl5R06MYv4MTVQnEUrAPmEeUzNu5wjUOvXJZCFgYN2H3naB
 kjDjdcpi4w0TtBR4GstybrFF5h7w7TLNRFGpIbpYwzfQT+8YX6OLU19cdRgjqDS0o0GLnQ2
 HqujuRiFqBujPbR81ATFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jy4K/YaczAU=;CSc8bHVpdOSLlR9Aaf8HqKUmskA
 mqlUVYk+Su+GMRS8I7BkxvFikSyvwuFqoBC9zXcDlam0pCDzChJnW7+5WXqCEOdwlKRtuX9RI
 hfbGsxUKVcbgRb5RiSVuV6rI69PtJN0TNsjOMOZxWOJh4Ex59yI1GUvfkSP27049A/TcOEBBL
 E5R26gvxxcWvIgQSYdBfXql824pj3L5pZl/ELX9vgq9lrn5ZpRBvWBFLAwTgmA5qypEK+hRgv
 tTBZPQXxbEfHd6owdeDSn4A7+6JD77TYYgGM9im0f2LV+F1W79FQfBuRAdB1fZm99EJLediPm
 dhf6pDhy5aWjpmHmls3ReZyAXz7qLchXGzstqycwTWBLY/p41oOpyjggplLNSdHAY8JoR4hPV
 D5JpKnDb0OmodDSEGVxPNlO8fmOFQXA7U4F7Iz6ZdamByc1Bc/v0t9bsdllgrd9U80Ux6EwtX
 2LSQlTtas1rrDFc/hyYz52MJrWpkUEuD7z5O2HZJjsKxO19Og4qBk3Sh3MYRMLtQljjHdJvxz
 6H1Pmp32kuKbAErne+eRK11QpIQoHx6vcDtWnhDYYky9j9wgyTFSQ1WNuj0ZllYnssB039z/4
 EJIbz1VmxPv/394CP9yPqv1dHI2+hsHRIZ2YMbLYIQIRQUmEp7ebdtH3uvK/QqeNWyPjxT62O
 LO9Q1qoKGwb/YYZydNf8GyE9hFlpunccOccvxPyyOlqKidk/j+hvt2QpfxfSj8vqR2t7YvsP4
 zq0U1q6TIzzWCptsjEQ8eB5KrXWgFBLs0ez+Hp+m7bURFdX4fJT2jU70L1hCsHE5LizBQfR2h
 1F7bFbaORwqUUF2cBkLa8bfFb7W1iwemq7IF/0un888gA8WvOiuNWq/fzGafGNHOXbAg1B+ci
 1AWBsLsK/4I7cSojVyNWUQioSiMP1P1qRXSxQgoqcGfIQt/seB3+0Q0MnNQtDs4+a/c2cK7dH
 JlUfgQ==

Am 19.12.23 um 18:12 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> In run_am(), a strbuf is used to create a revision argument that is the=
n
>> added to the argument list for git format-patch using strvec_push().
>> Use strvec_pushf() to add it directly instead, simplifying the code.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>
> Makes sense.  Between the location of the original strbuf_addf()
> call and the new strvec_pushf() call, nobody mucks with *opts so
> this change won't affect the correctness.  We no longer use the
> extra strbuf, and upon failing to open the rebased-patches file,
> we no longer leak the contents of it.  Good.

Ha!  I didn't even notice that leak on error.  Perhaps the two release
calls at the end gave me the illusion of cleanliness?  Or more likely
the opportunity to use strvec_pushf() grabbed my full attention (tunnel
vision).

>
>> @@ -615,34 +614,32 @@ static int run_am(struct rebase_options *opts)
>>  		return run_command(&am);
>>  	}
>>
>> -	strbuf_addf(&revisions, "%s...%s",
>> -		    oid_to_hex(opts->root ?
>> -			       /* this is now equivalent to !opts->upstream */
>> -			       &opts->onto->object.oid :
>> -			       &opts->upstream->object.oid),
>> -		    oid_to_hex(&opts->orig_head->object.oid));
>> -
>>  	rebased_patches =3D xstrdup(git_path("rebased-patches"));
>>  	format_patch.out =3D open(rebased_patches,
>>  				O_WRONLY | O_CREAT | O_TRUNC, 0666);
>>  	if (format_patch.out < 0) {
>>  		status =3D error_errno(_("could not open '%s' for writing"),
>>  				     rebased_patches);
>>  		free(rebased_patches);
>>  		strvec_clear(&am.args);
>>  		return status;
>>  	}
>>
>>  	format_patch.git_cmd =3D 1;
>>  	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>>  		     "--full-index", "--cherry-pick", "--right-only",
>>  		     "--default-prefix", "--no-renames",
>>  		     "--no-cover-letter", "--pretty=3Dmboxrd", "--topo-order",
>>  		     "--no-base", NULL);
>>  	if (opts->git_format_patch_opt.len)
>>  		strvec_split(&format_patch.args,
>>  			     opts->git_format_patch_opt.buf);
>> -	strvec_push(&format_patch.args, revisions.buf);
>> +	strvec_pushf(&format_patch.args, "%s...%s",
>> +		     oid_to_hex(opts->root ?
>> +				/* this is now equivalent to !opts->upstream */
>> +				&opts->onto->object.oid :
>> +				&opts->upstream->object.oid),
>> +		     oid_to_hex(&opts->orig_head->object.oid));
>>  	if (opts->restrict_revision)
>>  		strvec_pushf(&format_patch.args, "^%s",
>>  			     oid_to_hex(&opts->restrict_revision->object.oid));
>> @@ -665,10 +662,8 @@ static int run_am(struct rebase_options *opts)
>>  			"As a result, git cannot rebase them."),
>>  		      opts->revisions);
>>
>> -		strbuf_release(&revisions);
>>  		return status;
>>  	}
>> -	strbuf_release(&revisions);
>>
>>  	am.in =3D open(rebased_patches, O_RDONLY);
>>  	if (am.in < 0) {
>> --
>> 2.43.0
