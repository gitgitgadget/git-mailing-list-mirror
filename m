Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60661C69D
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522964; cv=none; b=GVjPsGIVRkKZuSucLIjj45VvMCrtZ7086Q2GGcy+l32xNKvgiUNAbnVtgFuOfQPelte2sDosJTh87BN+eHYhoM+ZzTEINTHb2p9WVnSdpNqksn1Sfbj7pYLoDuES28nMvkpyieg4pdZ48/ylBMxMKY/4RWewWQwh3x20CSBcpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522964; c=relaxed/simple;
	bh=ROBBf8qrx9tbvU4WgToPVEsJc1UlrD8Z96fOQ1pdpq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJYUVjZ9MQOHDU6643DXO4lsfQ4iHG6qoTimWSI6+pre/LHv0vQBcZSwWYtykm2bsHqLAmpvm7TZu6huzCXnB2ZyL99ORHLgY7DUSVkuga7a25BNt9S2PAtDyUibZGgwh5ltHIgvjcPbkVHZP8leztI3ahUQc02wXYpgbUOzeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnWJm6lC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnWJm6lC"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-559836d04f6so9107279e0c.0
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767522962; x=1768127762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyM3SnX7/Uscu0o12HFs9RN9xaoiGTIBolSMzUbyBAw=;
        b=PnWJm6lCvqOYj5slZxPMJtAfjvaJXKHqtCD9DALzFqYwh3ioh3AW8oT4xnU1YHHWkf
         1JpDrCyuJXhjFEiLLag5oAb6zfoqVKKqsIKcdfHHMXmpzGlUNQEsBgpV85IRfY4udaMf
         Xx6+dOAGeJiv4RGhqqEJ8d7KtYnIAXRZa/H4FrvsDTbMTiQDAgSQZekKCDokIcUSZiUU
         oswNh4SKU+/adC3/ZaZwQsNs0fCYzuWFzViGBku65VasthGKi8BRm+1On5fYL0UQFtHt
         fyY8e7LUOphN0G/nGMINsbJ4H7Cwb2FHRA/MOrSfMYkFcrOu6Lw116dha8RTbhHqiHjQ
         9Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767522962; x=1768127762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyM3SnX7/Uscu0o12HFs9RN9xaoiGTIBolSMzUbyBAw=;
        b=nAHcZaU32Ua7B1t+WcJfgrvPjUcocH+0n5bwiGgXh5ksE2Eg6leKwXUBZgjPRHpFky
         Tl4BqVHur6etoNkaGVSjtuJeR3RWRMoy65ZBSyLdxgaYg6TmMKuuUI++wFjwOqeCols3
         oGIFt5AWLT/l5SHdjTmG1/GRUToIHriMvcNWe92Omf23a/rMSVvAcVDQK6+OmVP+lt7p
         8Dcnps2PkTSAw3BeLihfBm8ZKZqtI+FlDvU9YEyMq/TjgcsAuTAuCK0204fh7dy94o6y
         YznhiKSalEf7yk9i23LF1jLNSEneP/hLwV5C5KV4gteHYbJBfhOUT5TzmeMvIcLl23Aa
         qP+Q==
X-Gm-Message-State: AOJu0YzFDpy7Fa21XhIPoQdo2J9fl43UifqkYzr9LaSPAx3F+k+EhaHE
	YMCMyvYGmp1Wn7IKgwOI//TQJTK2iVw1cQeOt6bA/n8UwIED5Ih1O0J+UxspUHm6HOGTKEyCpIG
	1xbTRCiPt/HaUPuNRGJdmym3qeOqDnK0=
X-Gm-Gg: AY/fxX7HowEMlFC4l/Tc+/bqiBgyix/nWL3yoAIIx5x8GT+1m29prkXC5lCp9ilbiih
	txhGNab/DrirsDbS0A5flb2NMwzyPoigKSNkzidxv/yAw6UKlZqfksvdm0VA2SO2aCcleQQf/Rn
	/RkOn61Mwlh7xmO9vSd6gjQ5DX2CDA18xLcUqtrIQBDg132xy+/+vQ7fd61IuDohUk7zIFVyumH
	Bjj8t4pJur14r1HG4Nov9P0us7T3iuFln3WgfD+8bArXbclLy1UZUBerWuFLn3VYfNsn75dB58A
	2I5AdQ==
X-Google-Smtp-Source: AGHT+IGzTY14+hjnyjzk4a7rzGeEzCDWxitoyHbWRZdApIngqf/JuLisFzTiIX4JPQ1GpDQAEzEd3RKf8XKkjxN9FwQ=
X-Received: by 2002:a05:6122:238c:b0:559:ef6b:1efb with SMTP id
 71dfb90a1353d-5615be07ba1mr14260409e0c.11.1767522961758; Sun, 04 Jan 2026
 02:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local> <xmqqzf6tncde.fsf@gitster.g>
In-Reply-To: <xmqqzf6tncde.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sun, 4 Jan 2026 11:36:03 +0100
X-Gm-Features: AQt7F2rqZaI3oBaHNk3Pdj-5GH31axQOUxB-iUXe_ot6s38LNObMsaXeM7SS1AY
Message-ID: <CADYq+fZZAwavfi0qDxTMSGuVt41nh7vaKNngv_p93s+cwj++Cw@mail.gmail.com>
Subject: Re: [GSoC PATCH v3] add -p: show user's hunk decision when selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 7:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > When a user is interactively deciding which hunks to use or skip for
> > staging, unstaging, stashing etc, there is no way to know the
> > decision previously chosen for a hunk when navigating through the
> > previous and next hunks using K/J respectively.
> >
> > Improve the UI to explicitly show if a user has previously decided to
> > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > This will improve clarity when and aid the navigation process for the
> > user.
> >
> > Reported-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> >
> > Changes in v2:
> > --------------
> > - Modified t3701-add-interactive.sh for conform to new changes
>
> Here is how "cd t && sh t3701-add-interactive.sh -i -v" ends for me.
>
> expecting success of 3701.50 'print again the hunk (PAGER)':
>         test_when_finished "git reset" &&
>         cat >expect <<-EOF &&
>         <GREEN>+<RESET><GREEN>15<RESET>
>          20<RESET>
>         <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?=
 <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>         PAGER  10<RESET>
>         PAGER <GREEN>+<RESET><GREEN>15<RESET>
>         PAGER  20<RESET>
>         <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?=
 <RESET>
>         EOF
>         test_write_lines s y g 1 P |
>         (
>                 GIT_PAGER=3D"sed s/^/PAGER\ /" &&
>                 export GIT_PAGER &&
>                 test_terminal git add -p >actual
>         ) &&
>         tail -n 7 <actual | test_decode_color >actual.trimmed &&
>         test_cmp expect actual.trimmed
>
> --- expect      2026-01-04 06:01:25.931220332 +0000
> +++ actual.trimmed      2026-01-04 06:01:26.079845771 +0000
> @@ -1,7 +1,7 @@
>  <GREEN>+<RESET><GREEN>15<RESET>
>   20<RESET>
> -<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET=
>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K=
,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>  PAGER  10<RESET>
>  PAGER <GREEN>+<RESET><GREEN>15<RESET>
>  PAGER  20<RESET>
> -<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET=
>
> +<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K=
,j,J,g,/,e,p,P,?]? <RESET>
> not ok 50 - print again the hunk (PAGER)
> #
> #               test_when_finished "git reset" &&
> #               cat >expect <<-EOF &&
> #               <GREEN>+<RESET><GREEN>15<RESET>
> #                20<RESET>
> #               <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e=
,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> #               PAGER  10<RESET>
> #               PAGER <GREEN>+<RESET><GREEN>15<RESET>
> #               PAGER  20<RESET>
> #               <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e=
,p,P,?]? <RESET>
> #               EOF
> #               test_write_lines s y g 1 P |
> #               (
> #                       GIT_PAGER=3D"sed s/^/PAGER\ /" &&
> #                       export GIT_PAGER &&
> #                       test_terminal git add -p >actual
> #               ) &&
> #               tail -n 7 <actual | test_decode_color >actual.trimmed &&
> #               test_cmp expect actual.trimmed
> #
> 1..50

Thank you Junio for the reviews.
I get the output when I run "cd t && ./t3701-add-interactive.sh -i -v"

[...]
ok 49 - print again the hunk
checking prerequisite: TTY
mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-TTY" &&
(
cd "$TRASH_DIRECTORY/prereq-test-dir-TTY" &&
test_have_prereq PERL &&
# Reading from the pty master seems to get stuck _sometimes_
# on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
#
# Reproduction recipe: run
#
# i=3D0
# while ./test-terminal.perl echo hi $i
# do
# : $((i =3D $i + 1))
# done
#
# After 2000 iterations or so it hangs.
# https://rt.cpan.org/Ticket/Display.html?id=3D65692
#
test "$(uname -s)" !=3D Darwin &&
perl "$TEST_DIRECTORY"/test-terminal.perl \
sh -c "test -t 1 && test -t 2"
)
prerequisite TTY not satisfied
ok 50 # skip print again the hunk (PAGER) (missing TTY)
ok 51 # skip P handles SIGPIPE when writing to pager (missing TTY)

So that test skipped on my end because of this `test "$(uname -s)" !=3D Dar=
win &&`
since I am working on a MacOS.

I will correct it and send an updated version.
Thanks

Abraham
