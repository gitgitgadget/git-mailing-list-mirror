From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Sun, 25 Jan 2015 20:57:49 -0800
Message-ID: <CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>
	<CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>
	<xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 05:58:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFbkV-0006Wn-9E
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 05:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbAZE5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 23:57:55 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51366 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbAZE5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 23:57:53 -0500
Received: by mail-ie0-f178.google.com with SMTP id rp18so6793473iec.9
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 20:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=E88T+xrj3quxzzTGokFKX2pVC2nLbP/b4x8iYIOeRmU=;
        b=T9fiPYU7I3L4lZMdAMAZZ7p2pXI9hJYunm30Xl8Q2UqdROz0S7cGfZ9CxD+et6tmF1
         Opd3cHxs0Opum6BrknmLAjAOtPwZibT/vEFA2u2Sz8+0b+aQO32aIbNtjGwTDElZ3OYw
         2kbmxq0B2IMphtp5C/DDxmzXw/xahBLt1kJAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=E88T+xrj3quxzzTGokFKX2pVC2nLbP/b4x8iYIOeRmU=;
        b=fBhj4PDETZGI59utgDxi5Tltth+o90o9KdLOucYc1mHxQxu3yh5EqhDFI+D8fKBQ5h
         9OXf8jt0P2UyY21OkWlnz6Df4lk5IxsBIxYC24pDDAaw1WI8c1igVV4+MVK3xB89n9pZ
         4deQp68KXuFDUFJHr3VcLEnp0nxHijxXcFSDRYW5tWSIrP8dD5U7+NIUxVOTXNb91oR5
         3b/+CbVWn/21oq25/npWgl3dQN6nnbWs4TQUkzSCuXkLTfQCWuMjpN4AMg6Pa3zJXWmg
         jkBbxo7E4zQby8h4CY6LV7bifxAb16VYFEMFJ0lhG6nMpe7LZ9kHKLObiQl2bWCwAcvm
         Wu1Q==
X-Gm-Message-State: ALoCoQm3+eeBSJD27VJfcBxgOTb9LC7Vn28OCYhmGxQDmFtCjQDmPCWPKA7YKShq8xhFZF8xqU3X
X-Received: by 10.50.97.41 with SMTP id dx9mr14272860igb.1.1422248270024; Sun,
 25 Jan 2015 20:57:50 -0800 (PST)
Received: by 10.36.76.76 with HTTP; Sun, 25 Jan 2015 20:57:49 -0800 (PST)
In-Reply-To: <xmqqa916nq4p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263026>

> But then, you are saying that the update does not fix these existing
> issues around submodule support.  So...?

I guess my point is that the existing contrib script has proven to be
useful to people, even though it imposes these constraints on clients
wrt the config file (namely, you can't have multiple workdirs that
need different values in the config file).  This patch, in adding
submodule support, I expect would be similarly useful to people even
though it, also, imposes those same constraints to the submodule's
config files.

I guess you'd rather see these config file issues fixed for all use
cases?  If so, I'm probably not the right person since I do not know
enough about how config files are used in git -- I fear any changes I
made would make some things worse for (some) existing clients of the
script, which is not what I want.  It sounds like this functionality
is being reimplemented in git proper in any case, so perhaps it's best
just to wait for that.  I don't know what its submodule support will
be, though.

craig
