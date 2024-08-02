Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F1ABEA7
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632048; cv=none; b=chQP85Cw/0ivXsFqcC9AvVRDDgLDg4ZMJZfs6yqRGNIuoD+yBlIoa8fDw3ovH4FvJkg1BjuADmLG4OUqLrgi3xSL+sghPiUTmzgGHYjJnuj/CBu/QXx8bD/PO6dpr+1ROivfLWYV/DkVZXFfzpxlPNuZvr0wVYjYcBgpM04AliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632048; c=relaxed/simple;
	bh=omMHM+nM267o5rW2G0B/f+Wsb49Hngv2k0vGaCBMDeM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GJAYrGJ6voqKWs7Hx3OBa5IZ9jTv/akcfoeZmcWvgqoHfvNLeZ5bq1T90zM7FUaHGMWIeOJQ70mw4JPtcdTuWtBLnnEfWkc2gao19g4x3aHmb24fdXHgdw3oc+MgPa0O+O8O7AhKinvyHB7AoQzPg/bGiS/sHccmhJruoeXd8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEZ1rCa8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEZ1rCa8"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52fc14d6689so9034788e87.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722632044; x=1723236844; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=omMHM+nM267o5rW2G0B/f+Wsb49Hngv2k0vGaCBMDeM=;
        b=XEZ1rCa8W48hpxTlm4MoUCJkT6Uxyk3siJw5i3hAJFoyd/KhDWO5yXx3/qp2k3wWCF
         Mp6IR0qCuVX58tqCuhxh7J3r1BHrADy2hnxUC3/xieFkNV0ZhooFEx1rDuZg2WPtlGl+
         dyzj1CLouSSPnf+Kbl3B+AHXQm9DQEV5rd5PFXDpooY1tZKzhGWis9QAIlp0AEe3NCly
         wgRClt9zqpfpl5U4/bzKYNHxofK3yAByoCO07vffweKwLuNGmgpKrrSJsM0ysNdDxo5y
         j335Hgq9uDphu9ZOS9WK9uvB6vI1fjss0Ays5NmYt4+LYYmlbtKrO8HD2Lv4XJI+Wglb
         8i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632044; x=1723236844;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omMHM+nM267o5rW2G0B/f+Wsb49Hngv2k0vGaCBMDeM=;
        b=dgJHmBybSJSCy15AVonYKeBYumdj3GXv5nI5+J+n9aM0885vmkQPh6siceSbgMyAks
         y5y15nlcu38cgX5oZSqDIKzRVp3PIxvRdFl+4IkVgXtjKRnRt9eXl5v64zaLbjcPKA6n
         FUBSXl9dw1WEmqgjFgqjEJLP3P/RSpSPAFSi2BjL048WV+KByK/TJI1j6DBCxGQrVR3a
         XLOsBsq1R42WVX10u3jtkhOlXfumFlfEjsELik+JMUugoRO/eFSOJz3ntpxzvns0Q8Dq
         5jb22ue0nMIbVQuja5Q0l0t2mjMAWUIXLP8khcGgLVaFS785wN++0saI96BHOog+HiQD
         Gvhg==
X-Gm-Message-State: AOJu0YwtBsgjrTg0/qIri0Ypp4gdY5uUWgj5P6jAfDGuNaKg/cL4VG2G
	Hbqd1mHprHhrt7g1Mim5j+M8NPW9CIZmG8F1+Hk9HcCiCF089Wskux5FMTQp0lQ=
X-Google-Smtp-Source: AGHT+IFjImgCs8gGMmKoEiOGnwFQ1wrc7KV9WhBWNkNR/Ggj3B64cr9t6K+Vxc1Sf9wCWLRT6DZTMQ==
X-Received: by 2002:a05:6512:3b06:b0:52f:cd03:a813 with SMTP id 2adb3069b0e04-530bb3a354bmr3429383e87.54.1722632044183;
        Fri, 02 Aug 2024 13:54:04 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3d0d0sm315611e87.277.2024.08.02.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:54:03 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Michael Salman <mjsalman@pathcom.com>
Cc: git@vger.kernel.org
Subject: Re: Merging problem
References: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com>
Date: Fri, 02 Aug 2024 23:53:56 +0300
In-Reply-To: <3db395fe-8d32-4a33-8f16-7df95f3ff194@pathcom.com> (Michael
	Salman's message of "Fri, 2 Aug 2024 14:41:48 -0400")
Message-ID: <87o76alk7v.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Salman <mjsalman@pathcom.com> writes:

> I am new to using git and I encountered the following problem
>
> 1) Created a repository using Notepad added a file (FileA.txt). Put one line of text in the file. Did a git commit -a. so far so good.
>
> 2) I created a branch (my-branch), did a git checkout my-branch
>
> 3) Using notepad loaded FileA and changed the first line of text to something else. Gave command git commit -a no problems
>
> 4) Git checkout master looked at FileA nothing changed
>
> 5) Did a git merge my-branch. No conflict reported
>
> 6) Loaded FileA in master the text of the first line had changed to what is in FileA from the branch
>
> Your help with this problem would be appreciated. I hope this is not
> due to my lack of understanding

You didn't tell us what outcome you expected, but to me all looks fine:
you've merged your changes (made at step 3) from side branch to the
master branch, and now your changes (made at step 3) are there on the
master branch as well: that's the whole purpose of merges.

As there were no any changes on master, there is nothing there for a
potential conflict, so all went pretty smooth, as expected. If you
change first line of the file in notepad (differently from step 3)
between steps 4 and 5 as well, and commit your changes, you will then
get conflict during merge.

-- Sergey Organov
