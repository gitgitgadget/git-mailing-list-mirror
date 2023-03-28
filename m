Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636CC76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 12:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjC1MOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjC1MOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 08:14:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A86E89
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680005660; i=johannes.schindelin@gmx.de;
        bh=LkGJfp0vtoSVSxB8ncW5i8XqbX71Bxc4KfYRHkek2ds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EbFTs6xnr81t88sGBel81yaSprgpbVab75HJ5YPEPYZfCJ/Tts3kf9gNhF36FXNVF
         Y9fiuW5S8UBMK5aE4pQ3KMAYo/oxSabfjfAn3XIPTj9Ez4K5erkEoPTkxn/tq0hyeS
         sc7DPci7M1nSLK5gP+4pOPqGoEake77XQLtoMEmX8bOHCN0ugfSYsDpzEuKo6wKEYX
         Gu2v9I7VUKZCv4oUPTvCoHz9PK+2aMRp/hokugcXHfHcMdrJHu1zeIGSZ6EawxLmSg
         LEZq1yP3iSQVcjO3sbHvS+zlzYgFdpGZZNHmf3cS0LRUYD8oz+fb6GIXp0I/xcsKDH
         myjGl+1mgGRaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1qZ6Rl1c0r-00sJaV; Tue, 28
 Mar 2023 14:14:20 +0200
Date:   Tue, 28 Mar 2023 14:14:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?Q?Jakub_Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
In-Reply-To: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
Message-ID: <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1ZughELe3wtA6sU3SQcf+N0hRfIKSos6aE1wZby6mUBTDhGcU4k
 CYCxhhv6rCb6VrtOzmvtbn1TT8Tdr7AeJ8LxpmUQaA9ipUh9GZBlARQuucCI8VT92yvg2MH
 WEinNERoVeZERkghVTUierqmN1E6UO8z9kn+k5OJR1O7JfLJvNHRAv8j1GajSORjZqDK7Cp
 00tKnn3vSSBpRxvy0Ku5Q==
UI-OutboundReport: notjunk:1;M01:P0:VsJYl+7Wsc0=;S9suC2FRVTve9Dx24BrD2EbX0Kg
 VPSPXQi/qHOXzigO4mBscR3KS4JgZ43XWE95MLkNQUb3Q0ZovBg8A/cQJqnlGfsTD16Ty/o16
 9iDblhTEXDmOEEWU2zjCXdgy9Ez/d4wXl/ag7dFLdcML+PtcLpmfsVZyWMCv41TZ7FXBM1hvw
 iHL/NftqbNADZuWSbxW8tIusswcNVsPsZVUqaAxPUAHbXi1ogmSTY3EqOWpHQIFmHOigERlhm
 rqvDvRLlNRfV093EgtpEdeOtcqcA4l0mqaM6l/dH7ToRKS+okGMkfuBKpUpyXn5FLh9VKNagb
 ROyKITpyGChG+3VnS7pTzmWyzy1g3cOe7Zbk6ONJNrf3s3jpMX6BV7MKOsuu6eF8UsinFtusk
 AOQFzFsfDbabzYsZnoGwWO2SnvLZ4U3xbyVDUah3jqjKDJW5fU0NDKDgSQ5oHlAck4mLLFGS5
 1VaDv0Osj+qHmOf8RRiSm1gA7iBtugQiLUoTl8yxH29+eI6Z1bLogYWCiCHibD/jpjUJweTxI
 GFlkSDh/VXpA/XrqMaMerk+/jvG5gleUumBrtkjJi/5OBhs/LGP1AyDr6V6wycAOyPDZjVdAb
 nUVwcMqQvfAIYZLTKpzjlNleFS/6ZQsrwSTBCC5H4LTB1kD0ucLgzCKDrGFFeoxu54YaSVl/L
 FSuzl0H07fWWvF/1CnLMYryx05GmZ/oo9YZll/Mm6/dVm1wlI4EqumRKA5AyrQYkLtUfBOXsS
 f5m4ov44sgghNkV1G0dzB7ns7LtPt0a0JVTeWhK3I3D0c3YDyPZtw45b+Owa8IT8dLGSVurww
 5oN5A0VVDJS0syPPx4+OHOvhBzRccqregFrn1AAZrkFUwgy5hgDwsUftaQQ+0SD+VyZGb/iPo
 /FoXdwGZvAWAxRgp8xxAILl8M3k7QwGG/m6RC7XKp2xMKurAY8S6gnwngpUQ8U9MTXdGBi5EU
 MkXIdaJ5ReoVZW20jwgzO2lRxVY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi M,

On Sat, 25 Mar 2023, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     credential/wincred: store password_expiry_utc
>
>     Help wanted from a Windows user to test. I tried testing on Linux wi=
th
>     Wine after cross-compiling [1] but Wine has incomplete support for
>     wincred.h [2]. To test:
>
>     cd contrib/credential/wincred/
>     make
>     echo host=3Dexample.com\nprotocol=3Dhttps\nusername=3Dtim\npassword=
=3Dxyzzy\npassword_expiry_utc=3D2000 | ./git-credential-wincred.exe store
>     echo host=3Dexample.com\nprotocol=3Dhttps | ./git-credential-wincred=
.exe get
>
>
>     Output of second command should include line password_expiry_utc=3D2=
000

Sadly, no, it's empty:

	$ cd contrib/credential/wincred/
	$ make
	cc     git-credential-wincred.c   -o git-credential-wincred.exe
	$ echo host=3Dexample.com\nprotocol=3Dhttps\nusername=3Dtim\npassword=3Dx=
yzzy\npassword_expiry_utc=3D2000 | ./git-credential-wincred.exe store
	$ echo host=3Dexample.com\nprotocol=3Dhttps | ./git-credential-wincred.ex=
e get

The reason is that `echo` does not interpret the escaped `n`, it does not
even get the backslash because Bash eats it first.

But even with `printf` it does not work:

	$ printf 'host=3Dexample.com\nprotocol=3Dhttps\nusername=3Dtim\npassword=
=3Dxyzzy\npassword_expiry_utc=3D2000\n' | ./git-credential-wincred.exe sto=
re
	$ printf 'host=3Dexample.com\nprotocol=3Dhttps\n' | ./git-credential-winc=
red.exe get                                        username=3Dtim
	password=3Dxyzzy

And the reason is...

> @@ -195,6 +197,15 @@ static void get_credential(void)
>  			write_item("password",
>  				(LPCWSTR)creds[i]->CredentialBlob,
>  				creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +			attr =3D creds[i]->Attributes;
> +			for (int j =3D 0; j < creds[i]->AttributeCount; j++) {
> +				if (wcscmp(attr->Keyword, L"git_password_expiry_utc")) {

				  ^^^^^^

... here. Note how the return value of `wcscmp()` needs to be non-zero to
enter the conditional block? But `wcscmp()` returns 0 if there are no
differences between the two provided strings.

That's not the only bug, though. While the loop iterates over all of the
attributes, the `attr` variable is unchanged, and always points to the
first attribute. You have to access it as `creds[i]->Attributes[j]`,
though, see e.g.
https://github.com/sandboxie-plus/Sandboxie/blob/f2a357f9222b81e7bdc994e5d=
9824790a1b5d826/Sandboxie/core/dll/cred.c#L324

So with this patch on top of your patch, it works for me:

=2D- snip --
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib=
/credential/wincred/git-credential-wincred.c
index 9be892610d0..1aa840e31a0 100644
=2D-- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -197,9 +197,9 @@ static void get_credential(void)
 			write_item("password",
 				(LPCWSTR)creds[i]->CredentialBlob,
 				creds[i]->CredentialBlobSize / sizeof(WCHAR));
-			attr =3D creds[i]->Attributes;
 			for (int j =3D 0; j < creds[i]->AttributeCount; j++) {
-				if (wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
+				attr =3D creds[i]->Attributes + j;
+				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
 					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
 					attr->ValueSize / sizeof(WCHAR));
 					break;
=2D- snap --

But I have to wonder: why even bother with `git-wincred`? This credential
helper is so ridiculously limited in its capabilities, it does not even
support any host that is remotely close to safe (no 2FA, no OAuth, just
passwords). So I would be just as happy if I weren't asked to spend my
time to review changes to a credential helper I'd much rather see retired
than actively worked on.

Ciao,
Johannes

> +					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
> +					attr->ValueSize / sizeof(WCHAR));
> +					break;
> +				}
> +				attr++;
> +			}
>  			break;
>  		}
>
> @@ -204,6 +215,7 @@ static void get_credential(void)
>  static void store_credential(void)
>  {
>  	CREDENTIALW cred;
> +	CREDENTIAL_ATTRIBUTEW expiry_attr;
>
>  	if (!wusername || !password)
>  		return;
> @@ -217,6 +229,14 @@ static void store_credential(void)
>  	cred.Persist =3D CRED_PERSIST_LOCAL_MACHINE;
>  	cred.AttributeCount =3D 0;
>  	cred.Attributes =3D NULL;
> +	if (password_expiry_utc !=3D NULL) {
> +		expiry_attr.Keyword =3D L"git_password_expiry_utc";
> +		expiry_attr.Value =3D (LPVOID)password_expiry_utc;
> +		expiry_attr.ValueSize =3D (wcslen(password_expiry_utc)) * sizeof(WCHA=
R);
> +		expiry_attr.Flags =3D 0;
> +		cred.Attributes =3D &expiry_attr;
> +		cred.AttributeCount =3D 1;
> +	}
>  	cred.TargetAlias =3D NULL;
>  	cred.UserName =3D wusername;
>
> @@ -278,6 +298,8 @@ static void read_credential(void)
>  			wusername =3D utf8_to_utf16_dup(v);
>  		} else if (!strcmp(buf, "password"))
>  			password =3D utf8_to_utf16_dup(v);
> +		else if (!strcmp(buf, "password_expiry_utc"))
> +			password_expiry_utc =3D utf8_to_utf16_dup(v);
>  		/*
>  		 * Ignore other lines; we don't know what they mean, but
>  		 * this future-proofs us when later versions of git do
> @@ -292,7 +314,7 @@ int main(int argc, char *argv[])
>  	    "usage: git credential-wincred <get|store|erase>\n";
>
>  	if (!argv[1])
> -		die(usage);
> +		die("%s", usage);
>
>  	/* git use binary pipes to avoid CRLF-issues */
>  	_setmode(_fileno(stdin), _O_BINARY);
>
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
> --
> gitgitgadget
>
