Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6313D2A9
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454976; cv=none; b=A7JzTvN5Y24lsL6UlpXf2IqGDRkDKPvmxtpwgm5HuDgNobINuCAgnFhV0gVfG3P1y3a+doP2YOO7zVqSqA515NQwfSGdCGmqyyp/kwgHFSQcbsF1QCkgnYtYdBvQcKIxmf0v7XtSIDRomwFdlcR07o1TAAuafZS1ejM6MA5w388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454976; c=relaxed/simple;
	bh=W3eVOOukAWqff7B3tIRp37ZTOjWbu2DcDOKN2dZkSvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ecLJhRR/REnQAY7KNN4Sz+uHVYWY3z8/tsoO6gR2irbJO5fucwkRgvKwEi2hFGyJt5QFejEpS8lCSgA1YRPJcIpOsgH8jt14L33ztjIH99XBvc0l0r0Hn6p7xIJYmZLDYjflcgMHu1/u4Zw6GHTtX10mw+IvmwfyLPl4KzmZ3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtB4I9gh; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtB4I9gh"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e036105251eso4074817276.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720454974; x=1721059774; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dw8fAwsKoXFFV50ufA24IWDCTPD2Fzg1FM2TY3UBSI=;
        b=HtB4I9gh2WVzObXz+HikZSjuuNQskH2OsjJGAiM50IO8t6c9fr3Z3fl1jjvO4Nb9Cb
         5pZGIuYkYgSxkg3HobYF3oR2jxY76Arc1rIP7mRUvGdeT8OoMchaUq3pCHNc7tU4Hwrg
         X6jOKcAOYsMo/LPWT7Y0T18HVoMJe0Ez/Tmjum6W6Gmc0MqIL3sg9r6X3oKZaoyh8p35
         N88XfRo/X3YFMhrpVIpx+Jzt+0MMxYbF1QLP+os6/kCEu9NN2ITV/+PTkeP05Rk+HQXc
         KiQdezaA5mDys5dC8arlePa2ogv35aH8zhDmrMV3e6dwEUCSv4nqa7twPJOCjolAeg/V
         V4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454974; x=1721059774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Dw8fAwsKoXFFV50ufA24IWDCTPD2Fzg1FM2TY3UBSI=;
        b=F1JtjdMI1me5vm8z6Q7fDrp/RWzXPFAn0aIA7YohlU+Khbqg5CMY8bI55woSaPOeDs
         QzWz6xvxbsE8A+MDv9Y+tcMJ9DYwxLpEOWdd6MExBtij+vz00ttNqXodRt2tlAzCb2Rg
         mZxsmreNcQq1HHdnVeQ2ePP4fK6wq3zalfVeme/snTgt5zTpvP96knqshhy/wCrJiCml
         oFQnf5jDSetDQUKyfxHZkauORbkQCJn7Cj73IvvXo36s1OwSR8HDJRngAOVFBZL5pX0y
         jozV+TPlOV2udMw8pjq4qGKZ3TzI4NW8zuuoiZxCV97CuzOZlsSDT/map+8tRcsvjV7v
         AbuA==
X-Gm-Message-State: AOJu0Yw3DVPQkvqysXUeFEU0hZ0TLevsaWJG2R2Mt6aB+HEfxf/XDrTb
	dlGaHkwc8BClMs6fn0IqQGFcEGR1GDqO3tCydGCNQSgPtiv3dgiAGNmoShkjAlRb2ew1imbctAF
	iwTqom037y49C0yJXNVacq65NL3T5Pg==
X-Google-Smtp-Source: AGHT+IGFKoSsYd2b4XkLGLqitIPLpPiUI2qV8mJ1icJ3JEw2uRxJktCYH0AfFUY3Ac+O+36IepL5LwuOswLKKs0nBuo=
X-Received: by 2002:a25:a343:0:b0:e02:50f2:784d with SMTP id
 3f1490d57ef6-e041b05c0eamr210375276.21.1720454973785; Mon, 08 Jul 2024
 09:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708143239.vq47dg7mgh33hykf@carbon> <2e10070f-2720-4d70-aa15-d4c008cc57bf@horse64.org>
 <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com>
In-Reply-To: <001301dad14b$f8f0e460$ead2ad20$@nexbridge.com>
From: Emanuel Czirai <correabuscar+gitML@gmail.com>
Date: Mon, 8 Jul 2024 18:09:24 +0200
Message-ID: <CAFjaU5sGvRD+jXOgLhx9qjQ_McawEzVt035DE6b2nx7+rU188A@mail.gmail.com>
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can try traffic shaping it, temporarily, just to can reproduce the
issue on (presumably)anyone's linux machine, like:
$ sudo tc qdisc change dev em1 root tbf rate 8kbit burst 8kbit latency 100m=
s
(replace em1 with eth0 or whichever `ip a` reports as your LAN interface)

Look at it:
$ sudo tc qdisc show dev em1
qdisc tbf 8001: root refcnt 2 rate 8Kbit burst 1Kb lat 100ms

$ git clone https://github.com/maliit/keyboard
Cloning into 'keyboard'...
remote: Enumerating objects: 23243, done. remote: Counting objects:
100% (464/464), done. remote: Compressing objects: 100% (207/207),
done. error: 153 bytes of body are still expectedMiB | 1.14 MiB/s
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output


It's different for me, but maybe this traffic shaping idea might still
help if properly modified? (maybe it's too fast still? or not latent
enough, I don't know)

I tried it again: (seems different)
$ git clone https://github.com/maliit/keyboard
Cloning into 'keyboard'...
remote: Enumerating objects: 23243, done.
remote: Counting objects: 100% (464/464), done.
remote: Compressing objects: 100% (207/207), done.
error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
CANCEL (err 8)
error: 7932 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet
fatal: early EOF
fatal: fetch-pack: invalid index-pack output

Change it: (use different values here for those 8 values and for the
100, if needed, you get the picture)
$ sudo tc qdisc change dev em1 root tbf rate 8kbit burst 8kbit latency 100m=
s

or Delete it:(restore your unshaped traffic)
$ sudo tc qdisc del dev em1 root

Look at it after deletion:
$ sudo tc qdisc show dev em1
qdisc fq_codel 0: root refcnt 2 limit 10240p flows 1024 quantum 1514
target 5ms interval 100ms memory_limit 32Mb ecn drop_batch 64

/sbin/tc comes from package sys-apps/iproute2 6.9.0 on my Gentoo, ymmv.
Good luck.

On Mon, Jul 8, 2024 at 5:32=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> On Monday, July 8, 2024 11:15 AM, ellie wrote:
> >On 7/8/24 4:32 PM, Konstantin Khomoutov wrote:
> >> On Mon, Jul 08, 2024 at 04:28:25AM +0200, ellie wrote:
> >>
> >> [...]
> >>> error: RPC failed; curl 92 HTTP/2 stream 5 was not closed cleanly:
> >>> CANCEL (err 8)
> >> [...]
> >>> It seems extremely unlikely to me to be possibly an ISP issue, for
> >>> which I already listed the reasons. An additional one is HTTPS
> >>> downloads from github outside of git, e.g. from zip archives, for way
> >>> larger files work fine as well.
> >> [...]
> >>
> >> What if you explicitly disable HTTP/2 when cloning?
> >>
> >>    git -c http.version=3DHTTP/1.1 clone ...
> >>
> >> should probably do this.
> >>
> >
> >Thanks for the idea! I tested it:
> >
> >$  git -c http.version=3DHTTP/1.1 clone https://github.com/maliit/keyboa=
rd
> >maliit-keyboard
> >Cloning into 'maliit-keyboard'...
> >remote: Enumerating objects: 23243, done.
> >remote: Counting objects: 100% (464/464), done.
> >remote: Compressing objects: 100% (207/207), done.
> >error: RPC failed; curl 18 transfer closed with outstanding read data re=
maining
> >error: 5361 bytes of body are still expected
> >fetch-pack: unexpected disconnect while reading sideband packet
> >fatal: early EOF
> >fatal: fetch-pack: invalid index-pack output
> >
> >Sadly, it seems like the error is only slightly different. It was still =
worth a try. I
> >contacted GitHub support a while ago but it got stuck. If there were res=
ume
> >available such hiccups wouldn't matter, I hope that explains why I sugge=
sted that
> >feature.
>
> I don't really understand what "it got stuck" means. Is that a colloquial=
ism? What got stuck? That case at GitHub?
>
> Have you tried git config --global http.postBuffer 524288000
>
> It might help. The feature being requesting, even if possible, will proba=
bly not happen quickly, unless someone has a solid and simple design for th=
is. That is why we are trying to figure out the root cause of your situatio=
n, which is not clear to me as to what exactly is failing (possibly a buffe=
r size issue, if this is consistently failing). My experience, as I said be=
fore, on these symptoms, is a proxy (even a local one) that is in the way. =
If you have your linux instance on a VM, the hypervisor may not be configur=
ed correctly. Lack of further evidence (all we really have is the curl RPC =
failure) makes diagnosing this very difficult.
>
>
