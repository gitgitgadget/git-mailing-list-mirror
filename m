Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73E1367
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720282588; cv=none; b=jGdeJEBSZTqijszhRJs8+ZLR7OuY+wj+J4Ugwz/WdKkvL6T9gEIU6EX3QvX0arnPcwyhuTcF/hHHPyLjNVIjGakSenr455AHe2bv4AIXBme6Sox0w4mZXNruLDpCW017sOR+lC4sKJoGf+ptGS6I/p/yjkVm0oynbbmZxNUYfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720282588; c=relaxed/simple;
	bh=08ZruECtPBYENoDptjMTwCVAhV65bwW/NOyIFddejic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS4MpwhwvwRSGmthX6H287/o9frIb55IMWcVkYjb6zFX8kGvyPgTxmeoL08wZJDTujdLZcg/Mxv53czAaxiKDtsJd3ekssKGGitJYMWURvwv7Owj0TB7pJi4iZDbR7twyhR+SbmoPkbDZ1Ca8wLqEKPMizGbn5uwcAlKqMSfxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDfx5Enj; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDfx5Enj"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f2ff9f5c30so506121e0c.2
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720282586; x=1720887386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGIJ8clUZpo4wgoTGPjsg00Q6bvZJHa/+GMbRScpbCI=;
        b=cDfx5EnjADrHxsplF0pWsUrtkcjWMwEN4djVpfW2l6Kdh0YgcSbCeey5Pzj+jiXFse
         HxTzNnBixE3IelIvg8H+py3xZZNOgp5CubZT0fLvcAqeBY4wUFlQTYjFYiQga3y2nNcA
         eYUOx4mCiZHN3L2LPSseVO2YivRlK4dZfCsAzNwkt/FRF6N3sj1GijNWOTD1MMGVuuQ/
         HyZsnLo8WcMdS/4RSdwS8X/LfcGMNRWwct+Fiy6Io7wPe2H0nShdF2mEmHJeYShnXGhQ
         wiCBkLWmiLjxcBg1kSNPggZDIfIO7z6H6M15MHpHtEFSO3DYX2Obte3pAEl0x4USMj6A
         +lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720282586; x=1720887386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGIJ8clUZpo4wgoTGPjsg00Q6bvZJHa/+GMbRScpbCI=;
        b=LVazupuPmUxwjL2o9zjTIktyaTJaVkhIkYthKrtgYUPvQmjC8mxSeNiNyWPHis87f0
         qQfmqxG7/SS4JMLNZEevR1muJrQdwRaBxrRy6rO5V7X0KlBt+3zX8ng3UwEIQwK5vDJz
         fX5RkLKF/IxpUCP3Ys8c6MxQEoS1L3sW5No0J5EDNWwng7R97UxXDHMTalVb03I9jR1C
         sxPV093qBORE2fdBK0jMPloZB6+V4+uVbpjR9fmV5B06bCSoBm9jeXVwxnpVTv6zqycP
         i0MpGlAwR282hHpGu0SiirgN9SL40X2W0Qbk7tgr7EnvC41DAIm0UNlyU9x0ksmhW1SY
         xZKA==
X-Gm-Message-State: AOJu0Yy99f6WiE3gyT5zPUlEGE0/hSmPCjEBgll4W+W8NAOYxlRkpTtZ
	P5laeHY6TT72lsjKc60m8PeLTbL0AIfZB853fPC/yJ+LdlhhB0boQjRxs6EADK5k7iq4arUDG4h
	qbmeCEo4TvY8a0vH6xdEpMtZKcWuMJVZr2aw=
X-Google-Smtp-Source: AGHT+IEsVGfo6vh7PcDQOvbJCPaHYiHOi/H3D/ehVOU8ssBUwsRZa9mtXc8/cT10vuiggjY2E+7Flne9z3KEDDXCpEE=
X-Received: by 2002:a05:6122:388c:b0:4e9:7e39:cc9c with SMTP id
 71dfb90a1353d-4f2f40531bfmr8482431e0c.11.1720282586011; Sat, 06 Jul 2024
 09:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704164547.94341-1-080ariel@gmail.com>
In-Reply-To: <20240704164547.94341-1-080ariel@gmail.com>
From: Ariel Cabello Mateos <080ariel@gmail.com>
Date: Sat, 6 Jul 2024 16:16:15 +0000
Message-ID: <CALRJROB7gGWok-YPGTjPe+TXkU5Y_MhqcPSiCGoPDzJ=WGHoKA@mail.gmail.com>
Subject: [PATCH v2] gitweb: rss/atom change published/updated date to
 committer date
To: git@vger.kernel.org
Cc: "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently the value used is the author date. Change it to the
committer date that betters reflect the "published/updated" definition
and makes rss/atom feeds more linear. Gitlab/Github rss/atom feeds use
the committer date.

The committer date is already used to determine if more items should be fet=
ched.

Signed-off-by: Jes=C3=BAs Ariel Cabello Mateos <080ariel@gmail.com>
---
Changes since v1:
- Typo fix in the commit message.
- Semantic fixes in the commit message.

Thank you, Junio!

 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ccd14e0e30..0ef5707557 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8329,7 +8329,7 @@ sub git_feed {
                if (($i >=3D 20) && ((time - $co{'author_epoch'}) > 48*60*6=
0)) {
                        last;
                }
-               my %cd =3D parse_date($co{'author_epoch'}
, $co{'author_tz'});
+               my %cd =3D parse_date($co{'committer_epoch'},
$co{'committer_tz'});

                # get list of changed files
                open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts=
,
--
2.45.2

On Thu, Jul 4, 2024 at 4:46=E2=80=AFPM Jes=C3=BAs Ariel Cabello Mateos
<080ariel@gmail.com> wrote:
>
> Currently the published(in rss) and the updated(in atom) date
> used is the authored date. Change it to the committed date
> that betters reflect the "published/updated" definition and
> makes rss/atom feeds more lineal. Gitlab/Github rss/atom feeds
> use the commited date.
>
> The committed date is already used to determine if more items
> should be fetched.
>
> Signed-off-by: Jes=C3=BAs Ariel Cabello Mateos <080ariel@gmail.com>
> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ccd14e0e30..0ef5707557 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8329,7 +8329,7 @@ sub git_feed {
>                 if (($i >=3D 20) && ((time - $co{'author_epoch'}) > 48*60=
*60)) {
>                         last;
>                 }
> -               my %cd =3D parse_date($co{'author_epoch'}, $co{'author_tz=
'});
> +               my %cd =3D parse_date($co{'committer_epoch'}, $co{'commit=
ter_tz'});
>
>                 # get list of changed files
>                 open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_op=
ts,
> --
> 2.45.2
>
