Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C061668
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770147047; cv=pass; b=eCnmhgr74oMG+ziQYoty2jQ8qe1oR2xG9ErpBZP1P8WQdNVxke7kZ7sn1VQCdDZd0FmX2ZKnr3k13tCOYHsSuAGYWIbkUBxzWeYW2KKeWxaBm+AnlQ5MrIhug/KTE4QsvRuyBOdMdNERMA50KJNP8RwWxB5+wTChHW/IIy7mjCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770147047; c=relaxed/simple;
	bh=ZmXDABIKYianlYyzFDIDXlGHIxvhMvMGy+QDLoC95ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lU6eNGyn0RqYaT17hTgsOZd0zvCBr2Z6Db370qrBBe0AFB59clDxtP0irSIr75IafHDw4D/gbfhmqsIEVDAY4fQuXf6OqyGv5GIS4cl2uqlfJMvJO633+7d9neF//wxHhpNrfxodNZMese6wgery/Wv95+GT2ckgXF+FD6CX8E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF+Ctu5T; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF+Ctu5T"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4b77adso2091741c88.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 11:30:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770147045; cv=none;
        d=google.com; s=arc-20240605;
        b=F5yybXscvB+JcvWkF2BkEPEmC0zbtpWh8/xzFW83Zpz2npl/vVjODw3kzXkI2dX1Z4
         iDYIFQHIOIJrh057MBLTsGuQtgHQZgLaKYxHGwRzuEHhtF/Luzfom9DgB4L1MwS+Y3+y
         kiqwQkjVYI6tYXJTXuLmRSBnaCy9r6bLm5TAzCoMs1W64/fsNBoqKPibgiYajGMVBvq6
         J8ylzCsXS7R8SJMPKMHPwCUfhlmXHhoXtmBxwrKDBjVKoX6KeVSuTv5CSAaj7it4iLOg
         GJFDR5P7XkxGmZHAlH3AeIRkahamZdPtNn4+yisrwDJCuFTDHSnAjDPJDfROjUv+Azoh
         acBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmXDABIKYianlYyzFDIDXlGHIxvhMvMGy+QDLoC95ok=;
        fh=LXEaqkYlq1MJSGuXjMVMjrmBEUqUMHJICVIaOkcBcwA=;
        b=FpRYVNhZxbQvSPFhWhDB30GUAPAkAe369uOqoUc6lhsE2et0f/Yydtr/9PEDGfOXIO
         MYg7lFtd0pVPw/faWMj7U54E5QR/S0sl3E34EQ+k7FhEwg6hsZ9az1cV8FzabnCvSpKL
         Mbr1BAaeWcsq0eZcWRKeAxBmaVvYUas7FBtLtx3GxSXaUnajA3Zx33qOhnHJ9hqKz0Y6
         x/gprquHzqJIspYkFjxT44joEEQxLoLQCUljBgbcC8/VuJad+D1myfD8LPvhwJMaUry1
         IDPf8Jmhbo4jXm3hH51Dv+rrAip/uyhMkRh8qtiHjURPG8aTkaiJ2EeMp+7rT3eoxmf+
         9BFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770147045; x=1770751845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmXDABIKYianlYyzFDIDXlGHIxvhMvMGy+QDLoC95ok=;
        b=NF+Ctu5TjlJOFAqbxwLuNIwEvKWRDgxZWzZZd+iWBPvZ3++4CzV4flhHc5f8wFDD29
         NOj1+MrzCFzs8jcBvSIxT6LvmhpXW99Z5/cc7d3OR/+esnvlQPOsojhT8NDR2IpXO4Qc
         dFhIY5egFSBoyWtObyxQyafGEVj/EJPIE6UAmPi7DO3HlkSHmjKewoQ3Ji6Pw2UHfxqf
         aQo3+znl+paAngS7vKgljlA+YtC8DJV/J1MWvOBQiVNjdzsgRfOEufkHdHw6M2hdp6MF
         nik3rjJQ7ZVHMCt2xbWpu6qDhFwt9T81npNBXO3QYfSAp7zxQN1Cu6cT/BK3CMC5PJ9l
         wr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770147045; x=1770751845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmXDABIKYianlYyzFDIDXlGHIxvhMvMGy+QDLoC95ok=;
        b=xOaL6iC/eJTxjj3aFR/pt97EOxt3UtynGJwtrDrUjOdFGINPOEZhdMyORFoG+XLu/C
         mpjpG7tFS65BcvT83s/tthN7nL5p1517A+RWFejLzDYr9NC37CVMiJyIQvp/+yTMQZad
         dzUPBxGubXJf39I5Tv6eraShrgawmU5dna77DLtQTVeQTxRRk8Ax221v1PSZ2ZINta2s
         99KHDH/lR2oGMf188oPsWrSrI4h6kBZo+7VvgrLSo47haBmCyglQJAHM1M0CKBLUZKBC
         gOrhuzRtlvfZBDd2gBLpaGEufcy3jcOYTig4WUqaJkztX0CkpcMSb6TrQLwcXb86aL/p
         OrSg==
X-Forwarded-Encrypted: i=1; AJvYcCWr6vwo8JeXZfxPlE+YGQyKgAKtNTNaMhA0/IPo6I+wJhaU4UQqjmpDrz2E4j9wlibT2vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABDi2OvFoezVGBch5WmQvlcG2fMxsK6MOirDbFd2c/gLtc2T1
	Av0Ex9WG9zKgTJaXee30KySwiPUWMMNYVZsjlrmwOdk8K7CwP4vHE8gF2kE6eXEhNjlb72kIvsT
	8Icq+WZDPoMXdvLyIZvxoeUI6tmXrACc=
X-Gm-Gg: AZuq6aIVNAFR5HQNqvDaLiYpclZr+TyNjj423paqm5Xl1hETvXAU2ROVrvdNS2fEvR3
	jmjo4kk6WmyYcVhc4fXOymU1cD8TxoO/hIDLs3TEr2NsFyov3VXtKphF49v+JPDJXpUKvAM41bn
	UezEIhj+0ScShy4XnJJg+3rnVOh1g1dZDZeisYzlx5W2BQGnvzHeWfRnDAfqgThhtQbFmand/Lr
	k5ryR5Ilqsn/0mboVa85fCq7IX717jUiAbteCmEcC7b5VkR6unMDqKHf5hbCIT5aU1VaZP2wbCs
	oGh/plHfe2iBepFMWvNC/2NvXqFZXTPHKCXzZPw89IjPc7jTNG0Uo/e7
X-Received: by 2002:a05:7022:e04:b0:119:e56c:18ab with SMTP id
 a92af1059eb24-126f477dfd7mr228159c88.19.1770147045486; Tue, 03 Feb 2026
 11:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CA+J6zkSo1LuFUdTU8m6z4vANrJ2r88EV6RDDC_0ZW3bWec2v2Q@mail.gmail.com>
 <CAP8UFD15Fkx0t4DYcWjK+WgeZBOzfYNyOePQXGU46Fyf4+pFgA@mail.gmail.com> <CA+J6zkR0tvv1b7db+jQ_XW4ft3_p07bCJOm96B30VKx1abpF0w@mail.gmail.com>
In-Reply-To: <CA+J6zkR0tvv1b7db+jQ_XW4ft3_p07bCJOm96B30VKx1abpF0w@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 20:30:33 +0100
X-Gm-Features: AZwV_Qj3Tgs1iigiTCN_98x4tGjT6deKJK_ZcSw5NWQz8pNLb2ozyR6rw_kfLXc
Message-ID: <CAP8UFD0oPL1e1wcy5_q_kmrEv-3YkJHVXutgdFHsZ+hLtb+JvA@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:15=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> On Tue, 3 Feb 2026 at 16:03, Christian Couder
> <christian.couder@gmail.com> wrote:

> > We don't have project ideas related to reftable or testing in our idea
> > list, but we could add some. If you have preferences among the
> > projects listed there, let us know though.
>
> Among the present ideas, I think I will be best able to help with "Comple=
te
> and extend the remote-object-info command for git cat-file". I could help
> with the other projects as well but I think my co-mentor(s) would have to
> pick up too much slack in that case.

Fine, I have removed you as a possible mentor for the two other projects th=
en.
