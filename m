From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] checkout: indicate when a detached head is checked out
 for a branch
Date: Mon, 21 Jul 2014 15:03:28 +0200
Message-ID: <53CD0FA0.1030600@drmicha.warpmail.net>
References: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>	<xmqqr41imuwk.fsf@gitster.dls.corp.google.com>	<1405720477.13250.8.camel@spirit> <xmqqpph2l39d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 15:03:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9DFl-000585-K0
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 15:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbaGUNDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 09:03:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58395 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932388AbaGUNDb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 09:03:31 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 240CE21D91;
	Mon, 21 Jul 2014 09:03:30 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 21 Jul 2014 09:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=luSHWkCX4adA9vdU96wRGr
	Hvlnc=; b=H0JoiQBDMOBWoe0dfDHA5fnFfqeMgyyCHbpihlW8VKFg0crkG3iJwJ
	bmXzBzPG+VZ4NAsQrWVXvyFsqevLbTgfDCvB2nidMks7KqoVyig/0QzGBgWi7+GY
	Af2ELep9HvVl3q5yAbAVwuYcWSkfYvOdcCxiEQ385TZKnYuvp3g2o=
X-Sasl-enc: va6guZmWYydtc9DIq3VzuW20eZLfoG+GO/FS8vbZTohW 1405947809
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6B19A680177;
	Mon, 21 Jul 2014 09:03:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqpph2l39d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253959>

Junio C Hamano venit, vidit, dixit 19.07.2014 00:18:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
>> My use case for this is checking out the same branch (or commit, so
>> already on a detached HEAD) in multiple different places to run
>> independent actions (e.g. make test with different compiler options, or
>> creating several different packages) and I would really appreciate it if
>> that would keep working.
> 
> I do not have any problem if multiple working trees have the same
> commit checked out on their own detached HEADs at all.  The "should
> error out" was solely for the case where the user asked not to detach
> but to obtain a state where a named branch is checked out.  In such
> a case, the command should not turn it into a detached HEAD, with or
> without a warning.

Exactly, all of that, plus:

* "git checkout --detach --to foo bar" could/should be a way to spell out
"git checkout --to foo bar^0".

* In the case of erroring out, "git checkout" could suggest one of the
above two commands.

Michael
