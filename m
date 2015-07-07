From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git grep does not support multi-byte characters (like UTF-8)
Date: Tue, 07 Jul 2015 09:07:06 -0700
Message-ID: <xmqqr3ok3qad.fsf@gitster.dls.corp.google.com>
References: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
	<CACsJy8BH_QJss57uMJNE=ojNT5vBWKN=eEdrBBS38g6As-UH6A@mail.gmail.com>
	<775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Plamen Totev <plamen.totev@abv.bg>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVPG-0001cF-Fh
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027AbbGGQHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36060 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788AbbGGQHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:09 -0400
Received: by iecvh10 with SMTP id vh10so137661093iec.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7ewjdDKQhVO04TdF/qpJlO7WnfmR17HAnbmbVJ9Xr0Q=;
        b=qn1+ImRV0G5gd1BOpf10W3vZTlh/eGNGVcDJJ6UcN2vPQgpRzQ5nKfkjoQjEA+f16q
         tU5lyOOVwZ6yupD4AMuu+QPnWM6y4uubrBEEfhZjV0zochWT2CBM04RWexRAH09qXWp9
         KW17T+4r0dgoFNnU2ryBnG5yMzqbLU/+mvBzGVyzgdJCaSgDmdtdX1fij9XiPKemUiiE
         oKD8/PnEG/v1Xeb8l0UVGIifbeQAiU41lNVEytxlG+2pFu3vnQV+7vV3VbmhNVr1LuDU
         WdmUXpoi8HCJZWaUMdiE+Zju1gPI8DABQ124j60S6aY4sNJRDzA7M6VP1+PtJtl3mBUO
         6aeg==
X-Received: by 10.107.25.15 with SMTP id 15mr7752196ioz.11.1436285228587;
        Tue, 07 Jul 2015 09:07:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by mx.google.com with ESMTPSA id j20sm12113115igt.16.2015.07.07.09.07.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:07 -0700 (PDT)
In-Reply-To: <775251698.1328032.1436259534851.JavaMail.apache@nm31.abv.bg>
	(Plamen Totev's message of "Tue, 7 Jul 2015 11:58:54 +0300 (EEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273576>

Plamen Totev <plamen.totev@abv.bg> writes:

> pickaxe search also uses kwsearch so the case insensitive search with
> it does not work (e.g. git log -i -S).  Maybe this is a less of a
> problem here as one is expected to search for exact string (hence
> knows the case)

You reasoned correctly, I think.  Pickaxe, as one of the building
blocks to implement Linus's ultimate change tracking tool [*1*],
should never pay attention to "-i".  It is a step to finding the
commit that touches the exact code block given (i.e. "how do you
drill down?" part of $gmane/217 message).

Thanks.

[Footnote]
*1* http://article.gmane.org/gmane.comp.version-control.git/217
