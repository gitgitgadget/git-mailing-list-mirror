From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git blame breaking on repository with CRLF files
Date: Mon, 10 Aug 2015 11:48:35 -0700
Message-ID: <xmqq1tfbugho.fsf@gitster.dls.corp.google.com>
References: <B0BFE3BB9B3E8C4A890D53FA460552D3737328B0@DEWDFEMB16B.global.corp.sap>
	<55C59A9B.9000808@web.de> <55C7B5EE.7060908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Benkstein\, Frank" <frank.benkstein@sap.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 20:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOs7m-00085m-A0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 20:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbbHJSsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 14:48:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35472 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbHJSsh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 14:48:37 -0400
Received: by pacgr6 with SMTP id gr6so32512571pac.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=3cHrNYR5EU1P8DRr9h0xKFzThC/8Rt/gicBMkBvuzJE=;
        b=BEkH18BKDhMNVkb/XC1N0llmRCfjL9a7CrcUAsk2RkI58s4f5jR/dSHIq6ZKs1Yw5j
         K0b3a/DYEqQ7tGPCiUsUPkAbIMT7LtRpkkxoH5nGOUpxI+1rF1hkcP+IK2TpfCuu1BoI
         UXpO/W6uWYcpdik/AZFQZwQ3YrqwvoJM81ZMbJxObhonngGV6QmnSe6gj/YFmL+XhphJ
         f3nADJw40z0WhtvfQ8dh38F/VLGG65D8MrW+SZFQv0xwxYoMBvrBt4HyuYo24NF/CRXh
         EoW8dK4iN65zR9wTPKMQhbMZcfEqO/rfxWXt9wjxN/ZuVruosR/pouO3zjbYcv6bYYxf
         DAYA==
X-Received: by 10.68.228.36 with SMTP id sf4mr47973283pbc.0.1439232517416;
        Mon, 10 Aug 2015 11:48:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id bc10sm20763062pbd.14.2015.08.10.11.48.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 11:48:36 -0700 (PDT)
In-Reply-To: <55C7B5EE.7060908@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sun, 9 Aug 2015 22:19:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275648>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Actually I could reproduce the following:
> CRLF in repo, CRLF in working tree, core.autocrlf=3D true.

What should happen in such a case?  Wouldn't autocrlf=3Dtrue want to
strip CRLF down to LF?  Shouldn't it?  And if so, "blame" is correct
to say that you are changing the line endings of all your lines, as
what you _would_ commit if you were to commit the tracked files in
your working tree would be different from what is in the index, no?
