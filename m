From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Wed, 07 Oct 2015 14:14:08 -0700
Message-ID: <xmqqh9m2tm8v.fsf@gitster.mtv.corp.google.com>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
	<632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
	<20151006135101.GA11304@distanz.ch>
	<ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
	<xmqqfv1mvawu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZmon6xwDE2reSOjM87HfG_dqc6-Rk2KzxnePLAN=BiQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Tobias Klauser <tklauser@distanz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 23:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjw2m-00023T-KT
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 23:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbbJGVOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 17:14:11 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33570 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbJGVOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 17:14:10 -0400
Received: by pacex6 with SMTP id ex6so31921961pac.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6WMbVj3mgug5EMOysy4DArheF2EYxUJAAYjqezOADOk=;
        b=s1oZGLGDybhko6ZnliA5CyulaHxfjTM9KolNo02JsvfzBHeDiY7KeWAgScS/ck8S3i
         kxRiGjmXv6Hb4KGOWfyf5ligCwh3ZJk67vWohV2gh3vomwrUlvJxLoxvddCD7K9/YY2w
         Lj8LohsXeVJBHfnl5rZAafq3I8PLuf34h3Vz3UN66Ms6fIR2EiItuiafcB0mtSNmN065
         qn104GwdyUI9VmkUkL6zwYQREAuW0VbQiLAeW3njf5JBWxS3G3pit4NkvnCMaqPdDktT
         5k/GLw6LxBmgErohWNsq5D8ndkrB4YcpFAPeMS4qg3LU4piKfsVnsRHBVnnG1N9b3ZyH
         WklA==
X-Received: by 10.66.186.141 with SMTP id fk13mr3421769pac.7.1444252449838;
        Wed, 07 Oct 2015 14:14:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id py6sm41162229pbb.62.2015.10.07.14.14.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 14:14:08 -0700 (PDT)
In-Reply-To: <CAGZ79kZmon6xwDE2reSOjM87HfG_dqc6-Rk2KzxnePLAN=BiQw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 7 Oct 2015 13:42:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279198>

Stefan Beller <sbeller@google.com> writes:

> Compare to a patch[1] I sent a while back and the discussion on it.
>
> [1] https://www.mail-archive.com/git@vger.kernel.org/msg70474.html

It is not clear what conclusion you want others to draw from the
comparison, I am afraid.

I am guessing that you are in favor of dropping this patch, because
'int' that signals success or error is the most natural return type
and meanint for this function if its callers ever start using the
value as the indication of an error, just like in the old thread,
the return value from get_remote_heads() had the most useful type
and the meaning for its callers if they wanted to use it.

And if that is what you wanted to say, I fully agree with the
conclusion.

By the way, it is not a very good comparison, though.  The patch in
the old thread deliberately attempted to discard a useful piece of
information.  The information the patch in this thread attempts to
discard is not so useful, as there currently is nobody that returns
an error in the codepath.  So in that sense, the patch in this
thread to change the return value to void is a bit more justifiable
than the one in the old thread, I think.

Thanks.
