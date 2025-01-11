Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C5A15CD49
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630381; cv=none; b=QcvcuQnS9sweTkMW3jkM97DSQysgQW274MyVuWW9+9cUlU5pfkQZFaL8kejaE6BK3+uBUoRAiUE4kvzvHkU7qrpsYlOx38IHTAKlzPEJPaTvwFIgoK1Nm6e1cj2HDUk+bJaFynwVGsitH5PAkWIZ9m9K8WtC4s17y9KeHtbSjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630381; c=relaxed/simple;
	bh=raMw+xHHBJ5f9tDzzk/XHGqVyMvJSfWM1QRDprrics4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VJSrNiBlFuZWhGXeMQ0MselBFDVHi1nYBZivtQ+Kouuf9kToEgnPM3ORt8r0x4MbRhW1iNg5a/+xwAXs3jivuOFkT+QlNRmhH5xxocH7UzEY2PpitKS4Oj0ispOpy1jrNfYIAydk/FHMlIfa/DntqK9XVFODcn1CXceUTcDmFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z360jKMA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z360jKMA"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844e7bc6d84so99520839f.0
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 13:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736630379; x=1737235179; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX9RYJQb5IzP2fBgeZpK4yxk6DELQjHoq47Dkzb8dwc=;
        b=Z360jKMAcZ+0YY7Ewp4JsH+mx4/JFYt3uCITI7AnVnwQd8bMMSoMDaGswQKNYR0Wro
         pC247jvsUIo682FmoErw/SJBrb7FMG3U2U2cGSjJwp0JyHvck0zyMvZ0+qXZnZWDHTcO
         v3/AlWZCvshlW1i7p2JSuumxpqaU0OxrowsAxa5/gx3VlSwNWBUkCI7M71lnuTl+eo//
         PKom2PttcrB6JQuqaA7xqWah0Syjw5wA22BWuFwj6vHBK0mjT9ssD3SF1fKC6LnQoC3w
         v40goVMKlBGTm2dQriN9wUEgHDLBFq7PtDh/Auz2tFRYhxVT6DkF/zg6pP1EV8razD7g
         gxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736630379; x=1737235179;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX9RYJQb5IzP2fBgeZpK4yxk6DELQjHoq47Dkzb8dwc=;
        b=M/ZCn6k9HkAPW1V633VVH3fViyZuU6DpBF7Re8Ygpqm5UoWevriNYehVNHIJBdiqNx
         2DPpDqFoRAUq+dQUy71r8Tu9ey0N4m5PMOkPPBTrmMRrIah5q45DKUaULXhxgz00iv/e
         1Bg+/vIjbmRCtAsBQUkTncioSb2N3f3DJZv8XOrGda9d9dxLrkG0G5pGAEe73qBALqy1
         EDyTcvhOFkyEWmgKJuGUrs9RgoMBF0mNuX/9nl5i3jN/0VEJumxoml0dl8+hkhSziscY
         l2cEaFNVfSqlF4GAU4VyNJH+jKUi0SZ9YuLD5Z14XJgAjeg7y4J2sCGX27ZaOMYRwQT6
         j2yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCqTvz0pfyyTGPGkIiKFMoLrAAhvzCsMZmvH+KSvWOZk6Bb2OGiBIQH2BRnflBrMDN3kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3B1U9Zocy1dgkxj1r/NWgMXgUScjPjWrL8VezHSQ6QeRUTnN+
	HqikeHvBU7Ai/UYm1wMvsUsImQh/pftzBOTHBN7ieVxkeoc96oBZRbYqpmCo6IWyPG6keo0HaaW
	vrpskOyrqGmQadWDcPYDKkGt2cRb0saLY
X-Gm-Gg: ASbGnct6ag2eXYbIKiB0/k/D24fC5+wPYAXGOktECTTMGhgyf8ORMS5rbr9D9bcqt93
	gkSz0olO3YBocv0pDqMbEmYyzbwhnBNjbgfCc
X-Google-Smtp-Source: AGHT+IHyEIWsfzG3Zot+1Hni7nnnrghwnRRhnN8u1Nhh7KDFqnehbkdaPD2KxeXNMVsTeEnVwnD69+BqOCeA97kDJ+k=
X-Received: by 2002:a5d:961a:0:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-84cebf70760mr848098539f.4.1736630379420; Sat, 11 Jan 2025
 13:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107194953.2104-1-mirth.hickford@gmail.com> <D6ZH9HE0N3X8.350NMMZ6IY8QA@swagemakers.org>
In-Reply-To: <D6ZH9HE0N3X8.350NMMZ6IY8QA@swagemakers.org>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 11 Jan 2025 21:19:28 +0000
X-Gm-Features: AbW1kvYAP346-dtc2U290-TDuHQPkjU2WB5EzMiDi0ZJdk70dkNFFhzlVaWgCH4
Message-ID: <CAKcCxfCepXUzcyT_i_eZ1wREU0J_T+LgrjcEzb++gY5J05phmg@mail.gmail.com>
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
To: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 7:06=E2=80=AFPM Julian Swagemakers
<julian@swagemakers.org> wrote:
>
> Hi Mirth, thanks for taking a look and testing.
>
> > Please could you add instructions how to test it?
>
> Sure, below you can find steps which can be used for testing.
>
>    # requirement git-credentials-oauth installed
>
>    # build patched git
>    git clone https://git.kernel.org/pub/scm/git/git.git tmp_git
>    cd tmp_git
>    curl https://lore.kernel.org/git/20240225103413.9845-1-julian@swagemak=
ers.org/raw |git am
>    make
>
>    # backup gitconfig
>    mv ~/.gitconfig{,_backup}
>
>    # create minimal gitconfig
>    cat << EOF >> ~/.gitconfig
>
>    [credential]
>       helper =3D cache --timeout 7200
>       helper =3D oauth
>    [credential "smtp://smtp.gmail.com:587"]
>       oauthClientId =3D 406964657835-aq8lmia8j95dhl1a2bvharmfk3t1hgqj.app=
s.googleusercontent.com
>       oauthClientSecret =3D kSmqreRr0qwBWJgbf5Y-PjSU
>       oauthScopes =3D https://mail.google.com/
>       oauthAuthURL =3D https://accounts.google.com/o/oauth2/auth
>       oauthTokenURL =3D https://oauth2.googleapis.com/token
>    [user]
>       email =3D you@example.com
>       name =3D Your Name
>
>    EOF
>
>    # create email to send
>    cat << EOF >> message.txt
>    Subject: test email from git
>
>    Hay from git
>
>    EOF
>
>    # update PATH to use patched git
>    export PATH=3D"${PWD}:${PATH}"
>
>    # confirm you are using the correct git version, should look
>    # something like `git version 2.48.0.rc2.32.g5adec67521`
>    git --version
>
>    git send-email \
>     --to=3Demail@example.com \
>     --smtp-auth=3DXOAUTH2 \
>     --smtp-encryption=3Dtls \
>     --smtp-server-port=3D587 \
>     --smtp-server=3Dsmtp.gmail.com \
>     --smtp-debug=3D1 \
>     --smtp-user=3Dyou@example.com \
>     message.txt
>
>     # now the browser should open with the oauth flow.
>
> > Which servers have you tested?
>
> I've tested this with gmail using a consumer google account as well as a
> managed google account and with the office settings I've tested
> office365.
>
> > Looking at the debug information, it looks like the SMTP command "AUTH
> > XOAUTH2 <base64>" was corrupted by a space at column 241. Exactly one
> > base64 string should follow "AUTH XOAUTH2 ", no spaces.
>
> I can also see a space in the debug output, but the position depends on
> my terminal size, and it is not interfering with authentication in my
> case. I think it is caused by output formatting of the debug statement
> and not the source of the issue you are having.
>
> If you have a coded auth string you can use openssl client directly
> to test it.
>
>    openssl s_client -starttls smtp -connect smtp.gmail.com:587
>
>    AUTH XOAUTH2 auth_sting
>
> If you have the xoauth2 access token you can create the auth string with
>
>    echo -n -e "user=3D${EMAIL}\x01auth=3DBearer ${TOKEN}\x01\x01" | base6=
4 -w0
>
> If that does not help, can you give me some more details on your setup?
> Then I'll try to reproduce the problem.

Oops I had my email accounts mixed up.

I confirm both XOAUTH2 and OAUTHBEARER work to send email with gmail.com

Tested-by: mirth.hickford@gmail.com

>
> I've tested the steps above on Arch Linux with Perl v5.40.0, and
> Ubuntu with Perl v5.38.2.
>
> Regards Julian
>
