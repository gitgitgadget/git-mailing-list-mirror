From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Fri, 22 May 2015 07:37:51 -0700
Message-ID: <xmqqsiaofzk0.fsf@gitster.dls.corp.google.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
	<CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
	<CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
	<7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
	<CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
	<20150522071224.GA10734@peff.net>
	<7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
	<CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: steve.norman@thomsonreuters.com, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvo5H-00023U-60
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbbEVOhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:37:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37018 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290AbbEVOhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:37:53 -0400
Received: by igbsb11 with SMTP id sb11so34145866igb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IwBCz9Gdt3g2HAiP4p1Pa2UkdJVuwB3u7X38Hk8UpeQ=;
        b=CchqbmMJAMp+qIob/iiPR3xfYR6yugjFo4mUbqdCRIQpfHJzsM8kG/7NMb0XV29GeE
         0nWll0OBoGGf6pDktJCOBxtxVv4z+tlk+JaZH4+Rrr6QEJC5xQvyaXpBjzMPM4Ir8QhO
         vB6Z5aC2AsM823vCR09OMWbKvWshiEqO3mNGPmOU0ORELPw764yd7tQ41wagiuPGCYbj
         SfsFajf78E4OPk56Tgk6rKz8YnyBZGw4UYKRdUO8WDEd2uqbbfgVL42SkyqDHdATYfK2
         SvYcn8NyJCu5DOvyw9meot/g8DuP+q2pU6T/1jKBTE2t7Wd0XfF5sqs0b4OgPs9+k+ZG
         uLTA==
X-Received: by 10.107.134.153 with SMTP id q25mr10936536ioi.27.1432305473400;
        Fri, 22 May 2015 07:37:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id k37sm1896482iod.39.2015.05.22.07.37.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 07:37:52 -0700 (PDT)
In-Reply-To: <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 22 May 2015 17:05:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269722>

Duy Nguyen <pclouds@gmail.com> writes:

> Strange. Maybe there is something else... Anyway some numbers from me.
> This is nfs3 hosted by Raspberry Pi, accessed over wireless. I just
> run index-pack on git.git pack instead of full clone.

So the checkout codepath to touch working tree is one difference?
Are there other differences?

>
>  - v1.8.4.1 34s
>  - v1.8.4.2 519s (oh.. wireless..)
>  - v1.8.4.2 without has_sha1_file() in index-pack.c 33s
>  - v1.8.4.2 + Jeff's mtime patch 36s
