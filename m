From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test for '!' handling in rev-parse's named commits
Date: Wed, 03 Jun 2015 16:12:23 -0700
Message-ID: <xmqq7frkwfmw.fsf@gitster.dls.corp.google.com>
References: <1433364854-30088-1-git-send-email-wmpalmer@gmail.com>
	<1433364854-30088-2-git-send-email-wmpalmer@gmail.com>
	<xmqqbngwwjbd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 01:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Hpp-00049p-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 01:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbFCXM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 19:12:28 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38815 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbFCXM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 19:12:26 -0400
Received: by igblz2 with SMTP id lz2so26831927igb.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ogv7nLnUudiFvnqvwL0Ml3qga9aRaQBLngT9u0p7uWI=;
        b=VgSbf8ClJkk9OJHZ+mEcnHwtdpd+KlFYDnJVVgEeqP2R4TxeVcR8YoX03frXA6b65i
         cD1I7r2YZoOC0nEgrWN48fXiQQvP2gEGg+PEfuD/xjiqu13RW1DW/tlb5sXLDFuqihhc
         bFfzULv2L4JQq7awbebBBN2Gune2zRHhpiATFjIwBIf76uapwT65Yb324Qgm/ECWmRot
         Faf6dUBumg7ig8zIFiX2FIkap3WOAHH8IxD20DsEhRSsXxwN3VCOX3Pt9etj177uW++4
         928tZONHX04j6nlITnSdkow302dwKlxg5yhCr8+JPqYJXBmLWsb43Qio5Jnqg4JeYXYk
         T+UQ==
X-Received: by 10.50.67.146 with SMTP id n18mr1449343igt.40.1433373146200;
        Wed, 03 Jun 2015 16:12:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id k81sm165325iod.31.2015.06.03.16.12.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 16:12:24 -0700 (PDT)
In-Reply-To: <xmqqbngwwjbd.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Jun 2015 14:52:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270748>

Junio C Hamano <gitster@pobox.com> writes:

> The anticipation is to use another feature introducer after "/!" to
> enhance the matching, so that we can keep enhancing the syntax.
>
> cf. http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
>
> Using "/!Message" to match commits that do not match Message
> directly goes against that extensivility design.
>
> We need to always remind ourselves that our latest shiny new toy
> will not be the final new feature.  There always will be need to add
> yet another new thing, and we need to keep the door open for them.
>
> Perhaps
>
> 	/!-string	-> find commit without "string"
>
> or something?

Of course, as I do not think it is something people would do
regularly to look for a non-match, I do not necessarily think we
need a short-hand "/!-string".  Perhaps following the long-hand
syntax suggested in that old article, it may be sensible to start
with something more descriptive like

	/!(negative)string

to look for a commit that does not say "string", without the
short-hand form.  Only after we see that people find the feature
useful and find the need to use it frequently (if it ever happens,
that is), we can introduce "/!-string" as a short-hand form as a
follow-up patch.

Thanks.
