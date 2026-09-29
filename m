Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F612BE655
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715642; cv=none; b=pO9AM1B6f9np4e3srVYfHbG9FB5NazDv613f9Eojxi9AiGvejxMPn9SXEMVUYh2m/91a9sIgamKuoJGvXg4rQHaT3DI+DdggXVl2G3AhNlA5A2WC8hPkIiuCGKNqx+jIWgUcnplQaJdHJZzh5+8LQ3pLk9lENls0j3+qx2rNSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715642; c=relaxed/simple;
	bh=bwmASp/sJEis3Xxmu7IYYBhzT32cillYlrDzD3SVS3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tVHg4N80biH4t4cJT9u48F4+FzCspp5Nm22FGpkMTGh3EWok3RcnrWA/oL8nAw6tDT+5DHs577+l31PBh0cvPRPYUSHz0psG9a9VxuWyhhJa8H3IcUl4uaS27ax2wE0PN5JrsUaHyFY4B3IQALe/k7tAnUfOturT6ybVXCQhagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=LETqtrAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAI2Ql8q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="LETqtrAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAI2Ql8q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C32C9EC03A7;
	Tue, 29 Sep 2026 17:00:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 17:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790715639;
	 x=1790802039; bh=H6bUICxj4MvBc6Z3DwHHINicx5+jRgsoC0Q5ER36wJw=; b=
	LETqtrAa9/crYW/gzlOCOg+FJe9xmjS8t32s8Pj2cuUPpmoaHMURjCfnifKFqX0z
	OaBTuteMCe3hHi0hfoSU+oZSzPLOSZ+aJydCOkv3aHvk0w+i6G2cuDMhv2VnthW7
	YFil9TY1uZh0qDf0Fux7TIa+OdfpVEGOymYkbQfNV6E3x50Fv9TCHCURjPGFMPb+
	h1X64PcuPINalidiw6tnYGv+13SxwZwoJ0wua0Ybgw3JVfoGu6r49lK5pRAK3I37
	jDstwwkje5E3xuzMzfuvIEt9xtnnfZP1FCWPYemJLTa6CwlFau2icaeTpCQXb6Ci
	ZlqJQ3OICkZGsQPWKm2uUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790715639; x=
	1790802039; bh=H6bUICxj4MvBc6Z3DwHHINicx5+jRgsoC0Q5ER36wJw=; b=r
	AI2Ql8q1w6zIiQJWo1Uw9S24vN7caI2Zy25Jv2NG2LabT63EHU+m/MmazLHqBjvZ
	NTCWkl4EVjTVxLCN0JbuJ4Obv4vIM6vOmdpuOa2WT/4bM2tf50Vf+V9acAuTN0NG
	3Qrz0wX5vPpt8oqq+wu5/0WmwXlmwPkhRGk1AJUcd8atHpsyQaAlSqR9wyUvmUxb
	suEKzeLucEMOb7wjzUDGbLlCzfnYIz+Nu/c7V6xXvcjJ/wYY9OQUcYyw53n68Mk6
	eEC2e/3GAg7X0k7rcbVVeJxFwct/8WDoSfwj95bI3fptnzG2ExeguuZQegBXR3fM
	R7heyoJ8IuZON1VIoWMQw==
X-ME-Sender: <xms:9ya8an01Qh--dXFVh-Dx9Qg052jKEDlhB_gkrjUzr2yjCGyQ9s3ENA>
    <xme:9ya8ag7oCVzJiF2sMuilcJfrJU-0HEhdCfmRmedJhASAFlWGDNj-JPEPz0fYrMOKY
    1MBlOC-ONCGN-OAh2Va2Rt8YPXsByAQMowgDzrpwV18Ht9B6TS2_TO6>
X-ME-Proxy-Cause: dmFkZTF6HaCxbDWdkWjC43uPpQ4mZ3uP0xruNaiKbszkG+F93i7vRkZ5Un/qGjSvPXwFI4
    qoTASmORnzy7xGc8/eU2hskaV/ZCSn0toa2bjeAkwQGoZBeCi9qV7j2CbUI8CJHPfec5A7
    jKJ4yks8vwinVxsbquvvt57o1h7DatS+kcdGhZN0j87OoS+Nn6yLh4i7JIeoaNwl8op704
    s4lrdAjDHseygaBbL05uCLUbVry889QAeLX1s5q9T3UlLzJ/mRFd6zavrX3h48wRV23CC7
    nR/yvuUqaHpApesiqNLdAmJ5PvC5YPPMCBcvLohoPLXDsDHQcxHQ2eLnf6/r2uK2mpcjmA
    Fm7zJX453xn68gbk7ciPHCuH3zeMIBTgJMQufSi2g3K0K+SvsYoi/5r+5i9qmMqgn3Ub2m
    AQ0aHcSY/k47PX2fl6Z0+PGBygHMwuhBbYqu3aRzDIHZ3EAG3e/cJJkxglRYtb09NBfOBJ
    JO3zSsbD1Q1LGRLEvPiZMm1HfUCMIGiOon6vNaYNKvIjfrtfH78TWhKBnbR+6vlhyAuO1X
    Jb9FcFZIz1YdRWZNQsP1ONox+LKKmQaoUUUGJNq+OCHCRUs2g8rEBq6yS6J20lRzbiz0UQ
    Lg8onfSJMhOy1TFHK2eGsH3Pt+T40FyusCaZfD0vQI+frK16G0NwWFqHSZ1g
X-ME-Proxy: <xmx:9ya8ahbVNh31Wfca9kQVFgnwrEu5LEqu4e-SW5IsCRHzioAQIVjaPw>
    <xmx:9ya8ap6os71Ge4KT5FfMNnSh8Pn0K8CrQK1nEwYyn-9yZKJREe3VGQ>
    <xmx:9ya8akB8utlI3liLraPuSxhtQ9kW3TRbfXSec9psqmwN-DmGnFnzVA>
    <xmx:9ya8avfABE_8ABgAqr_3zT2z7qHCfwS7isnucaEc9vTKeramYfxnbg>
    <xmx:9ya8alK8YbeJsdOmdHwe4wojfDM55f1vTMlunhWmB6JechYEmwKzCRgY>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7EF34780075; Tue, 29 Sep 2026 17:00:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6s586G7u8KZ
Date: Tue, 29 Sep 2026 17:00:18 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <9a628695-3c82-4cbb-96ba-8bd9c1c7570f@app.fastmail.com>
In-Reply-To: <xmqqfqyrg7j7.fsf@gitster.g>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
 <CCB1855E-759F-4741-BE49-23FC6DD402A6@gmail.com> <xmqqo6dgkead.fsf@gitster.g>
 <064ec9c5-d539-4d21-96a7-6ad0ead5a061@app.fastmail.com>
 <xmqqfqyrg7j7.fsf@gitster.g>
Subject: Re: [PATCH] [doc] Use `man git` to teach users how to navigate the docs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2026, at 3:51 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> Perhaps we could mention `git help` like this:
>>
>>> `git push --help` or `git help push` for the full documentation
>>
>> and then advertise the superior features of `git help` like this
>> (in the last sentence of the DESCRIPTION).
>
> Amusingly
>
> $ git help tutorial
>
> begins with "man git-log" and "git help log".  The first one is so
> old fashioned ;-) 

I still only use `man git-log` actually :)

> Perhaps a more modern version should be given at
> the very first part of the description section of
>
> $ git help git
> 

Will submit a v2 with the wording I suggested above
(since I think that's "a more modern version" of what
`git help tutorial` says)

>>> You can view an HTML version of the Git documentation at
>>> https://git-scm.com/docs, or on your computer with `git help`,
>>> for example `git help push --web`.
>
> Please write it as "git help --web push".

Will do.

> The command line parser may be lenient at times, but we do not
> guarantee it.  Please stick to published "git help cli" style in
> your insturction materials.

I tried to read `git help cli`, got extremely confused, and gave up so I'm
not sure what that style is but I'm always happy to be corrected if there's
a different preferred style :)

I do always test Git commands to make sure they work.
