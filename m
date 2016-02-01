From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree
 behaviors
Date: Mon, 01 Feb 2016 19:39:38 +0100
Message-ID: <1454351978.13104.6.camel@kaarsemaker.net>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
	 <1453808685-21235-2-git-send-email-pclouds@gmail.com>
	 <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:39:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJO9-0007bU-23
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 19:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbcBASjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2016 13:39:43 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32918 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcBASjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 13:39:42 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so10381500wmr.0
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=JumepVjoOr19mV5vdXsqV8CZZcLzE3ZaCA8X6qkHp7g=;
        b=sI76mt7EzGUl1Goa3js69PI0M1S9ZxdOY4E+CHGmbiWtV0FYx6ZeCpOm8aVT6jtwLC
         6HlJwvBqUD8xPOgZoTuAvO4t46t2zc+M17s63Dw0MUYJ94u29pQ0BrCydaH8I2YfbRNP
         Gct3UAegYPd2Ah6r4xHGdj9GIWH1sWL5kHPY21/xa1cRakyr86mVq98rpgOvKz8M8EQJ
         6t5tH75RwuP1+X9va8GxXoNQWRM9LxFQQolyNKXh4hB5jGv2NVUmxL/hE3gGpk5SdSeE
         i+uDTzOahbmHgs1CqLooPOpGzMtscLV6ozmTsi4okwRnlW3hJUDbo2ioPDAMKqcpCtjo
         tUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=JumepVjoOr19mV5vdXsqV8CZZcLzE3ZaCA8X6qkHp7g=;
        b=mZ8muJl109NIQ0ME4QznJk3BXGNS7hh6C9ihozXuEk9oebJQMQYk39/bnQ/AHOzuxv
         lkVD8ImdgrIHhlPBi/AgekwxieVhuRgrwN7tD4b4BCN8aPKg97aQO86kfjqzOt1MgG1k
         lvahtUiOSMgBn52FQtgSms4EGZ3cTEBuVYT4VsZC8jiQbFGiNZnbCXPVJsaVDs2RjS18
         jHbO+UX/uu/TnlIJbPe/WjT7MdZD2vW4j70tv10suwKonv8o6yGEEStvchS4OrCrSuJn
         mx957i0h48RlbKf64YfyYwcRhPydjrfe7a5AqkFJbsyxGxU8qQrlaFxhETmM+1m9XjiY
         GzSw==
X-Gm-Message-State: AG10YOTP8TxNEHyBXcVFuIe5QVcrr5rshJjROWTWER2iHYHQQHPHCUc+oTUkuoRTBD3Msg==
X-Received: by 10.28.97.135 with SMTP id v129mr13576410wmb.78.1454351980907;
        Mon, 01 Feb 2016 10:39:40 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id kb5sm30531956wjc.22.2016.02.01.10.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 10:39:39 -0800 (PST)
In-Reply-To: <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.3-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285206>

On wo, 2016-01-27 at 14:12 -0800, Junio C Hamano wrote:

> More seriously, are we confident that the overall worktree support
> is mature enough by now that once we add an experimental feature X
> at version 1, we can promise to keep maintaining it forever at
> version N for any positive integer N?=C2=A0 I hate to sound overly
> negative, but I am getting an impression that we are not quite
> there, and it is still not ready for production use.
>=20
> It would be beneficial both for us and our users if we can keep our
> hand untied for at least several more releases to allow us try
> various random experimental features, fully intending to drop any of
> them if the ideas do not pan out.

So far I have two use cases for separate worktrees and am a happy user:

- A CI setup that tries to avoid cloning a repository too often. It
=C2=A0 does N independent tasks in parallel in separate worktrees. This
=C2=A0 checks out the same commit multiple times in multiple worktrees.

- Quickly checking out another branch/commit without first having to
=C2=A0 stash all uncommitted work.

Neither of those require much specialness, so I'm more than happy to
see things change for the better as we find out more of the edge cases.
One thing that may benefit especially the former is a 'git worktree rm'
which removes the worktree (iff there are no local changes) and prunes
it, but nothing in the current implementation or proposed changes will
stop the addition of that.

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
